Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1173D891A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556241; cv=none; b=Kw7SpCtj5ML0CL7b2hedMZGHPdaJifsSY7OkCFK43rkoCjpPzelgpg7LlBcZY5AwdnZGkEDzOpDZalG1MXwwTPyqSzqehejU/NeKU/OnINwmgOdDzTAX7udUCZYY8siBiA+NxX90cJF8i+mXDUjablYX/+VOLyck2aZ3BvT7uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556241; c=relaxed/simple;
	bh=wPLh+OVKYFa3Pbc40kqD5khKGPXHIVr3LvpI84Ys4Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6OEi00C/KO5yuD/rB5mCh0F6VTAZvwzCfMtHoXK6cVn0+T6pOxIjh1XQUfPd4lVnkfM1GmySXHYLKfH+56Pus733gZxZ7TQwhSeWeTyGPJa25T3vZ9NLgAupPOZW/B70RelbTpS5RXpor8ZU/7Et6mzONSRZUcOxHJspCdFo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKPmxMgL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKPmxMgL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-920f33347f5so785958885a.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556239; x=1785161039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaM2LjqonagYCxuWZNVXds/iTM4pWO1CO5HfSZfFn+8=;
        b=PKPmxMgLF8b1tUQNIip0ke8ow/3K5YRAtGHsfF3NMxfgMO1YvdE9fCpMeh8Q48lBll
         /DhuHJNgTKxjlvvzFIVDiZbSogZ0mpgo7me/ZwegoV2gLD+cSysnS8mApPDdaiPSXbvn
         YNgt57V3lwYbFYDr5lwAlMFm/XkrmD+C77Sfs/F9oaGSPl9dxzC3ken+/leEfPSSQdUH
         I+qvAACx8rpke1UNmn1trvdguvaMlfok2gaVlG/VAEYDIkZlqGguNHLlV976jEjl1xM0
         kxrArYx62RZm3CaD+igWUCv0lkYCe4bZ8jm8Sb8hS0L2dTTUb6+TyY+xFjDMbp4/ycUi
         vAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556239; x=1785161039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HaM2LjqonagYCxuWZNVXds/iTM4pWO1CO5HfSZfFn+8=;
        b=FLSeq4wRF2wVZQOensAcYsx5WocAzxJPPllX/kUVV28G38rK6WnMDqNJ1yvZcOiAAh
         bj3brx7DvaiKS17zF3nSuHEsu78rfQHxJxldiuRZZXPsYl+6oh8Xq/e+DOciZlQKwCT5
         Oil2bpCP21JIsrEQgcoK16lrbHg8DqE9Tcpr7EJ1T9KmkMuTrVcNYb1JrCpxg07x1WTf
         6InaZ5xG+skesuItxk6sRWuHhe61bEAJ9QfBLjDai4AGJObHpw932IazvLxf3EI36zlL
         NGL/GGMp0bB094k0yKHcACtD4u+puzNB08vNFEA1R589nTeZ7NRSPgsOklD1twf7826I
         Curg==
X-Gm-Message-State: AOJu0Yx5dviS72EsTMcI6M1RIa03pwkQ5RDPfF4hHNU7GlGAiBWf56zw
	wpGLEQoSiaQrYESgcsFQGaTPjydpEDszXfjt1p3Fb+Q9df1Q/Lf0vDzXJeI5pw==
X-Gm-Gg: AfdE7ckXoWijnNpQ7ipUd46D77God0Lo8jPG3p+x+KGXSgEzK5wJaPlGcz1Gh7rv3wB
	AO4lNpsx7uutQbe6YLDJ3D6Yjx1BmFIX00FPuJ28Hh4spLJZJ8EeDtVpDCjYKvw8i85SqGgmUsX
	u3MnYRMX5dcEmT5K6/PGZEEGWFrhHbSsToI/M5AsRtZxfeQq01PYFprKGwP+hMu6ZExVIwcqwFH
	sq3iqMbBUelCs+aE1zU0a9qgL+FI2rla5A6JNRI4wx/ZlN9J9+8MyWTmUG9XlAPRXFQkRVgez7y
	nyaqd+78n5Eiyl5Mz5IzFEU/OtXF3641YkWfxxh7SWIXIy6e437ay1gI16vHCXTPeK0GrGjej0B
	yrVbsBDcTs8O6N1Iuvnb1FUqB/SJptJCDV/gKR7mdZ14KM2jNbiN+QRUE+dDNodg8QnBncMa0iq
	XdPJAs8pQATu0R6Pzb33X6KkR80ZADw6jPnWW3iUam147ilJI79q2RVhwj0g8=
X-Received: by 2002:a05:620a:1b87:b0:92e:5d19:bf82 with SMTP id af79cd13be357-930b3e9bfc3mr1270430285a.17.1784556239084;
        Mon, 20 Jul 2026 07:03:59 -0700 (PDT)
Received: from localhost.localdomain (syr-227-232.syr.edu. [128.230.227.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52faa8fsm891499485a.12.2026.07.20.07.03.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 07:03:58 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: stable@vger.kernel.org
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.15.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Mon, 20 Jul 2026 10:03:54 -0400
Message-ID: <20260720140354.15968-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026071956-wildcard-pacemaker-f337@gregkh>
References: <2026071956-wildcard-pacemaker-f337@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit dbbd07d0a7020b80f6a7028e561908f7b83b3d5a upstream.

Shivam Kumar found via vulnerability testing:
When data digest is enabled on an NVMe/TCP connection and a digest
mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
calls nvmet_req_uninit() - which performs percpu_ref_put() on the
submission queue - but does NOT mark the command as completed. It
does not set cqe->status, does not modify rbytes_done, and does not
clear any flag. When the subsequent fatal error triggers queue
teardown, nvmet_tcp_uninit_data_in_cmds() iterates all commands,
checks nvmet_tcp_need_data_in() for each one, and finds that the
already-uninited command still appears to need data (because
rbytes_done < transfer_len and cqe->status == 0). It therefore calls
nvmet_req_uninit() a second time on the same command - a double
percpu_ref_put against a single percpu_ref_get.

Reported-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a8ff08c81..48e46eb3c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1212,8 +1212,10 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED)) {
+			cmd->req.cqe->status = NVME_SC_CMD_SEQ_ERROR;
 			nvmet_req_uninit(&cmd->req);
+		}
 		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
-- 
2.50.1 (Apple Git-155)

