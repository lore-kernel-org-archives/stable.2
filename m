Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840865;
	b=ydEE0W1ndaW4yn24czo4vtAuM2VxgzEtWArK3cl+lREv+CNeQAoheUcyrSfG1MN6zqbd
	 cQlSPF1Rh9+rime6UoiUUGVlynOi8S8S7VpVKlzlKtdU0q+rkSufpvRft0QjO32qQweKH
	 GKF3jjBHaSqTczx3uEsD3x7154SEdLtJilhFDsF4E+3gEObBKshPWGMcate8LukJV2F10
	 oKrZW2vNwR6R12o2PI7AyjWY+YIL+6lclZ06Dish5dt8SvbATGrCsqhfuF+n46DC+YzSp
	 fs4r17cq3HGViXzkFMpgGPJ7D7cOgM9jREYD+4lD8p7JFCeHM3nJrA9XLpLEmRgHGhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6t9fJk8rDsnFKfYoqA35qg4bwmIPA6klJozyTgQquS0=;
	b=4inddFDhYjRDrSMKhFszHS2Bwn+6+YhmEcF0Bbx6SShSGIiAKYUyeA+YlcFe/pCYlECP
	 /yjx/3K2/vEgQCCXCnHULiYQthy9CsssbFjvC2PqTA0WPbVKsJbiZ3eMVVY+qirmGClK6
	 dwZRxnzF/UD1m1b4SrVx1zBwawhHVKdWJYznepPjkiiPGiKGipDT3f2OrbYi3fj+jPvdm
	 vsAWH9Bfrq8kaMWUNrPwDbOxMbK2P53U7XbRCUvsFUIaGVyHgOD0vnq9SHqx3x3MaN9PN
	 Ybt5GqJndRdZ0wMnPWeGT73gWS2/DEuamXJsFPhgp71nrF8yGStWyy0PHYWAEwJcyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyB1+Za6;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F3606A324
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77F3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyB1+Za6
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso4234444a91.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840864; x=1796445664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6t9fJk8rDsnFKfYoqA35qg4bwmIPA6klJozyTgQquS0=;
        b=DyB1+Za6LDlVE8b9T+YIkdtwMuuoR+2/gonBfCrPhKe+rQ6VTrobq1bRH0jmMnzqcx
         Rs/Ec4lwolFnCNRTHu3Jy5aXrtp5cY6lnlBZ+VRc0DMty815qTirlQ+8cqt5P1trKZxB
         WdhDaNwiy6uWcw4RAoYLgePn6U4kijKXEDazBDYhuBkGbpGfEyTba/0w1JatCHT2/APw
         UhLYhmHj6f2ayIIs9/9f/sbNdd2VJgl0dC5WGrZBa9HvH5Cq+RKraZxEh7uz20IRfx85
         g9n/csAs91cWbJEdZfMVZ6Of71zssVlCu1xVftsgMqkUIA71+aTQTAU0yHilzQa/bVBg
         xRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840864; x=1796445664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6t9fJk8rDsnFKfYoqA35qg4bwmIPA6klJozyTgQquS0=;
        b=rantGl2mMPlChpKd/Qu3s0LTbwE0bPysaObklifpcOxd9zFM79QT0DPFQhEarJwFrD
         CGfR5lo41sFV4JVfB2OE4w0i9SucUTvvPsRt4dI6UfvgNe0LS+MRlWUSMj520J89Zh3a
         +fHNwZ+JXumiZCOLQbN2XlJqsEX6stzEm+MOVLVYjOh1hiTVMyRL4P/eIjKvNFuI9F86
         9/HmhaRS+l50Ji3hTpTh1uHcD+DtIe4CYlZqnlfXY9fu43EI5fGKXy6Pf5sfOwV2TPqK
         iphHRwlr5wypg8f3dTkFDWitTD3PHHdb70WWADBIL6whsY4WTy3a0F/wmx//nTBTwLzI
         v3pw==
X-Forwarded-Encrypted: i=1; AL+hErH6TDqws+7LgRpRwdD0Wpfda8MVsBuLvBw9yTu+y5ubcZFAsDM7HPDwdhwlufCN6Be6QB8Poa0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vLR2fmD2xdTpaFh02MoH7mTIRKygNyOnvqobYyPGpqSd7NXdb
	0fLUr1VkULaPYHT2GlJ5rr7Wkg0ZBaLFsxakNNCr5avG8nbRsyGQ3epJ
