Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834629;
	b=g4/61xf9q4I8v8dGjOhVNiZqneV9osQXeRi+cw8zfp2HBNe7E0v/Y9tqdT6UnAVASnro
	 XlGb4NJkgBOgYuNOcM8xtLsfmnXBLqJC9zjNGhKqrMsI5YA/z7R6axmJvhLx+4XSgf9fg
	 ijyd9qKeqVcWy4VdewxJug6PIFb7qe6ymEcn5WjqOdwECUsjlbhUFXaqdxkFXMvbUy/XG
	 k4AGMXu1Ov1anlHp09XR8K7rHQjKs4j51a5PF25srultFV9YXH5yEcsIxj+pKEuiiUcex
	 ZL0pAHmQQV24RYydgJr0ZlztuE1jdeCZk3RxuY3blfSs4LkRfPMW5BqgvCZLn36jdlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KfVheouHi+1GThaJVmkKTNEYMohg4ChJ8TYrxBe+kFU=;
	b=GswhUzNUmQrm2pvuI9LxcEmCLtLhhBM6Q+tt0fFU+jYQvgmpych79sPh6B5IliFxY16L
	 +987v4ETiXiPZiCOLtEl6U9PEB9yEAiKY6J3Lw9aWNFb7BSmQ1M7EoW+WyAAXXqLHt2OS
	 tHsCiWaEhvRWIhIh88WfG+jqjRDHkXjXk3FCAMgcI8woakUxds8I/AJGltOjRwHcxYRR8
	 eEzrOAwbEkkWI5Z9jZt06oLWaUgKVm9yQ1eRr4NP201+Ko0NiJaPsy9OZPJeH7NaVMQAx
	 QGKbwi5QQOre29AaUhbp7JayvS79XLp7/Z5Z4QYhLySmuBglyxJ05T52R+7wL+SLFpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uv1wTyY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F498606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uv1wTyY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42951F000C1;
	Wed,  4 Nov 2026 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793834628;
	bh=KfVheouHi+1GThaJVmkKTNEYMohg4ChJ8TYrxBe+kFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uv1wTyY0M70fWEkndmoyrDUEWp/gtcv5Z11FhSM5dq+8SVFpS/VcBL+01URXB8FOs
	 dWnuuIzXgqAo99ETNTwvmFzW/OB0oZS0oL63ILxlKXn75qDkbO4h/7yH1KZw07DWj5
	 ol2lPSdzXt9wavm5gyO5Adpx9+iGTcakGQtBvapOUa3ev4FnRIz2fkvNoK0H0LrjUl
	 FDxmGeCpoSr1xi+ayDNwvU2qGzUgH1yFiS2Rc2IAiIYCGB7tl/CxeNlGzAstFwKOsL
	 IpAvPtt+kEzg74hqk2PUVLceiuIHbdmH3PAGiGSB+dC8ujbHbyJnTV/q6nDESOdt69
	 SqCwPNqcUOnug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: s5p-mfc: use timer_shutdown_sync() for the self-rearming watchdog
Date: Wed,  4 Nov 2026 18:23:46 -0500
Message-ID: <20261104232324.887984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110425-turkey-reissue-e353@gregkh>
References: <2026110425-turkey-reissue-e353@gregkh>
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
[ sashal: adapted the timer replacement to remove del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 50451984d59f7..eb844ddfd8a2d 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1458,8 +1458,8 @@ static void s5p_mfc_remove(struct platform_device *pdev)
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

