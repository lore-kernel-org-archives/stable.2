Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794845043;
	b=3myU18S2kvUqQyPDh3fqotPFW2JuLtHGyFZ2wTTJIX19otGFqUN4NF1S+6/eDMmHvUYy
	 im47A5TkoQEer2NuRJu95lFWg2cq4F1T9BlMnFcldxaP+ZBRA03U8x0072kwYq469XVUr
	 EiZctalpNHUjSPOJOln/b4zfl2Q669uWTKn+xxAoakWyrFKpHDi3pOwn8uNmICDLUb226
	 OyZqkvE7H4a2amJ6wQXTNGSUZ38WBPLwPjmKJhJUJlAVTnMHKP05X6nalenbDv6SEQePj
	 ZEzr+rzP9JvZlj0DPXnqdjeDhjEg+TY5rj8THQFXRcdwlmCcqvEwBcyK6MC7fqpHUIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845043;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XdLTo00ez0liJLVKJU/6DnV1F3D6qgRKsXkabMyfkAg=;
	b=tbXtI33Z59TK7Zh1Z27/NCkwkOe9tezNss+aymTR61U7VqAsRb6pkS9UvYGIJP/CUWtw
	 EhgEk44XfHtRQDcPjJYnvh37zUwfSh8Wz6RRNYcutX64frxAFN1EVPQAHyHE3Ea/SwWwG
	 qkuaVAybpNcAeYNlq/DKlO9SNeWR8DnHzIfgE3ZgQNijT6atVB0sM0DT102m16b6GufGe
	 kTAn1uOCeKUmhe41TubBjXFMvIYNOTmASiNbbWC6WZHJ1LoADknvrJOEiWU2Xou8JDE/q
	 sFfIWIK1cDgr/oXq0HvY0whF25o31R/gXs1h3zyHVpLOEjBSsl7SX7xf2tSgzqe0+kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhw7l3k8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB5606A32A;
	Mon, 16 Nov 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhw7l3k8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794845043;
	b=0N4/O+ta4hXLike/FhjqnJe7fdnpz079P8X28R1zV1Y740HW2npG5iM17gYcruTF22+M
	 V22hlyBZR/iKyZp9WMmlcuBRu6dEbp0nWaHANnKJo4M87WdHqcVo5CtHawiN8V38QmCvW
	 3sz3nmcHLwiDb03Etiiqp1plyIjH+vFHobbeHJyULyZo4iSeSz/BabSdbg003I/7t6Ojp
	 h6PmWYEqpaiM7NUFuJL8gtNQD7NawKRmeNIHg+JMzKRVtbDjq4sGcBB8VOf+15qzzL6Mh
	 1F+1Y6b3wx6uKNOaDqwyqLwWKrB45CfZ+WkjD2lB2EcKBAphkJQG/TfRZT1K2c2hlJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845043;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XdLTo00ez0liJLVKJU/6DnV1F3D6qgRKsXkabMyfkAg=;
	b=WCTUKG2H3aw+0sK7yhih4o9IuAi+VcivqIcFrj6dq73U9clPfKcuEnBBVpLZbwuH0gA1
	 iMpye0yrrdiRsbgA8GcWYMwh3hFB6+XwqGzQdsRHr/ypKyi21CKqEcBcBVnP2G+CGdqxe
	 +sRj0amfgGXCGlgV9ehwO50IFQs8cTujsOHPZOp8DaJ46d6AP9GVuWPQ39/0j8i2R7pIH
	 P/Xb9HvE02HTEJMzoLWLFrn7FIGHh+SyyiUX0ehPSsKHZF5f70lWbnP9DIcGQQfFlH1w4
	 sxviFm2jtmpv6XVSGrUk7bX+g6WMDZzV/aLuSM/ub1Ru37umA6EeXCXTA0GW6avDpAg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 951121F000C9;
	Mon, 16 Nov 2026 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845043;
	bh=XdLTo00ez0liJLVKJU/6DnV1F3D6qgRKsXkabMyfkAg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=mhw7l3k86gD0pHuvdUI5dDYpfSbqxHx9Gm6NRDILgt5RTsjxX6QM2UbQTFvSNSRBW
	 CwVgCTSmf3bkJLx8YYwM6t0mMbPOdtrsWzpRRsZFR0cpO4DZBjba0kvsgQHMeItmZt
	 2U8xPFMIbkxYeT8EScgfXZWZtS62PWsbOXclqFUBSxGe/5O9iyUi8O8imC0M3njXd6
	 4pxQDBupBdUbUqBOS/du4NS4lq6+4g+BxWClxIbgmzceuKi/XGSldFSGgPitGrDCio
	 BL74nL1HvcWBzZu0DJqZieGD0krRXZUoMfY0XwyPeQSroSX2lkAWxocicO762eoLhi
	 R37jQ2zqNWdOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EBAB14A508;
	Mon, 16 Nov 2026 16:04:01 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Subject: [PATCH v2 0/2] media: i2c: ov8856: Power management fixes
