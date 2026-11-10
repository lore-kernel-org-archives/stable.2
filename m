Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313061;
	b=AN3cqLnDjxhtzjIKIhHM3MdO0BpmZRmm95z3FpkWWIGuNdnrOgJZBWyegQ8Y6178pYge
	 cxyFzVvkrpQcPOkZcZUUucPb/gVAAjuJzhtxR9cvrBl35LGunU4Eggc2jdICo0p+X55k5
	 7Kn5KYLcvo0KeVwz2WkdxQMlUvOci9j9LPLPMC+T+pBMpTZlv216/khBum8N6oCdSlLz+
	 hxY1dcSdnvV2aRe1VoKiza9aCj0xYhx9hnTfD6dWVuA1A8kcqvQNvqR2TV1FBfCBd1Kkj
	 gj7DClw5O7FAPy57+ib//NNa7TsCD1lY4ZBdhQ41ZqhcLxIrPPlS9oPvYNkCyVftfeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313061;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KX6JlV6IGQsim866vXuaXSCrlmq6erpyhhkX1Qh3NNA=;
	b=QFlA54tCTL7Hmx7t/NsNJDdNFvAAgFuPihfLylFCYiCDcowIKtSzV1YvYP0KJ6I5z+EA
	 hCuWwcRSPZFxokJ98Rl19DYuusB7O7GXUag0OCIUstgug04FD7hK0XK/nXeZsdmwE8AHU
	 ZOSji1DE4u23oudCuiaR2r8RmnjBXrXprGUswsiw29T2J3DhTqrz5RkMZdnN2IxKLyuXg
	 ycz2J9xwmpWka7VF2eIoMTSYbgmhk+OEThaT9fGzRWbdeGZGeC3up0jqnayX5k5eKIMJm
	 ZPFydmkyTldB+t2iVzj5b+ZiilhrD1eS6kdiKsdbCBGYgPH3xXv82T8DEgUkvs7XF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1Btq6bR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09174606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1Btq6bR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E551F0089F;
	Tue, 10 Nov 2026 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313060;
	bh=KX6JlV6IGQsim866vXuaXSCrlmq6erpyhhkX1Qh3NNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T1Btq6bRkGddDRf7J+DqlWd2JTuqxDdCYGx6aKn3uVpbFl01G2ozyTpTI3NqrLxpF
	 qwUk98lXYofwvPw3r4OPB7fF04FxT3+lVgEbbYXEPFFMJbCgyoAQaH8VVcWbxTTuie
	 JV7k6JCmCVupjBkGW7mZ3XRIRfol0ir8S5OcqRJb+xVHUxwYfHot6kHWuvKM7ijIvB
	 iAFaOlZDq3m8l8Z3ASDApt0wORZRjjYZnkCiwr38QzbWqYNk8eT+stTJ9ku1FBNOuO
	 edIgD23efWwuiNIvnKDxzyad0WO70ZqCR+515/QxtA2yZezl6vsZtaKdqmzi1d3usb
	 PInyI9Z2/TUfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: mtk-vpu: Remove redundant 'flush_workqueue()' calls
Date: Tue, 10 Nov 2026 07:17:37 -0500
Message-ID: <20261110121716.1071164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061833-failed-5.10-2c50b58d4105@kernel.org>
References: <20261107061833-failed-5.10-2c50b58d4105@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 360c887a39cb56e75be4f558b16f1b6409ecb93f ]

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 2c50b58d4105 ("media: mediatek: vpu: free IRQ before destroying watchdog workqueue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 663694dff3ddb..98f043f1c8749 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -938,10 +938,8 @@ static int mtk_vpu_remove(struct platform_device *pdev)
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
-	if (vpu->wdt.wq) {
-		flush_workqueue(vpu->wdt.wq);
+	if (vpu->wdt.wq)
 		destroy_workqueue(vpu->wdt.wq);
-	}
 	vpu_free_ext_mem(vpu, P_FW);
 	vpu_free_ext_mem(vpu, D_FW);
 	of_reserved_mem_device_release(&pdev->dev);
-- 
2.53.0

