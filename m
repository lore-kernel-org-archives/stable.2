Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451A343D72
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778592; cv=none; b=rlw+Robov7VRx6C2GxVAOOESXgZL1jM8m5HxIFPIlxU107gn743AcBh8MH/IWP6pHyf50lQUGm8UJBkP2AzKQzmDzdejmrBFRWkOD0G7MhanIU/pazYhrbgbtfbpJDckHeToXPtPI9w1SgyYSs5eZ+oCGRA6JMx6m6WpVrovdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778592; c=relaxed/simple;
	bh=k6P5jy0WQDTaz2aaIa44CjnDPszeWZrbdA+QJq0ZtZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P36aPJfEA1iD4fdKEE4Fx7HwI0G5i+FrYuGY23bN1uPgyqtwj5zzQejFe1s93ncRY1pAgQrqWWTvHFwiLhn/n8V4+4gS6j1OB5/olzQ1t9mpTT2IPzGWOL7tP0cpuY5h5mj8pptWGaqUaz9Uy3khVPbdiZigdAFiImSxe0hyJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=RTN9UJaZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="RTN9UJaZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e812e2b31bso7185645ad.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778591; x=1792383391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DlUEUGLS7Nt4T4pXLTvciuKtlGeSVjzlDjaczYVQW0=;
        b=RTN9UJaZ6d/DSZ6EcqIYffVTi3SXmgfx0PtAibT4Kd7FG9cObqkL1QS7n2xswfGoLv
         GV1ysC58P1bd78MUg56YNVF5Y7doeouFVtd2riipWuW84UpzoCJsyYt757A8zV8yN2pU
         R69fzXtR80mYM2XuqR3wbmrw/lM6IxjwQFxShAnw4B7lDcTLlW4AFe33NMXOE7uXTSfh
         9iiAYWbPqp9UJpZ/UIJT3Sk20lbkM1zKNczBK+vyWFgOvxYttxEM7SUwgYa3ZMqAGRnw
         dPUSSNGPK2hqUvvmEfQIQ0eJbHGkiprmDKePjGqtASZB5H2HBfXCvhnzr69kLVNz/B1a
         gWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778591; x=1792383391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DlUEUGLS7Nt4T4pXLTvciuKtlGeSVjzlDjaczYVQW0=;
        b=bny14WFp9+YNDejWY1pKSAa1sGJFEMAhMVLCpGmyRy5GFAoD9GeSYceSPYja6cQVTN
         +udNz5FjRi+Jue1i8X9k1rSD3VyC2po08P8dPx3jXHa5r0OThMwpxsv+cnOW01tToDZY
         TTCHqCsk4KlRRnOFg0B/bd3WaFV2w8sgS+NfG/w1T3U6Ir4EhBUP+60FuWiRJD1+KXt0
         rMPe3vWlY9iHUagchUnj1cK1y3rraky/kyvsxVqEjFYa4kE1fZINoOsVOy1HkPCMu+u5
         YP5NxgK4jOTOQHM2Qbeo16T+aYHwiQyEA4YUyAlNITh6H896CdKdVjSMBMSWncUo0RI+
         qm1w==
X-Forwarded-Encrypted: i=1; AKwUvBzTRmJwCRnys3FWE+x1A8pjoRojp4RcEw+UQFqoXYDeDGcwaK0w4Au5KXNBHKJeNzO1vCrLYz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRguXJfPxCH77iwUZpmL80v69p71dC6+2rxgaKUDDVeqzW4Ahv
	IvxhUxQfffPZtqjoy58be8Iue25ybcK4f+xgrZazSmR015ZVZCwCUmV+2l0BMpfsPE0ti4j0LUG
	XeBXu7WQ=
X-Gm-Gg: AYBFou1skx3SJQ9jG2RsTRb5Q7ZL5Y+CJqgSprVROobxzcUcTTnz128JCyP7/5OmQ2A
	vKvO4ORbanrMF8lzCotmfYElIzVsPDjF+/kCfB01RRrGlVJijYxIXUst4y+q8n4h0yYiWnst90I
	Yj4f6GA3uEXoloOmG4YJxT6dfmwNTEMpoHlQrtgN2bFvsO6Bx+gGJCNvDHCD622Zu/QOoJR08D/
	4x56gWVLVwosCA5Kf9j+DHUC+fPYpJ5OVPnuNaFr0sHEH7M1fHvzasYcfD2Ddz2gtW57YKN1HAA
	ygPxjruYW/kjQI0dQ+WW99k/r7+0HzsVJcrrWPDTav8G2B4mkY43BxWss27etjeiqdb+s2memru
	uDRdH+Ley7Z85LMaRvZ9lyF/6mfKr0u5iIipbVrysNfWuFNdcxSvSyj1apCXjkfNIrULOf667YG
	8pdryA2O8RE/yJ87xvsPj+5j5/Srznqz+l94U0n+E40kwUWg4HYgVPltHhVESsJ7l5CfCbMNkoh
	2eaeg==
