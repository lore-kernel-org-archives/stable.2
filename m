Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046710;
	b=XKhytkuL1Xh0RhS97Ji339xtW00bC+43a3KKbimSeqy9+mpQvHenI1wztWHDe5d31E5m
	 QNcmCapT8p2HLwcSh+V6pBoqgCubkEYCHO49PZmpH8rmGkrHZQaisiMGzX4hLHWa4T3zC
	 ucK4ifJCR6Mm4Xl+8Rrem/pcixJ0q34uhgfNrcuYK0i8ZK5O0aRyrg5rEPKRC4Ch0lN/2
	 12s+aaw/8XA46clZiriR2il128rO/ioQ5PHDP2NKxqOxvPhABSUGkFl/bNYVTPiGRCXvb
	 oHlEds7ITnK6U+6+svoT6B8jC4/JlMEPInlNGy/GZGXsarlY6JBZxYyXG2Q6z804NwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ybobppUYlqmaRCc0ft9A2VDbkpDN7qhtmEwoVE/fjqI=;
	b=1Z8mHxkozI6gCoJ1kBf8JeZKwpXaTy3fHNVSmt8IlhU2td0EoDpHJ1+n82sxC312ilUu
	 TJHISsf9e4HMH+dBf+gxVU3jNN4OhVEvLdp8wRWFB0zocrOHPyhVgrw9MejWgC5ut/1+8
	 6zvHDCsxk0wMFH4Xt1EDy63p8vsLSS8tJr28opJ8e9c6cZhpz+RynTe98qKynf3IRb+Sq
	 B0LSHoYdaKG4DzWG5wM05iovgObj8mNryh4+KfJT1rXhkBZwIm+SvOixpAhUUZcyolv/K
	 GUl4VG4ihYWlHEqAPeLcXaOmNN98d0bqrJXeCoebrqPvNOVzn7pAg4HqrRb65LAgowQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XG7QHnI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5F6083600
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XG7QHnI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08771F008A5;
	Sat,  7 Nov 2026 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046710;
	bh=ybobppUYlqmaRCc0ft9A2VDbkpDN7qhtmEwoVE/fjqI=;
	h=From:To:Cc:Subject:Date;
	b=XG7QHnI7Su7Mzt/0q2x9DOcvkzwLlUAsFwGpReavJdDsM8XTh7sXlgrcjLTb0wkcg
	 s5ejQl9DnTe89nyApxl0+Gr4v7H13SNU/JmMrVd9d6nsAgVhMleD5AwrCed0J4abTO
	 9NKZc3ot7E3iDyRV6XgTzQaBuNnaykArCmSZYNzdDfMsG1al2xkg9UYOPhgVUZzM6L
	 M75822GI1NP1yH9gsq0Bp0r07vhTKE0DLHNT+P3CE7bK3FQQngsdVu/ZI7eRWuHxlc
	 pbTL/PLxiLCK+M65zpcUi9jUacYOz6mRDbznIZGb1Wo7uC4KXoO15IytjglmYJYFOe
	 MwCUJPM4BdGEg==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	rob.clark@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:28 -0500
Message-ID: <20261107051828-failed-6.12-ab91ba61871a@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ab91ba61871a896ca2ecc6e048d80a152136da44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051828-failed-6.12-ab91ba61871a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




