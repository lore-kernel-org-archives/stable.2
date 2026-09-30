Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230C37107E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735661; cv=none; b=gsrew1gaL0Amg7FXHmkG22Gn1zv0yxtgIvayrP0TrS4lce/iR5kd9yzA2A/B/uUcPUp3tWunBKD4KsVkYjdYBhpMGDymUZyohkTHjQ+R5OJt/QAyHZw2h6cebXyzJzBkyYRB8Xl5849onpqnDWFLWHb+NT5cWp0y3CzsTt9RkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735661; c=relaxed/simple;
	bh=B929RPjgoOKNX3vzqNTFre08OPaf1mZDUAEJ30Y2iEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmiVR9WAQOLuT1L8HO4zsA2CPyiD7sL9Yjqmk3wMAg6/BoIKhQmkoxc+OzSyJ7C97UjZ9oV8SRYG3uUv1TS8d4ziLKswxvK7oxSMSIFlMDAS+u+tXSLlhO04M2x1sFcJwBRb4fivOCcPuxvV6dOHxf3AdY8/DXP6iUk1JNh4vdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eczBW6WI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eczBW6WI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27F01F008A0;
	Wed, 30 Sep 2026 02:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735651;
	bh=MCvKlYAfhGk1ybBKQhUyurDRItXj+UK9tBtZCJrN6lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eczBW6WI4owb7CYgBKWIQscCQK+wH11q3BCByAHzEHHoTdbue6/nzIeSf9RuVA6jK
	 TAu4d4pl/adx5lCPFYCe8Wo7lQ8mWW3rCu+wWB4vHWl02mqLpK+VUplNBtxejjxZC+
	 B7tuhDQ5tQGg55NqqJ6zhzyfFClBP87ae7bgU1MLkRt/ceo3sLPb324eOqm8mcb0y6
	 wqz8LXKJlgCk6jHriuH5ESY6LuQ7XOkPCu8/6M0NCIdwaINN8zy6cFJ4YgwCk14guL
	 4pm/pC4HlIdMIVJNNSZZOLSKuNOkF1TvcS5EJyBiU6VcXE5a03MLwaBmi9FKceEhzc
	 va0RAhjJ915jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 29 Sep 2026 22:34:07 -0400
Message-ID: <20260930023408.3421577-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023408.3421577-1-sashal@kernel.org>
References: <2026092958-confirm-underfed-6c0b@gregkh>
 <20260930023408.3421577-1-sashal@kernel.org>
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
index d4fb5ca6bf73e..b2966c6598e18 100644
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

