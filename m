Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A33B71BD
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496251; cv=none; b=gGgrQpD5LirSqqdOiZID8nVAhqXNDfWOPpMoUS36ffcdRaxK2L/XyDnbwAv9yHdTl7/VqsRW4Wjy1+OkK9B9KkNiI5mD7Gf5uSqOxxAfzQA9dgwi9ibWnkSicEHU/VHCW6g8T24CLNIXvrRmeW77PVajk2d/XuSbMX/yMMFPoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496251; c=relaxed/simple;
	bh=OrMF8/0+qYyrjOag5c359VJ3lfHKWVNLx6b5WBn3Phc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Po7NgTmcBFJPgMioouwU1oDKvCpKEXiXh6SMzPsq/3I5oeYNX6QDMto8MYZ9T0OIgcTTvTtRtMCQ5S08gOnHjy/4eJn982ovdXsld854osdsCDV054rxe/0ltBAGNMGGsc9s/BtxekddKCzd3CXGjtvmXyVzd2WKeS1BmshfV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAAIdOGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAAIdOGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7108F1F000E9;
	Fri, 31 Jul 2026 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496249;
	bh=1PD5c9fETFJmAjgpIGruKVs6k+cw7yqkHjdCKXZIpzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAAIdOGz0o/Q0wlIy3yt/8oHzqlJ5WjyaNtb/6HMj7DlR+dO7l++hfrYSfUgQmn9G
	 N5NKxzfASecEfYh7qSdEVKzD7qitzYy1VoBL1Gsz40tWEXM91x8y7PXoPaA+K8Hpl1
	 AEAC70MdzV5q2i1iFsp2CGQ9mQlNhqKsbYCr/uHlNaK6FTvvggnuP6MKXWxuIab/ZK
	 pn4HjgI+kJBp4Gp2K510coFV7TMSf9sjeOjogKh8WcMniMao4wPTa2SZeSd9vDxuJ3
	 944FPnmqReTpcJDk+IMkIlbeSjpBCLCaYpQXxR1ylLGy0SuLXHeEJmXKYD/DyTS0ob
	 MhbgNt/ZqBk0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] usb: typec: ucsi: Only enable supported notifications
Date: Fri, 31 Jul 2026 07:10:44 -0400
Message-ID: <20260731111047.3593727-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072727-scarring-railway-c5d9@gregkh>
References: <2026072727-scarring-railway-c5d9@gregkh>
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
index d68953ec74f2..369af8a05fc9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1254,6 +1254,27 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
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
@@ -1314,8 +1335,8 @@ static int ucsi_init(struct ucsi *ucsi)
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

