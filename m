Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049277;
	b=lqLhjENEQB9ie0O9o7AhKSD6Tm5CLKpOPQZXDsjLJZfg1OwB9BUYRcUN1rUsdhHQME6a
	 oOUNRUTwQzGsP9BfpU9QOYzQBOYcKpyyNU5Ux2NYR4z5eECG5znOwG/4yD+9t1VLNKNW6
	 1tgtTsSyWxRpcKORNR39/lq61pRWq+dfOCyF37jDEIVjxncNIxYGOdIZR+ATyI3aht97t
	 C2Q2zAHKkJYWNAoRbSyCMP9qOB4m5rIaZ3ezV69ATozQcCpKSb9+LvL1pjXKmcgYw9SXq
	 reEqpNK0niK5TTBsYvw1G79qMG6t/Scl6eiPNlw0M+MKHjpRjgFhkLL+cm431TGje7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y5NKUkStb6sd+WvgniyXXC2tHypMdIlEs4kcnwAFmI8=;
	b=Tm7bxdvmlehRCifpEjSkZ1EVdmdNk6k8xNPVpLlBFlhoQWtFaTGSV7xYeuyO9c7hfnAe
	 IdeZjLBz6emhQi8hx6Sn3VjlC4mRLIHMMNhfSzV+QSsiAxdKss+ClLfMMbpc85zqo1Awk
	 GiGi+VNWux70wDtFchwX0FPHTO4yd3J2ljk+xnC1Tmbf/6zTGMicuR1FaFd7xQ31/D+Y0
	 RU/jqLvoogDVSoRkBYariw9dY22ANHpwbK5p/0DdVmasiYGVWWnTtvuV+tZ8kJCZjojTE
	 h3HpJJ/O+1nGqdzIPJKopirC224jgTgsAxUSiBQLHqAwWVCNv2lDc/wiQLu5SXN1ICw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IesvYxvx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IesvYxvx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5141F008A1;
	Sat,  7 Nov 2026 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049276;
	bh=Y5NKUkStb6sd+WvgniyXXC2tHypMdIlEs4kcnwAFmI8=;
	h=From:To:Cc:Subject:Date;
	b=IesvYxvxCojhr0aQgG7U1zHOnDdj7y32bzYMOJYHxK5970DRe6gxknUNk5gqzEFY9
	 nnXicaA8ZeSgLiCY3bwQ0H58Yp5Du68porn/PhdG3rkpZM753e9DL2RhPbCd/nvAD6
	 ff7W+PzN3+OtqrrsAHykehshqJ2wtwLU5tthE4w4iQ5Uo7Zybugl5wKtH4T4zrFBF0
	 oT/A6+MFTaC8mhA4iDCB2GY2Baw1KJKyqhlr0+f3elar6/UKtNjWc1SsYKfJ1WRhed
	 CMMet2WdahMhXAeaQ2sGNQFhGaJ0nxm4GcNdS8v/6SGLaYdSAcGSwuI0GazrPwqMig
	 El5w5zzMp6aYA==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.kozlowski@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:15 -0500
Message-ID: <20261107060115-failed-5.15-d27f831aaf20@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d27f831aaf20aaf06e41ceb1b260e10672269155
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060115-failed-5.15-d27f831aaf20@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d27f831aaf20aaf06e41ceb1b260e10672269155 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:34 +0200
Subject: [PATCH] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/752654/
Link: https://lore.kernel.org/r/20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index 77dce35cd45e0..ebb600d77cd82 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
-		return ret;
+		goto err_pm_put;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
 		ret = clk_prepare_enable(phy->clks[i]);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
 				cfg->clk_names[i], ret);
+			goto err_clk_unprepare;
+		}
 	}
 
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(phy->clks[i - 1]);
+	regulator_bulk_disable(cfg->num_regs, phy->regs);
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 
-- 
2.53.0