Date: Mon, 16 Nov 2026 18:03:58 +0200
Message-Id: <20261116-ov8856-pm-fixes-v2-0-7e41763164f2@tutamail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQ6CMBBEf4Xs2TVtgVo5+R+GQy2LbCKUtNhoC
 P9uJfHk8c3kzawQKTBFaIoVAiWO7KcM6lCAG+x0J+QuMyihtJSiRJ+MqTXOI/b8ooiWKttXxhm
 lOsjWHGgvsnRtMw8cFx/e+0GS3/S3Vf1tJYkC5bk2t1MpHGl9WZ6LHS0/js6P0G7b9gHJ5JPts
 QAAAA==
X-Change-ID: 20261103-ov8856-pm-fixes-ae4af48c822d
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Hidenori Kobayashi <hidenorik@chromium.org>, Ben Kao <ben.kao@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Charles Drolet <linux@cdrolet.dev>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794845041; l=5322;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=+mhMmb0y6u8eXbRcxOqaHSRMAfskWw4SpmD9aXVBVUw=;
 b=C8N2YRx0yY8QPmkcjwb12630HYHdCXzZaMFP/R+WK0V0q2zZk/xmynmLt0CQb6Tk3jmqDzWLh
 z+P7ePDRtkQAbN9wHMZFWQgA45pxgiOLRRSRZvsiS6QEyh5w8RERjAC
X-Developer-Key: i=b.danias@tutamail.com; a=ed25519;
 pk=6DWeigdk0D3JwBjwvmxo9RW8cG8S1Eku42cb9PP+ghk=
X-Endpoint-Received: by B4 Relay for b.danias@tutamail.com/20261103 with
 auth_id=1406
X-Original-From: Babis Danias <b.danias@tutamail.com>
Reply-To: b.danias@tutamail.com

