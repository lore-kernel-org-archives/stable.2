Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549045FFBB
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051127; cv=none; b=q17XOmr5s1hom0u5I+cn8r2SCUDX+5wWJI2wujq5RPTsnMZ3APoMKuctJojMjgagmQ2zDo/+Zssl/kmvNPANerNR7irOuyDyUTG8qtHfwwFxbpidAI590sM53AlVrBgFeyBH+Ve+UdK6xtWuvET//MXx5oRi/1V0YcBcdCtuGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051127; c=relaxed/simple;
	bh=7PttoYG+N72lGp3+n6J9QSHqeN61a9qbM4HiGVTu35A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZ2kPL6FBcCAWQLvmfaYnyr1RzVJpE//pNS9PHjyap27Ddc4f1sFqYhX+i3tGYiKnuHBMDjp3Tz6E3qkS1Dl9J9FEYPrDbezDvVcKj9mNlKDWqdZX1APsyc2d8uQ1U+JZP0Xaw47IbqrqVnxxlodvlSOpVKKUwROkx0tvgaGEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=KYRrE11e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="KYRrE11e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d5cad1a6baso10156465ad.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787051124; x=1787655924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F00tHSyJsJ6CzdE6v/TT1V5MB6XClnKFlQNlIPg7vzw=;
        b=KYRrE11eQZHheIf2C+D+OmCJeSpNybTxWskb5Afe63jK8UW5rPOJdS7srdR0uREgeY
         aQmoFXB3vq3BRZJYggLcp562GZsHIuTBVNtUbzeOKoaRfg3QZgjiaPHs51GRr2VyT8RY
         BeBqhhL3HaWJlDWxKnl+4U7SVAyu4uXPNPP8e73+ipaoYHRsc/06ibFzZUM9Ka0lcTMC
         Ip9orNX2y+8DbVqUSpbO8TXz0N0qu6/wal41rRl37cVeS0LXhp1SrHLQZPawXDgcMQxG
         ASte5BjeBkbsK1MGttIb2ScMpkZRbUevGNswHX5+PpUcu8Zza7XfapoAWEEvtsCLcXZa
         MqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051124; x=1787655924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F00tHSyJsJ6CzdE6v/TT1V5MB6XClnKFlQNlIPg7vzw=;
        b=r4BKWoU3m4jPbkMKaLI3NIRRQp06DuGnv3GmVuBbeC2p6OcKBYADxev9ZbL+ppdcM9
         DbU9/JQavesOtifE/Xs7rOzNMlExhgyKN5h+CpV5aoh8VKE9KUpUml+90unKgLEQ7oK5
         XrYtHJ0T3gqNHoGE472iJU9KqXtE/7t9FSErBpMxKv66UpwCJyFqx0KQW9V8PjO3MchR
         t6Q4MKZJWqPDlFqvpW/gbe35K/8GZUFb2PxHAyU3CU9WNuh/Ov4tSBNG4TDZwAOgj7Z0
         z8N+vlWRaiR4gfcyNeRNpkzG457HXvlPjhosobYYxPL8yU4P910sXmKZShUXhDoUs4rw
         8BrA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ilwmtigJChK3nZDd2MGFB3QLGPc9OwHEumHoznmGgfx7rOSo3LdKS3ggJhtJ4ddSB6zOXY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLXHU12CQlXl9v4BsMeUnuoOqzg8n7p4t4d5nDf/tseeBqAt3
	xZ97NScuBKm1T4nLX9DsLov41RlGurTUZisgtdewmryzIxA+I6NujPXyeYxuzVwIQlc=
X-Gm-Gg: AR+sD12PDyYpvcMCryXJ9UuveW5tEGmj+6VT31Q//PX7M6X7WpURBp3vkQ/g2WL3kuh
	Uuxh/bR/3KZY9PoitBwcFExS9HnbU/JV1LFwIxg5ELVzSE9L8DH4j2WIVZMN94Bn0tgb8Sbnr4/
	+50oTxr3CuQqIS7bgmM6XGE4glZDamClOKik6j5GYHV7hRwEpSVACfGXaW7aH+zrOGr1Nex0W/b
	asrU8slJq92hsYpI8dpY0KMeSNadma21kfsojXXKERhlwQIB2eI2VsX/yxFQovkD+qQgAeNG/dd
	2YmrnVPimaQstmfVOrPpmZEg0Pwk3pGEUGqNy4VcXrxlLW4oAwVDnjRQfJleu+qwIN5gjFj5XWU
	QJDcl/6ZucW3CwaVUt3BYrbIf1tOLj90SJSXXe589aTNnkK5QJVxes4ghfPZTJzCRLapb1iS3wO
	YTXRdL3ovYPDc/NrWFNedoh4VPJIQlgFokFlPyQqcapjGLKK4dckNAHk/8NawSZmJuPVm+
