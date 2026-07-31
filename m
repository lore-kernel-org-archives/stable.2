Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5F3BA222
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508317; cv=none; b=Lgp4EPu91Jvjux67Z5Gviq7BguUxE37H+alZg2SU0zvj+dA08qcyxn2SxDyQSBEgHo8kyin+8j6q83cBSenzQaYQWHwjIrQ3iWPyXHB/v6ntviLt4sYyiLX3JuJvbBuWSU1PR4Q/ZA7/sfbEoREIaZTvgD4NDaytyHLlPrqXn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508317; c=relaxed/simple;
	bh=itLl7zcIybd1Aend7MtMQIxeEEAZFXYjFN+ceLAlfNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCaTb7XWUtBqacTP1Ms1Ff92Z9UGCTBvRQZsvEpqICS4wTAha3IQpzl0ru62hh4sJw/AVk0GhOdGG0Vo7P7aivkT8dr84qufKk3K/97KDwOenaQCrNWUbZmiG7YHucI0iXhZPxB2T2ybtspTbAIlMbOz2rw4Gubge3P6Om3ReAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=B4EgS0Yi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="B4EgS0Yi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caced6038eso9532185ad.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785508312; x=1786113112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTqF2Y1g9qhorvzshaAVm+gXEaPPh+f9UXW2dSENYhc=;
        b=B4EgS0YioJIioXcu0fvmDUJfOwiEXdCuusjXbJ+23P4tFsE2LL/1DOyrs8vvtJpm+/
         NDhRMjbCuikOzWy06q8AjTdNhdq7tVfiRY5sJ1wsQF34Ya5MxXwQ0/QABt3C/jK5nI6U
         ZZWVH6XAbfC1ADcwUdALpKtv74vjFdnLvu+kE/EySxKkDw6Bdmv7oR1ZHKuz2Gi8U2JD
         mcbu1j5ptdjthYE8cuoNg+0UBgX7cWcKZEw6DZZITVF9z7i/g6eF8AI0s8QQQ+7S87lu
         QszcQVj2hJWQl2ukAb3qpkz8hCqthxFcK/WwLY3QkFgx3e46KwbPDaBrnHmYIqlfMM/V
         9P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508312; x=1786113112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RTqF2Y1g9qhorvzshaAVm+gXEaPPh+f9UXW2dSENYhc=;
        b=U74Fb9dxvoyIyp0EJiE6uowk3QH6sW2qRJMSXtYUtZ9nw+SpGrz0OnQoFYa4RDUZOL
         n0se2BzyoMd1HegfQRhXgCGZnwyq14A3cSvrEJk7o01kezoeUI4gNFzR562FeRsfuT1t
         UtY9UrIkp9s1AZdx9f7dyd3FKlG2sLvu7t0yMGemhi/7DXprKAolxaQojcTNgx1zpm9B
         UmSmVHhq8LnXrYNfDEuNw1fQKVKYRb772J/TG04zlcdt33vLGWtNXFqxP3DK/o1AHGRi
         fLbZcVlCAHQUCRALEHXJx6c8z5+AC+bzQ7bj5ekm43IY8jyaileafBpKF5bszeeOQWRh
         boZw==
X-Forwarded-Encrypted: i=1; AHgh+RpORdjf4dPhCpWpNf4Y8TWRV/voYwLzvZbDyeLzb6CrcBMEzDignL4klG5v/X3iT7fpMS7nguU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQrdLTzwK7Inws4kmFcOPgiOj/vsmajKi92BjqJfcd/pI1X9Z
	DaC9bEYgOfXpLCMIdDlqihpTLh6umfOVlNEw3RbCgR+4NnCM3UjnrbDOt9fhOEnkZsNLldu63oj
	TYFurN3N/9w==
X-Gm-Gg: AR+sD11iaEpYr0XTqMpySXnMWctt5R7ESVA3KwN+dEuTvQUnbqwtIg/SHq+veZ59t1P
	FoVhfGsLMSgGAHaVYvfs+OEG/yKCGLSYLOzhoEqjVRffOS2BZwcl2zblu/QlVe8MZcwxdt8H2yk
	HXbynIlQAz1fBjaST/uES61PMDJ6ZpKM1DxaTkvJBPacJzOfpKR8p2ZrfeiCr44AHKfh6xWobF4
	YIiUiEt4WB60Sytr4/AhINz0aVLb4cr7/EtbO73KTGwpp6R+FTcpltkBrNBFrYTEmtTMB8SDr2D
	M19Mfjc+PX3K1rJK7kAAsH+uom3t4kxS8784WRP0RQTY62/GoYfZTCt+ytjijG4qfYniCXmWq3g
	bFN0H9e58KswrpdzJXf9HYHXwipXoL8MqBDnT4C9CDm5NTnW1QsxZZ/weA6FBJXq4XxYy4O5cvk
	0SltiL7KblKzFNHsS+AKxxe0REjm7nXOxRUdoZ8OU51+ktBMvxvHS3Z1v9C78JRW5le7uf
