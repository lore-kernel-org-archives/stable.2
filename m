Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DCE416CF3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688312; cv=none; b=UdryxWXzYmvKAf5ztRZ5uT5L0ZQazN5NdgK+OrBi+LS7ZhLGh9ppOdROcd2jm1dDFeSf3fQw9Z5y44e/uiJ3iBRnCCNkiVWXsQTOl1LWHJlT/NBogsVc+DENM//+gL5Ar1PBN33xP6Sa5p3eTyFfRnK+QYhEVK4kFiNZyV7ntoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688312; c=relaxed/simple;
	bh=//gu5PY36ZJ8TQ155G9XighH/R5QjEC4QsMW6nlCm+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5JeA1uDKqp8AKJ50PVPg5x719H02YSeY4VFqAmRqiFoZzmNMYWvIc1PXhWjBP2amT2Qai83NCUPRdwYZHaORsKAscli2VXMf82G25txht5eRLgbew3IuBxk6lvIBZ8kC0PTuSno0HvT7wHVpCT/eVfOLMko2nawlWJSbEfr9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD9fgiQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD9fgiQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA3C1F00899;
	Fri,  5 Jun 2026 19:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688311;
	bh=wZ/D/Plt5j4MGVW9JmLKYkPw3KML2vS5LDa0+UVTbqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD9fgiQ4QvR1h/M2dva8yI9crzGyGTY9+rXRrW+cYECC0Tx3wpUpsPJ7vxmJm/hoV
	 knFkdkehYP//4Iirov3zIk54KEpeAZX4/UKT9rjfYvuVgGNU1Zgr8olMyYrOfzRt0o
	 Ppy/cs3ASTOcgcHHuJY63QkTg0K+n4Cqw4cyCpIt9zjJ9mMUObBgG5zdul+3BnTSmp
	 B8P+1Ggo+G6aplTPXFFEq2E5Yic4eLT5FwgElPWF3HSIVbBiwFwALxtY89vvT/aDs8
	 rydT8StGQNMicsNWCPJgljn6YTJtvugoKgG9mn//zTXeyTcfCp1B4TOlLacR2fmIpO
	 Meb7ZaOLe8dog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: Check if power role change actually happened before handling
Date: Fri,  5 Jun 2026 15:38:29 -0400
Message-ID: <20260605193829.2169488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060418-vanquish-saga-213f@gregkh>
References: <2026060418-vanquish-saga-213f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

[ Upstream commit b80e7d34c7ea6a564525119d6138fbb577a23dba ]

The CrOS EC may send a connector status change event with the power
direction changed flag set even if the power direction hasn't actually
changed after initiating a SET_PDR command internally [1]. In practice
this happens on every system suspend due to other changes performed by
the EC [2][3][4], causing suspend to fail.

Fix this by checking if the power role change actually happened before
handling it.

[1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794

Cc: stable <stable@kernel.org>
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5baa48213f1e57..efaf6a8e0cf8ec 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -783,7 +783,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
 						  work);
 	struct ucsi *ucsi = con->ucsi;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	u64 command;
 	int ret;
 
@@ -791,6 +791,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
+	prev_role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
+
 	ret = ucsi_send_command_common(ucsi, command, &con->status,
 				       sizeof(con->status), true);
 	if (ret < 0) {
@@ -804,7 +806,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
-	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 
-- 
2.53.0

