Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628671;
	b=gcAdLw2dBblmcGw+/191v87aXPhp2c6bHDDzUAB25+xLK5KS/6vQXi6QMMWkR5HVeNXk
	 Ue9NE+fZKSlbAlGzGLEeUQIU1d29Zmht9VXUu2e5ALYQfiEz8TevBw/FjKroxZvCZosYy
	 FTL+50Ov0htDtUSoEgmw3a3ehvXTtF4u46sLqlg+0MDM7wT/5OgNyn/vmqsjHD5Vbzz63
	 t3KPjF6hUZyqU/XqvBfEoF0nz5bWBJlaLEst2DaAmobsWuPlsrZ90hCcSdaytdaagykgk
	 s8NojeFL/vIB35tm80HSmlfEmHT0MZ5/JgOW3h1SVStyMQmRSPBEta2Rjls2ZfdXO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628671;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=gh7h2l1FMUYt0dTjyEv+X38K7pAh7Yd9rCAf1cFRibw=;
	b=TsnDnSK22GXXJjwx937YLvOJYrzmVH68SpQP+W/E762st61nHAyn0fZFOqE4y3SZhgOm
	 mQJTVrnQiPKus7qPnHOiNyfgqKMCzu3+4pcmoPExWe3JwtaN0XYamIChV4h31LRwv5cut
	 u4bdDUrjq/Dsi20/Elk/lOV5PxKiHbGUkpY+oJeQCWobUzM+iYaZOn1gBgvduY0hWVxIG
	 cb07XqpZyNT22VxZK/JmVvHyqBLeMcoXIQyXa4pbSvgqwK8vrWGVx0waYaSy6JeDOFGM+
	 uJrmJsjWaJgLYYiBAoZY2OBRFiGrKdXulIZ5djHrQckR4jkEZ1SwdEXufEGGkqU6LHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b="ChyJ/4IM";
	arc=none smtp.remote-ip=184.106.54.84
Received: from smtp84.ord1d.emailsrvr.com (smtp84.ord1d.emailsrvr.com [184.106.54.84])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5223606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5223606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=ChyJ/4IM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1795628663;
	bh=Yb4u4jyIF2nN0Cnmq3KYw7xLzfMLkFn2hP3xn40DEFY=;
	h=From:To:Subject:Date:From;
	b=ChyJ/4IMCoGVYrtKfA16AHAhwU58iHX1wD6dxHo7+aAUgK3CKJhGBwa/aWeQ6Hcbk
	 jJc3swAlumfUSDyFf+V17aiWzCtW3h4QeFiMaU9HlemcymLKuBxqPgOSM0vUDR7hk4
	 DZGc6DMfz9btOFKC70c4o2hg0hSxqVWLIKazvQ/U=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp19.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E5CB960281;
	Wed, 25 Nov 2026 12:44:22 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7.3.y] comedi: comedi_bond: Fix leak of opened device references
Date: Wed, 25 Nov 2026 17:44:12 +0000
Message-ID: <20261125174412.735738-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112537-imaginary-sloppy-a6fa@gregkh>
References: <2026112537-imaginary-sloppy-a6fa@gregkh>
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
X-Classification-ID: 1dc0d1a2-4a0b-4709-9e74-7bd8bb375bf5-1-1

commit fa0858523f07f8dd71d89b221f4422c3b8096d90 upstream.

bonding_attach() calls do_dev_config() to open other comedi devices
specified by the user and tries to make use of them as part of the
'bonding' device.  If it successfully opens the other device but cannot
use it (either because it does not any subdevices of a type the
'bonding' device can use, or because of some error that occurs while
dealing with its subdevices) then it is left in the open state and the
fact that it is open does not get recorded by the 'bonding' device, so
the reference to the opened device gets lost.  Fix it by closing the
opened device if it could not be bound to the 'bonding' device.

To match previous behavior, if the opened device is unsuitable then
ignore it (after closing it).  The opened devices recorded by the
'bonding' device will eventually get closed by bonding_detach() even if
bonding_attach() returns an error.

Fixes: 3cf840f65ad5 ("Staging: comedi: add comedi_bond driver")
Cc: stable <stable@kernel.org>
Reported-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20261103063301.1025860-1-vulab@iscas.ac.cn
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20261103173610.89687-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit fa0858523f07f8dd71d89b221f4422c3b8096d90)
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/comedi_bond.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
index 8e10ecab4f0d..aeb34eaa6a0e 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -182,7 +182,9 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 		char file[sizeof("/dev/comediXXXXXX")];
 		int minor = it->options[i];
 		struct comedi_device *d;
-		int sdev = -1, nchans;
+		int sdev = -1;
+		int nchans;
+		int nope = 1;
 		struct bonded_device *bdev;
 		struct bonded_device **devs;
 
@@ -221,11 +223,14 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 				dev_err(dev->class_dev,
 					"comedi_get_n_channels() returned %d on minor %u subdev %d!\n",
 					nchans, minor, sdev);
-				return -EINVAL;
+				nope = -EINVAL;
+				break;
 			}
 			bdev = kmalloc_obj(*bdev);
-			if (!bdev)
-				return -ENOMEM;
+			if (!bdev) {
+				nope = -ENOMEM;
+				break;
+			}
 
 			bdev->dev = d;
 			bdev->minor = minor;
@@ -246,10 +251,12 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 				dev_err(dev->class_dev,
 					"Could not allocate memory. Out of memory?\n");
 				kfree(bdev);
-				return -ENOMEM;
+				nope = -ENOMEM;
+				break;
 			}
 			devpriv->devs = devs;
 			devpriv->devs[devpriv->ndevs++] = bdev;
+			nope = 0;	/* keeps the device open */
 			{
 				/* Append dev:subdev to devpriv->name */
 				char buf[20];
@@ -260,6 +267,13 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 					sizeof(devpriv->name));
 			}
 		}
+
+		if (nope) {
+			/* Opened device cannot be used, so close it. */
+			comedi_close_from(d, dev->minor);
+			if (nope < 0)
+				return nope;
+		}
 	}
 
 	if (!devpriv->nchans) {
-- 
2.53.0

