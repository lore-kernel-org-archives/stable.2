Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539895;
	b=SJLVQD0DMjwLY8BjD6kwL0wSIty0efQtVuc5/sD+DCtBh+JKslFNiy5zsW24LqSzKxVk
	 m0P3+pnta5wxmhm7XaxB9dVKzHIHi2cu5Xgv3wYGsPJY0EuaZEwaw9H+wz2UCYN2h73eX
	 9TCnlfV54V3epIAy4CeWYPCQOkwpfHQtQvW3OnW6JE6hHZASydCUBRhmekNIULes4i+7H
	 CMRNixzqvVvvpfSLVeJWFhiCa4X+FN+7p6xMQhn8pyvTo/veHN2VK6ZCe5kaUyAuyGFYv
	 L0zBugbHJuKqU7EE3NFtijYI/6L/vX7kSjfg4bWsqtygGMMSQGvE/1t0WCBasUuaq+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539895;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nWc0P3UFTmQDnMEzGX9xP/Vkt43l2zO1TjQschvRNFw=;
	b=QsTyYcvxKjyDht2sz2TdqEbWCAxQNBI9Oz5pdwY3dJCgpKJI0J2Mj/ApoKbg5NPDLBmk
	 jUhL1Ujr/MeNnr0TKpVT9DQrhp2Kn05oH2KNQ+qitBIGAMGIqrJOJPeVAys6nIIingFXk
	 Em9BeQvbk/iBH444igCelQKZVOXoWTftVhk8WjU7vacGCTfhOFXJSLyX9WLBnRyWtXdQc
	 4FgPD5jfTEXaIP1anlf12zLy1/PMMnSvLBN3DdKkCS5/i9xVbxANW4LXAfmB5+AGE8Xi2
	 g8SQx75QanApLSWYYnljYkhH5DcSUNxUa6fIq0igtK/eD2l605G8qTdncOWKQpePRuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SkHtkpHe;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF2606A323;
	Fri, 13 Nov 2026 03:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9DF2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SkHtkpHe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=nWc0P3UFTmQDnMEzGX9xP/Vkt43l2zO1TjQschvRNFw=;
	b=SkHtkpHe9wM7wgDnQK6Qoe9I9l8fg5eO32VI8Z1bz2QqC/p1UyynDqK0mnEIhn
	i85mUDWMKZBnnXr5UunAJ8OpoVbr3cIxsV5443gtc+PiMXz0gdEvkCCNParCD70U
	QomXl5BziBGv/g6h/etTMqfTE/0Md0fnoxZg7kAF2awdw=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v9 1/4] can: j1939: serialize cancel and rearm of the receive timer
Date: Fri, 13 Nov 2026 11:17:24 +0800
Message-ID: <179453984495.31919.9405526133383541519@163.com>
In-Reply-To: <179453125694.488853.2205573161282115259@kernel.org>
References: <20261111-j1939-edpo-v9-v9-1-e779ca334a81@163.com> <179453125694.488853.2205573161282115259@kernel.org>
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
X-CM-TRANSID:_____wD3P6ZYgfZq7eHFGw--.4133S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw47Cr13Kry8uF18Xr18Krg_yoWrJr1xpF
	W3Kry7tr4DGr4F9w4xZF18XryS9r4fJr4fX3W7Kry3A398CF4jvFy5K3y0gFZrAr97u34a
	9a1jg3sxWFs0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uelk3UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BvORGr2gVs8wgAA3N

Hi,

Replying once for the series rather than per patch.

1/4

The High holds. hrtimer_try_to_cancel() returns -1 while the callback runs
and leaves alone a timer that was requeued from inside it, so an arm that
races the expiry still takes a second reference for a single queued timer.
The list lock does not help, because the running callback sits on the other
side of it.

The three Mediums hold as well. Deactivating on a WAITING_ABORT cancel does
leave the abort rxtimer queued on a DONE session, and that expiry takes the
generic else branch and queues a second RX_ABORT. j1939_tp_rxtimer() reads
session->state before taking the lock, and with try_to_cancel() no longer
waiting, a concurrent cancel can change state underneath it; the callback
then calls __j1939_session_cancel() again, which puts a second abort frame on
the bus and overwrites session->err. And the message is wrong in two places:
before this patch j1939_session_cancel() called j1939_tp_set_rxtimeout(), it
did not hand-roll get + hrtimer_start(), only j1939_tp_rxtimer() did; and it
replaces the 1809c82aa073 workaround without saying so.

The pre-existing txtimer leak is real too: j1939_tp_schedule_txtimer() takes
a reference per hrtimer_start() with no cancel in front, and the do_cts_eoma
path in j1939_xtp_rx_dat_one() calls it that way, so duplicate DAT frames in
one softirq batch leak the same reference.

So 1/4 needs the reference pinned across the whole queued and running
lifetime of the timer, not the queued part alone: a flag owned by
active_session_list_lock, where the clear-to-set transition takes the
reference and the callback drops it, and both armers and the callback test it
under the lock. That also fixes the state check in j1939_tp_rxtimer() and
lets the WAITING_ABORT deactivate go away. It is a rewrite, not another pass
at this hunk, so it will not be a v10 tomorrow. Zihan Xi is working the same
reference-lifetime problem and Oleksij has asked him to sync with Tetsuo; I
will see where that lands before sending and say so in the cover letter.

2/4

The abort code rests on a false premise. J1939_ECU_LOCAL_SRC is set from the
source address alone in j1939_can_recv(), so a second node using our address,
or a raw frame injected on the interface, is delivered to the transmitter
session. It sent no CTS, yet the session is aborted with ECTS_TOO_BIG and
that reason goes out on the bus. Once j1939_xtp_rx_cts_one() bounds the
packet number, pkt.tx_acked cannot exceed pkt.total - 1, so the next version
uses BAD_EDPO_OFFSET for both roles and drops the split. The comment will
name j1939_xtp_rx_cts_one() instead of "4/4", and the "bounds the
receiver-side writer only" wording goes.

4/4

The changelog describes the wrong current behaviour. An oversized
ETP.CM_CTS already ends in ECTS_TOO_BIG: j1939_xtp_rx_cts_one() stores pkt-1
in pkt.tx_acked, j1939_session_tx_dpo() copies it into the DPO, and the local
echo reaches the transmitter branch with session->transmission set. What
changes is that the out-of-range DPO is no longer sent on the bus. The visible
change is the TP case: there is no DPO, so pkt.tx >= pkt.total made
j1939_session_tx_dat() return -ENOBUFS and the session ran until the 1250ms
rxtimer aborted with TIMEOUT or the retry limit ended it with -ENETUNREACH.
That leads the new changelog. The comment and the role split follow 2/4.

3/4

Both nits accepted: WARN_ON_ONCE(!se_skb) and session->err = -EBADMSG instead
of the silent drop, and the comment in j1939_xtp_rx_dpo_one() rewritten as
part of the EDPO patch.

Thanks,
Chaosheng

pw-bot: cr

