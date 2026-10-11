Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2303DEAC8
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791740938; cv=none; b=IpGQvNAOE518qt1JWGnFhXUSyl9s/cRH39oDEKhkRN4uQyn+k9y7+kFGk9QIgf1qhzAODsXWipM44pkPcuoLfsuCcSOiwqOySvZiQMODLY7SMmJkeyXfxKvn6PVPmJ8f4th4cnck60oltirwkhLPC4FQtSBRT456Xn1WGg+bGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791740938; c=relaxed/simple;
	bh=+ac6ZuafHdUeOx4kM7JtsJyMiC3/HL6rFzc5v99ZtBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OWDUWK+ojnnDXO2RIJE9gmhIQy2vBi5roJ6494Ll4/IhhkPXLa+8KfNyA3N4UobCPuXXorwetgD4xANbKd0yZovkKJUtdJCPI7gbd2wFY2crO8bYo5x16jn3jyce86ZSqNBNsfPQcarsGe9MExysh5aHviX+F8nsqYdGy8esaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0VH55xm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0VH55xm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so7202395e9.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791740936; x=1792345736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnKvaxco2zJAP8jwsjWRlSJGBk6Z5phho18+IObWBjI=;
        b=X0VH55xmP9wMFZil60cPVPSGFM5qoJyg0Fw10RpYMY5PQSPl1yW3zJ4DybLPVBiaZS
         oXX98p7997j0NKlywcpTZcPFJ0B+iw9Nwynk7ifDNu2SH9T576kJM5TYl5dKU5xmplUN
         q3BXc1OWzZTnHpKt+TB9mf6196usZjwIHnKhaw8YebMT4JK/0LD4GsWJrAuEDczTwXy3
         t2rgqBFSZhkaEKRsI4an8TJC9GGh7j8xzcZmCYoBAvw+8IC5ElB6io7K2EKriFnhcyV5
         Ccn1KmL5D0t5S5mR2smfNIxt7x32DfLP+CA+7ryge44nRDUxdvuzUYxo1piEzmUx52pa
         R86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791740936; x=1792345736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnKvaxco2zJAP8jwsjWRlSJGBk6Z5phho18+IObWBjI=;
        b=iCTtihRnuB1HlFGwuLiBGrPAm0zDZE1tLXCfrlQyHdOfj7uP3iI+FxyYgZ5ialI91p
         BN5IuOq3ss0TREwbgq6QlcYMFEnsqEI7SwLIlYJH/q4cmr76u/THzYlCBT2528O0lrEQ
         v/jhNTXffO7NhuT9UNMJ2y6RyambVneKoipPakAXnDC9kw6X36kGc2iVicYECs825haB
         5Y39vbknxZS/yCrSd13aulM1ALncOlsTAvPWJTMx5qZZPJQg3uzF98qPNdcj9y3tKRN6
         gUl/gxcR9odHW6XjgkVRUmmHu0K7dJw3tdLhB/Juu4wIFCd2AC61NZaEbUI+1JGQf5/A
         8pzw==
X-Forwarded-Encrypted: i=1; AKwUvBx9GMQZWVotlyGVv75Z0EdYrX62kRJbeKbnRhzhC9C7XL90pOLeBvi7eJYoZ7imc5RFIl8gw0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCrzrmTyeYKSgQte31+lS3HxqnNwgLws0xu5Z8h7horIXX8bBB
	KPg6QslTQlrpTsK8DY66qm1kp7d3IuVFet9szeqqCiE0M6JlCTAwqU4P
X-Gm-Gg: AYBFou1RfwF4Rj3ejSTyLYsWqv3+rGUM3C2VOD3UVhxaJd16kQlV+LUQ4DjuGdQQYy6
	8hREXbIEkazJHrEOPnh+aN6GQiEumG9uEXfsVlJSwV7VBd2UKVTBc8xKbBIpl8RJ/4oYfQijMu3
	P+NZUXJLBvHvHisM462y7dEx8ET7YDPQBOgPjiWIn9OpdanxDqKY6doKCZhRmAkjas+6g21uRSf
	QGia0QiyP80yD3g82fhDZ7bgVfScFI7YjQw4qrelJHLQsfV6X+BHfvaOCo/FCywpyKuwunjU9M4
	3NYAPKnuifxmqsN/o81Ji5QrLBVnM3TP6mOMQTa16P4e5ZvvN3GduyKwJKTkgtaiz6V3ChW6zVn
	3GQ77t8x7hNnfvjege8dzQxbnSIy5M9R3HtHGE9rKJAbHTT7u3BbdpWJRUUSVHXf+CpKOyW46bL
	sbztXizzjw1a1qhWPcyNOE0GBoUtr+JQzAvjv74YUbUMk+QnFUqYSRrPsYWDHxA5hmG/zXyw9wS
	Nfp75nU0hxOOFZXi0YEA/6vYxSP3VmeQ3/GVxp5C2FFb9+KffoFCoCbMz3C+udP0uw=
