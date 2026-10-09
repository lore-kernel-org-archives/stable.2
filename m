Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED840E8D7;
	Fri,  9 Oct 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531091; cv=none; b=RerH3EuL3BQ9HhKPpdpO5F2X2ePbQmIzF9O6DyRwabJWNazcfiRxi9Hex2lhiZSRjWVrZPCA4NuSjnnsz3qb4lpLfEEGu6umMmul25vdtJvgm/r81NKZtPU9WgaakzJwttXHEbG+JIqvXgIQLV+b+TeXncA+QO6OMBkC3OxXdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531091; c=relaxed/simple;
	bh=Lpz0OuDyaABt8DrFda/UNnzr2ftGZ9uexqEzGQRiEDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z0ZhzuO+v+A4uHdauN1ifM3AuIzsanOgJ5Pa9+eqA2EH1MmyPkhF+2C8EmjgTjL9ryWppIzDKENVQvj5IPX0v7pxsGKGKMHkhS/p4CfMcy+VV7tA85JaGNLqdvrnDhwi4w22MCuX49FUnRBuo3s7PaR6InetkiuSLXy2XdpZe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=aNQ2QDS3; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="aNQ2QDS3"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 706AD780371;
	Fri,  9 Oct 2026 09:31:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791531085;
	bh=Lpz0OuDyaABt8DrFda/UNnzr2ftGZ9uexqEzGQRiEDU=;
	h=From:Subject:Date:To:Cc:From;
	b=aNQ2QDS37ohNrWmj2PIvD9ZpmUNRrHB+hvncCq1pdU+b0Je263STE3o+vM+VzxfVd
	 g/Pqi7gThpLZvgFRDlf5HFIzWQndrKt/3WjlFY26Sox7f3OK/eMav4L5KVo/AO/wUS
	 tJqwp2WAh0oKNd6v3M11aCz15LPHDtnrdcQZFPe3bepNI6YrYJAfcED7j3zEpllPIC
	 UL/WodtaDxeF0RNB8Pdek5dseCN8cz5UCxe+eqFMEDuhgSX3HVwOzlEUImI+6ujRbf
	 zKrCJkVvJC4nxqasAvJ7TIb/bSk/q0iqBBGZPGLNf8kMjF77sJvkOe2w5WQR6PSYe5
	 r6k2wnW2dNEmQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Subject: [PATCH v2 0/5] can: peak_usb: fixes, cleanup and input validation
 hardening
Date: Fri, 09 Oct 2026 09:30:27 +0200
Message-Id: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABOYyGoC/3WNwQ6CMBAFf4X0bE1biaAn/8MQsrRbqUghXSQQw
 r9LMR49TjLvzcIIg0Ni12RhAUdHrvMbqEPCdA3+gdyZjZkS6iyFyLgGb02pa9RNGQ2Pr9KZiUN
 qMpAgETPDtnUf0Lppf74XX6Z39UQ9xLto1I6GLsx7epTR+1Xyv5VRcsEFnKoqVzZFcbn1CA2nm
 QZsjzawYl3XD4i58IHVAAAA
X-Change-ID: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

This series contains a mix of bug fixes, cleanups, and hardening
improvements for the PEAK-System USB CAN drivers.

The first patch fixes a bug in CAN error frame generation where
CAN_ERR_CNT accidentally overwrites previously recorded CAN error
flags. As a result, information about previously detected error
conditions may be lost when error counters are reported.

The second and third patches are cleanup changes. One makes a public
header self-contained by including all required dependencies, while
the other reorders CAN_CTRLMODE_* flags in ctrlmode_supported for
improved readability without changing driver behavior.

The remaining patches strengthen validation of data received from USB
devices. They verify device-provided CAN channel numbers before they
are used as array indexes and introduce additional bounds checking
when parsing received message buffers.

Malformed messages are now rejected consistently, preventing possible
out-of-bounds memory accesses caused by corrupted or otherwise
untrusted device input.

---
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

Stéphane Grosjean (3):
      can: peak_usb: sort ctrlmode_supported flags
      can: peak_usb: validate channel numbers in PCAN-USB FD
      can: peak_usb: harden PCAN-USB message validation

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 29 ++++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 +++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 ++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 84 ++++++++++++++++++++++------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  3 +-
 5 files changed, 104 insertions(+), 30 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d

Best regards,
--  
Stéphane Grosjean <s.grosjean@peak-system.fr>

