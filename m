Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5249E139
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103523; cv=none; b=fxSThUWYYXsT6a0r34I/5Fed6H4B9/dRX2O1lYib6dFLqyCRvk9t7Ef+bf7VaApCowFl099/g3h/bO/eBAfQ9v1bvpjJB7/nidgSzJ7M+aTh6ThlvufieYbiHf/Qeo9R5L/aaSVCUlOa3VR9CUK9EXRSaVv5PVthtoNFxxSPx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103523; c=relaxed/simple;
	bh=02/CUf6Xo52ObYMbOgd8HXg/Qu0Hqww1mJYq81Spijg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7/Z8ArsSUSMWEYZWZmZGfBLHmOjELejCRD99TATxL8thBgFfwzfkWzq4GScZQcr9Owgzd2TGIbE/NpUJ1fd48s2WE/gY3C1f8NG4hcqZKuAHb7PdPM4CkD+0QrurGjfIYhXIaT7lDGLJfmzNLsju66eB9MDTZA3DQwDqAcE9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk20EEtw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk20EEtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A801F00893;
	Tue, 22 Sep 2026 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103519;
	bh=V6rzTFv4waeRCIQB1bcy7PgQ7YeuZ+YaGFJMyumlA40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kk20EEtwx0gfLHLq/D1bEH7BLhj1HkQh41C2EtXYKuNeMbCy7npyD57/TZCL5wPhB
	 G26EgHJAr0XduOysf96RQdPStIx52OcyX2Z0eeD2Z/ZWLStmBMmGS+K+7K/ViSFnOn
	 hVP3akorkbAdn+t2aptIXmN482LQtgINHC4Ejp8w1NRdLAlBMh7iOhkp3jBrPYOdXv
	 NHH6SKhTiYnzsTJjtQPGaZ6CJP5mpCRvmEkhM6IxcB5seZ8U2XRBrpN9syxprY4KUQ
	 s9EaalK5KYCESwfLcWaoFQCgbi3TQ/lrNhlFfIUdD7FzdydwjTK63OeSTb51cU3c3s
	 sCHdBCidQbCaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: libipw: reject TKIP frames without a full MIC
Date: Tue, 22 Sep 2026 14:58:38 -0400
Message-ID: <20260922185838.3889466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092232-riot-proven-31af@gregkh>
References: <2026092232-riot-proven-31af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 06f42accaf3c6aecab1dcc57f68dde6c06c8b380 ]

libipw_michael_mic_verify() assumes that an skb contains an eight-byte
Michael MIC. A short TKIP frame makes the unsigned payload length wrap,
causing michael_mic() to read past the skb.

Check that the MIC is present before verifying it, and use the existing
MICHAEL_MIC_LEN constant for all MIC lengths in the verifier.

Fixes: b453872c35cf ("[NET] ieee80211 subsystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20260909061124.3802517-1-4ncienth@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ adapted libipw changes to the older lib80211 implementation and Michael MIC helper interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/lib80211_crypt_tkip.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index 63e68e5e121e7..8c82b3a787ebc 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -38,6 +38,7 @@ MODULE_DESCRIPTION("lib80211 crypt: TKIP");
 MODULE_LICENSE("GPL");
 
 #define TKIP_HDR_LEN 8
+#define MICHAEL_MIC_LEN 8
 
 struct lib80211_tkip_data {
 #define TKIP_KEY_LEN 32
@@ -585,16 +586,18 @@ static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
 					int hdr_len, void *priv)
 {
 	struct lib80211_tkip_data *tkey = priv;
-	u8 mic[8];
+	u8 mic[MICHAEL_MIC_LEN];
 
-	if (!tkey->key_set)
+	if (!tkey->key_set || skb->len < hdr_len + MICHAEL_MIC_LEN)
 		return -1;
 
 	michael_mic_hdr(skb, tkey->rx_hdr);
 	if (michael_mic(tkey->rx_tfm_michael, &tkey->key[24], tkey->rx_hdr,
-			skb->data + hdr_len, skb->len - 8 - hdr_len, mic))
+			skb->data + hdr_len,
+			skb->len - MICHAEL_MIC_LEN - hdr_len, mic))
 		return -1;
-	if (memcmp(mic, skb->data + skb->len - 8, 8) != 0) {
+	if (memcmp(mic, skb->data + skb->len - MICHAEL_MIC_LEN,
+		   MICHAEL_MIC_LEN) != 0) {
 		struct ieee80211_hdr *hdr;
 		hdr = (struct ieee80211_hdr *)skb->data;
 		printk(KERN_DEBUG "%s: Michael MIC verification failed for "
@@ -612,7 +615,7 @@ static int lib80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	tkey->rx_iv32 = tkey->rx_iv32_new;
 	tkey->rx_iv16 = tkey->rx_iv16_new;
 
-	skb_trim(skb, skb->len - 8);
+	skb_trim(skb, skb->len - MICHAEL_MIC_LEN);
 
 	return 0;
 }
-- 
2.53.0

