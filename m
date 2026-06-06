Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D00263C9F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780755848; cv=none; b=fk5pV0kEYthRPe4ZzqZIHTDHwUrx0wQBEvlFBINVBayQVsSLKxqBz8ILDDpgT/jUsQT2Lxo00cxJj6kgYGvi6EhsDB+xvUqr7ddsx3tJvyjoLBBsV1m3vvsrFH4q8KXLI2LbcE+R04Z+scK04lNQr+bGyRQcFWrkfGuBoKf4Z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780755848; c=relaxed/simple;
	bh=DjzyiQZV6AZcnnhs2sZ+mvfY+UeKqoYVh0VBZwCMHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+gYmjCr+8I6t2T1udo6/HIKa/tzMSz/WwlZcVLan7zunHmT68D0RzwycZIpyztSE4nRG1q8NNzfvjr0bTa++yAbC85LWV1XhG+MIIt9EZWGBU2KdIMhZ+eYlXxh5CLvS4bONvNjK4e+hWVHTcFDPgfGioncA4Yh2fLYWucBAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sulk+WdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sulk+WdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB5C1F00893;
	Sat,  6 Jun 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780755847;
	bh=v9ncNWBsdlWjv3Iw4J1GxZylzIybcnuwAoe1gZeEV8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sulk+WdKiiT1URvKZImHK74L4k9LRL8pkWtjWlXCMbkdJdqdn5cMJY8XI16GPVScx
	 TwQBK8FtIZN9MKduAlUFxEftfUT4QWzcF/TPTSOzrT9BgR+cNS8CcGtD0DOUK68hUk
	 G25rf2HG6CtZVxDVtq3HouR7A56z4trBanm373kYZnVt+TgjKJBwfPXed+V5E/g0DK
	 nDlwa2Xg/cmwnNw3C/D9EAZLJL7FvaJ4l35jKhpSdYiteaohs72BvJP2fbLDBOIkuY
	 aq8d4/dv+TyO/+xPl3r5InUhvGP/zOTxyKMQ/99zSyrEMxyhQRFJIaWoK0iQ1X4Dr6
	 F78J2xLewbi0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: ucsi: Don't update power_supply on power role change if not connected
Date: Sat,  6 Jun 2026 10:24:04 -0400
Message-ID: <20260606142405.3108014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060559-detective-buckskin-3910@gregkh>
References: <2026060559-detective-buckskin-3910@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 60339c74669417..2f7b45eeca4abe 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -772,6 +772,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
 		typec_set_pwr_role(con->port, role);
 
+		/* Some power_supply properties vary depending on the power direction when
+		 * connected
+		 */
+		if (con->status.flags & UCSI_CONSTAT_CONNECTED)
+			ucsi_port_psy_changed(con);
+
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))
 			complete(&con->complete);
-- 
2.53.0

