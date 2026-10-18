Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB1366DD3;
	Sun, 18 Oct 2026 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792293466; cv=none; b=T8+47P1ibenPKGDF7YXzgpDec1Wl0suReUwBkHEetMSqXQpaKjfzyaxVAs8L5ghciErJGdHmBqgcGvepTpApnRf8AK7fGYA44T7rFZwF5MPL7EAjKJiX1lZcT+ONYWe6Yaq9938cluyBEx01ER+kQsSubglRnZdF+FrGYGjsvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792293466; c=relaxed/simple;
	bh=Vb+ei8N3NRQz/AMvH9MLTC6259M+aZ0Bg/jP410ctPQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEpUxfTZwmnrriMEsQs14Y8OJPE569wXjy38yfPmhCkrfh/wbm8QUsTBZ2EGT1ctqlPtIbRPpMak0fhe6Pgbx4YG5ojZJtvTBn+O/+oKjZxd9JhKTiwBgdtjc4vwikEmqr5sGNDENSYilGngJ37K1kySDLPtrDGkA/VGSQlYQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2QqiDhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2QqiDhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A21F000C4;
	Sun, 18 Oct 2026 03:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792293465;
	bh=yqieXVip+Y0+11WxWPmjTLS4Expr9Kk2s6GQ/K7PRo8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2QqiDhmAGa4krixvX1h5yNduq5tKZqeQj03+TKGTt48YPwP/CmDzoMU+10+m+ayN
	 FXJsZYl7UtrjVzbxkbi5XAJWkJoj2vVf6RMbqNsU/ZriqgWZFL60AyRjErS1Yk8YDl
	 hCxbOdVVWjgRFaolUovh8ShhNCfGthdSr0vGnT/5HBJN1DP/+MaCfZp6buno8WHSK1
	 BcpDUr8l5cylxlU0k0qjdtevFdXOqnL83z+3LUqBtIVSFMmjSjY4yBi00+Cd1+jDUL
	 YIY9FrJqIgQiQujI1KPuoSe7See1L+zg1LLBjVAdaLWREXv3Oa6VNzkUpLYXIb0fO7
	 uuaqbSiJkKqeg==
Subject: Re: [PATCH net 2/2] net: usb: lan78xx: reject short register and
 statistics reads
From: netdev-bot+sashiko@kernel.org
To: law.wei.jie@gt.tech.gov.sg
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, woojung.huh@microchip.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, 98lawweijie@gmail.com, stable@vger.kernel.org
Date: Sun, 18 Oct 2026 03:17:43 +0000
Message-ID: <179229346399.3135.12116533277810426921@kernel.org>
In-Reply-To: <20261014025602.26334-3-law.wei.jie@gt.tech.gov.sg>
References: <20261014025602.26334-3-law.wei.jie@gt.tech.gov.sg>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Three statements in this commit message (tagged for stable) do
  not match the code at its parent.

--

net: usb: lan78xx: reject short register and statistics reads

This patch makes lan78xx_read_reg() and lan78xx_read_stats() return -EIO
when usb_control_msg() transfers fewer bytes than requested. Before this,
uninitialized kmalloc() memory could be used as a register value or as the
statistics counters.

> With an emulated device on a kernel booted with init_on_alloc=0:
>
> - A zero-length reply to the statistics request makes ethtool -S, which
>   needs no privileges, report the stale contents of the kmalloc-192
>   buffer. One counter pair read back as 0xffffffff8a427800, the
>   address of usb_api_blocking_completion(), next to several direct
>   map pointers.
>
> - A zero-length reply to the RX_ADDRL/RX_ADDRH reads in
>   lan78xx_init_mac_address() turns uninitialized heap memory into the
>   MAC address (12:85:1f:dc:2e:bd and e6:93:44:41:9b:9f on two probes),
>   which is then written back to the device in RX_ADDRL/RX_ADDRH and
>   MAF_LO(0)/MAF_HI(0).
>
> Treat a short transfer as -EIO in both helpers. With this change the
> same device fails to probe with -EIO, and with only the statistics
> reply cut short all counters stay zero.

[Severity: Medium]

Can the zero-length statistics case still be reproduced at this patch's
parent?

The previous patch in the series, "net: usb: lan78xx: do not update
statistics after a failed read", already updates curr_stat only when the
return value is positive:

drivers/net/usb/lan78xx.c:lan78xx_update_stats() {
    ...
	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
		lan78xx_check_stat_rollover(dev, &lan78xx_stats);

		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
			data[i] = (u64)p[i] +
				  ((u64)count[i] * ((u64)max[i] + 1));
	}
    ...
}

A zero-length reply makes usb_control_msg() return 0. Then
lan78xx_read_stats() returns 0 and dev->stats.curr_stat is never written.

With that patch applied, it looks like only a partial reply of 1 to 187
bytes still leaks the uninitialized tail of the kmalloc() buffer. The
message doesn't mention that case.

For the same reason, wouldn't "with only the statistics reply cut short all
counters stay zero" also be true without this patch when the reply has zero
length?

Could the message also mention that it depends on the previous patch? Both
patches are Cc: stable, but they have different Fixes: tags (20ff55655a93
and 55d7de9de6c3).

If this patch is backported alone, lan78xx_read_stats() returns -EIO
without writing data. The old lan78xx_update_stats() still runs the loop
unconditionally:

	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
		lan78xx_check_stat_rollover(dev, &lan78xx_stats);

	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));

The heap leak would then become a leak of the uninitialized on-stack
lan78xx_stats through ethtool -S, and the counters would not stay zero.

In the MAC paragraph, is the RX_ADDRL/RX_ADDRH write-back accurate? In
lan78xx_init_mac_address(), those registers are only written when the
address is invalid, after addr has been replaced from DT, EEPROM, OTP or a
random address:

	if (!is_valid_ether_addr(addr)) {
		...
		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
		...
		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
		...
	}

	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);

Both quoted addresses (12:85:1f:dc:2e:bd and e6:93:44:41:9b:9f) are valid
unicast addresses, so they skip that block. Only MAF_LO(0)/MAF_HI(0) and
the netdev address set by eth_hw_addr_set() receive the value taken from
the heap.

The code change itself looks correct.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014025602.26334-1-law.wei.jie%40gt.tech.gov.sg
