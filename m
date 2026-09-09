Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E01EF39E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973206; cv=none; b=YfaUDBdnLGufMKVJTswY+rrbcPTFa9ZeerogtGXXRi3hxYaEC2NJl5w9D4TYd+H6YL4F9ZHuEZ9uIZQraePsERZBN/AXX9qqUIp31KOeyNFxwfgLhuI4IJtV627VyzwFqen3ODT+7fPNzWOCBE0N9gJPfi+8eK/J1d44DODW8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973206; c=relaxed/simple;
	bh=z35wgb84PdsJY2TRUBMGlWL8NVOe2i+C7nFlj86Poxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlqAppSsYtjKDcw+z8v1RmhHnrMtUBgf0UC0djPQDOnozS4eC6ALVZSQCaqb/74NGdzatoDz3qImU32cVWrABmFwWabDm+2mJGOnpLJa5p+V2r5xj7yRYJH8DBHtYx1udh+VTQnaHWGKVXD7VYV2mYrxSRYhrjRcVPXCIYGQN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je0VOoqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je0VOoqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4092E1F0089A;
	Wed,  9 Sep 2026 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973204;
	bh=4YCCBDRM/FVFUfULuIb3haVM1xnVHUePFB6x/+f/w5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=je0VOoqY6OFEBSdwIX5Ugp635FfHlfd2Q/8IgpijvIOEWO5KDU5q4kls0/QQABRPz
	 pJfKVcArZXBNzwMF/0AK7vOQlfBXBlBbDX14MwvFdVV+M83cnvj4MTJZOmvLwt9SYD
	 9TL9X03ICnqzkTfrqYHr6XKtanCSli0w6kmGAcWKcVqYJwc6OST2Xm9RcZx4dKTG+J
	 5p5mLVoHA1ek3mW34vpafu3RcrG2BcUF82QCEwMq4/LErwsMuroJtt/3fcUZ5Hxcx7
	 q3eVxb1UmKjlcwXGcKYgrTVUPvU73wsC4ATarl0bsUnQBi5Hdadw2b8uB4NlCnO51H
	 8u59IPIQtek/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] devm-helpers: Add resource managed version of work init
Date: Wed,  9 Sep 2026 13:00:00 -0400
Message-ID: <20260909170001.3156731-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170001.3156731-1-sashal@kernel.org>
References: <2026090356-iphone-deviate-2dac@gregkh>
 <20260909170001.3156731-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit 7a2c4cc537fa9f05fe90812e7d789b9faf7eb869 ]

A few drivers which need a work-queue must cancel work at driver detach.
Some of those implement remove() solely for this purpose. Help drivers to
avoid unnecessary remove and error-branch implementation by adding managed
verision of work initialization. This will also help drivers to avoid
mixing manual and devm based unwinding when other resources are handled by
devm.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/94ff4175e7f2ff134ed2fa7d6e7641005cc9784b.1623146580.git.matti.vaittinen@fi.rohmeurope.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 6eba34732524 ("power: supply: twl4030_charger: cancel workers via devm")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/devm-helpers.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index f64e0c9f3763c..50557f04ce802 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -50,4 +50,29 @@ static inline int devm_delayed_work_autocancel(struct device *dev,
 	return devm_add_action(dev, devm_delayed_work_drop, w);
 }
 
+static inline void devm_work_drop(void *res)
+{
+	cancel_work_sync(res);
+}
+
+/**
+ * devm_work_autocancel - Resource-managed work allocation
+ * @dev:	Device which lifetime work is bound to
+ * @w:		Work to be added (and automatically cancelled)
+ * @worker:	Worker function
+ *
+ * Initialize work which is automatically cancelled when driver is detached.
+ * A few drivers need to queue work which must be cancelled before driver
+ * is detached to avoid accessing removed resources.
+ * devm_work_autocancel() can be used to omit the explicit
+ * cancelleation when driver is detached.
+ */
+static inline int devm_work_autocancel(struct device *dev,
+				       struct work_struct *w,
+				       work_func_t worker)
+{
+	INIT_WORK(w, worker);
+	return devm_add_action(dev, devm_work_drop, w);
+}
+
 #endif
-- 
2.53.0

