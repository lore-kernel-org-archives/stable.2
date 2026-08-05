Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0F26D4E5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891496; cv=none; b=J/iEUeBv31ROzjEgxX16i3KU4oPji6OBPFEV4orkyBiq8EP8jmu7DI4BboTNa6qQHvEX0FneD2dA1SupfYcvlPcOYuBbARWGWpFIncS2Vw7FJIKiJymgYaMruwt9/ln9rwkHTjIJbkDQJ1/c034RMo/6ioKlRdlkXBh0Ffd7Ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891496; c=relaxed/simple;
	bh=iaMZiDuGXbQTAp1UT3IlgdN37u8BJVaTNrVhruNWOHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOfFOVD4MWt+Jids1FGFul6WTvYiasb3k/x9TrBFvNyPop5yJNSnNV4pzWz5sAhLroBSgTYIONRtxF6R7sPQwsh62pAYOZgwaxfgOuC0O0mPeI6bprQjMu6IxvtJLMPSR5uVLZ53pVD2nWxUOwmRapeD0I6lEGLNW122F206rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmPJ0edA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmPJ0edA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D071F000E9;
	Wed,  5 Aug 2026 00:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891495;
	bh=xPjLwSKyKdBH9rhm+tiCsvy94hH6CL5PFyjYygypO+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmPJ0edAF3C30icN9Z4lrujC1akk9a620sRKkwbVYNLmnAn9ft1YeDjsxljH0Rl9Y
	 TOJpLJoiVns1rbDjIZxGbCRt2MFPR4OeoqRPUSd2ubyZZSIGC5nPKb0A+rN2FUS89j
	 S/d+o9Pl52mo3eUZLHH/8w3+f0CpfueV//AGNkZ0kkpwHcr9E15kDBm9pcvfy/xkQa
	 8eALPDeheYMWeWVoivicREaJD1F7nxuxWOC6Wxhnag6GBn8Ug4eiboBi4aXH5XqrNy
	 +V9BqQ4+sh6P5ZUA1efu9smar53ZIO+KezODaEhMnqFt5uZLaVm+/HdEZBCFlW4N0U
	 1+ScpCPaQyCzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] media: imx219: Fix maximum frame length in lines
Date: Tue,  4 Aug 2026 20:58:10 -0400
Message-ID: <20260805005810.3988269-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805005810.3988269-1-sashal@kernel.org>
References: <2026072956-fresh-handoff-8044@gregkh>
 <20260805005810.3988269-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2c4f1ba7354312ad2d6e34e70a518a51a9344715 ]

The driver used the maximum frame length in lines value of 0xffff, but the
maximum appears to be 0xfffe instead. Fix it.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index f28795dd96ade..fc68810d591e9 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -73,7 +73,7 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		0x0160
-#define IMX219_FLL_MAX			0xffff
+#define IMX219_FLL_MAX			0xfffe
 #define IMX219_VBLANK_MIN		32
 
 #define IMX219_REG_ORIENTATION		0x0172
-- 
2.53.0

