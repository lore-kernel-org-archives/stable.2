Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.231.133.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529948;
	b=XbyyLK8EsX0GLo7ko+2yfsPC89EQH+7CW+EkhykFGCtoaGuSboSfdZxAuY8DraR4MCCG
	 N4IcokvzTHK97IkX1bYm2PPtvjGhc8b9FviOGqTkpX0Psuobci7onSkmlSJqNdGr0+S63
	 77+EU/n1aEXVTgQo3LHs5oUqRc+553OauAdPctT7oCcWHFxLaOFBknhICCK17xfU+ZPsP
	 IJy9+HbZ3NSC6q7/xTQS9RaGPmaBpxyHK3gV1UDUJewpAf94fJK2dlwzWqzj6tsVBZe7E
	 pKM23LIFaSO3iazL8WvWLp2ppZ0ZGlp76CvXDjJYunYonzIbp0RuUWaq7PWj7t0KLmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529948;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NgxtZprDu56ARd6CagLqzzCr9sovN7v478GsqojgKOA=;
	b=EL332iVBekuJghP6e24FzV72zccM22KGyDmJGP/geqskMQNzfi68kr9if4PneupQhN14
	 aZX5qbEqk1ZXG0FjfACJfqPWPkusyABBZgQadmgjKMcVWNgMkKjT+4Wu0HBxl+wH77MVx
	 Z8mtV42qV8NtcNQzfX/hoJWAYw5r31Z/ZxWtzOSjglUNcIipPzUtM37AUtVBb8WLPk1IZ
	 nIRDHInQaW1B8GzgY1O48mZlTS5NL9HKGx0w7LQgrLZgZHEVBzJ7kdmNjItqw6HQZ7DHA
	 OZ6gukaTgoQ3EqmXfD52UEtPqGbi1AXRjz8xpYsGbdb7Rxp/KK27PXlb7KQzB17QWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesp.com.br;
	spf=pass smtp.mailfrom=renesp.com.br;
	dkim=pass header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=iovwd41c;
	dkim=fail reason="signature verification failed" header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=ifibuEt6;
	dkim=fail reason="signature verification failed" header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=HdpXmoBF;
	arc=none smtp.remote-ip=45.231.133.222
Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52E606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE52E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=iovwd41c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=ifibuEt6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=HdpXmoBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1795529945;
	bh=FVk2svI83tFgdhTs3E2x/HB/PeflMMXHXcjvab7MxAs=;
	h=From:To:Cc:Subject:Date:From;
	b=iovwd41ccjIRBp5TCx4bsoJ4SdGwnCe+QdXrJGQS7uedpPBx7buGOBiOfqPvkDIoy
	 frOaGiR5hdgMa2eA3suQQKOFotJhVo7FzDDq7xreNVjdbbbCac9k6lwrihGG3ygMDF
	 U9mJbgfvJTDzvq8YfMiLWx8NyOh/C1H4xTHyPHug=
Received: from renesp.vps (renesp.com.br [127.0.0.1])
	by mail.renesp.com.br (Postfix) with ESMTP id 4jYlL11pVZz3wvK
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:19:05 -0300 (-03)
Authentication-Results: renesp.vps (amavis); dkim=pass (1024-bit key)
 reason="pass (just generated, assumed good)" header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	tempos-project.org; h=content-transfer-encoding:content-type
	:mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
	 t=1795529944; x=1798121945; bh=FVk2svI83tFgdhTs3E2x/HB/PeflMMXH
	Xcjvab7MxAs=; b=ifibuEt6HbmB3MHPHsibi8PDrgAgdv6535n2g5s6052ajS7n
	c27406XgJ+BiW3rle/Sq7T/hlacVk5wz1XB1uN+QyyxDkn01cETmNgHk/asJhnZU
	Iyg3zVDpN0BJI+ypgU2X5pfWAb2Z/v5ewCdg09egbBpC7G8Jqz+AglkxfirgMsRu
	TBNaH9gYIfm2IoC8IQ2FVKJiQrabXYUH85WnlOXzL5lNgugPLQApHuOm8S/qdl8D
	sIQ2aL08inYNnKxm6fZcs7NVY4sCMtWNhZWYDj4NhOU8y3L/CGqC5PNi9sRhS5Hk
	m/gfLTOgusj+XGskFMh7WPGmESPe+J22uRKCUg==
