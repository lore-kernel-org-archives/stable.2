Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC73CF670
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195283; cv=none; b=pfJbJXLsr7PKbTQ4j5Q5D9BpuVKroJLSvMCwP5lpU9To7FeYlX0QK5Cj+en11C2Pgbgq7/+S1qfotcoVSk1fZEmCuTMTbUAgFYvkuZ7f2Xvt92CrL1bLRcobN3QAFybV6igwr635gvqj6iozBlvx0s/mkTERs4n0B4CGk1hTD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195283; c=relaxed/simple;
	bh=PXDuKzSlHp2GNM2ULmfnPG37M6RYWTFtC1OKLAxOwVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pb7mAiVmNkkjZ55X2ilgUcxn4/Ypy2xDe3E3e4DsD1EBQjPRKrJH5TWGEjj+iivT5+Kp14Hb8jg+vSudi54tCwwzGtyad+JG5LjD4Wv8D+UX494amwcYEkSA+ydz5X3+/zkiQr8ONhN8NvMTc7EMQ6U8N5rXh9W50z3j7a3hFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSkl0L/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSkl0L/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736AC1F00A3A;
	Mon, 27 Jul 2026 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195281;
	bh=u3tObDZ3JBvH7+HOaZzopLKqTCGjz2Qn+yXg+aU8kD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSkl0L/PAw0Pw03Km9ewGVCjm3LvOtfnB5ImgliAlioJtiRcezKQGJgvtAYeIOENC
	 MmaGKHJF7Bl2LDWEs439rSYdDFEiFEkineGmkLvjk/+H0UzgeXZmc8NzuSgBhLrNZs
	 7cr/+zLq7d9ZofwJ5V2wQ+CZG8JIykshR+oGFlXN5WC/WD9FnMyCNIc7zvVwMsHRHk
	 zuBHTL3WUdDI6N0Fa1VGhrBSA597UuserGDWSeshOL+lPinyslp073uR0lrm2FuMWz
	 z6bWVOWY6JVkK6h9Fg/OfZMEffVu0cKcvZHP/8t4QO1Q7OvsUZ9esmoz5glQKqBwXn
	 rIZFLxvNidP4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sashiko bot <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] Input: ims-pcu - fix firmware leak in async update
Date: Mon, 27 Jul 2026 19:34:37 -0400
Message-ID: <20260727233437.2425385-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233437.2425385-1-sashal@kernel.org>
References: <2026072051-scenic-thermal-f0df@gregkh>
 <20260727233437.2425385-1-sashal@kernel.org>
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
index 2bac9d9c7b0c9c..4496378e31cda4 100644
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

