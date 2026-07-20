Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A741BA6A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556474; cv=none; b=suEHMdXhOWVw0Ew8uoPzxD8wUSe9xUH/AoojxI1csw4ECmcbIXwZMJkxEdyYGABmp3mVAha55B5O6CXZf+ez4rd8L/9VAA2zKfQUW8L9sk9/YSsGcDybhn5XYYcZSgbIkS4azjl44og/fIIEVzlq42dVED0mGXPbI47O6qi25pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556474; c=relaxed/simple;
	bh=ZFaLCPgchIZgXijV5F5+ubnaVi7qnACnLaAG4h2cHAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwqYubm0U8gzAD0JVxgkYSAeUvv9u5IV8pK6FAfa3IlqHFgV/fR/+Es081GMv4x9DyYNt2oF81bPBz1skTot7MToXbd/DMeYYtDMnyjivcsNhuAnWYH+8YgVXijkr7DOS3XtjoQMng3SGPZ4E8oe7/14lADxw2lYokDJouFRT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1ovKhLn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1ovKhLn"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfad59921so88841581cf.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556472; x=1785161272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bg+kYn9tefUszk0NhzD3FkM735R7nfMPQLXCJ8bN4CA=;
        b=j1ovKhLnZ7Ldjdncc0RW4UZj4dEQtluX31mIhXOOYBzlbLXXYstwwUlPercVEhGiQp
         a8wtEUQaBcEpoXRjB+DEWa9YKHcrF98VbGIujk8V2j8p4lKWfgWAg1wFrCH6ZULxkSKM
         5RVw7MHoFAvLGTWPR0k0ZyIki3sbKza+t9x/ppXxY3I3kiP6mSq/ZbL9QuLUVEGxZ/6Z
         nU1eyDs9Y3R8+vhKrR4nMkkUtRaYGfpqQDLaeICG3bCC1Esp2Xp9x2XSghWW2ZKHYi2x
         LeuqAomgXRLcL/OH98EClyOtCyS/92HSdroRObkhuihW4MKSz0o5ASkhBw25I6euRth0
         3mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556472; x=1785161272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bg+kYn9tefUszk0NhzD3FkM735R7nfMPQLXCJ8bN4CA=;
        b=aiiZVygehrcosnG6GQuRxSd+nZ4AuuGOWeWX3M4gH85Ovgz/ifHvaVn8kezn7atl6M
         WFKrAaJu19+jSR8IcMcNRAGXLz7AezINmrrZ3YK4DU7jlUEiWlE104yG0BOuvNgoAlbX
         b5xcRxPJa6GbAKHVNtYPyUs2gqZE0VOScxifRpNzcKjbDuyifxNLTGbR8bXiYmI4GroM
         fFkyBb1bAv6dO4ttAXSw+RHqnUIJrX4H8jgpR6531ND73QHNCfda8+6UCYJkPSKuWXjm
         nJ9+OYudIrjYsUS6/kh4MlDD0UAKp5vAhf7rIVpG1j8XcKARnMORNR9l2L7YovmyXwlI
         jylA==
X-Gm-Message-State: AOJu0YxDZlZBuJbkK4zrKS72W8m95TfSz8wxmKlYkagv7MS2TpX4nfw0
	d0amTWcqtuYwnYpTLyY0c1jfPyv4NfAA6MebToXjXmsAmWQA2Z8pdvvqVMmrZg==
X-Gm-Gg: AfdE7cmGsXIOw0QEfs2DVXHPxwKnmiJlI8Kferz3e9S31hnUIXRzZ75qje5xj/IZ2CK
	oQpEnA+fhBgGUCbhoSWSnauvO8ky2pgWhHIyMJJ5sAR10GymkcQTt/MCebmi7zg+eGygnwscvU/
	vtNEPjA3bv7H8gJLnEn+7NhDCVesQM9U4tRcf6PeErqORvqKqYJkBBKNECGm/NzAIhoCQjLbsTG
	HAMYjH0+iOPCewFam/XAVRafUYCWn3T+SQEN7Jmma8LOy9ZHbWNMh7zK3Ts58uzcNOK2fFIj+5Y
	67TDPkI+7Dbkvr8KTSdtGvf5fUPGE/Se9gsbhN29POFC0LC69c/Wti8cvkNdCnZeXqGs6wP4Onf
	sCWkpSSJj4CWu6h4dcQa5gw/nqj079/VGB7cYj64mTcRyhBCqOGF77LIt/KX8RVFR03NhXOyTrj
	eFQnm5vU5F9REeennxCZ74h+/BAq6tAkGgou/GNAzgaOOu5LWa40qGCd6UqZ0=
X-Received: by 2002:a05:622a:5c17:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-5213c00ad66mr131704351cf.5.1784556471504;
        Mon, 20 Jul 2026 07:07:51 -0700 (PDT)
Received: from localhost.localdomain (syr-227-232.syr.edu. [128.230.227.232])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214c5cd3dbsm76711691cf.5.2026.07.20.07.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 07:07:51 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: stable@vger.kernel.org
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.10.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Mon, 20 Jul 2026 10:07:48 -0400
Message-ID: <20260720140748.17471-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026071900-poster-swear-030a@gregkh>
References: <2026071900-poster-swear-030a@gregkh>
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

