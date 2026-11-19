Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067866;
	b=H9g2+6ZyT798A3EEsX9cZmaZvlsuq+F+JT2SWMfhhde27qasADanRMFzqDIob6qPUGTW
	 rqUVyG4tKaNUPkavkoyVulDB9kpng/hPLVyz/M6NFNQszlkhI+mkYmOv6+OjbOaNj3BKL
	 ajL2OIf8MaHumlUEWbxbJbnIPW6iOllARkdIIky2aEweXv69kfAojfh0lkSg1rI3NPl3Z
	 gHvyx8xFdfTx7QVWqrE4PgSOr0Hf+slV2WkgReC7UrN1ABLs/YxamweR42OTg4/ZbFxDI
	 IcwCFkuOTEMCw2mVcQVpfmO+h3SzEJ4N/jj5bnfJmc3s2+QjtFHtLLnPgMGUIJbZt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Uxw3rLhifWc1Jc5KxHA1RVURbGtASCpOsmekIH9l7c=;
	b=p8Z6jL+YwMo3lOTpRJQSe1nGCHuPS52BYdVZ+ZhAozUoYYB8426590g4iQs68LN2Yo18
	 dOVTeOYzFvGUCLHjOF0WrBM8USuw9V9W0BHvjpzXkrzAQ3ILK824T5OpJD9f9dtfgOzZo
	 yHg4AGpQpLkEbo4CK5SW2VpaavNAXFSspmttuX8ZdoFOG7zAtvA7rXTIL10kh4bDOfSTv
	 cz/1GzWx107A1Roa0Zbd/avt9vXTWhbMMtbCN2cZlEpN6d2kGQe0nM5bjrsj3OFet+N/q
	 e15Ig6bFEK+wmiuMajH9HMsgeAcPQFAvkoNOtIfzoinQbsxOJYtQwf8DILqWfE4anhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edN4lkzL;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C2606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412C2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edN4lkzL
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so19473095ad.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067865; x=1795672665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Uxw3rLhifWc1Jc5KxHA1RVURbGtASCpOsmekIH9l7c=;
        b=edN4lkzLoerGnOUz+XU+d/BCZNqPHs8kMn5ctqctnN5ihldL6Tovx6KDoeSBRs0yik
         YXHiEoaqoGjI3ugZXaw+bBuBzzh8lGouLKku5VIyWIP2WsSLQVooTbIgfjpbkRXPQCMa
         13HS2f7KdvE7aX1VGcXIjZOKVWkLSGp9vVO2GJHOMKL8cRAVdEttghi5tbgVzASucta8
         HF53S0aZlzey2K4/Gsax/g1q0O73EZAbCjpNX7qiSF4/q5Ali6kOcq+K/PModinNYsul
         s+jYH7ZZpPWTw9ezWHLWPaWoNWDuV2I97ocSTRXXfwXU9bcR7GM9I1VNlZArFRezGYO0
         F7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067865; x=1795672665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Uxw3rLhifWc1Jc5KxHA1RVURbGtASCpOsmekIH9l7c=;
        b=nog+2ZbhC0tF+LhKAi181PxCVTQ8T4rwe7aS7kzKwqr9mrauWmoU/BiiG/pVmGCv3x
         elR4DMG35O3GegC+LPh6ffHYEk7R9Kg7FT8sABFhyVK75VUbue4BEKRU/p1iKT0XRnGX
         hxVL69au/9H2tCye3zc/Co7oyIDeG4g+YUlsbrnu377VLuz01ZOYs30jpwnwJLbHuSy0
         sXwwXJh7T2tTGVs2QGdU6JCH/ICcJNXUMmrdtgjJ07cOjMkQjaLVwnQc5BNLs+bVQgJZ
         i59UfVqZCNk5qfsUAqGQhbbW+KHMHCIIoc/tFuknMPR5AZs6K6oz790rDkQPm5QD3CU4
         AcRQ==
X-Forwarded-Encrypted: i=1; AL+hErFAHZ6kNM4/muOlnia6bgZlDBdyu5TMySXLF3nN3U+yNZKJKQ7ZjpVVmh7WDYiVj4+3zQ3dvhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ASJp6TnmitM7qsbBQh/u/sQvO7taQPU80RRpTh4C7Wd2DDpNQ
	e3at/jdRVo+bZkmcPZ2w54qJkKDTd+uKorpKAHQ3gh0YVa82HstSub31
