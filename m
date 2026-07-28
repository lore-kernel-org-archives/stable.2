Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09BC2F25F3
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206802; cv=none; b=RKL6C2ig5lE+M3mTM7udAxI9xE0kk/f2YL+T8kMu72DCgt7kcKxfwlNDbU4JVks9fMh4nH7jDvrvqXVCcE+Jdtnp6drm8YQVlxzGPuxxamahjlwC/w7xrq8yz5xv930zoeBOzZ9T4NAcmUmBWy1nBJJW/s9MqbEWsDtDRTcgctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206802; c=relaxed/simple;
	bh=A2D8cpysJXjfrCuvjSx/jFF/1iS4Wn1JMU90i81GyzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI6A4Q480+5mtP+woBMOXOZiG55j7kM0P8TVb4VRN79FhkInJL8VPqbRPlQ+07S5ziCy5RMwzaQJHvxw3kDt9NdRx33g8WaM+z85v7uDR7SQ3R+U9i6QkCFYWKJEP/KBCySV9vBmtIz1YOqOHUkzCEi7/fm1qsRhvPNukCPDN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3ltaW2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ltaW2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36AD1F00A3A;
	Tue, 28 Jul 2026 02:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206801;
	bh=BHXGEQpQ4oRED5Yb5pmuDbEY4BGciO1Mhfe+4UAZFEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M3ltaW2BzRV+30pB2x5lxcT9NCN5rOgYr7ByRoqKpxD9jKqtKq6h3JeQPxWctELRZ
	 gtC3o7miPCybrRMzgkaPapo+FyX+LcYtJSFQdjuji0+MH41xsiX+vfHuVlDwaQzZQi
	 S8vgoj19brHOi9KAYWipl517mEbKAS701aDNPcRyN1AC1M5Z4S4yaNs2aS5o6cCaGK
	 i+6F/TOx278KK63E9A91D6qvi37uQt5ssBhW6kV1GVpHqiHheFIq+dazCnVB1Qi/hF
	 jK3nNr601+N+olisSnQCCdh+iPvSBa0oybV1JnoMC2tTbQfwepE/SOzCZomTR+VGX0
	 IyIBabEFuzTSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sashiko bot <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Input: ims-pcu - fix firmware leak in async update
Date: Mon, 27 Jul 2026 22:46:38 -0400
Message-ID: <20260728024638.3058096-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728024638.3058096-1-sashal@kernel.org>
References: <2026072051-gong-sweep-0821@gregkh>
 <20260728024638.3058096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit d48795b5cd6828d36b707e8d62fc9e5c90e004ab ]

The firmware object was not being released if validation failed.
Use __free(firmware) to ensure the firmware is always released.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/ims-pcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 59055818e0e6fc..59997196a5538a 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -944,9 +944,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -967,8 +968,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	ims_pcu_handle_firmware_update(pcu, fw);
 	mutex_unlock(&pcu->cmd_mutex);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }
-- 
2.53.0

