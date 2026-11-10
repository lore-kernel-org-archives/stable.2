Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354960;
	b=BgcfA3ruN2uK01lUOZUkvA5H7P38axUq495l0My4qCmWCqTp5MzkBQFhjdvn3Za8SbHZ
	 cGeT6n6QRskHlLkoCfeiW3D8vpz5iWOLsy3kBfIO/c3PeZ9ZhjMFwMq+MIAaBSc3HqrNx
	 g652t4gMBDBiVHoAeiADUDTcTKR+cjZd/df6QK+GUA1p0lK0fT+jwlFdkoTJyXV+wmSSk
	 Eh7eS/yfs67PN1/3tkzIJ1L86wgdLACRMEbg8geM1c91krqbKsriigZXe92f11Xiq8qlG
	 WYL5ihDlzOcYFe0A0ddVfh5qr311U5mjiG+W86klYFo43KtDvlIdH6MZEdR0pcJakVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h9CW/QEVtvEFJjatrYALhwF5dK7QqTldouLmL1PjEbg=;
	b=1bQm8v1U01wtc10ZB6WuM0P5S5agQLq/MKjDUMXa/e4IUHF/gNzTR8HAsSRbfcTJNtiu
	 AupLSIlhzHdMEjzHhU9dDpsBUVA0lWrkAUqLSEtbAaoKEXJicRYRuoaWLKm4jJu/IKCgW
	 nf+VcpPW64hagxDkKM0B7SmZxEUpVrNYr/zAnpQwDAKQo4KaZ1Z83XUYADUeU3BRodVko
	 2SX+tjYoCAd3TM0BJ5zhzLCGGMnzFwb9E79HXrjJtQTx/5koXkSAVlMgaT0y0J7JFTwHH
	 smeyaLz9VuOaQ+Nn280U6FvM4ZNKVQmMNdcU4dJNpEX2TWzZRKlRIMXvWOnQ8Mtuahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh7Fq+Tv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401A606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh7Fq+Tv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B0A1F0093C;
	Tue, 10 Nov 2026 23:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354960;
	bh=h9CW/QEVtvEFJjatrYALhwF5dK7QqTldouLmL1PjEbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wh7Fq+TvTGyQo5frxOjzfrsl76PqahWEcZqb76aN0Zc7YEprG59mXreRJgo/Oh+hA
	 iAW/uWseQ5+JM0IbIWsPDg2WjM1X61WafGkHbT6gznIeUPal62IHIl2x8vyFyrREva
	 VgvOVo6Qc5NNfaWUKXZ44ZPNvNySIpFxbVoIvWaD/Lzc1JhzMNyBvNP1qdTv6X6kz7
	 Kosk8zr8EfC4A2N8VCz1Oq9NTzjM3j4wYY+PrzQDc+6+ByvNHRISPviqJt1uML628N
	 PRGYrlxF3ecpPvWSsrlykd0dqfDe20ZWcZpBSSdm2ogKNdJHhgdCqny2Vdkidg0ZrX
	 luYDNQ4aCy8Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] driver core: Add device_show_string() helper for sysfs attributes
Date: Tue, 10 Nov 2026 18:55:56 -0500
Message-ID: <20261110235541.191333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053801-failed-6.6-3d9a175707ee@kernel.org>
References: <20261107053801-failed-6.6-3d9a175707ee@kernel.org>
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

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 3cc50d07be10f67aff836f8247a240ec132c6a67 ]

For drivers wishing to expose an unsigned long, int or bool at a static
memory location in sysfs, the driver core provides ready-made helpers
such as device_show_ulong() to be used as ->show() callback.

Some drivers need to expose a string and so far they all provide their
own ->show() implementation.  arch/powerpc/perf/hv-24x7.c went so far
as to create a device_show_string() helper but kept it private.

Make it public for reuse by other drivers.  The pattern seems to be
sufficiently frequent to merit a public helper.

Add a DEVICE_STRING_ATTR_RO() macro in line with the existing
DEVICE_ULONG_ATTR() and similar macros to ease declaration of string
attributes.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/2e3eaaf2600bb55c0415c23ba301e809403a7aa2.1713608122.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3d9a175707ee ("platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/hv-24x7.c | 10 ----------
 drivers/base/core.c         |  9 +++++++++
 include/linux/device.h      | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 3449be7c0d51f..cfb010dc285b7 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -425,16 +425,6 @@ static char *memdup_to_str(char *maybe_str, int max_len, gfp_t gfp)
 	return kasprintf(gfp, "%.*s", max_len, maybe_str);
 }
 
-static ssize_t device_show_string(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *d;
-
-	d = container_of(attr, struct dev_ext_attribute, attr);
-
-	return sprintf(buf, "%s\n", (char *)d->var);
-}
-
 static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3e722d2d5dd3c..69d9115fec0f0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2548,6 +2548,15 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
+ssize_t device_show_string(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *ea = to_ext_attr(attr);
+
+	return sysfs_emit(buf, "%s\n", (char *)ea->var);
+}
+EXPORT_SYMBOL_GPL(device_show_string);
+
 /**
  * device_release - free device structure.
  * @kobj: device's kobject.
diff --git a/include/linux/device.h b/include/linux/device.h
index 15eb24877a518..85f0412ca0668 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -138,6 +138,8 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 			char *buf);
 ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count);
+ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
+			   char *buf);
 
 /**
  * DEVICE_ATTR - Define a device attribute.
@@ -257,6 +259,19 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_bool, device_store_bool), &(_var) }
 
+/**
+ * DEVICE_STRING_ATTR_RO - Define a device attribute backed by a r/o string.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of string.
+ *
+ * Like DEVICE_ULONG_ATTR(), but @_var is a string. Because the length of the
+ * string allocation is unknown, the attribute must be read-only.
+ */
+#define DEVICE_STRING_ATTR_RO(_name, _mode, _var) \
+	struct dev_ext_attribute dev_attr_##_name = \
+		{ __ATTR(_name, (_mode) & ~0222, device_show_string, NULL), (_var) }
+
 #define DEVICE_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
-- 
2.53.0

