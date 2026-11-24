Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.231.133.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522862;
	b=F+tU4BWq1Tfdtyhh2mepzjfpiCDd2tDp/ecau/1qq9yPJkMA7WVcZ0hzOeUbNByZGOF6
	 OP1WD9R59Ly8peeHOx0cKuzpjm7QJJsf1xrc1cvtqmvJGoQNqnV5gmNFd0kyDtmp0Zn8p
	 HD4MfDoovbaSqZ2fgJvOegAb6IZShWAks08oGolxfPa0WLy/3AnKyNL3lSMAeaEePUdAH
	 +B7u15wfQJ9ELAtvdYtYazgZL7VqPniuIui1+WGVnXTkTk0ReGUgo7XC23pGGegrFNMmO
	 lUL3U5iLkWA17cOATjpTgfqqtZ7TiyUmRoqOYKXbJ291Sg26KqDLDfYO6kXInSHqQ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522862;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RyHhsrrzIHpu+0Gu49skCk9R55WpAVNNdr7nqfZtoog=;
	b=edbg4Wo08UeaOr9Jg+EYcRhxcLOQh1HYrp9Ptr9Qiljq8oQuSia5KQb71vcCR2vJ7kSJ
	 pOoWJgVhO+aRbVstrH0x0YOmD9EQ3a3i/wXtidMf7ukBLGWLsuIh+2ML8B1XrkwdzJ1Fc
	 uvXDvE6jvemGbSrXlAwfyihqlqtnFCM79szPutldLVYaHYkyWPBJANiRb0hxatTcs0vwg
	 1/Gxdb/kkr+PJp7nvAskOxzcVRLDqRobQrEtiae70zMtDzvkdsruPIF6c9tflsLa4gq/1
	 VbpbRCickqo3EjAiZfsyJCqPWwic6tYbFpS+wEV4Wcwun0fmtETnOLmRy/3L8yLw8sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesp.com.br;
	spf=pass smtp.mailfrom=renesp.com.br;
	dkim=pass header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=nDpEwb+e;
	dkim=fail reason="signature verification failed" header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=jM5+pjqi;
	dkim=fail reason="signature verification failed" header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b="O5hz/+Lj";
	arc=none smtp.remote-ip=45.231.133.222
Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123A606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7123A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=nDpEwb+e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=jM5+pjqi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=O5hz/+Lj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1795522853;
	bh=xIaQcj2s83xLPfozpMSbM0Bd40toJFIkUkAt/cxZJw4=;
	h=From:To:Cc:Subject:Date:From;
	b=nDpEwb+eTcr0tclms9sbMsOOJgs/iZq008mFS9cXcb+w4NrDV5Lrf0IG3nTs69Ur6
	 DI6jMnzPVeFE3Nc86ooTLxTUbiXpfSO3AgFXIZyq108vSsry5+chONQhtUHGySCSuI
	 QXMtdhqmd77+MvJjExre1JnuAWU1RptDEMfS6bNI=
Received: from renesp.vps (renesp.com.br [127.0.0.1])
	by mail.renesp.com.br (Postfix) with ESMTP id 4jYhjd5sKRz3wvN
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:20:53 -0300 (-03)
Authentication-Results: renesp.vps (amavis); dkim=pass (1024-bit key)
 reason="pass (just generated, assumed good)" header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	tempos-project.org; h=content-transfer-encoding:content-type
	:mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
	 t=1795522853; x=1798114854; bh=xIaQcj2s83xLPfozpMSbM0Bd40toJFIk
	UkAt/cxZJw4=; b=jM5+pjqin0PmywRWxd5FfrE8WEYFbkhw4EuLQ/smYSJOSLW0
	3R1fSUAdw+Hwd10NknKKlvoVq02bSvLi7OzA4Vjy7KM3Ldby9rtoUzyjXANK2/Rd
	M5fTM7a9A9QagDbvw2hcX/v/WgIAHpUHydP5YiIYS91ls48QrFFZ//i62gGnTqru
	w+6wI5aSokfg+48fjyVc2JnVD/fGDX+GBWfwhDL8uOcoHE2mLtLnCqsdMZhNaL4p
	qUtK/4VqZX6ElcHHdHkY6nWpQg0T4LvYoZwfxhNRsC8qKR+YwhroD+9tBxMJ7ovj
	ciW4D87BEQbv9XuW2YqteN++RPPthBXX/fgoAA==
X-Virus-Scanned: Debian amavis at renesp.vps
X-Spam-Flag: NO
X-Spam-Score: 2.21
X-Spam-Level: **
Authentication-Results: renesp.vps (amavis); dkim=fail (1024-bit key)
 reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
 by renesp.vps (renesp.vps [127.0.0.1]) (amavis, port 10026) with ESMTP
 id mMm7tzN8b5oP for <stable@vger.kernel.org>;
 Tue, 24 Nov 2026 09:20:53 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1795522835;
	bh=U8jsuGQrWb3zRrhzqCiAgcfxcu/AgiSD/CP5GlnXhWg=;
	h=From:To:Cc:Subject:Date:From;
	b=O5hz/+Lj32FDvO9vBL3FIcFU2QDWsknO/elqQxp1g7TLhy3Zc64fxsVqTD2LQrh5H
	 eR6x9+Y11Tx6Lf8sQAErXAHMAE0adNpIvLSRL1Lb6nx8xXbW1sWrTgBPj+dUhhFZMA
	 o+dHWF0YwuUjKJ94liyR6M+OPoeK6pDaXlFxZsaQ=
Received: from rsp-x1 (unknown [178.20.90.158])
	by mail.renesp.com.br (Postfix) with ESMTPSA id 4jYhjF09RLz3wvJ;
	Tue, 24 Nov 2026 09:20:32 -0300 (-03)
From: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
To: srini@kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: ekansh.gupta@oss.qualcomm.com,
	anandu.e@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
Subject: [PATCH] misc: fastrpc: fix fastrpc_user leak on abnormal process exit
Date: Tue, 24 Nov 2026 13:20:11 +0100
Message-ID: <20261124122011.2912030-1-rene@renesp.com.br>
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
references of the pending contexts there. A context still waiting for
the DSP response is freed when it arrives.

Fixes: e85eb5feca8e ("misc: fastrpc: fix use-after-free of fastrpc_user i=
n workqueue context")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>
---
Tested on a Qualcomm IQ-8275 EVK (QCS8275) with a 6.18-based kernel:
a llama.cpp process using the CDSP was killed while invocations were in
flight. Without the fix its ~1.8 GB of buffers stayed attached to its
context bank, and the next process, given the same context bank, failed
to map its own ("failed to map buffer"), leaking more memory on every
retry. With the fix the buffers are released at close and the next
process works. On mainline this is only build-tested (arm64, W=3D1).

 drivers/misc/fastrpc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cdc2627bdaf2..09a2963d72f9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1725,7 +1725,9 @@ static int fastrpc_device_release(struct inode *ino=
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
@@ -1733,6 +1735,20 @@ static int fastrpc_device_release(struct inode *in=
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

