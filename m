Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047883;
	b=frJkPpfrTnIXpi071akL7FJdX+VEqFyR8KZjbSGU3Xg4Y7iPiuwuHNoTRa3O7JiX91x1
	 dcHHEzCGI4cukTxOaoOyeRupWN15mNiDKhLnsspeZMLs0MZDHqaPx7Jz8I8/ozvfhmdnW
	 2QwER5yOn3yV847iv0HxG9VlhVFSi+d1t+04s2pa7sNu5lwAVGnmpFjLIi0hv49ov1NjM
	 VfU6GIrqOFcTDh4bQ6eY8fJP6CbiRlLUAX4UauSy7yxjyaTV8v+9ckeOezhkQ8ixKiePM
	 71aHw0yQ/072bsx1N3FN2SWx9vVE8Wq14QKzknDTItLTSn7fh+Y05DfsxkGHYVQlanA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pLqQtgdGOncDtIHmgG3aBk/Ry0Fi785CqghmarbY6gM=;
	b=Dof4WGJleIOpVujg1jvoPTVw1b53CtE9GdlsCz+ZjYDhwlPq+YW/JAgkttOUiRswKRTk
	 TNJVQXE6zHN2VHHUhdPd+tTcUTSJRIRxM35yR7Z3XedjsIyaM2GzfSZxHlr02TXfVKbGx
	 QKAJFon1AJPkCPVUdYGI4+aCdnaG4AWxqF8W8o5LODEhOX79p9OhL/fR9LqD7eE6MRDqL
	 SIGwaQbA17GOeu0z/JBNTEQk0hRUQNT+1JmBBLfe/qr2z3FKsJ27snKsjEKeNL5qmP9yW
	 gl3k+rkY5nwPwxvlmm4J+nKIDaPZdkm5LEsdw8giZlCL1t7d4IdnAZ0otu5Jt+/OuEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0ZeNM0r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E431606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0ZeNM0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB921F0089F;
	Sat,  7 Nov 2026 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047883;
	bh=pLqQtgdGOncDtIHmgG3aBk/Ry0Fi785CqghmarbY6gM=;
	h=From:To:Cc:Subject:Date;
	b=Q0ZeNM0rffL3l4LNpNFgodfzrr9CZw8cxrq+PNzEYFHOGcQaCJjbpZhmvP/qAjn9L
	 TDBQfZU0QSbLU9zCuCVYZEL/pAecwGcogMqcmhVjG8OErQPiWT8ptgxgfFjN6s6lOt
	 4EHzsuSEn9zMxSoVcVfv0LmmbpPPN8tNjI7YIt8hudvjVB0+KoydS8RMAH2RZc4jXo
	 DCAhRG9icq7w3x7He0dMl5A7kR//nB6YfGt9p+F4RTKOOuUUbERdfXaTNnSbWDOGqw
	 hx7WIjHx2EwceWIY+PL3epEnZwLdMjwqN1Xi7Pi/61c+YZ7JLD0Vo1Dd2kh3mIk317
	 vJgxzTtM/Zmdg==
From: Sasha Levin <sashal@kernel.org>
To: bartualev@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:01 -0500
Message-ID: <20261107053801-failed-6.6-3d9a175707ee@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3d9a175707eeb15a2d577af1e669b98e0236719b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053801-failed-6.6-3d9a175707ee@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3d9a175707eeb15a2d577af1e669b98e0236719b Mon Sep 17 00:00:00 2001
From: Bartu Alev <bartualev@gmail.com>
Date: Sat, 10 Oct 2026 13:15:58 +0300
Subject: [PATCH] platform/x86: asus-wmi: fix TUF keyboard power state shutdown
 naming
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fourth state flag of kbd_rgb_state_index is named "keyboard" and has
long been treated as having no effect.  In hardware the flag, BIT(7) of
the payload sent to the TUF RGB state device, gates whether the keyboard
backlight stays lit while the machine powers off: with the bit set the
keyboard lights up white during the ACPI S5 sequence, with the bit clear
the machine powers off dark.  Verified by A/B testing both values on a
TUF Gaming A15 (FA507NV).

Rename the fourth field and its index entry from "keyboard" to
"shutdown".  The write format is unchanged, the value is still
positional, and the diff is two variable names and one string, so it
backports cleanly.

Fixes: 61f64515299e ("platform/x86: asus-wmi: Implement TUF laptop keyboard power states")
Cc: stable@vger.kernel.org
Signed-off-by: Bartu Alev <bartualev@gmail.com>
Link: https://patch.msgid.link/20261010101601.888709-3-bartualev@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d1341adc1b3b3..3348ce162ad3f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1130,10 +1130,10 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	u32 flags, cmd, boot, awake, sleep, keyboard;
+	u32 flags, cmd, boot, awake, sleep, shutdown;
 	int err;
 
-	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &keyboard) != 5)
+	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &shutdown) != 5)
 		return -EINVAL;
 
 	if (cmd)
@@ -1146,7 +1146,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 		flags |= BIT(3);
 	if (sleep)
 		flags |= BIT(5);
-	if (keyboard)
+	if (shutdown)
 		flags |= BIT(7);
 
 	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
@@ -1160,7 +1160,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
 static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
-			     "cmd boot awake sleep keyboard");
+			     "cmd boot awake sleep shutdown");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-- 
2.53.0




