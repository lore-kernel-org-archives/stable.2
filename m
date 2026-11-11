Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794430947;
	b=joYl/AQCNwvqlX2SPlUySOy/YMYv1kvXPzHJ+W3R+L2vfqHwfVyVBKk0QK/pH27b3CWj
	 uMm3RIrBR08Rp6ZKuNcrbuUAMrp4BJaTviiKQWvnKzbXWPviX4RbW7dw0ieKQIowNr+Vm
	 HBNOP+wTZ4fF0INaPVsbBAbXU1rsTWRlm+/5jEMgCAHfiGS9CZhwOqot1S7W2X6ejUm5W
	 wR2JWWG327eE/ABWE5sa0mo7a/yweU6dc7xoeLJix5m6mM2xAAbTt+R0za4y4ntq/YBzZ
	 Veyt2ydS6yUkwFo11eEBiv45U8gLxCsYTmc1SQTfLI7DXwCM3yQAD0SIlCGLeSLz9LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430947;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvn5m3zvm2JBXqWK7LIJzhjZYVT4WuG035S4Y95swAA=;
	b=aWkEg0Wr9F5lwRwkum/4Bah91p2iTMKIv4YTn/7azX7aiO7EJB2pEAF55pixkglqjHrB
	 7xCQm7yQ5udzCdcxZrQ5lF3cCdGXRrO7yvin38DYcg5j+iDXD5G1atJ3MfQQ0MAOH4wwv
	 B2T/ESri5FIqBYKA1waXAupwXipbjt+20Hi/gucdw1nykqnjz5nxbh2qc0Flp8XcPo9XV
	 TqLgErYLkNQtZ49Ugvq6bXHnX965hd/oscoxFoHCCtjz4MkDotcNUDA7/HybSFQu0kJ8v
	 662jXFeT/kcP9OADVhBmoeOHRoQLm24dtQbfqASsiV9P6oW9sGbS3UOTLiBLUTVg7dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv3rYXKt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1C606A32A;
	Wed, 11 Nov 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv3rYXKt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794430947;
	b=l278fNp9d9N2zATavbmJ80MFeQLAIJEcM3eLNNkiyXZ5lagGEmmZAsw4b/Fpvc4R++io
	 bBuxszgxhIvrZUkDcE73G+GWKgZ8gJed1Sb+bygn3vjkuOwJIv3GzRiDGo77OH7kvsFnp
	 WPzJEcEHvt9pVS2xycP29jysgJsShALN+qFZePf5Ho1T8UeGiApEuqruVjabexHiPFxJ5
	 nvJTi3C7v6YK94fzKxTIDo2y5G3l8+1sfiDbkN4KpXxvqnsXxFZy1MCJ1OAiqr3+G6iRW
	 IJx5BLspGj2F4JHJsI7DM+wG9bYZIpvXyLHukjG73jf2CoCcV3tn813ilV6C52omOiQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794430947;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvn5m3zvm2JBXqWK7LIJzhjZYVT4WuG035S4Y95swAA=;
	b=iiP3whytwGfv6RQCoyzLgiLJPNnYnhgVFGlFy6oNcCQ08cUkIt4g+AGt0sdngvHSkHHh
	 ZtwU3RXxrdGYsg06Cs06Ua4dlNsQ5Lsfu18f51SozZZ9xfUbR0EgJ+EcsedT1NoLpLZkE
	 FNS7XTfXoMecWdrPmyW3QTubtOvcqrQIi2MUOrzpa+4KN56MxupqLSGQ2q+hC9hJSlG+Y
	 FnQlBzd5YoQxeUs/8JSXq0bXB1PyvKiihVL1ZJemf8kz75D7x1K1AVnkh/hnoyu/LxtHr
	 YkBgkk4+WOfryxAELRDwIAHgS5/By9UuKkV+iKxYPbwPXewOqXIPYW1D/w9Oj9ZFaYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 685501F00A05;
	Wed, 11 Nov 2026 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430947;
	bh=Gvn5m3zvm2JBXqWK7LIJzhjZYVT4WuG035S4Y95swAA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=nv3rYXKtVXvIr8mwVSKlp4nl8PAJre7lrxqv4k4STzBao0didPURRYtBe39K4Fmkz
	 EzqkCsJ9if3w/n2eOH5em5/q10c1A2jXVYsKJ+Tg2wifeN9PEfPLXuABl10zPoZuOP
	 9S/EJGFQydBmuDSLL48D3lor3FwwWfoB1OlebLg3DMsIicXC5EJ8Gy7letovlmn1Uz
	 AKXDKZti69+QiiGe2wYAoKqGGst8gCRXqL8CF325oRnUEWJejyvKfKvHkogsYiES2z
	 t33s1DSnAQWTmMlaSOHt08XxLOSn5Ohy4+J2dHvqjDrivRCEWXtb0VohK6qdfWMe2I
	 1rjVckapfe9tw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B22CE490F8;
	Wed, 11 Nov 2026 21:02:25 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Wed, 11 Nov 2026 16:02:25 -0500
