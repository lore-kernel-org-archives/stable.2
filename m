Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837327;
	b=aKqwuYSlM418h7T7IsC2k6FPPc/JSTiKGJ+yHoZEjQsYNH0kOUsBsaPR8l0Cp5LeHiHC
	 RNZVj5+Q9Oos7FC+bCGzZM0jZWOr5XLLjzBrPidNs4eo3qkHdadO7IM29jkAFTacexst0
	 tMB4xPdgSJWa0fNPQArOk/UQ3jKBs2hiMywX0upCeA8QgsPfRW+DsKwcqRh1wfP4cKZGM
	 RxQoRJoDv1A3VpHzW4LRRot7bW7iI2EP0RdyKcNiD/UPA5+tUD6BowjHGZ/mni72pvVM2
	 6rbfT90iXDeeuJi6kc0yYcTqK1VLHc41XrrvOa3aVi6Kcj0FvzYJi3Yx7/2jESeZmkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837327;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SuOJyNA0nLaL4cZf2/3rcrm+4ic4letafFwz7L5lluY=;
	b=AkZeW9PwIZEewdfe/9kYlHV/dhVzM4Sm5MN8EAiiLCHg1Tf+dQzZ3w1TR6zG52YMfBfv
	 hj83Y0KUL8/ovqEbZpXWxvuINDY4W6kqh2b32zd2MCJToEMo+7rbx+b+XQgeduo+Soo8M
	 e2lZpD7iqiGJPEVs6AQeurCV6k9adbX8ssXWyIcJnByz7xtwUkrLKnKBW4MN7+Jx+7gN7
	 JaFCOf9PpHJ/xL2IZbfVr2+7kFfzH4t96hcOB5kqX3j42a7t8BtWx1dmiijZwq40CLCa+
	 eWbNQ0/k8QZfAsVq98wdH0yuobz0rIBVp8yqGfftwd5EiKtU6G00/hss8VrMfBwo0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9Ye2d9+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4F606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9Ye2d9+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E011F00919;
	Thu,  5 Nov 2026 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837326;
	bh=SuOJyNA0nLaL4cZf2/3rcrm+4ic4letafFwz7L5lluY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9Ye2d9+gQpBrdYL+vcOiUVbQGdugfUyBwhmPjSGoWgD9Wjkw5+PdvyZO1Hywj8di
	 Efq+tDzoSCAxZel2AmqdCkXd6QPcUIS7oTzpCyWlqRH8CVCXl9gOzGTY83HMk0iyJf
	 x/YYXdQEGFDdnLLx7TWyNmUmrEDkeyaYoOfw1xq5Cgc0XLm1csubssxKjbQ5vDUhnt
	 +1QwtoGdkVq22lDmpjVAIUicXvpG30y4jBHt34STFVVeE/x4MKM3zplg1MiethGq7g
	 InPZ1TvOAHLztySUpMUHwkCy14DEUPKrB00Fbvu+dnRLlSRTviAG8Q6QJji7l0o7ts
	 jW7GQ/pWWrhcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Jamie Lenehan <lenehan@twibble.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: dc395x: sync the waiting_timer before freeing the host
Date: Wed,  4 Nov 2026 19:08:44 -0500
Message-ID: <20261105000818.977002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110422-glamour-fetal-620c@gregkh>
References: <2026110422-glamour-fetal-620c@gregkh>
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

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 0b1a79f2791a06f139dce5450e487307cf0e241f ]

The waiting_timer callback re-arms itself and takes the host lock.
adapter_uninit() currently stops it with timer_delete(), which does not
wait for a callback already running on another CPU. The final
scsi_host_put() that frees the host (and the host lock the callback
dereferences) runs right after adapter_uninit(), so a concurrent or just
re-armed callback can fire after the free, leaving a potential
use-after-free window.

Replace timer_delete() with timer_shutdown_sync() at the top of
adapter_uninit(), before the host-lock section: the timer is dequeued,
a running callback is waited for and rearming is blocked before the chip
is halted, so it cannot fire at all once the adapter has ceased to
function. Waiting outside the lock avoids the self-deadlock that would
result from syncing a callback blocked on the lock we still hold.

No shutdown is needed for selto_timer because it has no reachable armer
or callback.

This issue was found by an in-house static analysis tool.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Cc: Jamie Lenehan <lenehan@twibble.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260911020544.42966-1-fanwu01@zju.edu.cn
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: adjusted context for del_timer() calls instead of timer_delete() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index c8e86f8a631eb..312bc719c56ec 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4411,13 +4411,11 @@ static void adapter_uninit_chip(struct AdapterCtlBlk *acb)
 static void adapter_uninit(struct AdapterCtlBlk *acb)
 {
 	unsigned long flags;
-	DC395x_LOCK_IO(acb->scsi_host, flags);
 
-	/* remove timers */
-	if (timer_pending(&acb->waiting_timer))
-		del_timer(&acb->waiting_timer);
-	if (timer_pending(&acb->selto_timer))
-		del_timer(&acb->selto_timer);
+	/* Drain the self-rearming timer; must not run under host_lock. */
+	timer_shutdown_sync(&acb->waiting_timer);
+
+	DC395x_LOCK_IO(acb->scsi_host, flags);
 
 	adapter_uninit_chip(acb);
 	adapter_remove_and_free_all_devices(acb);
-- 
2.53.0

