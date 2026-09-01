Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4D40682C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227287; cv=none; b=igCOTRcAf37tWdP9tOU8yioER6fspnKToKm4CKdh9QZqXi/YiEwe7cTif6LnpssIhxkX7bgEulGGIHp8ztF97i97B6EMpH/HOi+igcMk8KlkPqAqzJoxqpPri+nUdxm7R58+FBgR1e5kTqIwmJpa+tuOueEP0lbFdV+0Em6C59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227287; c=relaxed/simple;
	bh=TbWvao8dNrFArHfsTdzgrvJfMW1810YoV1VL1qPO6hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l82FS2jSS+ZvG7W95mceUQL4+d1MuyJDHcGKMMPGMNw7zJVJLp0qveoW5X8aDfXQEVSUCFBBWpvO49rx1J238CI2hkK2iKmsxgV4Yj018gpzGRAr+/ps2D4/tA4gOw7iUAScJq2UAznIfhzRrPZS9HGMkgZv9KOXC1GF4Y4wFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbjSHPbp; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbjSHPbp"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93906e8a5feso430736285a.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788227255; x=1788832055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fd3UsNyohAVS0Ve8PPWJ3CkWAxlfnYDi5LuYeHbJPWw=;
        b=XbjSHPbpik57C0xJiwDnxcbmvlx3kWOnkNDoFur2nWhNmXIEvSYtIjV8nyGfg8CSBq
         R/ukk7hNywYINZ9ahzqLsdxVUrx9ksraks+EVglsATxvIDiYR12ee67b7G0czLZvvpoJ
         jIUnM1hZGNyeWwLlXnnF4K/uPNxL+N9JUu1FEkZBTW5kcRAMil+8MRVYGEy68FZ5wJOM
         fPX8U73A4UnexqHQ+dYYl5v4jpSqc6jsz2og1ww8eNdxomuUixcm6I91d6/8fLFN7E1m
         fp+Yl+Ey/99To5VpB6c+ZuDvOq/WmNLfKNgSQjZ+G/BNAxWuTvxZfOV0Im20z+7d8Y1P
         tgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788227255; x=1788832055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fd3UsNyohAVS0Ve8PPWJ3CkWAxlfnYDi5LuYeHbJPWw=;
        b=lkM1bFcDfJ2A+EOoK02tM4+1EL0qy4ctkNV2iA8FGb+yPcwQ67cVRM0x1M3EhzHaWE
         jRSniC0uSvhUhSkJMqckfoUI6FPc4duzdIAPb39Kx+ZFcJkgd37vh9anhttX0zmwB0VQ
         LZKnnbjoyIC3CoZkLKxnWFxXLtn7620AYaBo9PEK6nq+KTd0S0wYflamUCBsqvZ6t1kl
         lO57CnDQ2HQY+Ex4eUSwcrM/5VB/lVJeIov7uwnK6NphbzzQZQks9mRo9ZRUWZQyIiM9
         MCKmhYjj7Eejv3zD4Zw37qi7O9j6wTbVnbQuac9pRyrmmtkUN3N63dd/4TDU+IcTZhh9
         zI1w==
X-Forwarded-Encrypted: i=1; AHgh+RqgLRuGSyjopLCNz3hQHT3acSPHf3IlkGOgoSDeNDUWGRWAIuzXwMf3GwOpUCJAjX/fBmX0oso=@vger.kernel.org
X-Gm-Message-State: AFuF++nuPuAGbzma5FstPXU9C6qz5T1PHSP7BDTxUrl6NH43mzjEShbO
	aCKnVV4xzjFkMyP4EH5AqS4uHZUFg6S5KoXsa62kJHC5QGQy7CsPTe7h
X-Gm-Gg: AR+sD10AXd7+jTW+eBH4aAPFcud1WqfDkZuzwaD615/Zf6ADCPLTpQAVU5hurZs+xY5
	cRPTDE2E0K3vipQ8Z1BdJo2RslBDF3wsejixBl4elvCg9u4VHCWVnBUlhZrQqdBk/k8lCwwPsMu
	9TTKEI5QUOrDnBqb61XBgMfPbf1OqDbmkcgjKhgB/K0abgmkxf0QzETREaeC5kK/dD/8uXYicND
	6MfpExN1iOegdqYC+llAl5l10cEccuRoDavgoUH/m0GM/HqoNGMUe5Y4kuONN0q2TW66URQsAh+
	tv8T+45LpRGB8lBm1A286HTSrCvlsGpzPGGSI2uLfLw3+f91nr1u4livEjdv/FzXNHqo8TSH9JJ
	F8H6WZ0y2j+eYC9Jm4mGhbLG8+XX0uu1FQkzG/WKQwr98+4Ma1O7oyHm3st4K7cSASON9LdOlOg
	x52ow840woENKfYlrTt+wtLdpy/9Dubo4GUf/GlECEB241TQbxUxD89AnDcLM4e4ugeEZmnltoE
	P9MHYytL7Ef3RTDuf1+m7R08A==
X-Received: by 2002:a05:620a:460d:b0:937:50b6:4a5b with SMTP id af79cd13be357-939138c25bfmr3464249685a.23.1788227254662;
        Mon, 31 Aug 2026 18:47:34 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170138eesm929831285a.3.2026.08.31.18.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:47:33 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Greg KH <greg@kroah.com>,
	security@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	stable@vger.kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
Date: Mon, 31 Aug 2026 21:47:18 -0400
Message-ID: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With data digest on, a command that has received all its data waits for
the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
teardown even though it still holds the nvmet_req_init() reference. The SQ
percpu_ref never drains, nvmet_sq_destroy() blocks forever in
wait_for_completion(), and the nvmet-wq release worker is stuck.

An unauthenticated host on an allow_any_host subsystem hits this by
negotiating data digest, sending a write's data but not the trailing
digest, and closing the connection. Each leaked command wedges a release
worker; a few stall queue teardown entirely, and with hung_task_panic the
box goes down.

Drop the reference for a command left in RECV_DDGST from
nvmet_tcp_release_queue_work(), before rcv_state is cleared. A command
that failed nvmet_req_init() never took one, so skip it.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Assisted-by: Claude
---
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1640,6 +1640,19 @@
 	nvmet_tcp_restore_socket_callbacks(queue);
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
 	cancel_work_sync(&queue->io_work);
+
+	/*
+	 * A command that has received all of its data and is only waiting
+	 * for the data digest sits in RECV_DDGST: need_data_in() is already
+	 * false, so nvmet_tcp_uninit_data_in_cmds() below skips it, yet it
+	 * still holds the reference from nvmet_req_init(). Drop it here,
+	 * while rcv_state still reflects it, so the SQ percpu_ref can drain
+	 * and nvmet_sq_destroy() can complete. INIT_FAILED took no ref.
+	 */
+	if (queue->rcv_state == NVMET_TCP_RECV_DDGST && queue->cmd &&
+	    !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_req_uninit(&queue->cmd->req);
+
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
-- 
2.34.1
