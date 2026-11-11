Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356250;
	b=1D/3H6491DXqopXxZe0XsNxMtO7DpHUJsse06CkzmIaHPaQy4AmwPa3OhL5fKVzU40Rg
	 xqALU+0TJ4dXU2M2D71mvhcs+UE+0RMJO6ZJmy71DxONjWd741l5K7S2pJTlAnKvcdGWz
	 NEqWxelHWqDdXhC9XsswOhTCIgrXgIXK3aXEIyY+2DOBul+thQTkzShGVlSzF99DekUr2
	 Ssnh84M6jL8j4U3mGr5psf+3gEWnryV/ICq+l4yYwJuSCwQO1M4jDCq4PxgPW3aezEbp/
	 bQ5wEesvy0TF9I9nnjSl8+RLQOt6s87QN9xrbjNk8t83S7XWVTimJePQkv8IaFsdxmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356250;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BcEpCWpjWQvTJebdMmSH/79YHmh/exUt6leIB1nVia0=;
	b=eIVTdnQ6iZLLK/0Dci9noLfT25o04R/h9BVT4g78W7x21BFcxcjbsgfQVRvQctU2KcLc
	 uS4D6r8lO14+VdCgn/o/LzLXiylesKhv9uyxe+VAF4I1PR9SiCjbIM5sCkA3el3QpCGJP
	 WymvijMoAa+UCGqBicTRF2AsRB5TUrjtNEfMkU+2wDGPKJSZuwmZUUAY17HQmSxwuyY8p
	 S6PxeLB0gbkCxNi3ifHnjwlCDqkuX/e2/Vxya+MKmgzyecVe8hEW17Yg15a9uCP5Kwg+7
	 G3uJ3o5gk3aAX2p97BWLOhcTUJEifQWYdzDRnjHGrkNZJIScqKJQ5n/bEo6NXFFVL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ds/wWSfU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F2606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ds/wWSfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C011F00A05;
	Wed, 11 Nov 2026 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356249;
	bh=BcEpCWpjWQvTJebdMmSH/79YHmh/exUt6leIB1nVia0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ds/wWSfUiMbb6ghs21IlK10yB5/XhfiEqQsKgg0BA6zg+5G3fFQrrlWlhjaXkq+N7
	 6VNd3NKL3NrkxXp/c1e9UAt5la7JTLczjC2GX1L63f7mBSpbAcPzd+Td1HH146zJ5O
	 4MqWkwiZm8Vp9WfJJ1nP9k7kXDfEtnKbYjzy3O8ly0ms9WMejdmtmUTYta/GYL1VVx
	 NVfaRkgpZSzmMuXe43goZKjQYNty89IEd/bWaqIq54d00eRe5sPjRzzQseduW6YVqk
	 T7QYFnp0OKFSqwKC3EJ1GWzjD7NgMhGIjHHkEXdoVQXd9h+GnBOvwBMdNrhHWHvFkX
	 1YIQAHS+Ke/ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Seo <james@equiv.tech>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] driver core: device.h: add some missing kerneldocs
Date: Tue, 10 Nov 2026 19:17:24 -0500
Message-ID: <20261111001652.217391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055306-failed-6.1-3d9a175707ee@kernel.org>
References: <20261107055306-failed-6.1-3d9a175707ee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Seo <james@equiv.tech>

[ Upstream commit cd00bc2ca42705bf141a2bf6fb5224c7ae628dbe ]

struct device_attribute, struct dev_ext_attribute, dev_name(), and the
DEVICE_ATTR() macros lack kerneldocs, preventing them from appearing in
the driver core documentation and from being cross-referenced elsewhere.

Add the missing kerneldocs (except for DEVICE_ATTR_IGNORE_LOCKDEP(),
which is only meaningful on debug builds with CONFIG_DEBUG_LOCK_ALLOC
defined, and is aliased to DEVICE_ATTR() otherwise).

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: James Seo <james@equiv.tech>
Link: https://lore.kernel.org/r/20230509024702.1977991-1-james@equiv.tech
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3d9a175707ee ("platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device.h | 111 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b35162a3ab8b3..da53172bf3c62 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -102,7 +102,12 @@ struct device_type {
 	bool need_parent_lock;
 };
 
