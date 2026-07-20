Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12808426D07
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555166; cv=none; b=B6IyfGBw74zci8ceu4eXxssrYoPg7XMybzgKFmy8FCzXDFVPrOOeACMIByOOBbRJqppm4h5ChmVTUU3bDxjiVRXFJSM7mLy66yE4DN8RWR/ay7lt1rJCllaCkZOg/yp7shG2kQwiq+Vw1q08+Yn/Zy0U1kEnpQGICu0s/TmBWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555166; c=relaxed/simple;
	bh=czziLea7pNVvxUH95KlEbIqelxC2PJAX8pcN6TqZb1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsUK/m8zyFspbgvGLUdcJd+Wn+yDimBUBrpdgLaBPFgJD3jwGhLK3Ogaf8Tl0ipeOAM8IU0kkypwMD0RjlTfdDFnCq2EUYxnf5u166v0yKkNF+xGzEmlAJARtvgj5sgaDrtHY1TBJC9DdquzPKdczV7apt4kFxO2+rH8d+fp7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F02sfq3f; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F02sfq3f"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e69a2db34so51817607b3.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784555164; x=1785159964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjPKp5sWbIJn+2cXANxLIXzwURSfFtQmXK0gsZVX5i0=;
        b=F02sfq3fQWcOFzyNUwmNyng6YXtiXJYS9lmnGWDZsRiSw9Ch8JOQx810OZaOBLDzFt
         UvxWQAevDZEg4k5F7T8h7l/KCUF+vAjdmjJB7KOM9v8dhe5dXz1lBWl9fcdGsuLaRbXb
         wjXs+zYK+bNf5ynzeY5oQdjZ+6si7cuHXIbWpGzlAJ0ZcAArO4+FEkB7IIXPx7IZloFe
         s7TCfKjryJpoGTTx78MbpTl2tm1POcG4DngbcBDxJoIELa4V3sIqDzTiujwgLpx+Bx1Q
         k3o5RUbx94bCiywbuiYubXFcOOFc8Hqfgnzu4pLXPspv0CfhP7QceGYEYPKx2OUlkJdB
         DYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555164; x=1785159964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qjPKp5sWbIJn+2cXANxLIXzwURSfFtQmXK0gsZVX5i0=;
        b=QvcTYSo41dHjGL0qiMnnpzaUCWZCVTSPQgD6iKcxMFMH1rnDxP52KGVLRvl4pMiRRY
         l2MzzMCk4YiDimubmmoDtu1K2jEwOz8o3olc6Z2wfDSSbJiVeJsd37kBMMgUcwYKT3JN
         VvBLSMubeo7/rr1J+z4MempgonDg+oLV4gsKLaXBTuzw/XaCLI3XVzpW5gv8kFVW3Zle
         I65aX4i9wEbiZ72aWwjnCSYKAkYo1xAJgU3nxObZnqaNoKZ9gd2tXVxx8VJkwJD9eeK0
         Q6ltZrSknGNmeGUdDCF8p44CdB7KE90uFNYBbKEK0+ArMmNh3Jy6BLfz+pDtm6D5gJOv
         2kFQ==
X-Gm-Message-State: AOJu0Yw7wTN6zVnNsckFO6M3UuPvNNW9cFSzQA5TvzV66JJ//MoUp/sp
	ucKGRpe9DCBjof11I8m4RNX7CGiQG2x6nZZOFtqsk1fasBY4H4JG/xOVhlDIhw==
X-Gm-Gg: AR+sD13x6i5pTRHD3hAIeXnnWUVucHcSLL3mSSiq8DdF+6kw8NnuHjCYSclJ8pdZkFF
	Y7ZQgytiq3MqTbzVFHGNREOSmUNtUU9WrSqyktrr3zzgHMsp+30344n0kkFaYA1r1NLiVUUYcmi
	aBVhW3NQfDA3B/kK2sO6YDqV2wCEn1Yb0ViEOVy7x3g2i5u8uWcOraj04y0xIbA8tpMmRKOiiKP
	t2ZbGLgtvqLrXE083MJi7+BLnbZdbcx16+N8i+iHVYsyKgDU/KNik3mAuzPDExY0JJVa/hX+mUT
	ffSJDmqQicou1nob+Np8/TlgPZvNhKMSTjB1SmF4kdbEoghGw/HHNz25/ThHIjx0SaGpbs6ULmN
	op1Evwv1f8fUrWMv/QQvZoWIP30RtfJwFx3d27qBRvjyqexi+tMk6gtWNoPSki76MzPuglhl/M5
	feir5JBllwgOMdmLE6/ZD3jKnv7COjTF8Tj895JSLEVp4kj3596HtwtcXILUoy9hxEhn+93Q==
X-Received: by 2002:a05:690c:9b09:b0:815:bc6a:2e48 with SMTP id 00721157ae682-81ef2736986mr46071527b3.14.1784555163592;
        Mon, 20 Jul 2026 06:46:03 -0700 (PDT)
Received: from localhost.localdomain (syr-227-232.syr.edu. [128.230.227.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786acb67sm92087826d6.32.2026.07.20.06.46.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 06:46:03 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: stable@vger.kernel.org
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.15.y] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path
Date: Mon, 20 Jul 2026 09:45:50 -0400
Message-ID: <20260720134550.7632-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026071923-dehydrate-bubble-9f0f@gregkh>
References: <2026071923-dehydrate-bubble-9f0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4606467a75cfc16721937272ed29462a750b60c8 upstream.

In nvmet_tcp_try_recv_ddgst(), when a data digest mismatch is detected,
nvmet_req_uninit() is called unconditionally. However, if the command
arrived via the nvmet_tcp_handle_req_failure() path, nvmet_req_init()
had returned false and percpu_ref_tryget_live() was never executed. The
unconditional percpu_ref_put() inside nvmet_req_uninit() then causes a
refcount underflow, leading to a WARNING in
percpu_ref_switch_to_atomic_rcu, a use-after-free diagnostic, and
eventually a permanent workqueue deadlock.

Check cmd->flags & NVMET_TCP_F_INIT_FAILED before calling
nvmet_req_uninit(), matching the existing pattern in
nvmet_tcp_execute_request().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[shivam: inlined nvmet_tcp_finish_cmd() at the fix site for 5.15.y]
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 29ed707e7..a8ff08c81 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1212,7 +1212,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		nvmet_tcp_finish_cmd(cmd);
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_req_uninit(&cmd->req);
+		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
-- 
2.50.1 (Apple Git-155)

