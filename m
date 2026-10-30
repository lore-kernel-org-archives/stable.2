Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357476;
	b=EX2fzIdnZZEV3OuGDjrqvwW/SiW0uolKMHf4eRBo/hQosI1vAhYtraXuiuDthnvOgPI0
	 e48YiohBch9vjXYBl8fTIyaKQSif3/ufIZ3TOvTIYo0gQIqhQercw/pyLm4s3dENXNoUb
	 TiFJciPN9ELaXkGp/ClPxDgXS/9hwBksse3sv7QyEdQ8Nb/ZeHJJlcWUghUcKUfKudW5X
	 7fEoC/ZcCGNCvhFC8qgpzUnE7WgSZZZU9ej852e4jfQfJaVezTRuwSV2ErOUUzbqqrf9y
	 WgjPMYvnBU2ypQVrJkNvRyjAqARCyY3nP3N28nIIXpyU5UNUKVmerH775YuSzHy2Slg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ORZuUirSP0uEoL4vnmHKjRK3/96d0kMl+8hTFLVkI2s=;
	b=yAgXtNepqKF4wENI1EMOzwhIgrc2bi/tkm0M9XCGSmI1VWFRjUQ9aJvb38bqkIlScjKL
	 F/W7mrPisC5r32B4GF666xvVNxsjucz7cQv5gdLIuWd1w49ryzHQqmYW6eQKvm4BEKrXZ
	 w8/p4h7FyDkLUEiiy3R9vbxo/5DrDwA+yLRzkYNrZHZsev0vcSfTAc2C0u65Ua/IpHYks
	 8N3Y0RyMPmbeO+/Xf1zcohrYFZVW1W1KV36bnsJ9JszElS4Otv8D2STk3eYSgGpB0vASg
	 GNmP6syTA05QTOs9HjftMY8qLGtXIAQq8jbznDmY+mtcaVOR6+vP28Uq1oY04MP6acg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgFiA7Be;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084B606D290;
	Fri, 30 Oct 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgFiA7Be
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D971F0093A;
	Fri, 30 Oct 2026 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357475;
	bh=ORZuUirSP0uEoL4vnmHKjRK3/96d0kMl+8hTFLVkI2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hgFiA7BeKw12PG8Q0eBP5/6EL2tNObbVM5JYU8HshWdlUJ8kKI+JG5mHlxXnGH55/
	 FAX7RLnqP+asVkc7+3WYbWV+tF17mIrhcT6KnDu49sk3f1z4+7WUVAd3MFn629JfgQ
	 8nDLl+5OXBb3d4nSrBxd46F9bvFIwiT6YIqsi4O/MhT1o/h0SiS6Q7qj9Im0e8ILMh
	 CmEScg4VO5toOz2hPVPzygg2jCpcPeeO7jjBkjbv7YsTij+Yja6uPuIp7S1WAHcFGc
	 3dpkWL7TAJ4RymB69P5EuV67o9/5xzvE0kniMYMGD7LNdI9pOo3zQ0K24mNIgNtSey
	 /w+3cncELHAoQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/21] soundwire: qcom: Disable runtime PM and avoid clock underflow in qcom_swrm_remove()
Date: Fri, 30 Oct 2026 10:46:47 +0000
Message-ID: <20261030104840.3361217-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

When the controller is runtime-suspended, swrm_runtime_suspend() has
already disabled ctrl->hclk.  If the device is unbound in that state,
qcom_swrm_remove() omits pm_runtime_disable() and unconditionally calls
clk_disable_unprepare(), triggering a clock enable count underflow and
leaving runtime PM enabled.

Resume the device before removing the bus master, disable runtime PM,
and only disable ctrl->hclk if the device is not runtime-suspended.

Fixes: 74e79da9fd46 ("soundwire: qcom: add runtime pm support")
Closes: https://sashiko.dev/#/bug/linux-e26e04cd-3dec-4a3d-94e6-f45403c4bb57
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/qcom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 205011234030..246bc063b850 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1791,8 +1791,13 @@ static void qcom_swrm_remove(struct platform_device *pdev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_get_sync(&pdev->dev);
 	sdw_bus_master_delete(&ctrl->bus);
-	clk_disable_unprepare(ctrl->hclk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		clk_disable_unprepare(ctrl->hclk);
+	pm_runtime_set_suspended(&pdev->dev);
 }
 
 static int __maybe_unused swrm_runtime_resume(struct device *dev)
-- 
2.56.0.317.g454f8302e1-goog

