Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CB366051;
	Thu,  1 Oct 2026 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828796; cv=none; b=qFvAfJK1VKBaZeObJue9QX4as/qLGDNW2HOCKHU2wblaSeMGSA9utPA+aYE2tjiWgsMPECHYGnF9saNsW29ZZ4g8yLag4OZDXcKePupHxB4SqVpTY/w3mDLp1WZaWnGJmFer0a9hWGBTlSpcS1/07yx97YVrMEF66P0Jt6WeUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828796; c=relaxed/simple;
	bh=3Q0btvzME27VvOrz2f1Xq8sgl3iWM30+F/x6qGPpIBE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGeErc/fcASirqvD7b2YOPdciJePb3TnEh12bdG01ASiGV0hwfpN3YcpXY4EHz1v3QFusDWuXsLUNWeHGYEZyDfuFh6WI0KLDfcelO5SNlPzIOi+Vn0OJ62FaIjf008Y408dojL8LyoglPytkiJKAYIELBLTJzuBa0XrhJEJp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThldDxb+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThldDxb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146371F000FF;
	Thu,  1 Oct 2026 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790828794;
	bh=VDjHLJUvYGM7AtfLkzEUZQSHpcCntxchzE1D1viwYYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ThldDxb+OcBK1CSSBZK9iYY2u5Y9gsmE3AMn2oDfywx64WuawfnKO0EAKuBxqzLkW
	 8K3PpZrvi1JyvzaRbDXzML/xf38XmqEu+dcw09eI3y1xFIKpB5M8ALqwqf7I8COIz6
	 9NfUqZHbDJPi5mZp32yFLHxfxzgRzPBDo84VDRk8At/YeXuAhoFaIBNirFjfQHTgzh
	 AALWCbl8mmoN7x2RKXMHz3CvPaoIH5IFDXkMEcVRG72h2huwfRmDaI6f2/msQCsqm6
	 4DkQtkgrrYs++pxl9RBwixf0SNOToMk5pgbuacCKr2DAgGPf5nPZtAO6KPCMimVEhG
	 WgBTMb1tk1k2A==
Subject: Re: [PATCH net v4 1/2] net/sched: sch_cake: fix shaper stall on segs
 == 0 in cake_overhead()
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: toke@toke.dk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 01 Oct 2026 04:26:33 +0000
Message-ID: <179082879360.434549.1337490517221376378@kernel.org>
In-Reply-To: <20260928132452.59996-2-ndaugoing@gmail.com>
References: <20260928132452.59996-2-ndaugoing@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message's explanation of the failure is wrong, and it
  leaves out what actually triggers the stall.

--

net/sched: sch_cake: fix shaper stall on segs == 0 in cake_overhead()

This patch changes the single-segment early return in cake_overhead() from
segs == 1 to segs <= 1. A GSO skb whose cached segment count is 0 then
skips the multi-segment overhead arithmetic, which could charge a huge
length to the shaper.

> Because segs is an unsigned 16-bit integer, (segs - 1) underflows to
> 65535 (and is promoted to 4294967295 in the 32-bit unsigned arithmetic
> above). This multiplies the per-segment overhead by UINT32_MAX, so
> cake_overhead() returns a length close to 4.29 GB.

[Severity: Low]
Is this description of the arithmetic accurate?

segs is a u16, so (segs - 1) is promoted to int and evaluates to -1. It
never becomes 65535. It only turns into 0xffffffff when it is multiplied
by the u32 that cake_calc_overhead() returns.

The description also leaves out the last-segment term. With segs == 0:

    len = shinfo->gso_size + hdr_len;
    last_len = skb->len - shinfo->gso_size * (segs - 1);

last_len becomes skb->len + gso_size, so the old return value was in
effect:

    calc(skb->len + gso_size) - calc(gso_size + hdr_len)   (mod 2^32)

cake_calc_overhead() never decreases as len grows. So whenever
hdr_len <= skb->len, the result is small, roughly the payload size and a
slight undercharge, and the shaper does not stall.

The ~4.29 GB charge only happens when hdr_len > skb->len. In practice that
means a non-encapsulated skb whose transport header was never set. In that
case skb_transport_offset() is around 65300 and skb_header_pointer() fails.

That is the same case where qdisc_pkt_len_segs_init() returns early and
leaves pkt_segs at the raw gso_segs value, which can be 0:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
	qdisc_skb_cb(skb)->pkt_segs = gso_segs = shinfo->gso_segs;
    ...
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;
    ...
}

When the transport header is set, the later pskb_may_pull() calls in
qdisc_pkt_len_segs_init() guarantee hdr_len <= skb->len for TCP and
UDP_L4. For SKB_GSO_DODGY, gso_segs is recomputed with DIV_ROUND_UP() and
ends up at 1 or more. So an skb with segs == 0 and a valid transport header
does not stall the shaper.

The code change itself looks correct. Could the commit message correct the
promotion explanation? Could it also state that an unset transport header
is the precondition for the stall, so stable backporters can judge their
exposure?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928132452.59996-1-ndaugoing%40gmail.com
