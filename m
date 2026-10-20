Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461888;
	b=IMBkefuNlDHsqmNOlkZTLS1sBHICHF2/wRVPff82Ic2howX4lJU01VP4k2DsNvPvzu1i
	 hCGBqs3dlWaFKSa+7CDqTJHH4AtSUxxP3nBX/rrk08ksREorfY7xpRJjmD9SbQH4e8wGQ
	 zd1YcZlUYE2TNCBsifM/31/EnQnNysYk2llj6xRI9Xk6hlxwFjD3Y+0p5g7FZu6WBzj/F
	 akO4ntxxSIdkeBqUrHJu8OzEDdSHap0fTeqneKyhkiw0hagyw5Zb9W5rTvjOhrxA+TI/s
	 fU0aMJLvMbg0PxVEBdg4GHm8CjOm58rcqtCPNGto+QE04XjoV3T3yKPOR2bZuhVRsnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4pqVYn51yKmJj3+J36U8z23M9WpANCwAvq4Bsrx41SY=;
	b=5HX5kQ9KbcM7X32HuYtghztWJyFEQnbo98iuTZ2/2R3SZXxoy5/wCvVO5GGYnVhTZaUW
	 s+EPlzhL/bMYafYsz/n9uZjjV49b9UzMMPloKu9p1voXCAoe1Ezu7/+rEmzZFvB9qZEhb
	 PzkjHD4koP4/6kI8TUhjdymvI9pd3jggxiCJK8NGD9NHzGAIyVo51C4gLQuRb2o8wksxd
	 Hpk3acXFh7rOrCxP6hO8jCd1ZxCay+LLABvcccfUA4Qn/J8/J5/yakYqoYOwqgM/4xYiq
	 c0LQJLehLjZ79U3+rUcKG3y0qjb3URl0Gy2tHvw6Brh43JA+BquUNE9p3ZhAB+K0KKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=FCd+9WKq;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D4606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=FCd+9WKq
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so159725a91.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792461886; x=1793066686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pqVYn51yKmJj3+J36U8z23M9WpANCwAvq4Bsrx41SY=;
        b=FCd+9WKqa7y39CVwTgb8OduD4eca2G9Cwy7Ef+MhOLTpduEcN/x5Us3Bo21kBItazs
         TvcrPVa2ZUfPo5lL2NvP04zyaRp4GK+8BpxfqDHjTMz/ikqAvU2vHv1ygnhHNRyUcj5K
         /Gia2u0o5cEIjvXMRbeyJFwEXZeGg50zpg66Eo1dggUzkO96jiETrJF/yufXiKiafGEy
         a8TAdnMcf4oYmALuKNjnnk1F9egedgIRFh+URtBPeWHDkAL2Oyj2abBP68MX2cBLl/lX
         tDyGBY0rKalguSkjGq1DBrsMZOCpEOBo36Ne5Vzt8FYD/nuJgbDZO7C3yZPSeXTu8EeH
         AEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792461886; x=1793066686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pqVYn51yKmJj3+J36U8z23M9WpANCwAvq4Bsrx41SY=;
        b=jrcUxtFZJqj9VggmI7CuLvq+XyVXBKRvdnRUbPnnYiokyP9+mW0e0NLwJuWjXi602A
         c5Q/6Run31IqY5fv8vxAQmcKBLlAYRbr1TaYqT8BXzBkJSV3dSK+EETTcGpxK7jpvocm
         rPEl/fuT0RbbdnO5jVenIqbDGa+FBpQdnEWghIqOHbLiHrgnnX9V/KSXGi1bQh7oyrGi
         Qr1eesA+33DeGVZhU68qT6/X5MO110IP5HaqlfEf8vj9qXCfmbIMfOc7WoIM4xa6sByK
         IdqL9EVIVj4JqzfQC5LCARNwgZIQrN/6u+M/UhBm7K9tkujsXB4hbIxoaym6wxjBI3Rn
         Lwcg==
X-Forwarded-Encrypted: i=1; AKwUvBzfka3eCrjxo4o55YQZHZywD7RduQaOSjQuB2Chj73gia9DTRf7SPsiQkR7Deo52Wr7LarSB4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1Xu09IQjIKC2EptViPsjCF9kNLc9AuXZ7zyBl6FEuC6jUToDe
	pT+4XFVgzZIJV3gAGWfIPhVrYFIeIk/OoEWTQ+Tuz8tOERX7KByLTMQ/21cS9sh6V10=