Subject: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJbdCgVzEuoPzqaAOTjkUSw
 t2t+nbf5q1kSAKjU7VSwiwm01jgdhWFezfewDIUk6/9wZVYRcHQKUYsIWaTGfzunsjKx9btfVs
 3rm8GKgNNuMrym58vf1vuHwiv75G27QObfYctfgAAAA==
X-Change-ID: 20261111-pipe-epollexclusive-wakeup-981528041b4d
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794430945; l=3875;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=AMo3CuUQRFmmdnadGKZpp80pX6RvxZnQfgMh8Vg/BZs=;
 b=vKagOaquZDeNf8CRSF5BrdESHWSEON6SGjDwk4FBb4Vfz1qkjFSxsKl31j4K60lWFb24/LumK
 fWzBA7CejUbDqSjbFj6mS+PWDVzPdCQJYxe3tDV+kqpfafvnMpEKd7r
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A task blocked in read() on a pipe can sleep while the pipe holds data,
when an epoll(EPOLLEXCLUSIVE) watcher of the read end was added before
it.  The watcher's entry on ->rd_wait is exclusive and sits ahead of the
reader, so a write into an empty pipe wakes only the watcher.  The
watcher reads without sleeping in anon_pipe_read() and doesn't pass the
wakeup on.  Since commit f1cebdec9739 ("pipe: only enable the extra
wake_up(rd_wait) for EPOLLET consumers") the next writes into the
non-empty pipe don't wake anyone anymore:

  Task E                   Task A                 Task C
  epoll_wait(ep, -1)
    /* EPOLLEXCLUSIVE */
                           read(p[0])
                                                  write(p[1], "1")
                                                    /* wakes E only */
                                                  write(p[1], "2")
                                                    /* no wakeup */
  read(p[0], 1 byte)
  exit()
                           /* still asleep, "2" is in the pipe */

A then sleeps until the next write into an empty pipe, if ever.  Before
that commit any pipe_poll() enabled the per-write wakeups.  Those
reached A because an EPOLLEXCLUSIVE entry only takes a wakeup while a
task sleeps in epoll_wait().

So EPOLLEXCLUSIVE consumers depend on the per-write wakeups too, for a
different reason than EPOLLET.  Enable them for EPOLLEXCLUSIVE as well
and say why in the comment.  With the fix, A reads the second byte.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 2s.

Fixes: f1cebdec9739 ("pipe: only enable the extra wake_up(rd_wait) for EPOLLET consumers")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/pipeexcl.c

There are a couple of older gaps like this (a single write, and the
write side with EPOLLOUT|EPOLLEXCLUSIVE).  I left both alone here though.
---
 fs/pipe.c                 | 6 +++++-
 include/linux/pipe_fs_i.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4c1122597a3c..8ad792d300c9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -700,9 +700,13 @@ pipe_poll(struct file *filp, poll_table *wait)
 	 * and the ->pseudo_edgetrigger check in anon_pipe_write().
 	 * Currently io_uring sets EPOLLET for multishot polls, so it gets the
 	 * same behaviour.
+	 *
+	 * EPOLLEXCLUSIVE needs them too.  Its entry is an exclusive waiter on
+	 * ->rd_wait that can take the wakeup meant for a blocked reader, and
+	 * unlike a woken reader in anon_pipe_read() it doesn't pass it on.
 	 */
 	if ((filp->f_mode & FMODE_READ) &&
-	    wait && (wait->_key & EPOLLET) &&
+	    wait && (wait->_key & (EPOLLET | EPOLLEXCLUSIVE)) &&
 	    unlikely(!READ_ONCE(pipe->pseudo_edgetrigger)))
 		WRITE_ONCE(pipe->pseudo_edgetrigger, true);
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 95f6236c5c5b..6b2e14ec6ef8 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -90,7 +90,7 @@ struct anon_pipe_prealloc {
  *	@files: number of struct file referring this pipe (protected by ->i_lock)
  *	@r_counter: reader counter
  *	@w_counter: writer counter
- *	@pseudo_edgetrigger: has an EPOLLET consumer, enable per-write wakeups
+ *	@pseudo_edgetrigger: enable per-write wakeups for EPOLLET/EPOLLEXCLUSIVE
  *	@fasync_readers: reader side fasync
  *	@fasync_writers: writer side fasync
  *	@bufs: the circular array of pipe buffers

---
base-commit: b0993210e420f2f1d61e6719fbcd3966b96ff9ed
change-id: 20261111-pipe-epollexclusive-wakeup-981528041b4d

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


