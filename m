Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837335;
	b=b/NT3IGF7/hIEBEVJ1uOQq/wOmv3mZr4s9Ac5wHMjB3vJIkz8CGRpi8UmAuJJ7UoeS8M
	 vHf3NriePG6uXKLo1TbN395mIOro2IuChRCgZgFMbyu0o+8J+N/3Z9bHA/flYISXQ/UaJ
	 6ZkKhICiLomoGQGlCFkd/bvhZinr1PmZ5lZucGZblO3hFuy6GHmvHpU7Mmuh76+DPFh8Y
	 ZCbNNpSWFSGT4g3k0et/K5hQMWo5XS5YQ/7Uh/jbNbf7LAUTfr11tY5hErSeTzlGASqaY
	 RaTUhgY+kJoTJnIh1dkZSB7oZ7oTy8AJxHmLfDH9M57ZKvm1QzcvWYW+kmPL2RpqX+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nc6uWQ9nbl/Btn1WQ2V25dWXJ5jW8ALdsswrOS3YJD4=;
	b=Jomy2APMdZVxQVeM6/xRMkn0ajNl8YYyhdlRV8HMo1VjAvJTC2Yf0eq5lYNTX24A3P8d
	 yZbj0dT8LKcLmGQbtpbr8SQ5SLm73Sir3G0OgE5fZdGCeO8yr/UVwoVQ5fOqqib+f3S1a
	 t3ydaPYJRIlleisjna3sd1l2h0QeVLjDU4r/VqJk74z2UzyW/pOQsgWOzlwybW3p58ESx
	 VbLPqnQpDNOppRbXQ3meZnj++8zZ/JF5GYu15lGdC9VEp2nldNYxiglhUADWgBbFk6lBw
	 50Hcc5d3Boo2kX+sG85RUY2SjrDGUl55vCU7M/VawoUotcsSH2vi1qDHpsobAGMVQvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGyrMcSQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F679606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGyrMcSQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EADD1F000C1;
	Thu,  5 Nov 2026 00:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837335;
	bh=Nc6uWQ9nbl/Btn1WQ2V25dWXJ5jW8ALdsswrOS3YJD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGyrMcSQSEt7SvhX2aIS/RPIY+ZT0j0elPfrl4JQeXVmw0XEodS8Fa2xvaV2n0H4r
	 qnOF7yhyiH76dzDIG6xbz65AnOfwFMPJ7uI0dqGCr19f4wdnG44LAzoYZ+wgPW4zMi
	 N33VTuqb++gl5IXuk6m6F3M7NXoIhx/Fz5ufuZPVLGLUPX9xOIWmWSnJgH1zhp3QTU
	 0e8ndIX1qZ7eByo9aqEgkZ4zvZip82v8bheqZJW11hxG6hsP3Cv7Wi+2wD7e/DJ2Vt
	 WBkeaEmDbciWFGYK6DlZH7a+YrYOrKUelnuk3Y9wPL8EodYFmm8UuQPHNe4s8lypJ2
	 S0gPLuh7ibTzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
Date: Wed,  4 Nov 2026 19:08:53 -0500
Message-ID: <20261105000820.985309-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110426-pessimist-footing-003c@gregkh>
References: <2026110426-pessimist-footing-003c@gregkh>
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
[ sashal: adapted the timer replacement to the existing del_timer_sync() call instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 007c7dbee0377..58479d2a69fa0 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1440,8 +1440,8 @@ static int s5p_mfc_remove(struct platform_device *pdev)
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

