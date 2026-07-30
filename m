Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE237F007;
	Thu, 30 Jul 2026 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391987; cv=none; b=PvAkThGwjxyWjCF40rWgjtXOqb12JzBYTZwVVOhXc//A0a+3GJCuATvuJ157XXKuGqXy7adgv8W1oNCee33PjXVQUKDIuqpW1iCIY3ij/+LI7iaTf9ZOQcAQ+3cAc4ZtDLeuLMFFcylp6zF4MfRx0CnNAbOhBorTi8l/118ZdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391987; c=relaxed/simple;
	bh=6wkTzN2wSFu8JQa+7fiFbDnxUgCjXoE2dbCXoDeR3wA=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=hkp6jPOd50oKeChz/hYAXmpwj6pjls+Rb65e7o3TR/RoLTVxQKPej3W2uZM23AKcHSV+MVH/AVhjBgijrvgnmE7XW3R5OMnYthq/lRg7xFmoQm30BMC6/vrBzXioefrZtbn0h9SJrMnCylO0+R/h+GLDsdlaUCtgEAAofgoGLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j+iVbIX+; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j+iVbIX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785391968; bh=xodhZBnx6jfLH4JD+1UDx5RRMPDpkbVj69WOZYwA5Z0=;
	h=From:Subject:Date:To:Cc;
	b=j+iVbIX+Q1MKTEF8UxYUjUUm9oy/wPl4RMwF2k/ooZ3IDOtVscTPRdJs0cmAC714O
	 ApkVCdr80h/L+g8W2FnfhYZ1GHBokvl51Nlh0p7qNaBCpWSdz/371DpGATv1l+WZ6c
	 qCcFPgvqMLLtzGuXkeA7iQu8A4TMbeICe+Q9hh4k=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 2DF15055; Thu, 30 Jul 2026 14:11:31 +0800
X-QQ-mid: xmsmtpt1785391891t5q15582x
Message-ID: <tencent_0E5C2332F801372DD0D4CB4C25B88C18040A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoegJq/HghpgMeM/vEcKqPce/AHIJU6n+h4wmheiLkpGNDuLapRTp
	 hbZ5/z0BGn20avs+kCt0XScYUpVszTPZ1ZaP8Am33dxwSRnSuUtQ+RMHDAfolnof66caTPvzHy+r
	 z7BDAhDFuasiFYuCxCStGC+NlZWGHDdKOLWohgOmzeYkcR+nqQFN+zv04AUnY3/ezQtxHlU+u7gZ
	 ZRqEjiZxRR8Oa9UHhZuTdxDdjwDXNuGl8VrdvZqYtmEUsNcyax6sgDNy96L12YitmAoD/UdolvKN
	 kDc2/Jke6qRflU7GqPtA9jK8xCu5+1POVqJj39J78zuj6vEtDbmewIjrqXDyb0lwF8xyzznWEuSr
	 gO3FbQw0cjK7ZsyF3PE+5Q0egqVdRQcmzAlMeyD01cIl7ENz89E7u98qlhIp3W99Amwu9qmFNq//
	 kqV9+Lmjq9nBHRXBfaW8U98eHUBnMbZvPJZdAAXGT52ZUdsFRvraXOO1e5GvVHgfom69x1HbdM7Y
	 dVmUfUORA1N/bWeBOwjM4y0P7T1sp5xBl+zZ4jmqcIk+30TeDbTKYVNmo36QcKe26LSWUbRFb5ta
	 iD/AeK5e10YcdsHfnggxYTBbOantVUcYWUHzhS8Bb0NFl0IfI93/75OLkDCelkYvM9Xasf+BOh41
	 w9cqGvXAh3s/7GCeZchFVFEKrQTHb8b6QaHVkoVA+DSv6C9WePrh+SQFyjdtIi0dJdmmdkZZQ3fj
	 1oP1/mVY2Io9mO3kTt70KOHm8HguBl+iZ5EDvVbwOjH/9SlsuB1x3VB3cMKQqFAG46XQOxQ1YFkE
	 UX4y8I1ZTQYnKazpkfrHGtBT11d6NvreEU/cagX1R0TuMEGUTfiGDYb9X7Ddd5epl7QEBBrOmwow
	 McJw/DnyRGRt4MW3IcWZGo6LNwVFeUX4JRbO6zbc/bTC82a4xvMhb16hYWVQf/WrhvjhdyGM/sz+
	 +02QLHtVQCjIUjKKNoQHQABr4LV0AKKjnPZrRpVp5K/0Pe9eH9O2qnZgWhzof9bD7zD0mAQKdF9D
	 ctQ2N6aiFunfzTXf5x5nNi7GTE153Dl1VPPLq8HOqeO7pmX/JTId5vQC0I7e79oYrifHyfTJiElH
	 EXutGIJ+0BRfpbi9BCiWZJw/6cqgzzxPwVbmHQY3yj1Y4LIlePjIirFn0HdQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH 0/3] can: rockchip_canfd: fix TX stalls and echo skb races
Date: Thu, 30 Jul 2026 14:11:21 +0800
X-OQ-MSGID: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnramoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2MD3dzE4pLUIt1EwyRTkyTj5DTTRAMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0A/PjexmoAAAA=
X-Change-ID: 20260730-master-a1b54b3cf5a0
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
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
report the warning and stop the TX queue without a later completion to
wake it.

While investigating the warning, two additional ways for the TX state to
become inconsistent were found. The transmit path submits a frame and
advances tx_head even if installing its echo skb fails. In addition, the
erratum 6 retry path selects tx_head, which denotes the next free buffer
with a two-entry FIFO, instead of retrying the outstanding buffer at
tx_tail.

This series makes echo skb setup failure abort the transmission, retries
the correct hardware buffer, and serializes the TX head, tail and echo
ring updates with a spinlock.

All three patches pass scripts/checkpatch.pl.

---
Cunhao Lu (3):
      can: rockchip_canfd: prevent TX stall on echo skb failure
      can: rockchip_canfd: retry the outstanding TX buffer
      can: rockchip_canfd: fix TX echo skb race

 drivers/net/can/rockchip/rockchip_canfd-core.c |  1 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 31 +++++++++++++-----
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 44 ++++++++++++++++++++++----
 drivers/net/can/rockchip/rockchip_canfd.h      |  4 ++-
 4 files changed, 64 insertions(+), 16 deletions(-)
---
base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
change-id: 20260730-master-a1b54b3cf5a0

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