X-Received: by 2002:a05:600c:3e8f:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a18e44653cmr141326245e9.4.1791740935316;
        Sun, 11 Oct 2026 10:48:55 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19471edd5sm249995755e9.11.2026.10.11.10.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:48:54 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Chen <peter.chen@kernel.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	syzbot+3fb7629cfd12d04beeab@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: phy: don't overwrite a device_type the bus already set
Date: Sun, 11 Oct 2026 18:48:53 +0100
Message-Id: <20261011174853.59234-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_add_phy_dev() replaces the device_type of whatever device the PHY
driver passed in:

	x->dev->type = &usb_phy_dev_type;

That device isn't ours.  PHY drivers point x->dev at the device they are
bound to, and its bus has usually set a device_type up already.

i2c is where this hurts.  An i2c client keeps its release callback on
the device_type, and leaves dev->release NULL:

	const struct device_type i2c_client_type = {
		.groups  = i2c_dev_groups,
		.uevent  = i2c_device_uevent,
		.release = i2c_client_dev_release,
	};

usb_phy_dev_type has no ->release, so once it has replaced
i2c_client_type there is nothing left to free the client with, and
usb_remove_phy() doesn't put the old type back either.  Removing the
client then hits the warning in device_release():

  Device '0-002c' does not have a release() function, it is broken
  WARNING: drivers/base/core.c:2642 at device_release+0x1de/0x280
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   kobject_put+0x162/0x260
   device_unregister+0x27/0x30
   i2c_deregister_clients+0x27d/0x410
   i2c_del_adapter+0xe9/0x230
   i2c_tiny_usb_disconnect+0x3f/0x90
   usb_unbind_interface+0x1e5/0x9c0
   device_remove+0x125/0x170
   device_release_driver_internal+0x4e2/0x6b0
   bus_remove_device+0x2f5/0x470

syzbot gets there with a fake i2c-tiny-usb adapter: instantiate an
isp1301 on the new bus through its new_device attribute, then unplug the
USB device.

Only i2c is affected.  phy-isp1301.c is the one i2c driver among the
twelve callers of usb_add_phy_dev(); the others pass a platform device
or a struct phy, and both leave ->type NULL and keep their release on
dev->release or dev->class->dev_release, so device_release() still finds
one for them.

So only take the device_type if nothing else has.  Callers that rely on
the uevent handler still get it, their ->type being NULL, and the i2c
client keeps the release it cannot do without.

Tested on x86_64 with the syzbot reproducer: before the change the first
isp1301 instantiation panics on unplug, after it 292 instantiate/unplug
cycles pass without a splat.

Reported-by: syzbot+3fb7629cfd12d04beeab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3fb7629cfd12d04beeab
Fixes: a8534cb092d7 ("usb: phy: introduce usb_phy device type with its own uevent handler")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
v2:
- Add Cc: stable, as Peter asked, and his Reviewed-by
- v1: https://lore.kernel.org/all/20260924194236.168010-1-raghunathpalla.0209@gmail.com/

 drivers/usb/phy/phy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 5a9b9353f343..ded18c7fe32f 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -705,7 +705,13 @@ int usb_add_phy_dev(struct usb_phy *x)
 	if (ret)
 		return ret;
 
-	x->dev->type = &usb_phy_dev_type;
+	/*
+	 * Don't clobber a device_type the bus already set.  x->dev is the
+	 * PHY driver's own device, and for an i2c client the release
+	 * callback lives on the type.
+	 */
+	if (!x->dev->type)
+		x->dev->type = &usb_phy_dev_type;
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&x->notifier);
 
-- 
2.34.1

