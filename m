Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538728;
	b=Zjqri7fvkw39qdgLxdElG/wSKs7+KGKoPLOQG6QkbXQ/lj4YSkbe+gq+4p/E6sN0bYUE
	 aS2xB1wTCHTVnUn10XEKjn/n+9J26zPczRtTf5TvdVcEJvvpmmqs2Ax3F5nZVLnTImKMH
	 /W8kaKSK0yQEa2ctVvqCMdSjYx+Wbzo4+DZPm409bfdASPu0vxuydDHlcFyLjYUvX1+To
	 BFpUM8hWFIGETzNU6VxHBbo6jV3qoS1cqQMtpWHW4aQHx/yb4o/2NX7H4nrw6XvlGrX3H
	 Q43JSXFSWKPALiPwq3j2oSgQRw3KG2GWtDi5PQNEXOzCm505CWrmFFtwifBb4w9Tajg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538728;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=nyv4qyKmmJjP5p8S4igRIebh+SCli2h19+peO2noHyY=;
	b=gzqmEGFUL70SsZfqnFW5hj44fwtkeOn6YAP+sMxF/dwm+5T/6mZmb3JP5qyUtbgt0o0M
	 98PABaxbcCtKtr5FKCeQSETY8kTsDykCoSKU1vw6Jriy272a58osFjq3WIKJQr8wdWcQT
	 ru/94+OlzRb/dkn7pSZkkv8S3Gv72QCSbYHBEB9LtIy0WYS2+sz7y+W/Ei+ScT42H0avd
	 Ugsgh+Wr2Lg2ncgTtOBwFq9CriDfpRX0vzGFemG16sEQjW2rUmXi1FCj99LDrftl494dd
	 DgBCcpj8wba2V8bOS0fKq68U9tYG8OrRSrj/z7KDwrJAmsSxbiwlPnJi8pnS95jDqjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=mjpezHqM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43A606A32A;
	Tue, 24 Nov 2026 16:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A43A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=mjpezHqM
ARC-Seal: i=1; a=rsa-sha256; t=1795538704; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PqoW9vEsosk0kWNe8mN/b5cWz13IAD3NV/CfIq16wkKKeOS1TQtUeMItdUcUHeE6+aC1WFewJinRGk6LpXlOb8TYNSK0+yCbrA5iBn8bJ4HStdQQdcpa7D/zWG0wTBuwDqFoDdOBSZyUzhP9VsvajGp5t3oC8kGVWV1DQ1pJWCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538704; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nyv4qyKmmJjP5p8S4igRIebh+SCli2h19+peO2noHyY=; 
	b=WVo+S8VsfugagYmMoeFru00PgL+LOWKhv4UI2qir4qVRkXvbLuB/GZM+hfFlqSp/iZ0c0RWoW9yPMwkBcz6+GIL6TsZQsBH7PmxZJEYj+I72p/Uj5OyevPYlO8yxHsnDy5/lxsY+E9+3eG8r2IqVHQfgEhY7Gi2gyNCsJ018q+Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=mjpezHqM7WgrErdIArXe+3GmEMZ6UhhR8asE/IpDYc7WLymPHyRMrdLtyAXIf7FSKVWDtRswIIiJ1GxOTqdQUiSQhZ0b3ZTKPiJEnxpoLzuF0IvY4q2IkaC+EhcW125kQpvgqUopoRG96KtI/JLWV+nLXTzVbl60wmhyYh/V7OqmJe/IRQnG1EHSc3FYjEKL4UVtWTzbSQza3ZXCPekrWjmZSX0mU5xIUdolZokBIujYHKQiVwFGVOVHLhsGa/LWiUvHuqJI1whx16rsyLosvKq7mn/MNVxvYK129pmk+O4xdJ8Uv+XNPa81L3poKQ3ypV+tXpmzLaoybcCmMdnkew==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=nyv4qyKmmJjP5p8S4igRIebh+SCli2h19+peO2noHyY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538701913519.779254016571;
	Tue, 24 Nov 2026 08:45:01 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v4 0/9] HID: Add hid-plugin framework & convert haptic into
 a plugin
Date: Wed, 25 Nov 2026 00:44:28 +0800
Message-Id: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTQ6CMBCG4auYrq3pHwO48h7GRWkHqQZKWmw0h
 rtbdENk+SXzvPMmEYPDSI67NwmYXHR+yEPtd8R0ergidTZvUoNSCmpNO2dpp8fJGXrvvaUKK1S
 CtRUWLclqDNi657d4vvx2fDQ3NNOSWS46FycfXt+XiS93RDABnDOxqSdOGdXSYgECrLZ4Cn64H
 nqPZIknseKcbbnIvKlkoRmUpgHxx+Wayy2XmWNpW12VAIbZFZ/n+QOzHv8oPQEAAA==
