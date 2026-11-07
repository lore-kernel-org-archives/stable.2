Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049450;
	b=kqLlSTljF+sljJG3Ffr7sG+XT3ZlVkj+2zFxz6ceO0CxmHW/U3j966CH7fPLTx9yee4f
	 H9cX9lGD/P/8Bde066sBTpBMJVnMYS4n0QKwfYNCdH1X38I0PnVqjAyA2FEW/c9bfDsHt
	 mMRkd2n7aarqrMJKUqTFb6PltAXVHgReSlUSbhs8vaCt1yANVhntCXX6Eg8TeNKSiNBzs
	 N0y2n+qnHjW2iPqYGa7mG7nj9YmIGhHy8K3WO9NMXLRK0JBIMrrvZwh+4TqmGFxIGMs4A
	 q/JZ/I5d1f06ShHMBUMxd+kXnO+saFMP4iUSDo7FA/OjvL02Mom/PI31zsV4uc2lMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VnXOTSiGAJxnP8VvLA894mSjg74c8JXE9X+wZcdzN/U=;
	b=mCeoCNEUCpfekU+vfg3ma17L0aRKetjHJrskcT8tYwp+BzViRMz9CuA+SBWbZ/VN++Z2
	 6d+tDdK2DmFsV0w2nTcwPapDWmLIJveDYnKFR7JUObu3DFZMUbZeESZkCUYxrWF4uYgSv
	 k++FVp/WConNlwRMNVncA+ORTGRdY5k9KCiBboqJpatOfB2rWuJIhibFfimLo1TsRidRJ
	 8Vn2zKmSARpUas77K5XCV1HemFUfsvFSZiNs/AEGv94GeWwNwx0/k7wxN4HXq+bvfGI8z
	 sfziyv76n12XHJvAQigpvCy6dAXeuh4ZfXoCn8On+4DlHWk0l7/ZpLY9KTmJh4DGEsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7UihNyx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD190606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7UihNyx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8041F0089F;
	Sat,  7 Nov 2026 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049449;
	bh=VnXOTSiGAJxnP8VvLA894mSjg74c8JXE9X+wZcdzN/U=;
	h=From:To:Cc:Subject:Date;
	b=J7UihNyxZTF5wXJSDj72AnzKU+ZZgu71c6JvHBFxY0S0BCkigiF0n/cgBzGpaKylX
	 Z8BWuVKqYVwep27ctJk1q9sd0vbZjtPDipNmr+xj9izwPp2OL8oZ3jI3eXkdv1AbE3
	 duEDBFPunQfineFjL1oKZNxVpZKfiaUOwn/K6tkBlhdoWzCxg0ySdxRSD8WUsSqd6H
	 mXjO9FxVdu9uT7fVX3z7iTnNBcgg9J6Jwn2/Yj1PT0l7pwdWJWdxQ/Eslbp2AKYnze
	 zHNMBXbgVhhHxi3BAWmGLkwGFkzCQz6PSIZDlUmk47yVmjYZj/kJa5G3J4HALz2lkG
	 uNe4as94hbEVQ==
From: Sasha Levin <sashal@kernel.org>
To: eeodqql09@gmail.com,
	nathan.c.rebello.27@dartmouth.edu,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: ccg: Validate altmode index in GET_CURRENT_CAM response" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:07 -0500
Message-ID: <20261107060407-failed-5.15-02ee864e8d21@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 02ee864e8d2142c5648998944c3306ea6a763c26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060407-failed-5.15-02ee864e8d21@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




