Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492845;
	b=vigtUGNW1nLcUX27VzK3kh/rLxr8L2YUoKS27+Z450Bw9zYEQ0eFIFJP3hJPbKj5Znk8
	 Q3KEkVvQIn7qy2vXcatn080m33hWqQAkTOivkxHEEU3e6imoFeAnQCqWhEJIVQrhPoMMx
	 GtJRgjWsgYlsJuuUGL0/Faa3Jr1pn2XhPiCqSvib0DW141+upIBUHMN1mJLKxOtRp4Iej
	 1/Y9o4EAHjuu/JqZKCaJ8OzIXGDvHx3p1s0FnYZIhNRFFZBwJtPtjOtFKJtcZP15XDnkV
	 Ibq/BTt+AW95LP9KRqaJIrUTODA1IvPxNcse3ykI7sDdumxUBgtGh5JSwvR0uXvsHdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492845;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=n5EK0ziT9t6q1rI6T9BkNUVCku9SDwzvpj86BSyOcUg=;
	b=yAA1DSE7Dn6P7u7i8bwcJ52PBp3OD6ssoFWwfTtP2RnZWKr0fZwQOda4kmb6QyJPSlX4
	 vhDV0sNme/nZuPOqrCkZc3sliKHVilhtVqnQ44xt7T1PLC5owVEwSj++0oKEmWTo72ppo
	 4w2hM9LTqGoVqx5StneWfsDTYWlhMDdGcKgL8xRhiOTWwlP3M2b7LWM4aiItzttMx1tRg
	 0t226d9juqCPUZyQMSO1We+ORA3HmS99lMFODUH0CrfEk7TO0nPF0RQd+guOyXSJjYcFL
	 eQdgeDXOfYVOnQqQJBk7yPP7uCrdA7t1QMn7bMVIi4ZHzsxMUqXrIS3REQ2Di73wTIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=FTzVZRTC;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893E606A31A;
	Tue, 20 Oct 2026 10:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A893E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=FTzVZRTC
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id CF4B3780316;
	Tue, 20 Oct 2026 12:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492842;
	bh=OcGHRTOxPh+n4knMtjMfIiF/9+USpuNlAmnTEgR4g0k=;
	h=From:Subject:Date:To:Cc:From;
	b=FTzVZRTCqbfANl9T2vgl+iQmcsvQD9HgTMBi8jT6+313VbB1qxVB/+LqJq4NGpY7T
	 KwQ3u5raUKatm77WRlRSTdH0el38EPWYfAINazok7VoQ54zZkLJ4Ckt+yeuIz6QtVb
	 e/x2cnvOSk5gxwYfKenDZ8r+TZl16wv7B2cnRNZNKWlG7bsk8aXAQmYUtbtJpLb3xf
	 5gitZyzpf9f0k4TrcDhex9/7a85N24yVx8djIH8GfN9Wiu0LQ8rigoKD0r0z1uiE/X
	 dcot1gohtY5XF8STmbyyvDxg/Gop3PHtiXdhqzNV33bd7VZd+7GELQpzWYa6ktyrox
	 DxYtkOiXDGbcg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Subject: [PATCH v4 00/10] can: peak_usb: fixes, cleanup and input
 validation hardening
Date: Tue, 20 Oct 2026 12:40:15 +0200
Message-Id: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XN0QrCIBgF4FcJrzPUrf7ZVe8RMZz+NlttQ9coY
 u+eFkFQuzxwznceJKB3GMh28SAeRxdc18aQLxdE16o9InUmZiKY2HDGgGrVWlPqGnVTpkaL59K
 ZG1W5AcUVRwRD4rr3aN3tJe8P7xyu1Qn1kLjUqF0YOn9/XY889T4vxezLyCmjTGVVVQibI5O7H
 lVDwz0MeFlZT9LVKL4xOY+JiFmoAIQUEiT/i2VfmGDzWBYxyA0HvVZrKfEHm6bpCcdRvxdvAQA
 A
X-Change-ID: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series contains bug fixes, cleanups and input validation
improvements for the PEAK-System USB CAN drivers.

Patch 1 fixes CAN error frame generation, where CAN_ERR_CNT overwrote
previously set CAN error flags.

Patches 2, 3 and 5 are cleanups: make a public header self-contained,
sort the CAN_CTRLMODE_* flags in ctrlmode_supported, and replace
open-coded bitmask operations with bitops. Patch 5 also makes the
state flag updates atomic, which patch 6 relies on.

Patch 4 adds bounds checks to the PCAN-USB RX parser, so that
truncated or malformed records are rejected instead of being read
beyond the received data.

Patch 6 validates the channel numbers received from PCAN-USB FD
devices, rejects records for channels that are not set up, and stops
RX on all channels before they are released, on disconnect as well as
on probe failure.

Patch 7 fixes the RX parsing of self-received RTR frames with SRR set,
which left the RX cursor one byte behind.

Patches 8 to 10 fix related issues found while reviewing the above:
the same channel slot check in the PCAN-USB Pro driver, the netdev
being registered before its channel is initialized, and the dump of
stale RX buffer bytes on decode errors.

---
Changes in v4:
- Register the netdev only once the channel is initialized, instead of
  only reordering unregister_candev() and dev_free() on probe failure
  (patch 9).
- Link to v3: https://lore.kernel.org/r/20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr

Changes in v3:
- Fix out-of-bounds read of the error counters in PCAN-USB bus events.
- Harden channel handling in PCAN-USB FD: publish/read channel slots
  with smp_store_release()/READ_ONCE(), clear them on teardown, stop RX
  on all channels on disconnect and on the siblings on probe failure,
  and reject ndo_open() once disconnected.
- Fix RX cursor desync for self-received RTR frames with SRR.
- Replace open-coded bitmask operations with bitops.
- Add channel slot checks to PCAN-USB Pro.
- Unregister the netdev before dev_free() on probe failure.
- Only dump received bytes, rate limited, on decode error.
- Link to v2: https://patch.msgid.link/20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr

Changes in v2:
- Kill all pending RX URBs before unregistering sibling netdevs.
- Reject records targeting unavailable channels during device
  initialization in rare corner cases involving malformed device
  input.
- Link to v1: https://patch.msgid.link/20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
To: Dan Carpenter <error27@gmail.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stéphane Grosjean <s.grosjean@peak-system.fr>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Marc Kleine-Budde (1):
      can: peak_usb: add missing includes

Stefan Günther (1):
      can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters

Stéphane Grosjean (8):
      can: peak_usb: sort ctrlmode_supported flags
      can: peak_usb: harden PCAN-USB message validation
      can: peak_usb: replace open-coded bitmask operations with bitops
      can: peak_usb: harden channel handling in PCAN-USB FD
      can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR
      can: peak_usb: reject records for unset channels in PCAN-USB Pro
      can: peak_usb: register the netdev only once the channel is set up
      can: peak_usb: only dump received bytes on decode error

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 51 ++++++++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 68 ++++++++++++++------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 15 ++++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 96 ++++++++++++++++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 29 +++++++--
 5 files changed, 183 insertions(+), 76 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d

Best regards,
-- 
Stéphane Grosjean <s.grosjean@peak-system.fr>

