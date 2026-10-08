Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C94DA9DF
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474135; cv=none; b=obgPPn2mAViTYfN+WRoX5nwsePL+kM4QJsQhSz6yrRlJ61QSxdSpmPOaZszjuetvUFeFptZ1OIUulmMo2ENGTPerQYjEefosIMqE8lv88V0CWQjFeOYesIsB868dumlh0Y4xM7Tk7nqkkvy1uiPJukHQhG7JccHWV0pFehd5TxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474135; c=relaxed/simple;
	bh=kFYB2YE03Fr1cNJfzEYyTe0jd63mjl+q93uWX9YFs7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dYJ2Ee50SVnca2l9AEUrrMallGlAZT4uqF6QPLuSIt5B84F/dMfNR4KN1E2I+6Dq3yO6c09Sh6+BMRSISh8wu15/xvmxhnASGQG6TqsIaFh1D5MZJ0foeysYJJlnKdtEEnN6BOgIQKvDvVqxovnB2m5++1Il7KH5aJcpyDX1MCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJhOtLkZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJhOtLkZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed3993c1eso365908185a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791474133; x=1792078933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0u6VEga/fDhA/LHHVWZ01lUO0WQKoIfCOS1lH5jNGjs=;
        b=OJhOtLkZDn5zt/hI8ZJsspzrv1uC9f3FYu8SVAyOwbQFuO0OPK5xkmDoO4HGeNldBT
         8o5Q/ST+uSlVkMjka9xGBMxsx4C9jy4Zc7ritC7KZB5g3tgSgijxkHp6Nve94ATzM7Ft
         Og/zlv2aj29WIgM5NCTKGdvjTwSWuQ1j2EtJk+7oDmK8GjTlV2dScsTFL0Jn7qKxNVv3
         RUoO0IYD6qwn1WpEicjrRq1zxlE/IkzwktJMYZeEZrb9yRhd1xZAC+JZ/p8LNbxWw+dD
         0hskWMY5D3QHzLoglWvqc7BF8OjUS81DJ7MIT8CeE6Fph+DHp5En/FLQjQE4Q2GuPoDh
         wkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474133; x=1792078933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0u6VEga/fDhA/LHHVWZ01lUO0WQKoIfCOS1lH5jNGjs=;
        b=GNlIHzYE0BMyiqHdXzxErDEZhzFEiaKZaCy0nsnfhlGbqKpLYX/YBkBRsUS4TfNNLg
         pvwCrZCLLkiejdabs/3ariZRDengKUXZ+NRdHECYCZnQJtqfyqZw+cnJ1LCi3EbvBW7t
         5ctMqgoL4gkeW8APcwYTsM6XvT0vCUMvA9hK28PC6yHx6U7pJBHWNFMc3etPwIARhg9X
         qhFIgC4zJnpVezsr9DdhoxNPKPTqBjcYGesA+0h0koMw2Zz3VC4kf5GKcRVSebe25I8t
         OW6QJl8hIJ2iZGiiicKfwxGNCFemF4tXocJ/rUlblgIHq9Ev6/tV3yCQYA6f0VGrunyO
         +pjg==
X-Forwarded-Encrypted: i=1; AKwUvBy0lls+Jb1Ivq49Oo7KkppUz16/6SFqXLRAJnxLlqclWnhVjJ6LiJwb+pUwT8RKzk1RQT7sr2A=@vger.kernel.org
X-Gm-Message-State: AFuF++lvT2Za7kAAApXJWSulG4tWAAVffXWV+SAtijVI3Q5ZgB351HM6
	bvzdNYwj+NQNdrywfD2wwIgU2GEaeB/RCYR9mV8W694l8pTWubW/jPAn
X-Gm-Gg: AYBFou0GKmNCg40FgPXVcrmlaTYpk3t2JP2lCqokkWfDW2CfPWomHDWcavsnOLkZMKu
	KwDqFIlErcmoZHQL0qpSO8QvI3+5j6Ed/8g9IZqozGkX/hFCH2dZkvPsrBnI9PyLnaXUvhD11rl
	thZd75QXdpzyF4Y2jkf1b5fHHLD+zEbOq7ThMJSvsM3UEt34R30QBL2g98bHGZRoNOd91Ouom8v
	J70yzJBOP3w11DYK0todMfkK6cJLunsQyMPyCh4H+HEFQr6ibybz/QswuXjg/f66cCs40IBFjBB
	kxEqFfS+d4t15SLnBWTqVn7yrpwaWvZ0LyVgSbE9Muo0sBAoRLBqubYUTZ4cJ2m3ml4FsM9iH+L
	xOc3TLkZFFv5EBFV6U9tcOfiJmMvVo/sjAPNTHHEZEZlr8CgXqZvzAYwPUNMFVibbmb9JlAhHKv
	f+30/uuRMOogXEAn/ciTopxSxWgdFyA4o2yN2byOSkaXRiQnjPBUe3nVuInOFzfV1IoUr12UiAc
	+vIVvNYf3Kk2YJCL94BWznXsKJ0RVTuQo7l/OQ8YCxgpAUvR/KVv04e1SjRgFMvMuwROoLSAnv9
	U/PL3GsOi2coVBRC7l4ABVSik5+TvDzGPpL/SYlHo1Dms1gewcKWlAqxjhQKVVryE1TaR5ui0N2
	X1YIvQJAOhT+KFBa9jwHS5vsx4rRjSG8t+JGwPF+NzDqzw5D0gKe3QlvpHWZw0ccibCpN0D3Yyy
	a8Deoz9qz14nulsByx6fMREEtdRRFl
