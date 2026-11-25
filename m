Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628760;
	b=1MKhKZIabeEHccJpHwqKAsM9rvlxRGLcFv6WoGYO8EcFMZ1ojO8ywhnZN20bJoHOayoU
	 48r/Z+XRyiWbqDnfghwqK4uGHk7bFiNXk6KS9sqSJgEx4kQS2pPKU/WG3Zr2NWyR5frIC
	 coEQ3FS0l0Gah+ngEpJqdRJqiiLiZe7m4NioMMJaTJS0/g0TdK0oq/DQEfci5qjneXAW7
	 ZFbtcaN9qviSqr+UnzYvwZ7SJJKdJWvdlGeCbNx0PwCBv/oBkJWsa5KcYhoO0a1GiNLPI
	 CdcR3JtJsCBxW/iWvG/s5R3BXHk8CBgnSOeA8mojFeb6EXslz4cO7ljy3aic/WjDSXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628760;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=wN1N5SmhhRahrFdLRLG52pXG9GXvItu29SbUHZK/ll0=;
	b=13zjMkgKmj9T8x0Y1sxjm4xzdzXFMp1r0baQ8FEcM5LEholURbB9CeRsQMc6Mu6JCp/g
	 QSpQVBVZG4DHfcdzRdkCDI31Npp1HPVdU0IV9lE3LYCPxQZw1FpKCoBYH+t5EDOIyzPI8
	 aGMjF3yk/KjQ++Zjc7ey2bxRQC1hemb0x1uGbCjaQSFF1WcUNneiaA+khLv01RNKs8jk+
	 qqwYTfxqFWRlqiVF5uGhwylzO+8T6F0d2jKxhPz+6CtDIvWax/bKbwTLoGU9sMGSPSQ01
	 NjPUvNLDJwzcbaOEHuPUkU4ojQXxbU0W4aYREX2NQ0eXKqj5Jj2Btr696Xr9iKl8HuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=RPSIBb0f;
	arc=none smtp.remote-ip=184.106.54.82
Received: from smtp82.ord1d.emailsrvr.com (smtp82.ord1d.emailsrvr.com [184.106.54.82])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDE606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDDE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=RPSIBb0f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1795628752;
	bh=CbJBVlaa+xLVljF69QtXPkZrwPgsm7o1I7U08uOh1rk=;
	h=From:To:Subject:Date:From;
	b=RPSIBb0fhs3vX2u5S1phOpm/9NPTQfn8gjl4PTARUkhRrMrFDBQZFI0m3Z6YmmbJg
	 pKsmFJanVqkBNZbkcSRPd89j5eldF26QRLtwVA8+FCW/j2/UULGwFkgtUycoiBItS5
	 RkY9XUK6Qpr/LlcPfGHwuGFlCx7usBS8WP0c7p4I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp11.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 176E7602A4;
	Wed, 25 Nov 2026 12:45:51 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] comedi: comedi_bond: Fix leak of opened device references
Date: Wed, 25 Nov 2026 17:45:41 +0000
Message-ID: <20261125174541.735788-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-proofs-decibel-82bf@gregkh>
References: <2026112538-proofs-decibel-82bf@gregkh>
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
X-Classification-ID: 862bad7e-7042-496a-bd8f-b9ac6976c2ed-1-1

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
index 78c39fa84177..076aecae2c77 100644
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

