Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90385332EA2
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209172; cv=none; b=WLqGnQDrsQxC4KMekyFsQhrgwkfHaeZod0IbGj3vNhooaxMMRt42XsJY2fL7shxzz0yHhEYmqgf1sTT1KG4HmkG/Ixso/wmfv+56kcJ/ubYX9d7fv8VOakwwTT7shBmwfMPxBwwZbh5dDyzclNkkYKr+4cZ/7hk9s+L4d4ryIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209172; c=relaxed/simple;
	bh=LTnJd0GNhmF+aHTXytp/+OLlibxfepmVtfjEYEzo1xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I33KRffTXQVpLIwTRU7ZMqT8gJ66FMxjPN9EagmVy3NGvp3AFCcETO4vVec1zOICL2sONc+lKx078a4Io9H0Lai4wbuDv/hL4wQCqTTDIB4gfokzUy21B0AK2UftUs2AfxtEio/L5Kbq8WkMniYryofs7Q0BEKhxKiZwI1IqUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX8lEJak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX8lEJak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7CF1F00A3D;
	Tue, 28 Jul 2026 03:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209171;
	bh=DddVIKD2DQpNWxEDhUGPGE7hsxnQ66CVK3x70kbyWq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SX8lEJak+NlCWUQvoI3bTKEx6cSogwDsmN51SFCaglWPqtmMWLbeUN0H4UDHwKJgN
	 K0ZIgXYQsH5eFQZpj6SHMfpqQFaI1MIBhmK6wLCtas+nvHQ9e1iMYrauEgs/9/vZBi
	 6JT5RHwNu43OmZNkdlOWk8YehuYIFCCgMbU6kDzBeOLisFWGld0dQue06WbGrsLKw8
	 4+kN7umYkV5i4p7hka7F9ebuVndqO9NBTdh7ifuey+gepqGOWx3NxNsD95X854Dy9Y
	 b1+tyAq3n/+iKvr8yBPK7SDBTSKL6yczOsFn1lkJxbNNvUbk6HnOtBrV1CNcsj4Hx7
	 I4GeqJ0cUQPDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sashiko bot <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] Input: ims-pcu - fix firmware leak in async update
Date: Mon, 27 Jul 2026 23:26:08 -0400
Message-ID: <20260728032608.3151832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728032608.3151832-1-sashal@kernel.org>
References: <2026072052-exterior-oncoming-f12b@gregkh>
 <20260728032608.3151832-1-sashal@kernel.org>
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
index 55d4fffda41bf2..9a6dceeff559e3 100644
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

