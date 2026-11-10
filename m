Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320826;
	b=2x3l3yLQYkpFoK68OtiC+W7ja74VjO0tw727awH9N1Kmk9pFiTlTIJ71mc8F2jV6kOcJ
	 ja4BI9ZQaoq99x6s2cmWV+wrH15OVeM2hG9VC5p5hC/YDJJ41QkpKozDp1OUavEBS+23z
	 JLuCBjpUHtAUNt2zl2Cyew9Ckr0eFKSRYvNnzWC3gOklFbxHtY+xi0jmLl3GXBIY2siBI
	 wSsBPI2LIRPZzj4KW5fAVwcifTuvqUEgPp+Bkocds72Ste5hY6cfzTY5wWX8RNimYN98T
	 G9KbW/OCpknz70Tbk8rCIUAxq0lWOr7OlIDzVp5YASJHLioDSqgISipkmXVwmlCE2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8cwtTP/cP2BIFCMbNjoHR5BovC6tPnIS6SlB8tplJqc=;
	b=fz27hsnUv7htGQ1Gr+/QefUGBnjrfFS9KFkE8n4tZ6Oz2rdotz+pvsp0OHkjb3Q7ss03
	 wvgmONxnPzEEwaJDNU7dHaWiJzdnaCrPTGiZJxj7WPVsTkdzdANxjvu3L/dDaDmYRHqMk
	 YST+BHxHlR8PrxeX61fKvaivbV8QBAN2sN0lQC+ps3pateuF+ThIaucasp/Yvv934iOsb
	 X1U06+xgCcImux28wvtRMmY66BkJTlUWUqTAl5yTO14DDSSIYBRVpK14/dczf8TCCyMYR
	 3iZUEDZzHgrcC82g/anrG0wz8p7PknA3JGBlmg7sVrIPRH2RekIr9Pmd3jxX3KUnHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0hrfcxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0hrfcxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CB41F0089F;
	Tue, 10 Nov 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320825;
	bh=8cwtTP/cP2BIFCMbNjoHR5BovC6tPnIS6SlB8tplJqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e0hrfcxMA5t4tMms7LiqaEQLnm9SlqudEJ4EOYvbFzg39iA8KWwBKLlnhrJ5vjs9d
	 ppFvtXN9TpiaaGLW+17H/1xFjR65sX5bm0iUoh+XTDrBNSRVmIg9zfrXlkkXJkgA6z
	 bql1mVd2vck/KH9By3DSVPiM1e4fKdU1DpQO1Gdz2teXZsZE7nAQPZ0py6C2Bpt8kg
	 dQFu8+3g3uU4a10s0s6j/QT1joPsIXA2UieqrodnPA8eUjt3zogqnjRCJqAS1l1/fI
	 xvY/93iyMQKCFzZrwKfRKJnrX1CCGQZMLUNbvhrvc4KHQy92jZnX/yFGQfO+ivu4SX
	 kjLmuNRKIrLKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
Date: Tue, 10 Nov 2026 09:27:03 -0500
Message-ID: <20261110142638.1874788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051828-failed-6.12-ab91ba61871a@kernel.org>
References: <20261107051828-failed-6.12-ab91ba61871a@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit ab91ba61871a896ca2ecc6e048d80a152136da44 ]

dsi_tx_buf_alloc_6g() takes a reference to the kms VM with
drm_gpuvm_get() and stores it in msm_host->vm.  If
msm_gem_kernel_new() fails, the function returns early without
dropping that reference.  Since msm_host->tx_gem_obj is cleared on
the error path, msm_dsi_tx_buf_free() will never see a non-NULL
tx_gem_obj and thus never calls drm_gpuvm_put(), leaking the VM
reference.

Drop the VM reference and clear msm_host->vm on the error path.

Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/754332/
Link: https://lore.kernel.org/r/20260916175738.2089950-1-vulab@iscas.ac.cn
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
[ sashal: Adapted GPU VM cleanup to use the older msm_gem_address_space_put() API and msm_host->aspace member. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index cd605c75cef8e..ebd9dfca6459b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1205,6 +1205,8 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 
 	if (IS_ERR(data)) {
 		msm_host->tx_gem_obj = NULL;
+		msm_gem_address_space_put(msm_host->aspace);
+		msm_host->aspace = NULL;
 		return PTR_ERR(data);
 	}
 
-- 
2.53.0