X-Virus-Scanned: Debian amavis at renesp.vps
X-Spam-Flag: NO
X-Spam-Score: 2.21
X-Spam-Level: **
Authentication-Results: renesp.vps (amavis); dkim=fail (1024-bit key)
 reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
 by renesp.vps (renesp.vps [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 01I1O9xvOn4S for <stable@vger.kernel.org>;
 Tue, 24 Nov 2026 11:19:04 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1795529934;
	bh=S28ReI6Fu+NyU6JY1E8Q+vtFT3DloD9P2EWTyT6ur+E=;
	h=From:To:Cc:Subject:Date:From;
	b=HdpXmoBF1t9YwGzf7v2aRFu0XczqjPINtk7NpBOynne/vCHbdzddue+HyqQznZq4R
	 l1fKdEai4kXBsvQDQy1n248PZB4fRT2aFqW8IqKixj40vyUhvsWor/NunmqasBhir1
	 L6BIJ9BQWVpkWAn89MFjOnjdJWXkuWqLPuaFu+0Y=
Received: from rsp-x1 (unknown [178.20.90.158])
	by mail.renesp.com.br (Postfix) with ESMTPSA id 4jYlKm1YZQz3wvJ;
	Tue, 24 Nov 2026 11:18:51 -0300 (-03)
From: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
Subject: [PATCH v2] misc: fastrpc: fix fastrpc_user leak on abnormal process exit
Date: Tue, 24 Nov 2026 15:18:43 +0100
Message-ID: <20261124141843.3967523-1-rene@renesp.com.br>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Since commit e85eb5feca8e ("misc: fastrpc: fix use-after-free of
fastrpc_user in workqueue context"), each invoke context holds a
reference on its fastrpc_user, while contexts left on the pending list
(interrupted or timed out invocations) are only freed by
fastrpc_user_free(). When a process dies with invocations in flight,
this cycle leaks the user with all its maps and buffers. As the session
is given back at release, the next process can get the same SMMU
context bank with its IOVA space still in use and fail to map its
buffers.

No thread can be in an ioctl on the file at release time, so drop the
references of the pending contexts there instead of in
fastrpc_user_free(). A context still waiting for the DSP response is
freed when it arrives.

Fixes: e85eb5feca8e ("misc: fastrpc: fix use-after-free of fastrpc_user i=
n workqueue context")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>
---
Changes in v2:
- Move the pending cleanup from fastrpc_user_free() to release instead of
  duplicating it, and drop the forward declaration of
  fastrpc_context_put() (Sashiko)
- Link to v1: https://lore.kernel.org/r/20261124122011.2912030-1-rene@ren=
esp.com.br

Not changed from Sashiko's review of v1:
- fastrpc_session_free() stays at release, as before this patch. Moving
  it to fastrpc_user_free() makes a context the DSP never answers keep
  its session forever: on QCS8275 this lost two of the three ADSP
  sessions after an adsprpcd init failure. Reclaiming unanswered
  contexts is left for a separate change.
- Handle maps not released in fastrpc_context_free() is pre-existing:
  they stay on fl->maps and are freed at close, which this patch makes
  happen again on abnormal exit.

Tested on a Qualcomm IQ-8275 EVK (QCS8275) with a 6.18-based kernel:
a llama.cpp process using the CDSP was killed while invocations were in
flight. Without the fix its ~1.8 GB of buffers stayed attached to its
context bank, and the next process, given the same context bank, failed
to map its own ("failed to map buffer"), leaking more memory on every
retry. With the fix the buffers are released at close and the next
process works. On mainline this is only build-tested (arm64, W=3D1).

 drivers/misc/fastrpc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cdc2627bdaf2..23a5035654a5 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -554,22 +554,14 @@ static void fastrpc_channel_ctx_put(struct fastrpc_=
channel_ctx *cctx)
 	kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
 }
=20
-static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
-
 static void fastrpc_user_free(struct kref *ref)
 {
 	struct fastrpc_user *fl =3D container_of(ref, struct fastrpc_user, refc=
ount);
-	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
=20
 	fastrpc_buf_free(fl->init_mem);
=20
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
-
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
=20
@@ -1725,7 +1717,9 @@ static int fastrpc_device_release(struct inode *ino=
de, struct file *file)
 {
 	struct fastrpc_user *fl =3D (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx =3D fl->cctx;
+	struct fastrpc_invoke_ctx *ctx, *n;
 	unsigned long flags;
+	LIST_HEAD(orphans);
=20
 	fastrpc_release_current_dsp_process(fl);
=20
@@ -1733,6 +1727,20 @@ static int fastrpc_device_release(struct inode *in=
ode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
=20
+	/*
+	 * Pending (interrupted or timed out) contexts can't be resumed anymore
+	 * and each holds a reference on the user: release them here to avoid
+	 * a cycle.
+	 */
+	spin_lock(&fl->lock);
+	list_splice_init(&fl->pending, &orphans);
+	spin_unlock(&fl->lock);
+
+	list_for_each_entry_safe(ctx, n, &orphans, node) {
+		list_del_init(&ctx->node);
+		fastrpc_context_put(ctx);
+	}
+
 	fastrpc_session_free(cctx, fl->sctx);
 	file->private_data =3D NULL;
 	/* Release the reference taken in fastrpc_device_open */
--=20
2.53.0

