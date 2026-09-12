Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D237C0E2
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789191578; cv=none; b=W1E5EWGDObzBSB0XRRxKXFn8iIAUSYwVaFyRo9kujYPOiUFnmZ1cTALJK5YY4nWkEtlOAwUaI7u4ryWf2suVP/ZxOp+5NQKkc2X1/mqORUQc7lDl2LxITegDsf5YLhratgVKZKOS9Xv0v43iQMEVaBGXebe8EdDySdWZqqEofQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789191578; c=relaxed/simple;
	bh=V9+Wek3JYur97ZhIPpkT85Lp4D1DQ4ZZg1gbh7CpQcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP38991xU+3nNEckKrT6rPNCkqCxZJVHQ0aXsENTW2OKJ4bK8ncj4WbSwjfP5G0Qoc91xwLCnuNvPxXwqJcsFFp+6E4R3jDAdRTFUHJVy9mhJNJelLlwW1t5aKP/G2dKMFbfCo9NOL7U8FIuLwCOLggJpqTe4MfgzgAgLbxhvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM/pc/qk; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM/pc/qk"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso8477596d6.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789191575; x=1789796375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qckB9LNa3JhbaBuwM5JiRvIMbAmzkycMcDwtsjXKuIQ=;
        b=VM/pc/qkprO5HoZ3Donqn3VKqoFFIQ9oxg9floWq4sTd5/1s8vfTel9SKWs5wSDuK5
         QV2FBr8zylG2mb0MLtvRsXeo09OwLn97Nya/eLSOzoi9be4nJoYMFrX4UtR2/Lee/klc
         zuKZ2LE4b0tSwUmZhktKIYN+FMvj5Fu79aM2+i3/1sJeDVwFAO+1DuTOd9npc5FZ6o0U
         VnPaN1/FYBGmtwP5VG6xUGFuoPxPKme0fao5Qs8dJjxF3I9v5mNAjWbwN5sUGqaHOw+2
         aEdPZRrPCMdjP81OkAI2/ACuSM6jwHn4l0E7Cyv1IXbxSlk1vkZYehG9khU6nF0cam0r
         CqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789191575; x=1789796375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qckB9LNa3JhbaBuwM5JiRvIMbAmzkycMcDwtsjXKuIQ=;
        b=NWWmRhnoT50ONZDVpSYCLwe7z335pgNvrOfaQeH9JS6YjYgMvhmJF9gvoiaINFT0AN
         SOkC8LVH9LSiiImdprsA9MtK4w/lpyBo/o/okJta1c9VL1pvDaTj+lwC8GMtNWUdhueb
         4o0adDe0q0f/7IXNtdKDbjW4gUq7a3euZ4v82+920fJjZhNi1clCkdTsMWIHgNzG/m5E
         wDsF9VhrP5/NJHNf6wA23DpIAYxw+UJPLKHC4x05skLevv2uXuYMOeNBZUh1Sva3gVNM
         AoJWar8wENF4g8+P/Ec/2Wiy2ppp/dK2Hx9mzwVYb3wFX8dJLVWON412stL8MtjQixHL
         yT9A==
X-Forwarded-Encrypted: i=1; AKwUvBxgD7y2WlIlzIQrbsv2kp3CG9GWv/6D7RLO7Wx3eZ7egoaqFaZgP9JJU+/dtToC565odNBpjdo=@vger.kernel.org
X-Gm-Message-State: AFuF++kOzYqBX/DRlJFoEBEmpchz3Q8EEzy9lHv75axAauFeXLg7+FU+
	ghLX3QtJdAfYUNpcLZ5X/MK98h6iuMLsaRS3XCAlocfm3WocAMUVt8jw
X-Gm-Gg: AYBFou1MLsTvJtH3UIlyQj+MnSB/RPG44BjYU+2dKtJ1wWUIk0zbddsvOdLMZBEbZfu
	7YaeVYoYzUqSlkd5Ky2l8oXTIXGhwDKpGjiE0OVu08p7gbK44pR/3/nd/AGMPuKKTOmGiC+52Dn
	3/I+rFLJJgeCHr7h7AiYlXORWs1syTHGU2rtG0RpcGl0EAJuWs4NDg8gEvKyj8FnM9fcECOMgx7
	atTqIIgJ/CFOpaUVsCGD2ZnIfxuWUuh+vrOKWp4AsLpaQbUJTiKl9j2aCmeBxe18OP6GGNagQ0E
	C7Qm5w5cJ4Ss1De0XAgpClLASPl59CDonwrc1eTtIfSjkl6W3IdQw1LlPBfe8WjKnJQTXszwJiz
	XRDr+O4m1Xly7jtxk2idWuSNxT+mScvn8LEynii0BjaJBC2X7IH0JvlgNulvYTl+U6A7dhvwQUW
	T9FNYZUjMPQb4c8rxkgNjKsFPgOX46G0vAPCWrSaiMwl3Yp17gXV6ZijNPooAKIlIFb5KL5VaMd
	qY0neb00LVBbpWoZtfGxAIXNM3jkERlIafOHGL7fXbfcZ36fQ==
X-Received: by 2002:a05:622a:449:b0:530:b2e3:86c3 with SMTP id d75a77b69052e-530c878a9c0mr125432321cf.53.1789191575466;
        Fri, 11 Sep 2026 22:39:35 -0700 (PDT)
Received: from shivam-EliteMini-Series.tail1fee36.ts.net ([128.230.213.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca47efa2sm38400961cf.11.2026.09.11.22.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 22:39:35 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Greg KH <greg@kroah.com>,
	security@kernel.org,
	stable@vger.kernel.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: [PATCH v2] nvmet-tcp: fix a hang on queue teardown with data digest
Date: Sat, 12 Sep 2026 01:39:21 -0400
Message-ID: <20260912053921.49151-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
References: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A command that has received all its data but whose data digest is still
outstanding is stalled in NVMET_TCP_RECV_DDGST, where
nvmet_tcp_need_data_in() is false. nvmet_tcp_uninit_data_in_cmds()
therefore skips it during teardown, leaking its submission queue
reference, and nvmet_sq_destroy() then blocks forever waiting on it.

Release such a command in nvmet_tcp_uninit_data_in_cmds(), and reset
rcv_state after that call.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e59810175262..3bf344b184e8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1608,6 +1608,11 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 			nvmet_req_uninit(&cmd->req);
 	}
 
+	if (queue->rcv_state == NVMET_TCP_RECV_DDGST && queue->cmd &&
+	    !nvmet_tcp_need_data_in(queue->cmd) &&
+	    !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_req_uninit(&queue->cmd->req);
+
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
 		/* failed in connect */
 		nvmet_req_uninit(&queue->connect.req);
@@ -1636,11 +1641,12 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_restore_socket_callbacks(queue);
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
 	cancel_work_sync(&queue->io_work);
-	/* stop accepting incoming data */
-	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
 	nvmet_sq_put_tls_key(&queue->nvme_sq);
 	nvmet_tcp_uninit_data_in_cmds(queue);
+	/* stop accepting incoming data */
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
+
 	nvmet_sq_destroy(&queue->nvme_sq);
 	nvmet_cq_put(&queue->nvme_cq);
 	cancel_work_sync(&queue->io_work);
-- 
2.53.0

