Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB94DB579
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858718; cv=none; b=GdyqLWZH4ehdUMus/2j8Xr+SEQSj9uCVwJKSSYn9arxpMOFqyp587lQ9soPKYdqS539k3FGIiex/BjVeVGx30VLAE/iR7erUWGL+QZ4kCQhsmt7JRV88F5niz5MDIgEAPOWkRKJkx5rfuqGgmX10Bj383kxiWRAcx4xD77ozB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858718; c=relaxed/simple;
	bh=4TKkYG7mP8psh1SoXRp8laSiK/nXRqfyoc/INVQaNR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qA/W1Q+N97O0U7/BGXYJfKh7nmU/59jRzFwddOojvglMIUG2X2qdXvZBd7EOn//DDT8sFwXx+yAHVWE8lKt1IUFBWjtr2+uOyZT6GynIbVzZXTYYO6+CnDRm8HE4ZAnrRNALvIgJOBUoZBdQsjD/9BbvbHHpt1IMFBy8sM+s8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkBQQj+l; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkBQQj+l"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f0b5ed131so19458085a.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787858708; x=1788463508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBi81DoAME+eWZV4X1kfhpLDp5hpSffQeNzIrftqK00=;
        b=XkBQQj+lup2sEXnieH13q5LnfyP88LyXockMu00FiuxLBFb3LtakE93IvLpHgWL4yY
         BIrS7vAkCNXeehq5Tww9bwOWAb8z7Ge2eLn45NRrlpGuWrdkAkHPJ35ma+pr6WcBf7wd
         co5CSNtZGF6B9h7uAl6TbQ/DjXQ97ihUYOBn5sNQBCPgGClpm7iQRu4h4rzIi8bF8QL6
         MC5BLLl1Zb55mU4AOCZfs1MbClKn9zN3/Tsoo6ykR0V72/gmYVZjL0MTSTJqUqm4MxbZ
         HJmPtIMGuyw6Vii3dbpR6gQ/huOmWKGFY/5LZeaxHOkrfcMn0CkQlewA+AiYUos3JJou
         5y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787858708; x=1788463508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBi81DoAME+eWZV4X1kfhpLDp5hpSffQeNzIrftqK00=;
        b=I5TKLBMzQiPfvLkm1MIMaOo4hcVAhwTVOPuCL7X3k8dOwO5U2ScJ/B3krTT09XW97g
         bAM1kdpmxn4ceNLcIfDYiSou0P71SYAuBCbKkqUON2qzuZajHoAxM9mgjbIJGPdC1fZL
         alFaetkhbimgBnehYwK2R1ywI7zbYZSE62Gc7ulHSSn3ug+csWmUQqMtvDB/+2bIqKQt
         UXH53KN2LXL5hzYLmBsbzzy011NgMxUB/pvaLiAXjL1xTcb3NCJkKhDmjzJ5HGDZvYS4
         MMrjHDluS/mSdVFhcDGWHEoAB+niaEkYVs3cv9SZMB1JhDUZvp//DxMQbZ3rAC7wl/TH
         bK2A==
X-Forwarded-Encrypted: i=1; AHgh+RoCdhhTmDUQ9sXavL2QCKVIou8NFSeQpUqtYEJlEtVskU4dinYsXXJ2dzgrYa543oCfgDK4wtQ=@vger.kernel.org
X-Gm-Message-State: AFuF++npKg7Jak21GtjnnW+xR4xeC/y99nAis0evNPYjEp93Yh90U7AX
	yKAufa8PuKAAUPJRmR/6byBR1WAx09bAIf71PbpuA0UNXhm9hZ9nziAr