X-Received: by 2002:a05:620a:471f:b0:93e:4f4c:b380 with SMTP id af79cd13be357-93e9b2f09fbmr1114619485a.10.1791474132642;
        Thu, 08 Oct 2026 08:42:12 -0700 (PDT)
Received: from node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us ([128.105.144.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991a014esm507954485a.27.2026.10.08.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:42:12 -0700 (PDT)
From: mosafer <mohsafer@gmail.com>
X-Google-Original-From: mosafer <mosafer@node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com,
	Mohammad Mosafer <mohsafer@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] driver core: complete deferred binds when drivers_autoprobe is off
Date: Thu,  8 Oct 2026 10:41:05 -0500
Message-Id: <20261008154105.256340-1-mosafer@node0.quickhttpnode15.cloudfaas-pg0.wisc.cloudlab.us>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Mosafer <mohsafer@gmail.com>

device_add() registers a device and then runs the bus's initial probe
via bus_probe_device() -> device_initial_probe().  With
drivers_autoprobe disabled for the bus, device_initial_probe() skips
__device_attach() entirely.

That is correct for automatic *matching* against the bus's driver list,
but __device_attach() also doubles as "complete a bind that a driver
already initiated": when dev->driver has been pre-assigned outside the
normal match/probe path, its else-if branch finishes the bind by
calling device_bind_driver().

With autoprobe off, that second duty is skipped too.  USB depends on
it: usb_driver_claim_interface() pre-sets dev->driver on an interface
that is not yet registered, documenting "let the future device_add()
bind it, bypassing probe()".  Composite drivers (cdc-acm, cdc_ncm,
cdc_mbim, ...) rely on it to bind their sibling data interfaces.  If
drivers_autoprobe is written with 0 while such an interface is
between the claim and its device_add(), the interface ends up
registered, with dev->driver set and iface->condition ==
USB_INTERFACE_BOUND, but never bound: its knode_driver is never
attached to the driver's klist_devices.

Teardown then trusts those flags: usb_driver_release_interface() ->
device_release_driver() -> __device_release_driver() runs a full
release and calls klist_remove(&dev->p->knode_driver) on a
never-attached node whose knode_klist() is NULL, which klist_put()
dereferences:

  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
  klist_put <- klist_remove <- device_release_driver_internal <-
  usb_driver_release_interface <- acm_disconnect / cdc_ncm_unbind

Reproduced with syzkaller's C reproducer on a 7.3.0-rc6 tree:
instrumentation shows the doomed interface's device_add() racing an
autoprobe=0 write; the bind-completion branch never runs for it; later
teardown hits klist_remove() with a pristine node.  With this patch the
same instrumented race completes the bind inside the window (knode
attached, crash gone): 3 VMs, 5 min per run, race window hit and bind
completed 8 times, zero KLIST-REMOVE-BAD, zero Oops.

Gate the flag on what it means - automatic matching - not on the
completion of a bind the driver already requested: pass through to
__device_attach() when dev->driver is pre-set.  Other subsystems that
preset dev->driver before device_add() (w1, tegra xusb,
zynqmp-ipi-mailbox) get the same correctness back; when dev->driver is
NULL the behavior is byte-for-byte unchanged.

Reported-by: syzbot+863936f50214e843ae0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=863936f50214e843ae0c
Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Mosafer <mohsafer@gmail.com>
---
 drivers/base/dd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..98315264295e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1149,7 +1149,17 @@ void device_initial_probe(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
+	/*
+	 * The drivers_autoprobe flag only suppresses matching the device
+	 * against the bus drivers.  If a driver has already been assigned
+	 * to the device (e.g. usb_driver_claim_interface() pre-setting
+	 * dev->driver for an unregistered interface, expecting device_add()
+	 * to complete the bind), the bind must be finished regardless of
+	 * autoprobe: otherwise the device ends up registered with
+	 * dev->driver set but never bound, and teardown oopses removing
+	 * the never-attached knode_driver from the driver klist.
+	 */
+	if (sp->drivers_autoprobe || dev->driver)
 		__device_attach(dev, true);
 
 	subsys_put(sp);
-- 
2.34.1

