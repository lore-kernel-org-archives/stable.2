Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928532;
	b=n/lGIyhfEzzgHvODzNqlxJJqy37Mv5eIIZZMQG64hZFVrThZEYMk8JTEmB3P7o8rMPYm
	 1q1HNwCL/O9FB5uRVHYh7CzH3TJzROEbRCZPOIowEw2N/IlvkTtsrN0nLVS1TVTpGaGsH
	 G2ne0HyqyMDcIXx04Edja0aumCK6IsGN+B8+zuhtYwrJmsVbRKPWVviNcGRS9RNVPVuho
	 rwaoG/BFqsEP340TR4JbsII8lch80Iu56vbufrM3Wik0k6D1Yu2P/PrpTxxd3p4T5gJ1p
	 bdS3tE8V7Or4ZzqkxMzhim4NCFs2Ue7LVzqdNBk5Lvs/BF3xytr7f2c6DJacH2JYSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PhmTqIVrhZ/NvlRobX5Y+GvIs1MtU8Z4kfjwx8mwLL8=;
	b=Idw/Tc3GGMDWMVcQTNukzBAUUtel6RGkPdn6top8N7/nkMZXRjLy+6YatyWKne1LhtXI
	 v9Y2pO6Ys3MGLcmewmuwbvbPc8ccLXc6+8tFfHWrl4FVLO5V8R9835N7m3bWHEA6hQhGL
	 ESK7Abb7b1z9gL1w7r8GXAxi3/HilUvNcExg6PQn7PxXvxUAzBmjzlYmDEcAudWujPbEa
	 fSQcpWuYXFMzNtNse0oeAavc5avfArt7ruMA9Sa+jYkF5oMpWG9zIk7NVjrS6XVmFOh49
	 QtmJxrEEqEgc+vVaVrpS+K/odP9BbokTKk2Z6yKixdZvITSkmMNQIwSnu9WMPXsYPEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TpvUiXJN;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD3606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TpvUiXJN
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd623dfe420so1469976a12.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792928531; x=1793533331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhmTqIVrhZ/NvlRobX5Y+GvIs1MtU8Z4kfjwx8mwLL8=;
        b=TpvUiXJNriwwOkpJktK38zjrXmnZIWyTAL2b6oxnVhFEW3kV0nnOZ6u6FIB7KkO+bU
         zSdSEADvARbfHupOrx4iQLTtbfGPaCSTVmNN74amYLqPxJJIP/ez2Kcf/3JgrUWpfbow
         YCu9VvW4eSvCBbT1jfF+GbzH54MXoqzqMqcKT2BHhWZBwjYCEFr/JZCuoG0KTNCdfm8n
         X/kVyVFIOOrj4QGKCCUSNY/cfYXKwL/ImQmPy4V1w+eLzwGoLJTWSX8iv6qv6nJ/h9bD
         8gaH9Rez9Avi8gyzdHfrPGNXe4GvX4NhtvKlJkhLVe3UNAUPR/T74cPMStbvGTDQWqQH
         k27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792928531; x=1793533331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhmTqIVrhZ/NvlRobX5Y+GvIs1MtU8Z4kfjwx8mwLL8=;
        b=Bs7Rjov21XrVqQxzQL6eL/2vYIP5Zgz4dLpU2j922FCs21PReCMA4fm/AlGmDoEfig
         ux258ZCqVpeLijYG9aFv4xWXLYS7Idsftz7z1brMss4SlbNmqZdNW52CUI9UIF2CcJ09
         hFFOklIsWeR6cDWT2ezbku9r1PmlVdZZTtBrryXoc/9g9AkP9RGYkSPhW5MC/buDuw7Z
         yNuevlgSQIl7x5Pw2pSXlBUGZaS3l3Z4ZoZa/0UXkeOqsaUjcBCmTlxOAyDFTZls1SX/
         CYa0e01ymmOk35jXqTIdMprscZIXyUeQBmFxgVPHKKB38tf72oux2GJnGssQwZKPaROX
         k9ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSSOs9Rmq8aXkzxkkYiTOZBzu4eUClGJkYr/7Uyh6i2jPAFyvGXma/vZ2RFqvplapM4XiTM+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/7Uyur+CIyrHJ2A2lLLuQLTZzREJGkcmM2L05RKAl15EF3i0A
	xkLGYBhFYisZvx07oJd1mmvRBrZutR3Yusw7xl6OF/DD1XuoSZBtKn5I+a0bX3Ntkqw=
