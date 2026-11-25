Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617037;
	b=kggO4zuLOp/Reyua158k5dUETuVbzC3YofQk1ggLuck8n1X9BR4ryrm101mX/fWmj1r+
	 fFeKEduXV24E1MYP3UlQMlKpLfLXmhguH+7x9MiBWYddoVhO9zqFtC0hIIvkbB3Klz0u6
	 h16H23QxYrsiP8k7X/XDvF3Fj8mfgO9gL7b9xuiA9p+JD3k9D5gRjHEZGSGAdf+kkTtr/
	 6HpODZic5iAew/8XRMQoS3JnpDktO7eF1AtNFtd5Ap2vMl2mDlIklSdgEmoJ0YTyx4IiN
	 pn/vIJsb3LASc8WH9vo708VloC72aaXuK6buzHQI8cYvzRnjqUxaTycNGAxBbgKhTLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x01a/SxRc7XEGNuvxdWyHLDVEpUXlvRacN9TyC75zAQ=;
	b=uMUsIrY+AUN91XoTqEx0ka6in5Y/Eqc2GbtPLNUPoF0ogZqNHv/CutFkLmrLPMS3AJBR
	 iT7t1ODAt38r78SjhvqzeJVc5F6UpvBHbhK6IaWZT5xGtuoF3sjeePAXPOkiQOqpgzBEr
	 9khrH5VpeYI/8orJwp4UkfWqxe2Y/OLqkDL/v0NjTNy46mwv8/OInO/fW0Q8gQ24YNHYG
	 5rf+8+KdPy6etUaYCgplyFgWwCE6cI3QrUNd8hvSLdNzNZY1WXQXiQnmUCHgUwS1pBfpV
	 9R4b6GlkeKIrS9c718dJlROo99UCfHXFQ7hMTudtMYGwEE4hUHVGq6Uy6ehfSS4v/mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnsY+Xo8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42719606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnsY+Xo8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6B21F000C4;
	Wed, 25 Nov 2026 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617037;
	bh=x01a/SxRc7XEGNuvxdWyHLDVEpUXlvRacN9TyC75zAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnsY+Xo8thRaHIzG3UqZUOSpjsKbe028dGGIPpJOEobqURhKTferKE0KthTAXO7Vo
	 ljPKrVBJsHTChGhj3Lmt8DIwCMaAXRrgQpENJoLDEheAaStJRqcEL4Khz7SkluoD+i
	 Hlt1hPBHsJH5gw/ZLiCAzsiMjhBBh2/Y8vhL/4N27//X+Z50nug2yXQq2zlANjczjS
	 OYaiokJZEaFfnxzWUBwz6AHt0oMz8f3wJyAG78sNpPJDh0i/eolIHwU+aBRigb54fg
	 hHk3rzx7VAu7ZTec6g7qQ5kpzzGlbHRmjenxLo8hKVtpmzNqp6pn057zaidXTNX7mJ
	 CdFgHJr/Mbq/A==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.10.y] hwmon: (scmi) Check channel config allocation
Date: Wed, 25 Nov 2026 14:30:32 +0000
Message-ID: <20261125143033.3949666-1-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026112550-barge-grandkid-a809@gregkh>
References: <2026112550-barge-grandkid-a809@gregkh>
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
index 09ce30cba54b..743c298c4cf5 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -158,8 +158,8 @@ static u32 hwmon_attributes[hwmon_max] = {
 
 static int scmi_hwmon_probe(struct scmi_device *sdev)
 {
-	int i, idx;
 	u16 nr_sensors;
+	int i, idx, ret;
 	enum hwmon_sensor_types type;
 	struct scmi_sensors *scmi_sensors;
 	const struct scmi_sensor_info *sensor;
@@ -224,8 +224,12 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
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