Since commit 609a71568664 ("media: i2c: ov8856 : remove ACPI node
bypass mechanism") in v7.4-rc1, ov8856 also controls the sensor's power
on ACPI systems. Bringing up the rear camera of a Dell Latitude 7320
Detachable (OV8856 and a DW9714 VCM, behind a TPS68470 PMIC) on top of
that showed two runtime PM bugs in the driver, fixed here:

1. remove() powers the sensor off even when runtime PM already has,
   giving unbalanced regulator and clock disables. This also affects
   devicetree systems, since 2022.

2. probe() registers the sub-device before enabling runtime PM, so
   ipu-bridge can't runtime-resume the sensor to instantiate its VCM
   (-EACCES).

Both bugs are older than 609a71568664, so both patches carry Cc: stable.

v1 had a third patch, which powered the sensor off during system
suspend. It is dropped after Laurent's review. The problem it was aimed
at is still there: with the dw9714 driver bound, the sensor stays
powered through s2idle. Charles Drolet is looking at that from the
dw9714 side.

Testing

Tested on a Dell Latitude 7320 Detachable (BIOS 1.39.0), with ov8856
and the TPS68470 board data built out of tree, on two kernels:

- Fedora rawhide 7.4.0-0.rc2.261111g067c5c24cef2 (mainline at
  067c5c24cef2), with ov8856.c from v7.4-rc1 plus these patches. In
  mainline the file has changed since v7.4-rc1 only by one
  devm_kzalloc_obj() conversion.
- Fedora 7.2.15 with 609a71568664 backported.

The board needs TPS68470 board data that isn't upstream yet: the front
camera entry from Sahan Nissanka's series for the Dell 7320 Detachable,
plus the rear sensor's supplies, reset GPIO and VCM supply. Charles
Drolet is working on board data for the rear camera.

With that, on both kernels:

- three rounds of unbinding and rebinding the sensor give no warnings
  (before: the warnings quoted in patch 1, on every unbind). On the
  7.4-rc2 kernel, the regulator trace of the whole test shows as many
  disables as enables;
- the VCM is instantiated when the sensor binds, the dw9714 driver
  binds, and focus can be set through V4L2 (before: the -EACCES error
  quoted in patch 2, on every bind);
- the sensor is runtime-suspended after probe and after each rebind;
- streaming with libcamera's cam works at 1640x1232.

The logs quoted in the patches come from the 7.2.15 kernel.
checkpatch.pl --strict is clean, and each patch builds without warnings
with W=1. I haven't run sparse or smatch.

Two things this series does not change:

- After the sensor is unbound by hand, the dw9714 driver is unbound as
  well, and it stays unbound when the sensor is bound again, until it
  is bound by hand. v1 behaved the same.
- The probe error paths end in an unconditional ov8856_power_off(). If
  probe starts with the sensor not in D0 and then fails, that disables
  regulators and a clock that were never enabled. This is older than
  this series, and Charles Drolet has a change that makes that
  power-off conditional. A related case comes with patch 2, where no
  usage count is held across registration any more: if
  v4l2_async_register_subdev_sensor() fails after the bridge's bound
  callback has run, the VCM work may already have resumed the sensor
  and let it suspend again, and the error path then powers it off once
  more. I haven't seen either happen and can't test them on my unit, so
  I left them alone. I'm happy to add a check there if you want one in
  this series.

AI assistance

I'm not a kernel developer, and I'm out of my depth here. I worked on
this with an AI assistant, Claude, as in v1. For v2 it explained the
review comments, proposed the changes and the tests, read the logs I
sent back, and drafted the commit messages and this letter. I typed the
code changes myself and ran every test on my own tablet. After that
I've checked everything as well as I can: each claim here against the
code, the commit history and my own test logs. I can't promise I caught
it all. Hope this doesn't cost you more time than it saves.

---
Changes in v2:
- Dropped the patch that powered the sensor off during system suspend
  (v1 3/3), after Laurent's review.
- Patch 1: mark the device suspended only if it wasn't suspended
  already, inside the same check as the power-off (Sakari).
- Patch 1: the Fixes: tag now names 08304923d317, where runtime suspend
  began to power the sensor off. v1 named 0c2c7a1e0d69, which was wrong:
  the driver had no runtime PM callbacks then.
- Patch 2: don't hold a usage count across registration; call
  pm_runtime_idle() after registering the sub-device (Sakari).
- Dropped Charles Drolet's Tested-by on patch 2, since the code changed.
- Retested on 7.2.15 and on a 7.4-rc2 snapshot.
- Link to v1: https://lore.kernel.org/r/20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com

---
Babis Danias (2):
      media: i2c: ov8856: Don't power off a suspended sensor in remove()
      media: i2c: ov8856: Enable runtime PM before registering the sub-device

 drivers/media/i2c/ov8856.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-ov8856-pm-fixes-ae4af48c822d

Best regards,
-- 
Babis Danias <b.danias@tutamail.com>


