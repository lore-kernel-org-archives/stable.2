Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DC39DBD7;
	Thu, 30 Jul 2026 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419334; cv=none; b=DOFaymco/W0i69hKnW4KzpkfkY2TaAn8ic0omRmRHJygR9SrTzohvDrNsPzpizTswj0IsY9FaI1vu85O1CvvqZt/gsaQ/yn2cy5ZhKQXrHf+pYMuMOJDzq/P3F5hUM77IfEJcQ7T7kl9HXAd2FFCWBhCagEaN9nYF2Y0hJwOyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419334; c=relaxed/simple;
	bh=xiwqsDLu3+hOdbGzpCLAnAnCmmJ23EfEz8L35prqMV0=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=dEPG2q1b+CZYyWdZU2WQtHpJmwORTLZp6rNliX9iBrrsQFZn9Lyth5wxkkGHY3tFEQqBXflYnOTIszSPSJiYolob+dQOLcMllHYtrdt9ZfOjcCRpEc1CVWsx4yo8nCkyEr7MlbEUgFbcsnLC/jwCSjpXWjW8F5mYQpHbS66TwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=n3kFyzuG; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="n3kFyzuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785419324; bh=IV4VWKt9C18iet85WS4Z7bjY9sriiGMTucHXIIW/ing=;
	h=From:Subject:Date:To:Cc;
	b=n3kFyzuGePnzaS5K2aX3D+AZyX8fD5wxSBrLjOcivuRK0RSMg7RKSsBfMmzs8gcUo
	 KwugVP45GWOm2BtNAwsHTWdYyKkEZPdNrDF7/NEj0KP3lUliUA1h2jf4ME4hDhIwfD
	 h/fgoZ42IdS76hi3jygiZ89VhvwXHb7dqE/KKn1A=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C291AE95; Thu, 30 Jul 2026 21:48:41 +0800
X-QQ-mid: xmsmtpt1785419321tvkx2fomf
Message-ID: <tencent_011F48D3310D8C4C4942DC88698030A28B06@qq.com>
X-QQ-XMAILINFO: Mb+hvSGTyAUJS18Yz+EPJ4bgdcEqKmKbH6njzV59WmccKspVnmxGfEDXcOQuOx
	 eBjktyXDGGzbZZJZ5zd7R6bfzFR6lZ/t5uahTO/lZsQqKLGXJnKvw/y1AiueoWsvv5OmPqpMEnT8
	 1rWfjdWUBv+4kjN6Kw2t43V+972PQ678RhHALRCeoi7LXwsdpzKE/dwApenMmBV9YOw/fJ2r5PuB
	 vBRtWX2YxVnOYy3gHuIzA4DL1mTU16vXQaZnv7yqf/DFK0hdoWOTlmP3AauEvyn0cMojF8CI5vlu
	 95ckK6SS8GZbA7K4VcYpppfnXylaK/G0MifKx2z5Q/WJwCukDliUqpIJsIDHlrwC6c5jZk7+EJ+k
	 /3iwQ1ucXvKWQ+HU0ccL50auaAXyqYvRw39omN6nNDokbV21VNY8/N/i7v6zfFRRqGl482Yw+b/p
	 JEtRH5Sg7E4z4+rP+jXIK2chj1lbuGHabBnzP/ESvjSlIPOS3pBeYftIlf9wucbq3uIBn537ROh6
	 sr9lYSIDqk4TgfCXslbRioSKqIm+KWBxhArDPaVaz38nNL/K4H2mt0fqpSflcPQkF+/gcFhyBzq/
	 CXA23v2/UGVkbtmuRpoi8wQ2fJtFgmHga3Pos8apY1AU0uQQnZmNdORd3MX8VJ92hnoyvjRlX3hi
	 HRH6J4/uwYXibD48jvqVfeFs4g4IwrZ8lXpPO24ExFITuqbBR/k0rIKUDoqwIsE1jvZviUmnp3Gx
	 aQUp93CFDgfS29cRu5uy/KQebTInBt+95QRxpHldK9/9Oormo/6EWQ9bvhZ6bB0+RsYge8+/y4n6
	 CZyhCS/brCjjSgBQU3WqbqOb/Oc+ZXmQfGOcB/og4SQMP4H6o5fzilOsJ7zD5MT2qGwCvp9LXetq
	 KT8ScsR9QCIa4fiJpsmQem2bC0sNHBHF/aMMnRp0EgoG7QyTupGqL8tiB2UmLrIYA5vpjZmSfFx2
	 VlpSOrEcXmDoK80gcFtpwMbaQ2+XvVWyPJulXjf1QFHX9HAy4OCk/rY9OVyZsE/TIp0PUgoJrG/h
	 pjb/+K1Jbc34wWbPfItg2hsnWGbFPUYaJVRlZEU8nRPmmOoXViBiLGmIMgNUZn4Xpxj8o4sJwJM1
	 jt4cuMLzdTHe0jCSTbvf9pZBR3acEKdA3BbVVNlFS1QZnYWkIi08y1wpP6hnEagO4EdS9nfhml53
	 ZfsDPzmnngQQQcNverci5B3NvdapSoyEaTciAJMCIfbsHVJDog4UQwL7lygBxZ9PEGTGB5Ijx+nc
	 LiLw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v3 0/3] can: rockchip_canfd: fix TX stalls and races
