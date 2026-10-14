Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BF4AB3A0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974493; cv=none; b=Q+dT8wjWxzI/5fradnFqdc21pEVSf041hxuOhmz6qKcr6HtZ1X7O8RtLdmUmLlBn+Kr/W2UmwmyKEV4YA3ckoAEFWSWdmXxFKRiwg1LA56rKbEGdBcYrfEK05ZflmGEw/eZmVkg5O/wmUWDEvUUIfr63AJi3jQPNjxmpRt5CLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974493; c=relaxed/simple;
	bh=QkXnEoUjS6Asy3QHKoWfyrmwmxRf0oOgi7AmW/HqsaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dApiw5NqzkyJpYCsbX6TL1YxxLLrLaHflhhYUyBymAI2ZYKrLCC3S23ruX6sVm6I//ikIcOXm/tdHulxCyDciW94qUcbZWTRXk+0w7EbzPdVgX9FjD1IlT/nuBht1xuVMka4Wv3jYs1cMAwoOf16Dkiv8ON/0E33L6uNAgAkzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oT7gztfP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oT7gztfP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e940d5d2beso1560225ad.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791974491; x=1792579291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=834mvMFQ68xQN8ymFd/I3UQRq9F1Cfklp9OOKEeRylA=;
        b=oT7gztfPlrqiOETOoJyUr70ym9TCNPBGJhRC82N0eu1ii7OhQIGPU6IAYX/F+KJf+T
         68futkWAigDW9gFExsL6M8GVvwUAU4iEl7aSuMmt91RFATsMF5u6gLeNthpNiYxU93+s
         7xyPzgi3K4Xwa69vfv2iuV3mwx/lTSiQvrz0M7vr47FHaMejyc6DwyyQM6/Os3o51gNF
         4QetlLSlsQMKGtuA23ccrf1VDSpFSzQHohd6uloNVc4s2wnEJGdjDIMkf36hJ7RSoY1N
         BgdATpiOFuLV1Q3cYNx3KtNJ45FWhAlvF0FnR/aQDz5FlAa2lPR+kDoUmutAuKrLfT2Z
         FmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791974491; x=1792579291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=834mvMFQ68xQN8ymFd/I3UQRq9F1Cfklp9OOKEeRylA=;
        b=U4MVfXmY2Y2u5hx5GlN2O4yj5jZcj6Ig/2QWuJiJtvQnsIU+gFkwhnns6QGT8zyNEK
         PwU+I0l5oV77hXr+L9efvGdk/0WSTJieV1+BkvxjT2d2xhbmjSyhsUJvCzHkBK6YcS26
         MCSCy3qDdKKjikpOwA9XthkI6XlyAqTvvaegY9MbeODQAkMGaRrNV6f+a5OA5U37apY7
         q5QzhBwh4H8EfBW1bkKieQTDkeTXb/vt3blzsxxsY4Fi6mpjcgnsoOIF4m4dWG5sZkmf
         dAnEcVFeGew4rvRSt3/KvfNo/Xj81HluegNG3uVzKYDPSdtXc6rl7N30OxOfwpPKPWPb
         zHHA==
X-Forwarded-Encrypted: i=1; AKwUvBzb1IhHOOBdH3oTVbx3RadnL9xHGSoT32ckNUiTWK13/Ifx9ai5PaBpSd4tmiSWdGzPEDIExY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQsAjIHK+qPfl2kNkXwVVIod+OFXpHCsHaSPp36dGFMiexq40b
	63L3PexppL5ub7iLXneFRYPlmrnKMFwnEvL9tZoY7KUgtWLA43xVYHQ5
X-Gm-Gg: AYBFou1AxCoeXjicmBD1zdnWYeYOeAOZ4RTN0GS0BMz/I1TRVdj6ApZPQzth1ITuPlQ
	WrppOz6fyQo/4uLhqA3YOhx1ymi0t0lKdnoZmQjQ1nhpuktPyAnAaVjy7zlTSo6F2C/POmn4IHa
	nWmibZSapeauA6olORC6hyZgu21MZcOHyTGQebUHSbyfw7ybrsUSGlAf7/XXeE889ammkXNX7P7
	2I10UcTT9llfomDsPdP0jatogrinZ3DMtHcxe180+1467iJzbKWY8/spyDZWE2PGMZSQ574rqSY
	1eOAYl/rIlLWN3qYSPySAVNwXoO4Z0SjySTrAIdPR/PVw6wx9GSlD815xXykyQUX84+loR1pRfZ
	KpzF7kOJXHYYYtbn3kkvW7AEn6sWULngRADipNT63wkrFBIOXjfXSH8+e+WkT6iws+cW7UCaP/g
	64GPV+bSWzuzXYN84NMzcxBkLxKnqSI7NoUhduGTJM5EnzHFjV4EAjlzcLjxEekfTr5JaGrUt2V
	/nDOjaewl523rdyGwevYSX8ELRlGoP2h8GFlW/cR9jhNe10gUFDD2Xlgg==