X-Gm-Gg: AZFdTZedZqWnRc/BkZH/2KIQQqKxqEEDARxy4BO7H0aZ6gxZMBMFDoaIZz9Zuyu9CA8
	90ujSrVBi5x/qd1kFtMQUdQAJjRF8MGCmzl9LmPetg7CaZ4XVoVdlsaNDzxl9Baxt+ZcCZI2S+L
	HghcePMPSUw4e3g6RT+300vbBi07Pu4EUspp7h1S+7CX15896y6PeDXmDgZv4WBHnbykiAMPeFB
	DsREYmBrNlO+JLdTeldzpi0/SXuPLYUK+KDDSvVgQQcg35qBamnbAMoF5ar5CeMkI8g8PW7Z4sW
	G3jWcr/BnzarM1+uZnBNP8kKK621kChHzoQltwoJ7Kvr/QccvdiLV24FN3efUQOeANudUGF49+3
	ekm0uPXWRj7PMsEQykM1XGjvCqbgoBs11nNUwzVCLd+mxDtP1hy3ZT+LYfQ3+EvV+8JMbaxZGxp
	UUG5So565yd8mGtGPrwWtzMGqwxQJa5Hv4/+etVwL45k+bi5y72eStwf7jkPt3KqmTroDWi/sqK
	3/I0MjnnuvyvxOgwsap6GEw3iB2M5IFfwKLzxPQ+ANIO7zy03sBDWM4CetT4cRa6a8TSd+397IM
	Ypp06xOCj4yqyCaVO4sMXr9lbtIj0N2WI7ds3defENkMNoVVFb8VCU11FyhAeu1Dxv8zM63KDJJ
	60B1Jp0RzZjsvTnc3ER+SjvmnKYxaRUkpVvgOh0M4D9NeS+gs6UvWXRIkmylb/nYw7rAE2fnGlf
	q4jHmjDs4gzjujTa+8m9VUU/c=
X-Received: by 2002:a17:90b:5287:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3b41c7c22c0mr26750567a91.6.1795840864188;
        Fri, 27 Nov 2026 20:41:04 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:41:03 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rosen Penev <rosenp@gmail.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Romain Perier <romain.perier@free-electrons.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/8] crypto: cesa - finish long hashes on the non-TDMA path
Date: Fri, 27 Nov 2026 20:40:50 -0800
Message-ID: <20261128044050.722617-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128044050.722617-1-rosenp@gmail.com>
References: <20261128044050.722617-1-rosenp@gmail.com>
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

On engines without TDMA (Orion), the last request of a hash is finished
in mv_cesa_ahash_std_step() either by the engine, when the total length
fits the descriptor field (0xffff), or with padding built by the driver.
Three things go wrong there:

 - The hand-made padding is only added inside the branch for the
   last/unfragmented operations, which is only taken when the total
   length fits the descriptor field. Hashes of 64 KiB or more are
   therefore never padded.

 - When the padding does not fit behind the data, the code keeps
   len % 64 bytes as the amount to hash and carries 64 - padding length
   bytes into the cache, rather than hashing the whole blocks and
   carrying the partial one over to a step that adds the padding.

 - mv_cesa_ahash_std_process() completes the last request as soon as
   its source data is used up, so a carried-over block and its padding
   would never be hashed anyway.

Enter the finishing code whenever the data of the last request is used
up, convert only last/unfragmented operations to middle/first ones when
padding by hand, carry the partial block over properly, and complete the
last request only once its final operation has been started.

Tested on an Armada 385 (WRT3200ACM) with TDMA disabled in a test build,
against the software implementations, with this and the two previous
patches: before them, single threaded with lengths up to 140000 bytes,
63% of MD5/SHA1/SHA256 digests were wrong and a 4 thread run hung; after
them, none of about 240000 hashes of up to 8192 or 140000 bytes, nor of
26000 operations of mixed cipher and hash load over 4 threads.

