Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441B376497
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642086; cv=none; b=X3r8SwVZbXIprzcQHLHSIHx5267eO87qS0pW06xdUIghLaE+Eg9upPGU312BJb36ppd8YOFJDPdwUoSZhEBHwE4n/57jFPUo768UCt/JG9BlCAFgEd2oF2qOrbgNmJ9QmIKG3rY9vm+Amp+I2nEPoRCSiZU9P/7UkKBR24Ekjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642086; c=relaxed/simple;
	bh=wPLh+OVKYFa3Pbc40kqD5khKGPXHIVr3LvpI84Ys4Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1/EIvfB3ERnyxmby9+tPyTS1W6B7Vv5bka8nRyu5/vFTZ+2OzgkfQt9S+RSHsdW2k6PchQ7/F77dzerBOC2HE8GmzyLPTiteR6qoMSmRPGzmHw/HVbYMUpqMfp+brANu9o7w7NC2ZZ1bUkhadj5sCmsmTxM7FqttR/CAay7gDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbYO9P3x; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbYO9P3x"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0a81d286so45086281cf.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784642084; x=1785246884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaM2LjqonagYCxuWZNVXds/iTM4pWO1CO5HfSZfFn+8=;
        b=LbYO9P3xROQkL/tEtYmAh0jElpn2u7kDv9GA7Vg5Iur1iSo68UpGh3x9AMLRyGzR3h
         lN2sNtWyeoPYsrfxZcmMTF4ZV4impMpNLvJqkSziVXrXp9fQTwNHx6eNu00T6Ag8mz92
         kLdG7bbBGqjyNHtC5iYjmiZ0nveQjUif2IfKwIL/TlXujlPmov34LFSvHT0x/BHrjUF1
         CNKWBeCxWTfRuqjArwwhvckSyOfDCcXyFr65zQ6IukSOsSaNuzo+L1mkjkou3wVu9aew
         0UUoOtyY0ZrbB3MqxKw6jDpD6gnaexYsz8kT5Fnz8Cmrz++fo8JR9ioGLb2kmFx8hlp8
         WvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642084; x=1785246884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HaM2LjqonagYCxuWZNVXds/iTM4pWO1CO5HfSZfFn+8=;
        b=p21ZIDq1aB/ZCBHQ8fEiwQAaazgJ4WUS7oXrmn7CohYhKZDItuFWcHaE456T0cjdDO
         2Oy/e8wcYkdB6bMYWj2QCOle0C2i8QLbW/5b7n7h9nRan6vYJuOxLorzNBqE/X4g6MKF
         aEdemy+oaGyKBaRprEoNc5oh0M1DmNtoh8j4Z3AJpkpIYSLsBbrkmLAI7JY9Ym9Fp1uF
         45n/DDOu6jq6fHRiV5zfHKvJz3BDyJEqHdtlZimzWTzkbYid7FTVXhHWFvvUyUSvjqtq
         cp5KiJmBPSTAlXBL45+ZRYtpy5rJoRCbcb0RvJsIyqxvYwkK3kc2DxXk7LtIN7LQd66m
         utYA==
X-Gm-Message-State: AOJu0YxaS3Y2zGSq4qviq2GSgYnc5rIRN63m/yyaXlqoFbgfvf7ddLG2
	PNyTi8UM+CwLPhj3FgrT7CGM1a0d0ccUZCaE/qyfg9ZglNlG1humU+VlKyhjng==
X-Gm-Gg: AfdE7cn71iNh1PXLAxZp+mFLqjK5ejRHIJnv2rfZX56N6aDAPGYH6SFM5NPbvrtCrKk
	tZeHWlpDkcKozKcfGBFLHCij7vxh+tWPhhnXMGjeVgt+feGm/CsZC3XA32qe65wcXt6pUdPBP7g
	Fi3Hfb3vp/RG5iNAGS5el3Rt9rQK9oVeExIy7pEP/x8srFSsGcWjer4yB2D1Z1+9HDrO0skVZIg
	58KlZacQJVL77AYYK8smK++ymQBdR+qF14PnScqe3pGah5+6Ar8QZOGKQtlzU9/q0D3JhbieOB4
	1xI/5EnvVd+lSoRcVJJiyJwNukryED3RBfK3g4cphGu1Baf8+2tgBtq7WiZYMo0SZuoYIiJ2gU1
	evR+OErk2dsPl4LOGkoiOqeOa5DKGn1DdaRFSL7ULVslITEpsjc6fwi3FsGxxyw5CWIB586n8iZ
	2GZbwmfcemycdIbkJA0xnWv7AdWLYi2E6kG5zlcxXOwBfnEWZsZfUb7vs+CBlyrp/sIk3zxA==
X-Received: by 2002:a05:622a:5909:b0:516:35fe:5524 with SMTP id d75a77b69052e-51fbeeb3240mr220462471cf.5.1784642083534;
        Tue, 21 Jul 2026 06:54:43 -0700 (PDT)
Received: from localhost.localdomain (syr-195-216.syr.edu. [128.230.195.216])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521502b92acsm101656261cf.30.2026.07.21.06.54.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 06:54:42 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 5.15.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Tue, 21 Jul 2026 09:54:38 -0400
Message-ID: <20260721135438.14435-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260720175500.0017-stable-reply@kernel.org>
References: <20260720175500.0017-stable-reply@kernel.org>
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

