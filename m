Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272839;
	b=zRi6ZMT4NNEgbhNUORm8efKq0I9MSyBVc6qZ+w7yeMtzY4/ljn5rTk9p2F/FnP4FFCti
	 wfmJ0J+Xp9T6PTB/T0W5Z19ffu24YRA5N6lKuIL0CHJ5r8QmGUofnnfVHzYNfI/Xg9HbO
	 FjxE2uTOcORrKz2ieFZG+FGYSYA4ICcSaak2Wl2T3K2viOXTPmC2PT4BPTTR0917U9UOP
	 pIZeSnyIjZs85xuJr98WSccWjjj/VD6yz9F2q4A8HSh134uTXV/H7qaXN40SQwOkJSqHE
	 lG1KY5fj2hy7HIXSHhL1gTX8uRdcxN6kz9CA4y48JgWWQ3g77PmsketpPekrcuLFPFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QZEUFj7yXHLpuSiVWxXCjY55CCWxq3xqwAsRxTWSPN4=;
	b=aVvE/AEpgUaPaj9DgXdZAOlIjeEJtLuxxpelHDw+aui8jJcpfRuJsmhSHxNZ34PlyR56
	 ouDHcWWlogJ9lAPDRM15HF5HMYaNc/tCbEmW31ZB0EHEH3wZpb6B8mdoZKe21CRc3Sd0m
	 QahzNAZ04vlQWP9r11hgjNvs+LdrBYHyodZiYHfjiRY73Oyu6RgZO86S+qrP8x2fTT6kw
	 liipcovyx125TmshAvQpJVbRqOtoaDjZJi+LixMjqOreDD3LMFZ+2miocQixOV/OhdOIw
	 RxZjEGYeWs9XprWVmQuQkxUDqmFwf6F8skW3GBUbEWkTcD5XtEvc+vsUuJqL1tIdfDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n6T6vI/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB8606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6T6vI/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342BD1F008A1;
	Tue, 10 Nov 2026 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272838;
	bh=QZEUFj7yXHLpuSiVWxXCjY55CCWxq3xqwAsRxTWSPN4=;
	h=From:To:Cc:Subject:Date;
	b=n6T6vI/GNRYzaM3JjpIxO8wQJc2cOfgMG/4p2oL1QDdag7xupwghZPOn7kMkT9omx
	 vdZb4SozvjNawpd6icuoLaY7xgtvRsQ0u7u4NLn0zykg7v1VQsSr2kjuVZMRUVOgLy
	 4hiRD2pjiEmCjk9SGFfpjPaYWFp3yYVgNQ/fPvlRcz949DccE3kZWHDJoRh3nKxUL0
	 xAOvkcRED8B1zk8GN4HRWI9cQMdnUAlj5/AOpNYB3Nk+U1zE1m/IWwniEbgdbT5OIs
	 ASe9JEpbTPczI7BQjWpkdD/XmlgvzC4g0eu9o4wH5O+nFv2Yo/IgWKdcUVJqz3yyMJ
	 dC3aR3IkoBIZw==
From: Sasha Levin <sashal@kernel.org>
To: javier.carrasco.cruz@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: chipcap2: disable device after hwmon teardown" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:17 -0500
Message-ID: <20261109200717-failed-6.12-4724ac5556ce@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4724ac5556ce63f01a3f5d61fc7fcc20f4ddef3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200717-failed-6.12-4724ac5556ce@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




