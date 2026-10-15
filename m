Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00C4DF4CB;
	Thu, 15 Oct 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055149; cv=none; b=t57kgIAivriB17oOyITK0yI5ixSl/hkxNASuQy5akmOkjMtNQmQljjGkURVsbdIzSFJZQIebb0Igj1druV3aEBOLp3j+NlgI4W95azEu/KMiBU2cWQFX4VdrqqTcp73kTeMV1q27n12ikoD7HGXIG1zCMr29AxTA3sLx7IsmCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055149; c=relaxed/simple;
	bh=6mmhDBw7AYNyYv2VAOqVILYc/86dDgxgQa0qzZICyDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d830C34hqEnh/TaXXGryXOpT/fPVItKNc866KitV6/8CiZ1k3f6ULfiBmsUht4dxBTIkTageHGw23PhviXmxeCSqBUtJprFTC9/ofuRIMz4GrkvTpZ+dHQQYn+rzMueFy0APUf6CH4CO+R9Jp4LDZrRRdJS6touWfvMjiWKrIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DLiBQe3C; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DLiBQe3C"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j52Fj2NPbz61kk;
	Thu, 15 Oct 2026 11:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792055081;
	bh=6mmhDBw7AYNyYv2VAOqVILYc/86dDgxgQa0qzZICyDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DLiBQe3CMBENSolMUVdI5cLvOZawGRHH8sg2E1eHxTlZuCwCvUejLUlG3UiJMR+Mo
	 n2eoaDtk3lJzTrQjIffMhL+QzlYfY1YTOEWaXCqopZCNfA/qp0ve71fM65/z3uRQFE
	 mtZjmdbaoIU5/iZLxqRL49u3kzGylru5N5y6yGarEbjpXZk2haUQ6vmInDQtOqV43O
	 0Vs6LyjlNM/KYxDQBTKWMBMEUgDxnkANIHpyQh3QLh8xvUqhemQCT+0ZC17BRjXSMk
	 EIHsRzUoXFqGbHH3+1zp0lfXQH+T6n5L3DpN4UgJK8TYyKPv/48DpPRn7pogGv0J77
	 55qNyxxRN8n9Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4j52Fj1dj0z4xFy;
	Thu, 15 Oct 2026 11:04:41 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j52Fh47wKz8svT;
	Thu, 15 Oct 2026 11:04:40 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 898AC5F9A7;
	Thu, 15 Oct 2026 11:04:33 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <9776e821-f95e-4ee4-8595-4bbf4b48ad36@leemhuis.info>
Date: Thu, 15 Oct 2026 11:04:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.12.111: "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU" breaks TCP through relays when the
 peer's network drops ICMP
To: Echoo Wall <echoowall@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179205507390.3469799.11823592184201869523@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 898AC5F9A7
X-NC-CID: Va6iAVlA+hoISRnTWMmySDrOgAxF0kZ5QKT/h7sMFrDAgeZLz8c=

On 10/9/26 18:27, Echoo Wall wrote:
> 
> After a routine stable update from 6.12.107 to 6.12.111 (Debian trixie-security,
> 6.12.111-1), TCP connections to our servers started timing out for a subset of
> clients. Booting back to 6.12.107 / 6.12.101 fixed it immediately. I believe the
> cause is:
> 
>   2640e64195948a601430d230c9864f5426574cde
>   net: advertise TCP MSS from the configured MTU, not the learned PMTU
>   (in stable 6.12.111 and 6.18.51)
> 
> #regzbot introduced: 2640e64195948a601430d230c9864f5426574cde

Thx for the report. That is a mainline commit, but this might be a
stable specific thing due to a broken backport. These cases in the end
might be handled by different people, so somebody needs to check which
if the two it is. Could you thus check if 7.3-rc7 or later is still
affected? If it is, please try to check if reverting the commit fixes
things; if it is not, please check a revert with the stable series you use.

Ciao, Thorsten
> Topology
> --------
> 
>   client ---(internet)---> relay (Linux, nftables DNAT + masquerade) ---> server
>                                                                ^
>                                                  path MTU 1456 on this hop
> 
> - Servers have a 1500-byte interface MTU, but the path between the relay and the
>   server has a PMTU of 1456 (encapsulation upstream). The server learns this
>   correctly: `ip route get <relay>` shows `cache mtu 1456`.
> - Clients reach the server only through the relay (port-based DNAT, SNAT to the
>   relay address).
> - Some client networks (typical corporate firewalls) drop ICMP
>   "fragmentation needed".
> 
> Behaviour
> ---------
> 
> Before (<= 6.12.110): the server's SYN-ACK advertised MSS 1416, derived from the
> learned PMTU. Clients never sent segments that were too large. Everything worked,
> including from networks that filter ICMP.
> 
> After (6.12.111): the SYN-ACK advertises MSS 1460 from the configured MTU. The
> client sends 1500-byte packets. They are dropped at the 1456 hop, and the ICMP
> error never reaches the client because its network filters it. The handshake
> completes, then the connection stalls: a classic PMTU black hole.
> 
> Direct connections to the same servers, without the relay hop, keep working, and
> so do servers still on <= 6.12.110 behind the same relays. That made the problem
> very hard to attribute: it only appears from certain client networks, only on
> relayed paths, and only after a kernel update that nothing points to.
> 
> What I verified
> ---------------
> 
> - Reproducible per host by switching only the kernel. Rebooting without changing
>   the kernel does not help. Same sysctls on both kernels (309 TCP parameters
>   compared), same userspace.
> - On 6.12.107 the server has `cache mtu 1456` towards the relay, so the
>   SYN-ACK MSS is derived from it (1416). With this commit the advertised
>   MSS comes from the 1500-byte device MTU (1460) instead. That matches the
>   symptom exactly, but I have not yet captured a 6.12.111 SYN-ACK on the
>   affected path.
> - As a workaround we now clamp MSS on the relay
>   (`tcp flags syn tcp option maxseg size > 1416 tcp option maxseg size set 1416`
>   in the forward chain). I have not yet re-tested 6.12.111 behind it.
> 
> Why I think this matters
> ------------------------
> 
> The commit message argues that on symmetric paths nothing is lost because "the
> peer usually already knows the real path MTU". That assumption does not hold when:
> 
>   1. the peer sits behind a firewall that drops ICMP fragmentation-needed, which
>      is common in enterprise networks; and/or
>   2. the narrow hop is only on the server side (relay, tunnel or overlay egress),
>      so the peer has no way to learn it other than via ICMP.
> 
> In both cases the receiver-side PMTU knowledge was the only thing that kept the
> connection working. The old behaviour was effectively a built-in safeguard for
> these black holes, and it has been in place for a very long time.
> 
> This is now shipping as a security update in LTS/stable kernels and
> distributions. It silently breaks previously working deployments, and only for
> some users, so most operators will not connect the symptom to the kernel. The
> 6.6 / 6.1 / 5.15 backports appear to be still pending, so there may still be
> time to reconsider before it spreads further.
> 
> Possible ways forward (just suggestions):
> 
>   - revert from stable and keep it in mainline until there is a safer variant;
>   - make it opt-in (sysctl or per-route flag) for the asymmetric / DSR case it
>     targets;
>   - or only ignore the learned PMTU when there is evidence of asymmetry, instead
>     of unconditionally.
> 
> I am happy to test patches on the affected setup.
> 
> Thanks.
> Esko Mobius