X-Received: by 2002:a17:902:f64f:b0:2dd:ad73:c984 with SMTP id d9443c01a7336-2e842bc5ae0mr126774105ad.28.1791974491304;
        Wed, 14 Oct 2026 03:41:31 -0700 (PDT)
Received: from spark-da2e.tail8e743c.ts.net ([2001:2d8:219e:928:2121:3ae4:3d22:fb3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dd5sm70016385ad.55.2026.10.14.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 03:41:30 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: cp2112: don't dereference hdev->hidraw unconditionally
Date: Wed, 14 Oct 2026 10:38:47 +0000
Message-ID: <20261014103849.1837692-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014051326.3784498-4-dmitry.torokhov@gmail.com>
References: <20261014051326.3784498-4-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cp2112_probe() builds the I2C adapter name from the hidraw minor:

	snprintf(dev->adap.name, sizeof(dev->adap.name),
		 "CP2112 SMBus Bridge on hidraw%d",
		 ((struct hidraw *)hdev->hidraw)->minor);

hdev->hidraw is set only when hidraw_connect() succeeds; on failure it
stays NULL and reading ->minor faults.  hidraw_connect() fails when all
HIDRAW_MAX_DEVICES minors are in use, or on allocation failure.

hid_hw_start() does not report that.  hid_connect() has

	if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
		hdev->claimed |= HID_CLAIMED_HIDRAW;
	...
	if (!hdev->claimed && !hdev->driver->raw_event) {
		hid_err(hdev, "device has no listeners, quitting\n");
		return -ENODEV;
	}

When hidraw_connect() fails, claimed stays 0 -- but that bail-out also
requires the driver to have no ->raw_event.  cp2112 sets
.raw_event = cp2112_raw_event, so the -ENODEV path is skipped,
hid_connect() returns 0, cp2112_probe() passes its "if (ret)" check, and
the dereference faults.

The minor is only used for the adapter name, so fall back to the device
name instead of failing the probe.

Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid
(syzkaller with extended descriptions), arm64 with KASAN:

Unable to handle kernel paging request at virtual address dfff800000000000
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
pc : cp2112_probe+0x794/0xef0 drivers/hid/hid-cp2112.c:1333
Call trace:
 cp2112_probe
 __hid_device_probe
 hid_device_probe
 really_probe
 device_add
 hid_add_device
 uhid_device_add_worker
 process_one_work

hid-led.c and hid-u2fzero.c read hdev->hidraw the same way, but neither
sets ->raw_event, so for them hid_connect() does return -ENODEV and their
error checks catch it.  cp2112 is the only one of the three where the
bail-out is defeated.

Fixes: 42cb6b35b9e6 ("HID: cp2112: use proper hidraw name with minor number")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
This is the minimal, backportable fix.  Dmitry's series

  [PATCH 0/5] HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
  https://lore.kernel.org/linux-input/20261014051326.3784498-1-dmitry.torokhov@gmail.com/

solves the same thing more thoroughly in mainline: 2/5 adds
hidraw_instance(), which performs this check in one place, 3/5 converts
cp2112 (and hid-led and hid-u2fzero) to it, and 5/5 makes the raw cast
impossible by moving hidraw.h out of include/linux.  That is the better
end state and I am not proposing an alternative to it.

I am sending this separately only because that series moves headers and
touches include/linux/hid.h, so it is not a stable candidate, while the
dereference itself has been reachable since v4.12.  If you would rather
tag 2/5 and 3/5 for stable instead, please drop this patch -- that works
equally well for me and I will not resend it.

Either way the oops is real and unprivileged; the trace above is from
/dev/uhid with no special capabilities.  I can test whichever way you go.

 drivers/hid/hid-cp2112.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..8883023d432d 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1330,9 +1330,13 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->adap.algo		= &smbus_algorithm;
 	dev->adap.algo_data	= dev;
 	dev->adap.dev.parent	= &hdev->dev;
-	snprintf(dev->adap.name, sizeof(dev->adap.name),
-		 "CP2112 SMBus Bridge on hidraw%d",
-		 ((struct hidraw *)hdev->hidraw)->minor);
+	if (hdev->claimed & HID_CLAIMED_HIDRAW)
+		snprintf(dev->adap.name, sizeof(dev->adap.name),
+			 "CP2112 SMBus Bridge on hidraw%d",
+			 ((struct hidraw *)hdev->hidraw)->minor);
+	else
+		snprintf(dev->adap.name, sizeof(dev->adap.name),
+			 "CP2112 SMBus Bridge on %s", dev_name(&hdev->dev));
 	dev->hwversion = buf[2];
 	init_waitqueue_head(&dev->wait);
 
-- 
2.43.0

