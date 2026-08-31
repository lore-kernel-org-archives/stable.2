Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996E21255A;
	Mon, 31 Aug 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169010; cv=none; b=phnvVv3iM3FzNWWr5iCVqSMsAbWBV1S7gVF2EXp2y2KD6c37Lc0rSdDqcwkYr0/Q76dR1hUzEcpUlMqV4ZuzUNum1QEEfV8vSwguBuDrsEH6wr8qf3J3P3ZaPqhac8e3EywDOr8jRvz0t0xMgBimbaDFnNrwYP9Sd2sJ5GGvcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169010; c=relaxed/simple;
	bh=byJBOBt/tR2tYDXtPyEeunwPUn6CVenvRXOn8is+8AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rukOGvJHoMCDtjUsAlZjTNW6i+91qIvHlaL/Mst/cUK40aSG5snjLEIBx4v7vb7SEjawNZh58otoKWT5PHJM0N8b2IF7foMxF3InrpXNoGxAsC6H3fzr0ulwRhphM5CEZB1TMGXYVfsRLfhPNy1e7MMI0h1DtZVkwLn5DaYii6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SMt2VOTu; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SMt2VOTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788169000;
	bh=v9/UAjiuPxVgMyeedaks9B3wmR8pswsO8wt+LHQBfXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SMt2VOTuaNbLp9m9GGzlM0dF4/o+MFpsukfiZpaUwPb7d+EWwm/czqpPPLFgLKHH4
	 fKnDSUGssxvyaMu/0pEvrmVteuUI7gRkQyjpoCXaKVRKRT2pkciNXqtCz80XdMB4I8
	 PWfkLw5eI8aedtlI5JSJ7MSID82ylw5a2N0nQgGk=
X-QQ-mid: zesmtpgz7t1788168983te1bde3d2
X-QQ-Originating-IP: im5pLOGF9MTXPq6UNTUPnnQx+ZPtpYKJcihSEfObd8g=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 17:36:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9484404449190021099
EX-QQ-RecipientCnt: 14
From: raoxu <raoxu@uniontech.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	maciej.fijalkowski@intel.com,
	raoxu@uniontech.com,
	diego@giagio.com,
	agimenez@sysvalve.es,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: ipheth: stop data URBs on ndo_stop
Date: Mon, 31 Aug 2026 17:36:19 +0800
Message-ID: <8DB5FB95051A2E5A+20260831093619.838403-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N61MakLYUF4qMbA4om/qpif2/WVkjzW3g93I+fZkOkWFRzNQh+9Ks06A
	jwggMfvG7voENy1opiKNMqRGDSAIsOFeyD9f7KfFCoow96i8oQkmS5BoPOIRZTfXD3421bI
	prxhmWzRCs6GxY3ebmVn4ymtojQXfzXwsQ8A4vitgAbxUWdYxRRTC+whOknhImdZcwQaYRC
	ylnWJwESXG7AqJQ8ultxeNoho+Xs0UGy6f5MfUoW9/MVRHp6EyJC2mHvVc5+h3GWgEiX/WF
	huf4SC/tUps/8pwDcLPocDn4f1zJFC2I/m0zfowglsf8vS5HrdyjDai6fbIcQfsqUmfwOlh
	UV0ZSAjqF64rL/gLn4v7YYP3ygAGqvf7+a0IhELZrvFJZaCvHUy0Ai/v34l9toA2of8haxw
	cejLpt/MbVNY49EP31J+sV+5gZJSCnmlUL7ysCxgvqkJOXRq8Ze1EOORfA2xdY3hS+7ZVCF
	qbglt2Sdv726oEU3tuWNcD7HdAQD4MWqJ7Zy6iSYIGelCxd217nwzzMAgBlwGxe6lZbX0AV
	Qs3PT7+4HmYBB501x0+iv1I9iwfWh4YvNglQqaei0DCHiVvdpXaTd7uKgZUpE3jQlHcOyjC
	PXoVR82gczoIf8XUN/CRv2wNNHTTpXmy3pjOEW8etc/1OQ4OtWn/1JcE/Ue5bXjRha8AUHm
	MUEQhbO/8g752Y2HN1jXnit//NpssyPdcUbGUEAZCK2p5X07oBmI6Hgfk4x0YLrzMRdwyQy
	R89D1BMeb6DAuBtKJSJzxuKCbR+WkJYFgSAHP7qrMxKGmuNAdCKvfzpiVzDekybKwYiMyZG
	LpP9CxkC20tfs7F9V3XCxMAhDQg0LcQiTRX2Aji5TjhWocOYPGuzakKfb0EPXz6Hd0Tnpss
	Ac1wDSPO7HHjppCqgNMqh4LpUbn2V6qWhRxDhnmxlVmnU7JyLiObwudO5VIVVWP1nLq1qH8
	iikiMsmQEncY6gfgRRG0eymqrWAeCMxdkyWyqQyB5XvMDEr/4DFfM3N1FXK61KCB9/iOmbg
	EFMPKx1NQNi9Y9+FsX7wNyN3KQ1FKBgCwAweCyVm8vOBqXTGXxq3fvHxFmWoXHe3zzx93L8
	x1YSof3P7Zn+z/a7B2knZIfOI/pDdUugYvPeJrrwQGqVXattZFKC2o=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

ipheth_open() submits the RX URB and ipheth_tx() can submit the TX URB
while the netdev is running.  A successful RX completion resubmits the
RX URB from ipheth_rcvbulk_callback(), so the receive path remains
active until the URB is explicitly stopped.

ipheth_close() stops the netdev queue and disables the carrier work, but
it leaves any submitted data URBs running.  After an administrative link
down, an already submitted RX URB can therefore complete successfully,
account the received packet and pass it to the networking stack, and
then submit the RX URB again even though the interface has been stopped.

The disconnect path already kills the URBs after unregister_netdev(), so
unplug testing eventually quiesces the data path.  The gap is therefore
specific to an administrative close while the USB device remains
connected.

Kill the data URBs from ndo_stop as well.  Do this after disabling
carrier_work: ipheth_sndbulk_callback() schedules the work on TX URB
errors, while disable_delayed_work_sync() prevents a completion caused by
usb_kill_urb() from re-arming it.  usb_kill_urb() also waits for pending
completion handlers and prevents the RX completion from successfully
resubmitting its URB.

Fixes: a19259c3d589 ("drivers/net/usb: Add new driver ipheth")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/net/usb/ipheth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 2b490114d232..f127aeab7031 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -505,6 +505,7 @@ static int ipheth_close(struct net_device *net)
 	 * it, so that such a schedule_delayed_work() is a no-op.
 	 */
 	disable_delayed_work_sync(&dev->carrier_work);
+	ipheth_kill_urbs(dev);
 	return 0;
 }
 
-- 
2.50.1

