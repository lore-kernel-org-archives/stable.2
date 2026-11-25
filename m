Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606316;
	b=tU/4QeUgGZYnYQRGgHcrauoEp4XlDJfiAp+5IklffiDtbawlbQUHe+bdD7jsolUn4ZA7
	 2oBHgQLsod69j55Ww8KzVVt5Klw1pJAzJ6Ji7Kk8ilDLHYSC0rDoTPTx+jxf2XCylPluy
	 Lr0lPXxPC8/kY6beFE9OroYQhDYMVS6XStANlSHf2Bvo+7yrqWwHMmV/2Uz2GnecJxtxI
	 RGNL0poD1evsfR3hwvpslPFUHIZ3je6T0yk5ZT9JNrDVxL8lxWYDT1rwAoGwxLdv/OlcW
	 SVC6C2i2Mid83V7+ltX2tjheJ1kSzigxub6IU9padIfwDIJ5n93ZzxkbPsB0AWlj9LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606316;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oWK+Gv5Ui9LHddePBbZpjgFju4D79/THYPIGuY5Ig84=;
	b=y7NqgCcWtbfnGufIvmN/N8EGnhpacitQ4ctxNVQREaQBlbs8pVYa4EbE51YaO+iuppM5
	 5m/MjvGAHEBDtYVoZfa9akcaLc5yKKXdH/Wfor1z+Rx3eR6PC64ZnQtyk5J/GhoDU/r5U
	 /9lDQbKW6M80jajvdo8mra5pZO5fmidrsuNqFVNi0d4hTLzl71cHlpce4GkfC5K1bKcC3
	 V/Gb/zgmyJpyrQg3aG03mc2Iych2HFA/6kC2lzT8rgOZv3RmGPY5j161TrywpjOhBmKHv
	 u2Qv8sbUPO8XrLXo90yMcbEgJsRulqiD0IH/55hwOGC4y8IHSlMb3JWi6o/+285QWtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="VY/NhYzN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B19606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VY/NhYzN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C9D1F000C0;
	Wed, 25 Nov 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606315;
	bh=oWK+Gv5Ui9LHddePBbZpjgFju4D79/THYPIGuY5Ig84=;
	h=Subject:To:Cc:From:Date;
	b=VY/NhYzNodhDyc5ihuGL9xxBWFhPM4JFu67i3eNTndxGKchHMBxoXX6Bhi1uCtiM+
	 BvFNN5cd8RGY3lh9WUK7jrIZyTWI6XOUOpbuIYZ5W3IzuhNY85YZPsYkhhFLT3NjQm
	 YAr+Fxe8ec3A2Od+pYsNDxm0gVmGAqzBoTcJW0DE=
Subject: FAILED: patch "[PATCH] dm: fail a REQ_PREFLUSH bio with data when its preflush fails" failed to apply to 6.12-stable tree
To: daejun7.park@samsung.com,mpatocka@redhat.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:17 +0100
Message-ID: <2026112516-prude-hurried-f333@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112516-prude-hurried-f333@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 12 Nov 2026 10:35:29 +0900
Subject: [PATCH] dm: fail a REQ_PREFLUSH bio with data when its preflush fails

For a bio with REQ_PREFLUSH and data, dm core may send an empty flush
first. If the flush fails, __dm_io_complete() still reissues the bio
without REQ_PREFLUSH and drops the error. When that write succeeds,
the XFS log keeps running and fsync() can return 0.

End the bio with the flush error instead of writing the data, as
blk-mq does.

Fixes: 6a8736d10cb4 ("dm: relax ordering of bio-based flush implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a73355c0125c..38eaae8ac9b4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -983,7 +983,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	if (requeued)
 		return;
 
-	if (unlikely(requeue_flush_with_data)) {
+	if (unlikely(requeue_flush_with_data) && !io_error) {
 		/*
 		 * Preflush done for flush with data, reissue
 		 * without REQ_PREFLUSH.
@@ -991,7 +991,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 		bio->bi_opf &= ~REQ_PREFLUSH;
 		queue_io(md, bio);
 	} else {
-		/* done with normal IO or empty flush */
+		/* done with normal IO, empty flush or failed preflush */
 		if (io_error)
 			bio->bi_status = io_error;
 		bio_endio(bio);