Date: Thu, 30 Jul 2026 21:48:37 +0800
X-OQ-MSGID: <20260730-master-v3-0-91cf030c337d@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVWa2oC/22Nyw6CMBBFf4XM2pqhtBBc+R/GRSlTqQmvFhsN4
 d9tMXGjy5Pcc+4KnpwlD6dsBUfBejsOEYpDBrpTw42YbSMDR15iVSDrlV/IMZU3UjSFNlIhxPH
 kyNjnHrpcP+wfzZ30kuy06KxfRvfan0Kedj/RkDNkZS2kaVth0JjzPB/12EMqBv7f4dGRFa8rg
 ZILxK+zbdsb4hqnId8AAAA=
X-Change-ID: 20260730-master-a1b54b3cf5a0
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

While running CAN traffic on an RK3588 system, the driver repeatedly
reported an inconsistent TX echo state:

  rockchip_canfd fea60000.can can0: rkcanfd_tx_tail_is_eff:
  echo_skb[0]=NULL tx_head=0x00060f7d tx_tail=0x00060f7c

The Rockchip CAN-FD driver completes transmissions by matching
self-received frames with entries in the echo skb ring. The warning above
is emitted when the driver sees a pending transmission but finds no skb in
the corresponding echo slot.

The immediate cause is a race between the transmit and completion paths.
The completion path removes an echo skb before advancing tx_tail, while
the transmit path reads tx_head, tx_tail and that echo slot without common
synchronization. It can therefore observe a partially updated state,
dereference an skb which has been queued for NAPI, or stop the TX queue
without a later completion to wake it.

Two additional TX stall paths were found. The transmit path submits a
frame and advances tx_head even if installing its echo skb fails. In
addition, the erratum 6 retry path selects tx_head, which denotes the next
free buffer with a two-entry FIFO, instead of retrying the outstanding
buffer at tx_tail.

Review also identified that the erratum 12 MODE/CMD/MODE sequence can be
interleaved between the transmit softirq and the RX interrupt retry path.
The interrupt can restore the default MODE before the softirq issues CMD,
bypassing the SPACE_RX_MODE workaround.

This series makes echo skb setup failure abort the transmission, retries
the correct hardware buffer, and uses a spinlock to serialize the TX head,
tail, echo ring and command register sequence.

The final series was tested on an RK3588 rev2.2 at 1 Mbit/s with 100,000
extended CAN frames. The run triggered 138 erratum 6 retries and completed
without drops, queue stalls or driver warnings. RK3588 does not enable
erratum 12, so this test does not exercise that hardware workaround.

---
Changes in v3:
- Make can_put_echo_skb() consume the skb on every error path and remove
  the Rockchip-specific -EINVAL free.
- Drop the redundant error message from rkcanfd_start_xmit().
- Link to v2:
  https://lore.kernel.org/linux-can/tencent_D802EB485A801362BF9F54130C0D990C6206@qq.com

Changes in v2:
- Document that the TX lock also serializes the erratum 12 MODE/CMD/MODE
  sequence.
- Add the erratum 12 commit to the Fixes tags of patch 3.
- Add RK3588 extended-frame stress-test results.
- Link to v1:
  https://lore.kernel.org/linux-can/tencent_0E5C2332F801372DD0D4CB4C25B88C18040A@qq.com

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
To: kernel@pengutronix.de
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org

---
Cunhao Lu (3):
      can: rockchip_canfd: prevent TX stall on echo skb failure
      can: rockchip_canfd: retry the outstanding TX buffer
      can: rockchip_canfd: serialize TX state and command writes

 drivers/net/can/dev/skb.c                      |  1 +
 drivers/net/can/rockchip/rockchip_canfd-core.c |  1 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 31 +++++++++++++++------
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 37 +++++++++++++++++++++-----
 drivers/net/can/rockchip/rockchip_canfd.h      |  4 ++-
 5 files changed, 58 insertions(+), 16 deletions(-)
---
base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
change-id: 20260730-master-a1b54b3cf5a0

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

