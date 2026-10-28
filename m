Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227278;
	b=j4RInwWvdLGN0kdBTV0Ij/xJAouobBE5pXKZcijLbqApXG7QpLEP2mo+3UnRHyC6t+il
	 57vgoiPcA8iL2akIDLJUIByXYLm0KhQkNZHqnTTL+lBNp2kGeViMhoGFvaKnrgZ3fYoiF
	 7dPGgIZdrUzAgbDxN69YYegSzE+zrpKI+1HIvTxP2q5c6yujmpFGt6lV6VWWelF/xlTF0
	 H5NTsYQ/tyz2/oWuSo91gcCxqY5jhVlkXblt6rKEC7Z8xRw8Jk+IB6iST4NKp7ezsT9jp
	 90ltPDF8BZkV8Ur/X3/pNvUSQZQkZDzQAHj/wMgjDPRBhZnFKrNrLEz5cEaOmV/a0sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2JY3WgHQl71TpwFfPN3ajoLGU5Lfhxz2JrBrBuC10ac=;
	b=YfApAoRQzXwYxpHBd1PIgJysBxrqohRh+V+9DyPi/zun7iGTd4q0jy288C9ncslbZ9US
	 yy4u2TTzLz4HoOI/hJuBdAZYbInwmyXPcbDvf2RPrK7u96YOUJCEtbwsuQJLO1E8fYdik
	 NC+DeTPVrHLwkXhgD9EhCTi+i/pqWo/ahddW9yRrxqYpv/KW6S1fC52N6+oRvHLH3c0Xj
	 lhjRB0II6a3SaMwvHfPNG7BF/Unp2U/W1Q7RNTqJHXjDXA8xIsUSjtOPHA4byhTjoA3Fn
	 UjqVS0+VoiI7NnmB7VWxm3CsSgvhSXI8by80/VUNeGRJclv8Rn3++/uzFpcZcwlOveQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVUVWnbu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146CF606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVUVWnbu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270251F01825;
	Wed, 28 Oct 2026 22:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227277;
	bh=2JY3WgHQl71TpwFfPN3ajoLGU5Lfhxz2JrBrBuC10ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bVUVWnbuS6d5d+onCivK2WHaQsYgdQYCckkIIa+iVpZZwuMz6pfx5ucPLgcMALjHB
	 E4eu0fwEABlSqylAYNnNjs26PWvSvkTDinzQ6kZ+W6BVUhoj1D44SGmotZQs3YMMBt
	 Bv5QnNuOqk5xiU/pgCC/x9uy7UTfVYJB6r4/C4dWN6lufoQxN04y0Zk9aFNNMTrlbA
	 +YismkFJipfreHDR39xfJIOMolYEhv08Eq1QyLIT1ePLHw3c4stR4dISj/HyX2rerS
	 wOngYN6FaNJ8LEhM9i/bci933pYrp9gJ6bCL+QEovtfW6PmGa05OPg5CAVBv9zBoWb
	 G7j/NX9OeOqSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] exec: cancel io_uring requests before de_thread()
Date: Wed, 28 Oct 2026 18:41:15 -0400
Message-ID: <20261028224053.2414973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102821-deluge-generic-8319@gregkh>
References: <2026102821-deluge-generic-8319@gregkh>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit b42c85c20d84ff3e4f0f027d6596c3b3b4a20657 ]

begin_new_exec() cancels the exec'ing thread's io_uring requests after
de_thread() made it the only thread in the thread-group. Now
io_uring_task_cancel() runs task work after. If it runs a
create_worker_cb() item then a io-wq queued on the thread before the
exec creates a new io-wq worker thread.

Said thread joins the thread-group which de_thread() just took down. The
io-iwq sticks around until it notices that its workqueue is dying. But
code after de_thread() relies on being single-threaded.

Move io_uring_task_cancel() before de_thread() but behind the point of
no return. Any worker created during task work run from
io_uring_task_cancel() is just a sibling thread that de_thread() will
take down and reap.

Once io_uring_task_cancel() returned the thread has neither a task
context nor a workqueue left so nothing can add a thread behind
de_thread()'s back anymore.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/aq0_lvHDViIpX_Mu@redhat.com
Fixes: 3bfe6106693b ("io-wq: fork worker threads from original task")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Adjusted context around de_thread() to preserve the existing fs->in_exec reset in bprm_execve(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6797c8cf88f4f..a495aa064a6d4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1255,6 +1255,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
+	/*
+	 * Cancel any io_uring activity across execve. This runs task work
+	 * that may still create an io-wq worker, so do it while de_thread()
+	 * can still zap it.
+	 */
+	io_uring_task_cancel();
+
 	/*
 	 * Make this the only thread in the thread group.
 	 */
@@ -1262,11 +1269,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
-	/*
-	 * Cancel any io_uring activity across execve
-	 */
-	io_uring_task_cancel();
-
 	/* Ensure the files table is not shared. */
 	retval = unshare_files();
 	if (retval)
-- 
2.53.0