Fixes: f63601fd616a ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/cesa.h |  3 +++
 drivers/crypto/marvell/cesa/hash.c | 38 ++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index 906d55fb6a3a..490d7b46cbfc 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -585,9 +585,12 @@ struct mv_cesa_skcipher_req {
 /**
  * struct mv_cesa_ahash_std_req - standard hash request
  * @offset:	current operation offset
+ * @final_issued: the last operation of the last request (finalised by the
+ *		engine, or followed by the hand-made padding) has been started
  */
 struct mv_cesa_ahash_std_req {
 	unsigned int offset;
+	bool final_issued;
 };
 
 /**
diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index b51315cd01df..5e867e688ffa 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -174,6 +174,7 @@ static void mv_cesa_ahash_std_step(struct ahash_request *req)
 	struct mv_cesa_engine *engine = creq->base.engine;
 	struct mv_cesa_op_ctx *op;
 	unsigned int new_cache_ptr = 0;
+	bool final;
 	u32 frag_mode;
 	size_t  len;
 	unsigned int digsize;
@@ -221,16 +222,17 @@ static void mv_cesa_ahash_std_step(struct ahash_request *req)
 
 	frag_mode = mv_cesa_get_op_cfg(op) & CESA_SA_DESC_CFG_FRAG_MSK;
 
-	if (creq->last_req && sreq->offset == req->nbytes &&
-	    creq->len <= CESA_SA_DESC_MAC_SRC_TOTAL_LEN_MAX) {
+	/* All data of the last request is in SRAM: finish the hash. */
+	final = creq->last_req && sreq->offset == req->nbytes;
+
+	if (final && creq->len <= CESA_SA_DESC_MAC_SRC_TOTAL_LEN_MAX) {
 		if (frag_mode == CESA_SA_DESC_CFG_FIRST_FRAG)
 			frag_mode = CESA_SA_DESC_CFG_NOT_FRAG;
 		else if (frag_mode == CESA_SA_DESC_CFG_MID_FRAG)
 			frag_mode = CESA_SA_DESC_CFG_LAST_FRAG;
 	}
 
-	if (frag_mode == CESA_SA_DESC_CFG_NOT_FRAG ||
-	    frag_mode == CESA_SA_DESC_CFG_LAST_FRAG) {
+	if (final) {
 		if (len &&
 		    creq->len <= CESA_SA_DESC_MAC_SRC_TOTAL_LEN_MAX) {
 			mv_cesa_set_mac_op_total_len(op, creq->len);
@@ -238,8 +240,13 @@ static void mv_cesa_ahash_std_step(struct ahash_request *req)
 			int trailerlen = mv_cesa_ahash_pad_len(creq) + 8;
 
 			if (len + trailerlen > CESA_SA_SRAM_PAYLOAD_SIZE) {
-				len &= CESA_HASH_BLOCK_SIZE_MSK;
-				new_cache_ptr = 64 - trailerlen;
+				/*
+				 * No room for the padding: hash the whole
+				 * blocks now and carry the partial one over
+				 * to the next step, which adds the padding.
+				 */
+				new_cache_ptr = len & CESA_HASH_BLOCK_SIZE_MSK;
+				len &= ~CESA_HASH_BLOCK_SIZE_MSK;
 				if (engine->pool)
 					memcpy(creq->cache,
 					       engine->sram_pool +
@@ -262,15 +269,20 @@ static void mv_cesa_ahash_std_step(struct ahash_request *req)
 						    CESA_SA_DATA_SRAM_OFFSET,
 						    creq->cache, i);
 				len += i;
+				sreq->final_issued = true;
 			}
 
 			if (frag_mode == CESA_SA_DESC_CFG_LAST_FRAG)
 				frag_mode = CESA_SA_DESC_CFG_MID_FRAG;
-			else
+			else if (frag_mode == CESA_SA_DESC_CFG_NOT_FRAG)
 				frag_mode = CESA_SA_DESC_CFG_FIRST_FRAG;
 		}
 	}
 
+	if (frag_mode == CESA_SA_DESC_CFG_NOT_FRAG ||
+	    frag_mode == CESA_SA_DESC_CFG_LAST_FRAG)
+		sreq->final_issued = true;
+
 	mv_cesa_set_mac_op_frag_len(op, len);
 	mv_cesa_update_op_cfg(op, frag_mode, CESA_SA_DESC_CFG_FRAG_MSK);
 
@@ -299,11 +311,12 @@ static int mv_cesa_ahash_std_process(struct ahash_request *req, u32 status)
 	struct mv_cesa_ahash_std_req *sreq = &creq->req.std;
 	unsigned int left;
 
-	if (creq->last_req) {
-		if (sreq->offset < (req->nbytes - creq->cache_ptr))
-			return -EINPROGRESS;
-		return 0;
-	}
+	/*
+	 * The last request may still hold a partial block carried over from
+	 * the previous step, and always needs its final operation.
+	 */
+	if (creq->last_req)
+		return sreq->final_issued ? 0 : -EINPROGRESS;
 
 	/*
 	 * Less than a block left: keep it in the cache for the next request
@@ -331,6 +344,7 @@ static void mv_cesa_ahash_std_prepare(struct ahash_request *req)
 	struct mv_cesa_ahash_std_req *sreq = &creq->req.std;
 
 	sreq->offset = 0;
+	sreq->final_issued = false;
 }
 
 static void mv_cesa_ahash_dma_step(struct ahash_request *req)
-- 
2.56.1