X-Gm-Gg: AR+sD12ackGkd6UJT1smT3aza1lOwiYEsuuUI8AXgTvpNjWCGM7omAFNvHNKzxYOWCq
	RnipHZKmjq89zHrBaEFabvAsK1TQiZ9IVpT7JeM3nXSmIM1InceBrekOrl3JwY1Z8cCgx6HkDUa
	1cqtWdYOlR5LHl7y98Wot+NtoGnaomrgxnmWWfD3PwNYobXXC4oMoBHPAZ3/lln0Zak8fuVoBDX
	B2DV015O0i9yCZhB+jFyP+DbsZdBKAtEo9FvU2gsOyBgqicAikN3uT4F6FxCtENbF9HWcLFCxeb
	T01Q33quDAB2MFHRJ7QbVyVGv07IWVmW/cJnW6K+ZPlLPrnsCBpTN3k6DiKEOd6Lmvw0L9Jazd7
	gbEnpDV/24Yrl2UoR5pF/wFKJ9vCWT2FZ31d5QqaXVYt1HMbqbZ0I90Q9wWc0zBnpBSqvPu/wX9
	IVVE8ZCrkm43vemwX0OLAiMyLgEYSoSRnW+HtKZdrRsK+/Eg615c4wbugFF9u1wjRLFPPGe8YsV
	Y3BHLc4ow0BFrJfST6Pqr9cFhenqE2IuaL1
X-Received: by 2002:a05:620a:4707:b0:939:6a:a71e with SMTP id af79cd13be357-939138c0afcmr134402785a.21.1787858708152;
        Thu, 27 Aug 2026 12:25:08 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd7044547sm24043406d6.19.2026.08.27.12.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:25:07 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: reject unsolicited H2CData PDUs
Date: Thu, 27 Aug 2026 15:24:55 -0400
Message-ID: <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082755-stucco-champion-2bb9@gregkh>
References: <2026082755-stucco-champion-2bb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmet_tcp_handle_h2c_data_pdu() accepts an H2CData PDU after only checking
that its TTAG is a valid in-range command index and that the command's
data buffers are mapped. It never checks that the target has actually
solicited that data by sending an R2T for the command.

A remote host can abuse this. It submits a write command that takes the
R2T path and, before the target transmits the R2T, sends an H2CData PDU
for that command's tag. The data completes the command early, and when
the command then fails synchronously (e.g. a length mismatch caught by
nvmet_check_transfer_len()), it is completed a second time. Each
completion calls nvmet_tcp_queue_response(), so the same command is added
to queue->resp_list twice while it is still linked; the second llist_add()
makes the node point to itself (lentry->next == lentry).

nvmet_tcp_process_resp_list() then walks that self-referential node and
adds the command to resp_send_list twice. With CONFIG_DEBUG_LIST this
trips the "list_add double add" check (kernel BUG); without it the loop
never terminates and the nvmet_tcp workqueue wedges (soft-lockup). It is
remotely triggerable and needs no authentication on an allow_any_host
subsystem.

Track whether an R2T has been transmitted for a command and reject an
H2CData PDU that arrives before it. The flag is cleared on command reuse
(nvmet_tcp_get_cmd() zeroes cmd->flags) and stays set across the multiple
H2CData PDUs of a single solicited transfer.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e4f603b2ace7..328b075300a6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -103,6 +103,7 @@ enum nvmet_tcp_recv_state {
 
 enum {
 	NVMET_TCP_F_INIT_FAILED = (1 << 0),
+	NVMET_TCP_F_R2T_SENT	= (1 << 1),
 };
 
 struct nvmet_tcp_cmd {
@@ -776,6 +777,7 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 		return -EAGAIN;
 
 	cmd->queue->snd_cmd = NULL;
+	cmd->flags |= NVMET_TCP_F_R2T_SENT;
 	return 1;
 }
 
@@ -1009,6 +1011,12 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		cmd = &queue->connect;
 	}
 
+	if (unlikely(!(cmd->flags & NVMET_TCP_F_R2T_SENT))) {
+		pr_err("queue %d: unsolicited H2CData (ttag %u)\n",
+		       queue->idx, data->ttag);
+		goto err_proto;
+	}
+
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
 			data->ttag, le32_to_cpu(data->data_offset),
-- 
2.53.0

