Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8D488DA0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101284; cv=none; b=kqwlJzAdjjq6aWkGpqbP3/QIzouxdfbMYXuEgP9lDg8u8N0NHZlVuGDIV1SO4EbvzHAPpEnbJmULOtqs9ju9imA77weFeh4PWDWNzivQOGiBrT3LlkpyFqOtlg29bFidF5Pz5+zr+JVTx4ceHCBYzUjpaCTH1E+BgTD3cKqxuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101284; c=relaxed/simple;
	bh=dcWT4PyT3SSMREXFO5uGs6tyexBRi/eP9T1UJf4CWZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9XRA5tWTrMGbCXQ7T5f06ncwKI+I0twuj6F9D7YUG1nJsj3QrxpQGFrplvtMwSUvT92hoK5Rg+cM+Kq78y4ktqlJ88PDKgNIUvUjnqkhC4zrzkiaicAxYlGDQo3kPpHxfhIvHhF5f5l+ef7gfFw3dZCBEDBluaRB+3CM6xoUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0l7dERr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0l7dERr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E1D1F00899;
	Tue, 22 Sep 2026 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101283;
	bh=54WXhi1v3m4jQI6docYD6jcpDAfNARusGZSxSXJjp4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0l7dERr7J4BJsi66lBZLVTyxd6dxQayvrPo9Ja+JnJvVCKPgxIfuv829biwCNq7+
	 eoStawOWXsNn8t+WQUR4wb30cD2dxSwQjpkS23fB2D8YZhMBezMXDimz+OwuEtIrlZ
	 9mzb6YLCCZmb5vlz/a5/mX3AQc+KJTaRSOd4I5IFXGRq4y2fbGtwD6conPIKST+jDc
	 +XbzHf+sDKV9adeIgdfV4K9Yuwngb/EmNdUoCg2YUsNHjz0wSxRrChw23TlhElowkv
	 T7m2qNU//qZQMJZ3sLAmIlXBDhfehPufzKUAN79p2hL0o05I3s/JePB8q6FfCVn3fW
	 JgV4cSAoF2bLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
Date: Tue, 22 Sep 2026 14:21:18 -0400
Message-ID: <20260922182120.3570035-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182120.3570035-1-sashal@kernel.org>
References: <2026092231-good-mahogany-cb59@gregkh>
 <20260922182120.3570035-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 613c83766884503f0f6bfdc45964c84b5286091c ]

Export michael_mic() so that the ath11k and ath12k drivers can call it.
In addition, move it from mac80211 to cfg80211 so that the ipw2x00
drivers, which depend on cfg80211 but not mac80211, can also call it.

Currently these drivers have their own local implementations of
michael_mic() based on crypto_shash, which is redundant and inefficient.
By consolidating all the Michael MIC code into cfg80211, we'll be able
to remove the duplicate Michael MIC code in the crypto/ directory.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Link: https://patch.msgid.link/20260408030651.80336-3-ebiggers@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 06f42accaf3c ("wifi: libipw: reject TKIP frames without a full MIC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h                     |  5 +++++
 net/mac80211/Makefile                         |  1 -
 net/mac80211/michael.h                        | 22 -------------------
 net/mac80211/wpa.c                            |  1 -
 net/wireless/Makefile                         |  2 +-
 .../michael.c => wireless/michael-mic.c}      |  5 ++++-
 6 files changed, 10 insertions(+), 26 deletions(-)
 delete mode 100644 net/mac80211/michael.h
 rename net/{mac80211/michael.c => wireless/michael-mic.c} (96%)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2526ccd8a4a06..2cf3ae4b940a2 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2249,6 +2249,11 @@ enum ieee80211_radio_measurement_actioncode {
 #define PMK_MAX_LEN			64
 #define SAE_PASSWORD_MAX_LEN		128
 
+#define MICHAEL_MIC_LEN			8
+
+void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
+		 const u8 *data, size_t data_len, u8 *mic);
+
 /* Public action codes (IEEE Std 802.11-2016, 9.6.8.1, Table 9-307) */
 enum ieee80211_pub_actioncode {
 	WLAN_PUB_ACTION_20_40_BSS_COEX = 0,
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index a33884967f212..85eaf72ba803c 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -18,7 +18,6 @@ mac80211-y := \
 	iface.o \
 	link.o \
 	rate.o \
-	michael.o \
 	tkip.o \
 	aes_cmac.o \
 	aes_gmac.o \
diff --git a/net/mac80211/michael.h b/net/mac80211/michael.h
deleted file mode 100644
index a7fdb8e84615a..0000000000000
--- a/net/mac80211/michael.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Michael MIC implementation - optimized for TKIP MIC operations
- * Copyright 2002-2003, Instant802 Networks, Inc.
- */
-
-#ifndef MICHAEL_H
-#define MICHAEL_H
-
-#include <linux/types.h>
-#include <linux/ieee80211.h>
-
-#define MICHAEL_MIC_LEN 8
-
-struct michael_mic_ctx {
-	u32 l, r;
-};
-
-void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
-		 const u8 *data, size_t data_len, u8 *mic);
-
-#endif /* MICHAEL_H */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index bb0fa505cdcae..42bbe64617a11 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -18,7 +18,6 @@
 #include <crypto/utils.h>
 
 #include "ieee80211_i.h"
-#include "michael.h"
 #include "tkip.h"
 #include "aes_ccm.h"
 #include "aes_cmac.h"
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 62a83faf0e07d..a77fd5ba63686 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
 
 cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
 cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o trace.o ocb.o
-cfg80211-y += pmsr.o
+cfg80211-y += michael-mic.o pmsr.o
 cfg80211-$(CONFIG_OF) += of.o
 cfg80211-$(CONFIG_CFG80211_DEBUGFS) += debugfs.o
 cfg80211-$(CONFIG_CFG80211_WEXT) += wext-compat.o wext-sme.o
diff --git a/net/mac80211/michael.c b/net/wireless/michael-mic.c
similarity index 96%
rename from net/mac80211/michael.c
rename to net/wireless/michael-mic.c
index 8a1afc93e7499..50cdb67f0503d 100644
--- a/net/mac80211/michael.c
+++ b/net/wireless/michael-mic.c
@@ -8,7 +8,9 @@
 #include <linux/ieee80211.h>
 #include <linux/unaligned.h>
 
-#include "michael.h"
+struct michael_mic_ctx {
+	u32 l, r;
+};
 
 static void michael_block(struct michael_mic_ctx *mctx, u32 val)
 {
@@ -81,3 +83,4 @@ void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
 	put_unaligned_le32(mctx.l, mic);
 	put_unaligned_le32(mctx.r, mic + 4);
 }
+EXPORT_SYMBOL_GPL(michael_mic);
-- 
2.53.0