X-Gm-Gg: AYBFou1UjZYR8vlhsVAQvS4HfkcWnHQQAvubs2fDGoZWeYpUWBqLQLqxxPvih9vpKF5
	7DhgxrnawaOecoILUc/UQ+P1X3buglEDAY3KhbFgJqTb7Xmih6gKStvH9JktGHWQe6VJArOuapU
	mNg2RdwRhaNYS7oaznFUJVRB+dVyUg6SN3bjGjZwPvFimVCnH7li9RFDwEP/aBKvLxloPBzL2yk
	GpoHeYffoYiM1IhEKTWmu6MgpLqYEz6zqzm0oPjbqTGIXiiMTIz8aIWRl9b0PA0HiYzEGHkW2nL
	QOUbQm4TGuUhfNY7n6n8IhzvaC7ipgWQg782JnEdNcqEDLnrtFCd9IeFWs6sjwIX5iwereeyV6H
	R9+/4oNixNq8rgfkzc1QFoTfJCZT938UWylsmxK/2zE4ngpsKYkUtt9vg4mR4IdcUfBbOm1sXCX
	Rg8X/ZEKvC76hWHD/RiEVzBehPKYbdo8yp+XGaaQ2Iy36/BMUsRDlpnlnQF04yXbjkQnywN00i1
	3VExy97F4Mci3wjqqCqrgfP8zZNb4zucxLFke4F0Xibh0ZeUfX7XeVXfoM+EAqYnhxzaV3P21ac
	FPBgjCy/Z9JMfbZCtxPjnNJJbxm7Jg//QCuyGxE37F4PFjmvfNs7aQAcBfaOwX30
X-Received: by 2002:a17:90b:4ac7:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3adeaae6dfdmr3592234a91.15.1792928531192;
        Sun, 25 Oct 2026 04:42:11 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm5219705a91.2.2026.10.25.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 04:42:10 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 1/2] RDMA/srp: refuse a target that cannot receive an SRP_RSP
Date: Sun, 25 Oct 2026 20:41:54 +0900
Message-ID: <20261025114155.4007867-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
References: <20261025114155.4007867-1-yhlee@isslab.korea.ac.kr>
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

srp_cm_rep_handler() takes max_ti_iu_len straight from the target's
SRP_LOGIN_RSP and srp_alloc_iu_bufs() then sizes every receive IU with it,
so the target alone decides how large the initiator's receive buffers are.
Nothing enforces a lower bound.

The initiator parses a 36 byte header out of those buffers. A target that
reports a smaller max_ti_iu_len gets undersized buffers, and the header
reads in srp_process_rsp() then run past the allocation. A report of zero
is worse, because kzalloc() answers it with ZERO_SIZE_PTR, and on a
transport that maps addresses virtually ib_dma_map_single() returns that
pointer without looking at the length and ib_dma_mapping_error() reports
success, so the buffer reaches srp_recv_done() and the read of the opcode
is already out of bounds.

  BUG: KASAN: slab-out-of-bounds in srp_process_rsp+0x757/0xbe0
  Read of size 4 at addr ffff88800243f120 by task kunit_try_catch/42

  CPU: 0 UID: 0 PID: 42 Comm: kunit_try_catch Tainted: G                 N   7.3.0-13249-gcea86339412a-dirty #2 PREEMPT(lazy)
  Tainted: [N]=TEST
  Call Trace:
   <TASK>
   dump_stack_lvl+0x3f/0x50
   print_report+0xcd/0x620
   ? vprintk_emit+0x21d/0x380
   ? srp_process_rsp+0x757/0xbe0
   kasan_report+0xde/0x110
   ? srp_process_rsp+0x757/0xbe0
   srp_process_rsp+0x757/0xbe0
   srp_oob33_test+0x305/0x700
   ? __pfx_srp_oob33_test+0x10/0x10
   ? __set_cpus_allowed_ptr+0x181/0x240
   ? __pfx_read_tsc+0x10/0x10
   ? ktime_get_ts64+0x192/0x250
   kunit_try_run_case+0x1ca/0x4b0
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? kthread_affine_node+0x24b/0x370
   ? __pfx_kthread_affine_node+0x10/0x10
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36e/0x500
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34d/0x620
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x22/0xdd0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x19/0x30
   </TASK>

  Allocated by task 42:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_noprof+0x179/0x3b0
   srp_alloc_iu.constprop.0+0x69/0x5c0
   srp_cm_rep_handler+0xc2e/0x1bb0
   srp_test_login+0xc8/0x630
   srp_oob33_test+0xaa/0x700
   kunit_try_run_case+0x1ca/0x4b0
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x36e/0x500
   ret_from_fork+0x34d/0x620
   ret_from_fork_asm+0x19/0x30

  The buggy address belongs to the object at ffff88800243f100
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 32 bytes inside of
   allocated 33-byte region [ffff88800243f100, ffff88800243f121)

The KUnit harness that forces this is not part of this patch.

Refuse the login instead. Both the largest messages the initiator parses,
SRP_RSP and SRP_AER_REQ, are 36 bytes, and a target that cannot send one
cannot speak the protocol, so nothing that works today is turned away.

Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 5811f02df9805..a85d28b95306a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2379,6 +2379,13 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
 
 	if (lrsp->opcode == SRP_LOGIN_RSP) {
 		ch->max_ti_iu_len = be32_to_cpu(lrsp->max_ti_iu_len);
+		if (ch->max_ti_iu_len < sizeof(struct srp_rsp)) {
+			shost_printk(KERN_ERR, target->scsi_host, PFX
+				     "Target reported max_ti_iu_len %u, too small for a %zu byte SRP_RSP\n",
+				     ch->max_ti_iu_len, sizeof(struct srp_rsp));
+			ret = -ECONNRESET;
+			goto error;
+		}
 		ch->req_lim       = be32_to_cpu(lrsp->req_lim_delta);
 		ch->use_imm_data  = srp_use_imm_data &&
 			(lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP);
-- 
2.43.0

