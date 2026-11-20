Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164059;
	b=DVh8ESfnwlgPpvzNGXubb3Dyn4ghe1+7PKLcZCcg7kXaSvvLOV7CcTGUZt6XTavOrU/B
	 l70mYB6tsQbypEHUBBeQK0zv2wU5ZymL6JNpbpixi9LnDPZwzMNZFuaELyV3KAApkt8l/
	 NZGRdtkJ28H4oO9ZqCqcS5Op89b88fH4MKnNTLR981rfvx6VVEM2r34RkYu83/1Ft6fI0
	 rNHhA/hYGXefzwHTLoieSTFKa/vrmSM3IZi05cWkhZrrN3KqsLUL7+DS5xQLIJjnPF2gT
	 cff8Rh6058HjbILEfQzMoRQDgVGvWh8PvPKIkrOTXAK7vco2p34tpYjKeQrwIoQqWBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=rgy5Vju6ditzf8RwMLDG8EIp/gd3Q1etcgAz1qHp3+Y=;
	b=dM/lQMwa5SDcbdTm8bYvNS+K1uY5/QkwGAeJ15hw3KKk9ac/8Q3NBI4qJgLIiKYlxsOW
	 JvbefP7vjjCsKcabgL0ttVHlhBOVI7pFUuAefidJufYgr6IKWzfomlHHxuVV46q+VYdKV
	 g4iMWu1PrEHMqjUJg04wdRnP9qvvp1O0UPNeyBjMRXNQFVXKWrQEIxWrNYt3W+Iid71gh
	 mgq4SBk4bemmLVnE85iaGgsELguxqg3LmvZVBzfnVgjxQTCnkxcpbPOcI9jXFlAmPDAAd
	 4jvTf9IO6k9hs3t0o9ybIbdWR2LWlnufxyBULAJqeig/Nq0N4NkL4wQh0+0CtHpdQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVEt2lt6;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2F606A339
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B2F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zVEt2lt6
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-380c28f9e35so1660281eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164058; x=1795768858; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rgy5Vju6ditzf8RwMLDG8EIp/gd3Q1etcgAz1qHp3+Y=;
        b=zVEt2lt6j3RSrcMzVrDWhPt37eB4VammH3c6O5mGP6/7MqQwj3QDPk2mo2fzhjy7aA
         /KQo3Ab1IAt7w4ico/AVlo5hxInhIxuN88zBm4HljIlrGtWR2uEA1gAlxKaazlv5b1Gz
         qmQF+tf7a//+Z4W8mT5Bm/O98mUdTlCyg1ge7VEtLCPdZDA91A75BkPJ0ynqLsu/MXJC
         xPe4Pjr3iIqBRbFfzuTqj1iAWRHfVC3nYtpyo16Xo2h08IVs48wQGxH9cFiqxAkFkseG
         cBEcGGF4zemaWuDQevaAU+bFFbQBKPuFXhJD6dnEap9O7V9j2xRYu9dFypkT/kn2qpo5
         UO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164058; x=1795768858;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rgy5Vju6ditzf8RwMLDG8EIp/gd3Q1etcgAz1qHp3+Y=;
        b=tnnLwPllHqQDh8NxzX/L2rL/WgB0Yr+YFLLgJnVWX9+0GhK5XpvGQbosGoYmiMEfAF
         4TRSjqC+9uhdN1GrHCIEl92JzEYLA3iiXSO+TlAVdX5aMZMWbO/HBQUxERJa9g8su7Ry
         wp704rXlfYfhKOwUXhagXBaoKHTzDB0xGWWDdBcl10fKSYFf5Vpb9nI7g2tFJC7qBGds
         dQRnJjP2L3tU1uQhh9KpHrLroDec3QQ087HmcB/d4bSW0RiuIJ5HD41DasuVyOxErfa6
         JW5CjUQfPkEYT7S/RBMH7D8PrQOVuXHjMaVl4IW7OhuY4C9czAA9ushwwfBJysZz5SaH
         6NNQ==
X-Forwarded-Encrypted: i=1; AL+hErF7r8oQVWEjpSlMmK8Fv33KLCro2N9QI3kyoSkmwl4V02nbPpaRsF3GeeF87HrWZQIxb6hlz2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JliWIdq1g1rmXNQIpvaBNqDfxfFm482RsMzK/vdUCp/kLauo+
	MM6hGG/PTNMlb5WbjAvUAgCZhWt8NazMMpFpDCrRq+h7n9u3tp8RsUyi
