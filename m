Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503053;
	b=h0KBkkHM7CyBSxisivKItUPznXZZtoW1JGyBfBjqVwfb48PdVg4ko2aYRaeyWK5Tk2mN
	 jYBqK1iK1xNZ+1l0q4ThmoNmkDgJl10GHoUhAox3+hOVO4hEb+0CJGXuL1y7MRscP3hcF
	 UxRqq5sUaR4Ar09vGVImQb1au665JT5cpzobx/54mAIt3S9S5VSw+HTjXa9fd8oG74O8n
	 kYIpqmyRTRvB10ziOc288+WmU7j4Ruwg8ZCefksojSnm2HvKQ+upfMQfeZf5c9akUusHr
	 aMdZDifr04OYVL3zSbA6nGVpzMYniqvkqy4TXox683q5Ltq7kbP659+S1bSh3Kml+dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503053;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ESoHVz7AZTa5EVNN5T+aPazedHc4CD5AOeW7iz5qXwo=;
	b=jHgbh76IhY+Z1w2NqDI94B5cT1f4zgVWFYuLk4o1bklI9Jfi0VxA+ySr3KT727q7F74F
	 4zNy2eXIbqT2s7e4EgVrdSmp0MvHEmcUgCqVT8gPAtGgoeaUQDbpP1EGSAcowZOVcrXON
	 lId9rdyP4at/TOdEbIjE3clKSD7r8FfGPGUToseRaW0sMy8M9Fo7KsMakLgnuAoDepZ/p
	 6/j3QtsH5EwkjfzzmBFRbYw7JGwOpwLJJUwgBoa67WCIleWlv1n0Zyp11C/P7wHwJw6A7
	 7pbp825OyzIjDsy+L7YNtPzy9wyADZ36vyn0CEdEErApxoyfLOHQlKxTt/2mhUdw19w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h14oUdPo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3B606A322;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h14oUdPo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503053;
	b=R14Ps0vi+2q0Wm/L5AS+Q2zhPmT9q7Vwtv9JflaVYwFpL7h0TbeGC9H02/JX3J7DnuKI
	 ml6apPUnpu1BveAZP8mIlAAk/30BWKk6T6KlPRfpQfqqiqcu9zrTuE2gxGzOL+T5bUdOQ
	 0uL+567LACBCFsQthMb7Xz7chgwvUIsYMFI+evrnifXl8yvqLl0bGKXkv3w4349iktr7o
	 DDNBA2Kj4ICVupgLKy4LlmiLOhhliJu2MN5K/Cr9bqRlo42jv55U9NzyDsBcJoe091MLO
	 Pi/oC36urRH5YjQfyvmns4Wi7jAJPgvvlPDgefIcitqiBrJGQETBxKS529nJsg13wNg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503053;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ESoHVz7AZTa5EVNN5T+aPazedHc4CD5AOeW7iz5qXwo=;
	b=mR/lqNlun1HSVJYqv/nkmowGuDfcXLBuOq00seA22W0iLmMh3MOvg/hnKjrQHOXompUj
	 QaCoHqSNaf5fZP6nLImv5+N7xOFfImKIbRIiEzxIfz8y2r3f9dKnKwGw1AN087dCkJPgv
	 fyyFib5FOJBVcRjy2MFfLVoNUKuXzmTap18LdBqgCriAOeAoZ+DOCvgaWl+/P2/Hcs9cT
	 Cp+aEsPj60+Y67D6VZ6hO5XP+eC0fcpK0BPaC0vDbL2fEpjrzgy8PakOvj1CIGwdyIZaL
	 pRmCos5nsa+mHSZ1nkcxIJhtoJReF28F6cA18W4KkyC4hnMRDKepWEPY4StNZfs3+LQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EAD31F000C5;
	Tue, 20 Oct 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503053;
	bh=ESoHVz7AZTa5EVNN5T+aPazedHc4CD5AOeW7iz5qXwo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=h14oUdPoRtfgL8U7obcYeyWtoVD1EggxYMRjMqnk/hl+M2tNxWnBMVgfi2NzCrT4G
	 qZyKqCODbm64tZhGlzjVAS3M04dPn9Ky8kegRmK1SBw8utsAfhrEdk9ux4JiY/GNrk
	 DgktpU8IoB0hDEuwHj9hQOD0Z8BEyWfZqdmwIIbtaL65pOqI8B7qlr7wFapR3heIwR
	 4IjoslVjiTM3pxyJw+98eOckPjD6wc5wpBn1oEeowLOPt2B4qmmDrJu6AOHVXHObq0
	 gGTLt6YPDvRutaW/W5AlmojjdyDVJ/pyhzeiK9B0I9dGWQ7FXQd7oMS0QbIrliukWC
	 ng58H5g19U2Fg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F0EB43178;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Subject: [PATCH v5 00/10] can: peak_usb: fixes, cleanup and input
 validation hardening
Date: Tue, 20 Oct 2026 15:30:39 +0200
Message-Id: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NUWvDIBQF4L9SfJ5DjdmNe9r/GCVc9bq4dmnRN
 LSU/Pdpx6CwBvZ44JzvXFmmFCmz182VJZpjjoexhPZpw9yA4wfx6EtmSqgXKQRwh2PwvRvI7fr
 aGGnfR3/mqD2gREkEnpX1MVGI55v8vv3J+WQ/yU2Vq40h5umQLrfrWdbe70u3+jJLLrjAxtpOB
 U3CvB0Jdzxf8kRfzyGxejWre8ysY6pgASyAMsqAkQ+x5g5TYh1rCgbaS3AttsbQQ0z/E9MFs8F
 66mToLNo/2LIs36s9rvi8AQAA
X-Change-ID: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=4489;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=wZ2HZ+zMm5V2T6Bd7WCF/RbuqkDZvPvZrcAS0O2FTlQ=;
 b=63l4J/Z1VkV6vWFD+ni/7D26oAsb/49pmdXqiRsQ9j3qoLbxGLNiBwOaSifmywefd3M9i6MDE
 4a05HEUuUx5BdXpomFE6q2gJ+enxl9fLK16wKA1YbhGbVZYhto0Sjx9
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr

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
the same channel slot check in the PCAN-USB Pro driver, the netdevs
being registered before their channels are initialized, and the dump of
stale RX buffer bytes on decode errors.

---
Changes in v5:
- Register the netdevs only once all the channels of the interface are
  initialized, since they share resources during the init of a sibling
  (patch 9).
- Link to v4: https://lore.kernel.org/r/20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr

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
      can: peak_usb: register the netdevs only once all channels are set up
      can: peak_usb: only dump received bytes on decode error

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 51 ++++++++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 91 ++++++++++++++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 16 ++++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 96 ++++++++++++++++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 29 +++++++--
 5 files changed, 201 insertions(+), 82 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d

Best regards,
-- 
Stéphane Grosjean <s.grosjean@peak-system.fr>


