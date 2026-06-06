Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF726E718
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748344; cv=none; b=F7i97SKS/7N5vQFbULQR+2dcDLx2ZLcSVRrktAq3Qe6Tmiildng95Irgi5d826ttXRwylB2sRzgKJMykWMj2t0WVvZwJNdhz/BaeQEQ0CAIGei5esBCr+KrHncmGQ4j6LJ/icgXNMwvmJ7BKKGrSNDnmw8vE9UygPS/Xu0fCU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748344; c=relaxed/simple;
	bh=zW2EIR0wei+b1ULqYMbNSVpo1xOV5BJ1mq89w98Bji8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiw3bPL39riv2+GbR/3ZJgy5gtClXZHWpL3nm8TaZYm6BbjgHtc9e+RdfqgYg54AYQr3mx9T+cEeQ9aJihnJvRWPv/C1mImSPigFGU+U32gZxoLs8senKPalnLWAVK2z/xV24oSoWTzXiQ+7fBN52T2fXeDbOrCN2iXMKKZLN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izaa/lGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izaa/lGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD7D1F00893;
	Sat,  6 Jun 2026 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748343;
	bh=PFtHzB6i6sdwF+zbv5itpj7pKY1UuZZ5Y2AvllF+qYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Izaa/lGckvXs0AwsE8fU7aLNXuyXFZRzvQ7a8Zw4jHvMtYmfock7baT0vJDd0VG2l
	 lyngSD0KrZjdK495YB2l2oa1LovpmBkN4BhpB2yGtRX2tDsdNp5mhRp1cyZRFiECU6
	 Yq4RWwUTA21Ex4NfCLS0KDotlWZjMOJTivXclHSDRfkRDK6XuX67BhP/2AsnbExwjd
	 +KDAq3hxT40Xi9i93JzdiGWXt799cKnBdcX3Vuy4cD4XWKcexXrzCmE1X4mx+rQ4vP
	 utkmO61eEyv8wNhjN5o3cTIn9x53R3BRIX4L4uGM/ug/wiPzDITbn1830Xiqjbj4Dg
	 WLtvRXiKGo6Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: typec: ucsi: Don't update power_supply on power role change if not connected
Date: Sat,  6 Jun 2026 08:18:59 -0400
Message-ID: <20260606121900.2851177-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060551-crazily-gatherer-b40f@gregkh>
References: <2026060551-crazily-gatherer-b40f@gregkh>
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
[ This is documentation for an already-completed backport. The change is described clearly.

"translated upstream `UCSI_CONSTAT(con, CONNECTED)` accessor macro to in-tree idiom `con->status.flags & UCSI_CONSTAT_CONNECTED`" ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index efe45ce943747d..1ae12a47f75564 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1231,7 +1231,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
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

