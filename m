Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608311;
	b=NQ/b/uY+3i3L2n2KmVnasnvMnK4CQ7pxem56kXIajY5BNUCQJRLG65HIMkMjXjLADA+y
	 y/Vzs6Ylt32T1aD+WGiuspfBi/uJmoxR5GwabVbMB6WZvAxrIRgWmUBj7MXZ/mSnvb5kI
	 +aKbG0pvhbMGP8+alKgIzTCIxvDzHlayMOYjJ2ZuHRso2rY32kLJj9zMqymTd7u54939L
	 7lCy2MfxFwjcYl5LCZf+yyctkVH8mwE74YgVFiXS3LIO25fEw64GhVaFYKSNZnV6K6aBg
	 dHNSX31z8+dUWT5rKginGyYHw6G/F9CZEN2ilhHnI/tYbnAshHIRTA8C4yEYzCFYelQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608311;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i7o59x2iqYlOWUW501HZ/z0VNP1vHARpYT9U+Qekh0Y=;
	b=4og0YM+FdM1DGysZcQachmuopFI962cl/La1x0ztdSgOPEj72/jj4GGORIYAq6A519bO
	 HcIr6wMi6o+hGvSnD0hglg+XDKKfKF42B4qvHbl153laX+XzR7GZC/s2XYr7d31Jk05gq
	 QHNL16NazsyzKDslo/2q6Ki0Kw0V9ebC8xNXQ4/D6AZBs012+KEgTIn7RV1eR1oykKmmV
	 bPSODMkeRk0gM0yBkLEM6Xa4SKvjtytScwFfR7Q7HDrsyp5OzYOszwenV9rKEGS8AA/W/
	 5rejP9gtGaVayxeEJe9JwEmmsboT7Akw/rgijbzr8fzjeYm/3absRDSy2YLW/7USUmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="y/nacUQr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05E606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=y/nacUQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D1A1F000CF;
	Wed, 25 Nov 2026 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608310;
	bh=i7o59x2iqYlOWUW501HZ/z0VNP1vHARpYT9U+Qekh0Y=;
	h=Subject:To:Cc:From:Date;
	b=y/nacUQrzaxSXjfTD+s1WVHcOd5SecUBZ1C4brZIlks+iLj60oYtW75hVWzxK4vIy
	 ZxmHyPOmvp81n05MwEhnZDGYNEkMyDSlfJSBKFoMvx9N5sODQbDrj0U5wSWjD92hHN
	 EBH8NyQ/cUfiStJd4jVS0+YGZFnybqJ+vhy9PIoA=
Subject: FAILED: patch "[PATCH] comedi: comedi_bond: Fix leak of opened device references" failed to apply to 6.6-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org,stable@kernel.org,vulab@iscas.ac.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:27:38 +0100
Message-ID: <2026112538-scuba-bok-ba4f@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fa0858523f07f8dd71d89b221f4422c3b8096d90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112538-scuba-bok-ba4f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

