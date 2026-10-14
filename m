Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6E37AA7E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946138; cv=none; b=PrPylHIQTmssT/QALQ1RZAAiGMzymkm55UgE8ieWSuQz1MH5gS5JQ6+cqeeEVUzYqc5bgxDHb4/63aA+FRohuYIHrtZn6przfAM7zfUz0s6lGOrerXJAZR0H0RAfjn5eWdBVGmFStxzKKDoGTDT9u5tfUIOoTwPmFxWSa9+Fpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946138; c=relaxed/simple;
	bh=OXDYFE9XRN8PNuvWXQ3gqGFHj1YcGhHHSnQnQQ+Z/0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIwoeMlH+5tli8yzSfobtngrzpmb4PLyNMgXPJpsXb1a4FlslC6xJPWaGvWAVdc4jI/F8zfl1F8L44PaG8YlMotK3+AzaBme27a03tzg4aIgLV/o+9am0B/3gOif3gGreR3I87MoQpFUl5QBxEOJ8qdnjOHZka/L1kA5AfSsces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=lSsFPJ1S; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="lSsFPJ1S"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35829219da8so554591eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946136; x=1792550936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9C2DQMC0mb4l0SVDeDQHg67THaPbHfyurH3VMACn8VI=;
        b=lSsFPJ1StvqwzIxGYe2R+92V0xQeFgtvzhzl0FoXqYsmOKuDzD8HJupJbjmIG8ZZHG
         a4Ds5OFz4KwB72Bn3DPya5nzWNi71shMOPDjheNSObVVb5Vuo6kt+ZJt9D6uNV0hvvJU
         j+nXP3p+Tsot1AgHBy9Ou91WGsGSVBKxgsUmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946136; x=1792550936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9C2DQMC0mb4l0SVDeDQHg67THaPbHfyurH3VMACn8VI=;
        b=VDp2MNFN+egK14Nt5z6nPA04bvNwDXLdpTJ3jVzXMkit8V2joxPySLRhzSZmUg+TVI
         PKQi/E8Bac4krq29SmBR+4Xrorat6xvzOuZ/zb9h5JjpSxru9bEIgFVW9yhPUHYZyY4p
         vSMN29SqcIKppGouB9KCu+4XS0LsFXhPb6JW/lEpV+COZDffEwGsKdkWBXNSXk9eX2KD
         xd82zgPvmqtOtV8MXtV6U93f9BWgI3ZVCOdzE9Ou6YLBFyXOM1PtqwUBMZ1+79M4+zo5
         yjCTDdbA50zTD3797ZKJhu848rNE6u5tATEqwN8aFKEJtSC/01wYV5wOXIMAcjfxmpSE
         BR6w==
X-Gm-Message-State: AFq9FYLKTadVrJoKWyL1lwS3VWRuZH4Tx6jdCMVYjLdOp+DjBnfOjLjJ
	UQLDcaGXUHnxvpXDsEaK1xkbRMk3fq7185hgLZnMw39Ynasz289laF58NNgk+LI7ixM=
X-Gm-Gg: AYBFou2JljqVQFeO+wdObhvAPewbwIK+hoZKyqULdMc0f5ejLNGus0FkCf+AsKxjFgU
	dzlwY/D68jcQEKROLVWv/FK7Dy4/8309nWMBecv6KjgnJa1kIZpqabCHXRdIl0+ZKBvKQcVqUR4
	m5OCzkPuatsGLgy3PfSwzGzUAWkEJADzXH/514+iLA7eObwp6fvwMYJTFW41fRHzuS85PdNqAwG
	bbx7dxefQnY9WhNkev+afUYPS88N+KiznhZABMVih3hflUZfj/KT8iewzCfPeNjsT6qpozYVqWV
	mzu/65Gnd68X5Tj3vQnACcG48uhlecbjqweP0u+56MUekSdWO/YO8ODy3/9s6PUDjQ88Bp9hscO
	ZOwOnwJCHlRROkoDoyZskMfGya+hx7N0poPXIAp6NohOMXp8+cL+QpoFlXPgrgmvqNYcaA8fHcM
	ml2kljcBC3B8Ai99VN0Sy24yYLo/nRhgCVCBO+gIFF81gLK+U2dF6/6t08uBij02wE/VV8xaBHQ
	hmssyH51MRAfDoajzuKJnvqBYWhsDfdn8wfCpk=
