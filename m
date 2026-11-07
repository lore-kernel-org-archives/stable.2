Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048222;
	b=q6LkJoEAX1wuZgtWCdGUMZtJ7SRDHyaJxVW/x/eM37u0cX4Fc6lJS+dDIIiFMi+fVrq6
	 XDlXGV7+nO9Nyn857Jk1hS2K6GHTClPx6TRQ2EMyPtyF6XervwwYUn0RZ5MN+ix9caHVr
	 lD6J4+TNUam1v+2ebjgoaYsWwyne6HWBL7diY1U5VYJBekvl3cX7WAlEXQZnS5GCKUqyz
	 i4fTs/fbcNLi/oAAelyXh81X3BYgBcX9/EJRdLStL6XE6zfrUJOSJuaMmYCnS7Y/Mnwd6
	 6auMQtIZ0oMzTr9ZP5muOEycLFfly/PVhfOLZ0M1Lg1YXWWKOn9jYAhhmsfftBLLHZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=otn7WByjb3XRTCHAHZ0mOEewktTPVVl34E3fGfppThw=;
	b=5dMjbp5Awb337lPVhvnfhFMtoFVwnLCxG+SMqK1odBkSm8fLX+0i2MSpqE8vDIS1/6kh
	 OwDykRX901G6wiSckcVAIW5zyHTtpCTG+s0bBFiMeUQV+zPEpORjWJM9YGU3Amo/XJZ5f
	 L40iULG7c7xjJk0dy6DNyv4nz//q/Uo6rGaWd1xD6X1mUZSVP/hQ/YxNhP3tut18QmirZ
	 pdLXFajRjondNQtlVzLCnVXXQQXNebmZFPaY0bXeIiOwDwQDn8z7Z+0toFJrycKTmp6Fd
	 GUIQnKxNfCdEhWjFBUGea5A65VGlKERKOLusvsml9N1ZJp5XMpXOcKGor1T6z9huwUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFC5Ywk9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFC5Ywk9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC8F1F0089F;
	Sat,  7 Nov 2026 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048222;
	bh=otn7WByjb3XRTCHAHZ0mOEewktTPVVl34E3fGfppThw=;
	h=From:To:Cc:Subject:Date;
	b=XFC5Ywk9vbbWt4t05/FYM7t1ute941e4F/MM3jgmFng4switTw2IOgJEslP9UdEiv
	 3itZSjiXEPhtQkco6ix8v7n2EtkIjqx7o2FUS99zmZlJyBX6v/pHmHuhh3xPPZkOIT
	 IBrFaeZ/6T3fAAuPyB1aMsHLAYSNsxETsKXom0CGw2mTjotcZjoDlnLaEmp6eWcA7H
	 PNpxJXMkNbeFf/GW2vJZ2MNVyeXpyEsgBILOndKFffvv5IiHZMedE1VcHjQptgr5NA
	 Wg84bGmDQIPya0DEL3KuteIxV21ogfhBsL2Ah5WHMeyVedHKZdvvCuMZ1gNd3ge4tX
	 8uh3EDz3chajA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	rob.clark@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:40 -0500
Message-ID: <20261107054340-failed-6.1-ab91ba61871a@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ab91ba61871a896ca2ecc6e048d80a152136da44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054340-failed-6.1-ab91ba61871a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




