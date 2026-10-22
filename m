Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679278;
	b=e9vW22wW2RnuxoyAdKJG5K06z1vAjqPnDl4GTl38A/W5ExfrNWBXbWZJQJVv+45/N4Ke
	 Yk0NNuL+3/y2+TVhOjVKS9GKDFoEvRbjl1hSOF6O3abUZ8YBX3UcTewfKC65M/wviqGKZ
	 nNa9qGkUy8Ts3UzSyhFTXRkII+j7nF88fUV50YkJ0P7902LCeDLnr7mJwmPNmtj7g7i8w
	 wz5rdPgiZS3J0+8+3ViZECOaW2Ug+iSoWuUNaOe+P3Qld3/fthT5XfBwmyfbxZDAgAbTW
	 43S/eWw6XRMt1ZnAj3biL5+JIG/U1R5urbNy+0aVyP+rt7NAPVwRwIHt2RwoFFWy0jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679278;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2tCDo1x3QhLFgEA9g3b5718o8UuMO738ZD6rhVHiogk=;
	b=x0qBNQb84LpdX1WS87LnDx7bRGdvDsM88lH9wAiihxEKtxLPzSQp9c5E/DDYpa5+g3Yq
	 5lLr/S+xBWvsNQmwpp3LfWq8zHmzh+ukie01CJUE74/zKdidsNJdzzur8yEdVrF63e+ks
	 x+LdC93jbzKiHWdeGxjsYcynz7jmYvr7tzDzQ9TR/xZGqj7g2WUQtyM4tJ29Fm3B8ETnT
	 48rR5PJMvcYDdfdgpzvN9kB0Ig5UcF4m/xcr0Xb3N6fyaDug6OHkGGDRPcVKPVhX0JEAr
	 0GqZybRNtOdcncgWlCx/q0rE73e37CvrjOjNhsBB2+ffnTqAtX/pJ5nXArzIH4PRYHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYFmDJDl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FB606A329;
	Thu, 22 Oct 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYFmDJDl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679277;
	b=NPBdp3pqC7vaHPjDccE+7xQoSvI1PVC3sAPF1++GjaTJVtzIGMvLIlAd3lwb/7Qu4vks
	 ODla4mPJeU69yWwQfeTLtHXgFoISuBWwsyHj0Et0hQbEBnVuMiHvtXYqYYlDrgwmdNf6P
	 vLRoUK+4OcVLP1MRqqT8KeasLNObWV821oGkJjASv7DvHd0LgJ89I303RqLWAN+8VO2Pg
	 LrWywEHuLcKDcjIp8GucsDDR9onPfgBXsCm8vKdn9E0V1kYRceeLMQCEeWaRh7JtyOTmj
	 8vGa9crC0OqpEi55AJ/Qp8BhA8lfMqAgSwoF08ewxggXH3QHt99uX5NW8Z2WW6YLNvw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679277;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2tCDo1x3QhLFgEA9g3b5718o8UuMO738ZD6rhVHiogk=;
	b=RWS04u3OuXiRnRLX4rIYbc1iZ1VzNHSFFIwaobYsk6kQgkLWWPayx584X+TPeUNBAVyQ
	 Io6T9JV4anIcTdKuYhjhZsPjuH/P2Bp9UTZKixZDV/vW4X+e8mGdAPVN8oxhk7tt2WLCC
	 oDuUSLCc06t6ImSw/ZuNhPiDX2sno8dUi3fnKI6KZ7p9mIgVAZ3aFDEhfHnFtDxK8oO6/
	 VSE2AMzJBVDiBopSZ3g3aXGmvU+avjnkc0VT7e8297TEcyjJfA2TUGh/ydy+P6Es7G2N3
	 Pde076gHLoaJQV3GsvRKyN2a8XPTmDGPCVrbsGH2OABYWmeqmu11iJ0BNqjyNYq4K5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26B2B1F000C4;
	Thu, 22 Oct 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679277;
	bh=2tCDo1x3QhLFgEA9g3b5718o8UuMO738ZD6rhVHiogk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HYFmDJDlmQU2JEAM4Lr5A2cfEaMVWtbY4tEKPgE5rLO+llL/YcjJXMKHeOw3kzhKU
	 ZazGAIKVIjN3NegKxmbqTVf7HZhZ2rdAmkrgDYrJ4j7dtJX74wdw8CpqfGM2Z1lAM3
	 +RmHKUEVVCYNH9DugqBFZSI5LvQHTG2HEf+2spq4IYmueMWNfi54omgE1Si+5CP6NR
	 akgTF6gc2+PEZDKJVVLyOZvnBT3x3qRF9jJecRoWMjGNDaFGhMHDnn0nkd1lCQ/kVH
	 VNzrHYSZ7DawpBnHwKngGjhcq1ad6DtjsGkX8HhEOeWncU+0VlhQ1ZM2SUIhv1tp+I
	 Xc6DsZzK83Mbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7ADBA435B1;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Subject: [PATCH v6 00/13] can: peak_usb: fixes, cleanup and input
 validation hardening
