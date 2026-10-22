Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679449;
	b=rYIAN/uZj3xzDzLn9mGqWuKKOhMEHbbx1IKb/9Yzv81s0CzOkrNpldpMmCs3cpXGG5dU
	 v21BKK8VkwoqBoJwYDShW8OXd2Mx990o0KvrXcemnNufydhfUfK+vXvPu9D30j3g1bSAf
	 JiGWWJcer2Q5CbTNfM04UjJt1hQaNxFiA5niBMC1CsMCPgZj58U1zcCm676D12ZGRdx/Q
	 Uzyf8YJOrDjANfzbV5uwEbEzgf+oWC7QjP+cHH8MAPARp0MEzOkV6IjrHtm8WyUjhkgqC
	 SKq61GTQnvQ9cCdxVhM6ltYg881omHjvw1JNOeCnJtA54tP94wxfG7WlP6/qcdu8VOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679449;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VQJi6/xdI9W7hQ9gor0XjG2VytK4x2Aii/hv8vuP200=;
	b=DUvfH3VSyS0fE9AR6H627K1i3H/iIZKzP4RTWVa3u/JlflxLQH/wMTO0JBcC1JcC4wGg
	 /4bhY0qFM5d7Gck9/osTf98OaAy2T4xWVU+im8ULF0KlmuIlov41BNnmeAn9GtNFkzyZl
	 EPU0dnvN0ghmBdKvfhuzvF14rxFUQcHhCtuJq7IiNs+jg+bQOh3ajHDBjm7c+qWvs0hxj
	 DauXn+NweQWDB/rOMWfu8/4pPmKUQ/K5q3t/JrUYo/ELkpWbtIwyaURkspAg+ZdNZEEAO
	 PfpI30ZHn9PqoYOgUd655EvhvPwPQb7rHLpzPV1TKOcBbeHSV3jcsa121lvmy5It7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crswSAKD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419E606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crswSAKD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFA1F000C3;
	Thu, 22 Oct 2026 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679448;
	bh=VQJi6/xdI9W7hQ9gor0XjG2VytK4x2Aii/hv8vuP200=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crswSAKDZhSyP9W9603alPCJOnZwsfm8ktqGpuF1gnwaAOXI/Ei52qBrXmVhhKjHr
	 vuDKD2/ObHH43xmV7/eanciT4N6Db0aq3n0X8Hp+BEwB207R5tZYTaChLhCqkCiVQR
	 OioPPRymHudrZtfdbSIaQ4bRXQDgWAvhmx8lklqbRC07HuHFtjMCa6ZwpIc6Rvym0g
	 /uvTlzwKR+Rj+w0xqamxgmUBIIPo2Q+dfLgc6SPVXJwv1EShC1EBEzehrzpLBkN0ao
	 o2/bncjFpfvzDe6btaOSbgEOqIQxDkt2rVmimXAswBNX9pHUQUJuYEJ/Rm1nBORz+z
	 20P2GMZMauCHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] io_uring/cancel: move __io_uring_cancel() into cancel.c
Date: Thu, 22 Oct 2026 10:30:44 -0400
Message-ID: <20261022143039.1598352-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022143039.1598352-1-sashal@kernel.org>
References: <2026102127-pettiness-citation-cb83@gregkh>
 <20261022143039.1598352-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 01e019b2a30df41c485f602a5246124ea911071b ]

Yet another function that should be in cancel.c, move it over.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: fddcf4c5321b ("io_uring/cancel: don't spin on local work the task can't run")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/cancel.c   | 6 ++++++
 io_uring/io_uring.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 2754ea80e2882..3ba82a1bfe804 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -422,3 +422,9 @@ bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
 	}
 	return matched;
 }
+
+void __io_uring_cancel(bool cancel_all)
+{
+	io_uring_unreg_ringfd();
+	io_uring_cancel_generic(cancel_all, NULL);
+}
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3d7d88df4d88a..b2abff1290b51 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3369,12 +3369,6 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 	}
 }
 
-void __io_uring_cancel(bool cancel_all)
-{
-	io_uring_unreg_ringfd();
-	io_uring_cancel_generic(cancel_all, NULL);
-}
-
 static struct io_uring_reg_wait *io_get_ext_arg_reg(struct io_ring_ctx *ctx,
 			const struct io_uring_getevents_arg __user *uarg)
 {
-- 
2.53.0