X-Received: by 2002:a05:7300:ea85:b0:359:fb64:11d7 with SMTP id 5a478bee46e88-359fb64144dmr11982172eec.11.1791946136334;
        Tue, 13 Oct 2026 19:48:56 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm46855529eec.30.2026.10.13.19.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:48:55 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH net 1/2] net: usb: pegasus: do not advance rx_skb->data on dropped frames
Date: Wed, 14 Oct 2026 10:48:51 +0800
Message-ID: <20261014024851.23629-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the 0x8513 chip, read_bulk_callback() skips the 2-byte receive
header by advancing pegasus->rx_skb->data in place. This is done before
the pkt_len > PEGASUS_MTU check, and when that check drops the frame
the goon path resubmits the same skb with the advanced rx_skb->data as
the transfer buffer, still PEGASUS_MTU bytes long.

Every frame with an oversized length field therefore moves the receive
buffer two more bytes towards the end of the skb data area. A device
that keeps sending such frames makes the host controller write received
data over skb_shared_info and past the end of the allocation, and the
corrupted skb_shared_info is used when the skb is eventually freed.
With an emulated device sending frames filled with 0x5a on a KASAN
kernel:

  BUG: KASAN: slab-out-of-bounds in dummy_timer+0xade/0x3f00 [dummy_hcd]
  Write of size 1536 at addr ffff888105821202 by task swapper/1/0
  ...
  Oops: general protection fault, probably for non-canonical address 0xeb4b474b4b4b4b4c: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x5a5a5a5a5a5a5a60-0x5a5a5a5a5a5a5a67]
  RIP: 0010:skb_release_data+0x36f/0x800

Only skip the header with skb_reserve() once the frame is going to be
passed up, so the receive buffer always starts at the beginning of the
skb data area. Unlike the old pointer adjustment, skb_reserve() also
moves skb->tail, so the two header bytes now count against the buffer
size: lower the length limit for the 0x8513 accordingly, otherwise a
pkt_len of PEGASUS_MTU - 1 or PEGASUS_MTU would trip skb_over_panic().

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
---
 drivers/net/usb/pegasus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index aba1a640fc26..7c7d6b69998f 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -461,6 +461,7 @@ static void read_bulk_callback(struct urb *urb)
 	u8 *buf = urb->transfer_buffer;
 	int rx_status, count = urb->actual_length;
 	int status = urb->status;
+	int rx_offset = 0;
 	__u16 pkt_len;
 
 	if (!pegasus)
@@ -510,7 +511,7 @@ static void read_bulk_callback(struct urb *urb)
 	if (pegasus->chip == 0x8513) {
 		pkt_len = le32_to_cpu(*(__le32 *)urb->transfer_buffer);
 		pkt_len &= 0x0fff;
-		pegasus->rx_skb->data += 2;
+		rx_offset = 2;
 	} else {
 		pkt_len = buf[count - 3] << 8;
 		pkt_len += buf[count - 4];
@@ -522,13 +523,14 @@ static void read_bulk_callback(struct urb *urb)
 	 * If the packet is unreasonably long, quietly drop it rather than
 	 * kernel panicing by calling skb_put.
 	 */
-	if (pkt_len > PEGASUS_MTU)
+	if (pkt_len > PEGASUS_MTU - rx_offset)
 		goto goon;
 
 	/*
 	 * at this point we are sure pegasus->rx_skb != NULL
 	 * so we go ahead and pass up the packet.
 	 */
+	skb_reserve(pegasus->rx_skb, rx_offset);
 	skb_put(pegasus->rx_skb, pkt_len);
 	pegasus->rx_skb->protocol = eth_type_trans(pegasus->rx_skb, net);
 	netif_rx(pegasus->rx_skb);
-- 
2.43.0

