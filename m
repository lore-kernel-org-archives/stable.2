Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C4396579
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751141; cv=none; b=NxHfrKmiBClOT1JTQwhMQuuv44Df0nU08s33Qn322gaQHEFohxFrzcLNLEY2VbDqK0+bx9eo3nAO2I5lU8UE87vCPEQCsEhuD9dt+rVNOL9iYuz2OSw8MurFXYIUeL27cMOXdar/skAdIEyXC2s7hO0FbRfhfWVWg8L8W00A3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751141; c=relaxed/simple;
	bh=xAh/XhYUYp92e1ZCqDkpcRuzZU4MViONmU+4T2Y2rjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sose0d0sL936eeVZr7Ks0CnNB9DOjbpDW8jxfAO/qaS0TQ8yxuS6ljpdKKi14JmhX+z5Qet5UgzrVTTae0Q16TYRnP7gywimyA/mSQzKNhl10R6P3hlsSgDWo7v9dESLCv8FMLRd9KmqjMgdSUdlyfC9tcDEahwd8FXWlo2nMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emGO3zi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emGO3zi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42901F00893;
	Sat,  6 Jun 2026 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780751140;
	bh=Di/OLje9Fl5U/3Q+I4I3iWH6TDzhpXeuZNXfAnnPIzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=emGO3zi6xH7Pu1RVUXFNh4Cmp05n+wqJfAJdWfazeBw0k8/TPI7C/LFtxu9Haov5O
	 FCiSXRb64u50Av+BRJ2Cqs4/iALNEbKCvt8z1/WUtBLnDjjvHXbEJFMW8jvC0BAX5c
	 akgFwWBhXkebgTtMXMGzimTOWR+HfY8DiobqboKizFHo2BdBepdK4Qgc1wB3fjiaqN
	 1Gm/CrJi4DkqtkNqQI2eb/BmC3bV3b1Qr/KecEL/B1mklGp6BRt+WSb1nS3xiF4WnZ
	 18Vb+33YoNxxUNjON6KbgVefvS1bh6yYCHSX6LPw+4JVqp/ROMwJCCIIUpaXmXcFYD
	 7TooE3Fr44rNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: Don't update power_supply on power role change if not connected
Date: Sat,  6 Jun 2026 09:05:38 -0400
Message-ID: <20260606130538.2924564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060557-ethically-perkiness-c7ca@gregkh>
References: <2026060557-ethically-perkiness-c7ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

[ Upstream commit d98d413ca65d0790a8f3695d0a5845538958ab84 ]

We only need to update the power_supply on power role change if the port
is connected, because otherwise the online status should be the same for
both cases.

Cc: stable <stable@kernel.org>
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-2-6f1239535187@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ changed `UCSI_CONSTAT(con, CONNECTED)` accessor macro to `con->status.flags & UCSI_CONSTAT_CONNECTED` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index b88f4e179a7ad8..757f4ec3799710 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -910,7 +910,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
 		typec_set_pwr_role(con->port, role);
-		ucsi_port_psy_changed(con);
+
+		/* Some power_supply properties vary depending on the power direction when
+		 * connected
+		 */
+		if (con->status.flags & UCSI_CONSTAT_CONNECTED)
+			ucsi_port_psy_changed(con);
 
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))
-- 
2.53.0

