Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602938;
	b=ZCtIRb0UYzZAu7xkULfPPyldV05/uDBwbI1anpOUmlViTB0rsztCz2Th/YwW1qkYsOFL
	 WbwrnOfpJOgUREAZ+miWkzPNUlMzqGvQwXdR2u2c4yYkGFFfy7GsxkfvvmGZ61dlpZXrP
	 ENE3zDHuEyRX0njbIhZDNmuQ25uOL9Zt5MTToJEqneQHLWDd7X/yK3NCI3MnKqbY2Fnxk
	 0ktlhgSw3PSfL2DuXMwnLHFrWO0PSBmylE3qgIzoOlp7Fhg7npNzCSaI/key28vFeRT9b
	 csp9MZvcwuEc5sqqozt0CrXOx2jtaCzwrP8Rxqb8e722lja7MxRvmU3iCTQ3HGJ3scQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602938;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=D/lWJCkK+5UQK3rxXwFgiEpXB/g4Gd1L/rOhb7uYAd4=;
	b=5XVmkd/y3um+wA01ZoqtQgjtSXzb5URDAYBm7o/l5gjTk7kDu/BjX9rDnpFiElxkbOF5
	 piqx5OohMIV++A1yeBshids2vQ2Q+MFf4kRMTS+2KZ6m4OMFfP9hsG7xNEXgQb/lNS7+n
	 JDyV0IgYKzG7wg+Bgj5Z6iXLhrb4YK0U9mUtkUGwy3AyvbQgG8g9dNosZm2rASuLwstze
	 GM6FXpGnQH7spHmRjH9BIcUWC0gBRmp+uDR+rGhKY4f/ayEx3KOiKBG3kBKiefAyIMbSt
	 NU/SQjNHaVKrWw8EAP5BJY6QXo+whS2193eAOwXUuVF/v4u2zKLvYFsCRZ4W98SSBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kPXWW+8w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kPXWW+8w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC021F000D0;
	Wed, 25 Nov 2026 10:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602938;
	bh=D/lWJCkK+5UQK3rxXwFgiEpXB/g4Gd1L/rOhb7uYAd4=;
	h=Subject:To:Cc:From:Date;
	b=kPXWW+8wAN2KqLT1y65ttJ4Dnjri/Ea9JQDqNENNTrAgUfXISO/sVrjhUpdP14JX2
	 bz6fHNfUi8/N5Oj1fa4v4HRncNa7GR3PVhwasqdNkyk5LipoxygrP+oZiFSIYWaRkv
	 2HoVE9DDAmeKgmxAs+K2JT9P+G5aufdEPryzoYoM=
Subject: FAILED: patch "[PATCH] hwmon: (scmi) Check channel config allocation" failed to apply to 5.10-stable tree
To: sudeep.holla@kernel.org,linux@roeck-us.net,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:18:50 +0100
Message-ID: <2026112550-barge-grandkid-a809@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a2996d892d0150d059d39c683d95d6fd7a37630a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112550-barge-grandkid-a809@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2996d892d0150d059d39c683d95d6fd7a37630a Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Mon, 9 Nov 2026 15:19:26 +0000
Subject: [PATCH] hwmon: (scmi) Check channel config allocation

scmi_hwmon_add_chan_info() can fail to allocate a channel's config
array. Ignoring that error leaves a channel with a NULL config pointer
in the hwmon chip info, which hwmon dereferences while registering the
device.

Check the helper's return value and abort probe on failure.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d10ced6b-a6f0-403b-9619-f5a6573f9e7f
Fixes: b23688aefb8b ("hwmon: add support for sensors exported via ARM SCMI")
Cc: stable@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Link: https://patch.msgid.link/20261109151927.1672956-1-sudeep.holla@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 7789285b6c67..0c82d8dbd626 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -228,8 +228,8 @@ static int scmi_thermal_sensor_register(struct device *dev,
 
 static int scmi_hwmon_probe(struct scmi_device *sdev)
 {
-	int i, idx;
 	u16 nr_sensors;
+	int i, idx, ret;
 	enum hwmon_sensor_types type;
 	struct scmi_sensors *scmi_sensors;
 	const struct scmi_sensor_info *sensor;
@@ -297,8 +297,12 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 		if (!nr_count[type])
 			continue;
 
-		scmi_hwmon_add_chan_info(scmi_hwmon_chan, dev, nr_count[type],
-					 type, hwmon_attributes[type]);
+		ret = scmi_hwmon_add_chan_info(scmi_hwmon_chan, dev,
+					       nr_count[type], type,
+					       hwmon_attributes[type]);
+		if (ret)
+			return ret;
+
 		*ptr_scmi_ci++ = scmi_hwmon_chan++;
 
 		scmi_sensors->info[type] =
@@ -333,8 +337,6 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 		return PTR_ERR(hwdev);
 
 	for (i = 0; i < nr_count_temp; i++) {
-		int ret;
-
 		sensor = *(scmi_sensors->info[hwmon_temp] + i);
 		if (!sensor)
 			continue;

