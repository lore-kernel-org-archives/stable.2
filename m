Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD990372B3C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611528; cv=none; b=cC4gddBzck7+BP7lKNyroQMWura49Ow8xicVFT6JfiBy3CWFHyuEK8IwrSmdTvTz5LwBqNoFpmRziq1g2vnxK6KLCpYoDtrE5YTHeaCwqZAqPiXR0+G1zqErDEgIWFgY0zSXx9fil0StDMbRUcOMFsjrUWBCQ932qiJWEG50yo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611528; c=relaxed/simple;
	bh=EMzrTYCtG1RI/Tw2ok2LE30J0gyffSrSjCM1WRuFvRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2qWTnfGuwxbp90NB04cC+C2m6Daj9DDK6EAtwB3LHJaRfx0idsPhh5/zzG02MT6k/CKSxGHRpEAuREG3MGySQuyukGCovEW/lhonLdI5FCRH9FVrcwTDpYS8GOxO4liDl4ABzY5u5fEQQHp6R/sRowUgifKO1qcJej0/ypFpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTTsoyCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTTsoyCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292A81F00893;
	Thu, 17 Sep 2026 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611527;
	bh=HcfTyvsIF0FFEJnBM6uBnvXCzzxaby5JWkkwblja47o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTTsoyCMnvd8Sixwj129YUC3amKGTm8Ipr9FMdADdMy8VWEf8LjQ07cWyWGopb0lo
	 E/m3Xsni5sKERIZsNPdyKgI6GDtC5u/sWRy5m0npx9slaJ5Z8SR5zZ8SfuqEF7Afj2
	 Y9wKB8xJLNC5iaNJKdwEBoS7pEr7en8sW2mZzijm4QFl8HSYw8hiHPWinScAaAlX60
	 QtB0TXywluKhoUmsWB6hflESL4BrklnPp85i2BOY9KAiZ4KkXw0cSrOwq967ymHJl/
	 rnZ7tVtJQbSsIEXDt/DE4K6DLQI18mvDZ3soqjq2PT0diZipkF2VDk3NISE6ymklJx
	 oj2q82R7jvk7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] devm-helpers: Add resource managed version of work init
Date: Wed, 16 Sep 2026 22:18:43 -0400
Message-ID: <20260917021844.3809679-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021844.3809679-1-sashal@kernel.org>
References: <2026091651-verdict-tactless-1748@gregkh>
 <20260917021844.3809679-1-sashal@kernel.org>
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
Stable-dep-of: a2471ed17b0e ("hwmon: (gpio-fan) Fix use-after-free in alarm work")
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

