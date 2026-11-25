Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628626;
	b=f9FS8OjnnJv7zF8apKV6GrFXWFD7N07Y42Jkzt8TMgX2SkVPjjCmgFwLWqVL+36Mq1LH
	 WRvfRXcoGfzvckeVBetAdxWPmo/y4bOO8xGfE0xNVj1PFaNuvjepOClmdW33K80sdNHC/
	 zDR8SF0KBDm9V+eCGbsegp853lK3hhbsIshN7RZa2abcJmGxtTQfN54kRpS7Ue1EkQscp
	 P6ukUG3uGQKdCUQlNRlBgXMWcuTEq0k1LXX0h1JZEjKPFVKVh+8Mnt+AasNtiDekfVCdH
	 j36XVKanqi5UwPk2AzWdJOOuljvVa1fRHGd1dH8qJ4R+cCnmTMC20OSVQrmqf1VolpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628626;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=wN1N5SmhhRahrFdLRLG52pXG9GXvItu29SbUHZK/ll0=;
	b=1Ah48sBo02TRV8AZnmmEYzoKQY5BKMEYkULelMLr66gG4b1IcL74BPzgPeNRECKIj5IM
	 BRx8wXNz/0fPc9deBtJkuV4Czrj0qYsq8inb8KiTfyaOav7JKQfss3zm9LbEqx0I6d0Tc
	 1EilLA6Lv7bwTY1rq9oQVohvAvP5aNcskV827je4AsNNTwKwVQ2RAuy9N7Y20+D2G1Wov
	 Vhri0VdCIO2UYDzjCy9deniLUaIA6kAi1D6UvwklJagM4tzyPkugSzbIy4i+iaMgdINGd
	 H6DhDZWK2n+LndKXxBIZIkeglrLm2o9EjwQ32w2BTlcOCO/7N+0x6HUtwf6ft1WRzPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=Z149L8b4;
	arc=none smtp.remote-ip=184.106.54.122
Received: from smtp122.ord1d.emailsrvr.com (smtp122.ord1d.emailsrvr.com [184.106.54.122])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE43C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=Z149L8b4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1795628619;
	bh=CbJBVlaa+xLVljF69QtXPkZrwPgsm7o1I7U08uOh1rk=;
	h=From:To:Subject:Date:From;
	b=Z149L8b4igbWWPb2GngBbTKqTccpGy5MQu5BgCP1HEdrSp+EcLH1pHO99ZNCsdpVg
	 X3bdXVLiiAcAi1aaVImN9aT40Sk1CvX1HxUmY53qC0F+4C4y4TLHvNUkwRfI96qkFE
	 lCulAy2l3wscp3RJeNDgzFPFbpNCasSJm4Gq1pTw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A0742A010E;
	Wed, 25 Nov 2026 12:43:38 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] comedi: comedi_bond: Fix leak of opened device references
Date: Wed, 25 Nov 2026 17:43:22 +0000
Message-ID: <20261125174322.735709-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112537-rocklike-strive-9f66@gregkh>
References: <2026112537-rocklike-strive-9f66@gregkh>
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
X-Classification-ID: bf344868-1fc6-4e71-81ae-b5b60c9852b8-1-1

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