X-Gm-Gg: AYBFou38SZb9tLn9trfEOfiEUEDWnxc5e7gNGMBw/qcVUUg78r7BhfApXnl1fclncQ0
	fjfB7FAfCkuBT32LwLeAur1bs4y5BgqIJGOqFoAk8lJ8lrxGcZ88sJbif+l+tFCWsCRjHVpWw/9
	ZTz87mNciECEgcRfipja/a6lvmnYJUx4ATGVVUkM9OFc9hYjmiL9AR/vlnzz8kbKZ2A0831Rymu
	oFRRjOD6lQss0ejAmIDAgmyR2D/Xuth9fW6Y1T2DbIW3eko/5KRetJ9N2Z8IOy6dzT3sBNI/X95
	VWJqhoPwVv04NYwWQd6caHUkuXLBy0daiHijpx+KjhaBPTWleDX2Wzd96jDSVRyjsQNcrx+7lZw
	SKtosVa0IWt5oqrOZHy2IBSW0kdC3WuQNTji38tUHxyRzHmkceSbld84fB1csMka+e+ZdHR404k
	2kuH4bM0mCNB5/L1p1EIr96rkUegMeCES4167Y6eL6wskMNjE8Xg/UV9MCjgu/KkYULHURzd0xE
	COYiv4GI+P1kgTH
X-Received: by 2002:a17:90b:4407:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ad64bcc0d6mr488784a91.28.1792461886438;
        Mon, 19 Oct 2026 19:04:46 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d564327sm1815184a91.8.2026.10.19.19.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 19:04:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: skashyap@marvell.com,
	jhasan@marvell.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] scsi: bnx2fc: drop unsolicited frames shorter than an FC header
Date: Tue, 20 Oct 2026 11:04:33 +0900
Message-ID: <20261020020433.1119739-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

bnx2fc_process_l2_frame_compl() works out the payload size of an
unsolicited frame by subtracting the FC header from the length it was
handed:

	payload_len = frame_len - sizeof(struct fc_frame_header);

	fp = fc_frame_alloc(lport, payload_len);
	if (!fp) {

On the unsolicited completion path that length comes from the chip.
bnx2fc_process_unsol_compl() takes it out of the work queue entry with
FCOE_UNSOLICITED_CQE_PKT_LEN, a twelve bit field, and nothing requires it
to be at least an FC header.  Below that the subtraction underflows and
payload_len ends up close to 4 GiB.

fc_frame_alloc() does not refuse that.  When payload_len is not a multiple
of four it goes by way of fc_frame_alloc_fill(), which hands payload_len +
fill to _fc_frame_alloc(), where alloc_skb_fclone() and skb_put() both take
an unsigned int and quietly truncate it.  The allocation then succeeds at a
few dozen bytes while payload_len is still 0xffffffff, and the

	memset((char *) fr_hdr(fp) + payload_len, 0, fill);

that follows writes a byte roughly 4 GiB past the frame.  A frame_len of 23
is enough.  The harness below is a KUnit test that is not part of this
patch; it calls the real function with the frame buffer kmalloc()ed at the
length under test, and fc_frame_alloc_fill() and
bnx2fc_process_l2_frame_compl() are the two frames above memset_orig in the
trace, with payload_len still in RBX:

  RIP: 0033:memset_orig+0x81/0xaf
  RSP: 0000000062893df8  EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000001628a779f
  RBP: 0000000062896e00 R08: 0000000000000001 R09: 0000000000000007
  R10: 00000001628a779f R11: 0000000000000004 R12: 0000000000000001
  R13: 00000000628b4000 R14: 0000000062887200 R15: 000000006272ba00
  Kernel panic - not syncing: Segfault with no mm

A length below the header that is a multiple of four does not panic, but it
is not handled either.  _fc_frame_alloc() truncates the same way, the frame
comes back with an fr_len() of four, and fc_frame_header_get() trips its
WARN_ON() in fc_frame.h before the handler copies anything into it.  A
frame_len of 20 produces that warning.

Nothing here needs an upper bound.  The unsolicited path sizes the buffer
it passes down from frame_len itself, rounded up to whole RQ entries, and
bnx2fc_get_next_rqe() refuses a run that would wrap the ring, so the buffer
always holds at least frame_len bytes.  Only the lower end is unchecked.

Drop such a frame.  The other caller, the one in bnx2fc_l2_els_compl(),
builds frame_len as sizeof(*fc_hdr) + resp_len and so can never be short,
which leaves the check a no-op there.

With it in place the panic and the warning both go, while a frame carrying
an ELS request and one at an ordinary size are still allocated, copied and
passed on.

Fixes: 853e2bd2103a ("[SCSI] bnx2fc: Broadcom FCoE offload driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index a5ecb87d5b2d7..fc6396ed00f62 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -570,6 +570,14 @@ void bnx2fc_process_l2_frame_compl(struct bnx2fc_rport *tgt,
 	BNX2FC_TGT_DBG(tgt, "l2_frame_compl l2_oxid = 0x%x, frame_len = %d\n",
 		l2_oxid, frame_len);
 
+	/* Anything shorter underflows the subtraction below. */
+	if (frame_len < sizeof(struct fc_frame_header)) {
+		BNX2FC_TGT_DBG(tgt, "dropping short frame, frame_len = %d\n",
+			       frame_len);
+		kfree(unsol_els);
+		return;
+	}
+
 	payload_len = frame_len - sizeof(struct fc_frame_header);
 
 	fp = fc_frame_alloc(lport, payload_len);

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

