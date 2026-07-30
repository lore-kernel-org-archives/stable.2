Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F143FCB33;
	Thu, 30 Jul 2026 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406330; cv=none; b=ti0XT+SmNAGKczWZUz4tJ8VNjpkXdVX0O7OC+ophaeth3TTkPkwtKyH9ePewAdPdTCXJFb9C25fefSqMNIazXCi7ONbI6b23UPdKlRORk2Ry28wlFzsWB3JhSjW2Mj2dnR80Y7AveVpQwDbQ0KdFDCxnSIQrm3ZKGjtwPAwr84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406330; c=relaxed/simple;
	bh=HGzGxXxH5k6FgXKKcmEUbzeEbnGhXc6+LoKHYMKOBj8=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=g4t2QoAmtJS8MfwLp+kRv906UxrmZXJt9w0npqqWCs09bDBb1Rt7bdUJABtOa1BeM7OaWMWi5j1o68KcgYbk5VvOIy0l6GuCvAnwxsM3pAC8eTkOC+gnUqkhLbR47rdCDVC0/cEfiZDdAzVBs5HOczsZZESq4AQphb2a0lQ5/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=m1J3sPTq; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="m1J3sPTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785406319; bh=50Uuu8XRCWJ9Vy+dK1JJTg4ciK2N8RX5LL7SNEvVIBo=;
	h=From:Subject:Date:To:Cc;
	b=m1J3sPTqzrR/2SMAf0cB1VRH9c0pEUQ5RjwdVLWCNAczFxQJpNUuRGlJi1W0j45/8
	 51JaMK2DXTFQ9iBjZCNyznMYkBfgeRxa2nTAHNaTFyaozy64kka3MaCY5ZL08EDfWu
	 YLVArGMXOtFUORWVtSB0ZeRFRg45xEkFO1YA1tNo=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2F88CE83; Thu, 30 Jul 2026 18:11:56 +0800
X-QQ-mid: xmsmtpt1785406316t819daiix
Message-ID: <tencent_D802EB485A801362BF9F54130C0D990C6206@qq.com>
X-QQ-XMAILINFO: MzFuFcyvqEEC9szwZ9kMTGfyNdRPPkfxv5BDpdOB9GDen2MKLeIrqCPAXkATWp
	 mGTueUIR4jsE1OKmhEFYyviZSsta8Ywo3r9foqbZnyDX7rQgBrg4LrKTl30iPptNOGfHuOU0lKo7
	 KqEqJnuglqZf7leSe65Z44Rs+WRiUW4GJuz9pB7VKj+GHG6NJugnjKfRm37eGiLlXLsDtr5McVX3
	 fZlUxV9zyzwRwAHAFqLkyiPWLQX5XcURMX1nnqTS9rFNMO/qaDMrBYJURn6J2Ao+He88PP0o9HGm
	 ViYSY4GxBuy/wBNf4Rkh8cFC1JrKRi35u33CeGV2QbUuk43KIrwbAdiGh9bxyKiGapIC7Ij+cd4T
	 xTP8TK4wxAvd1AGIssPYUpLyzPgM2G6xjrqnM+bE+WbVI+BTWlk9h9TxU/lNblMe/eddG6AXjyXc
	 Bt16d/OCTuChyWmgwbvcumh97uRQjJldCYkK0iiUG8PcYSGO7mYEb9RNdEExEWUbk5S8uAxUkD4T
	 BUxEWPUUkgBsGZZ/IKuOJ7xMlefNmRRn9nF1+x1obt/4CQwgyj1x3dwm3OQ8GpyTQoA3HvPY+34T
	 W3cqaW7Nemvp9LtGmBWPHwPMi0aKHyeLjLeoxUyccoJfOT31mGtr86kiUXX/ESb7MWxTCiRj5WkM
	 dRk4gdXAoREQ3ZbwvUtRDMrUMC+i6Fj8tyhXxtdLckC4aTq1hfVOM+CmOALFbUA+weYgVlHVlVPl
	 peBZazK78V8YpWwxV2lFXz4oFDcPn2QX8+Y9CaJeeuhsADlXi+Pw96JnXKz8/rn51EK47GZ7g38i
	 AsRphK8GgFypPiBA9c+fmSSY8L5hmUh7IVZ6NeTkDPs1+mI3lJ4WiH2wSqtwBVIUhj7NWPxBVlhB
	 eGaxTpSeBx5mnpmac2T2HIit13ac01w9P1gkru1fBxv+KhSLKvWAndcFwg3Bzg+CzGCZMs323xQ6
	 peayOdqeObeeuv1Gijfh8sw9UoQEfi4KDbf85aQGvx59teGGK41mDF5aIrRy097d+oiBwnhgCoRl
	 CeWbgwFsWuZ2X5dzgZPnsDK62chrsL9r//si8f13zlni50FTplTSBxA/d02JlOBTlfC4qQJkLJwD
	 pMpKvWK3PBBjCuwVWfGrkxy3w4+c2L8bAB3cWwzyWbDDHQXiZtnTUh2E1OlFQtTkpvD+hEuKZ0+5
	 aJr9Vuzie1FG1eFg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 0/3] can: rockchip_canfd: fix TX stalls and races
Date: Thu, 30 Jul 2026 18:11:45 +0800
X-OQ-MSGID: <20260730-master-v2-0-572974052400@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEja2oC/2WNQQ6CMBBFr0JmbU0LFKMr72FYlHYqYwJIpxIN4
 e62uHT5kvffX4ExEDJcihUCLsQ0jQnKQwG2N+MdBbnEUMqykadKisFwxCCM6nTdVdZrIyHJz4C
 e3nvo1v6YX90DbczrbPTEcQqf/WlR2fuLLkpI0Zxr7Z2rvfT+Os9HOw3Qbtv2BWuNG1CrAAAA
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

All three patches pass scripts/checkpatch.pl --strict. The Rockchip CAN-FD
module also builds cleanly with W=1.

---
Changes in v2:
- Document that the TX lock also serializes the erratum 12 MODE/CMD/MODE
  sequence.
- Add the erratum 12 commit to the Fixes tags of patch 3.
- Add RK3588 extended-frame stress-test results.
- Link to v1:
  https://lore.kernel.org/linux-can/tencent_0E5C2332F801372DD0D4CB4C25B88C18040A@qq.com

---
Cunhao Lu (3):
      can: rockchip_canfd: prevent TX stall on echo skb failure
      can: rockchip_canfd: retry the outstanding TX buffer
      can: rockchip_canfd: serialize TX state and command writes

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