X-Gm-Gg: AZFdTZe0Zg0j9UslMSO7snWE2Bvm1dNe3WXUteeRUQes43vYSPsPwPOLFSP6bbhA77v
	oEOiblI3mm4D3jxOS++AzpT8B9e6slBj/FpM2Tj5eM3L8QYurbgIVZCM2Fn/lu/DmP00gVdfZfe
	ZGt/erooIaiMA/cQ+sM/PJ9MZiLyFoL6b0YntTU+ub3FLDAacMPP/lJzs+N8Fa3zp8K1A5MuM71
	7kHT2J+ppESTPKMX886iRP0G+/xrcAeWIaEkb6qjdRTXKQeHYbEDDezO9G61xLDUAmTMGhwbVDN
	r7HHm6x+9+n7c3yLoPd1U9Q7M+NWWmQxs7xC0R7BUtCs21xHBApzaA7sA+Hz8X1s9S6btaiUR5o
	9fwcvM6fZsyGRX6XR1kL9ncy2ZB8d6Cc+SFQhWd632yx51hSejEpS50jp49PlZWxQfm7U0cPa+X
	5a1OqJ+B5x5ECSwTdveBSrialdK3vAXSdaWPS/j/5jDbiKHKnOieRLPFI/fnNaJFWz8hb8y+427
	AOXYS2D9qJ0c3O7kOlTP9X3p5fHVYiNX0OtLE1bxIB0kzo/vs7hDqUjs65rBflwue+KAyycbgJ+
	rjvyO6JQhNHpxwf9H5LBe+yRgQhcs1Kp9W3oig820r7q5iR8g3v/av6mSt5okay4wrqOffMOv7Q
	bSVEjvehbhaRL1aRZtg==
X-Received: by 2002:a05:7300:d18f:b0:36c:fdba:ee36 with SMTP id 5a478bee46e88-38570e2a37dmr1891976eec.12.1795164057789;
        Fri, 20 Nov 2026 00:40:57 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:40:56 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 00/14] HID: logitech-hidpp: G920 force-feedback and
 battery fixes
Date: Fri, 20 Nov 2026 00:40:48 -0800
Message-Id: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAJAHAGsC/22Oyw6CMBBFf4V0bUkfpBRX/odxAbTQUaGkxUZC+
 HdbdMHCzSQnuffcWZHXDrRH52xFTgfwYMcI/JSh1tRjrzGoyIgRJiilBBtQ+Gl7mHVrEkwTFlI
 WTdeImhcSxeLkdAfvXXq9fdm/mrtu52RKCQN+tm7ZVwNNud8AqUi6PGdSloILTLEaYHZLHvP2Y
 Wy49EMNz7y1A0ruwA7t/+8FhgnmpCy4rqiSvDkqtm37ACiyhEAEAQAA
X-Change-ID: 20261110-hid-logitech-hidpp-6884bfb6a348
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Per Jiri Kosina's request, the v2 series has been split into this
14-patch bug-fix series targeting v7.4 and a separate 18-patch rework
and cleanup series targeting v7.5. The open-evdev-across-unbind
force-feedback teardown use-after-free (v2 patch 22/33) is now handled
in input core ("Input: destroy force-feedback device on input
unregistration") and has been dropped.

This series starts from Gideon Heinz's report of Logitech G920
force-feedback initialization timing out in v7.3 and addresses several
pre-existing bugs and lifetime races in hid-logitech-hidpp.

The force-feedback and teardown fixes temporarily enable device I/O
around g920_get_config() in hidpp_input_configured(), switch
hidpp_ff_queue_work() to GFP_ATOMIC since callbacks run under the input
event spinlock, drain the G920 FF workqueue before closing the HID
transport on input close, synchronously disable driver work items and
disconnect input devices with device I/O enabled before stopping the
transport on removal and probe failure, avoid storing an ERR_PTR in
battery->ps on registration failure, avoid NULL pointer subtraction in
the HID++ 1.0 consumer keys report fixup, and fix an off-by-one in G920
slot tracking that made the 63rd user effect in slot 64 unusable and
leaked it across reopen.

The transport and battery fixes update hidpp_send_message_sync() to stop
retrying timeouts and transport errors, initialize response buffers
before publishing send_receive_buf to eliminate races with concurrent or
spurious packets, fix HID++ 1.0 battery mileage event parsing and state
updates, properly propagate negative errors in ADC measurement (0x1f20)
queries, mark devices online on unified battery (0x1004) events while
gating 0x1000/0x1004 dispatch, fix K750 solar battery feature lookup and
reconnect handling, and expose and correctly map the charge_type
property for the battery voltage (0x1001) feature.

Note that device removal teardown still has limitations due to how HID
core's hid_device_io_start() and hid_device_io_stop() (via
driver_input_lock) gate both driver raw command/response I/O and
subdriver event forwarding, disabling I/O before .remove() and
hid_disconnect(). For instance, HIDPP_QUIRK_DELAYED_INIT devm-managed
input devices are still unregistered after hid_hw_stop(), and
hidpp_connect_event() publishes hidpp->input before input registration
completes. Resolving these teardown edge cases cleanly will require
follow-up work in HID core and driver input registration.