X-Received: by 2002:a17:903:2311:b0:2cf:afe8:b722 with SMTP id d9443c01a7336-2d5c5149013mr98394785ad.11.1787051123928;
        Tue, 18 Aug 2026 04:05:23 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bcf36500sm15298765ad.5.2026.08.18.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:05:23 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
Date: Tue, 18 Aug 2026 20:04:05 +0900
Message-ID: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_tcp_handle_c2h_data() finds the request by command id and checks
that it has a payload, but it does not check that the command asked for
data to be read.  A controller that answers a write command with C2HData
therefore reaches nvme_tcp_recv_data(), where _copy_to_iter() hits
WARN_ON_ONCE(i->data_source) and returns 0.  The receive path turns that
into -EFAULT and resets the controller.

No data is copied, so this is not memory corruption.  What a controller
gets is a kernel warning it can raise at will, which is fatal on a host
booted with panic_on_warn.

The send path already knows the direction - it consults rq_data_dir()
when it builds a command - and nvme_tcp_handle_r2t() checks the length
and the offset of the request it names.  The C2HData path does not check
the direction at all.

Reject a C2HData PDU whose command is not a read.  Rejecting it fails
the command and resets the controller, as the neighbouring check in this
function does; what goes away is the warning.

  [    6.885580] ------------[ cut here ]------------
  [    6.886457] WARNING: lib/iov_iter.c:193 at _copy_to_iter+0x289/0x1330, CPU#0: kworker/0:1H/71
  [    6.888137] CPU: 0 UID: 0 PID: 71 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMETCP-gf5098b6bae76 #1 PREEMPT(lazy) 
  [    6.891165] Workqueue: nvme_tcp_wq nvme_tcp_io_work
  [    6.891875] RIP: 0010:_copy_to_iter+0x289/0x1330
  [    6.903739] Call Trace:
  [    6.904085]  <TASK>
  [    6.909254]  __skb_datagram_iter+0x433/0x820
  [    6.911026]  skb_copy_datagram_iter+0x37/0x120
  [    6.911622]  nvme_tcp_recv_skb+0xa07/0x4320
  [    6.913378]  __tcp_read_sock+0x1ab/0x810
  [    6.915788]  nvme_tcp_try_recv+0x152/0x1e0
  [    6.918222]  nvme_tcp_io_work+0x1e4/0x6c0
  [    6.926906]  </TASK>
  [    6.927226] ---[ end trace 0000000000000000 ]---
  [    6.927878] nvme nvme0: queue 1 failed to copy request 0x71 data
  [    6.928709] nvme nvme0: receive failed:  -14

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Applies on top of "nvme-tcp: do not accept C2HData based on
blk_rq_payload_bytes() alone".

Measured over a user-space target that answers every write with C2HData.
The warning appeared in 5 of 5 runs without this patch and in none of 5
with it, in each of three shapes: a buffered 8 KiB write, a 4 KiB write
carried in the command capsule, and a discard.  In every run the command
ids the target answered matched the ones the kernel named.  A conforming
target is unaffected over 5 runs each way, including writes and a
passthrough read, which rq_data_dir() classifies as a read.

Those runs were on 7.2-rc5 with this patch as the only change.  Repeating
the write, the in-capsule write and the conforming-target arms three
times each on the base this patch applies to - 7.2-rc5 plus that patch
and its predecessor - gave the same counts.

 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 85a87ed6df936..a62d6e48f7190 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -679,6 +679,13 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		return -ENOENT;
 	}
 
+	if (rq_data_dir(rq) != READ) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d tag %#x unexpected data for a write\n",
+			nvme_tcp_queue_id(queue), rq->tag);
+		return -EIO;
+	}
+
 	req = blk_mq_rq_to_pdu(rq);
 	if (!blk_rq_payload_bytes(rq) || !req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
-- 
2.43.0

