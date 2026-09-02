Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC7363090
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314257; cv=none; b=h1hO0yTxWNO8F0u9nQxwWODXf0H+mXsaYuj5lGh6krx7uKSvajkaJfnEHb7wi4L1rqVWtER2znfGojkam7RqJofy3Nm7lL0Krdo0GQevNI/Zkrhn3qIPYE9nIT3ZsDE7RjewW6LgjJIbPnh9UmsoQfAO+5zBEQqVfnMY7BZSoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314257; c=relaxed/simple;
	bh=nNFtUFgC/p/K4K6LX995cICjDodLLrWxvJtEwtyVtZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ5wAcXgACSVlb4HubtdpB/ZTrU1wOGaxJzsyjtlicZde9I7r61N2jfqEPGTGT45NprEXaFiI2ycQI3L60Ye30/D47MczAkXXfTmQoJEW0/chxSRWPV5xb3wVJjb+VXJLkZIg8rt2D8oUn+62inCAiqXEOSeaJX8sUOYZu0BxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=pbj6n1Mn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="pbj6n1Mn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d58efc7356so5502385ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314243; x=1788919043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2+yr/LF5kIYJw79OBD8uWpDfnVTI0CymWIi9oO6fGg=;
        b=pbj6n1Mnp7kainZQovS0x4vow1t2efIXU79khXi88nIfaJzO3+ftcmSFyFnShUE8at
         x0TChwUe8bU4Sg7tNeyEmTmKyVJX3/WUNtgYGEnrzAsokZ6B0IPSDyqvBAloo5BjcJhV
         MX9x2Crcww5bXwAlvbHM7eYsKEG0SKcsKiJoGZEH1bcmknh6OTtSHTqwpxZclNE4Feqc
         qEAwVIl2hovbCC+JL6S7vDfphmalEx0DVFddX52HQZxlSm3YC9RnY9PzuhPRUEtf3M2m
         d+vddqelbENFMHvPHCBU9zm+2eqIJMqWk+MZI1kmANGxpbfaotfic1xO7r0Jm9QQWVor
         6OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314243; x=1788919043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O2+yr/LF5kIYJw79OBD8uWpDfnVTI0CymWIi9oO6fGg=;
        b=gfPrhArWnA9HEHO22KN2CwIxP1uNl4G+KCEMJ4kgv7Nq0Fas+4SQdtZnOq1CB1F11g
         pAjXtgEAFpfoB41dwGsvWt0J+Hmt1fAU4QHoNRBMRNraJ+L/R1sKloxE0O9rKAConrh2
         l5SrmLbusOKlx81isH+IYETfJ1tCwomE8C/AttG0tEF4sP7UuzUkkayJNjDnUWL7LOjQ
         04oogqDvCJPP1EjDKI624iOCZYk4IHbUna6AjWDb6wpN/yiBmydr4MhTdgnoc6e1r7Aw
         6bRNazX8hk/yCbxF6YZkhFUILlhHpahLp+99pfQL7KCu/AnJgPVqx1+tRUfEeVPX7Bsa
         XRlQ==
X-Forwarded-Encrypted: i=1; AHgh+RreqAGB0+o6Ri2QWREiY7QM44l6O2xguifvfA8Fo8yQCXreLPSoelxDy4J8vo96ULhlfdgnvfA=@vger.kernel.org
X-Gm-Message-State: AFuF++m1FWLaGCpO4g/6RIu5aNfGyi087d8uhsFtEhy18pcnHPTHRtg0
	wqXpAfqipTm5Hl6QfrRfZ+uTs3RvriLiR3CF06IUL6//8+dokuxCx3TReFg0dCSiLMo=
X-Gm-Gg: AR+sD11J3zuYZp5jcAzYtq4D1xtxyKv6uTm7YCcdXijuvRgrmtfyWCTfMKw34ZPV7Sf
	o65jz9xmP5Or1wNKWADtjdU7QQHx0TsS6HWXhNKu7B6iAuDpIFh+mLDSn0kYbRVvRKZOAzxAO2E
	Jl/74h7cVJgJwtbVc8E+6l2ffUrjJV9GqTClDenhTskc1LR8fqP7zjFI8jTfeu15TEf0rCrhP5M
	Yop0KgaKh/N7CAVrMCQCGk14ZFWdAP5x90TbX1wEFgGjZjDtO0bg7AL2WM86utk6J9g5Z8+1ajX
	mnRo1uSH/8gR9lNERSViMguCLCBPr8bY0BGk7mTbB1dfHz2kZqN4b7O1C0VNWfhpt0cGiz7sP5t
	lB4/Q/s8gn10y7Wj90aoKasUEgLb7gWcFeDHRrljVwKjC0qrFbrjGMTJI3uXjRguv5ji8WKB0cB
	+MhXXxkr5nz3isTFCdKONypr2ZQGmx+O/9Afb5/OoG
