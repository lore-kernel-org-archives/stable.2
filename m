Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616989;
	b=jMyJJzk4jy10l6T92EtHXpKXz7DGEOqYQ2SZCAN9RjhxK/Q+MkfgKXJ/IHF73PnZ56pX
	 uPlPCMgUMZiHzvu5p0Zk0KVsXQpIsaneaDFMnMkJqBwRpMGwUThsVbSSTxBRVqciS0iZ8
	 H8z3iAqVQxd5vdXPzhhqhxY/sgYN3mGNh0NNOUuSbz50BFKhpsmqAkC2BozejACLR2p03
	 LFxW6n/MIGGqVNrHfDD0+E19qWmGfvxiS/1K/r0g1g8iF0NWVbrontAvmERA03l3N1Ddy
	 iOrCMLCd7wgDPE4DH7HRn6Ooqo26uqmXlv5v9o0gAqdnnBi6npXE05pqnlcO84b+DfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pCXDHqMSN7ai+xZCH5L1KMIX1JuNHfd9EhXks9RhxRg=;
	b=uiOyDaetQYuBj9kMx/ef3NyJCqBVq5SlELVBYBqRh5ITLC+JDNhP/2aALUF++0EabeHG
	 1TIah9PdR/c1XLm8gansbmu4rIi9OaCAu2QQFk5vpacVdhurP7gxBaa3Klprp1QoHVCkc
	 mIoXwCsA0YMwi8LuAyJdI5FznmLbyQcomHDjkjTyC00rXiFQBjFJj5+/ygAYFtbG6rbHO
	 XyqrkfZzCLGrADE/BfyCR6ESfbEYpSOB/aW3tbMm6+JDk11pRdt48la708uIxSC4FUG8R
	 qQGbZOVveJkGPROmnirngkAgYCHi3CvVjDidV+WdkzJlXAAUj2kHEJY/EAXmSlPQZzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwHCsZ1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwHCsZ1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ED41F000C0;
	Wed, 25 Nov 2026 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616988;
	bh=pCXDHqMSN7ai+xZCH5L1KMIX1JuNHfd9EhXks9RhxRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZwHCsZ1TgBEyhCa6qDwcCKg2fdH3jTQ4ZlML9CUej3kDCkEy70Wko9op/M2sJNYAr
	 TpHKEs9o7OYLsiM08M3Y/2W/I+18EJxUs8csHESqHJkra1w9E+bLjlYvr3iQPId97K
	 juofEKnCWZuAbr8kNayguvISX7xQj1rj9AzWbj3DmhN7jAqMc4ZS+g3Dh760ZZo/or
	 b9rc+lwokJSabheGsEgygz5v+rY+NJrq1MpJsgqW3QmUDbOA+hYmcc36k95uVDWezr
	 s2nEcADknhLeRqdnv7eaR9H0/8npnW0OUjFRO0epqkrZgDaD9lCCRpL6SVezZeKxnY
	 syOiGt8FnTn+Q==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.15.y] hwmon: (scmi) Check channel config allocation
Date: Wed, 25 Nov 2026 14:29:43 +0000
Message-ID: <20261125142943.3949509-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026112550-overfeed-putt-7fcf@gregkh>
References: <2026112550-overfeed-putt-7fcf@gregkh>
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
(cherry picked from commit a2996d892d0150d059d39c683d95d6fd7a37630a)
---
 drivers/hwmon/scmi-hwmon.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index b1329a58ce40..c263434d9e0b 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -159,8 +159,8 @@ static u32 hwmon_attributes[hwmon_max] = {
 
 static int scmi_hwmon_probe(struct scmi_device *sdev)
 {
-	int i, idx;
 	u16 nr_sensors;
+	int i, idx, ret;
 	enum hwmon_sensor_types type;
 	struct scmi_sensors *scmi_sensors;
 	const struct scmi_sensor_info *sensor;
@@ -230,8 +230,12 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
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
-- 
2.43.0

