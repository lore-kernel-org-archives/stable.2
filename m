Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABC261B71
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727632; cv=none; b=QYHVoPyHEmEPjtoMVc7zAYFb4HRii0ABU/nIihtP76N74km4ox0QWAxjr3DJfOsaaQKCHxeCQIIh4VhUwjtDo8TrNMDCADVMhkN4O6c4cSYn2u4KnC1cQBVfYxdAiGHwCVeFFhA+BT1qyymkp4vkTCQdnuchzo9zao38fQOJyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727632; c=relaxed/simple;
	bh=gWQww5V76Wk9Oa4Lnut11da8VCsJCDjuaDXmnZkU7BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RllyJ1cC+zcNs+ui8o09+oqi02ph6EajoQ5FRa99AQTifrpFeAjsg0IZfqzufAInbI70RwcN2H3pAQ45Ifj6u7OaeFQrlRC7+xaARNbVypRx8dgSE/ypgSTDgmLxCpzH7sBcbZgPa3aAelwUTVT55S3P3B7lrF9K5om0RxpA0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVJiw6ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVJiw6ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA2D1F00893;
	Wed, 30 Sep 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727629;
	bh=CZncWslQ6z/LMT4/2sRx7I8VRqoKfdQqKJA8qi6B/RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVJiw6jaxzQgwVkiu4aCRSUxvmbyQaOIUdTWVRUT25KTBcALxBvvu54RICyyF980n
	 kWlrZNqy11vT0XpA1Hxm0kR0sQ2Zn+KQ+WJujFdfZiLuSVwDQofzwAXN8jtPLZkodC
	 NqmmBzOk+VpC1gMTKHlt6Hj1ONm6h+szdaA2Pq08ZLqNoxytYSRUY+glkIih9sGgep
	 wmYanG87+HXCiChs8QoWgQMFR0jRX/REdYkLEA6433Qqs3Y1yvaWyGBA6T25MLEPrP
	 ezFoXZnYU7apTn0NE2VR/eQcwAV1HVYg5pHLaXUmIkWkPOCQu7drc16X/0/QoUwpzQ
	 XxgTi6COQn8kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 29 Sep 2026 20:20:26 -0400
Message-ID: <20260930002027.2934444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092955-onto-scouring-df20@gregkh>
References: <2026092955-onto-scouring-df20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 5e130f58629a2819c9d053507ad368160d25eb65 ]

This increases build coverage and allows to drop an #ifdef.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: aa9dde93e05a ("HID: alps: unregister DualPoint Stick input device on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 8c3f83532ce92..67179e3fe39b7 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -843,10 +843,8 @@ static struct hid_driver alps_driver = {
 	.raw_event		= alps_raw_event,
 	.input_mapping		= alps_input_mapping,
 	.input_configured	= alps_input_configured,
-#ifdef CONFIG_PM
-	.resume			= alps_post_resume,
-	.reset_resume		= alps_post_reset,
-#endif
+	.resume			= pm_ptr(alps_post_resume),
+	.reset_resume		= pm_ptr(alps_post_reset),
 };
 
 module_hid_driver(alps_driver);
-- 
2.53.0

