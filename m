Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047461;
	b=3iG9+SOXCPKlHI3EwQ1U4US6v6bzkba82ZvGUgLC3azKG7T7GPVFBNgSJ6R1DHFnF66N
	 qtQ9Wa7c9eDDUeZ6ULaG/pJzYhC6cJKsGErfLW+OSRFc+XUJ3Pf6uvSRUCnYEwedRjWOU
	 Q2cnKo5mEVBAIE8kZR/P6obqeLSfj2uPyFxmtBEgDID+HKophF6k42Aur82z8vBe2YNBf
	 hvTV8zhVYL1VDXTm6oxTAHt+7cZhhsu8BM3Rqmajq+91vNIokObCZTdwLEh7k6MwbbokX
	 SzHMQoyGDdmmJfkhgEbzvTX9mQT96SFJYxDZv3TDt/4/bM4frxlVpL07Tna8HADDeIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0ONA/zG3ydSz1axL0sWvUzYWF3ckl1iDb9vpq6h/prM=;
	b=NYXK51SczOwlyzDMvTaor1k2YLmiHcgXbZa8b94IYeEDqDqZxnkWqQWu2Ybj6v5rXXzy
	 su49WQt8+MTdfBOV/dbbqSbDUDkg5utAIBsIUquMSRN1rkRiqMc8gCcl/983hbjF8DF9A
	 QJNzEesGh6OuTpsmOy5fdhnyBO+WJzNmBKrLNfqsgNRsdi/oEdT3NBeQmnImZ8MrOL4ob
	 oNhbRbOyluYsSoTZN8PRLYoQnGskCYQ3UH+xYoMWStGP4LJ8UkN6LU+baLMJp4MY7mBL9
	 HIAuT/9vEglS8McJ+5Yxqh1joMX2I0NpYA0D7NxjYBE7jFiz1zkPM0aFfFFQBZq7plg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPVt7DQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47704606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPVt7DQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9C1F008A1;
	Sat,  7 Nov 2026 10:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047461;
	bh=0ONA/zG3ydSz1axL0sWvUzYWF3ckl1iDb9vpq6h/prM=;
	h=From:To:Cc:Subject:Date;
	b=TPVt7DQRaiX44btW264/+SgqdObxJnLruliXwPP8dcYMbtzfBRduf3HNPR3vsnzWU
	 udciXT/rEAn6uKLQ3VkpO4Qaa0wggMvI7suHdb0GryVBRCM/k0EsWLs5oBb/DwP9Eo
	 wtmsrTqseG0KgtTCnm78BuOOqWWhplbWQlJ9rqKw0Ni5czHBJ0TuwQl4TG9aryH9vK
	 LU5N1MrKV9SXhNzITfuA3DOwf7XsJ2/Dylfhkg9X9e+6XZgAt4TmBw8WYtxHSsnpFz
	 IljKATg//8bIrlGXawwFDl4x0YnobR+2AHUacQvsUSeNdGS+oFoBJkFFXSQnf/6auc
	 plPoBGG+Prvgg==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	rob.clark@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:59 -0500
Message-ID: <20261107053059-failed-6.6-ab91ba61871a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ab91ba61871a896ca2ecc6e048d80a152136da44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053059-failed-6.6-ab91ba61871a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ab91ba61871a896ca2ecc6e048d80a152136da44 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 17:57:38 +0000
Subject: [PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()

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
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index b292dfd266d17..d92659d80f172 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1254,6 +1254,8 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 
 	if (IS_ERR(data)) {
 		msm_host->tx_gem_obj = NULL;
+		drm_gpuvm_put(msm_host->vm);
+		msm_host->vm = NULL;
 		return PTR_ERR(data);
 	}
 
-- 
2.53.0




