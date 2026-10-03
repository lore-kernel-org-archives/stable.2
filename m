Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF4318EF4;
	Sat,  3 Oct 2026 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007242; cv=none; b=D4/lrn4hcm68Yje7xitmbWimDOeVYabakVOSHWlxp4vOPINLedmwsPBcu/Z7rTYK2WzvhuKRp3+V6MP2dhUHrDZ9mZcqaYpp4mh+91ibm1n3Tjen6k5uHB+A0S3PDQ28csH3RDxXgh86LIGEVeqQ8wL7zU+k6rZ0ekwpOHDhm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007242; c=relaxed/simple;
	bh=xs/eu+1AGocgu3fxahmW/bsjbrDlmJogrD5CEsqckCI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3W7AugdhgwQAdpCt02xpTTYX5e7WfGjMXiOsDH6qNrTJvn7C7BUSiNN9VI6HljaUJe9Z5fM8ORw2SuhDUB4XzWYfyQsxpDNI0cNzVqtfEhIfAPSqlqX5xobontWU4Z/zaz+nXSxXxNxfUqQT00peK1jB1696TULCWBh9Kb/CqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpkc44/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpkc44/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1201F0089C;
	Sat,  3 Oct 2026 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791007241;
	bh=Xi4jqe9cG2WbOW+dJnz5XyhS0AarZpL28wD8BisZRxE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jpkc44/+G8WwdlZ/HO5nRPNgJMyabZ4vwsP3iCy2GUSDnZh2zHrkvKQqg1eezoEhZ
	 ZHpyvxJDXAoNkS2JCzFye4bacM8ZpwNn7M+sbGnJMRUKwEUpJID1oodqtRD/b1bS6N
	 0bO+iBLfn28G8j1GCTW95mglYKrXMOfqX0WMaYWfZJsd1ZGY1oc/CyRBee5BoeqdqK
	 HPVveGLVFCxnZepZS85zZoSvsXPlW0N6nOa+yQG6rPFFvSpZ4Sefc99qMv7/Vh9zxu
	 kt2OQ3APoIuIcMD0O9w41UaZc8mu1GwH+hawocKhR5+lX/OlhKWtwCSvcgdR1bG7Yg
	 68Yky3UgPaVZQ==
Subject:
 Re: [PATCH v4 3/3] can: fix unique skb identifier regression under RPS
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, norbert@doyensec.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Sat, 03 Oct 2026 06:00:40 +0000
Message-ID: <179100724051.1406898.18080408504073975767@kernel.org>
In-Reply-To: <20260929154125.3298-4-socketcan@hartkopp.net>
References: <20260929154125.3298-4-socketcan@hartkopp.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In net/can/af_can.c, can_get_unshared_skb_ext() uses the wrong
  test to decide whether the CAN skb extension is shared.
- [Medium] A UID set before transmission survives the new extension
  unsharing, so duplicated or mirrored copies of such frames still share…

--

can: fix unique skb identifier regression under RPS

This patch moves the CAN per-skb unique identifier used for raw_rcv()
duplicate detection from skb->hash into a new can_skb_uid field in
struct can_skb_ext. The UID is now assigned in can_rcv(), canfd_rcv()
and canxl_rcv() after the CAN skb extension is made private for cloned
skbs, and can-gw and vxcan reset it for forwarded frames.

Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index ef435f22ac933..4aa233d7e8a1d 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c

[ ... ]

> @@ -684,11 +679,22 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
>  	}
>  }
>  
> +static struct can_skb_ext *can_get_unshared_skb_ext(struct sk_buff *skb,
> +						    struct can_skb_ext *csx)
> +{
> +	/* create unshared CAN skb_extension for netem/mirred skb clones */
> +	if (unlikely(skb_cloned(skb)))

[Severity: High]
Is skb_cloned() the right test for whether the extension is shared?

skb_cloned() only tells you whether the packet data is shared through
shinfo->dataref. The skb_ext has its own refcount.
__copy_skb_header() shares the extension through __skb_ext_copy() for
copies as well as clones:

include/linux/skbuff.h:__skb_ext_copy() {
    ...
        refcount_inc(&ext->refcnt);
        dst->extensions = ext;
    ...
}

So results of skb_copy(), pskb_copy() and skb_unshare() have private
data but still share the CAN extension with their source.

One way to reach this is netem with duplicate and corrupt on a CAN
device:

net/sched/sch_netem.c:netem_enqueue() {
    ...
        skb2 = skb_clone(skb, GFP_ATOMIC);
    ...
        skb = skb_unshare(skb, GFP_ATOMIC);
    ...
}

After this, skb2 has dataref == 1 and the copy has private data, so
skb_cloned() is false for both. They still point to the same skb_ext
with refcnt == 2.

Echo skbs from can_create_echo_skb() on IFF_ECHO devices (e.g. vcan
echo=1) can end up in the same state once the parent is consumed.

In that case can_get_unshared_skb_ext() returns the shared csx, and
can_set_skb_uid() writes can_skb_uid in place:

    while (!(csx->can_skb_uid))
        csx->can_skb_uid = atomic_inc_return(&skbcounter);

The second frame then sees a non-zero UID and keeps it. Doesn't this
contradict the commit message statement that "independently received
clones never end up with the same UID"?

With a shared UID, raw_rcv() can again drop a legitimate frame when the
slab reuses the skb address on the same CPU:

    if (this_cpu_ptr(ro->uniq)->skb == oskb &&
        this_cpu_ptr(ro->uniq)->can_skb_uid == csx->can_skb_uid) {

If the two frames go through can_rcv() on different CPUs, the
check-then-store in can_set_skb_uid() is also an unsynchronized write
into memory that both skbs share. The UID could then change while
raw_rcv() on the other CPU is between filter matches. Could that break
the join_filters counting?

skb_ext_add() already does the refcount-based check in
skb_ext_maybe_cow():

    if (refcount_read(&old->refcnt) == 1)
        return old;

Would it be enough to call skb_ext_add() unconditionally here, or to
check the extension refcount, instead of gating on skb_cloned()?

> +		return skb_ext_add(skb, SKB_EXT_CAN);

[Severity: Medium]
Does the private copy really get its own UID if the frame was already
tagged before transmission?

isotp_sendmsg() and isotp_send_cframe() call can_set_skb_uid(csx) on
the tx skb before can_send(). So the UID is already non-zero (say X)
by the time netem duplicate (skb_clone) or tc mirred mirror/redirect
copies the skb. Neither path resets the UID, unlike can-gw and vxcan
in this patch.

When such a clone reaches can_rcv() still cloned, skb_ext_add() goes
through skb_ext_maybe_cow(). That function copies the whole extension,
X included:

    memcpy(new, old, old->chunks * SKB_EXT_ALIGN_VALUE);

can_set_skb_uid() then leaves the non-zero X in place, so the private
copy keeps the same identity as the original.

Once can_receive() consumes the first copy, a later copy (the echo
clone from can_create_echo_skb(), or the mirrored frame) can be
allocated at the freed slab address. On the same CPU, a raw socket
that did not send the frame, such as candump, would then match both
uniq->skb and uniq->can_skb_uid in raw_rcv() and drop the frame as a
duplicate.

The commit message only explains why the UID is kept across the local
loopback path. Should duplicated or mirrored copies of pre-tagged
frames also get a fresh UID, so that the "never end up with the same
UID" claim holds?

> +	else
> +		return csx;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929154125.3298-1-socketcan%40hartkopp.net
