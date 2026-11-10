Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324177;
	b=3AcdXL5rB8brbtE3rEMyHtuBPl2ms1U+kPJjdtgLdyPDnXyVceCyM+gqDaQGfTihz7UH
	 CbYPCdCr8JDBqTbZsb2nlsiwYKOosvz35RRI7dfBzUQfWER4noSRPuCGDpg54FkwiHEL5
	 urkXsGnNjcel79qDhJp0XySAvyo+RrLPOCFPH7kklF+usSY7Pqxm/iHPVoJtaDNpfhtzD
	 b1UseF2lHhYxSzpwXcix0svnEt7o3DZu2DbTf6qPsQ47FmezeqJPRtenVzd1fZPtIKh36
	 /ExZIOutfjP3rfSMCa5zOkLhX90E+meP6XWKSq+P8/GI4YdE+kDzdole/zjSESdpmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V2hs5F5rcXBVyfLsJXORJE6edm4zrvxs03ZBbgJkHVw=;
	b=HXdrEnTMXr5YzumkXbRqklW1C1GC7d3R/CndJURVRPqqBWrlo3eroMYipgeZtifoV+3Q
	 o40a/Kj6Oj0LmVbKf891vhF7p1PwY+kUoGwgNM0JWLuda8E9tumhfyJ2/EHQD7wBsYGQT
	 Fp/Jw+bmGljWaBs80P9FcLxYgJHjC1e7VUB/9h/Q0CjnJXUPgRBIhIqNmSxMFaTUPEfJl
	 43Uez2CjlfJwaXaen6K9UoUu42oo+w2OFFZT2PQQfN+U43bA0DQrA5wvffZHAy/UZSVAf
	 abEh2hqfkbTXKptHIoqV4YGEQ3gCnbaT4KqGvNSKaaRpg/kZo5LbYHpVDkJBA71Oetg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knKdSHni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DC606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knKdSHni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED71F0089F;
	Tue, 10 Nov 2026 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324176;
	bh=V2hs5F5rcXBVyfLsJXORJE6edm4zrvxs03ZBbgJkHVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=knKdSHni4eY3DOLNAH6hppaLBHkNDbmpi+qWgP0wMKiq6TgImEKE8gnejthF3EcId
	 4lxzwJupqd0OagNb8VR9sFAQia8QEyF38M1tDBBpfxuN302elVG0stRkqBZWG28D3x
	 566DmvZykMc8e7QZ5cYGPqnWckmwOoh7Hq/Bu371vZtfVH3DaHYlwkM+OC3FjW841v
	 u1A7pPGiMGw9EeNAZntNBqLKgcX+MIa+PiXpm9L4SstBgGoyNGSlQz9aaEsP+E3rzo
	 FYA8GLl63yaSJ/68YYj2xYFKArHw5FtqSvVSZd0ttcF1HZ37WEB6XscewPWExbyM/Q
	 6Ra+dq5PA8aeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	stable <stable@kernel.org>,
	Nathan Rebello <nathan.c.rebello.27@dartmouth.edu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response
Date: Tue, 10 Nov 2026 10:22:54 -0500
Message-ID: <20261110152224.2080796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052102-failed-6.12-02ee864e8d21@kernel.org>
References: <20261107052102-failed-6.12-02ee864e8d21@kernel.org>
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
[ sashal: Propagated helper errors through ucsi_ccg_read_message_in() instead of ucsi_ccg_sync_control(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 3a4e1b6f22ecf..fbb65b734fc1c 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -397,14 +397,28 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
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
@@ -593,6 +607,7 @@ static int ucsi_ccg_read_message_in(struct ucsi *ucsi, void *val, size_t val_len
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
+	int ret = 0;
 
 	spin_lock(&uc->op_lock);
 	memcpy(val, uc->op_data.message_in, val_len);
@@ -601,7 +616,7 @@ static int ucsi_ccg_read_message_in(struct ucsi *ucsi, void *val, size_t val_len
 	switch (UCSI_COMMAND(uc->last_cmd_sent)) {
 	case UCSI_GET_CURRENT_CAM:
 		if (uc->has_multiple_dp)
-			ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)val);
+			ret = ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)val);
 		break;
 	case UCSI_GET_ALTERNATE_MODES:
 		if (UCSI_ALTMODE_RECIPIENT(uc->last_cmd_sent) ==
@@ -622,7 +637,7 @@ static int ucsi_ccg_read_message_in(struct ucsi *ucsi, void *val, size_t val_len
 	}
 	uc->last_cmd_sent = 0;
 
-	return 0;
+	return ret;
 }
 
 static int ucsi_ccg_async_control(struct ucsi *ucsi, u64 command)
-- 
2.53.0

