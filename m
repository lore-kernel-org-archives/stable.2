Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844098;
	b=zbP/lVSzlkyUlmw8TCd8AwQk7mnXdXNLKBtUmbMWE4ZgHtilJ4vMuSVXWRhszlrtBcDo
	 t8Jv4/w+baPsXpr31zGRf7G82WTqxD7Izf0l3xRwnCgPdxw8xVmqCeQsWMzIBFutSHbKD
	 RMn44UE049KXG2vW0HMRZhVLma4jQIQuBFiw+KKE88ZGNX7Tf5OFpx/eQk4qd7jM13Mka
	 7o/DITynvlui/BzSVWj2AxJEE/iF9fZLcseAvmKc9xKJt7eJlvnJtHFwINDgJ0E8fp/GY
	 m2zD5Khioe6tgDqQ6KltsKUxrHfWUO2mG8hUJARxjXJ1jD2UfYPfo4Dr9Li1rtTKJOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S/l1VS1esdpG0yBlCLYcsFUGZGZHIILbqdTFMIVJwwM=;
	b=3iQUrX952DcuOlgVRXoFvD+kWh9eIrmHscgnJ8DQZRXKsWM1gV0xQKcN/0dXPEkqn4ud
	 TjQFsFupOobhNekUeMN3oPSMhl51myYPlIVVg8pKmv86Jntoiw07us1jp8rY4gEwWFfnI
	 qExaxLyQ1h3J6qgHy6ygp//IVR3ug1lKfkcsEjlMKZkdfXxf1jgyVRwRTiAmyesVSN2Gv
	 ik6NvxYkaOzHy6YzEOiTYIcVc8dxjj46oU57iO76Cwgkjl7zj0nP+O2bcP0TlA/9GlW5a
	 dQkiMTKeLCPUkGK6Rtb0WP8BWs6BFF6Bjtms2DpXP52C86uGRAgbNDKZ8HTuoTqISoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHcm3xdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D860779BA
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHcm3xdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DD11F000C1;
	Thu,  5 Nov 2026 02:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844097;
	bh=S/l1VS1esdpG0yBlCLYcsFUGZGZHIILbqdTFMIVJwwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHcm3xdiPE2bC7sT/zyE/eSH7wLtN5Y3YDSKRkofOMNu4kZR1q1vzGQnX56C/D3Mu
	 R7XNyWkI6DOmXM8Ri2YZ5IxvOK8rDju3G/cBijcbL3yngEWXHbcr86z3ZaqXWPpfjA
	 71qAHWDJJw58lIaK3MVrw/w/kxF5Jf/lqyR81IawbbmAr/qiyVBBRiJqdWLCw1n8jr
	 JhDO2zdewYCEoe0EEMZl752d4NzjAiMzN8YtQ0kgevBkyiKYLlB1rtrpInj/gMYbJt
	 DFpDNeKMRGjvJmeyii9sYaQOVoRK9AqKc7W8SoOF5Xs0V1B2vGdE0nKqjXVgHaTxac
	 e5c3qHjAoefTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
Date: Wed,  4 Nov 2026 21:01:34 -0500
Message-ID: <20261105020041.1022704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110427-decoy-mayflower-3cb6@gregkh>
References: <2026110427-decoy-mayflower-3cb6@gregkh>
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
[ sashal: Adjusted context for the existing del_timer_sync() call instead of timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 4c511b026bd72..36cc6c85a5c59 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1447,8 +1447,8 @@ static int s5p_mfc_remove(struct platform_device *pdev)
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