X-Received: by 2002:a17:903:b50:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d0482ce66dmr16049695ad.2.1785508312279;
        Fri, 31 Jul 2026 07:31:52 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm6203185ad.6.2026.07.31.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:31:51 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
Date: Fri, 31 Jul 2026 23:31:16 +0900
Message-ID: <20260731143116.1870962-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
References: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes
processing") established that blk_rq_payload_bytes() must not be read
without first checking that the request has mappable physical segments,
and changed nvme_tcp_setup_cmd_pdu() to record the result of that rule:

	req->data_len = blk_rq_nr_phys_segments(rq) ?
				blk_rq_payload_bytes(rq) : 0;

That rule was applied to the send path. nvme_tcp_handle_c2h_data()
still reads blk_rq_payload_bytes() on its own.

The two differ for REQ_OP_WRITE_ZEROES, which has no physical segments
but a non-zero blk_rq_bytes(). Setup therefore leaves req->iter
uninitialised while the receive gate lets a C2HData PDU through, and
nvme_tcp_recv_data() copies into whatever req->iter holds. The
driver-private area is zeroed only when the tag set is allocated and
never on tag reuse, so that is whatever the previous command on the
same tag left behind.

Reproduced with a test target that first leaves a residual iterator on
a tag, which is behaviour the preceding patch rejects separately, and
then sends a C2HData for a WRITE_ZEROES command on that same tag:

BUG: KASAN: wild-memory-access in _copy_to_iter+0x642/0x1330
Write of size 512 at addr ffe728c2175dfa81 by task kworker/0:1H/103

CPU: 0 UID: 0 PID: 103 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMETCP-gf5098b6bae76 #1 PREEMPT(lazy)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nvme_tcp_wq nvme_tcp_io_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 kasan_report+0xce/0x100
 ? _copy_to_iter+0x642/0x1330
 kasan_check_range+0x105/0x1b0
 __asan_memcpy+0x3c/0x60
 _copy_to_iter+0x642/0x1330
 ? __pfx_sock_has_perm+0x10/0x10
 ? worker_thread+0x45b/0xd10
 ? __pfx__copy_to_iter+0x10/0x10
 ? _raw_spin_lock_bh+0x83/0xe0
 ? __pfx__raw_spin_lock_bh+0x10/0x10
 __skb_datagram_iter+0xf3/0x820
 ? __pfx_simple_copy_to_iter+0x10/0x10
 ? __asan_memcpy+0x3c/0x60
 ? skb_copy_bits+0x58d/0x830
 skb_copy_datagram_iter+0x37/0x120
 nvme_tcp_recv_skb+0xa07/0x4320
 ? __pfx_nvme_tcp_recv_skb+0x10/0x10
 __tcp_read_sock+0x1ab/0x810
 ? __pfx_nvme_tcp_recv_skb+0x10/0x10
 ? __pfx_lock_sock_nested+0x10/0x10
 ? __pfx___tcp_read_sock+0x10/0x10
 nvme_tcp_try_recv+0x152/0x1e0
 ? __pfx_nvme_tcp_try_recv+0x10/0x10
 ? __pfx_mutex_unlock+0x10/0x10
 nvme_tcp_io_work+0x1e4/0x6c0
 ? __schedule+0x181a/0x49f0
 ? __pfx_nvme_tcp_io_work+0x10/0x10
 process_one_work+0x633/0x1030

Test req->data_len, which is the value the rule already produced. It
subsumes the old test: data_len is zero whenever blk_rq_payload_bytes()
is zero, and additionally zero when there are no physical segments.
nvme_tcp_setup_cmd_pdu() initialises the iterator only when both
req->curr_bio and req->data_len are set, so the gate tests the same two
conditions rather than data_len alone.

Fixes: 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes processing")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e93f015fa785..63a734efc2b6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -668,6 +668,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		struct nvme_tcp_data_pdu *pdu)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
@@ -678,7 +679,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		return -ENOENT;
 	}
 
-	if (!blk_rq_payload_bytes(rq)) {
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-- 
2.43.0

