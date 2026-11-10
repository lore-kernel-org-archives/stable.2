Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312649;
	b=cSdMHH2oBJ+tcMMILHrTokCZxMJABtjaAcf1qf2LdTKlQWFJby0sbY7xQx2wfmr1RxeR
	 RXSaOf81IoDyXHlwnT1yflAbAtkqxNT3JvxDRxW7VUF1eGS7HGJGTDqNTy5z9yufnCe1r
	 FAvBdqtP3TpI9sO543VETX2ugykg8EoX/6pWq4jkcUSBTEweYjbKlRXR9tmvSU/qkwVt+
	 TtgkuDlOvCOvENTkxgFBpPGG2knigrKJqLe3bdHviLXFFtf3Ub3pi2axIeQC3O/OGgGHi
	 l2VYzNLPcWoRumTuUcKc7R3GAXW0BvITpD5cAstJT6c9uzxnP9/uF/15D+WHcXrpaBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gVSc7m1qOGvW0kJ8iTaNHPYaZunvUHHoF0PLPOvuuy8=;
	b=PBsyuGI+gFVzk9qB5NyV59fYEvizkV5Epx2pC4SsLpXO/0fHLa9aDgJrQjzxkSkb/fuy
	 xoPB5DY2MKBuevYzQet0h7bmttabWO4EV2OpJqYc+mB0V+FTVJ2r8K44PjfPyIUy5waWQ
	 y1P1AiBGPKChXiIivrdAWwArGaaR1YS9YNGCZA45kMMn9c3Scz/F9glY+Mx0uFbmmYBrF
	 WT4WjqIgA4/KpeNUVVpTk2/Eq+IGl9eD/IVJJEhJ5GxLr0l6WmaqkzL2s6yc0jU2R27hZ
	 hn99YGCLUNhti6TBZ3pFWCmz5xEpwHAeHLNU+isLbQ92ZYcd+v9gEuOYzQ2wdw2LyqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecI1VUxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8A606A945
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecI1VUxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762311F008A3;
	Tue, 10 Nov 2026 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312649;
	bh=gVSc7m1qOGvW0kJ8iTaNHPYaZunvUHHoF0PLPOvuuy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ecI1VUxN4sSn14q1OqvUhnPPG0IBAVIx5Sw2l4bgzfsBqGQfd18QQYDZAWdzSYqfx
	 pfBqpkOlIRrVw74HSQz7Vu8EzvZSG1n6AQ6z/fr0NFLQFmsL3owyd/ayMqwACLeR0k
	 rHj+ofWCEJDHh/6A+PR5NvVStok5JH0hAjmN0Q5XD4PcOFasaC8E5iecIOtUQPPWrS
	 OqIFUHGIo6QTweA2czh6WJCaBG9nJ4NYRncXhhmUhBNBSn616bYyWxYh4VHSDniya2
	 dyQHROgQb7CYvsKehaHEig4YrfS4QYV88BFvrCAq0iKmLdVoUTVwii/rAeGX5DzTpZ
	 1CSB0i6z+siTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: mediatek: vpu: free IRQ before destroying watchdog workqueue
Date: Tue, 10 Nov 2026 07:10:46 -0500
Message-ID: <20261110120942.969538-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110120942.969538-1-sashal@kernel.org>
References: <20261107060149-failed-5.15-2c50b58d4105@kernel.org>
 <20261110120942.969538-1-sashal@kernel.org>
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

[ Upstream commit 2c50b58d4105f6dbaa36d6306087954b9100e9ae ]

mtk_vpu_remove() destroys the watchdog workqueue while the interrupt
handler requested with devm_request_irq() is still registered: the
devres core frees the interrupt only after remove() has returned. If
the VPU watchdog fires in that window, vpu_irq_handler() queues
vpu->wdt.ws on the already destroyed vpu->wdt.wq.

Fix this by calling devm_free_irq() before destroy_workqueue(), which
releases the interrupt and waits for a running handler, so no new work
can be queued while the workqueue is drained and freed.

This issue was found by an in-house static analysis tool.

Fixes: 3003a180ef6b ("[media] VPU: mediatek: support Mediatek VPU")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 1657575346735..b10102e093f4d 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -966,6 +966,7 @@ static int mtk_vpu_remove(struct platform_device *pdev)
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
+	devm_free_irq(&pdev->dev, vpu->reg.irq, vpu);
 	if (vpu->wdt.wq)
 		destroy_workqueue(vpu->wdt.wq);
 	vpu_free_ext_mem(vpu, P_FW);
-- 
2.53.0

