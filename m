Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745DF372EEF;
	Tue, 21 Jul 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631503; cv=none; b=sB8qYBWbfkWz9klI1JuNLWh18UEnaBYElcXR/KTmagNVvcTGp5O6jZ2wJTXIrzlD3bdtreRSMOGy2b5xxXEYTEdWEylEa8XHKnKyhqoY4rPkTBGys4MoFM37oLLYwu3IenEgll8tUXwxuiAeVVbjHKyq8sQwjUwYZvOgKYVINGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631503; c=relaxed/simple;
	bh=5ERNSbrgHsBf+Kc422Gd9piA11oc+mCc2IKVHlCSe14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=OhlIuh57EXRC2/Pv+cOjWE4SpUm5qD4++ny9LoIfjd+ywvG7OF3TTPj7cdezpU6Lv//9+bCLK6fnwIZ5ZQSHmoD9vy9fTZZ1pYmXxEPllkkesiROIlh54jKTVl3NwyNlzvqWc5C6qoDcuEgXHfh67TBOIPnQlP0ZgmU591CPwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QMJRwrJo; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QMJRwrJo"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4h4Ddw6fFvz4GK4;
	Tue, 21 Jul 2026 12:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784630948;
	bh=5ERNSbrgHsBf+Kc422Gd9piA11oc+mCc2IKVHlCSe14=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=QMJRwrJonYk4zTGopCFJX8HLYvA6vnsIGKN2gS+/X3XllzwKgCosqFsYVxWGK0JOQ
	 Yb7JR77m2JYqONoMiwx+w5DQ4wBGFFMwkJddZUlPhe7qLM3bZYYmEQRXxdcXBNvAtQ
	 wmLQkrEqJOuoTn9erYxiMAzQzm/mPdHHi/I3OPqv5jOOw9AhjVZA62EhsZO6NWGGN3
	 r2dPf+uUbI10LU56V9CKYkUJ8wwmKFejLZXhi+VNREvkB/PNCtiUjblKCyXMGqkY0H
	 nRUAqWq77V+fmeQY5FazmWqBMsX974kgXJJ5UNRZAhfnk1wf/Ic436uRaiFYxDXoS4
	 NAigCl2o0RDYw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4h4Ddw5wTFz7w5b;
	Tue, 21 Jul 2026 12:49:08 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h4Ddw1J47z8sb9;
	Tue, 21 Jul 2026 12:49:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DE0CE5F94C;
	Tue, 21 Jul 2026 12:49:06 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e2555ce7-0313-4fec-8bc4-739b51a009f3@leemhuis.info>
Date: Tue, 21 Jul 2026 12:49:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iw scan hangs in netlink ENOBUFS loop with kernel 6.6.99+
To: Peter Astrand <astrand@lysator.liu.se>, linux-wireless@vger.kernel.org
References: <19b022d0-76ff-23cc-ba63-f00fedc65ed1@lysator.liu.se>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <19b022d0-76ff-23cc-ba63-f00fedc65ed1@lysator.liu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178463094785.1041444.13436106746578465653@mxe9fb.netcup.net>
X-NC-CID: YnC2l/69BSGLRFDnFtUiaUr0qZ5ck+X0sjG/ys6pRKLiIBSABWI=

On 7/14/26 00:37, Peter Astrand wrote:
> 
> kernel 6.6.y
> iw 6.7
> libnl-genl-3-200 3.9.0
> mac80211_hwsim
> 
> With kernel 6.6.99 and later, "iw dev <device> scan" sometimes hangs in 
> busy loop:

Thanks for the report. We need to rule out if this is a 6.6.y specific
problem (like a broken or incomplete backport) or something general.
Could you please check if 7.2-rc is affected as well? Testing 6.18.y
might help, too, if it's easy for you to try. Maybe switching to that
might be the easies way to resolve the problem and a good idea in
general, as explained here:
http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/

Ciao, Thorsten
> recvmsg(3, {msg_namelen=12}, 0)         = -1 ENOBUFS (No buffer space available)
> recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, 
> msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=48, nlmsg_type=NLMSG_ERROR, 
> nlmsg_flags=0, nlmsg_seq=2511084235, nlmsg_pid=-1866444344}, 
> {error=-ENOBUFS, msg=[{nlmsg_len=28, nlmsg_type=0x18 /* NLMSG_??? */, 
> nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK|0x300, nlmsg_seq=2511084235, 
> nlmsg_pid=-1866444344}, 
> "\x20\x00\x00\x00\x08\x00\x03\x00\x0e\x00\x00\x00"]}], iov_len=16384}], 
> msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_PEEK|MSG_TRUNC) = 48
> 
> This issue appears with kernel 6.6.99 and later, even latest version 
> 6.6.144. 
> 
> If I revert these commits:
> 
> 346c820ef513 netlink: avoid infinite retry looping in netlink_unicast()
> c31ee1695b6d netlink: make sure we allow at least one dump skb
> ce2ac2e46719 netlink: Fix rmem check in netlink_broadcast_deliver().
> 55baecb9eb90 netlink: Fix wraparounds of sk->sk_rmem_alloc.
> 
> ...then 6.6.144 works fine as well. Seems like there is a regression here. 
> Any ideas? 
> 
> Br,
> Peter Astrand
> 

