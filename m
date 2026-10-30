Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357553;
	b=oqpxr9HmrLuhNjMbV6ijSLOak3Yu3hh+YTZ/utHPwSWT/FaO6kes3iCGzLba6a7iJC2W
	 UzcyvQ64GLAElYk7TiRzG8eofDGB/gTKbVb2mJNmsdSc+QizSRJ2qTsl6nuFWQ9UC7Lk1
	 pwHP7FS3N5pjBui8QbRdqEWOqNB37VwKAYedCdXNHRmpTacHMcH7i3SdItME4yqsIf9O/
	 Q6DYcW+PUQlVmI0xVjU9LtpJHaE//3nWzqoZgF1A4DldYfayxznhIRGwrAw5K9TrZmFnp
	 KJi5riECrwYRWstZ6Z4KXlzFlUq2qinuW1isVAAE0C+UeizKGDIgVpEWGEKAcTs0jiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZIo5u+lLKNKE3aQuYCEzmQ7ffFvxS5aSvaiSvn2Jcxw=;
	b=Qj4e5tb6/7uR3TiqaGGbFWHCSZ3XnvrkZj+4aPvsG4F96RjVbljkE9fSTCX9rTDGpI/f
	 LOqMXmjTApiYiCkKr3QrkjxTEfKl2UOJmLrdip0FBHs0Blsc1WbXC+yA0wqORhkAF0G7O
	 lbLmM4K+6ohWRLQwXLgIFzfy8+XFgmDcKnVnPodhdK5CZnAdi4THHu4P6ucVx9gzzoZPq
	 0z8dwNHqo9VNqDwWrlgfnOpoX5MvpVtB/K7TLrCrVI89eCLaU6k4bnqmchcBXUOHyYHDi
	 denU9PDlPQFqVm1EooD6Jc8yLFmf3cxe5+yFDa9hNOBKJp53VIhfMC4mZpkV6kbFwjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJYXScGZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71D606B944;
	Fri, 30 Oct 2026 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJYXScGZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDDC1F000C1;
	Fri, 30 Oct 2026 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357552;
	bh=ZIo5u+lLKNKE3aQuYCEzmQ7ffFvxS5aSvaiSvn2Jcxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJYXScGZCHJRIhAM8kFHVAY8OzWrd6P3BYS+4Fz9Ci7crGMeGNRNyu3MYWLfC1aWg
	 /YPBJh1bvLboNomzOSEFrOSDbhGb5glRY+CMJd+7QUANvfvxC09/EyftK/69vr4YhX
	 poUnbFl2tXplW2hDvO7Bi3mqEyFbB6XQNwYNfSKnLTXnOJnEykgnT9tRoc9euKO2S7
	 37hdJvT+QmA6yIUO15F25QtNdgJo/8ycLHH+rVXMYEyS7xIJh4/23gIVKlT/JMnxGS
	 tCqzezlP/h+stWAIRQ+X8dKO9rTvjcDBUwlvN1yfGCZP1xbyipmfYejwt1gE0pzT9z
	 n3/JYa+4qPxhg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 20/21] soundwire: amd: Check clock resume timeout in amd_resume_runtime()
Date: Fri, 30 Oct 2026 10:46:59 +0000
Message-ID: <20261030104840.3361217-21-lee@kernel.org>
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

When resuming from AMD_SDW_POWER_OFF_MODE in amd_resume_runtime(), the
return value of readl_poll_timeout() when polling for
AMD_SDW_CLK_RESUME_DONE is stored in ret but never checked, allowing
resume to proceed even when clock resume times out.

Return ret if polling for AMD_SDW_CLK_RESUME_DONE fails.

Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
Closes: https://sashiko.dev/#/bug/linux-c6360b30-11b9-40a1-ab04-528462af313c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index ba8e6d42c467..faff3e9eefad 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1494,10 +1494,10 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
 						 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
 						 AMD_SDW_TIMEOUT);
-			if (val & AMD_SDW_CLK_RESUME_DONE) {
-				writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
-				amd_manager->clk_stopped = false;
-			}
+			if (ret)
+				return ret;
+			writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+			amd_manager->clk_stopped = false;
 		}
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
 		ret = amd_sdw_clk_init_ctrl(amd_manager);
-- 
2.56.0.317.g454f8302e1-goog

