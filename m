Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321501;
	b=od+QYgmcxD80xNO2GzTAoEAfJKHw6cAVGTJDqvG97CPPxs1zvXhohuDFSZvdBj110kYF
	 ijbC/UwAzu8E3sWUtUzLQVDVHgWM/VEIzJOcHKk9hXtxBgOTnoiFH8snNZ3pCPxPPBM3w
	 6SJk+WCAmY/Ydx75YBPt87fFqqiRRG/CDa+C/3hplhlWB9iUtJgKDKO2ANAFlueDbuaux
	 ZjuO2hjPRNzK9vAlj3GumJD0e6r5Pyd1REaTQP0ojbkXhSQrLNlMYpD1fpoCcf5Qt69CU
	 KEa8Fx7psxJV0X8DpI4qe9ujN4sGK5UJyPhRyu03A9xgmXLRR7v/8g868uC5ZRVdB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uXhzKX7QH8ModkaNynrnU+Vmfq5vgFTpvU8WQs8VqTk=;
	b=nty/mRrRD/nI6rsAtjtYdh/eb9fGyNZGuTsSfpKf5ee8j2KHiBFh28Z9Jgp9k+46+Ewm
	 l++2B7fv4GqRMjRwvanywaGq7lB/nEpPZOeZiv7WElqbuW94CQWMjjfGSK0+gq9X1/xDn
	 B0F5QOU4+nQRdlp/QMXYmaL57GZg3MsLWcO3MXZzzqExkht7e9Bfqx5ie6R3gJlS4Bxck
	 nj97fINzhKlFHka/5s1GYpfDiJdwfjWNFeSwk3viLpr96rl5PhfsQS0A2Mgxx8quosQuG
	 311Oju6ogMVoI/12ahAOi2PjSUqmvlh7wfUJAaFNYafrvE1EugWmi3gHULXIwSgEN8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCgV8syB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A419606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCgV8syB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732DC1F0089F;
	Tue, 10 Nov 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321501;
	bh=uXhzKX7QH8ModkaNynrnU+Vmfq5vgFTpvU8WQs8VqTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bCgV8syBPxQS/Il2oWxKbvRj/+uax6QWrYpjCEBxjD/xYAiVUi9FssdzHTJwkABlQ
	 uID/VzBRBhYcbYyzpf/MNrC7dGdqc5mTAkdce4BgLdk2yayZ9JAF4Xkto0mIrUF3q7
	 d/f0w/iXcg+HH4Ss3lkPORe52x3tjKFrNA/ZyGR74zLESMsefoz00tJ9aH7HlfXtB/
	 a5M+vVDcnfdNWQNcXbSPlp5VYyfWFoo7tJZESNEWGyuQBMcB8yWrQn1ooQy5Ygng6S
	 X3JPHle+cNP1xip0tgAp4SW2dwxYVa6hspSES0n5s9nhxdbtM/DFLzciEkclJcdCGx
	 iI4cyKtWFXsOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
Date: Tue, 10 Nov 2026 09:38:19 -0500
Message-ID: <20261110143743.1919323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053059-failed-6.6-ab91ba61871a@kernel.org>
References: <20261107053059-failed-6.6-ab91ba61871a@kernel.org>
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
[ sashal: Adapted VM reference handling from drm_gpuvm_put() and msm_host->vm to msm_gem_address_space_put() and msm_host->aspace. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index cdc964aaf405f..cfef8d9067157 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1184,6 +1184,8 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 
 	if (IS_ERR(data)) {
 		msm_host->tx_gem_obj = NULL;
+		msm_gem_address_space_put(msm_host->aspace);
+		msm_host->aspace = NULL;
 		return PTR_ERR(data);
 	}
 
-- 
2.53.0

