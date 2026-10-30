Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376928;
	b=LtxTy/APhzMqFzEBuPGKuXkMgRh5BYk2FtKOQ35tu7s6DyhMDpsC/4oCDXvGnniVM3jj
	 3j0ZKmXdUsEIwjaQimP3eo08VajaOOU15ZLCIgdv1oUeP2DRNVGSbfFB55LpJdUtbrfvQ
	 LXft7uJBB8MtjKTIAxStkfq+HOWrgLpNvMbEZa5ZW0LFC1URI3js5W0cD6lssKVOmk4dQ
	 lY6lrCAWtE8DinUyHIvcjJaPW1mGvTy3ktJrhu1VIPFwlTwY0l2GmqpeYeethoV70GbdS
	 XdsdnqiFgIxD8SYaVrrqOdhnuIHLBOBPuOvu/PHrlHEdHWGxb2JAF81+6j5igHGWwqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376928;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wjI02aEekAmmKt1UVJ6rqLVVhG81TsTdYiaIhoUVoAg=;
	b=0Ka1icg0Jffatv9z5AfyriS0zOi+Hcuk61vTqmTzysz2evmpMG4ud71Gb6ZqK5Sux2J5
	 x3OPrtQPw777ed/I5bYR0ijLU8hDX1pRD6FNl/dohOWeDB3/hPcf6uMg5SjdOw+YsML/q
	 o8LnbFKz0lamfJHgCFeXgjUCJ9e/w9T11x4lEKh4DeS2BaXrDa7eZbU0aaeSnt2GdofjQ
	 wfAhRIN1ZaG2Fug0SQ+A4WOe+W5UKMIGSIlmXHyRLTLj2AmqJi5KCbuYrpTqrgNwY0Kul
	 XjpQopBb3/D9R67Aw7IfrXu8ysNferYY2mASoZBgUaa7vr2AuEIxlIlpu6oxb0YpA2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXaTnVgz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AB606A31C;
	Fri, 30 Oct 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXaTnVgz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8EC1F000C1;
	Fri, 30 Oct 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376927;
	bh=wjI02aEekAmmKt1UVJ6rqLVVhG81TsTdYiaIhoUVoAg=;
	h=From:Date:Subject:To:Cc;
	b=PXaTnVgzRMdJERdpMD7D/japujRQOqeuPx2pXYVYccyllUngpyIp8i4ubx71o7kgq
	 fNlF+bl/bayR+D1kq6eUqxHV66JsPlYPiEPSQUWAX+SJDDcFDKmwzLgGquvGZQDfts
	 hm42uogwf0B4yGdSzjqkImcsRJz9d0+NAF0rtfO85hDFVzW83x+am/D2ZPlUiO0XQd
	 Yx13sfDqWsK5++XTcfpqdA0aEAvOmK6BqDcQDYu13Ul3G+0BHUq7htsHxWZfjE4kGy
	 0FJW0UX784dCJXUqEQSRmYs682qWB+reeLS1g84J1MsyQVSPtWSSwKH7MEdKPRZYHr
	 BRMa18Ebu00GQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:15:21 +0100
Subject: [PATCH] aio: don't let exit_aio() return before complete() is done
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBBEr1L220jSBhWvIkWy6cauQiLZWguld
 zexf/OGebOCUGYSuDYrZJpZOMUC5tCAH118kOKhMLS6PRndafVN+aUcJ0ULT/caMJztRZuhs2i
 heO9MgZf/563fWT74JD/Vo7pAJ6Qwu+jHWs1BjruxbT8nce2/kQAAAA==
X-Change-ID: 20261030-work-aio-exit_aio-bf74801d34b4
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Benjamin LaHaise <bcrl@kvack.org>, Jeff Moyer <jmoyer@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org, 
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iUUNZL+OIbGum+RlntuTW/ESOd0TNsln1fjEx6A9Xec=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OTS7oPLEVsV97y8GbI+/Kekya1bbfTUekdZ3+Q8rJ
 kwuyd7Z2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRc0wM/zRmZxy4e2GH8PXt
 G68ls52y3vJ4ZaGLyrzEl7MfphYscGJl+Gf2/P3GeVcXpOi6MFSl9nClzTo4S5Rf0X+WpGlJyrJ
 P9mwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

exit_aio() kills all contexts in one go and waits for them with a
single on-stack struct ctx_rq_wait. The count starts at table->nr, each
killed context drops one count in free_ioctx_reqs() and exit_aio()
subtracts the empty slots afterwards. Whoever drops the last count
either calls complete() or, if it is exit_aio(), skips the wait.

With a full table skipped is zero and atomic_sub_and_test(0, ...) only
tells us whether the count already hit zero. free_ioctx_reqs() runs from
the percpu_ref RCU callback, so if exit_aio() is off the CPU long enough
the last callback can have done its atomic_dec_and_test() but not yet
called complete():

    free_ioctx_reqs()                    exit_aio()
    atomic_dec_and_test() // 1 -> 0
                                         atomic_sub_and_test(0) // true
                                         kfree(table)
                                         return
    complete(&wait.comp)

complete() then locks and writes a completion on a stack frame that is
gone. So hold an extra count for exit_aio() itself. Then the last count
is always dropped by exit_aio() after it waited, or by a callback while
exit_aio() waits for it. An unprivileged user gets there with four
io_setup() calls and an exit without io_destroy().

Reported-by: Kyle Zeng <kylebot@openai.com>
Fixes: dc48e56d7616 ("aio: fix serial draining in exit_aio()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index bf002a9d2ad7..8cf02878a3cc 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -961,7 +961,7 @@ void exit_aio(struct mm_struct *mm)
 	if (!table)
 		return;
 
-	atomic_set(&wait.count, table->nr);
+	atomic_set(&wait.count, table->nr + 1);
 	init_completion(&wait.comp);
 
 	skipped = 0;
@@ -985,7 +985,7 @@ void exit_aio(struct mm_struct *mm)
 		kill_ioctx(mm, ctx, &wait);
 	}
 
-	if (!atomic_sub_and_test(skipped, &wait.count)) {
+	if (!atomic_sub_and_test(skipped + 1, &wait.count)) {
 		/* Wait until all IO for the context are done. */
 		wait_for_completion(&wait.comp);
 	}

---
base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
change-id: 20261030-work-aio-exit_aio-bf74801d34b4

