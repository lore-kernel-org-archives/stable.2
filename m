Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFA4BD793
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660442; cv=none; b=GjbY+wXY5HXN7Wf11HunJm+x2B7mHB2Hl3nb81k8e5umyKBBVdXki1JI8sc8z9YmhdqFyY3zSNqZUhghUgpFzRdf7ORWWoW6z9X8j5IJvhujwG6Fam0xqsLNXPqKM4FtxnX0+riF0UerH2PPaO601TSr3D7Mtvf/2Xt82blP638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660442; c=relaxed/simple;
	bh=T21C/au/tuvTBrwLBzOHO/ngCMEJ9LQB0PnJ+o7cO48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfS59j4u0JSWP4QgLz3qi7DK5qQhSfVR0PlwNTjilSr/5LQmmtbGOT+Bmzf8WgFTTEOkJ/f9VTfuGF7jILUGS0WUhNZsM6+vkpymUV6u50R7D0IAXjrYjaDTolSqhLBRieV2+CqfvmfA8KvqT9hFT/2lQA+E2tlE2wFMLxrmfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=DZc/VWcB; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="DZc/VWcB"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35903777bbcso337023eec.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791660439; x=1792265239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ONbofROHEB35NS/5T323EfaoteCEiGhp0xJlYSlbpeU=;
        b=DZc/VWcBXE/7zuz3dO+iCewTqlpfi0WBfQAFI2PiG6fItnsv75UeMsyLLMlaDmzEhZ
         XEqEpqI27NLTELb7V1KXdgn8EPLyyVGjEy2XHo3541/gTgnFgwPS2isAhKfvu6jKgMo1
         ZgethWu+fgpuXo1+Y6YaWonGEWQE6eoKzO/fYpRSqSdxFbv+Z/z8GB6ICw919zdG6DI7
         LW5uHkRLyB97cfQpYo94Vwm2kbqYAgANHtSANEBOPq9VkKWZckewucgp3UuX7hyYZisS
         LfVsLuRkPwNXx/YwuwbQbSKqJ6NbPmNCLXFu7NRgAf3wdGKau4vbEPmp4ICWsj/HnOHt
         Dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660439; x=1792265239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONbofROHEB35NS/5T323EfaoteCEiGhp0xJlYSlbpeU=;
        b=HJE2BLU98qgjZQ0+6XuevXVjV6y29Z6ipJq7O7zwS56/Mahk4pjDBshaRW00W68YIJ
         auYXWklgEO8cuZ0IW3zrCTxHA8/IUK4pKQw0TRa/47B4cCu8kycEU+CJhXS7L4qpCyQJ
         kdEB+58YWCpc+tFf5WUdIb01Ij1BwkojLUFelr0gyujU19obPCt+oOwF4IYZAWT7Bo+s
         TcEcul/jwCWyZKc+Rb3rx1h89w4ZMSDhVcPk4WKnksD7vRsEg4VstGV3xjn1/aR52zkR
         JrpKI+PPmdLJ9PKUd9TMq4GyNyDQ0JYBexN6hWRmUY5J3i6kDyjC1RTI25fdPB0+o2VA
         nKPw==
X-Forwarded-Encrypted: i=1; AKwUvByWMKQvQ6tfrJY5cpsTcKalhyOVmQudSHd/1uY+SjPZj2fIoFbNcx1k7i06ffw7slFF86VZF2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO+59lo2mEeKKzy903fmBwjnfrcgiN3UGg2wFd+zhQsYOl67zh
	MkKssc4Z2FDa4ADtemypVUynmyVvTadcEQi5P2k5zqIDrwWkKNqKo7GlR1fE+GXzTvU=
X-Gm-Gg: AYBFou0xRTG9/sBszRviTQv2k4ChJZots6LwpTeq0hpIAev5FnSDF4XTBR7zNoLl5Kq
	TQIUCVNRWqFHOa56XG0MxyiNlySCG3h7kPJ2bQ1b0IrIi6mpSp4xpybZOz80duRcJ4I4Ay33MSa
	ekjQlrhQ6G5Z4UJlMKlfHl37KpeA6yMFv+4pBg6sy9ErvlnebHUz4FTGQZnriJMnnsaxKcj9Ekn
	Jub24mVZCYr0QLyvqQdf5S3njLk5Bwi+bBeUolvNJem239eZ6zcdNu2T3QULcopObn0HE/0mzK5
	bK8tTZwAk5IbUd8kpLVl+TWcV7d76NjvwrsYhORL01hwvveI5Cv5yRmj1r3LsRT7sNFGZZGZC9D
	MyyISTAY6cRmte5R3tT0kLd7wMbtGOwMOkCqsUEJWR/IrI7vkfGCuSboN+4Vpl6sP2KMI1zmrPM
	CeDgIX6JmSceIC+4+OozaRGLA4V4KA4fxhyDwimPwzLB4hoZIk0IaooPp7mzIZRPee5Mc6XLiQ3
	BHu/0xXBEfnyJVM9GZtA1CSxDIaTyFf
X-Received: by 2002:a05:7300:8410:b0:353:599f:d63a with SMTP id 5a478bee46e88-3537e0202abmr7181873eec.17.1791660438526;
        Sat, 10 Oct 2026 12:27:18 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:9657:9541:a576:7d2f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm18641806eec.10.2026.10.10.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:27:18 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v2 2/2] eth: fbnic: return the page reference taken for a dropped Rx fragment
Date: Sun, 11 Oct 2026 04:26:50 +0900
Message-ID: <57e762aa85874571b506e5b5a55004029b4b2a5d.1791659860.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_add_rx_frag() takes a page reference through
fbnic_page_pool_get_data(), which decrements the buffer's pagecnt_bias,
before handing the page to xdp_buff_add_frag().  xdp_buff_add_frag()
fails when the buffer already holds MAX_SKB_FRAGS fragments, and on that
path the reference is lost: add_frag_failed is set and the frame is
dropped, but the bias is not restored and fbnic_put_pkt_buff() only
returns the fragments that were actually attached.

The page is then never returned to the page pool.  A device that keeps
sending payload completions for one packet past MAX_SKB_FRAGS leaks a
page for every completion beyond the limit.

Restore pagecnt_bias on the failure path, the exact inverse of the get,
so fbnic_page_pool_drain() reclaims the page.

Fixes: 61f9a066c309 ("eth: fbnic: Use shinfo to track frags state on Rx")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b4ca9f7e8bb2e..ba663fe7598f1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1076,6 +1076,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 
 	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
+		/* Give back the reference fbnic_page_pool_get_data() took */
+		qt->sub1.rx_buf[pg_idx].pagecnt_bias++;
 		pkt->add_frag_failed = true;
 		netdev_err_once(nv->napi.dev,
 				"Failed to add fragment to xdp_buff\n");
-- 
2.43.0

