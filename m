Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF563DB65A;
	Mon,  5 Oct 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206912; cv=pass; b=T3QsKhjzLlHRDOWDSF7hxbGVs/5Wlma0z8ExGe11/+C0sBlr6/VdsFzb72w4VxcTVKPo7ObcAbDi3u8Z1Bk8Nw2KeOU4w3kl2qm07xfqApsM9Z8gkQqf2hlbPA0GdC9GqvretjWnOG9NA9Ef5Eox9mao/3kfo9MCGSH4UoKwzho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206912; c=relaxed/simple;
	bh=qblQEc9bv3zS3PbOKKlp6Dqadq1oJleKof+0/JVLdtU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nAqXJYaFUmVdF8qJR3hYUlD8hCe2nQC3ECTga7Ihsx1Uf02LAU3/hHv1mcxGcHX+WR8MUD3ng9pmIUQtGwx5CxQmOvawAhexUSIhjaWdFlR+gHioaxqlDuk9OFwnpUzHNfdgr8lV6ad7vOe8XHPa7EhgPfI2xBJ3YLA3RIeyayQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VO4ifw70; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VO4ifw70"
Received: from [127.0.1.1] (unknown [IPv6:2a02:560:5ca5:d100:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 23399201F18;
	Mon, 05 Oct 2026 15:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791206902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3V8N820IBJDGfbEgp90WfrzITJ46pVVuhCieemYPhLg=;
	b=VO4ifw70ourzOesQ5JGipadJCljNFfrgfxyRCvgw7cZ9Kisgy0On6jzSuIcwI1EeVHIwFo
	qM4LbOZlgBGx7InEJBuNS5mJP3OuO89kstamEO/Yb2/hYESAUzebbh2jRCzH6bPpvWTy3w
	L8U88CBWmOWxrZbxChC5R1R1WouCKnHFLIv25qUIdKih+7853YXwPzMGQviKLQHR1FS03x
	RQ1OUdNu53uHpfWOieayk9576YRUD98IIi41HUwLUH0zltR+TTMTrpuCDPpz4ZkvTevGfv
	xKVOqwCfwvaHau5eBOMBi/DzxS3eZxVHQtKyv3HsU8q159Y5LRtIM0DCKomYaA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791206902; a=rsa-sha256;
	cv=none;
	b=H2NNEmXsAKn2urjPJyvOoUBMusy2Kft7lPz5m2qLEwUWSJHMhkZwzz2GlcwPRoXr2p5Ox9
	agXU5VFmIlgSBTFMODTdKNl+edwx7DERWMiZ5FgyCTQF1Jo545CzKShkqv+O7GaBZtlir9
	ewx0lCIHutT3ls15UzPwltMAALHJ11GpsoMM68t8RipLbL+gQHBRFSqSu8VsEEGs2fBw+3
	hTkuqJj5AvnvJaz81lQdckvPy3LzFEnAmhsKRkdlAJCjOl425ZQeYCz3FFr7oE/Q3N0GF5
	IrhqWVd4aWpFIbEFlApSJ1X8pVY5wfy39medtEXRS5XgDp/wKOPc1t7oCX+/Ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791206902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3V8N820IBJDGfbEgp90WfrzITJ46pVVuhCieemYPhLg=;
	b=cHXKUTURy9udSvWlAyUl/Y10j62K+gIgeVmtjs8pivrVHYpvPCfOWCrmIjgOrbYPR97O4G
	aKJeSl1//nn+4HGlzpJoP2RK563kgTCiLarbWN0AHTf4AySYtqR7MJJzksXSeStK48J2ZW
	oxDkh9SaioSSl/Q1SpICa/wOp+hy8NCf4PU7q9onLCsAtxmuYsMtiE3mc8+mxRiWE35/x3
	E3FeaqeYwwhqVsCKxfvFt7gicK9x+yhac5NlAptMocfGWvcWG28Bz+tBYlUBnxXSnG9cN3
	aAKW0/tJ4N2/qLYgLnZM9chktvguvdqr2V7xEASmqOj/mVgOpXngn+mJeZcKCw==
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 00/10] media: synopsys: hdmirx: support an HDMI bridge
 in front of the receiver
Date: Mon, 05 Oct 2026 15:28:19 +0200
Message-Id: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSlw2oC/2XOyw7CIBCF4VcxrMXA0It15XsYF1CGdha9BCqpa
 fru0saFl+V/kvkyCwvoCQO7HBbmMVKgoU+hjgdWt7pvkJNNzUBAISqR8dZ25GfeoSXNHZZoqhw
 MGGTpZPToaN652z11S2Ea/HPXo9zWNwTqG4qSC45a2bK0mc6duo7YN4/JDz3NJ4ts0yJ8Cj+vR
 EhCLcEVmbRnI9yfsK7rC7/Jm63vAAAA
X-Change-ID: 20260904-hdmirx-media-fe7eb952b2be
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>, 
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: Gerald Loacker <gerald.loacker@wolfvision.net>, 
 Lucas Sinn <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206902; l=7004;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=qblQEc9bv3zS3PbOKKlp6Dqadq1oJleKof+0/JVLdtU=;
 b=uC03mHE508WVCfhlOUg/G3KjWm3ipnXVAXGlyoGkOdy8s/T9YRs0bnMolgkXUjrk7ENBNmgXt
 DXj+T2PHnH7CiQ8FT80kjQeJjEO2LM9x1yWODR1qj4Lv53uEPnI2aso
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

The Synopsys HDMI receiver driver assumes the HDMI connector belongs to
it: the connector's +5V line arrives on hpd-gpios, and there is nothing
between the source and the receiver. On the board this series comes from
that is not the case. An HDMI bridge owns the connector, the receiver
sits behind it, and the two are described by an OF graph endpoint.

Three things follow from that, and the series is arranged in that order.

Patch 1 comes before them and is a fix for the driver as it is. The
driver data is devm allocated, but an open file descriptor keeps the
video device alive past unbind, so the last close works on freed memory.
The media device the series adds would have been torn down the same way,
which is why the fix leads the series. It stands on its own and is
marked for stable.

Patches 2-3 give the driver a media device and register the video device
as an entity with a sink pad. On their own they add a graph with one node
in it; they exist so that there is somewhere for the bridge to appear.

Patches 4-5 add the endpoint to the binding and bind the remote subdev
through a v4l2 async notifier, linking its source pad to the receiver's
sink pad. Such a board cannot provide hpd-gpios, so the binding requires
either hpd-gpios or the port. Without an endpoint in the device tree the
driver keeps working exactly as before, so boards wired straight to the
connector are unaffected.

Patch 6 is fallout from the wait for signal lock, which was bounded by an
iteration count whose duration came from the 5V debounce it called
each time round. That debounce goes away on a board with no hpd-gpios
later in the series, so the wait gets a real timeout first.

Patches 7-10 are the 5V state itself. Patch 7 stops probe requiring an
interrupt for hpd-gpios. Patch 8 makes v4l2_device_unregister_subdev()
wait for notifications already in flight. Nothing kept a subdev from
notifying a v4l2_device that was unbinding it; that is not new with this
series, as asynchronously bound subdevs sending V4L2_EVENT_SOURCE_CHANGE
race the same way today. Patch 9 adds V4L2_DEVICE_NOTIFY_RX_POWER_PRESENT,
and patch 10 has the receiver set v4l2_dev.notify and take the state from
whatever is bound in front of it. The notification is only an edge, as
the 5V interrupt is with hpd-gpios: the hotplug worker then asks the
subdev through g_input_status(), so nothing is cached that could go
stale against bind or unbind. Without a det_irq there is nothing to
disable across suspend and remove either, so patch 10 disables the
hotplug work items themselves instead of cancelling them. Patch 8 is
what lets the notify callback read sd->v4l2_dev while the subdev is
being unbound.

V4L2_CID_DV_RX_POWER_PRESENT is otherwise the only place this state is
published - adv7604, adv7842, tc358743 and tda1997x all set that control
from their cable detect interrupt and stop there - while a format change
already gets an in-kernel notification through v4l2_subdev_notify_event().
An earlier version of this series hooked the control with
v4l2_ctrl_notify() instead. That reaches into another device's control
handler, and the only thing it bought was working with those four
drivers unmodified, which turns out to be worth nothing: they are HDMI
sinks, so none of them could sit in front of an HDMI receiver anyway.

Nothing in tree sends the new notification yet. The driver for the device
on this board does, and the alternative was a mechanism that no in-tree
driver could have used either.

There is no in-tree device tree using the new port yet: the board is not
upstream, and the device in front of the receiver, a Lontium LT86102UXE
1:2 HDMI splitter, has no driver upstream either. I would rather send the
infrastructure for review now than sit on it until the board lands.

Tested on that board, and build tested for arm64 at each patch with W=1.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v3:
- new patch 1: free the driver data from the v4l2_device release callback
  instead of devres, an open file descriptor keeps the video device alive
  past unbind. The media device cleanup Sashiko flagged on the old patch
  1 was the same problem, which predates the series (Sashiko on patch 1)
- v4l2-device: wait for the SRCU grace period on every subdev
  unregistration, not only when the v4l2_device has a notify callback,
  as the reader dereferences v4l2_dev either way (Sashiko on patch 7)
- Link to v2: https://lore.kernel.org/r/20260924-hdmirx-media-v2-0-c12f641d8b0f@pengutronix.de

Changes in v2:
- dt-bindings: squash "add the source port" and "make hpd-gpios optional"
  into one patch and require exactly one of hpd-gpios and port (Conor)
- dt-bindings: drop the OS-specific sentence from the port description
  (Conor)
- hdmirx: take graph_mutex around media_create_pad_link() in the async
  bound callback, the media device is already registered (Sashiko)
- new patch 7: v4l2-device: wait for notifications when unregistering a
  subdev, so a notification cannot outlive the unbind of the receiver
  (Sashiko on patch 9)
- hdmirx: ask the subdev in front for the 5V state on every notification
  instead of caching what the notification carries, and disable the
  hotplug work items across probe, suspend and remove instead of gating
  the workers on a flag and cancelling once more after the notifier is
  unregistered
- Link to v1: https://lore.kernel.org/r/20260923-hdmirx-media-v1-0-ea3d77d4a5f3@pengutronix.de

---
Gerald Loacker (6):
      media: synopsys: hdmirx: add media device infrastructure
      media: synopsys: hdmirx: add media entity for video capture device
      media: synopsys: hdmirx: add async subdevice support
      media: synopsys: hdmirx: give the signal lock wait a real timeout
      media: synopsys: hdmirx: skip the 5V detect interrupt without a GPIO
      media: synopsys: hdmirx: get the 5V state from the upstream subdev

Sascha Hauer (4):
      media: synopsys: hdmirx: free the driver data when the last user is gone
      dt-bindings: media: snps,dw-hdmi-rx: add a port for a bridge in front
      media: v4l2-device: wait for notifications when unregistering a subdev
      media: v4l2-subdev: notify the bridge when the source power changes

 .../devicetree/bindings/media/snps,dw-hdmi-rx.yaml |  21 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |   8 +-
 drivers/media/platform/synopsys/hdmirx/Kconfig     |   1 +
 .../media/platform/synopsys/hdmirx/snps_hdmirx.c   | 355 +++++++++++++++++----
 drivers/media/v4l2-core/v4l2-device.c              |  42 +++
 include/media/v4l2-device.h                        |  15 +-
 include/media/v4l2-subdev.h                        |  12 +
 7 files changed, 386 insertions(+), 68 deletions(-)
---
base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
change-id: 20260904-hdmirx-media-fe7eb952b2be

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

