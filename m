Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17AE3EDE63;
	Thu, 13 Aug 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644989; cv=none; b=N9h1pHJN5RoUJUWJ/+sPzFpfgkevDFToHOdsf6KeuVCGovnfw9H5vVflEPL0uR6pXXYgwcl3bUluUQ5ToHL9JD2x3pl2B/yPGtk+k+OUCL9a3ISMwicFdhfMmmp9k7NMqHWc+KQl1L3isvLM9aqWkPX8JvE7u9A0950zB7P9dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644989; c=relaxed/simple;
	bh=mGb6tNHi+V8a2B3yjUlf9eOR715pdSx5lBUYHC2f8P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eet2l3RikVpUfyGAHjPXOsW/qfL7wKMTZ6jr5Q7Jen1mlSvg1ZOFkNtC1YsU8sRlNGAWxaC+/lGt7YXJFPzTvD9JIn4+PvzD0q5aXWWM96z4kJR7qchn6mORz5ER0rDw32eoWE3/9FGjPg6V6x5pW2+ME9IyncSoNP3q1uuWlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFKqAZG1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFKqAZG1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53C83C19425;
	Thu, 13 Aug 2026 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786644988;
	bh=mGb6tNHi+V8a2B3yjUlf9eOR715pdSx5lBUYHC2f8P0=;
	h=From:Date:Subject:To:Cc:From;
	b=cFKqAZG1ALolX1jdAsBHyNR7ULMRirqLCWK6NxuR5kX7GZUPgMp3YcJSbZ1TR0byI
	 jl4tbxW3WV6CgKGRlJeR+9PWO6ar0RzM/Sts+K+1KATzegCcN+rtIRlww8+BGJBN4a
	 e7Wf0aQShJoiGGZ/mhD4POgMhRXcAVvWO7nuBPNJnV/ytWXTCjz2EDzI/ML+k4ojtU
	 VXAiuLomkzK+68oMtvcGXAShnupGHPOD5Y15Sg25kQZnLVKRNHQv1Q2sF3fV8ZIRUb
	 +quXVMe3fg/e2YBYdzJBTK2f9viRGO6Pbf7Dbf24nkBFwI74/qdqCVOJ8iskgwbQQN
	 ffSETS9/jAzVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A0C5B572;
	Thu, 13 Aug 2026 18:16:28 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 13 Aug 2026 20:16:15 +0200
Subject: [PATCH] usb: typec: tipd: Fix Thunderbolt altmode VDOs for cd321x
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-b4-tipd-vdo-fix-v1-1-70317f2cd554@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE2CVtO4ili0OhgLpEUk0rsrl
 t9L3n9DIM8UoMlu8HRy4HVJKPMM+sksIyG7ZKiKShW6FGgl7rw5PN2KA18oJanaSm3ICEivzVO
 av2Lb/Q6Hnanf3wzE+ADk7CYHcwAAAA==
X-Change-ID: 20260813-b4-tipd-vdo-fix-44e65b48aea3
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3562; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=mGb6tNHi+V8a2B3yjUlf9eOR715pdSx5lBUYHC2f8P0=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1Yd5895Ww0T8suTns5RbxHrPvusZkVie1q8ZczaCTaRw
 ieNWMM7SlkYxLgYZMUUWbbvtzd98vCN4NJNl97DzGFlAhnCwMUpABNZq8/wk7FRq/Rny906drdV
 91rCNTziovJuCx69sWyv7r3FW1bGyjIyrL7+W8Px+vsTES1y1VX7HjD26DX+UqufueFCF8PisMN
 feAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

The Intel VID status register is actually 9 bytes long and doesn't
contain the raw VDOs but only the upper 16bits for device mode and enter
mode. Shift those two fields into place and reconstruct the cable
discover mode VDO from the data status register instead since it's not
directly accessible. With this fixed now the correct VDOs are forwarded
to the PHY and the to-be-submitted Thunderbolt/USB4 native host interface
so that the right mode can be negotiated and the link actually comes up.

Link: https://www.ti.com/lit/ug/slvubh2b/slvubh2b.pdf
Fixes: 0b31c978935f ("usb: typec: tipd: Read USB4, Thunderbolt and DisplayPort status for cd321x")
Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c     | 17 +++++++++++++----
 drivers/usb/typec/tipd/tps6598x.h |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index d5ee0af9058b..159d1a2f9a1f 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -114,7 +114,6 @@ struct tps6598x_intel_vid_status_reg {
 	__le32 attention_vdo;
 	__le16 enter_vdo;
 	__le16 device_mode;
-	__le16 cable_mode;
 } __packed;
 
 /* Standard Task return codes */
@@ -700,9 +699,19 @@ static void cd321x_typec_update_mode(struct tps6598x *tps, struct cd321x_status
 		   cd321x->state.mode == TYPEC_TBT_MODE)
 			return;
 
-		tbt_data.cable_mode = le16_to_cpu(st->intel_vid_status.cable_mode);
-		tbt_data.device_mode = le16_to_cpu(st->intel_vid_status.device_mode);
-		tbt_data.enter_vdo = le16_to_cpu(st->intel_vid_status.enter_vdo);
+		tbt_data.cable_mode = TBT_MODE |
+			TBT_SET_CABLE_SPEED(TPS_DATA_STATUS_TBT_CABLE_SPEED(st->data_status)) |
+			TBT_SET_CABLE_ROUNDED(TPS_DATA_STATUS_TBT_CABLE_GEN(st->data_status));
+		if (st->data_status & TPS_DATA_STATUS_OPTICAL_CABLE)
+			tbt_data.cable_mode |= TBT_CABLE_OPTICAL;
+		if (st->data_status & TPS_DATA_STATUS_ACTIVE_LINK_TRAIN)
+			tbt_data.cable_mode |= TBT_CABLE_LINK_TRAINING;
+		if (st->data_status & TPS_DATA_STATUS_ACTIVE_CABLE)
+			tbt_data.cable_mode |= TBT_CABLE_ACTIVE_PASSIVE;
+		tbt_data.device_mode = TBT_MODE |
+			(u32)le16_to_cpu(st->intel_vid_status.device_mode) << 16;
+		tbt_data.enter_vdo =
+			(u32)le16_to_cpu(st->intel_vid_status.enter_vdo) << 16;
 		cd321x->state.alt = cd321x->port_altmode_tbt;
 		cd321x->state.mode = TYPEC_TBT_MODE;
 		cd321x->state.data = &tbt_data;
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 03edbb77bbd6..d172c84ada74 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -206,10 +206,10 @@
 #define TPS_DATA_STATUS_DP_PIN_ASSIGNMENT(x) \
 	TPS_FIELD_GET(TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK, (x))
 #define TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK   GENMASK(27, 25)
-#define TPS_DATA_STATUS_TBT_CABLE_SPEED \
+#define TPS_DATA_STATUS_TBT_CABLE_SPEED(x) \
 	TPS_FIELD_GET(TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK, (x))
 #define TPS_DATA_STATUS_TBT_CABLE_GEN_MASK     GENMASK(29, 28)
-#define TPS_DATA_STATUS_TBT_CABLE_GEN \
+#define TPS_DATA_STATUS_TBT_CABLE_GEN(x) \
 	TPS_FIELD_GET(TPS_DATA_STATUS_TBT_CABLE_GEN_MASK, (x))
 
 /* Map data status to DP spec assignments */

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260813-b4-tipd-vdo-fix-44e65b48aea3

Best regards,
--  
Sven Peter <sven@kernel.org>


