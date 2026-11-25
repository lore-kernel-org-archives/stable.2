Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602941;
	b=tdYBBa7wx+lWiZl0Tz2VtHQTlQ3BFj0ntEmwGBqKdGnsNBAAR2bwBTDoIAp3MNlbkxbV
	 HcbUDtwya/oLqS9p7+rgSzYityFsMIxTRhJlXwOzqF+d6RA8THiKRab8gZcvckCYX50EA
	 jgFbnhPYeMTmqMjZAQ3++iP/Hq8XQg4EmQACVSmRw0EUaaWzjfzc8a9o9kU0thEOceyIC
	 8q3pq5XBHRDpRZPaWVR9YkrxuxnbaGV85m9os7UZEEhXJ7Pv4St/SAjiUPW9/vE6zu0dU
	 1pvztBkGNrPvooryvzdLmPQysN5/YixtOty1nrgDODRXlQ3579Gnnr6szLgDYBdBGSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602941;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S2/KjbWZHJDXrqfosNT2gHNLdN0kwaeyMhrZVbRoZGQ=;
	b=aUnASQJe8po4XmQL/2YggreQh2o0G7o8+Yc4unaZH2w8DKBKEX60om/qUlh0G5pI3Jlz
	 uGDJXG6T/1tDVGVppHhaiNZUPWGEVRGpD1uZu6nYutR3S8lvxgSkM0C/vZ1ly5Uz+28ZK
	 ZiMhpJ0pcPDuXhG3Tw8hpeNCDzV6w6isY90Fo0cQA1N4OfD4XvMZhc6dYSngdt2FwEqVi
	 Bb6WAxiYSjal6vEKuWpnJ4e/2RJ61CNwhUSloRQO4ncrganeQsGTg9ChyEk5mTRm+WdAn
	 zulRYy/b0OqCsB/fo2BliEu5CZ8pZW9dZkLuEfTDpvFS4kut6ulhalCER9rkYIFKm5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=flXfgOcp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=flXfgOcp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59DA1F000C4;
	Wed, 25 Nov 2026 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602941;
	bh=S2/KjbWZHJDXrqfosNT2gHNLdN0kwaeyMhrZVbRoZGQ=;
	h=Subject:To:Cc:From:Date;
	b=flXfgOcpmkCo1KV68gl8ZMDmPDE36dDZU2BYd7NyURxhD9clEwExUaJlWR0yuzRq+
	 W+nTAazGnPNymZ6SyKt8hOPC9N85biRaVSHdjyrh9sh62QF4M+TPgKx3sAZAjHRUd6
	 hdumA8vPrfQ0r28flsHu33GtH/R0FQLv/QP5yhp0=
Subject: FAILED: patch "[PATCH] hwmon: (scmi) Check channel config allocation" failed to apply to 5.15-stable tree
To: sudeep.holla@kernel.org,linux@roeck-us.net,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:18:50 +0100
Message-ID: <2026112550-overfeed-putt-7fcf@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a2996d892d0150d059d39c683d95d6fd7a37630a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112550-overfeed-putt-7fcf@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

