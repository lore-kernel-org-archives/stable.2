Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708423ED5D6;
	Tue,  6 Oct 2026 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292665; cv=none; b=fVh8Kr5gbCEG8Z+yXaWVbFgiYnF6/Mf+j5Ugzq0x+OSUdTI1pA9Swd4QilWIJ0qwrrGiKRD72tBAvqXCe+VOjIOskVX1YeNyESrJTf9ALC9MXmFVJ302ziH1ImT7KVd9YGfs+nN7wDN3Suai7eJ8qy/N5FsHDTy7s8Qy/Fafbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292665; c=relaxed/simple;
	bh=uCCDQHKiQ1WD3t9bncVW9QO65qcSW+LrGDAjCuW8mGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPl0QZkjThQVULDnj6hXXZ4QZA8FzVV/eOqnOxE1oNwT1LWCGKI+V6wv9E2hhonv/I4WZtRqtlZNMfZyyThaWiJW5hFeuXLJYPUMRq8KaNjhxTTs7vDF1s3TlCbRK8bCv/Mbu7ZgSljLXC2Dlf8yyHjs6eWrFfDVHNyFupCyS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=d3tTgvp0; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="d3tTgvp0"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hzc7k2vt2z6LqQ;
	Tue,  6 Oct 2026 15:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791292242;
	bh=uCCDQHKiQ1WD3t9bncVW9QO65qcSW+LrGDAjCuW8mGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d3tTgvp0Gugf+r/GpSQ8heVAUqHVY6oxbDSAtMMBR4sIx90Saoq3GxcaVENr6IVls
	 lCBsYpIg5nS97qrfBIxWoBAKehVAT5VYx3TO6no7a8Rwh8dEM3C8a4gPlN4q+/lW67
	 xygYWT0gSn8OViHjlnsld8wzsoDov4wtpTNMC6rjcKabK5Q7sAv7JBqrZpaQ7E47Bh
	 O2c4yc39lNmDTvoP5bb5NTg4UfFVStpmqmPgDRWcAKzTUMoQ8dpWevDfIoDLfHNd0h
	 7U8IomrSo6tmuGJIPbFlEnFTWZ9o51zdtJc+p+Gb9xrwGsWgAXJWi7MZ6NdQYpvTAn
	 ldyv6LgO7IyAQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hzc7k2BJkz4xpJ;
	Tue,  6 Oct 2026 15:10:42 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hzc7j4pzNz8tH6;
	Tue,  6 Oct 2026 15:10:41 +0200 (CEST)
Received: from [192.168.142.38] (90-182-211-1.rcp.o2.cz [90.182.211.1])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 017F25FB4E;
	Tue,  6 Oct 2026 15:10:40 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 90.182.211.1) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[192.168.142.38]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f73ca71a-8a22-495c-91a9-12d89968ac2c@leemhuis.info>
Date: Tue, 6 Oct 2026 15:10:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com,
 Sasha Levin <sashal@kernel.org>
References: 
 <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179129224130.3559709.5435972012489445442@mxe9fb.netcup.net>
X-NC-CID: 40GMaFCj8XTzy3SLEIrrdQalchxRrRhm+3W3Zn/aek0HDsVESko=

On 10/6/26 13:45, Jan Čermák wrote:
> 
> the Home Assistant OS recently shipped kernel update from 6.18.39 to
> 6.18.52 which was followed by a bunch of community reports about fatal
> network breakages [1] which had one thing in common - r8169 driver and
> configured VLANs. This manifested as network stall early in the setup
> of the system with dmesg events like this:
> 
>> r8169 0000:03:00.0 enp3s0: NETDEV WATCHDOG: CPU: 7: transmit queue 0 timed out 6125 ms
>> r8169 0000:03:00.0 enp3s0: rtl_rxtx_empty_cond == 0 (loop: 42, delay: 100).
> 
> As there was no change in the r8169 driver itself, I focused on the
> vlan subsystem, where AI pointed me shortly to this suspect commit in
> the range: 1517d1996b5236fe69eccd9d253f725e06996eb1 ("vlan: fix
> skb_under_panic and races when toggling HW VLAN offload"), added in
> 6.18.51. I'm not referring to the mainline counterpart below for
> regzbot (447cbe95ebb9) as I can't confirm whether it triggers the bug
> there as well. FWIW there was another issue [2] with a similar
> combination recently in the regressions ML but that one seems
> unrelated, as disabling EEE fixed that issue, and it doesn't fix it
> here.

Not my area of expertise, so take the following carefully, as it might
send you in the wrong direction:

There is another issue known for 447cbe95ebb9:
Commit 447cbe95ebb9 causes IOMMU DMA faults on macvlan/vlan with bnxt_en
https://lore.kernel.org/all/20261004122616.56714cbd@nargothrond/

A fix for it is under review:
bnxt_en: fix DMA mapping length for padded small packets
https://lore.kernel.org/all/20261006042153.199444-1-edumazet@kernel.org/

Is that maybe related?

Ciao, Thorsten



> I don't have the hardware myself, I asked for testing with this commit
> reverted, which confirmed that this change indeed started to cause
> trouble. However, it's obvious that the change itself is not bad, as
> it fixes another issue and the regression is scoped to very specific
> hardware/setup combo.
> 
> Besides the revert, following workarounds were reported to fix the
> issue as well:
> - Disabling TX checksum offload with `ethtool.feature-tx off` in
> NetworkManager for the connection (HAOS doesn't have ethtool binary,
> hence this option instead of direct ethtool command)
> - Enabling REORDER_HDR with `ip link set enp1s0.100 type vlan reorder_hdr on`
> 
> Clearly, this needs rather esoteric setup to trigger the bug - I guess
> most systems set the REORDER_HDR flag by default, however, due to some
> legacy in the DBus interface that HAOS stack uses to configure the
> network [3], it was disabled. Anyway, I think that disabling it should
> not lead to driver breakage as we're seeing.
> 
> So far it appears that this only affects RTL8168h/8111h, XID 541 -
> there isn't any report of another chip/XID combination yet.
> Unfortunately, as I said above, I don't have the hardware available
> for testing but I believe I'll find some community members who'll be
> willing to test a proposed fix for the issue if needed.
> 
> [1] https://github.com/home-assistant/operating-system/issues/5019
> [2] https://lore.kernel.org/regressions/353419280.954808.1790290283530@mail.yahoo.com/
> [3] https://github.com/home-assistant/supervisor/issues/7248
> 
> #regzbot introduced: 1517d1996b5236fe69eccd9d253f725e06996eb1
> #regzbot link: https://github.com/home-assistant/operating-system/issues/5019
> 
> Cheers,
> Jan

