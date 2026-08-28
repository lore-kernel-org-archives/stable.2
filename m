Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3140EB91;
	Fri, 28 Aug 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913755; cv=none; b=imvQ5k5LGkPcqSOPT2rBqbpKyQuHlWPcKtpoBM5KJrPqndAmM0gbTBy8B/vdyrMFTG/r1FFsM7eknorewtw/kgSJYfi/KAYFJMM1YnAg6Lm1hEVXCfLQ5Irlfk4nY7uTQl8lJ0liao4wmiWwZP3AsCwjq423IZH+QIUWu435PkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913755; c=relaxed/simple;
	bh=TMHhiKGJhiixMSSefGOX3mKwji8XqB0Qoz5YBH/RdOk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Naln89RWHbBuwr60jT9m812XBHbTFv3iuIBHYTvOWqUsHWzZ8bi2yac0eT+oNWmc0kkU5UU/b4d1ASyTZxP9rztKBPPLCTy17YoRoaWktlhLPJQRPRRztNd4p2yukLoe3rSJIY9xJdM93/R3FKx92Ky34AmLG7DXJN9efWNBXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev; spf=pass smtp.mailfrom=ghoul.dev; dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b=C0nv9J6+; arc=none smtp.client-ip=185.70.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b="C0nv9J6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ghoul.dev;
	s=protonmail2; t=1787913748; x=1788172948;
	bh=4hx4DF9Ze1/WdDlpBQe0Jt7BHNmSlbucflyx8vSRHPA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=C0nv9J6+xnL88keL6RFHxMcwwxw1Rm++AAcHLvRxTaRujUGgRDse+g2iNvzu7epjh
	 93rRptz4dK+kVaTC3+nKp8PMmj0tzOLEpBobGju2HUd5fA2NMWLqObHBeyQMCtx2bi
	 iqVoV80VEfmBJ5esHd1CaQDtZ5z85sRRtulHuSsNolTpwKONkd87NJWRoz7cLXNw8V
	 mpK4IWAsbTpq+eiRBTZyTHQkzpDmG9daxCiNsdtEE/7Yg3h93UJvTxTRGzT5dt924s
	 eWRU/LjF5kXjHD9ROTGd968se3iJGFwkzEq5Agp5YaL+0JTl64yHp01VFUEU2qtZqU
	 1jjYaiIzu1JYw==
Date: Fri, 28 Aug 2026 10:42:21 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Denis Benato <denis.benato@linux.dev>, Antheas Kapenekakis <lkml@antheas.dev>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>, regressions@lists.linux.dev, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ahmed Yaseen <yaseen@ghoul.dev>, stable@vger.kernel.org
Subject: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices with no input reports
Message-ID: <20260828104159.62399-2-yaseen@ghoul.dev>
In-Reply-To: <20260828104159.62399-1-yaseen@ghoul.dev>
References: <20260828104159.62399-1-yaseen@ghoul.dev>
Feedback-ID: 177610485:user:proton
X-Pm-Message-ID: 601481af4ca6df679a1c95ab7ef3110b170d05fa
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

usbhid starts polling a device's interrupt IN endpoint on open
(usbhid_open() -> hid_start_in()). If the report descriptor declares no
input reports there is nothing to read there, so the poll is useless,
and on some composite devices it is also harmful.

The ASUS ROG N-Key keyboards expose a second, input-less interface used
only for RGB control via feature reports. Opening its hidraw node (any
hidraw reader does, including SDL/Steam Input or a plain cat) starts the
pointless IN poll and keypress reports on the keyboard interface get
dropped for as long as the node stays open: a lost key-down drops a
letter, a lost key-up leaves the key stuck. usbmon shows the dropped
reports never reach the URB layer.

The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
asus: early return for ROG devices") is what exposes it on these
devices by keeping the input-less interface alive instead of ejecting
it, so its hidraw node can be opened and the poll started.

Skip the poll in usbhid_open() when the device has no input reports.
Feature reports and hidraw output keep working over the control and OUT
endpoints, so the interface is otherwise unaffected.

Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-strix=
-16-2025-with-cachyos-during-gaming/30823
Link: https://github.com/ublue-os/bazzite/issues/4590
Cc: stable@vger.kernel.org
Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
Tested-by: GameBurrow <gameburrow@pm.me>
Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/usbhid/hid-core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..d7cf2b56e117 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -688,7 +688,14 @@ static int usbhid_open(struct hid_device *hid)
=20
 =09set_bit(HID_OPENED, &usbhid->iofl);
=20
-=09if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
+=09/*
+=09 * ALWAYS_POLL devices are already polled from usbhid_start(), and a
+=09 * device with no input reports has nothing to send on the interrupt
+=09 * IN endpoint. In some cases polling is harmful: on the ASUS ROG
+=09 * N-Key keyboards it makes the sibling interface drop keypresses.
+=09 */
+=09if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
+=09    list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
 =09=09res =3D 0;
 =09=09goto Done;
 =09}

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
--=20
2.55.0


