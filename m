Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF826A1AC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728225; cv=none; b=cTmSM3Xws/1LIyHK3hOUzvviJ8RoS0Wp1AeLKL1/r2LE6SEtzEmyOAJX9oQqo5AHTmTorrGrmj1TMaAvT7y3i2ROEeSd/12BDAK28j10eX7pouyp7wi0pbqfpIqNWYX7ceReI+s9qFas3xmJpCwRW+Z9q9hV9jl8JoSn3Pimg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728225; c=relaxed/simple;
	bh=B929RPjgoOKNX3vzqNTFre08OPaf1mZDUAEJ30Y2iEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bumv09QYo08QvT8ToHt7zXYjcjzurWPBxnbydgrosuXm2WQl03HaSXMSQnuMihTb0Pp5zN76VNDGdLdJBu/1s7YL7LvT8VXdKgs6QGxZF0OzORFSEWgDvwCmkgp9XsD7nGRRgqcwQy0NotbwNxBWKYqsJVqFLgKAnB7MnBu88no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsqYv9su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsqYv9su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355231F00893;
	Wed, 30 Sep 2026 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728224;
	bh=MCvKlYAfhGk1ybBKQhUyurDRItXj+UK9tBtZCJrN6lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EsqYv9suGsU9aC0NgDe/0O5t8iVvX9beRgxZ5IIJ7FEocM+fjbSWKac6ZLerJrGfg
	 /xwpW0q5TxXE8LXD8dPBrX8xwoNkQXsm6uieT1zU/qdemk+VV8QPpA6GUSBIaCpnVz
	 9ngqQqeqNy0g6Ex8/gLLHqPCg168fsL0vFZH9x8bTMrI3XeNsgJWJKQvDISB/lGcOx
	 tvhhsMkKoKJ+P5WqwUQQEIIVj7k2ZQckiEUjQ5oeN8BikgC8u2MXoEai+Hc9TzFuhs
	 GS6H+5/OoYkzxRAM/vStJJVGz1CiAb194+YvG58i56ppG/vrzzvCIu7cHVnVtK1POi
	 oYQI5ZfsE3pnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 29 Sep 2026 20:30:21 -0400
Message-ID: <20260930003022.2942066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092956-legwork-unhinge-11c7@gregkh>
References: <2026092956-legwork-unhinge-11c7@gregkh>
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