X-Gm-Gg: AZFdTZcKN8FozsGT0TaPuX7wCPm0X/T6nOaSCajENVeANZw9BB7xqCfOgho4e8b4nNK
	uvVCGbz7DTSVHRqwwJDsFHppo6u5vkdExuBZKflluGNhOUt+2B8pK2ydT8kEScf9AnxGRj5YVME
	k1l1ULJ6ARSAOfG2Kck+YFLNMc6TfSksop6ak65fiUa5SF4DS/wY/UMMoPQvRyN9En8JNcQetd2
	PeMDhvQmllJJitg/yf996nki+LhcskYRoUyav2q0x+ypfNOMT4RdnlRVtQNWiaRvQ4OebJ9tkak
	LKl4gLhQxwKJ3kf/PsYQBuTdFqfyBPbLVDTAdXBv7QNPD4XVwq6pHVzw4YNeRvsdTDuEXSZ6LTx
	0yCZj7C+0rLBpBAX56DTf3DDcIT2Zd/nSI/Xb+F46WHk0s/wPBvGS1FeXfjIJDCnp+4t64ZJMzX
	YlmUXTu1xlclnRSfKHO+oJ22kzUXpHgxSnMJ4b3vBiEsdn5v/tK3h2LmqzvPGge8PMmGu+9LgFZ
	nPrG1xccuqppYdOvMPlMUmBmmnsL21N/qrSvQy4vsk7mfawobc0PYts8uvEAJmWsCZ89HtdZXJF
	tfT7dL9b1LtTXZ4mGQF8D/bNIQtymHITUE5YMDZAAJBzq3lOpA==
X-Received: by 2002:a17:902:f605:b0:2dd:ad73:5b6d with SMTP id d9443c01a7336-2eff740ef49mr46440545ad.29.1795067865468;
        Wed, 18 Nov 2026 21:57:45 -0800 (PST)
Received: from localhost.localdomain ([155.69.167.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62e38eesm24522945ad.76.2026.11.18.21.57.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 21:57:45 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: jjohnson@kernel.org
Cc: lcy8047@gmail.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ath-current] wifi: ath10k: Do not free the caller's skb when HL TX expands the headroom
Date: Thu, 19 Nov 2026 13:57:40 +0800
Message-ID: <20261119055740.55934-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When the skb has too little headroom, ath10k_htt_tx_hl() copies it with
skb_realloc_headroom() and frees the original. If the copy fails, or a
later step fails, the function returns an error and
ath10k_mac_tx_submit() frees the original skb again with
ieee80211_free_txskb().

Expand the headroom of the same skb with pskb_expand_head() instead, so
the caller still owns it on every error path.

Fixes: a2097d6444c3 ("ath10k: htt: High latency TX support")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    Bug was found by kbound, an internal static analysis prototype.
    The fix was written with the help of Claude Opus 5.5.
    
    Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
    not have an SDIO or USB ath10k device.

 drivers/net/wireless/ath/ath10k/htt_tx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index efaea150025b..7b759f506f80 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -1276,7 +1276,6 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 	struct htt_cmd_hdr *cmd_hdr;
 	struct htt_data_tx_desc *tx_desc;
 	struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(msdu);
-	struct sk_buff *tmp_skb;
 	bool is_eth = (txmode == ATH10K_HW_TXRX_ETHERNET);
 	u8 vdev_id = ath10k_htt_tx_get_vdev_id(ar, msdu);
 	u8 tid = ath10k_htt_tx_get_tid(msdu, is_eth);
@@ -1330,16 +1329,14 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 	 * and realloc the skb if it does not have enough headroom.
 	 */
 	if (skb_headroom(msdu) < HTT_TX_HL_NEEDED_HEADROOM) {
-		tmp_skb = msdu;
-
 		ath10k_dbg(htt->ar, ATH10K_DBG_HTT,
 			   "Not enough headroom in skb. Current headroom: %u, needed: %u. Reallocating...\n",
 			   skb_headroom(msdu), HTT_TX_HL_NEEDED_HEADROOM);
-		msdu = skb_realloc_headroom(msdu, HTT_TX_HL_NEEDED_HEADROOM);
-		kfree_skb(tmp_skb);
-		if (!msdu) {
+		res = pskb_expand_head(msdu,
+				       HTT_TX_HL_NEEDED_HEADROOM - skb_headroom(msdu),
+				       0, GFP_ATOMIC);
+		if (res) {
 			ath10k_warn(htt->ar, "htt hl tx: Unable to realloc skb!\n");
-			res = -ENOMEM;
 			goto out;
 		}
 	}

base-commit: b1ed5a45b994a6473ca1cf34f35a1bf87f1d8e2a
-- 
2.53.0

