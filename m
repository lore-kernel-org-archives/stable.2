Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487349;
	b=RBDa8EvKenHlU2gDgETCMKH8YO96Fx7XCRAHYSz7vctWYft4EPZ18ME0PAjY5/k6X8pu
	 m10/6XqiOXqMrYv0ba7UNC3l8Wav0Y2rvAacmRzDtEdkFz2RmySRowPQThDYpS+8c6yue
	 DriqR0L5kDwrHFV7vBFWHgGjsS9NeZ0HMvR2LRBTbPXYvnQpmiWh7toxbhN1ryo3Y3LHp
	 8KuJPaPy/gTOBznDBR6MP5xadHHdoTE/eqyXfLyw4eOAJPjNu94tiznTm9Wq/CRsTIVtD
	 RbBjDP6nXWI8ksa43pAjLnJQDPxWZnT7pu6ewuDYunSFp3cIEi3FGGsRAI3iY82yCyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487349;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=hDi/RCUNS7mRKFhCXheAPCIsHg3hFMeRfEsj8Ev4PJo=;
	b=44/4Xk09J3uxJdh2yTIJziADAep9yleFiv7EqCOLr+kj2mTpzCjgQ58pEogAJi3xtKDQ
	 cPVW+9r1YkJAnH1avsE36/pbGQ8QPz3v+MKoqdVBgCbpdzEQuakl8QllPqx8scqk7lp/i
	 CeCkeuhRg6R57zNVxAO0j0oKgyBu9V+es+wgn1gVUHuLinDsi4GbogTkwL4XrzF5y2Wx2
	 nLlos1mgy6+UxeZ8WjrwlEn86pBcnSGxFFVNPaGZzJGSKGf4OrMYMC8UdsIGbfvMLrld4
	 nZfs4ZOQKl10fGDHAqKG9G1LwUU/qxsMDoroILJQrUZtUijGdKyXzLBJuDpv9lYLyFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=pR3fMv0k;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F88606A31A;
	Tue, 20 Oct 2026 09:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F88606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=pR3fMv0k
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 80ABF780395;
	Tue, 20 Oct 2026 11:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487341;
	bh=1BMQ1wu5KC7UAXbtC0A8UCup5u/Ob3yCg0t2vrAJOOQ=;
	h=From:Subject:Date:To:Cc:From;
	b=pR3fMv0kqrBe+UPtonjYmxrm/FDgkS4zs67+KaaKHgg+UOPq4vR1vAfjT7BAIeQ9D
	 rFc5qJK9TofH5z/awDiFCvjZ0wmylNVCNI8XJ3H4396djVzF7uw2Jrvs8+mo2r06IL
	 b4baqTFvR0nCDFGLKOAMD/w5peVC5LnZmHVCXpoveRkmktwI8kqficf6UBJHRlIHaJ
	 4kzhrbxNEyZwN4VYPPwLKT9FhRT+gYrsr8yyuzsLZKhLuM+7pP5dhJIIXr2iRaiqqY
	 QzZF792dglNzjfTAdMAvgW/ayl9NCOegog+b+zWCxxIBFlmfIbxCqOFqBDLZeIveFQ
	 0H8yZkeHFqQog==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Subject: [PATCH v3 00/10] can: peak_usb: fixes, cleanup and input
 validation hardening
Date: Tue, 20 Oct 2026 11:08:05 +0200
Message-Id: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WN3wqCMBxGXyV23WKb0lxXvUeE7M9vuSyVzUQR3
 73NCILw8oPznTOjAN5BQKfdjDwMLri2iSPb75CuZHMD7EzciBF2pIRwrGVjTakr0HWZiAYepTM
 jlrnhkkoKwA2K786DdeNqvlw/O7zUHXSfdImoXOhbP63pgSbuWyk2KwPFBBOZKVUwmwMR5w5kj
 cMUengerEcpNbBfmdiWsSizXHHOBBNc0D/ZsixvKYiMMiIBAAA=
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
the same channel slot check in the PCAN-USB Pro driver, the order of
the netdev unregistration in the probe error path, and the dump of
stale RX buffer bytes on decode errors.

---
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
      can: peak_usb: unregister the netdev before dev_free() on probe failure
      can: peak_usb: only dump received bytes on decode error

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 44 ++++++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 47 +++++++++++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 15 ++++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 96 ++++++++++++++++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 29 +++++++--
 5 files changed, 170 insertions(+), 61 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d

Best regards,
-- 
Stéphane Grosjean <s.grosjean@peak-system.fr>

