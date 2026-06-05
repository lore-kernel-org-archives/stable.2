Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C22738F636
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687046; cv=none; b=siPMn7FKGPm7oiEbHwnrvFAiMH7SUd7c/5s+5P7U/QnsoJvgfpHJ+2oEtHAdHW5tISaK50mcxHQTFWDpKCKc7Wr3Uv/VybEbFwT8qYryCmf0MKyuZpRYwVK44CyXLS+704sEGoLUO0naFIAisJXyfPi899Gd2D241gpPppK/Zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687046; c=relaxed/simple;
	bh=EM1JgTzzbjxuXKbdMgZx4743pzAHAS8JlY7n9hK0UiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwihpUoaQwwefbomd7DZlu6bWjZuUOsDbS4jYjQ4QqMd+ZPAReMOh0JQp+syKuFv1dyjR2umaSuYyP2SEMZ+iJ67aG6AlTy7K+O9vxHFuf7zIK7R1oAjTsO5RxYHWzHSQYTR3H7f1fCzVtNEy59TgQEuOILd2xK272T2GquCKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7RhSMFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7RhSMFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E4C1F00899;
	Fri,  5 Jun 2026 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687039;
	bh=IVziJgLBHc2t0/P97HwCuR9mgEon0lVdIgnisvDBs3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7RhSMFKXnVQPxilcCsUpTHTWshI4MhT7ryf4g3faSoaYflHYXW4oICnvRiWWBsi0
	 C/zUzSUtfw8xL3HlBi+j8ELx5GAzyWlmIpzoEuIEVvR+aK1J99hXp9TI7K1x5iwIc1
	 bSjoO2tMRXdmZh3YJbKjFUIOXEqbmwiBfUrbixwjOVRty4aS3WW6uFWUDjiP0meDp7
	 S4k4SpK+/BvKdaDWhfR1inMIFBCYVVoDlDVtypDFFPdKmyZ4DY67uwGd7nOPt8ROxw
	 G8W9J+X/zvwrEtTt2LFnuvyBch/UraUhWqeXD32jv/dh2y0GY6StnujPSQ3knrSase
	 5pdKrUETq27Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: Check if power role change actually happened before handling
Date: Fri,  5 Jun 2026 15:17:16 -0400
Message-ID: <20260605191716.2134705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060417-headless-faceless-e4a9@gregkh>
References: <2026060417-headless-faceless-e4a9@gregkh>
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
index b88f4e179a7ad8..3060a4a13cfc2e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -884,7 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
 						  work);
 	struct ucsi *ucsi = con->ucsi;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	u64 command;
 	int ret;
 
@@ -892,6 +892,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
+	prev_role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
+
 	ret = ucsi_send_command_common(ucsi, command, &con->status,
 				       sizeof(con->status), true);
 	if (ret < 0) {
@@ -908,7 +910,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
-	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 
-- 
2.53.0

