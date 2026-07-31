Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA117262E
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465661; cv=none; b=F6QgjigccLDzM3wteYSvBj+2hC8Ied1tMguD9laTg19IJpUjmdtIOcYyszTUjj72phzRZoloKoRiy3QRcdLf2ls+lbMiJqkEzTQsRrqohQzUKnRmt+LwSV36Ij42nZ3P8mtZADoJU+AGuFm57Hri9C3YLeNVRFLk/q96Y00CFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465661; c=relaxed/simple;
	bh=WCrag+7PNwTcqft4ZzR7ktUlY1eG29j3fA9CPrAqTn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MryaxQU05vYECLp7+GE4ufQY9fxeDE5sHNRzAXXsnC32Yki+hehrrEJl8mw2usJZXlbLrfeSJZIhyX7FWvppnoxtr20K3IjGbfUYuvhEeui3W8KQqO3gotywoWgQJD5GG3Yo5z58gVoctMGXDMoUPe/mz4HGt+KETFXmlgRCuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsaSE0wY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsaSE0wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C511F000E9;
	Fri, 31 Jul 2026 02:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465659;
	bh=bSj5Lxm1DovQR6XDSfQCgV839iNSB+gos/1Tq8maXjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UsaSE0wYYYVmoQxstnsE+JG8/TLwtTWvI0msTntZmc3nBXIJc0pK8Dq+XFOeF4gD1
	 CgmRZGrEMFN/VIzDqnCZ9jxfx+CpssjrWtFcvgnPArQCziijD2vgKruGMXQt5KjLei
	 9df57xOFvXOm6g/AsNM6Is9QjjNPGxv9e5rEpJ7BUwH1d015uj7F+9B/lClK5aEAsi
	 9t+N+oLL2hDsUjSeXBVAJcOOBO8eY577Ly3X4NxLYpxnWPQv1jir6RPGRjRjTFn0Eb
	 lHYsQoJYnaQzwHrb5COXczapw2v+lI9nuC+c+0rSgPjjbbcWQMRew18QDTPwbmrVld
	 3POmvVhJQLqmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] usb: typec: ucsi: Only enable supported notifications
Date: Thu, 30 Jul 2026 22:40:55 -0400
Message-ID: <20260731024057.3338855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072727-giveaway-lumpiness-947f@gregkh>
References: <2026072727-giveaway-lumpiness-947f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

[ Upstream commit 27ffe4ff0b33b3dcc97fd448fd1e38d31ade575b ]

The UCSI specification defines some notifications to be optional for the
PPM to support. From these only enable the ones the PPM informs us are
actually supported.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/yhz7nq622mbg3rqsyvqz632pc756niagpfbnzayfswhzo7esho@vrdtx5c3hjgx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 7aa7d4bf9d3f ("usb: typec: ucsi: Fix race condition and ordering in port unregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a70e0118680c..ad1a199d92ea 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1406,6 +1406,27 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	return ret;
 }
 
+static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
+{
+	u8 features = ucsi->cap.features;
+	u64 ntfy = UCSI_ENABLE_NTFY_ALL;
+
+	if (!(features & UCSI_CAP_ALT_MODE_DETAILS))
+		ntfy &= ~UCSI_ENABLE_NTFY_CAM_CHANGE;
+
+	if (!(features & UCSI_CAP_PDO_DETAILS))
+		ntfy &= ~(UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE |
+			  UCSI_ENABLE_NTFY_CAP_CHANGE);
+
+	if (!(features & UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS))
+		ntfy &= ~UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE;
+
+	if (!(features & UCSI_CAP_PD_RESET))
+		ntfy &= ~UCSI_ENABLE_NTFY_PD_RESET_COMPLETE;
+
+	return ntfy;
+}
+
 /**
  * ucsi_init - Initialize UCSI interface
  * @ucsi: UCSI to be initialized
@@ -1466,8 +1487,8 @@ static int ucsi_init(struct ucsi *ucsi)
 			goto err_unregister;
 	}
 
-	/* Enable all notifications */
-	ntfy = UCSI_ENABLE_NTFY_ALL;
+	/* Enable all supported notifications */
+	ntfy = ucsi_get_supported_notifications(ucsi);
 	command = UCSI_SET_NOTIFICATION_ENABLE | ntfy;
 	ret = ucsi_send_command(ucsi, command, NULL, 0);
 	if (ret < 0)
-- 
2.53.0

