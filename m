Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC103C76A6;
	Thu,  8 Oct 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451472; cv=none; b=sWtmPgBVQP2eq59IaGHtIsuKysi2SfvjLa0WPzjQxBRRxbe9yvToaKD3/NYKycZ8qHvP64x4pnQyLf5CUrDmhJTN1sq3JSLBLAeBhtvkZZjh6UueqaW1SX7rIWGUGGgzICYZTtBEs+aQ5kbN8mJ0PG8fLr2bm8K0XnefhoWJb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451472; c=relaxed/simple;
	bh=aw4MigMksMLf+GRLWNC3ifo3LsDUjeq27D4fKEpDdMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MEnA/iDksBnEPOO/DHTuHg4fUgQ0Zl5MDwOkk64eKfvQVNWpQHx4NmurBLHHczwfJHswJKXfnS/in4WZ4AJSq5f6UW878cFtc8wjMUf6r23wu1R7BfTQlL8xDA1HCpswEMplTKQa9smHNimZCiI4wuAavTet42y2+aEbuWswvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fcv17w/A; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fcv17w/A"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B8D1A78051B;
	Thu,  8 Oct 2026 11:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791451466;
	bh=aw4MigMksMLf+GRLWNC3ifo3LsDUjeq27D4fKEpDdMs=;
	h=From:Subject:Date:To:Cc:From;
	b=fcv17w/A1rjfcUgG36/QpgsYZGcaxbMTLLr5tbqz+WYbRcC/xeTqdgSAUj/Glj0m7
	 biJs7wM0x69mLXxmN+w5h6Zbu1nFsAZ9TybX2JduX43QZXrTiheUlRRD5q+lfIOBmX
	 Vud+fGgydeOq5fmx2WQ1m82qJ+/mA41NgTkrfkh1bPqqANM7ulZS/zRDo8ftuVv22b
	 a4apiSVxckwpzB2bBMC33q8Sbuo7mVgMhe4SSFZWIi2ab0OTo8BdqhRgz3RsMxObIB
	 DZlU+hwt05RfgBp40Ttr40ahIe9XSFW+RxjFvjm2RF0PiAWLdvRCXu7QGtfsB201TV
	 stbTuzgn4OEBw==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Subject: [PATCH 0/5] can: peak_usb: fixes, cleanup and input validation
 hardening
Date: Thu, 08 Oct 2026 11:14:54 +0200
Message-Id: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA5fx2oC/yXMUQrCMBCE4auUfTaQFDHgVUTCuju1qxIlqVIov
 bupPn4w8y9UUQyVjt1CBR+r9swNYdeRjJyvcKbN1Pv+ELyPTjgPmmSE3NO2yHgk09nxXiMHDkB
 Uau9XwWDzr3w6/13flxtk2nK0rl96Ski6ewAAAA==
X-Change-ID: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
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

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
Marc Kleine-Budde (1):
      can: peak_usb: add missing includes

Stefan Günther (1):
      can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters

Stéphane Grosjean (3):
      can: peak_usb: sort ctrlmode_supported flags
      can: peak_usb: validate channel numbers in PCAN-USB FD
      can: peak_usb: harden PCAN-USB message validation

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 29 ++++++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 +++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 64 ++++++++++++++++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  3 +-
 4 files changed, 73 insertions(+), 29 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d

Best regards,
--  
Stéphane Grosjean <s.grosjean@peak-system.fr>

