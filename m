Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31848A8C6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101286; cv=none; b=MxyqyVNBqc10VE/WauIfc9PM1TgKNYPyCaF9NPBycNxDRGy8JSMPcKElqBdNDJ8bQw4jZjXtHbnZdRnRBsug9bde2efa2SMZFeSeGhs8gnsa8JqGNOFG2tuEbLgor/3/mxw2IU+ka7gJS8wN3SIlvo/mUmcOuYvv1KSrj6nydeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101286; c=relaxed/simple;
	bh=dHsWjeSvPWuWbosKO7BlM9N8oZtM3Jmln/gE79BPkfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwdIM68LeT73kcro+9UOu4+eMG8Mcl+AYDO1q22ShjnpHub0rXFjdCw/g5IYX+7KT+zYgU9Dv3NA8pm47Ou0WGpE8QDpVDB3II9HHlFjSgRU0tfCkImP1Dlr641la/dqk3Q+V7TWRN29o7S3zf1yCIg6ZCulktpL2TXBf6ZrB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H72huTt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H72huTt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F121F000FF;
	Tue, 22 Sep 2026 18:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101285;
	bh=JyOtM6nwg3DTrErGgRkD0M22j+9RCyqsPt3bO+XpROg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H72huTt2L7B2brAjvVUXt1YxweNiWEljLVviLB+wML249czyD1xD7r/VSZKSw9uPC
	 VstKNpzV4dzUSZrrbpw6VB/KN4jq4RIh64myZPX4GXylQ7YH6kah03XLdvZLVVXc2w
	 6kdXa9te44qD5dPBHVZwfUy+sxXBKvzpuxHjKJzc04tK1k5Mc3pSTuKC2ebwkP33BM
	 RrNnoaboCyFIwCpwVTqemOFVM64vAVyxCZyirAlPhkWz8HSdBdniP0oXY2xJc0jyg2
	 Zj8005U1iNRv0F/GK16XlYSMAXn/ATAcjg15nLA7SnkGPIwKLo/wBBC5e0eLBdmHWs
	 lTFCNWOEX/ckw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] wifi: libipw: reject TKIP frames without a full MIC
Date: Tue, 22 Sep 2026 14:21:20 -0400
Message-ID: <20260922182120.3570035-4-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/ipw2x00/libipw_crypto_tkip.c  | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
index 0106e2c8f8e3c..695d1d85f822b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
@@ -474,14 +474,16 @@ static int libipw_michael_mic_verify(struct sk_buff *skb, int keyidx,
 					int hdr_len, void *priv)
 {
 	struct libipw_tkip_data *tkey = priv;
-	u8 mic[8];
+	u8 mic[MICHAEL_MIC_LEN];
 
-	if (!tkey->key_set)
+	if (!tkey->key_set || skb->len < hdr_len + MICHAEL_MIC_LEN)
 		return -1;
 
 	michael_mic(&tkey->key[24], (struct ieee80211_hdr *)skb->data,
-		    skb->data + hdr_len, skb->len - 8 - hdr_len, mic);
-	if (memcmp(mic, skb->data + skb->len - 8, 8) != 0) {
+		    skb->data + hdr_len,
+		    skb->len - MICHAEL_MIC_LEN - hdr_len, mic);
+	if (memcmp(mic, skb->data + skb->len - MICHAEL_MIC_LEN,
+		   MICHAEL_MIC_LEN) != 0) {
 		struct ieee80211_hdr *hdr;
 		hdr = (struct ieee80211_hdr *)skb->data;
 		printk(KERN_DEBUG "%s: Michael MIC verification failed for "
@@ -499,7 +501,7 @@ static int libipw_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	tkey->rx_iv32 = tkey->rx_iv32_new;
 	tkey->rx_iv16 = tkey->rx_iv16_new;
 
-	skb_trim(skb, skb->len - 8);
+	skb_trim(skb, skb->len - MICHAEL_MIC_LEN);
 
 	return 0;
 }
-- 
2.53.0