Date: Thu, 22 Oct 2026 16:27:45 +0200
Message-Id: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N0WrDIBgF4FcpXs+hJkbd1d5jjPCrv4trlxbNQ
 kvJu087BoUl0MsD53znSjKmiJm87K4k4RxzPI4ldE874gYYP5BGXzIRTHScMUUdjMH3bkC372t
 jxEMf/ZlC6xVw4IjKk7I+JQzxfJPf3n9z/raf6KbK1cYQ83RMl9v1zGvv70VvvsycMsqgsVaL0
 CIzryeEPc2XPOHXc0ikXs3iHjPbmChYUFYpYYRRhq9izR0m2DbWFEy1nisnQRqDq1j7INYWzAb
 rUfOgLdhVTD6IyYJBJ2wjre5UYP+wZVl+AOXIg2AJAgAA
X-Change-ID: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=8278;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=+jnSG2MiA9rk5bDISbesAmHFzXpKuKNKa+lWY7SULIE=;
 b=QIHbYUXYGyUYYQYts0jDei+SvSLpuXIOdqxUPpUNeLQEKcpMWjUvwwKlQzcDdG980ECYSf9YM
 8LGdAki+gnGAsetT2pjinJ/YF5OVCeyIcqdyXtGupSVqMNFDn6yxxAc
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

Patches 8 and 9 fix related issues found while reviewing the above:
the same channel slot check in the PCAN-USB Pro driver, and the netdevs
being registered before their channels are initialized.

Patches 10 and 11 add the missing validation of the data received from
PCAN-USB Pro devices: the data length of the CAN frames, and the record
count of the messages, which could make the decoders read past the
received data.

Patch 12 stops dumping stale RX buffer bytes on decode errors, dumps an
undecodable URB only once, and rate limits the decode error messages.

Patch 13 fixes an uninitialized stack byte that could be returned to
userspace as the PCAN-USB CAN channel ID.

---
Changes in v6:
- Patch 6: clear CONNECTED under RTNL in peak_usb_stop_rx(), so that it
  is serialized with peak_usb_ndo_open(): no RX URB can be anchored but
  not yet submitted when the RX anchors are poisoned, which made
  usb_poison_anchored_urbs() busy-wait.
  Found by Sashiko AI review on v5:
  https://sashiko.dev/#/patchset/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr?part=6
- Patch 7: update rx_bytes together with rx_packets, once the SRR byte
  has been checked, so that a frame dropped because this byte is
  missing is not counted.
  Found by Sashiko AI review on v5:
  https://sashiko.dev/#/patchset/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr?part=7
- Patch 4: add Cc: stable, since patch 7, which is tagged for stable,
  relies on the bounds check it adds.
  Found by Sashiko AI review on v3:
  https://lore.kernel.org/r/179262353124.3131.13235647451945152794@kernel.org