-/* interface for exporting device attributes */
+/**
+ * struct device_attribute - Interface for exporting device attributes.
+ * @attr: sysfs attribute definition.
+ * @show: Show handler.
+ * @store: Store handler.
+ */
 struct device_attribute {
 	struct attribute	attr;
 	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
@@ -111,6 +116,11 @@ struct device_attribute {
 			 const char *buf, size_t count);
 };
 
+/**
+ * struct dev_ext_attribute - Exported device attribute with extra context.
+ * @attr: Exported device attribute.
+ * @var: Pointer to context.
+ */
 struct dev_ext_attribute {
 	struct device_attribute attr;
 	void *var;
@@ -129,30 +139,124 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count);
 
+/**
+ * DEVICE_ATTR - Define a device attribute.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_show: Show handler. Optional, but mandatory if attribute is readable.
+ * @_store: Store handler. Optional, but mandatory if attribute is writable.
+ *
+ * Convenience macro for defining a struct device_attribute.
+ *
+ * For example, ``DEVICE_ATTR(foo, 0644, foo_show, foo_store);`` expands to:
+ *
+ * .. code-block:: c
+ *
+ *	struct device_attribute dev_attr_foo = {
+ *		.attr	= { .name = "foo", .mode = 0644 },
+ *		.show	= foo_show,
+ *		.store	= foo_store,
+ *	};
+ */
 #define DEVICE_ATTR(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
+
+/**
+ * DEVICE_ATTR_PREALLOC - Define a preallocated device attribute.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_show: Show handler. Optional, but mandatory if attribute is readable.
+ * @_store: Store handler. Optional, but mandatory if attribute is writable.
+ *
+ * Like DEVICE_ATTR(), but ``SYSFS_PREALLOC`` is set on @_mode.
+ */
 #define DEVICE_ATTR_PREALLOC(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name = \
 		__ATTR_PREALLOC(_name, _mode, _show, _store)
+
+/**
+ * DEVICE_ATTR_RW - Define a read-write device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR(), but @_mode is 0644, @_show is <_name>_show,
+ * and @_store is <_name>_store.
+ */
 #define DEVICE_ATTR_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
+
+/**
+ * DEVICE_ATTR_ADMIN_RW - Define an admin-only read-write device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR_RW(), but @_mode is 0600.
+ */
 #define DEVICE_ATTR_ADMIN_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
+
+/**
+ * DEVICE_ATTR_RO - Define a readable device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR(), but @_mode is 0444 and @_show is <_name>_show.
+ */
 #define DEVICE_ATTR_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
+
+/**
+ * DEVICE_ATTR_ADMIN_RO - Define an admin-only readable device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR_RO(), but @_mode is 0400.
+ */
 #define DEVICE_ATTR_ADMIN_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
+
+/**
+ * DEVICE_ATTR_WO - Define an admin-only writable device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR(), but @_mode is 0200 and @_store is <_name>_store.
+ */
 #define DEVICE_ATTR_WO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
+
+/**
+ * DEVICE_ULONG_ATTR - Define a device attribute backed by an unsigned long.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of unsigned long.
+ *
+ * Like DEVICE_ATTR(), but @_show and @_store are automatically provided
+ * such that reads and writes to the attribute from userspace affect @_var.
+ */
 #define DEVICE_ULONG_ATTR(_name, _mode, _var) \
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_ulong, device_store_ulong), &(_var) }
+
+/**
+ * DEVICE_INT_ATTR - Define a device attribute backed by an int.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of int.
+ *
+ * Like DEVICE_ULONG_ATTR(), but @_var is an int.
+ */
 #define DEVICE_INT_ATTR(_name, _mode, _var) \
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_int, device_store_int), &(_var) }
+
+/**
+ * DEVICE_BOOL_ATTR - Define a device attribute backed by a bool.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of bool.
+ *
+ * Like DEVICE_ULONG_ATTR(), but @_var is a bool.
+ */
 #define DEVICE_BOOL_ATTR(_name, _mode, _var) \
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_bool, device_store_bool), &(_var) }
+
 #define DEVICE_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
@@ -750,6 +854,11 @@ static inline bool device_iommu_mapped(struct device *dev)
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
+/**
+ * dev_name - Return a device's name.
+ * @dev: Device with name to get.
+ * Return: The kobject name of the device, or its initial name if unavailable.
+ */
 static inline const char *dev_name(const struct device *dev)
 {
 	/* Use the init name until the kobject becomes available */
-- 
2.53.0

