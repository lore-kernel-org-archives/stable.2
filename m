Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628718;
	b=ymve6Fl3TYnFOeZeplzrKkrBrDU93oP1irALmmPrxJZ5MTfgQBSyZmwwKCSCqap3v+Ki
	 4qPvDlFhqwE5rmOHWXyeorHHtChGXBsxODqvZ5CFx6/AX7reMIJPt4gjze6xrRKu99Akr
	 3xbnJlokyfI52vqCgNtbscJlS6ZCdpDTwV1kqdOL2tPFMVuiLMUWAi97nn4qy4+l0nnqX
	 PsUUqcOlE4fc6laL0GPWTnVrRTskMbqbCD0+egxkm0cxgKVvRyLjRwFqCtdrC2J+JMnKD
	 /tIsOO5129STWxQTWk19sQuTYiT7QxbWom5hAeqnCW70XfkN/7xUX7MjEkXic7o8Aqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628718;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=wN1N5SmhhRahrFdLRLG52pXG9GXvItu29SbUHZK/ll0=;
	b=h8xba/U9kO/7V3IJep1WvTSrt+Q2BM/rtbWv4igGJksa4faJ6LSGtX04WgyZZQbQiOZ2
	 ieALbcs4IlcevEnmcQW6HsSteHrIOkhvmD7NNjjn17QEl8kGdQpnzPF0E82sYm5pZYTuo
	 9OfL91Tb3CgYev83afGUSfNpvAEy3JAQq4gKO4/ikESPcWBXdqs5KX5PM7457ldoeWkvk
	 A6WcXqiFCveuG8xImbKK7T9ZnRc8CRg8AK2NLBE6j4jKwxiQoerb0FNox0Olq33N61rDo
	 Ajpidqx7kP2GOikS3rejK9s09k3dIz46k6Ogcs7lhtaEbhhNMYT3L1p9ZDd1ulkwgOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=Vunzd+ZN;
	arc=none smtp.remote-ip=184.106.54.106
Received: from smtp106.ord1d.emailsrvr.com (smtp106.ord1d.emailsrvr.com [184.106.54.106])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA4606A33C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BA4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=Vunzd+ZN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1795628709;
	bh=CbJBVlaa+xLVljF69QtXPkZrwPgsm7o1I7U08uOh1rk=;
	h=From:To:Subject:Date:From;
	b=Vunzd+ZNozaW3BzFzzZHIh4qZaqnwmPOS0uauk4n/DZxgi0ns8b/FpIAFBNPCXd12
	 JDz25nqq6kAEW0hY3nRabmTLCMwi5+pC2t0uJNmZfCreNiP0AUpKFYDl7VW2blwWQU
	 OV1w9aTJ4oAyDyfKPuO8ajWFvpnJyPe+jh5xCwG4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp14.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AB8694028E;
	Wed, 25 Nov 2026 12:45:08 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] comedi: comedi_bond: Fix leak of opened device references
Date: Wed, 25 Nov 2026 17:45:00 +0000
Message-ID: <20261125174500.735765-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112538-scuba-bok-ba4f@gregkh>
References: <2026112538-scuba-bok-ba4f@gregkh>
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
X-Classification-ID: ed68c15b-abd9-4297-842b-ffa9ff75db91-1-1

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

