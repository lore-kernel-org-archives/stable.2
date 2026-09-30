Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA62125A0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726671; cv=none; b=b+pfrqc4/NYM1JNbFJcqMJ37+WoNA5wHrze4YK7lcL6y3iW2sYIH1R8PngMNksDBR6E79SaB5RVDMjJtrWzQliNh2CgOTGs+nRwFF903LV4s/WtYoRjb+zSWS03QccXpiDAIdfiwxWdmC+Db3v3kFgLN5pQ+Am4/3oq5h95CGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726671; c=relaxed/simple;
	bh=gWQww5V76Wk9Oa4Lnut11da8VCsJCDjuaDXmnZkU7BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BD/7YqhPVM9AcPFI3ozKuovRMZD+3enq9OAEhMM1BSCgMtireyNkXQk6eF0fkmvGKDzvuhraAqIs/NBDshy0SB8kwzj6g1wBQKcwWj3TdG5SMtL7+WdwNMhesJSyc7EzymtuC/oznft/aiuYHCLOoZD0JQEQLj4wKsPSA/tvVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyhhOk0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyhhOk0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465231F000FF;
	Wed, 30 Sep 2026 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726669;
	bh=CZncWslQ6z/LMT4/2sRx7I8VRqoKfdQqKJA8qi6B/RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IyhhOk0Jew9chjbTRxj8scTxIkBk81b7YCE9qwtKh41BEdYX1If6TkyyJTafYZTyn
	 1Begcu4/nyGTKWLusZfxYDojS5izg1iD4tvLvxsadDrQRiba9SWcgxb+5q+xBZxpXp
	 pS6g/ax0hN1G8WnyEI7iGyPMuQyQa1ODZ+HU9y3qOhHGfPKkpwA2a5EgAYBD+DvZr/
	 Z2mxDwwIEY7H5wch7wbhlJxtIpnPqICns4wfIBahXTbCuKue/eNNgTkD8Zn+QzKWfi
	 EgESPWSuplyDDGdE7cTEnRpJ8g3JoAI2grSe7OL51GRUuNQrhVYVtaerDS7gU6NRdV
	 by6IeXEwUwUvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 29 Sep 2026 20:04:26 -0400
Message-ID: <20260930000427.2866647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092954-curled-shabby-13d3@gregkh>
References: <2026092954-curled-shabby-13d3@gregkh>
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

