Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5F31E831
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564171; cv=none; b=oFIHpvLkG2e4ISer2u/xZWK3dZpqJRWZoh7pUHbugJed40nLY/Udw8Svm15ciirK1W/d8N9n/TVHhruC/fCRRxNHxV3R7KR98Ag6ciAaEkYq+fUCojN7S20Pt/tbzAXpNvs53YQryYiNt0xWXHv2zmJyx1kBehR61r4/vcStetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564171; c=relaxed/simple;
	bh=PaCDEADHOiiYIku6VKXBxRoIXbypj+h3AplcGBWcDCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDA7wrk/YzWk7Mt6txfLV9P5Cl4o3ZAnxO0zALdKiaSiNqEwEIUlPP8onwM9//j8V1RDy3tZ/JYF1WoLRhfEPTP3SozclkADomn4sPcFElPVD70r0DP7kKpESeVuOME6uGvpHpqIM3YAql/RffNVPAkbU/XcO3sviIbo7IGI8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=KejZUDYY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="KejZUDYY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1318388a91.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785564169; x=1786168969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FE8ttUnLC4/HPgKY+wP8Klu+NVFl8eobi0/CL9TYD0=;
        b=KejZUDYY6zKiz24zYHyeoV5GALFoptvsBMK7AaC3+lc9u5DKW57n85PkFJIW+eGskA
         N7Hee9mwGr7GpSetlv70++K33aVItNLW9dC/GlyFJa3tygAXsUG6vAUQ5ODz6J2h2yXM
         BD1WmITmF/RPpGqxO+bF7+XVVHNYBKQNAVihkrgECKGX9H/Qrksy4OJrEtN4rYPMaecw
         psVMnHOH5q/hzvZ4M1+cNUSowF8usxmX+QpNSl/VY6XNjuv87z9adlrcEv9V99W7/1DQ
         dCLD7/7QWsybWGrzPTU39NqYct3bXxl7FgcuqR9q5I9tfT8dGS+gay7tYiH62Mi+3sXD
         IGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564169; x=1786168969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/FE8ttUnLC4/HPgKY+wP8Klu+NVFl8eobi0/CL9TYD0=;
        b=KYtiYVJWd2RRXlAsg3VE4S1rz3U/WRQ5mmWBOSz3FZhq/K+HrtN9DZTHLNnmoyQk79
         jc46fio0e8Nad+VcMr30/Eoor+19Dz0rMwAWkxxG3nRt0VwW2sr1LCOuPzVweJeu7omW
         X7j5epg+eQVNK71t62R8iXKYiRuuLvDUidd5Umx0XTt7WHKZ7csfm/I1cPSHS7lhec9S
         hW7U9vMT5AA2pmLxIHLJqLkmZQlhWezpAEdvSyE7EoMV2peNpg0u5l+suCDOP3MhGreT
         0zj/NGdhFVowSeVy4XJa4NuAjxZcPT6YYDEnf96d7n4WWWTVvd8iUDsHfwBuqRMwl+rN
         /jJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpu0W8GjWYQZM6meGlKob/ZloVnUD5qk87f5AP40wvj+SQgQQX7ojwlNHNX8jL4WLvz8r43p8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtpCOMTAVBbe+Bz8yNCN+6CfjVhTyLPgdoF5gbdsBrNr5zWgB
	C7/1ZHK/viizXD8P/YrUKmPSfsruwrL1SVKRpGFClWTsrk4pGbMD5jRsgaLjf+uQDpI=
X-Gm-Gg: AR+sD13RryeP6obsLYu1Jt9ELPmKpSIBMX/qFUAIuBHwmOMDGayG8ZR+iDCVImKYmw0
	Om7ySZMzNncnZDKnQbEqN/B+/HkkKwvGizpFMl+tfqe6V7NEkoeF/72OIi3M0l2cR30ev3mUCO2
	+GVKqhQCUHlqzp4qkg3zjMWHyZB8JJB+JqAYpMFdkQfiVKeZ2KQfQ2Sdn5VdiEtf7Sakh35t0a7
	tGUgSFWrkKuKbgCA/Fbx1BFUZTVWtRvKetqJXSst5vRVUljN5bFg30rgH2/57Qt997EBBjskeEc
	66PrVbeWgxeITpfgAiTzsWFnFs8DLSqNQvh5Mk18zYuu9zdyXIKcHi230AFZNUUS/xbCKDVLfQh
	99uVOBQ6oeNvHF9YLueUnIjuD0XleKVWBRilccHnScqD4v0FVwysnrsNCIghB7GUfdzikXRZptq
	iO37lMnDBAtwAKTUUvJsEec71ZJ0ZTEP3z0HCprn1xvb3UL7h/TDe56X+erKl/d3UBvvOlqBt3b
	L2PMsXC68y9RXk8HcBApN0=
X-Received: by 2002:a17:90b:440d:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-38fbc438399mr2464915a91.14.1785564169033;
        Fri, 31 Jul 2026 23:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bae2efsm1598856a91.11.2026.07.31.23.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:02:48 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
Date: Sat,  1 Aug 2026 15:02:01 +0900
Message-ID: <20260801060201.1879499-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
References: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
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
was left as it was, so nvme_tcp_handle_c2h_data() still reads
blk_rq_payload_bytes() itself.

The two differ for REQ_OP_WRITE_ZEROES, which has no physical segments
but a non-zero blk_rq_bytes(). Setup leaves req->iter untouched while
the receive gate lets a C2HData through, so nvme_tcp_recv_data() copies
into whatever the previous command on that tag left there. The
driver-private area is zeroed when the tag set is allocated and never
again.

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

Test req->data_len instead. It is zero whenever blk_rq_payload_bytes()
is zero, so nothing the old test caught is lost, and it is additionally
zero when there are no physical segments. Setup initialises the
iterator only when both req->curr_bio and req->data_len are set, so the
gate now asks the same two questions.

Fixes: 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes processing")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4b72f555495d..dc2aa9b01f20 100644
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

