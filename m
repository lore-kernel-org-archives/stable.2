Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588381;
	b=07crEFKTJXdNICXslZTK2IrwbC0L1TGXS8mgcVQwhlqC+Lly61p3JXQ30tEZss4KkuX8
	 ZJy0+u/NSEeI5kjCj8yXAXkP5mIXqqcHFFg08B7x3DhBOiFB7SDTdgPshwKRNwhGjVr3t
	 JrX6wgRiVU8PxcwMKO68UAp6ZUKpeNt9xh1HZstacU2M7AOHdwkvJEgr/2KysBAmVkEwb
	 4z+9vEXW26r2N9xzJoKqgs+/5Bnd42UTarqkKvC9Jr+WG+7ohxSlYPtN0G7g0OqvV58OH
	 ZNQTM8vRF6Z9aoLMNMJSMGEPwqWqXBfigsJ1csEqLGbqiOlk2o+4bZ6qDypsep9D7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588381;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gA1QZAB7HPf+dALo4WYbNOoCQsQN7g2lPKb9/BwTFdQ=;
	b=XLux06ImOckNws2DMcJLgCLjm/aHMAxDGi3syyKRoee3kkM5Nm/ypkgNiP/Ip/rlTFrb
	 3nYZFJTqEHSC3muQNLACs4TBbPrwVbqGcr/pFaSYVTY6ycJXkD6GAMoFMJ3mb6XxytPCG
	 Rrv3EH9hv6poP4ZUThLgsT+gXhqwq+0ZKJ4lFDfc5XkF95Bd7hu0ySdxn4mxiRdxzdcqu
	 hd78P9wFv63tB4qGcD4yskozctD5Bj79vlYFND7FLnISGxgAerXjiBQBmi0cZZ382DRq8
	 f7o8oF+cUEG+YTdsCjac/IT/g54cyyXXIr35cb3ChufwnLp4+8nTkxag45Yi0bF5l+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pV29axjm;
	arc=none smtp.remote-ip=91.218.175.46
Received: from mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E1606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 902E1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pV29axjm
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EXv0sHP9HvBQZ2ybMZ4eUwO2jxKtfElIN3Q1E2u8x3M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795588378; v=1; x=1796193178;
 b=pV29axjm6x2hepkkga5Xd1V9av8XQJhG5nEfn4wvGUaKImpHhCaG35neZCbo4oHcZmE/lYGu
 PvlZgzdWodGlo4eK0iTfoVAGEe4I6GkKObi3/a9aHkUWf8Ebk3jXy6kPdl6CW8dQr3YXF/hymNO
 yjncksb/qCJn5A4TXK0rFhQE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a407cc287828b350;
	Wed, 25 Nov 2026 06:32:58 +0000
X-Mizu-Trace-ID: a407cc287828b350
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 07:32:52 +0100
From: Richard Leitner <richard.leitner@linux.dev>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, linux-remoteproc@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, weinshec@holodeck2.de, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: revert channel freeing order in
 imx_rproc_free_mbox
Message-ID: <awaAMLAk8HJz9T7W@bombadil>
References: <20261110-imx-rproc-free-mbox-v1-1-3e33ff98570d@linux.dev>
 <avMgJNyGez2Eyr3a@nxa18884-linux-1.ap.freescale.net>
 <awPmc_4VFkcpW0C_@bombadil>
 <CANLsYkx=M_TXN10qAcQC0be065TYnzfOae6E8ss-9DTj9MzogA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANLsYkx=M_TXN10qAcQC0be065TYnzfOae6E8ss-9DTj9MzogA@mail.gmail.com>

