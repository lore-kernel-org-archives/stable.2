Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171C3783C6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642331; cv=none; b=iEwrjGICn8YjUquXw1XBqknxei0JbuzOOXl5MrwTXTWiaVFPXoiqCeuMkEGtL1fOM2yvIleYQpcKz+BYcFVZQBNBWOSsPhSWvw5+FTV4pdePFQ5pbtSgURGx7UVfT+GIAo7owrVoIbcukMYXx9xlbknaQesheKkJ2FnMjbibpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642331; c=relaxed/simple;
	bh=ZFaLCPgchIZgXijV5F5+ubnaVi7qnACnLaAG4h2cHAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/BrLBgvoVEEiOq8tluDcSKE7RKKUmviwsgogex6tphCOBBIP8R8E3cVCOkf6kiKA+MHZz8s5223qRfYdXeLliClJzlxKpFjTLGDMLKnqH0VATkttsI4/DsM5n7FIu5erR0Ml0YIoJlt4mcHsn2HwiKkpPwM+qVD2IVrqXFeoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCL40SZy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCL40SZy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bf2479349so104849991cf.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784642329; x=1785247129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bg+kYn9tefUszk0NhzD3FkM735R7nfMPQLXCJ8bN4CA=;
        b=WCL40SZybrA3rjS9GjtDBkzpKbDUgxUt3Qk39df6IfyOecb4uNXmufd5Yw2Qe2xRr9
         YqdX2T01pvrM1nWjjAVe97ufHi/F3K/abqjgkHsMZBtCblVNSAWTxUuitVbB+5f9BKnI
         cfuMENuysgVNxuQzXsCzjxMIJ7JoEnRZ546YBFxKPjBr2Zzd20j1O9skonsjtyz7Mz+j
         2PpwBIq6peNMfeW1ZdK5WEBJZDXiFofIbN1JS91hCQ5yf/07dVK0j3yt1TyfnuFC9b64
         nLbI6SrMe75OtHBSwPdjxkvARgdIPX/gG5PdAsc/MVQpxVnvvqXf5sVmzyqAFjYhSvxg
         +Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642329; x=1785247129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bg+kYn9tefUszk0NhzD3FkM735R7nfMPQLXCJ8bN4CA=;
        b=dECjgn8RqQzZJejEDhJF0wPLh271uO8x0joj2mijl5pgiOU2BsMuxed8KMFh+6u8Pz
         Os6RTM+SF9sLw4hDk3goo8mBma5HRVeQlA4rGFY9KsfuMCMCyT0jcb7Hx9Yo/1sg8Cbg
         wzC/gdPMWmC92ybWmqxQmmmvvvKJOXN8axcD3bkrgTbyovjnadsdYoCrVogjbYMXSJXh
         QBhkmNKGLgzvKWvEY2NV/CYCBHDIBh6cqGtxTyDzgorg/9PgvDtgJbzndFgvOJUYHkNZ
         GHAx1RI3cP0oWEh2CPXg74JkpMqxmIcZrA6S0n/IyJo7+tQNmvbuQFNTVWp3WGoy5yuk
         PWFA==
X-Gm-Message-State: AOJu0Yw+nsNRJt7Tp8r8fDkB42GBAGTK9daxqd2KH1uA6szwXLdO98UE
	80Tho45OKStBYIbbZdQzFHWNb94L/dVspWEoK0jctqy1OedIMuRamTJV4mXevg==
X-Gm-Gg: AfdE7cmC8873/qV9CScSw5BlDVWuln3QCZAcYTyN4XTFgT3YQlCq97jHyqDVNzXkZ6H
	zcwJq+ZeAVbp9uJ2s9GSix4j6Y12bZUfY0nm0Yq75I0oDSl0/0IvZQ2BcY/TCUzqyTM5Uc4SBEz
	R6Ch/57HoagZkqfJIv9nX/k+04K26/fBKZ4SZxPpgd5DSZGRrYN1zowyw3EeYVH+PHvoNhpz+4U
	rPiKdOL4s7qzCH0cPzkoGpLtc8KlFuWzooxOr9qc84ZQ/8JxTBCcZhb4SUYzdHfLl0uQJZS1nBf
	VBm7x86E7hDQOmvcUlxT89MBqkmhLgdQ+yIgJdAyTXuKPnY23Wu0FZR32jKH+5PK/IOCapnDeD0
	guErGre/hXR8dEgUp2gCC3UGZ1RqbymvBH7WMmKyAUiwxutVdEJRERQdZkQP4Yyk9LrlvLXJbwm
	PeXSSqE0ZdNLAlzyOa90WtfpFnbK5+irCovp9NjIdH4KWu3/GLDggP98ShMIY=
X-Received: by 2002:a05:622a:11d5:b0:51c:7b11:41ae with SMTP id d75a77b69052e-5213ed76974mr171106731cf.74.1784642328919;
        Tue, 21 Jul 2026 06:58:48 -0700 (PDT)
Received: from localhost.localdomain (syr-195-216.syr.edu. [128.230.195.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871dec5sm115377626d6.44.2026.07.21.06.58.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 06:58:48 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 5.10.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Tue, 21 Jul 2026 09:58:45 -0400
Message-ID: <20260721135845.16642-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260720175500.0018-stable-reply@kernel.org>
References: <20260720175500.0018-stable-reply@kernel.org>
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
index ba5817006..11e917d02 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1200,8 +1200,10 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
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

