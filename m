Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36D415F3A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749048; cv=none; b=QrAh+o7lEbldPYkaqN1RRTTAbg+DY1KVx8crXPFCE4jOZ7XmXOFUoUVeZFXbJOJYlrjGuAmrcqjF8OINmVUIr00PlWjWkbBqmQNvjmlatcR255n5buc+hZpO+kbUFvb3h4neqkDYa35gR3lVeV2JZ56N33kR3BJLq22sQDF43hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749048; c=relaxed/simple;
	bh=7wj/lje8xmafBA3r50rRhACvdNsTqd96KQbDa+UCSXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYFqNN/GwCQphvayng4vh7NZ67EpKd4m7F9tmIMRyzwXvIogL3M6Z/bg00X1ftPjUzJ1EtcUWIPco9DfGyZQPc56ABC/uTHzvh0BmyL+e/pgOYSoGpWml9D897r9O43jtQlir/CtbQKly99xOFi7ktOEzdMwaeiw00X3gs+nUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dte/uUb9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dte/uUb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE21F00A3D;
	Wed, 26 Aug 2026 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749043;
	bh=/8DNk3DdSg/ucHpdVF65pfvPb6IWZ7tJGLpy07JK0FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dte/uUb9HtC5Tlp4DMDQy7w1rpOBUMmc/KAiBryy8DG2rAi/94CwOx4g0ka5PA1qk
	 Q5B+JVzjQukLQJibVUJX0z6/FkblWK3HYlPZN39XiuN1YmcCMqaY/pbIt8NrmyPJN9
	 f9exSLcUUPNnyTt1IS4bxh3uJj8G1HPM51NQ0LPNYyQ5zMeOXYvwLstTWdN2zjXyef
	 efw1dSru1dBOi4Ht+r08zvDMyp5nEgNLiw08H41B2JibCgKflcAQJWmywG73/qf9CX
	 WtuywG4uWT9LH9jv4E5i167ZmeYN4i5XWzJagmc4fpWhZjoJKzNVz1VeiLnFyjB4l0
	 WADe3fbLiDXcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Kodama <ckhordiasma@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] HID: magicmouse: re-enable multitouch after reset-resume
Date: Wed, 26 Aug 2026 08:57:21 -0400
Message-ID: <20260826125721.2952904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082547-glove-frying-a57a@gregkh>
References: <2026082547-glove-frying-a57a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher Kodama <ckhordiasma@gmail.com>

[ Upstream commit 4253fe22b137c4ee68f36b707fdb1b44b191edc4 ]

When the Apple Magic Trackpad 2 (USB) is reset across a power transition
(e.g. resume from hibernation) it drops out of multitouch mode: it keeps
sending report ID 0x02 on its HID_TYPE_USBMOUSE interface, but the packet
shrinks from 21 to 8 bytes and the trackpad2 handler drops it (size < 12).
Clicks still work but pointer motion is lost until the device is re-plugged
or the driver reloaded.

Re-enable multitouch from .reset_resume via the workqueue.  Only
.reset_resume is needed; suspend-to-idle keeps the device powered and
retains multitouch.

Fixes: 87a2f10395c8 ("HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: Christopher Kodama <ckhordiasma@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ kept 6.6's non-const `magicmouse_report_fixup()` signature in context instead of upstream's `static const __u8 *` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d5df2745f3da4..f4748db48967d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -950,6 +950,22 @@ static void magicmouse_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+#ifdef CONFIG_PM
+static int magicmouse_reset_resume(struct hid_device *hdev)
+{
+	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	/* The device drops out of multitouch mode on resume; re-send the
+	 * enable report.  Only the HID_TYPE_USBMOUSE interface accepts it, and
+	 * it must be deferred. Sending it inline here is too early.
+	 */
+	if (msc && hdev->type == HID_TYPE_USBMOUSE)
+		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
+
+	return 0;
+}
+#endif
+
 static __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				     unsigned int *rsize)
 {
@@ -1009,6 +1025,9 @@ static struct hid_driver magicmouse_driver = {
 	.event = magicmouse_event,
 	.input_mapping = magicmouse_input_mapping,
 	.input_configured = magicmouse_input_configured,
+#ifdef CONFIG_PM
+	.reset_resume = magicmouse_reset_resume,
+#endif
 };
 module_hid_driver(magicmouse_driver);
 
-- 
2.53.0

