Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506541D65E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857068; cv=none; b=e1fgC/jBDrSVsZEYWz3EbXCiJwYoxlF0N5wzulScIkAE9ycuZ5qh+OwGfBCaWulQNvJ1JokzRgQRvkJg1LqspPIDcxVlE/q8TWDSFyRdV3hRKAtl5In+Tegk/6Or0+GTOk95YQZmiXXI4OgkEkJ403R8UhORl2cwXGkanHrqTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857068; c=relaxed/simple;
	bh=2sOodfgfsJvhsqW94qeYn0qkhe9uEMRF+lcymC2ACNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7xJNEmC+T3HazzNlfCGrYurYQsZ6/uEEzNu+eyBAbZi63ygTY2LMFVkPBYHb3KBVZiUPw7V4tfKMC7SHAoVbj2AUJvGcZgkFJNp0YaV4vwpg418P1XB7e0yK0C31GMpjUnvV8LKkPO9wxMEEtPrZslce85K6VVbCO6WdZQ3i4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ey28pnFV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ey28pnFV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84830c774a0so385894b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787857056; x=1788461856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6buHA8XL3FoLT9T4LeVf/7ku8y2shlH2FUen9mPz6c=;
        b=ey28pnFVtbturuRJRAVpQ2FirCc1pFV029jreFdMvUpDfk+ZuuMWgaI8sCi0d0FseL
         VWj7Wnoxa8lz5pTXm4MQCoatUE424lgV3cqjVvgdsR/5WjgWcpeK9zhQ3kaWJyl65sRV
         aRoLVdlKRNj1brJMwidirWtfAh2avcDr8zxc7pVKpd0AU1hPw6VXWYCrbziAliXUE/A/
         gn6AXgRWDQ6BWHefozm3nXqngsBZs44bX4XIMsfL2Yy8lj2dl2BZ0xH7jdMHRaUwm67Z
         JqEfZSYaM3HtHl2pRlCHWA93tNSVJK1KbKzUu2YVA1gBRsd4UC0D4U9WftHzJSJFpviV
         ZKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857056; x=1788461856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6buHA8XL3FoLT9T4LeVf/7ku8y2shlH2FUen9mPz6c=;
        b=hn1m1NXE/yCnA21YKK4h7lukCmJCUoPFM5c2eBIgYGcvnSfjioCB7XZvJpNnqZ/CzJ
         El1iDNvUTk2nv6DtzcBt8f7QSdgzFxKzPxCG2b64kbQO7O62t9OVth7IeKPhJiex+rWO
         4V8Y5qXPyK9QyV5a74cfrGkAqACmYTTLi1VSPlMYUUvi7ftmYunhjVLHnk/FO01KmtXP
         ryDQkHtS4orEN4k7n3uhoiUcdtNxM+v4DmTjArQJ+mIrZjZ78mZ/QVmGExp/9p3tuftW
         wFxRrMeZhl6Jl2fHjOaxRr4Z1cf27AoRlyi4qX6DyO73GUXrwbo7qX1CTBzI7C6csn7W
         sybw==
X-Forwarded-Encrypted: i=1; AHgh+RpOE25EH4w6CLsCaTTu4jkdJCADuN53RiCbzwpcUFDlNhg9PMCJI+iglL50Q/KFW6CzP/J+Vrw=@vger.kernel.org
X-Gm-Message-State: AFuF++kUcWWwtdYkztcF3yvS5iA1p/sOCsQrB0szE45LFBBQalQzu+tR
	pyzjbeDmXcyyeDQSm2994kw98hbjv6JJnyhmMk3AouOkl98YaNGYSNvWvVRJz7u4zsU=
X-Gm-Gg: AR+sD12lpOcGear6WsJrPdGcOnaodG+eGMctx5Su/JXu6hd4nPj/vqZBrjz4zuqOUYN
	KHDJYyGlsIri4i3UDA2l72ozAshs4P1svVGG2fsAF4AYem6JJ1tseyoNFLCPdJ6i0mY5oRBVHJo
	SQjW5SGvOLGYscOacpMWraqOEqqeIrw6nju+xAkhGq2tVAjJDAChWS6QCCqsfO6WAZFy+Le2YM1
	GRuxwIBjezXy3uX1wsAPss+hRFPn9RS6TR69pMGmz1Q2pvT/OMe0w89uPk7Xdu1FLQYKFXfwHtQ
	5hgZC/lckSXOob2m3qoermk4i9bXVD4B4cPjL6hN1nNuN6EH3JjUpri4nin5olMR/bXsliJTcE2
	+x0u2xGU9s9QenVagOyeug+4iBbn5Qs9TWwFLEusjoH9uzfr/6LKlDDSTlc2KJzSf9lkvl6aHti
	WeIPWwbH+kxBY7r13P+TzA8wqNl0mpXdPwfnvQqQ==
X-Received: by 2002:a05:6a00:4109:b0:852:38ea:3fd with SMTP id d2e1a72fcca58-85629a252e3mr2408405b3a.11.1787857056352;
        Thu, 27 Aug 2026 11:57:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85359cd5f3asm2327602b3a.3.2026.08.27.11.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:57:35 -0700 (PDT)
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
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net v3] bnxt_en: Bound SW TPA IDs to prevent crashes
Date: Thu, 27 Aug 2026 11:56:58 -0700
Message-ID: <20260827185700.2157164-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPA IDs are generated by FW and can be up to 1024. bnxt_alloc_agg_idx is
intended to wrap the FW ID down to a software ID which is used to index
rxr->rx_tpa, and to generate a mapping between FW IDs and the wrapped
software ID.

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

v3:
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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59bcca73a2b..8f4791fb468d 100644
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
@@ -3831,6 +3834,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 	int i, rc;
 
 	bp->max_tpa = MAX_TPA;
+	bp->max_tpa_roundup_size = MAX_TPA;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (!bp->max_tpa_v2)
 			return 0;
@@ -3838,6 +3842,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 		/* Older P5 FW sets max_tpa_v2 low by mistake except NPAR */
 		if (bp->max_tpa <= 32 && BNXT_CHIP_P5(bp) && !BNXT_NPAR(bp))
 			bp->max_tpa = MAX_TPA_P5;
+		bp->max_tpa_roundup_size = roundup_pow_of_two(bp->max_tpa);
 	}
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
@@ -4551,7 +4556,7 @@ static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
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

base-commit: e2a6641e3bfde58f2284f9859c2b0fdcc6d1c0da
-- 
2.53.0-Meta