On Mon, Nov 23, 2026 at 08:11:04AM -0600, Mathieu Poirier wrote:
> On Mon, 23 Nov 2026 at 01:09, Richard Leitner <richard.leitner@linux.dev> wrote:
> >
> > On Tue, Nov 10, 2026 at 09:46:12PM +0800, Peng Fan wrote:
> > > On Tue, Nov 10, 2026 at 01:29:08PM +0100, Richard Leitner wrote:
> > > >The imx_rproc driver is affected by a race condition in the shutdown
> > > >ordering in imx_rproc_free_mbox(). A received message might cause a
> > > >virtqueue_kick resulting in tx_ch access. When imx_rproc_free_mbox() is
> > > >triggered between the if (!priv->tx_ch) check and the mbox_send_message()
> > > >call in the imx_rproc_kick() function the mbox_send_message() then tries
> > > >to dereference a NULL pointer on the tx_ch (as seen in the call trace
> > > >below).
> > > >
> > > >Therefore fix this behaviour by first freeing the rx channel, so no new
> > > >messages are received and therefore no kicking on tx_ch can happen.
> > > >Afterwards release the tx channel.
> > > >
> > > >This problem was encountered on a fleet of i.MX8MP devices on about 1 in
> > > >500 system shutdowns, resulting in Oops below. This Oops was recorded
> > > >from a v7.3.0 kernel before the work-queue removal.
> > > >
> > > >    remoteproc remoteproc0: stopped remote processor imx8mp-cm7
> > > >    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> > > >    Internal error: Oops: 0000000096000004 [#1]  SMP
> > > >    CPU: 0 UID: 0 PID: 32710 Comm: kworker/0:1 Not tainted 7.3.0-XXX #1 PREEMPT
> > > >    Hardware name: XXX (DT)
> > > >    Workqueue: imx8mp-cm7 imx_rproc_vq_work [imx_rproc]
> > > >    pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > >    pc : mbox_send_message+0x8c/0x178
> > > >    lr : mbox_send_message+0x88/0x178
> > > >    sp : ffff8000897f3b70
> > > >    x29: ffff8000897f3b70 x28: ffff80007a07b248 x27: ffff0000d90e1a20
> > > >    x26: ffff80007a07b328 x25: ffff0000c1d31300 x24: ffff0000d90e1a40
> > > >    x23: 0000000000000001 x22: 0000000000000005 x21: ffff8000897f3ba4
> > > >    x20: 000000000000000b x19: ffff0000c1b24240 x18: 0000000000000000
> > > >    x17: ffff80006a453000 x16: ffff800081ac8000 x15: 0000000000000000
> > > >    x14: 0000000000000040 x13: 0000000000000228 x12: ffff0000c115a3e8
> > > >    x11: 0000000000000000 x10: 0000000000000001 x9 : ffff800080cd6570
> > > >    x8 : ffff8000897f3ba0 x7 : 0000000000000002 x6 : 0000000000000000
> > > >    x5 : 000000000000000c x4 : 0000000004400000 x3 : 0000000000000000
> > > >    x2 : 0000000000000000 x1 : ffff0000cb268000 x0 : 0000000000000000
> > > >    Call trace:
> > > >     mbox_send_message+0x8c/0x178 (P)
> > > >     imx_rproc_kick+0x50/0xc0 [imx_rproc]
> > > >     rproc_virtio_notify+0x3c/0xa0
> > > >     virtqueue_kick+0x4c/0x68
> > > >     rpmsg_recv_done+0x224/0x658 [virtio_rpmsg_bus]
> > > >     vring_interrupt+0xbc/0x158
> > > >     rproc_vq_interrupt+0x40/0xb0
> > > >     imx_rproc_notified_idr_cb+0x20/0x40 [imx_rproc]
> > > >     idr_for_each+0x74/0x100
> > > >     imx_rproc_vq_work+0x2c/0x40 [imx_rproc]
> > > >     process_one_work+0x194/0x520
> > > >     worker_thread+0x19c/0x320
> > > >     kthread+0x134/0x148
> > > >     ret_from_fork+0x10/0x20
> > > >    Code: 37f80574 aa1303e0 97ffff39 f9400a60 (39402001)
> > > >
> > > >Fixes: 99b142cf7191 ("remoteproc: imx_rproc: Request mbox channel later")
> > > >Cc: stable@vger.kernel.org
> > > >Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> > >
> > > LGTM:
> > >
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > BTW: would you plan to fix the other issue that sashiko reported
> > > regarding imx_rproc_xtr_mbox_init()?
> >
> > Thanks for the review and sorry for the late reply.
> >
> > Sure. Should this be a separate patch or added to a v2 of this series?
> >
> 
> Please send another revision with the fix.

As Peng pointed out, the sashiko finding is handled by a series from Lee.

See: https://lore.kernel.org/lkml/20261123172140.3547896-6-lee@kernel.org/

Therefore I will not send a v2 of this one. Please pick this patch (v1),
ideally as a fix for the next 7.4-rc. Thanks! :-)

regards;rl

> 
> > regards;rl
> >
> > >
> > > Regards
> > > Peng
