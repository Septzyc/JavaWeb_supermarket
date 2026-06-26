<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智慧超市 - 在线商城</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/element-plus/dist/index.css">
    <script src="https://cdn.jsdelivr.net/npm/vue@3/dist/vue.global.prod.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/element-plus/dist/index.full.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background: #f5f5f5;
        }

        .header {
            background: linear-gradient(135deg, #1a3a5c, #2d6a9f);
            color: #fff;
            padding: 12px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 22px;
            font-weight: 700;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .search-bar {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            margin-bottom: 24px;
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .search-bar .el-input {
            flex: 1;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .product-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }

        .product-card .image {
            width: 100%;
            height: 180px;
            background: #f0f2f5;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-card .image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-card .info {
            padding: 12px 16px;
        }

        .product-card .info .name {
            font-size: 14px;
            font-weight: 600;
            color: #1a3a5c;
            margin-bottom: 6px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .product-card .info .price {
            font-size: 20px;
            color: #e63946;
            font-weight: 700;
        }

        .product-card .info .stock {
            font-size: 12px;
            color: #444;
            margin-top: 4px;
        }

        .product-card .info .actions {
            margin-top: 10px;
            display: flex;
            gap: 8px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #555;
        }

        .empty-state .el-icon {
            font-size: 60px;
        }

        /* 右下角悬浮购物车按钮 */
        .float-cart-btn {
            position: fixed;
            right: 30px;
            bottom: 30px;
            background: #2d6a9f;
            color: #ffffff;
            padding: 14px 22px;
            border-radius: 999px;
            box-shadow: 0 6px 16px rgba(45, 106, 159, 0.4);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 12px;
            z-index: 999;
        }

        .float-cart-btn:hover {
            background: #1a3a5c;
        }

        .float-cart-btn .cart-text {
            font-size: 16px;
            font-weight: bold;
        }

        .float-cart-btn .total-price {
            font-size: 18px;
            font-weight: 900;
            color: #ffdd57;
        }

        /* 弹窗内文字加深 */
        .checkout-table td {
            color: #222;
        }

        .checkout-summary .row {
            color: #222;
        }

        .detail-price {
            font-size: 28px;
            color: #f56c6c;
            font-weight: 700;
        }

        .detail-stock {
            color: #444;
            margin: 8px 0;
        }

        .detail-desc {
            color: #333;
            line-height: 1.8;
        }

        .detail-actions {
            display: flex;
            gap: 12px;
            margin-top: 16px;
        }

        .detail-actions .el-button {
            flex: 1;
        }

        .checkout-container {
            padding: 10px 0;
        }

        .checkout-table {
            width: 100%;
            border-collapse: collapse;
            margin: 12px 0;
        }

        .checkout-table th {
            background: #f5f7fa;
            padding: 10px 12px;
            text-align: left;
            font-weight: 600;
            color: #222;
            border-bottom: 2px solid #dcdfe6;
        }

        .checkout-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #ebeef5;
        }

        .checkout-table .item-name {
            color: #222;
        }

        .checkout-table .item-price {
            color: #e63946;
            font-weight: 600;
        }

        .checkout-table .item-subtotal {
            color: #e63946;
            font-weight: 700;
        }

        .checkout-summary {
            background: #f5f7fa;
            padding: 16px 20px;
            border-radius: 8px;
            margin: 12px 0 20px 0;
        }

        .checkout-summary .row {
            display: flex;
            justify-content: space-between;
            padding: 4px 0;
            font-size: 15px;
        }

        .checkout-summary .row.total {
            font-size: 20px;
            font-weight: 700;
            color: #e63946;
            border-top: 2px solid #dcdfe6;
            padding-top: 12px;
            margin-top: 8px;
        }

        .payment-methods {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin: 16px 0;
        }

        .payment-methods .payment-btn {
            height: 56px;
            font-size: 16px;
            border-radius: 8px;
            border: 2px solid #dcdfe6;
            background: #fff;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .payment-methods .payment-btn:hover {
            border-color: #2d6a9f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(45, 106, 159, 0.15);
        }

        .payment-methods .payment-btn.active {
            border-color: #2d6a9f;
            background: #ecf5ff;
        }

        .payment-methods .payment-btn .icon {
            font-size: 24px;
        }

        .payment-methods .payment-btn .label {
            font-weight: 600;
        }

        .checkout-actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }

        .checkout-actions .el-button {
            flex: 1;
            height: 48px;
            font-size: 16px;
        }
    </style>
</head>
<body>

<div id="app">
    <!-- 顶部导航 -->
    <div class="header">
        <div class="header-left">
            <span>🏪</span>
            <span>智慧超市</span>
        </div>
        <div class="header-right">
            <el-tag type="success">欢迎，{{ username }}</el-tag>
            <el-button type="danger" size="small" @click="handleLogout">退出</el-button>
        </div>
    </div>

    <div class="container">
        <!-- 搜索栏 -->
        <div class="search-bar">
            <el-input
                    v-model="searchKeyword"
                    placeholder="搜索商品名称或分类..."
                    size="large"
                    clearable
                    @input="handleSearch"
                    @keyup.enter="handleSearch"
            >
                <template #prefix><el-icon><Search /></el-icon></template>
            </el-input>
            <el-button type="primary" size="large" @click="handleSearch">搜索</el-button>
            <el-button size="large" @click="resetSearch">全部</el-button>
        </div>

        <!-- 商品列表 -->
        <div v-if="loading" style="text-align:center;padding:60px;">
            <el-icon class="is-loading" size="40"><Loading /></el-icon>
            <p>加载中...</p>
        </div>

        <div v-else-if="products.length === 0" class="empty-state">
            <el-icon><Box /></el-icon>
            <p style="margin-top:12px;">暂无商品</p>
        </div>

        <div v-else class="product-grid">
            <div v-for="product in products" :key="product.id" class="product-card" @click="showDetail(product)">
                <div class="image">
                    <img :src="product.imageUrl" :alt="product.name" @error="handleImageError">
                </div>
                <div class="info">
                    <div class="name">{{ product.name }}</div>
                    <div class="price">¥{{ product.price.toFixed(2) }}</div>
                    <div class="stock">库存：{{ product.stock }} 件</div>
                    <div class="actions">
                        <el-button type="primary" size="small" @click.stop="addToCart(product)">加入购物车</el-button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 右下角悬浮购物车按钮 -->
    <div class="float-cart-btn" @click="showCart = true">
        <el-icon size="22"><ShoppingCart /></el-icon>
        <span class="cart-text">购物车({{ cartCount }})</span>
        <span class="total-price">¥{{ cartTotal.toFixed(2) }}</span>
    </div>

    <!-- 商品详情弹窗 -->
    <el-dialog v-model="detailVisible" :title="detailProduct.name" width="500px">
        <img :src="detailProduct.imageUrl" class="detail-image" @error="handleImageError">
        <div style="margin-top:12px;">
            <div class="detail-price">¥{{ detailProduct.price?.toFixed(2) }}</div>
            <div class="detail-stock">库存：{{ detailProduct.stock }} 件</div>
            <div class="detail-desc">{{ detailProduct.description || '暂无描述' }}</div>
            <div class="detail-actions">
                <el-input-number v-model="detailQuantity" :min="1" :max="detailProduct.stock" size="large"/>
                <el-button type="primary" size="large" @click="addToCart(detailProduct, detailQuantity)">加入购物车</el-button>
            </div>
        </div>
    </el-dialog>

    <!-- 购物车弹窗 -->
    <el-dialog v-model="showCart" title="🛒 购物车" width="600px" :close-on-click-modal="false">
        <div v-if="cartItems.length === 0" style="text-align:center;padding:30px;color:#555;">
            <div style="font-size:48px;">🛒</div>
            <p>购物车是空的，快去逛逛吧！</p>
        </div>
        <div v-else>
            <el-table :data="cartItems" stripe max-height="300">
                <el-table-column prop="name" label="商品" min-width="140"/>
                <el-table-column prop="price" label="单价" width="90">
                    <template #default="{ row }">¥{{ row.price.toFixed(2) }}</template>
                </el-table-column>
                <el-table-column prop="quantity" label="数量" width="120">
                    <template #default="{ row }">
                        <el-input-number
                                v-model="row.quantity"
                                :min="1"
                                :max="row.stock || 999"
                                size="small"
                                @change="updateCartTotal"
                        />
                    </template>
                </el-table-column>
                <el-table-column label="小计" width="110">
                    <template #default="{ row }">¥{{ (row.price * row.quantity).toFixed(2) }}</template>
                </el-table-column>
                <el-table-column label="操作" width="60">
                    <template #default="{ row }">
                        <el-button type="danger" size="small" @click="removeFromCart(row)">×</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div style="margin-top:16px;padding:12px 16px;background:#f5f7fa;border-radius:8px;">
                <div style="display:flex;justify-content:space-between;align-items:center;font-weight:bold;color:#222;">
                    <span>共 <strong>{{ cartCount }}</strong> 件商品</span>
                    <span style="font-size:20px;font-weight:700;color:#e63946;">
                        合计：¥{{ cartTotal.toFixed(2) }}
                    </span>
                </div>
            </div>

            <div style="margin-top:16px;display:flex;gap:12px;">
                <el-button type="danger" @click="clearCart">清空购物车</el-button>
                <el-button type="success" style="flex:1;" size="large" @click="openCheckout">
                    💰 去结算 ({{ cartCount }}件)
                </el-button>
            </div>
        </div>
    </el-dialog>

    <!-- 结算付款弹窗 -->
    <el-dialog
            v-model="showCheckout"
            title="💰 结算付款"
            width="650px"
            :close-on-click-modal="false"
            @close="closeCheckout"
    >
        <div class="checkout-container">
            <h4 style="margin-bottom:8px;color:#1a3a5c;">📋 商品清单</h4>
            <table class="checkout-table">
                <thead>
                <tr>
                    <th style="width:40%;">商品名称</th>
                    <th style="width:20%;text-align:right;">单价</th>
                    <th style="width:20%;text-align:center;">数量</th>
                    <th style="width:20%;text-align:right;">小计</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="item in cartItems" :key="item.id">
                    <td class="item-name">{{ item.name }}</td>
                    <td class="item-price" style="text-align:right;">¥{{ item.price.toFixed(2) }}</td>
                    <td style="text-align:center;">× {{ item.quantity }}</td>
                    <td class="item-subtotal" style="text-align:right;">¥{{ (item.price * item.quantity).toFixed(2) }}</td>
                </tr>
                </tbody>
            </table>

            <div class="checkout-summary">
                <div class="row">
                    <span>商品金额</span>
                    <span>¥{{ cartTotal.toFixed(2) }}</span>
                </div>
                <div class="row" v-if="discount > 0">
                    <span>优惠减免</span>
                    <span style="color:#67c23a;">-¥{{ discount.toFixed(2) }}</span>
                </div>
                <div class="row total">
                    <span>应付金额</span>
                    <span>¥{{ finalTotal.toFixed(2) }}</span>
                </div>
            </div>

            <h4 style="margin-bottom:8px;color:#1a3a5c;">💳 选择支付方式</h4>
            <div class="payment-methods">
                <div
                        class="payment-btn"
                        :class="{ active: selectedPayment === '现金' }"
                        @click="selectedPayment = '现金'"
                >
                    <span class="icon">💵</span>
                    <span class="label">现金</span>
                </div>
                <div
                        class="payment-btn"
                        :class="{ active: selectedPayment === '微信支付' }"
                        @click="selectedPayment = '微信支付'"
                >
                    <span class="icon">💬</span>
                    <span class="label">微信支付</span>
                </div>
                <div
                        class="payment-btn"
                        :class="{ active: selectedPayment === '支付宝' }"
                        @click="selectedPayment = '支付宝'"
                >
                    <span class="icon">📱</span>
                    <span class="label">支付宝</span>
                </div>
                <div
                        class="payment-btn"
                        :class="{ active: selectedPayment === '会员卡' }"
                        @click="selectedPayment = '会员卡'"
                >
                    <span class="icon">💳</span>
                    <span class="label">会员卡</span>
                </div>
            </div>
            <div style="text-align:center;font-size:13px;color:#777;margin-top:-8px;">
                👆 请选择一种支付方式
            </div>

            <div class="checkout-actions">
                <el-button @click="closeCheckout" size="large">返回修改</el-button>
                <el-button
                        type="primary"
                        size="large"
                        style="flex:2;"
                        :disabled="!selectedPayment || paying"
                        @click="confirmPayment"
                >
                    <span v-if="paying">⏳ 支付中...</span>
                    <span v-else>✅ 确认支付 ¥{{ finalTotal.toFixed(2) }}</span>
                </el-button>
            </div>
            <div v-if="!selectedPayment" style="text-align:center;color:#f56c6c;font-size:13px;margin-top:8px;">
                ⚠️ 请选择支付方式
            </div>
        </div>
    </el-dialog>
</div>

<script>
const { createApp, ref, computed, onMounted } = Vue

const app = createApp({
    setup() {
        const isLoggedIn = localStorage.getItem('isLoggedIn')
        if (!isLoggedIn) {
            const contextPath = window.location.pathname.split('/')[1] || 'supermarket_web'
            window.location.href = '/' + contextPath + '/'
        }
        const username = ref(localStorage.getItem('username') || '用户')

        const products = ref([])
        const loading = ref(false)
        const searchKeyword = ref('')

        const detailVisible = ref(false)
        const detailProduct = ref({})
        const detailQuantity = ref(1)

        const cartItems = ref([])
        const showCart = ref(false)

        const showCheckout = ref(false)
        const selectedPayment = ref('')
        const paying = ref(false)
        const discount = ref(0)

        const cartCount = computed(() => {
            return cartItems.value.reduce((sum, item) => sum + item.quantity, 0)
        })
        const cartTotal = computed(() => {
            return cartItems.value.reduce((sum, item) => sum + item.price * item.quantity, 0)
        })
        const finalTotal = computed(() => {
            return Math.max(0, cartTotal.value - discount.value)
        })

        const loadProducts = () => {
            loading.value = true
            const contextPath = window.location.pathname.split('/')[1] || 'supermarket_web'
            const url = '/' + contextPath + '/products' +
                (searchKeyword.value ? '?keyword=' + encodeURIComponent(searchKeyword.value) : '')

            fetch(url)
                .then(res => res.json())
                .then(data => {
                    products.value = data
                    loading.value = false
                })
                .catch(error => {
                    console.error('加载商品失败:', error)
                    ElementPlus.ElMessage.error('加载商品失败')
                    loading.value = false
                })
        }

        const handleSearch = () => {
            loadProducts()
        }

        const resetSearch = () => {
            searchKeyword.value = ''
            loadProducts()
        }

        const showDetail = (product) => {
            detailProduct.value = product
            detailQuantity.value = 1
            detailVisible.value = true
        }

        const addToCart = (product, quantity = 1) => {
            if (product.stock <= 0) {
                ElementPlus.ElMessage.warning('商品已售罄')
                return
            }

            const existing = cartItems.value.find(item => item.id === product.id)
            if (existing) {
                if (existing.quantity + quantity > product.stock) {
                    ElementPlus.ElMessage.warning('库存不足')
                    return
                }
                existing.quantity += quantity
            } else {
                cartItems.value.push({ ...product, quantity })
            }

            ElementPlus.ElMessage.success(`已添加 ${product.name}`)
            detailVisible.value = false
        }

        const removeFromCart = (item) => {
            const index = cartItems.value.indexOf(item)
            if (index > -1) {
                cartItems.value.splice(index, 1)
                ElementPlus.ElMessage.info('已移除')
            }
        }

        const clearCart = () => {
            ElementPlus.ElMessageBox.confirm('确认清空购物车？', '提示')
                .then(() => {
                    cartItems.value = []
                    ElementPlus.ElMessage.success('已清空')
                })
                .catch(() => {
                })
        }

        const updateCartTotal = () => {
        }

        const openCheckout = () => {
            if (cartItems.value.length === 0) {
                ElementPlus.ElMessage.warning('购物车为空')
                return
            }
            for (const item of cartItems.value) {
                if (item.quantity > item.stock) {
                    ElementPlus.ElMessage.error(`${item.name} 库存不足，当前库存：${item.stock}`)
                    return
                }
            }
            selectedPayment.value = ''
            discount.value = 0
            showCheckout.value = true
        }

        const closeCheckout = () => {
            showCheckout.value = false
            selectedPayment.value = ''
            paying.value = false
        }

        // 修复：成功提示带上总价
        const confirmPayment = () => {
            if (!selectedPayment.value) {
                ElementPlus.ElMessage.warning('请选择支付方式')
                return
            }

            paying.value = true

            setTimeout(() => {
                paying.value = false
                ElementPlus.ElMessage.success(`🎉 支付成功！支付方式：${selectedPayment.value}，应付金额：¥${finalTotal.value.toFixed(2)}`)

                console.log('========== 订单信息 ==========')
                console.log('支付方式:', selectedPayment.value)
                console.log('商品清单:', cartItems.value)
                console.log('合计金额:', finalTotal.value.toFixed(2))
                console.log('===============================')

                cartItems.value = []
                showCheckout.value = false
                selectedPayment.value = ''

                loadProducts()
            }, 1500)
        }

        const handleLogout = () => {
            ElementPlus.ElMessageBox.confirm('确认退出？', '提示')
                .then(() => {
                    localStorage.removeItem('isLoggedIn')
                    localStorage.removeItem('username')
                    const contextPath = window.location.pathname.split('/')[1] || 'supermarket_web'
                    window.location.href = '/' + contextPath + '/'
                })
                .catch(() => {
                })
        }

        const handleImageError = (e) => {
            e.target.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="200" height="200"%3E%3Crect fill="%23f0f2f5" width="200" height="200"/%3E%3Ctext x="50%25" y="50%25" text-anchor="middle" dy=".3em" fill="%23909399" font-size="40"%3E📦%3C/text%3E%3C/svg%3E'
        }

        onMounted(() => {
            loadProducts()
        })

        return {
            username,
            products,
            loading,
            searchKeyword,
            detailVisible,
            detailProduct,
            detailQuantity,
            cartItems,
            showCart,
            showCheckout,
            selectedPayment,
            paying,
            discount,
            cartCount,
            cartTotal,
            finalTotal,
            loadProducts,
            handleSearch,
            resetSearch,
            showDetail,
            addToCart,
            removeFromCart,
            clearCart,
            updateCartTotal,
            openCheckout,
            closeCheckout,
            confirmPayment,
            handleLogout,
            handleImageError
        }
    }
})

app.use(ElementPlus)
app.mount('#app')
</script>

</body>
</html>