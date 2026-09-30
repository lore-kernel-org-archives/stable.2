Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547D35C6B5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735126; cv=none; b=gOKecrt37LFcUo4CHYasO/46Gjl1WfS4z1RXtPFA4wx8lIPZTf42r5nJWcTAd5+eDnTg6v0uWL+oyPSugXX3XihEtJFuqUx2xa6h838ES3If++36mbSa06/9cGm3xoxk5rx4DQf8SNoLcW34rASkmKP5TRTYs2nk9W2N4DbKViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735126; c=relaxed/simple;
	bh=B929RPjgoOKNX3vzqNTFre08OPaf1mZDUAEJ30Y2iEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCnfQi8uP7L1zTOzHnhNreJMNIaapdsI7WXV5TgCp/mZOLyOYBQMdo6RH88wq2LRV10N+leiWvH5EiSRBg4p2WQ+Mp3s10ROUytsJSragCWlI8kBEfUlJSdGFiRF4r+Wj2duQb7F+FDgOt/dGuveJDWZhnFwLgRnUytICMSL7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOvC6RYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOvC6RYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC1F1F00899;
	Wed, 30 Sep 2026 02:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735125;
	bh=MCvKlYAfhGk1ybBKQhUyurDRItXj+UK9tBtZCJrN6lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fOvC6RYkb8uDNStbuAj7W/K435+SOiU2oz6iPMaQDqU95AySgDxCGkEyqZBynxxDv
	 DVXhXHypeJpFKbL1yrBMEb6kvLXE+7NHC62n7A409Vjqjw4LztELWqwweUOg/xHBRQ
	 mJf21tfrJeSrJDrBxQUqnygUSCCtheKgjjXCO5F4qxIVWta6WnZ7FLMQYm7MmCkDiq
	 CbX4qpchSjFwHSyJC5atSgmwSz03vaUtQf26bEljh3lId7O8HlpX1vIiQocS/tejnM
	 c0yu6bhmJ20ORb23m05LsJ3LmZ6WNAMNiqMBf9IqOAIcYiazLrcPj2heyBQB7TsIVY
	 hC/s9cci31jOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 29 Sep 2026 22:25:21 -0400
Message-ID: <20260930022522.3389463-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930022522.3389463-1-sashal@kernel.org>
References: <2026092957-hanky-stipend-aaa1@gregkh>
 <20260930022522.3389463-1-sashal@kernel.org>
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

