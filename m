Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F7426432
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555663; cv=none; b=DMiMj4HQzpZRexwWnwq5lnPi1s6DGeFVlcpK/uo5QznuqnAQl+rim/cw/IDS1hKtojohtnVPfqscekHH9EtpNmg1ZxJBcJKM8Ax9I7biQ6SLeSNf3i17fbQ3gAka+sz0jI6c/8kejsff8ylk3NGCZq27xY+BjT/A44ObdyztO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555663; c=relaxed/simple;
	bh=9bkDgJFd3PiXF21kdLzF7oWhWzPCbt3yohbc00d53II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI9tf3uNNsB6Wq7bYb3D12ILaIrMEcH2vjaLZ94Ywxiy/u7E7/Sw7JYz9y/JDfIiJxj2t7OK5l/X40uF7Lkm9CIKnwBUYRWVo2FR6i3Xbx3A7SDfywE6WhtoWbUfNTeXbyQ1VL2Kh4/R3ZEcPB635xi2VxAzV9cp3MaLg7qHEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbfnd/m6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbfnd/m6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6c4a867cso437062885a.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784555660; x=1785160460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlX0m6vRtBZ9M584YjVjHwMHCvgTV6JNPP74nWUqyEY=;
        b=Pbfnd/m6tbx+CJ3Yh381cA8iZiRvklwZFxJQpsjYqUFV+CyfuQLfuf9297FdtXCRo4
         XJbmCFq4BM60SzVho9wrcER6iyzmT19SBd6hyyJqBIwv5PE8SdRCrgawRffGM8osMnM3
         UOJAafpJ9rhce9zDYQlFc04SmL6rJ8TPGRA+P+aRSVdgYreP3C40LfkQ0YI0O0hpg5wN
         5V3uDBX192lHySrHgHjDK5pCwK/U8QkB9SDvpuI5NI2Px4PQYZ+h+U+gb8pq9qQCHRmx
         B4QkYTxvpmWX4id1oe091qKQjtAstdp6sl6rVlV/DP+jHccrkKRIlaR8sywYd21iHfjA
         0HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555660; x=1785160460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HlX0m6vRtBZ9M584YjVjHwMHCvgTV6JNPP74nWUqyEY=;
        b=l5Q++RZlE8CxK6E+2n6BnyQkIpqs6CYQdnaGMYhnMHCIMNAHhrXhraGjUHFdmlNk1D
         lvtOeMDPJcEHAzYT/+qXW2EvQAyfSUjC7Yx/UesTaER0SguS+bN+FZC5QfPTM0eytGIv
         VX/pd6+uZgxepA3EzyHBz2L0nYMYRbhFnbcs1AS5RXIw9YWslHL3rortckLCfKgTCziD
         xRYpWkek1QIe1Blikr297LrDt7AuZHKj4xFgiEpS6itId9hzS5bQgPAp9zu6aZLHhFSO
         us07fhgGXNCdeRZGJMHf0PFtaQg4wMriHyVEI+PM8hvC+8ACDH+gW0kVEk88v18RTmde
         a99w==
X-Gm-Message-State: AOJu0YyevojN8cbSmSrzmNUtS2d3u2biZUa9QA4E4IYwgBLozducJI5f
	p0EboIPO4OssBy/HHm2TZn2eqXVCtFZ/6S+66YnRT4r3NQKJpzHqIOBcG/q3Eg==
X-Gm-Gg: AfdE7ckv4hGX/Kh7dQ82ulJ4V5zh0wwmMvzvq4jVEJLGMc6ucqnkqRmk/tzcPEbHTyy
	horz9XSkfPFCrE1JFnPoHQLg5CqTAFZJchw45Nw12eNOXwjGujMQ361W78b2+77EWUsiD2Ng6N1
	KS3GttCsR067xngilVbVUhmvDgvSlKR6ynZU8b5iYUeVPLvldEb/lz9eal1dSBovo1ZnJ04F+GZ
	MystQlKXYMeLTGgqiBlEnmH/r13tcVmErBt6dUcEd9HNDfWfD2uwnG6bgMyrpxJnbn0ZLEP21rg
	3iA6/OAE+1Mr+1sWOjMo8birvpanA7yzEvu+ziyPfW5Q4fOI2YT2CZlyN1N+I4DUifemMZ2EIyz
	qzsO4u1Zjpr37H8FjZkoOxp31gIuy7myxZYPlPo3wDT+yJjd4pxvYQzjtz+l07UdCaifQKOTLbo
	FqZPKjXFllbL8M1jhRUdtGDWmV7RxclHo6bMy3dISZBHwCO6h8+MHsrUFacJw=
X-Received: by 2002:a05:620a:288a:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-930b3e4b8a0mr1355871585a.19.1784555659495;
        Mon, 20 Jul 2026 06:54:19 -0700 (PDT)
Received: from localhost.localdomain (syr-227-232.syr.edu. [128.230.227.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm894611885a.35.2026.07.20.06.54.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 06:54:19 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: stable@vger.kernel.org
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.10.y] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path
Date: Mon, 20 Jul 2026 09:54:15 -0400
Message-ID: <20260720135415.11708-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026071925-skimmer-retainer-3785@gregkh>
References: <2026071925-skimmer-retainer-3785@gregkh>
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
[shivam: inlined nvmet_tcp_finish_cmd() at the fix site for 5.10.y]
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index edcc0662c..ba5817006 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1200,7 +1200,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
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

