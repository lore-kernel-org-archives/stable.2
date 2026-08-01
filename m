Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7AA364045
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572326; cv=none; b=VTi87RhpMZgAl+j1CgflLpRd82VpT5LJIYL1WxMvW3CkQA+CVxUGGYaQ/4Dtb7J79iudg6chvxzEKnQpQUT4aB+xGas+QQJdQm48L2TswlqtZZOD2Vn+c6zpLNHHGyYPX6VWC8NYj2jBrE9g1AgiWUtCOHhG10IARUwPUerAGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572326; c=relaxed/simple;
	bh=b/eFGy+WGnEH6RkGlTWexGaLp97r9zOzyhM5fVs9sfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MccQFllbvYe09Q4Y5t38xWUzmkPFPCF4To15Lrnh4Ih5uBfHcH1jMM6kzdi/cxaHits3zfbs4pJQR3maFOf7cqXtMG7L+OM/PwnyhTDuqG5Dh2K3veX0S/g9dhj6o08XxasqR3MKAAnrPgAjt6PZ6/52riGwkdqGNXTlzS7J/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=nykbev1f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="nykbev1f"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84830c774a0so1814547b3a.1
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785572324; x=1786177124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1lwZlW3FZpQI3GTqv3UD9QOcWZj0C5mMeHQ3vQ2kJj0=;
        b=nykbev1fXB9HmQP87uaCOtdBOYObWHB/fn06JteiIAs2FMN5NclYYo7t1zRZx6nvv+
         XRgkG2N5M+Rd7mhK+jNG5PrB05rmKEu+KU+0kt99ozpbtv8pbVf2g4nJtq3QZ2h60x7K
         19xZdhRfOjLrznJSG0fgpYkIoD9o9ex6PzhSO0XK6ZxPWO7hiJgcGNbmXuWaIb6vz8VD
         IyCOKSK8KOgpqEbntrCrchBDAnGmsxaZgBNCHVevOqz/UFsMkLQ5VnGmoWy6GeNKtD4T
         5zri0e/0am04Z0LkWZR7UhaBURQGDBKNYzPntcL5SSSyIwoyHEL/OgT64kvic03bxESG
         ipaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572324; x=1786177124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1lwZlW3FZpQI3GTqv3UD9QOcWZj0C5mMeHQ3vQ2kJj0=;
        b=V39mAsOqFqNxOHG6PuAdvURpffgpstXL8EpuUWXif65q0MfD45vz+8pIpHOCmZ0TCH
         BD6hMcw0PjpW3rGMKUenpnA9KNswSNs3H5x7a7CovmapJ+bEjZ2JYe6JDigO1K2STc2n
         WmWevjoCoZU/DaVkavJVp5o91s5l6lpjLge9+wvjCapEJZTM0fBiaBDW8mbREs0BGFzY
         kt2FnzecXbCxMjp1O7yRtwJe7ql1f5ZAWaUDD7gj4lsiAjYLgZKcskOsBWtrZfoBG5oW
         dVoB7ekqH1DoCtXvG8ZN6nf9Rc0s6IFX4P4Nk3TeoUmEn+748U+CpZf+SvV97CvmGl3P
         Sw0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpUC82qz9av7AT5aFvR97lZdHg0N/9KQ/VyJSB8scz77z8D/ddwtICDcDkIiv1Q4rE8y1ptq+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7ekpM0VVWc8hzziN2AS4rGmOrsmruWu03GZAzoN2kSWFj64N
	uo0YqZSJ6x3Ye0Yp9ftW48vDhmneJsh8B0vB5Zs61njST4N8t9ytG0m5VJ4N5089I7c=
X-Gm-Gg: AR+sD10VOtxtpzSywSWU4/9kOOqCwUmDk0CYtBZCzhQbdjmRWgVruTlZT628YDddRjk
	7wS6yZ0DbkJqK9WoC1Pni5Pbiw6Yvb8sffnL1MQ4afN7VOHgUYqAVbS/oZMh6G8EOPG+AqyJw0i
	GEDPuOlgFdf62YiFq3BYdT/x8XuEdvrIQf7mVGDkYZotZGwYwpx/YVhk5GLEFEniTC88C7jbefS
	y1cV3hYXstea70E52MuebalJ6x6AdOiepuf+0RPdNwqOvXVXw80xfqRzz7j03IvXOS6/0PV3Jew
	o8EPFcQ17RZwVV43OECevlA3Tm57EIPDAyqdaq70FgrPn+0MShvheUyR95h6jTL+YpDKleY3DrX
	9NGkwCMPZMF7cxq/ENsLyKRUXyELEoYKDeTEqk83hhl8aKVvJmDN81NCJanYd+9HUrfWJYG3N6e
	aCvv5YfVZ4sAQv6DakLNwTNT8zMbaN9aeQQF+OXPF5joimQ4Ps5sI5MW6re9LJ+ZbxV8+Puo2Bw
	bX1HX+IGXs=
X-Received: by 2002:a05:6300:14d:b0:3c6:3c5b:f301 with SMTP id adf61e73a8af0-3c92a9519f2mr2907018637.68.1785572323922;
        Sat, 01 Aug 2026 01:18:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea9a40sm1433003a12.25.2026.08.01.01.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:18:43 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
Date: Sat,  1 Aug 2026 17:18:18 +0900
Message-ID: <20260801081818.1884199-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
References: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes
processing") established that blk_rq_payload_bytes() must not be read
without first checking blk_rq_nr_phys_segments(), and recorded the
result in nvme_tcp_setup_cmd_pdu() as req->data_len. The receive side
was left as it was.

The two differ for REQ_OP_WRITE_ZEROES, which has no physical segments
but a non-zero blk_rq_bytes(), so setup leaves req->iter untouched
while the receive gate lets a C2HData through and nvme_tcp_recv_data()
copies into whatever the previous command on that tag left there. The
driver-private area is zeroed only when the tag set is allocated.

Reproduced with a test target that leaves a residual iterator on a tag
and then sends a C2HData for a WRITE_ZEROES command on the same tag:

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

Keep the blk_rq_payload_bytes() test and add req->data_len to it. The
old test is what rejects a C2HData naming a tag that is no longer in
flight, because blk_update_request() zeroes rq->__data_len on
completion; req->data_len and req->curr_bio are driver-private and
survive completion, so they cannot stand in for it. Setup initialises
the iterator only when both req->curr_bio and req->data_len are set, so
the gate now tests the same two.

Fixes: 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes processing")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2 -> v3: keep the blk_rq_payload_bytes() test and add to it; v2 replaced it
and lost the rejection of a C2HData naming a tag that is no longer in flight.

 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c4fe06d424d1..85a87ed6df93 100644
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
+	if (!blk_rq_payload_bytes(rq) || !req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-- 
2.43.0