X-Change-ID: 9644469a-hid-haptic-kmod-4e8e420f8e5f
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Recently I am working on adding HID LampArray support for hid-input [1].
I would like it to be a loadable plugin module. While looking through
LKML, I found hid-haptic, which is a plugin-like support code collection
that must be built into vmlinux. Therefore, I decided to develop a
generic framework for loadable plugin modules, so that it can be used by
multiple drivers.

This series aims to introduce the said framework and convert hid-haptic
into the first plugin, as it's easy to convert and perfectly
demonstrates how the framework works. For simplicity, hid-haptic still
attaches to hid-multitouch after the conversion.

Recently, I brought a Logitech MX Master 4 with haptic feedback, so I am
also planning to prepare another series to make hid-haptic generic by
attaching it to hid-input after this is applied.

The first five patches fix pre-existing bugs in hid-haptic and
hid-multitouch that may become more frigile once the former is
converted. The last four patches refactor hid-haptic, implement the
hid-plugin framework and finish the conversion.

The plugin framework is designed for devices with additional HID usage
pages which enhance their capabilities. The support code for these usage
pages is called "HID plugin".

The corresponding HID driver calls functions provided by the plugin to
take the advantage of such enhancements. Without the framework, the HID
driver must have a linkage dependence on the plugin, which is not
optimal because the plugin is always loaded into memory even if no
device actually supports it.

Logically, the dependence should be reversed, i.e., the plugin should be
an optional component of the HID driver, which is only loaded when the
driver finds that the device needs it.

Introduce hid-plugin framework for loadable plugin modules to achieve
the said logical dependence. Each plugin has a unique hid_plugin_id when
enabled, so that HID drivers can request it accordingly. The framework
aims to be lightweight. It loads the plugin module when needed. Once
loaded (or if the plugin is builtin), requesting the plugin is just an
RCU dereference plusing an module refcount increment.

When a plugin is disabled, its id maps to HID_PLUGIN_DISABLED, and calls
to the plugin helper functions are eliminated by the compiler.

With it, hid-haptic can be easily converted into a loadable plugin
module, so that hid-multitouch only requests it on demand.

I volunteer to maintain the framework as well as its plugins, including
hid-haptic and future ones.

Thanks Benjamin Tissoires for the inspiration for the implementation.

[1]: I know Texudo folks are working on adding hid-lamparray to connect
it to hid-generic. I am not in favor of their design, so I decided to
write a new one. In my local tree, I've had an independent
implementation with HIDRAW sniff, autonomous mode as an LED trigger,
RGB/non-RGB LampArray support, per-key LED device support, etc. I will
submit it once this series settles.

Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35inqda3exwzs3tk3ff@oagat6g46zto/
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v4:
- Drop get_device()/put_device() and try_module_get()/module_put()
  completely, as they are needless now (thanks Dmitry Torokhov)
- Drop synchronize_rcu() during registration as other drivers do, as
  there is nothing to protect
- Link to v3: https://patch.msgid.link/20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe

Changes in v3:
- Correct the Fixes: tag of PATCH 4 (thanks Sashiko)
- Add missing Return: to hid_plugin_register()'s kernel-doc (ditto)
- Fix the return value of hid_haptic_connected_to_input() when
  hid-haptic is disabled (ditto)
- Link to v2: https://patch.msgid.link/20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe

Changes in v2:
- Reject touchpad applications with non-force units (thanks Sashiko)
- Only call runtime methods if the event source is the same input device
  as the stored one (ditto)
- Rebase on top of v7.4-rc2 due to the devm_kzalloc_obj() changes
- Link to v1: https://patch.msgid.link/20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe

---
Rong Zhang (9):
      HID: haptic: Get rid of input_ff_destroy() in error paths
      HID: haptic: Fix use-after-free when draining workqueue
      HID: haptic, multitouch: Check haptic prerequisite properly
      HID: haptic, multitouch: Fix haptic device double-free and unnecessary allocation
      HID: haptic: Postpone GET_REPORT to init
      HID: haptic: Convert simple methods into static inline ones
      HID: Add hid-plugin framework for loadable plugin modules
      HID: haptic: Convert into a loadable plugin module
      HID: haptic: Remove stubs in favor of inlined dead code elimination

 MAINTAINERS                  |   7 ++
 drivers/hid/Kconfig          |  21 +++-
 drivers/hid/Makefile         |   4 +-
 drivers/hid/hid-haptic.c     | 194 ++++++++---------------------------
 drivers/hid/hid-haptic.h     | 233 +++++++++++++++++++++++++++++++------------
 drivers/hid/hid-multitouch.c |  75 ++++++++------
 drivers/hid/hid-plugin.c     | 108 ++++++++++++++++++++
 drivers/hid/hid-plugin.h     | 147 +++++++++++++++++++++++++++
 8 files changed, 542 insertions(+), 247 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 9644469a-hid-haptic-kmod-4e8e420f8e5f

Thanks,
Rong