Thanks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v3:
- Split out the 14 bug fixes into this series for v7.4 per Jiri Kosina,
  moving the 18 rework and cleanup patches into a separate series for
  v7.5 and dropping v2 patch 22/33 in favor of input core teardown.
- Collected Tested-by tags from Gideon Heinz on all unchanged patches in
  this series (omitted from patches 12 and 14 which were updated after
  v2 testing).
- Gated event dispatch in hidpp_raw_hidpp_event() on
  HIDPP_CAPABILITY_UNIFIED_BATTERY so 0x1000 and 0x1004 events are
  routed to their respective handlers instead of cross-corrupting
  battery state.
- In hidpp20_battery_map_status_voltage(), set charge_type to unknown
  when status is unknown, to none when discharging, full, or not
  charging, and to standard, fast, or trickle only when charging.
- Reset charge_type to unknown on wireless disconnect in
  hidpp_connect_event().
- Link to v2: https://patch.msgid.link/20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com

Changes in v2:
- Rebased the series on top of linux-next.
- Collected Tested-by tags from Gideon Heinz for 17 v1 patches (omitted
  from patch 4 where hidpp_remove() was significantly altered).
- Reorganized the series to place all 14 stable bug fixes upfront,
  followed by next refactorings and modernizations.
- Updated hidpp_remove() to enable device I/O while draining work
  items and disconnecting hidinput so in-flight transfers and
  force-feedback teardown can receive device replies (noting that
  complete resolution of delayed-init and transport teardown ordering
  requires follow-up work in HID core).
- Stopped retrying non-busy errors (timeouts and negative transport
  failures) in hidpp_send_message_sync().
- Initialized response buffers before publishing send_receive_buf to
  prevent stale response reads on concurrent or spurious events.
- Fixed HID++ 1.0 battery mileage event parsing to read capacity from
  the correct report byte and update battery state.
- Handled negative transport and timeout errors properly in ADC
  measurement (0x1f20) queries.
- Marked devices online when receiving unified battery (0x1004) events.
- Fixed K750 solar battery feature lookup and reconnect handling.
- Exposed charge_type property for battery voltage (0x1001) feature.
- Link to v1: https://patch.msgid.link/20261109061103.2887636-1-dmitry.torokhov@gmail.com

---
Dmitry Torokhov (14):
      HID: logitech-hidpp: fix G920 force-feedback initialization timeout
      HID: logitech-hidpp: use GFP_ATOMIC in hidpp_ff_queue_work()
      HID: logitech-hidpp: drain G920 FF workqueue before closing transport
      HID: logitech-hidpp: disable works before stopping transport
      HID: logitech-hidpp: do not store ERR_PTR in battery->ps
      HID: logitech-hidpp: avoid NULL subtraction in consumer key report fixup
      HID: logitech-hidpp: fix off-by-one in G920 force-feedback slot tracking
      HID: logitech-hidpp: do not retry timeouts and transport errors in hidpp_send_message_sync()
      HID: logitech-hidpp: initialize response buffer before publishing send_receive_buf
      HID: logitech-hidpp: fix HID++ 1.0 battery mileage event parsing
      HID: logitech-hidpp: handle negative errors in hidpp20_get_adc_measurement_1f20()
      HID: logitech-hidpp: mark device online on unified battery 0x1004 events
      HID: logitech-hidpp: fix K750 solar battery feature lookup and reconnect
      HID: logitech-hidpp: expose charge_type property for battery voltage feature

 drivers/hid/hid-logitech-hidpp.c | 150 ++++++++++++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 43 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261110-hid-logitech-hidpp-6884bfb6a348

Thanks.

-- 
Dmitry

