Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050278;
	b=jDwi14ACOjRbVKiNanQPkLJy8F/Oq+Yj+ta6I5DUVbRYfgNiMCDya1R0zqTdzPFLGTM6
	 CZKcr2iilzWtGhQ/G7F0/kWDY8QOImaprsOal6EEp/8HizC2Qh9ly1e0zO/IcpO8j6T2u
	 7msytKtlRM7Jamf3Bf5l886uUz3ZtbJE5je6BXjCMsH+8fXwHpjisalu2HaZD6nPEx3qG
	 NL7VVEENMonzGoJ/8MdIrDb3RcX1IEyNQH5PNBmnC3Ums3rhArPEAWmMi+jJKHpKIylXU
	 iTdKyZLBDznLekggPHK35wb7WW88jM0JLUNEruj03V0hBd9CkaQTsGndFZvY64I5PMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4U4IBDzgtE9fCA4LyYF4Hrr0+y8fz+Nf5/4GeEj+hZY=;
	b=JIt2hX377edPBN8MZfO7wjY0miOajNR8GfN0QEbvuK3Me1KAogti6faJJ9KvNhzHieg+
	 i7NuDAIvbS8/TUfMck+I2l7iVBI3KkSyCZs5KZpkmYZIudQG2Nk5ZY4r7wVDaDVFWD5xM
	 kjzJLUodNk+jgkv8Gx3JiQYFwMIsuNLLsUVv998xXLfsx8brHQXn6QKPBy6JW8QOYQTQg
	 VVGsxUI81abPP7AtQf6MRLQxvo3Ni+8RtFk+yYaXJEfik1Cp9I/eQY2NFzvMx8yuRnJmG
	 mrK+jyRHdEh9AGVINEemY6GfNI8WavT1eIj67mMFo8dUXtjibnvI2TtP2u4nUGfbLIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTzQEnNW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTzQEnNW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CFD1F0089F;
	Sat,  7 Nov 2026 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050278;
	bh=4U4IBDzgtE9fCA4LyYF4Hrr0+y8fz+Nf5/4GeEj+hZY=;
	h=From:To:Cc:Subject:Date;
	b=fTzQEnNW5HPtVRRs0bvkgPrBh2whIwQyvQBcaoU0PriUWKwOxZJdKO6LAsZV5v5W7
	 chcXERuzm6rkhRHIpJXp46IN62xAYDwJK4u6vzj8lEKUMD/gJqwsEmD9me2gP7Ub6e
	 QwUf/uYrNvl7ZKYjh4ugbsBKMdnjfUhBsg3hW7HdL/H6dBpcn0uKwPbZxh3SDsxs0v
	 9FgwbWb4M2ZPqbeV9duV+zNLZvDezJH2n7CeBmqtNZmbh+2rikFTJvcwiN5NvM+0oR
	 ravgs4rtkMx2g9CxPFxwH7A3ts/lQ4/i6FbJ4nSc3c2LfY62QQNz2SGefyJQBnTAaU
	 zvTAjf/1dR4bw==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.kozlowski@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:56 -0500
Message-ID: <20261107061756-failed-5.10-d27f831aaf20@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d27f831aaf20aaf06e41ceb1b260e10672269155
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061756-failed-5.10-d27f831aaf20@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




