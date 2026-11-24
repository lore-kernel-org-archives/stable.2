Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512656;
	b=ui+SF6j+ChGRcLiV7p3btuW/nGrNUzxX6cS+50scYHVAd6SWH6bWsvNSAFxvZifEFpvE
	 hqkYRLGgkRYpVJIxV1qYKAh1ErXwKY3t6lqiEiecppUZ8N76InJitWJfrDwh+EZET7X0s
	 +SPhFzY0eGpVIkmKXosSCSr9f3uktQwRihSnGE3lwVjsKjCapvUhRwN3PwHbSnELaFSVD
	 oJEwq8kmXEI69nNrH7rVrQ1gCLM3M65qBY7VgCIQUCkHOE0IjK6VHuVWSMLFphi87T1R+
	 LlBv6Z+zR9LZkGLcVY+oE0prk/4HZpaKD/6qy+xLylu164tvwSSbPv+T8qUSgMbSyPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512656;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LWhJdPwB4Sa1O1IYYxGqk99vpRu3T04bxTINWWe2wmM=;
	b=K1dU7jaTs0M+t8fejlm6AVZapDdsf6m5rZXktQ0I8pOfJ3Mp6qy+6n407vGDFjf2IZtm
	 0oagHAqAiY37gNcdOfNrLVMf1dyYboByaPUlZhpckEviIiBjYo916MUy0Sr10K659pLUJ
	 OQ9T2diNd9NNKIC4SM/yWuXA/8ZPth2NPGM0MaYUlxcgHFVOHusfelEu/EVV7pCu3kBQ8
	 JPjo+vRMiABhUX7yS0tcrB8Z/QvG8u3oytds22sxiSRVxna8odDDJAhXiSiXCN22chqv2
	 7XrIXMvzmEAEYIFIOyALt2g0VC4sJcFyOgNCzco/lXRyv7iLMm1fuzqNo9glOivNEWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azVp0ldJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB203606A691;
	Tue, 24 Nov 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azVp0ldJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80641F000D4;
	Tue, 24 Nov 2026 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512656;
	bh=LWhJdPwB4Sa1O1IYYxGqk99vpRu3T04bxTINWWe2wmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=azVp0ldJGS9uBHFaoDgaJ8v11PcB4aeUDx7TH0CkfhhQ/yiqQ+xcEtDDvGeJrySx6
	 ClxB5cpynB0Kmb6yeReVl8uCG1UNIPM0DfBVBuOiqKHE9t3MO5DTjxKSJhVElI48W7
	 bTw907HEwY7xbriGwtkQ2HE8h460u+aBQYF6x8+FJ20UHyhvfypUimjkv1vYDH1Wki
	 +z+tyJN7L/keBNzc4ZGdVlql0gA1d04w4+P9lZVbRu02cgzcghA/NsLvWQxdZ3CKUo
	 VglmyQD8y0ZqlN+ulsRNKhXeawR1VJclz37FQLBK5aEHS3nf40ZI77icHn+7mNnMNR
	 1m/EJ1bvZHeyQ==
Subject: Re: [PATCH can-next v10 04/14] can: gs_usb: use spin_lock_irqsave()
 instead of spin_lock_bh() to protect struct gs_usb::tc
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:30:55 +0000
Message-ID: <179551265523.3131.7740892094400767439@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-4-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-4-7c165c35d04a@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds `unsigned long tc_lock_flags` to struct gs_usb
  and creates a locking contract that is not written down anywhere.
- [Low] The commit message has typos and does not state the user-visible
  impact.

--

can: gs_usb: use spin_lock_irqsave() instead of spin_lock_bh() to protect struct gs_usb::tc

This commit replaces spin_lock_bh() with spin_lock_irqsave() for
struct gs_usb::tc_lock. The reason is that gs_usb_skb_set_timestamp() can
be called from the URB completion handler in hardirq context when the HCD
does not set HCD_BH. A new tc_lock_flags field in struct gs_usb carries
the saved IRQ state into the cyclecounter read callback, which has to drop
and re-take the lock.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114-gs_usb-fixes-v8-0-f615502b005b%40pengutronix.de?part=7

> gs_usb_skb_set_timestamp() is called from gs_usb_receive_bulk_callback(),
> the URB completion handle. usb_hcd_giveback_urb() calls the URB completion
> handler directly when the HCD does not set HCD_BH.

[ ... ]

> This issue has not been observed on read hardware, but found by LLM review.

[Severity: Low]
This isn't a bug, but there are two typos here. "completion handle" should
be "completion handler", and "read hardware" should be "real hardware".

The premise is correct. usb_hcd_giveback_urb() calls the handler directly:

drivers/usb/core/hcd.c:usb_hcd_giveback_urb() {
    ...
	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
		__usb_hcd_giveback_urb(urb);
		return;
	}
    ...
}

So gs_usb_receive_bulk_callback()->gs_usb_set_timestamp()->
gs_usb_skb_set_timestamp() can run in hardirq context.

Could the commit message also say what goes wrong without this fix? With
spin_lock_bh(), gs_usb_timestamp_work() can hold tc_lock while hardirqs
are enabled. A URB completion on the same CPU would then spin on tc_lock
forever. Lockdep would also report an inconsistent {IN-HARDIRQ-W} vs
{HARDIRQ-ON-W} lock state.

The patch is tagged Cc: stable, and the stable team needs that impact
statement to evaluate it.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index c9306e7155529..470dd52d97dfe 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -333,6 +333,7 @@ struct gs_usb {
>  	struct cyclecounter cc;
>  	struct timecounter tc;
>  	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
> +	unsigned long tc_lock_flags;

[Severity: Low]
This isn't a bug in the current callers, but should this new field have a
comment that describes the locking contract it creates?

gs_usb_timestamp_read() is the cyclecounter read callback. It drops and
re-takes tc_lock using the flags stored in the struct:

	spin_unlock_irqrestore(&parent->tc_lock, parent->tc_lock_flags);
	err = gs_usb_get_timestamp(parent, &timestamp);
	spin_lock_irqsave(&parent->tc_lock, parent->tc_lock_flags);

The cc->read() signature cannot carry the caller's flags. Any path that
reaches cc->read therefore has to follow two rules that are not written
down. This covers timecounter_read() in gs_usb_timestamp_work() and
timecounter_init() in gs_usb_timestamp_init():

  - the caller must save its IRQ state in parent->tc_lock_flags, not in a
    local variable
  - the caller must be in sleepable context, because of the GFP_KERNEL
    control transfer in gs_usb_get_timestamp()

The patch also uses two conventions for the same lock.
gs_usb_skb_set_timestamp() keeps its flags in a local variable. That is
safe only because timecounter_cyc2time() never calls cc->read.

The commit message does not mention the new field either.

Two related documentation problems are fixed later in the series by "can:
gs_usb: add support for context analysis":

  - the stale tc_lock comment ("guard access tc->cycle_last")
  - the __must_hold(&dev->tc_lock) annotation on gs_usb_timestamp_read(),
    which names a dev that does not exist in that function

tc_lock_flags still has no comment at the end of the series.

The contract is also harder to see later in the series.
gs_usb_timestamp_start() calls timecounter_init() under
scoped_guard(spinlock_irqsave) with guard-local flags. That is safe only
because cc->read is temporarily swapped to
gs_usb_timestamp_read_initial().

A future caller that takes tc_lock with local flags and then reaches
gs_usb_timestamp_read() would restore a stale IRQ state from
parent->tc_lock_flags, and nothing in the code warns against that.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
