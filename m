Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9191990A7
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200274; cv=none; b=CiJwoWkLNwwFVoakAbStB0737eCxz1jZDdFDPFH87SOlzdmKzETSZhf6kn+CCuirn+YbL1VSmcPBvVKiAEWfMcTAEXoQ2S2LDGRMhuswr8nEuqYeNNiyfrQSSYC2BKZ5Uq6WyLId0vBkPAz96KsR5cV/l08lPRBCEbXw0L/GrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200274; c=relaxed/simple;
	bh=xV9Ym4Py7qlPxHGcVusKTMESTNRLbzxJlUHINSDCTyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCumsYpsS0br0w7PJkz7jMF9P9x6RarknuCHExZisPxz3YuiO/JnAfNwHDULksf3Z/9x7+MDmklG110bmXPn4zSAp7A19LHKfuEw+UiazA+8PyBhFXhhbjmhiDmojHOJhO3ASUda2kf+Vpe8Oo4n51YE6v0JAILNXVH6tABF1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf1qw4dV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf1qw4dV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0859F1F000E9;
	Tue, 28 Jul 2026 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200273;
	bh=NT0+sOJhgAfQXhQdb8XzgkQHpwQYEs79KoW5uLCUT3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bf1qw4dVZJrnteItSm/sg5nWpL+Kwvt2VPrvmytyWQMRLYNvDRTc08NraNv8V4aoe
	 B4i6B/nV/B9/ITZUyAXBSIglh5bljgsAC2qxixRDq/rRsQWxALlZ/DfsZr4YqhgZZB
	 ZCw6W6qkGcdpVCso1oaQMXvRK9X9DK/d9oKka0invl2HHlgmArkTCXgmNHLnG+cCNW
	 pIj7CxObvtqAsMgVoU+WLmvTyX9MMZjB4QeuBDLND7rvrPHyy49izeuE8rQwTF9tGy
	 nZ4Lu3uXvzODJFRfw306oS+DvpD3EJ64ad+gAzoPzwp+Zq3QR8tbPaQnce6iHeQukp
	 cDfdbyJL+ci7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sashiko bot <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Input: ims-pcu - fix race condition in reset_device sysfs callback
Date: Mon, 27 Jul 2026 20:57:50 -0400
Message-ID: <20260728005750.2691008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072030-handwork-earmuff-b1c2@gregkh>
References: <2026072030-handwork-earmuff-b1c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 411b8c4b274737c3bf08e1e025801161603cfffc ]

The ims_pcu_reset_device() sysfs callback calls ims_pcu_execute_command()
without acquiring pcu->cmd_mutex. This can lead to data races and
corruption of the shared command buffer if triggered concurrently with
other commands.

Acquire pcu->cmd_mutex before calling ims_pcu_execute_command().

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/ims-pcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 59055818e0e6fc..ffb478cca604d6 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1173,6 +1173,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,
-- 
2.53.0

