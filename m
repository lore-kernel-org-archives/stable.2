Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325134;
	b=Nzh+N+lOj8qoqDBR+Oxdqut5rNXj0svUtRzUQO/x3rmkMfatuauTCYWaZ/gzmzrnuwt9
	 EyptxZK0lH0NbO+n04Ynsi3vPDqmjvNask+8sPA1vGP7FvSbvV6BokkDqqxo58TbkIWWX
	 CXdQ1ZnkXy629yg4cr7+f/5hofVaWjg3A4jlqcBizbw9Up2F2rTutxAJVtM1C4OP9fork
	 w49hN/lG9SJLqXepCo0irvpXWrN1RpuT5qNmTN0RUskySYTNbyXIm7tVY9hTcCbQ88dYS
	 r4MYpvusWBDedgppRyfNrfUPLyvEOgmkfNkgO3LrleKzsqEQ7ji2jVXWe/+looESHSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yAlpTTVXGCkpoAqWyQzQF2/xAkRbjAwy9xer0+8/rzo=;
	b=iWjV3wMwRHONG85lV1nuheDrr0GCGth78RX9Jm0DjB4/dShOBAkq2fcPuVyLPiIcFwoP
	 5U9di02BQQWGqE9oLeC4E8e3Ea6+AgywurxMVl2Moahtq6tY4LSiHjrdQa3/QuavcS4tH
	 SnfRpFOZDgSM3dF6ZG3Ka8uUmj2yWc7owZ13BJUWZlYojzxE8hjyEM7ZYbVN/O0l9fh9H
	 5hvT5yKtLUkQEFWw5LyaDY9banmTJIXP0xk2Cr+ZlfkxywHHJAKtCNyPaK0W9He5TqLMl
	 x9GvDRe/XG7O0VnoRKp/QqzSiHIGOtV/GLoirKzxHESca6o0rL4dBIEPFeA+5IKSPgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQhavh7v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC2606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQhavh7v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A71B1F008A3;
	Tue, 10 Nov 2026 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325133;
	bh=yAlpTTVXGCkpoAqWyQzQF2/xAkRbjAwy9xer0+8/rzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQhavh7vde0i7kHlyd/Kip0MzW376FeTi+dwJXYKNKY1pPzdBVjmItWxiDjFCMErk
	 P9yvF+81KluJO2vJKYPFBoVIKOFaltKV0KGBZA4bcP7Bu/RcdiSokENHAxxDBh32QC
	 POpupRHvk2Efb9Yynw4QI8fy587taSJ7mum55jnoC8O8kdC02Rxb1qcG5wxFbXVSC6
	 U0Tn2nxvIMmH3+QOSCMbKVbKl3SOH4PJeYdEoZZYzYfkioqGNAC1azuvhcAhdmdchk
	 40/H55Rg5IUQm9zkRM1OQtAy3fuDHIwEtfzYujYal+AAj91uqwgjcHQN9GKTfE5v/P
	 iWXVHr5SK0xxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	stable <stable@kernel.org>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response
Date: Tue, 10 Nov 2026 10:38:52 -0500
Message-ID: <20261110153828.2328698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054636-failed-6.1-02ee864e8d21@kernel.org>
References: <20261107054636-failed-6.1-02ee864e8d21@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

[ Upstream commit 02ee864e8d2142c5648998944c3306ea6a763c26 ]

When the PPM reports more than one DisplayPort alternate mode for a
connector, ucsi_ccg_update_altmodes() merges them into a single entry
in uc->updated[] and sets uc->has_multiple_dp. In that case,
ucsi_ccg_update_get_current_cam_cmd() rewrites the response of the
GET_CURRENT_CAM command. The response is a single byte holding the
index of the currently active alternate mode, and it is provided by
the PPM firmware.

The function uses this byte directly as an index into uc->orig[], and
then uses the linked_idx read from that entry as the translated index
into uc->updated[]. Both arrays have UCSI_MAX_ALTMODES entries, but
neither index is checked against that size.

If a malicious or buggy PPM reports a value of UCSI_MAX_ALTMODES or
larger, e.g. 0xFF, uc->orig[cam].linked_idx reads over the end of
uc->orig[]. The byte read from there is then used as the index for
writing cam into uc->updated[new_cam].active_idx, so the out-of-bounds
read is followed by an out-of-bounds write. This happens without any
userspace action, since the UCSI core issues GET_CURRENT_CAM on its own
when handling connector changes.

Fix this by rejecting responses whose index is out of range, printing an
error and returning -EPROTO, so that the caller cannot accept this.
Also check linked_idx before using it as an index, so that the write into
uc->updated[] is always within bounds.

The response is now only processed when the command completed without
an error. ucsi_sync_control_common() only reads the response when the
CCI reports command completion, so otherwise the buffer is not filled
and must not be mistaken for an invalid index.

This bug was found with a Python script that traces where firmware input
is used.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Cc: stable <stable@kernel.org>
Reported-by: Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>
Assisted-by: LLM
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20261003215520.611083-2-eeodqql09@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adapted error propagation to ucsi_ccg_read() instead of ucsi_ccg_sync_control() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 20f7f87a92f2c..1ee2f4d9de4b5 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -356,14 +356,28 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
 	return -ETIMEDOUT;
 }
 
-static void ucsi_ccg_update_get_current_cam_cmd(struct ucsi_ccg *uc, u8 *data)
+static int ucsi_ccg_update_get_current_cam_cmd(struct ucsi_ccg *uc, u8 *data)
 {
 	u8 cam, new_cam;
 
 	cam = data[0];
+	if (cam >= UCSI_MAX_ALTMODES) {
+		dev_err(uc->dev, "PPM returned invalid alternate mode index %u\n",
+			cam);
+		return -EPROTO;
+	}
+
 	new_cam = uc->orig[cam].linked_idx;
+	if (new_cam >= UCSI_MAX_ALTMODES) {
+		dev_err(uc->dev, "invalid linked alternate mode index %u for %u\n",
+			new_cam, cam);
+		return -EPROTO;
+	}
+
 	uc->updated[new_cam].active_idx = cam;
 	data[0] = new_cam;
+
+	return 0;
 }
 
 static bool ucsi_ccg_update_altmodes(struct ucsi *ucsi,
@@ -547,7 +561,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	switch (UCSI_COMMAND(uc->last_cmd_sent)) {
 	case UCSI_GET_CURRENT_CAM:
 		if (uc->has_multiple_dp)
-			ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)val);
+			ret = ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)val);
 		break;
 	case UCSI_GET_ALTERNATE_MODES:
 		if (UCSI_ALTMODE_RECIPIENT(uc->last_cmd_sent) ==
-- 
2.53.0

