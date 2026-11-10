Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272609;
	b=5L2N0NHy0hw3UE4f/Uapxdpq0koNQaB/NPUdIy5hiHtYVjGHfNkBrtD+PC99Kly5Gypg
	 sB9vYR1EeqSoW2yiCCwO9Fy6UZjzZYwMVRhOeC7720mpW2IOsqE655l3vKOuQ1u848jA+
	 VFF/u7mJfbcLtWQmU4W/9ya9O5+uuXaRTAgkNrHZY9t60/1+iHMc56lX2LimaVYeXhO90
	 OBDX1hvRTlBuAGhQDOFvgziabK/5fVz9p9tf+132U0y2yEutDdNwAWpleTXDfpysTSS5i
	 Mr8kjlU2aY5sHOFj6RtQHXl2Ga+pMzl93TpWwsP0McTzTI244GkXC4pS9gvjF3gf6zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2DNccL/MwKIpbTNTxNhPKeciPkldAVkWVKOjRyYZmPo=;
	b=tOG3avgZI/xY6ec4r24h9N9WuTyXKKS4wAJaHIXMv9+lz4+BO3mDZrW1b9AyrCehBQuB
	 BxiVlDunBqdtJvp/kKbp2EQmY7a+ucF5T4eRKxHRAhI/UXBJgi9oaRlYU+akwYYZjRqlh
	 IkU55bUCAnfYXD7uz/Ip8MCIcafEnOzBHPymvHecY1z+Fim0Z6+3sq+3fOYtZwDQbb5OQ
	 VNMasUZNsrtAkIE82v2mWr0TKd6WvW27zkeMQVXLmAXEWGp/bfKxtJwjOPnEHlT881GJO
	 nv6Qs4/LxULAcqxdQoBY7F2apkYeeVUi7ISN1uKDTz5csOMwtJrgXXADoODpW6dhlnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGci5LDK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGci5LDK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB211F0089F;
	Tue, 10 Nov 2026 01:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272609;
	bh=2DNccL/MwKIpbTNTxNhPKeciPkldAVkWVKOjRyYZmPo=;
	h=From:To:Cc:Subject:Date;
	b=mGci5LDKihy0yYFw5jOWXz/8tu3wpkFuoSTuiNqerIEo1ZR5lQaXDKj8x8O2eEd8l
	 W35OaGTEO8FY2/3uWDEPh9wJpm3j3wV/WUKcQfl8HseXLLKHFXwwmcW1BydPWQbf7d
	 PRWsrt8MFkNhFusmGhxcQGBEf8+aaKm4ygoXCaxNVKXUMuiiZuHGtxNRL0JhSuCI//
	 dldUKkAjPm/jHooSt8nELpAPoE4lTU1ibw26kS3Lv6bhZXEi/N7dZk8fha5jrCdrbk
	 ZHrVVu5/6qx770da2j5HHDtEe/htOu9MUwUWYIJk+MteiarcsPg1R9vKcHo39mzUNj
	 Y6NCWmhVvPMqw==
From: Sasha Levin <sashal@kernel.org>
To: javier.carrasco.cruz@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: chipcap2: disable device after hwmon teardown" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:27 -0500
Message-ID: <20261109200327-failed-6.18-4724ac5556ce@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4724ac5556ce63f01a3f5d61fc7fcc20f4ddef3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200327-failed-6.18-4724ac5556ce@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4724ac5556ce63f01a3f5d61fc7fcc20f4ddef3f Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:05 +0200
Subject: [PATCH] hwmon: chipcap2: disable device after hwmon teardown

cc2_remove() disables the device while the device-managed hwmon device is
still registered. A concurrent sysfs callback can then enable the device
after it has been disabled during removal.

Register a device-managed disable action before registering the hwmon
device, so devres unregisters the hwmon device before disabling the
physical device.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-6-27ebfc2c5b9e@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/chipcap2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 21dc6db27c401..654f6420da7ab 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -152,6 +152,11 @@ static void cc2_disable(struct cc2_data *data)
 	}
 }
 
+static void cc2_disable_action(void *data)
+{
+	cc2_disable(data);
+}
+
 static int cc2_cmd_response_diagnostic(struct device *dev, u8 status)
 {
 	int resp;
@@ -744,6 +749,10 @@ static int cc2_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get IRQs\n");
 
+	ret = devm_add_action_or_reset(dev, cc2_disable_action, data);
+	if (ret)
+		return ret;
+
 	ret = cc2_request_data_ready(data, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
@@ -762,13 +771,6 @@ static int cc2_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void cc2_remove(struct i2c_client *client)
-{
-	struct cc2_data *data = i2c_get_clientdata(client);
-
-	cc2_disable(data);
-}
-
 static const struct i2c_device_id cc2_id[] = {
 	{ .name = "cc2d23" },
 	{ .name = "cc2d23s" },
@@ -801,7 +803,6 @@ static struct i2c_driver cc2_driver = {
 		.of_match_table = cc2_of_match,
 	},
 	.probe		= cc2_probe,
-	.remove		= cc2_remove,
 	.id_table = cc2_id,
 };
 module_i2c_driver(cc2_driver);
-- 
2.53.0




