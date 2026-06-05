Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFEE3B1BD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684299; cv=none; b=pfDJ9uTXmnngp0mlMKkj/GOsDr6hoV7ODQscZfq6gIdEQwK/of1/I7s77FQ7CEcSCN0WF9+eAVQrKzHoieqJIyyT/ovBIDCO2QBfkV47i6OxQj4+SMzvIm8nLTI5ZMqXVMyWTZIVDYxz+XAR3ebGtghvipU94FxIg6R97bRk59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684299; c=relaxed/simple;
	bh=gijIM0U66RV9KZxpaC7l0u1rgrhIAKQsYd8AJFvCwS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2OXECEkt/UbmiRRa06bn6+repasdH3h/9cnmPOzxLJQ1KPtr484Az63gsYBQnVml6qZ9WnFZ3vODDyRTzHBRUCGlDs0LOBppDYN1NLS5VQUVxWMeYP+akcn1wqdu/U8XM6sbJNezZv5KU65osjO/sGxpsUtL2mejHoIbMTaC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coKb3mUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coKb3mUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A491F00893;
	Fri,  5 Jun 2026 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684297;
	bh=dkzYs/BaBQrm4s/eoTJqf/YTVV7Xho3OOdUhGMTLHXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=coKb3mUjQnvc+uCEgT5N1OvnU6VpURx/yC6Po6lE8GNNnQu/f7L8c0oCxAjWxFtIv
	 Pt+CPCI/6Y5ZBWL9sOm/5VGhM7LmMyebXQmjEF28gGt4PDvpQg7MwOQKUquXUZAGar
	 6tjxxraTFfN1HKHe2wOc+YYiJn0cnvK6FX1HkTnM/MCm2Dlf2JzigcKtvDI7/6H2Up
	 jA+LW6sFR8RPpS0kE7wT2C0miRR3OOw2gq0GB/M8AALEg52BBIQClovgYOszmiGBAZ
	 C04lBU90beMGvnbSpmn1ZvUn2Af7Ddy7337PaqFU5BRgmuBD2ByLrGsgLtL745mYxz
	 Roqi+R0DmlHoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: typec: ucsi: Check if power role change actually happened before handling
Date: Fri,  5 Jun 2026 14:31:35 -0400
Message-ID: <20260605183135.2056737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060416-womanless-occupy-e037@gregkh>
References: <2026060416-womanless-occupy-e037@gregkh>
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
index efe45ce943747d..06c788f51ee4ca 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1201,7 +1201,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
 						  work);
 	struct ucsi *ucsi = con->ucsi;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	u64 command;
 	int ret;
 
@@ -1211,6 +1211,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
 			     __func__);
 
+	prev_role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
+
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
 	ret = ucsi_send_command_common(ucsi, command, &con->status,
@@ -1229,7 +1231,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
-	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 
-- 
2.53.0