X-Received: by 2002:a17:903:3910:b0:2d9:464f:d45f with SMTP id d9443c01a7336-2daec5dfb40mr22503425ad.5.1788314243448;
        Tue, 01 Sep 2026 18:57:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd356dc8sm5221595ad.8.2026.09.01.18.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:22 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: horms@kernel.org,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net v5 6/6] bnxt_en: Bound SW TPA IDs to prevent crashes
Date: Tue,  1 Sep 2026 18:56:49 -0700
Message-ID: <20260902015652.2421609-7-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FW supports up to 1024 concurrent TPAs, so the FW TPA ID is in the range
0..1023 (see commit ec4d8e7cf024 ("bnxt_en: Add TPA ID mapping logic for
57500 chips.")). bnxt_alloc_agg_idx is intended to wrap the FW ID down to a
software ID which is used to index rxr->rx_tpa, and to generate a mapping
between FW IDs and the wrapped software ID.

On a 57608 with firmware version 233, the firmware advertises 32
concurrent TPAs. As of the commit under fixes, bp->max_tpa on this NIC
is set to 32.

If the software ID from bnxt_alloc_agg_idx is above 31, this results in
an invalid address being loaded on this line:

  tpa_info = &rxr->rx_tpa[agg_id];

because rx_tpa is allocated with only bp->max_tpa (32) entries. Writes
to tpa_info later in the code are out of bounds.

This bug results in a crash at boot:

Oops: general protection fault, kernel NULL pointer dereference 0x8: 0000 [#1] SMP NOPTI
RIP: 0010:bnxt_rx_pkt+0xc0/0x1560
RSP: 0018:ffffc900009b8c78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000048 RCX: 0000000206682516
RDX: ffffc900009b8db4 RSI: 0000000000000000 RDI: 01ffffff038fe1c0
RBP: ffffc9006e687480 R08: ffffc9006e687000 R09: 0000000000003048
R10: 0000000000000480 R11: ffff8881c6083900 R12: 0000000006682516
R13: ffff8881c6095400 R14: 0000000000000016 R15: ffff8881c6b66680
FS:  0000000000000000(0000) GS:ffff88fef3c77000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8bda40584 CR3: 000000807c812001 CR4: 0000000008772ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? __netif_receive_skb_list_core+0x1ca/0x250
 __bnxt_poll_work+0x152/0x280
 bnxt_poll_p5+0x1cd/0x480
 __napi_poll+0x30/0x180
 net_rx_action+0x20b/0x3b0
 ? note_gp_changes+0x53/0xe0
 ? tick_setup_sched_timer+0x180/0x180
 ? __napi_schedule+0x9a/0xb0
 ? bnxt_msix+0x24/0x30
 handle_softirqs+0xdd/0x2c0
 __irq_exit_rcu.llvm.3171231171502365008+0x47/0xf0
 common_interrupt+0x85/0x90
 </IRQ>
 <TASK>
 asm_common_interrupt+0x22/0x40

This stack trace is from a crash triggered when an out of bounds rx_tpa
is dereferenced. The invalid write mentioned above is silent in this
particular crash.

Fix this by allocating rx_tpa with bp->max_tpa rounded up to the next
power of 2 (bp->max_tpa_roundup_size) entries and masking the FW TPA ID
with that size, so the wrapped ID can never index past the end of the
array.

Fixes: 54c28fab2fa5 ("bnxt_en: Set bp->max_tpa according to what the FW supports")
Reported-by: Raphael Cardoso Fernandes <raphaelcf@meta.com>
Suggested-by: Michael Chan <michael.chan@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
v5:
  - Updated the commit message to mention where the 0..1023 range comes from.
  - Updated the comment in the code now that a previous commit in this series
    addresses the LRO issue.

v4: https://lore.kernel.org/all/20260828190900.1767611-1-joe@dama.to/
  - Moved bp->max_tpa_roundup_size init out of the early return path and
    documented that TPA is unsupported there, as suggested by Michael.

v3: https://lore.kernel.org/netdev/20260827185700.2157164-1-joe@dama.to/
  - Addressed an issue Sashiko pointed out, where max_tpa_roundup_size may be
    left unset if bnxt_alloc_tpa_info returns early, which would lead to out
    of bounds access.
  - The other pre-existing issues Sashiko pointed out are unrelated to this
    patch and would need different Fixes tags, so they are better served with
    separate patches in the future.

v2: https://lore.kernel.org/netdev/20260825001842.2501798-1-joe@dama.to/
  - Followed Michael's suggestion on the v1 to increase the size of the tpa
    array so that wrapping indexes into the array is a simple mask.
  - Add Suggested-by because the approach was suggested by Michael.
  - Add a Reported-by so that Raphael gets credit for reporting this bug.
  - Boot tested on a machine with a 57608 and the crash did not reproduce.

v1: https://lore.kernel.org/netdev/20260821233549.3134699-1-joe@dama.to/

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 ++++++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d2943de1b62a..b2ce5b4e5e6a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1514,14 +1514,16 @@ static int bnxt_discard_rx(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return 0;
 }
 
-static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
+static u16 bnxt_alloc_agg_idx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
+			      u16 agg_id)
 {
 	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
-	u16 idx = agg_id & MAX_TPA_P5_MASK;
+	u16 idx = agg_id & (bp->max_tpa_roundup_size - 1);
 
 	if (test_bit(idx, map->agg_idx_bmap)) {
-		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
-		if (idx >= MAX_TPA_P5)
+		idx = find_first_zero_bit(map->agg_idx_bmap,
+					  bp->max_tpa_roundup_size);
+		if (idx >= bp->max_tpa_roundup_size)
 			return INVALID_HW_RING_ID;
 	}
 	__set_bit(idx, map->agg_idx_bmap);
@@ -1586,7 +1588,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		agg_id = TPA_START_AGG_ID_P5(tpa_start);
-		agg_id = bnxt_alloc_agg_idx(rxr, agg_id);
+		agg_id = bnxt_alloc_agg_idx(bp, rxr, agg_id);
 		if (unlikely(agg_id == INVALID_HW_RING_ID)) {
 			netdev_warn(bp->dev, "Unable to allocate agg ID for ring %d, agg 0x%x\n",
 				    rxr->bnapi->index,
@@ -3584,7 +3586,7 @@ static void bnxt_free_one_tpa_info_data(struct bnxt *bp,
 {
 	int i;
 
-	for (i = 0; i < bp->max_tpa; i++) {
+	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
 		struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
 		u8 *data = tpa_info->data;
 
@@ -3781,7 +3783,7 @@ static void bnxt_free_one_tpa_info(struct bnxt *bp,
 	kfree(rxr->rx_tpa_idx_map);
 	rxr->rx_tpa_idx_map = NULL;
 	if (rxr->rx_tpa) {
-		for (i = 0; i < bp->max_tpa; i++) {
+		for (i = 0; i < bp->max_tpa_roundup_size; i++) {
 			kfree(rxr->rx_tpa[i].agg_arr);
 			rxr->rx_tpa[i].agg_arr = NULL;
 		}
@@ -3807,13 +3809,14 @@ static int bnxt_alloc_one_tpa_info(struct bnxt *bp,
 	struct rx_agg_cmp *agg;
 	int i;
 
-	rxr->rx_tpa = kzalloc_objs(struct bnxt_tpa_info, bp->max_tpa);
+	rxr->rx_tpa = kzalloc_objs(struct bnxt_tpa_info,
+				   bp->max_tpa_roundup_size);
 	if (!rxr->rx_tpa)
 		return -ENOMEM;
 
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		return 0;
-	for (i = 0; i < bp->max_tpa; i++) {
+	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
 		agg = kzalloc_objs(*agg, MAX_SKB_FRAGS);
 		if (!agg)
 			return -ENOMEM;
@@ -3832,6 +3835,9 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 
 	bp->max_tpa = MAX_TPA;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		/* TPA is not supported at all, so there is nothing to
+		 * allocate.
+		 */
 		if (!bp->max_tpa_v2)
 			return 0;
 		bp->max_tpa = min_t(u16, bp->max_tpa_v2, MAX_TPA_P5);
@@ -3839,6 +3845,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 		if (bp->max_tpa <= 32 && BNXT_CHIP_P5(bp) && !BNXT_NPAR(bp))
 			bp->max_tpa = MAX_TPA_P5;
 	}
+	bp->max_tpa_roundup_size = roundup_pow_of_two(bp->max_tpa);
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
@@ -4551,7 +4558,7 @@ static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
 	u8 *data;
 	int i;
 
-	for (i = 0; i < bp->max_tpa; i++) {
+	for (i = 0; i < bp->max_tpa_roundup_size; i++) {
 		data = __bnxt_alloc_rx_frag(bp, &mapping, rxr,
 					    GFP_KERNEL);
 		if (!data)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ab894f8addef..de46b42d7c98 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -789,7 +789,6 @@ struct nqe_cn {
 
 #define MAX_TPA		64
 #define MAX_TPA_P5	256
-#define MAX_TPA_P5_MASK	(MAX_TPA_P5 - 1)
 #define MAX_TPA_SEGS_P5	0x3f
 
 #if (BNXT_PAGE_SHIFT == 16)
@@ -2380,6 +2379,7 @@ struct bnxt {
 
 	u16			max_tpa_v2;
 	u16			max_tpa;
+	u16			max_tpa_roundup_size;
 	u32			rx_buf_size;
 	u32			rx_buf_use_size;	/* useable size */
 	u16			rx_offset;
-- 
2.53.0-Meta

