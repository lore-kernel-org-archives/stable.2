Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048398;
	b=TzWTFvyjENFpFQdQ7asBGWaVQ/DdYfQ7Uj2T1/0k6XvbnQCMqYUvgM3QMFzoDojCM/mE
	 wZC1RzHzHqJF4W98NTSdNbho7H58kjzAGqMCc4QUb+JBeevxeciaHRkpOrO1naLreAdg+
	 YYST512jKls6T+ek9oZsnZYGEPwv0R20b5aRIWYbNXMbPsjqUYsK117hn5TPuzTlrMYVj
	 WAHsj4AHq9NRvXWfql7ZR8bC7fPCh+oSOq7rBVJPSvmzOs1ck1zETkyBKZsdba6JWYw7n
	 Xwo2WkHZvrNPQ5KkjdL+zI6iHvO0aeXTOmn4uzoyIUNlaZrHRWdiwUiVDBJS6GdX4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YkGgUAdTCvWgS3H8lHnkRF/Tv/Aej9TwlnrEt2RLnGA=;
	b=Dj6PfFtS2LMhk0VHsRaFbhPMGHWlNgMOALn89CPhMUbj5gyuko1vXyMfP3ILGWQSW4it
	 rlUZ0olzIiOGHtriNIVUd8uevksPdD9aHJsiCeCIuMFm28+RMhBiXnzJo0bDXrlZ+/OT/
	 gpXab0uxER0HjbFkjhPNuCz5NbPkPQJvOSZwmLdpDYOeyrvFA6OTYKRvIG8CEPKs43XsW
	 L6ai/duNNcBsSCdZUUrnggO5aE2XoJhUWxRo4tasSc/n8mSVV0nm0U8mTDTQBMuH0MDdD
	 bF5HwFZO2/RA6kzkpz1KR+RGA6OirHqqSFTcgExHMLTCu8TlhuEwEdpZfMYOf52RJeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF0+TAon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D845606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF0+TAon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2601F0089F;
	Sat,  7 Nov 2026 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048398;
	bh=YkGgUAdTCvWgS3H8lHnkRF/Tv/Aej9TwlnrEt2RLnGA=;
	h=From:To:Cc:Subject:Date;
	b=LF0+TAonqYiwKSYs5m2N1GqWRg7TnlbPm5H6E5NRaEK4mcGgc3kUI4/9L5xnpVsEM
	 N6eJMENbGuziI89403PXG5JnCezj7t1X7SBzRvXIbejq78zB9WkVa7PByED8MRUclo
	 VdxKMdRklflV41pE/yoVvHBeHCIIyDqaKoCkkp7VjtQH4Glj09Oo8VCh0KVRN+g1qE
	 72DVrYeM9w/mgbbBJ0MeSKO5ryKkk9vSuSnknTwKVlx2ofqVTPJE9kcXyiHatr8fmv
	 Vb7KSj0biHAJ6e2FHbfiSWbPauuOD8U1FHeV6baPFi/7if0smkXJ7d1yrPi1C+GKRN
	 j3s5VZV8gYLUw==
From: Sasha Levin <sashal@kernel.org>
To: eeodqql09@gmail.com,
	nathan.c.rebello.27@dartmouth.edu,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:36 -0500
Message-ID: <20261107054636-failed-6.1-02ee864e8d21@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 02ee864e8d2142c5648998944c3306ea6a763c26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054636-failed-6.1-02ee864e8d21@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 02ee864e8d2142c5648998944c3306ea6a763c26 Mon Sep 17 00:00:00 2001
From: Seungjin Bae <eeodqql09@gmail.com>
Date: Sat, 3 Oct 2026 17:55:20 -0400
Subject: [PATCH] usb: typec: ucsi: ccg: Validate altmode index in
 GET_CURRENT_CAM response

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
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 91c2958a708c0..80e3e84b418d7 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -384,14 +384,28 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)
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
@@ -636,8 +650,10 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
 
 	switch (UCSI_COMMAND(command)) {
 	case UCSI_GET_CURRENT_CAM:
-		if (uc->has_multiple_dp)
-			ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)data);
+		if (!ret && uc->has_multiple_dp &&
+		    (*cci & UCSI_CCI_COMMAND_COMPLETE) &&
+		    !(*cci & UCSI_CCI_ERROR))
+			ret = ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)data);
 		break;
 	case UCSI_GET_ALTERNATE_MODES:
 		if (UCSI_ALTMODE_RECIPIENT(command) == UCSI_RECIPIENT_SOP) {
-- 
2.53.0




