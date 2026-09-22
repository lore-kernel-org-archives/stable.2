Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3039021F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089891; cv=none; b=Fu0WzxHhPpXtF6W4UikyfyFf6UTpo40GadBWwiDH2WWXMnxNHBZhD6yzbZvYKHMhnO26uO+85aZ3o9qk8or303IGDGe5huR/bS/g9KsADCgb2UJH/ynJ5FmBRtT0BQKdjhbBmnPh35NA5crg6hSgmAt4RNnek1/rIABoecKluxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089891; c=relaxed/simple;
	bh=vRHQrYVklYncfH1q5SBCR0b0PdLau1JqhznTF1Zs/hY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jkP+y3L80JPG2Fe3jZSpU5dQHkDPozD5gpbRqkdvXeKVgMOm8PJH8fGmAtO8Es6gvSpS4A1j07MlKBJKGGc5enWsANGQkrgvUZyBNCd2eR26N9y4H4Ipzkr6sDfaOpBscQX83B0dWKtJqgabdvPpE+S755V4Crbmx58SQiNpQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WG+3w+I/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WG+3w+I/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78E1F000FF;
	Tue, 22 Sep 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089890;
	bh=AxF3mogtmKUsISmZHB9lFeD4wWaTRMbJr+fLpMzaIDw=;
	h=Subject:To:Cc:From:Date;
	b=WG+3w+I/zZpvr+9lE7ul6FNUItZpX61pKtRk5YeXZbAzWsCjz77gMuUlBTwaxa5pp
	 UmJjFmWe05F4pDiHO8JrrfU6jD23HUJtQ92omQzOFIYcW1v3UvEBeKQyYYHMbII0pJ
	 MeFx5AbegR1WxS1zGflQH2qquLEq80UQSUNQhYvk=
Subject: FAILED: patch "[PATCH] wifi: libipw: reject TKIP frames without a full MIC" failed to apply to 6.1-stable tree
To: 4ncienth@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:58:33 +0200
Message-ID: <2026092233-hypnotic-moonlike-fb51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 06f42accaf3c6aecab1dcc57f68dde6c06c8b380
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092233-hypnotic-moonlike-fb51@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06f42accaf3c6aecab1dcc57f68dde6c06c8b380 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Wed, 9 Sep 2026 15:11:24 +0900
Subject: [PATCH] wifi: libipw: reject TKIP frames without a full MIC

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

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
index 24bb28ab7a49..2b0cf0ec496a 100644
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