X-Received: by 2002:a17:902:ce12:b0:2e2:aa17:477f with SMTP id d9443c01a7336-2e842f11b4bmr67470145ad.58.1791778590797;
        Sun, 11 Oct 2026 21:16:30 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:29 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v3 2/5] eth: fbnic: validate the Rx completion offset and length
Date: Mon, 12 Oct 2026 13:15:57 +0900
Message-ID: <5b7c2618b56d35f50b6847d565a0050cf2a7f371.1791775409.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_pkt_prepare() and fbnic_add_rx_frag() take the offset and length
from the completion descriptor (FBNIC_RCD_AL_BUFF_OFF_MASK and _LEN_MASK)
and use them to place data in the fragment page without checking them. A
device that reports an offset below the reserved headroom, or a length
that runs past the 4K fragment, produces a negative headroom and a frame
that extends beyond the page, which is then read out past the page into
adjacent memory.

Reject a header whose offset is below FBNIC_RX_HROOM or whose offset plus
length exceeds the fragment, and a payload whose offset plus length
exceeds the fragment, via the drop path. Clamp the derived frame end and
truesize to the fragment so a FIN descriptor cannot push them past the
page. A maximum-size header (offset 192, length 3584) stays inside the
fragment and is still accepted.

  BUG: unable to handle page fault for address: ffffed1021a8ee10
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:kasan_check_range+0x15e/0x1b0
  Call Trace:
   <TASK>
   __asan_memset+0x23/0x50
   __build_skb_around+0x222/0x320
   napi_build_skb+0x50/0x1e0
   xdp_build_skb_from_buff+0xda/0x8b0
   fbnic_run_xdp+0x29a/0x1040 [fbnic]

An offset and length that keep the frame inside the page but past the
valid data produce no splat: the read lands in adjacent page_pool memory,
which carries no KASAN redzone, and is copied into the skb silently.

Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 41 ++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 305fe6d2f511f..7dda59bba14ee 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1037,13 +1037,34 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 		return;
 	}
 
-	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+	/* The completion describes one frame inside the one
+	 * FBNIC_BD_FRAG_SIZE fragment it names.  fbnic_hdr_pg_start() takes
+	 * the headroom back out of the offset, so an offset below the
+	 * headroom underflows it, and the frame data runs to
+	 * hdr_pg_off + len, which has to stay inside the fragment.
+	 */
+	if (unlikely(hdr_pg_off < FBNIC_RX_HROOM ||
+		     hdr_pg_off + len > FBNIC_BD_FRAG_SIZE)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
 
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
 	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off);
 
+	/* fbnic_hdr_pg_end() rounds the frame up to where the next header
+	 * would start, which can be past the end of the fragment when this
+	 * frame is the last one in it.  napi_build_skb() puts the shared
+	 * info at the end of the frame, so hold the frame inside the
+	 * fragment, which is what the FBNIC_RCD_AL_PAGE_FIN case above
+	 * already does.
+	 */
+	hdr_pg_end = min(hdr_pg_end, FBNIC_BD_FRAG_SIZE);
+
+	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
 	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
@@ -1091,11 +1112,25 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 		return;
 	}
 
-	netmem = fbnic_page_pool_get_data(qt, pg_idx);
-
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
 
+	/* The data has to stay inside the FBNIC_BD_FRAG_SIZE fragment the
+	 * completion names.
+	 */
+	if (unlikely(pg_off + len > FBNIC_BD_FRAG_SIZE)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	/* ALIGN() can round the charged size past the end of the fragment
+	 * when this is the last fragment in it, so hold it inside, which is
+	 * what the FBNIC_RCD_AL_PAGE_FIN case above already does.
+	 */
+	truesize = min(truesize, FBNIC_BD_FRAG_SIZE - pg_off);
+
+	netmem = fbnic_page_pool_get_data(qt, pg_idx);
+
 	pg_off += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
 		  FBNIC_BD_FRAG_SIZE;
 
-- 
2.43.0

