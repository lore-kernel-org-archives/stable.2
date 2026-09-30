Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F431FFC48
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735925; cv=none; b=PNHh2tziRBgaMcUp+BQj8sATat0mJX+fdhyZZ8mP704muxVUIZc9vC1qB4vI5MVnD1teX14szvf1g38lcQszQxQ5LcavhFXuz31Uk/DIv12YxSvBhx9KriAz4DtJx/RBxnKKSzRwC+ON+JIDzh+eRyZEpE8hJczY77Mk7lvhUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735925; c=relaxed/simple;
	bh=tsHRnc4p/ZUn7tYgodPn95Ya69U8Oe/yVheP6pH9QkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcbGDo31/wk1rzKgO286AL/qIdWjy1jXkYmnzJDKOUgTOY9yowzDZxPAfaS8zuwHO/GOTFrMSxvX9F8SoOl8XqVU2BYimwcwm29yEYJihMCbneh8TjplkQu6DEhMLPgfyT+HrYYcTyzSvy1r+rc/f5pghmNv0JasRgMvm6tCN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUA3h56e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUA3h56e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F3B1F00899;
	Wed, 30 Sep 2026 02:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735923;
	bh=o8jBLCWsovMBc5uncBA041tVxSpJhdeuAoRJhSqKrzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUA3h56en7EcQ5oEv0aBmSBcAy871/qnOC0fciwaQRRGJBk/fJgvJMy+i1dWPHsIa
	 W36UqVxYT6xwoGiy8KXxgkWC5OOzFOD3R5glO3NmUGcBvEXVsRdcO37kPKcDBbRunv
	 oS8yKmZTnfGBAlbKVdcUQTILkxNo4eo/B6Sd5Axi6o/2NpBwsJrHeJYiv/sJyFaQtU
	 GmBQDpfdLoqLRIDDVZZwuFv7TFUZ870b9/LQ0xuYQIrhRGXQ4ls6SmQ3bCx0elX8Nl
	 Ss3XjF6vbssfArrA8UMQPXDJij1lNrWTOXhLeAAWeZMwC5gFzesCcNABL4abNoLpF3
	 7ZUrrexhLRqZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 29 Sep 2026 22:38:40 -0400
Message-ID: <20260930023841.3438294-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023841.3438294-1-sashal@kernel.org>
References: <2026092900-radar-unrushed-0fe1@gregkh>
 <20260930023841.3438294-1-sashal@kernel.org>
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
index 8bf3f21998bb2..6d46a4c1a200c 100644
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

