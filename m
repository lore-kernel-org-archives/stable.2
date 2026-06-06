Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DA3AEF34
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752117; cv=none; b=ShqGQ6lEAqGELfb8AyomaDwBkxfIPsbxo/7DUn20qVLvK1JIVeOGqnfOzlXkKFL3CRR/cqVV9cl6Lhvq777EQCx5ZidfVlrC5mbARZSiimZZsPDi7cx7Xiky/YoYDsKZBRLUUPSC70jY+r1kjHQuVYv7Q0svS/AfyZXVyNGXhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752117; c=relaxed/simple;
	bh=YIHAeUcM9eCQnUZAarR4PZ1SCmpfzCUEDLTr2GKvo/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4gdVXXcTsdxfw+/VRsjaXvfuyOmiKJLsyYTUwNls9GtXGMhi0ZoPddNSdti/n0AfQMx4crDUUvilgwXVgrB1WCxYnfTakniYcyppEP9XtGMRE6jxY6Rvi3Pi7n3YfDuwDgQ7dq2B3zJ4vEnF09czdEtxz4CBUpGJ2BeVl1cxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTKhv3uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTKhv3uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5081F00893;
	Sat,  6 Jun 2026 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752116;
	bh=eQXWFvF/0+3QhCMJ6TPwGGvYrl0SAWrChYsYP/ckGlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTKhv3uobEMPP3Hjx8a1poMRCeOt6a17qXBFZShfELx4JjRaUxR7oLEcZqDgAdWTz
	 j2P+4RkZciM5HMP3cKJ3ifKJoo8ffaDRaKacOEQ3F7yg8LOgRSULgzf6t1jHk0wM12
	 Vbl/JBDXL/4FJwi2IevPe6wCNwUv7mZoma7kRgdnF7TDXOvSvgaHMLnWGoFIN9Iaqr
	 rAstr2ziHLUJK6IbDN/4njBJuSgR8Z7CKNjV/9WM7XTWbosmYUmM3TFh3vOI5r/Svn
	 ImFmvEey/Ahk+AjcOZah9x8bFSAzVUZoIAp90pNYS9hjh8VpPH+33/WydQcbqpzygh
	 UtfvWm1xeInjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: Don't update power_supply on power role change if not connected
Date: Sat,  6 Jun 2026 09:21:53 -0400
Message-ID: <20260606132153.2949745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060557-finishing-leverage-ebc0@gregkh>
References: <2026060557-finishing-leverage-ebc0@gregkh>
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
index 5baa48213f1e57..021589ebdbbb88 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -806,7 +806,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
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

