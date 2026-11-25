Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608307;
	b=Kswtwk7R/KSjEV5e26cLMAk3a1HI0kdW+0l37lD5lHkJnCQvAMdBxAqJaQtiHpCrlNty
	 gyBSV0C50F5ZYIy04r+mXhKee6E5/bFxFkp7h+rN7rNxxH1vCBeyvxnqaZGx/N3rvqe86
	 dHAoKdlOUyh8KK4pqTbq2lU3XkycKaRF3mTYkaCDrIdJ7x3KW4ZnZ+mYMu7iJNB1egMHz
	 KLRGEKJvRc25q9jd2+Wlhmdrw5qNA9ho2L1nMM8+NZ3lgZU6DMaj6PCtjNeywkyeYZd2p
	 K12d2KtihJBUWRzBd3HFpKg8ooZfQWCrhlbGzqwg/A7ldf3VQZ+PRVOoJt5P0ZxT4dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608307;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lOJInCrqVfxAiOXbdSEOc2JEJoeuvswqh05wK68mPVg=;
	b=dPy5zfeY1R5uHEcPChJ3Tqj6C00uDhByesD/xXe1EZIrOHbVoyKN2WbnIcAmFGblyFcR
	 P/TgThA8O3prbfL/FCnLMyPyLd6g7Nu/eCKHzN5TwMqH0U0enKuV9ObY/3NN7o3qVwPgO
	 kMVP2ne18iE0xhu161eReAKTrOtXy9GM7uL957d3kP9lByJXfGJngLTmZZGZg+EiUhKCr
	 NqZ7RLYsGWxPnjuNQKcthYpLT5W6rw0y0novhp4kFPP9cVP7Rf9tMeRiUKUsJK5NWSy1F
	 Uz16yOVJb9OMZCT2WMMVvnzeWe2JsHMZKZTmuJcpj4ZjE/PBgKfuVCkdsecbmekCzzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uzUXEUMK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92762606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uzUXEUMK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669711F000C6;
	Wed, 25 Nov 2026 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608306;
	bh=lOJInCrqVfxAiOXbdSEOc2JEJoeuvswqh05wK68mPVg=;
	h=Subject:To:Cc:From:Date;
	b=uzUXEUMKsOBELab6VZ4lANSUIZY60Go+S41Z4gzQoTzWdN7yD2bgRdZnjaaZ4f6ap
	 fGVVaZnm8enmMVnHnr9IwZFest328ddSV7NoW5GDFkIGEBdz5GrDmpnzud0Tp8CYNG
	 mfzm5D0MwznOtjIfKyR/3jQCrkk75wQvsYEb7pLg=
Subject: FAILED: patch "[PATCH] comedi: comedi_bond: Fix leak of opened device references" failed to apply to 7.3-stable tree
To: abbotti@mev.co.uk,gregkh@linuxfoundation.org,stable@kernel.org,vulab@iscas.ac.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:27:37 +0100
Message-ID: <2026112537-imaginary-sloppy-a6fa@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x fa0858523f07f8dd71d89b221f4422c3b8096d90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112537-imaginary-sloppy-a6fa@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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