- New patches 10 and 11: validate the data length of PCAN-USB Pro CAN
  records, and don't read past the received message in the PCAN-USB Pro
  decoders. Pre-existing issues found by Sashiko AI review on v3 to v5:
  https://lore.kernel.org/r/179264019905.3131.17443314322038603114@kernel.org
- Patch 12 (was 10): also remove the dumps done by the PCAN-USB Pro and
  FD decoders, which dumped the same URB a second time without any rate
  limit, and rate limit the decode error messages. New subject.
  Found by Sashiko AI review on v3 to v5:
  https://lore.kernel.org/r/179264020123.3131.12155600294986434879@kernel.org
- New patch 13: don't return an uninitialized PCAN-USB CAN channel ID.
  Pre-existing issue found by Sashiko AI review on v5:
  https://lore.kernel.org/r/179264020017.3131.2617691177294766125@kernel.org
- Patches 6 to 13: add the Assisted-by: tag, as required by
  Documentation/process/coding-assistants.rst.
- Not changed, after review:
  - patch 8: a record for an unset channel still stops the decoding of
    the URB, as the other malformed records do, and as in patch 6. This
    can no longer happen once patch 9 is applied;
  - PCAN-USB with CC_LEN8_DLC (reported on v3): checked on hardware
    (firmware 8.6.1), the device puts DLC data bytes in the records with
    a DLC of 9 to 15, so advancing the RX cursor by the DLC is correct;
  - the other pre-existing issues reported on v5 (asynchronous restart
    URBs and PCAN-USB restart timer not drained on disconnect, bus-off
    not sent on unbind, driver-loaded state not cleared on probe
    failure) will be addressed in a separate series;
  - patch 9: the "can%d removed" message logged on probe failure, and
    the netdev_err() messages of the command helpers during probe, are
    left as they are: they are cosmetic, and will be dealt with in that
    separate series.
- Tested on PCAN-USB, PCAN-USB Pro and PCAN-USB Pro FD on the same bus:
  probe, ethtool -e, reception of Classical CAN data and RTR frames of
  all lengths, of len8_dlc frames, and of back-to-back bursts, module
  removal with all the interfaces up, hot unplug of the PCAN-USB Pro and
  of the PCAN-USB Pro FD during RX and TX traffic. The new error paths
  of patches 10 to 13 were not exercised, since they need a malformed
  device.
- Link to v5: https://lore.kernel.org/r/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr

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

---
Marc Kleine-Budde (1):
      can: peak_usb: add missing includes

Stefan Günther (1):
      can: peak_usb: fix missing CAN_ERR_FLAG when reporting error counters

Stéphane Grosjean (11):
      can: peak_usb: sort ctrlmode_supported flags
      can: peak_usb: harden PCAN-USB message validation
      can: peak_usb: replace open-coded bitmask operations with bitops
      can: peak_usb: harden channel handling in PCAN-USB FD
      can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR
      can: peak_usb: reject records for unset channels in PCAN-USB Pro
      can: peak_usb: register the netdevs only once all channels are set up
      can: peak_usb: validate the data length of PCAN-USB Pro CAN records
      can: peak_usb: don't read past the message in PCAN-USB Pro decoders
      can: peak_usb: dump undecodable URBs once and rate limit decode errors
      can: peak_usb: don't return an uninitialized PCAN-USB CAN channel ID

 drivers/net/can/usb/peak_usb/pcan_usb.c      |  66 +++++++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  99 +++++++++++++++------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  16 +++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 123 ++++++++++++++++++---------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  86 +++++++++++++------
 5 files changed, 269 insertions(+), 121 deletions(-)
---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261007-canfd_check_channel_idx-a4d7a1a1ee7d

Best regards,
-- 
Stéphane Grosjean <s.grosjean@peak-system.fr>


