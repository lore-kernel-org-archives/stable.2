Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0D2BB13
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175763; cv=none; b=RfQQZr6l47r7ES3oUTbcgBEeHqCzhAq2x/T/SemMKHheC0XOgkxm/drLzewWtK8C4ETi+8GceCpPAX3ukS44mvfZsVUqF70YN5WQ+JtJYGNWM5+pMFStks9GRI+LpEoFjLmhJ2doH43CXwySeTrFL9S4wAwuH9jy27nUgJkLfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175763; c=relaxed/simple;
	bh=RlwK2Cmq0cHokex+6+EAEcjz6T0MlTNy+oIrYy7vIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiHJfxjv30URDGry6SmhQnQQIQKStFU93C5LZloNHstXe1QBYO3W4yf08Qn31KxVghmFY7O8uUfoSOlg92MXiSRSiZByArebV/yPRZDw/JgAbexJJWe5o/THsVj8CeEDtIoe97oV9G25twm83NyotpezYM1lFDB458IHbQZRwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzWxzmrU; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzWxzmrU"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93cb545be7fso112158385a.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175760; x=1791780560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcJnHXIt83QrSyOF8UJnIWTRMzOTcOywYQswfygDEJY=;
        b=YzWxzmrUlp43y/iwRUEI02fU1yysOIrZ1wCYn7Iq5rEZATcrIU97uguB6fRahoAauK
         8r545MnSVUSt5Fdf0nos1N+RsSF2RuHoZUT1Ov+TUsj5dtDZR5cQdp7IBMSMAwCmsotS
         ece2bFvYNUQ+VBvFT/xnqYWorr9gPvLAZarDMdrT+4DBKVoANYC4DZ1bKQCI8IAYjk/h
         tuxaYiXiUPOxeD8aQN48WD3p3CIZNGt1pk1Xyump1mUS9z/Bk53hQ71DbsWnzr9B7KPi
         Dm2LzATTsdVKKlSWOkcn17BbNclsjXJql+fqm337DZmUNoPBqhERBnq/VQKVOKD2WvxA
         t4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175760; x=1791780560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcJnHXIt83QrSyOF8UJnIWTRMzOTcOywYQswfygDEJY=;
        b=VfX57JvQjtjM88U8nx5UcGj4+ksVwwD9W1gTzKfbn2OBumVjVlOETASGVL3dblnpC0
         PQq57ckGVQDANDJ4ggQyfhZ+Q0EaaKcEbKn88zvNn7L1f4ZociuoV55/ltTMEVtajbPI
         X4i2D6UwZ/sqzOGCKMhkI1lr6MSo2xo95TrpUNvSPm4R7yTTD2jjc5xdp92Rxp7CwVmR
         Gt29QF3rMP6ss+xVU+kUIzRefAq1FtXRk8hit6N6IcOd8a5oyf2/jyuxmjjyw0ftANGA
         P9njAS4V/PJJC6qGJjJc62IMmk2xFVA2YQtd1KV2mD7peTCNhOvLoeRn/qgVQutei/G4
         gkzw==
X-Forwarded-Encrypted: i=1; AKwUvBz6lQHi8qoEUpSZAE7sI9ZT+f3ZPE9DiQO5TyieGTfIVcUPQicziG8cN7yhAxVjZm6wxjQ7c+w=@vger.kernel.org
X-Gm-Message-State: AFuF++kMHaw/IVf9mntUUJNrzL4EAIG8z06j4dDBsxM49OQ5j9ALyxwU
	3ywt6PfYPoo9vP04qPQ5ki7cpBUkZlQ2+1xOeIf7ar7+W0IMccd/R4v9
X-Gm-Gg: AYBFou3qFgw34ATQ60jt9DNZCkPOMj+RwnG/yHGaW0cxximrAR/Jpagv4jyFZGMgvJ4
	41Ii5OvIbFs05OpFV1r/i4s9TdH4e9D+fCdrWqnqff4qmsL+sassfrDbVrhDwWR3WXkOhEMw9dH
	f6iupRQ5ZT6AILQ5O14wNYT6+zzl8qp4zoVnPNWA5s+ZO5x9KgtVady00F7ZPDUwfK0A/LJwZzX
	c28ectoUpvUXqTF5tdDFMv95D5WY/MsuyM6oniVM6M9Kw6lZQvKrpAGh/SpyMsiXT1lnCfjtacG
	Tuv90Ois/TNNztAKUTwd4NI9izbKY2/LjJYOCQBfP9vP7keRbjTg88scfAmAQh1tCMIebN0srsn
	D9mh4UpCe9HgtoMSuyAFpSlRiVMYhsb1WMuo/s1B5xVjq+gElWp7MA+q5QWTLwDS8rmAsIPO0Zy
	c9Y/uNCV5S+BE3eWf9V+j9kZRPyKs4cAjaZl9JPrVNRYmpB45TXCYAO5LNdk+jSNAJ3Ggy5BKnQ
	LL8qMh3MvzhXMzDMU3DZw==
X-Received: by 2002:a05:620a:438f:b0:939:bc7c:15c8 with SMTP id af79cd13be357-93cf18979e3mr1635069085a.45.1791175760243;
        Sun, 04 Oct 2026 21:49:20 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b67167sm79120846d6.21.2026.10.04.21.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:49:18 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()
Date: Mon,  5 Oct 2026 00:47:45 -0400
Message-ID: <20261005044915.264532-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snet_send_ctrl_msg() reads the error code the DPU reports when it ACKs
a control message, but then overwrites it with the return value of
snet_wait_for_dpu_completion(). As a result, a DESTROY, SUSPEND or
RESUME that the DPU rejects is reported to the caller as a success as
long as the DPU clears the opcode register in time.

For SUSPEND this means vhost-vdpa marks the device as suspended and
lets userspace reprogram the vrings while the DPU is still running
them; for DESTROY, snet_reset_dev() never even sees that the device
failed to stop.

Return the error from the saved ACK value once the completion wait
itself has succeeded.

Fixes: 3f3a1675b731 ("vdpa/snet: support getting and setting VQ state")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 defconfig + SNET_VDPA, W=1, sparse).

 drivers/vdpa/solidrun/snet_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
index e284c3a06717..09afa0487fd6 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -291,7 +291,6 @@ static int snet_send_ctrl_msg(struct snet *snet, u16 opcode, u16 vq_idx)
 
 	/* Check for errors */
 	val = snet_read_ctrl(regs);
-	ret = SNET_VAL_TO_ERR(val);
 
 	/* Clear the chunk ready bit */
 	val &= ~SNET_CTRL_CHUNK_RDY_MASK;
@@ -301,6 +300,8 @@ static int snet_send_ctrl_msg(struct snet *snet, u16 opcode, u16 vq_idx)
 	if (ret)
 		SNET_WARN(pdev, "Timeout waiting for DPU to complete a control command, err %d\n",
 			  ret);
+	else
+		ret = SNET_VAL_TO_ERR(val);
 
 exit:
 	mutex_unlock(&snet->ctrl_lock);

base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.43.0

