Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA2429036;
	Fri, 25 Sep 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323375; cv=none; b=kScY9lUeh1kBz/aOA/98EJ+sIIoQR9Esfa7DhDJ+7uYP0DgXjjnIp81nUD6+GauP/m8vH+w68n0uqmtl+pU2EARS18ZZ3U1HToJzL/GUQh3+9F779w3yGjrOl4+BUIzSWWp4FidyWckT4F2vcq1LBWwkLIDQFFpaaJFHQMKbEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323375; c=relaxed/simple;
	bh=AYSqMTtE1fV4VjXlqjLWaSe80ghKeBur//2SbcdzhZM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+orv8WPi+lLOjEoqQuVXY2kw9IkezVJ+siVVtwIM5srfmy5jm6cCDoGn/E4OD1E4cSuR4G72uq1ujb4xJOH8uQP9rDq8R8S/Tr52qWpbAGb6Wwui2ScoURbum9A64RP8uZIKg+XIJlLGmELFHxEhvfqpjuEKTqNZk53JFFfvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cACoKe0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cACoKe0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1C71F000FF;
	Fri, 25 Sep 2026 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790323374;
	bh=gVjg6yAH4af8nJpcF1EN2HhLt3HM9n0qHsdjGQwzX8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cACoKe0W1HHQyAMonJg2IpATZHeHsgCpjWE0rA/wipMRFaFQJ6IUHci9zCBy8nmEB
	 /O37nR+wF5oGej1gW3HwCCypyTQ4+5+BCPlymUAE8vhcBdZol7Shq19PP7CBOvSMyE
	 Wc3whWLe/YgNMR1VTswNenFOcBA9KsddvB+NVqxwhCzKug5L+RCznpTG6VqiXxCU6d
	 b/KeVzTTO1r8irD6zT37XixKbdtCD/ybb1dEWDlODLMw3eU2kCWH3NIxSvuG2qw004
	 Pg3oiPJzBQSjsEHY2vFxvzsyIGkfijRhJWtK+Hp73k/7WnEv3UoshA9OV/+OM8WAA7
	 xDLJTrPwHrMaQ==
Subject: Re: [PATCH net v2] af_packet: fix integer overflow in
 prb_calc_retire_blk_tmo()
From: netdev-bot+sashiko@kernel.org
To: zhangdairui@gmail.com
Cc: netdev@vger.kernel.org, willemb@google.com, daniel@iogearbox.net,
 stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 25 Sep 2026 08:02:53 +0000
Message-ID: <179032337381.2160803.13389684683115214605@kernel.org>
In-Reply-To: <20260923050101.1510064-1-zhangdairui@gmail.com>
References: <20260923050101.1510064-1-zhangdairui@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the negative timeout needs `div == 1`,
  i.e. a 1 Gbps link.
- [Low] The commit message says the reproducer "needs CAP_NET_RAW (a
  --network host container has it by default) and a 1 Gbps NIC (QEMU…

--

af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

This patch makes prb_calc_retire_blk_tmo() compute mbits in 64-bit
arithmetic. The old 32-bit int product could wrap negative for large
TPACKET_V3 block sizes. The negative result then armed the retire hrtimer
with a negative relative timeout, and the timer re-fired forever.

> The condition is actually (8 * size) mod 2^32 >= 2^31 && div == 1,
> so the trigger set is [256,512), [768,1024), [1280,1536) and
> [1792,2048) MiB. Other sizes wrap to non-negative values and faster
> links divide the unsigned value back below 2^31, which is why this
> doesn't blow up for everyone.

[Severity: Medium]
Does the negative return really need div == 1?

In the pre-patch prb_calc_retire_blk_tmo(), a link reporting 2000-2999
Mbps (for example SPEED_2500, so div == 2) can also return a negative
value. The final unsigned increment is what pushes it over:

    div = ecmd.base.speed / 1000;
    mbits = (blk_size_in_bytes * 8) / (1024 * 1024);

    if (div)
        mbits /= div;

    if (div)
        return mbits + 1;

Take tp_block_size = 0x1ffe0000. It is positive as an int and page
aligned, so packet_set_ring() accepts it:

    blk_size_in_bytes * 8    = 0xfff00000 (-1048576 as int)
    / (1024 * 1024)          = -1, so mbits = UINT_MAX
    mbits /= 2               = 0x7fffffff
    return mbits + 1         = 0x80000000 (INT_MIN as int)

ms_to_ktime() takes a u64, so INT_MIN is sign-extended and multiplied by
NSEC_PER_MSEC, which gives a negative ktime. init_prb_bdqc() passes that
to hrtimer_start(). prb_retire_rx_blk_timer_expired() keeps returning
HRTIMER_RESTART, so the timer spins just as it does when div == 1.

More generally, with div == 2 the old int quotient only has to be -1 or
-2. That covers sizes about 128-384 KiB below each 512 MiB multiple
(512, 1024, 1536 and 2048 MiB).

The u64 arithmetic in this patch fixes these sizes too. Could the
description of the trigger condition be corrected, so that stable and
security triage also covers 2.5 Gbps links?

> Reproducer, needs CAP_NET_RAW (a --network host container has it by
> default) and a 1 Gbps NIC (QEMU e1000 works):

[Severity: Low]
Is the set of users who can reach this wider than described here?

packet_create() checks the capability against the user namespace that
owns the netns:

    if (!ns_capable(net->user_ns, CAP_NET_RAW))
        return -EPERM;

Root inside an unprivileged user namespace passes this check.

The same user can create a tun device in its own netns, since
tun_set_iff() checks ns_capable(net->user_ns, CAP_NET_ADMIN). It can also
set the device speed with ETHTOOL_SLINKSETTINGS:

- dev_ethtool() does the same ns_capable() check.
- ethtool_set_link_ksettings() does not validate the speed.
- tun_set_link_ksettings() copies the settings unchanged:

    memcpy(&tun->link_ksettings, cmd, sizeof(*cmd));

prb_calc_retire_blk_tmo() then reads that speed back through
__ethtool_get_link_ksettings() for the bound ifindex:

    unshare(CLONE_NEWUSER | CLONE_NEWNET)
      -> TUNSETIFF
      -> ETHTOOL_SLINKSETTINGS with speed = 1000 (or 2500)
      -> socket(AF_PACKET), bind to the tun device
      -> PACKET_VERSION = TPACKET_V3, PACKET_RX_RING

On systems that allow unprivileged user namespaces, this seems to let an
unprivileged local user start the maximum-rate soft hrtimer with no real
hardware. Would it be worth saying so in the commit message?

The same tun setup could also be used to test the fix at runtime. The
notes say the patch was only compile-tested because no 1 Gbps setup was
available.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923050101.1510064-1-zhangdairui%40gmail.com
