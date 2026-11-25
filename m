Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608323;
	b=Qlfkz9ljw0il7dsXCl3pzzVV3K7Iy35n9mwDxMOVoxT2dUEuAunPUaB6LbwAKMNigMG6
	 K85kslpSjaAzRf3vrcwNG/XBKepUqc2YlBZ0uldOfQdUlRLz5Dk2+0JtAXHQVZP/OorTp
	 DMdXWZ8xxoj/ry8/wrIBg1GwAxu3kNNTSd5a7rFfrei0CmU9mH+KrEmMWQt8gtPQ4MMkZ
	 XhnfUJn2BNBnMSS0enRZYYO/3LHKQlbyhye9LNMd96Gtzoit0+LVzZiKRguJd3MyGki/J
	 ZIBMbMl7733ivyxAlZ7KprzeyO2TsJSw1GVu2pplqoA8T/D3uq0HVKI/b2OIEaT98Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608323;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XIp+IHKSr/ybrxU2yjOtEQmdNFWMVqg5+on8AZarFL8=;
	b=2yX5mFCw0m1C2uM2dP/qKI8i0YmN0y0PAr/ci9FDlqEkfW28CYjlBEiOzv0U6b0nFD1k
	 S0AYXQANcRtsDucWZyWBvCprrJ6jTRBs5Ihkg4CEQjwWIIPYk/rRAk221tQVR8A3nMppq
	 Elw9Md0V+AzI9woMTe2XEMzNxSDyHiac23k/a85iadByL5G8b5GL/2e0rS6k93JsdDxa4
	 LxtKozqbmY7zddHUJ0LMHt+3jivz7dOvnPtF8d5n1MZTATlfpwye/TSHQz/GYn9GnBqrR
	 kVeMcQdOrg+rJg8l9PdfYNjVqvehxIh3V95B7DqRKbMSWQTPLZaNydtcRAuw54HlNwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=co5y71hI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24248606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=co5y71hI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CCE1F000D1;
	Wed, 25 Nov 2026 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608322;
	bh=XIp+IHKSr/ybrxU2yjOtEQmdNFWMVqg5+on8AZarFL8=;
	h=Subject:To:Cc:From:Date;
	b=co5y71hISU2Gq8isZfLVHUzyUu8SyhvkYvCRQUcUu+otpu0ZoQH3B5V7j6sSqF4kP
	 GY2S49QgvRX5lfaMqmLJZLczPop4Sh5pMLW2O+7qhX50j6hkWk4MNmiX/rvZkTNlB1
	 k1GjIfbRWnS53fmwwmNjiYH4rpn1BibHOhFDXeas=
Subject: FAILED: patch "[PATCH] comedi: comedi_bond: Fix leak of opened device references" failed to apply to 5.15-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org,stable@kernel.org,vulab@iscas.ac.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:27:39 +0100
Message-ID: <2026112539-sandy-vicinity-2260@gregkh>
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
git cherry-pick -x fa0858523f07f8dd71d89b221f4422c3b8096d90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112539-sandy-vicinity-2260@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa0858523f07f8dd71d89b221f4422c3b8096d90 Mon Sep 17 00:00:00 2001
From: Ian Abbott <abbotti@mev.co.uk>
Date: Tue, 3 Nov 2026 17:36:10 +0000
Subject: [PATCH] comedi: comedi_bond: Fix leak of opened device references

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

diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
index a10cfbd04c72..3764ece90f82 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -184,7 +184,9 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 		char file[sizeof("/dev/comediXXXXXX")];
 		int minor = it->options[i];
 		struct comedi_device *d;
-		int sdev = -1, nchans;
+		int sdev = -1;
+		int nchans;
+		int nope = 1;
 		struct bonded_device *bdev;
 		struct bonded_device **devs;
 
@@ -223,11 +225,14 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
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
@@ -248,14 +253,23 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
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
 
 			/* Append dev:subdev to devpriv->name */
 			seq_buf_printf(&s, "%u:%u ", bdev->minor, bdev->subdev);
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

