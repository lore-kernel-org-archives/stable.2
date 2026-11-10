Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325829;
	b=ezECN3LA1tMTQG79tco5x7K5jo0NADk4LWDhRpdpk1EY9L7/Tq9oI4RskfP1aj38OIv3
	 jtCVkVj7+FHGixQ1GvIibJhMHTGhODpcvvrL1s8XB1TQal1H9R9093qixlX7+SXnVZrya
	 tC15HA6SheDwrq2gDWL4CXwkBFpwA+PhmKBadN/A6/FlASyHe0BVqbABnGUQOwHKCz8JU
	 898z2nLTowY2tej2dRT37IfqiH5BFftn9iw/ZqglokMOhQGb2VmQlO+K7kesZHF/Rr5Tw
	 nP437gOR3pjcuaWLGb7iz7guItlAKDasDmaNRSc2QqUvqTQhiUTsbRpIhgH5kC76xNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ksMy58YBadyOzW5jmhuirj6MqnxQt5tR6Lw2I8nTjXc=;
	b=PfFNo7BV6r3UWe8rSZHCMW/Sqb8VdS0NGkyU2bDkIRJ8sox1HRsYYiN+Y0P6//SwUUGk
	 1Mhl9CatK8fM307kcam7ZgnMh87C7DjOlj9gP4Mp/GKybaj+3DEGsbVSCdR8o/F/bT6ir
	 XD9543eTmZ0OG0SnEVzcQD6RtNmSGjbUTOS9mJGfY450lgzP9u1V1fvVULDcbYShR5cQ6
	 jixnc1zVO/3QZYRCrGdDq0hLOfVOYLza8Ev0Np7nNFZLS21twYayqb4Lqo+TOAVF91VLR
	 tJvzmnuppPYwWYHKBB2L3DIXV41dJEwr2ixzbcreuCwNHMm6n/HkIgiVlEAgrEFzgSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPawJClg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C17606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPawJClg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BC81F008A1;
	Tue, 10 Nov 2026 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325829;
	bh=ksMy58YBadyOzW5jmhuirj6MqnxQt5tR6Lw2I8nTjXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPawJClg8Dblx0wf2uT8yP5Wbg7ssywwvj1vVla7OawNxfPkyonnrWEUf6518c33j
	 C1vO97LVVRqQnbDjcJ7zryI7LU5fpmm9hQ/WcLXoQxN8di6AEMzBfVZzloY6dZ5Xwr
	 J3kOng6bhlQpSYd9LC/oAsF4mgXRloRVKRnuUgtOZmF0wNrUfzC9m4UAjOJ3ydyeX8
	 zAGsR4cjsu48sd3klclu12VjqezFoWnoxNde0CfPBdJEP12QjE1SK8DbYMxDl4oCHX
	 ZSmJpMyVghBDQPuC1lPm4lXgfpeQHodYAaVLRKL7rkg8P9AZt+PMZlLA5iY7aE9YL/
	 kPTptK7RjTURg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	stable <stable@kernel.org>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response
Date: Tue, 10 Nov 2026 10:50:27 -0500
Message-ID: <20261110155003.2346757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062044-failed-5.10-02ee864e8d21@kernel.org>
References: <20261107062044-failed-5.10-02ee864e8d21@kernel.org>
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
[ sashal: adapted the ucsi_ccg_sync_control() change to ucsi_ccg_read() without CCI status checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index b50933cd4babf..2caef7d02cbb6 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -351,14 +351,28 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
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
@@ -541,7 +555,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
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

