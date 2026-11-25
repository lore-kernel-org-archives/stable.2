Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628842;
	b=VtczZ61koG0Yqf1RkKrNkxHIdEUnzldae1LEBFmmG0z7Yv7fe+g/c25oPI65lwerCoUi
	 lzBIwfGNuBAb6t/LlRvyPPJUkuld1UsmwBNXRZZyV6+q3j+2lEpnA5OPio9+zDrB8hChl
	 icP5TEo1NmCk7ZnHpFiHbuijNRiN1u6QhXpX5fAaBlAX+9LKleZT7LykkPScmbNQPpkqh
	 v95Zbqvxf55M760SkPnzUNEfIT4avK6lns+4XUVxjRznaqqtIu5TGO+zLb3BW3YrEaFUf
	 NoIKDAYEe10/n9WEz1fbdgRZAzUTQatc73s0+oFZ6FUdWNPBI2CfETw6fBLPfuLCQXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628842;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=gsdil1Y1eWYO2VuNBJgyxnTbW9x5mKIdpLHF51e5qEM=;
	b=BHx+ImevksXvJvQESxo1q9r3ENjrU9rrjXNJAJyyPQBCe5OtPsL2A1JSCDry4T1CMaU5
	 P7c0fExkKxahlqbAaU6Vp2gSv8jG0v45uMMWrssEtiGTjQofC+w3uz5vX4hoVuag9/Nhd
	 9t8vwUW+bMmFbQ+ctHYO/5WZds0PgxUWKCpOL7LnVhKZukh1ybRPgDr3GISQKNAwc5MAg
	 Ps+NDxaGdmt4z2hmdoYAq0fToZodrnDsb0y7TeC3sftgT0rE4NZkzT5Dv92UM32Frl9Uu
	 ZkIPi79WH9Ff0YuWQqnd9IEUxRkxkaaxFAPuxVw0pVklFJkRywYS59fiGFuW1s66o0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=hr9syddL;
	arc=none smtp.remote-ip=184.106.54.64
Received: from smtp64.ord1d.emailsrvr.com (smtp64.ord1d.emailsrvr.com [184.106.54.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B78F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=hr9syddL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1795628835;
	bh=bnkbiLA3BLa7/rRLEg015OvSWbBHuT4brSwYlKTAV7M=;
	h=From:To:Subject:Date:From;
	b=hr9syddLxoteUw3cIgsmNB2favkSpueRHM2pZQ24TfYNYP6p0PH6AaHbAbD3DNEX/
	 VRQEMb+sl7F8kWFDavpCWlK4g0vaNpjf5S8GUQMnFnTSH7Mmazzln11981OfHd7wdX
	 w85NcDzMmx2fhapQL737j3jinSuCg5adVbMfiBMc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9F637202B5;
	Wed, 25 Nov 2026 12:47:14 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] comedi: comedi_bond: Fix leak of opened device references
Date: Wed, 25 Nov 2026 17:47:00 +0000
Message-ID: <20261125174700.735835-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-devotee-transform-b74e@gregkh>
References: <2026112539-devotee-transform-b74e@gregkh>
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
X-Classification-ID: 3baced67-01e3-4155-8916-744b4aadb0ec-1-1

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
 drivers/staging/comedi/drivers/comedi_bond.c | 24 ++++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/comedi/drivers/comedi_bond.c b/drivers/staging/comedi/drivers/comedi_bond.c
index 4392b5927a99..a8b9c21d1dc3 100644
--- a/drivers/staging/comedi/drivers/comedi_bond.c
+++ b/drivers/staging/comedi/drivers/comedi_bond.c
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
 			bdev = kmalloc(sizeof(*bdev), GFP_KERNEL);
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
+			comedi_close(d);
+			if (nope < 0)
+				return nope;
+		}
 	}
 
 	if (!devpriv->nchans) {
-- 
2.53.0

