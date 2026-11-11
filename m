Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356250;
	b=MCe1UajcSmG3bozd2GVrNCO/UvW6+oJcx+E5cVckDEohsYaL50//rQ9mCui7TGP/+NGI
	 6ws6iw0O6637CHJoRLbz0mdtU3T3Lsx42MqdQwRHDbcu5mRNJJkQ29XXzQGTQELWNQNz7
	 lpV4OnwmxhBZqlUhNKqCj7J1UZMu6La6YrG7mgvn16FT4Iyx1vq7iE8XytYNDv4yvM7bD
	 qWG1RoeQESOCdLAHkghd6zYak72rjvHOkJtpYg86GxTN59NRHl9J5OHL0CEf9UXh42WGT
	 vHqm7dhBcG3Ye/O2kPHlxAwhdcNTHMWRBsJKcmtpowUTlsN2+nXLeehfKn5WtQueUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356250;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qvKp/SWRpa3t6q7FKfrQFlJzExhJI154nNVRcxceyJI=;
	b=gbiU0fXb8LLN5rNFry5J83W0hlPUO1aE2Fg3kPLKAfxKzDu9yHI9Z4/0xX7kUsHs361R
	 qkmOhl7SDk9vMGdK6j8wpc3oClZfuvY5eRB3gMbF3zSXULy77qY/HtDg8zJzmCTb7/8nM
	 kpdfVGjadqWBV5vETp+VHIAoMwIkzSy1iFFuw7j7+oiiAW6KSPkTIyVIF+HFYDKLkI446
	 mWotM/FOiOcP0wrbIsGAEbg2adboJ2I6zl95Jccn17x6iqavZbVLbfnKx1RoQrPHb/rdK
	 KuDyxB3MQ4lt0om8XFXcJl8u/kztlE9hk7mEHVwKvB/CJt9kvlZMx8VbXgG/pWf2Aaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+E2Vl6C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D2606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+E2Vl6C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094001F0093C;
	Wed, 11 Nov 2026 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356250;
	bh=qvKp/SWRpa3t6q7FKfrQFlJzExhJI154nNVRcxceyJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+E2Vl6CzmIka3AfsSgvdMpE4Ad8Pz132+5/D+/zfrDqbP41cQG4iAtpRPV7WcNxH
	 01oTDl8c/WJ+Q6Jr6ZOLr0SkW8OCIXi9/LDpkkXhaNCo4amBdpNBeKz1ynq2bLQewn
	 ZjZcghrHJot8M5dbIr2FyyLABEnUWHbH1gQrq5lz5u9O1rwyhChB+8lLzvIyshLTPh
	 9gCUxNx4t+yVgY9gEHSrs4zSdBpVLOATxb2PfYf4QYbS41+Ua1RJTrt2E07LA93AWN
	 C5mlp0wzBDjZPZFEXSYLC1bp1/8FECS9CQQ/CziKz7J9EgoU6zYQ9YBIxrcDwr+3uR
	 +dIXcLcqEflcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] driver core: Add device_show_string() helper for sysfs attributes
Date: Tue, 10 Nov 2026 19:17:25 -0500
Message-ID: <20261111001652.217391-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111001652.217391-1-sashal@kernel.org>
References: <20261107055306-failed-6.1-3d9a175707ee@kernel.org>
 <20261111001652.217391-1-sashal@kernel.org>
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
index 7dda59923ed6a..d33c4c9a145dc 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -438,16 +438,6 @@ static char *memdup_to_str(char *maybe_str, int max_len, gfp_t gfp)
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
index 84019bebd901b..32cb9ab16695a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2474,6 +2474,15 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
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
index da53172bf3c62..70fbcc437360b 100644
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

