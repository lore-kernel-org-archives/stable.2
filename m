Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836293;
	b=eKI1DknuxpUkNz0NT9OQtJRH0r/dmWnoU51JiRdZXiMKs7JHgaFkT836NXXZ6YjlA2v9
	 WH39yB4iJ4T6ukljzoHwKQ7YfxoI4LY+0LflO4k2dyJ2A2jgRv8pdJBCsY+SWTclkURI9
	 xl3dil5UQ7B5xqjHRRm/oPLFSs6tPY8Pey4UcrwyLd13gLZxnglCOqdznhValIh0aDmDw
	 +kmN/K9YSPNdzzCnQ8UNqb8x7X/idVYr5nm+19MonTg56WOOJNb8KVHb5p5RtCUs8aLMt
	 GAMfFSWLrCLo3m5Q0SK9m1BkxynOlHfNKnZs3r9KDYPIFn9tava9nMuFF13wG4T7dgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Sfry1kHkGoI00sEuShgmwRE319huUyE47/fhH9PZ1BI=;
	b=r2ZJrDlxHQUoUOIF3E6iJzyq0rj1kk2WWGkFm9UQV7CKyMMjxX1Gp6JfKQIdFU3VSZmT
	 no7NNs2e6hzhNpk1W6CPrflrIO1jZN5PbkdhJVZIUOtVqpCpa1CB0rGVrQA5SyfaortyO
	 Ljnmz1XZCwhGwp4Q3RKzl+f3xkA8v7YqTitJxJk6D6U4SR4QS7aj/01r5yX7iMfaJf11Q
	 CKy8cgWcLfG7IcRUprxzFX/Yo8RbEjuWe3/L/2RYvD2FvxC7giKyqyxwhmKqzphJtRN9z
	 QTgMnsXiG+ljjwnTFDzDt44Zg5Ui0DgpwekB84nCEqIOZyvgz0m1H6bDnYYEVhcvmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4mTzMnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4D606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4mTzMnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D81F000C1;
	Wed,  4 Nov 2026 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836292;
	bh=Sfry1kHkGoI00sEuShgmwRE319huUyE47/fhH9PZ1BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4mTzMntw4qHEogkpu7JKztYTZUhg6YgDJdMYL6xgiFs4uZ+iIKAHH9ZPYzP4bTpj
	 gBWDypyvIWV0mLBteFLD3wAHC3PR15uV8X4BGaOUZY4oBNNHPjnRJ9Fmhehnn5RTBx
	 0J9ZOuGnC96LE7iUb6miFe+YlY7sa+jwi2F+n3wEoOnh38Ww7gSC3zZNn+vjfl3+7T
	 3dfmH3AkoiJYpHhR1Mew6I4W/uIiXOhcXys2cu44GvisFnsC/NUd8qwk//Y0RzimZT
	 DdSj5k3npJbbxf6kutXnWewIYQZm0NeTJxUqa3QgzwO0pLUWre2Jm1gT95CgkzrtMx
	 VLcjkSEMR53gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
Date: Wed,  4 Nov 2026 18:51:30 -0500
Message-ID: <20261104235107.950691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110426-scrutiny-value-3242@gregkh>
References: <2026110426-scrutiny-value-3242@gregkh>
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

[ Upstream commit 63069b5917cba2e15b1a78b3f4ff99e45102c56f ]

The MFC watchdog timer (s5p_mfc_watchdog) is self-rearming: every
callback re-arms itself with add_timer() and, on a timeout, schedules
watchdog_work. s5p_mfc_remove() tears this down with timer_delete_sync()
followed by flush_work().

timer_delete_sync() dequeues the timer and waits for a callback that is
already running, but it does not prevent a subsequent re-arm. Because the
watchdog callback re-arms via add_timer(), this is the wrong shutdown
primitive: once the wait returns nothing guarantees a just-queued re-arm
will not fire later, dereferencing dev (clock on/off, deinit_hw,
load_firmware, init_hw) after video_unregister_device(), DMA teardown and
s5p_mfc_final_pm() have run, a potential use-after-free.

Use timer_shutdown_sync(), which puts the timer into a shutdown state so
that any add_timer()/mod_timer() from the callback becomes a no-op and no
later firing is possible. Switch flush_work() to cancel_work_sync() so any
watchdog_work that was already queued before the timer was stopped is
cancelled rather than allowed to run to completion against the torn-down
device.

This issue was found by an in-house static analysis tool. No runtime
reproducer is available.

Fixes: af9357467810 ("[media] MFC: Add MFC 5.1 V4L2 driver")
Cc: stable@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted context for del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index e30e54935d79a..1386208b092f5 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1454,8 +1454,8 @@ static void s5p_mfc_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&dev->mfc_mutex);
 
-	del_timer_sync(&dev->watchdog_timer);
-	flush_work(&dev->watchdog_work);
+	timer_shutdown_sync(&dev->watchdog_timer);
+	cancel_work_sync(&dev->watchdog_work);
 
 	video_unregister_device(dev->vfd_enc);
 	video_unregister_device(dev->vfd_dec);
-- 
2.53.0

