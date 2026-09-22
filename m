Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FA475357
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101284; cv=none; b=J2kk2ZeceuDAbGg2NO4Qji+G64WyTwM6ZRwKK07VIsiOvmaXDrlXDBH3S2p4s2I8pBYxT5J5ytwluAiu2jn1Kipo2ZmQib3JQyIoRnQbhN461DswvLNIjY2chFEaRcwg1Lt/AruL+Zqc6gi+xcjCe7y6pC60Ks2AaUNRyxzvkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101284; c=relaxed/simple;
	bh=cnco4Qk+LIRfwYU79QZd4fT60rPbGeyGVk88V5STTYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN0kcYPANFLTOl98LQq2F7WKoAZRSOO/RTuKNC5x0GKlp3dcBRwdf4LtowsSQnC4RIp77+0l7PgLld+W6ESchK1Vv1R+kpPajF/CscC2C9GDk/2ZWwuppD5f3S4wZjh4kIdBro0Q1egJUv0dOWgVYKA8YPeEhhdsxixJ1uX7HwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j49irmj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j49irmj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EA91F000FF;
	Tue, 22 Sep 2026 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101282;
	bh=bsIxyO7MC2faxqV0XPETA0SQl9CVAqiIpkhscXAhvCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j49irmj11DUHnTSFsfo/o/OBDPOJ3D7B2cSh3TQt/iPDDRQCohpCi+CzSnPiXbVWY
	 IkXJzNvprOLwAOEmf2LQSkfiacr0xzXLVm2ds8XJ674Ly1IK0mDSZkIezXX3q3GQAu
	 L+1PmYHIt65GhYNIQSey9O0iwnsQauY2XJdlGOylfbvy4qDnvNi1l65yann+0Hz3K2
	 n8uRHVoSgpyz008+ay4sE3LGGcSow2FJuMTM2ZLCgmcSNZFZWyxhFErfcX8gbkID0q
	 +pwOzfyNbwuK6EMQhsIg0Ld7IKw1Jw03Ya4GuQO/I5k/rf6kKK5LhKO7ut7G9Yg8KB
	 EDbKsPmpfWwNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] wifi: ipw2x00: Rename michael_mic() to libipw_michael_mic()
Date: Tue, 22 Sep 2026 14:21:17 -0400
Message-ID: <20260922182120.3570035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092231-good-mahogany-cb59@gregkh>
References: <2026092231-good-mahogany-cb59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit ea06baf59bd4b83c2cb13698411909e5e6be001e ]

Rename the driver-local michael_mic() function to libipw_michael_mic()
to prevent a name conflict with the common michael_mic() function.

Note that this code will be superseded later when libipw starts using
the common michael_mic().  This commit just prevents a bisection hazard.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Link: https://patch.msgid.link/20260408030651.80336-2-ebiggers@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 06f42accaf3c ("wifi: libipw: reject TKIP frames without a full MIC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
index 32288697da4f5..c91218d457e0f 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c
@@ -464,7 +464,7 @@ static int libipw_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
+static int libipw_michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
 		       u8 *data, size_t data_len, u8 *mic)
 {
 	SHASH_DESC_ON_STACK(desc, tfm_michael);
@@ -546,7 +546,7 @@ static int libipw_michael_mic_add(struct sk_buff *skb, int hdr_len,
 
 	michael_mic_hdr(skb, tkey->tx_hdr);
 	pos = skb_put(skb, 8);
-	if (michael_mic(tkey->tx_tfm_michael, &tkey->key[16], tkey->tx_hdr,
+	if (libipw_michael_mic(tkey->tx_tfm_michael, &tkey->key[16], tkey->tx_hdr,
 			skb->data + hdr_len, skb->len - 8 - hdr_len, pos))
 		return -1;
 
@@ -584,7 +584,7 @@ static int libipw_michael_mic_verify(struct sk_buff *skb, int keyidx,
 		return -1;
 
 	michael_mic_hdr(skb, tkey->rx_hdr);
-	if (michael_mic(tkey->rx_tfm_michael, &tkey->key[24], tkey->rx_hdr,
+	if (libipw_michael_mic(tkey->rx_tfm_michael, &tkey->key[24], tkey->rx_hdr,
 			skb->data + hdr_len, skb->len - 8 - hdr_len, mic))
 		return -1;
 	if (memcmp(mic, skb->data + skb->len - 8, 8) != 0) {
-- 
2.53.0

