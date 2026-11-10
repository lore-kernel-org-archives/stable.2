Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322415;
	b=Pyimo8tDt37Lq+JJoqdD+7Ui59uxYQMOsRfo+EChKu965F8WNOaisoxpkEnMauMCgJWX
	 HVXByMRzCzswRnWvOJPVEcgYf7d8IARPssofovSn+0R28ywQ2IAdcDftqMyRDlhV2pM+6
	 GoKvQ9iueZWtWlQFoeG+Lm/C911OAPtyNeeKRyUG08M4zrXVeXcwPR/xMESVbHHESD1ou
	 MdjFDjKUbMk54zW/deMoT949QJWMwX5MNC7EpsG4IcGsNK5PAyy5sCscEROSQ2bUoRb5Q
	 bXbhbbAGThfq++cVXQPyQTwoiX+QG/4YjJ5+O0BIctdyglyKsaSGslvUsi4P5tEZ4eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322415;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Iv2AMbcUp3UJegJFv/wi0SBKKJdogezfuPX3iQWAlxo=;
	b=eUY+XtRD1bVr00gJzFdyNjQstilLYGIw6CKdxl8XPXzZX0DFSfPTJ7ojk/f8vWIE6mY8
	 4AqaFTplkrkVuYWJmolMR8ZGAzz+4MWwdNwKqkYJdxpT1xa53WUwJ6ds0YPW4c7esl6c3
	 rA7aU1bjKK86yyMqnXz9nONjiBc1JXUIa1nEBuhOMUS+sa6f0RNMl+EpD1RjYzLPA4AFN
	 2uQ7uHXieaajZqh7zFT74Jki76NewdmPYF2cwvjR/RvMd3lscl2vwO66mZe9mWWNryqA3
	 2Qh2gyTcJqYEqjvRaJ2t93sawMqhkKN/gtPr/uBtnpjSCfh/iI3oXT1hYRPQihSzl4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+eUA8Ww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE840606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+eUA8Ww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84041F0089F;
	Tue, 10 Nov 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322414;
	bh=Iv2AMbcUp3UJegJFv/wi0SBKKJdogezfuPX3iQWAlxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+eUA8WwMYJrseExT1LwhnJcrh+4TB/L3ZnWW2WuC9pyL+zt94kJ/e19FPAPt4wOf
	 gM2KO/pcZXBM7YqxbQZ169vy2l6Qmhn2arECCYer8JRZQ0sZ6lCrhopW07unX6VtS/
	 DY65+oOEIexvIzzH04Y2oSdAfIlVLNAN8eWjSfoSoHx0E4ilrg2pbmiO6q7ydidTc0
	 cArEUIzRTC89/+Ex2tpF+IP0qidid8nMDwZGMMeUJjgQXE1cpni48BlKZpCTAIUm0R
	 IB+AspFBCoEyQyOcU6eRhIW0k5AhL445MzE5EH+Rozo9ySR94gqzQd+pw7+LdPt8Nk
	 bkIKRqW/fS7PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
Date: Tue, 10 Nov 2026 09:53:32 -0500
Message-ID: <20261110145310.1958008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054340-failed-6.1-ab91ba61871a@kernel.org>
References: <20261107054340-failed-6.1-ab91ba61871a@kernel.org>
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
[ sashal: Replaced drm_gpuvm_put() and msm_host->vm with msm_gem_address_space_put() and msm_host->aspace. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 634e42630dbf2..5a2d41ba37b78 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1147,6 +1147,8 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 
 	if (IS_ERR(data)) {
 		msm_host->tx_gem_obj = NULL;
+		msm_gem_address_space_put(msm_host->aspace);
+		msm_host->aspace = NULL;
 		return PTR_ERR(data);
 	}
 
-- 
2.53.0

