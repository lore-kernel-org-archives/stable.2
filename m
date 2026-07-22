Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10633204C3B;
	Wed, 22 Jul 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726360; cv=none; b=iZPkvLr/sTY4zbX8jVBQvZpkSJhLhCMUsU7XsFqoYHwY5FZd9lBLa3oK/8ARB6RYm15neQGjuv3x17hUMdjo2JVJqlgfE9AhHwFuOkczOPY93hFBJFKsvY7KAl8W8Mh1e4BDwj4r0cBGpAnORLSh/KVkvVN3leqvGkzYiIlGzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726360; c=relaxed/simple;
	bh=JSBkiNzFfavHvbp9/1HikK4JUTMwJSEzZ5l4BpJfcZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bPgnqrNjqLpgPFrN30bmGDvf/dJonFLe6CiKFh3eN5UapZGrj5e7l7ZYN8D5XIVWnFL4dCdVxS7X2mZeOZ1n8iPV+nLJ93wp1kL1oA/ISwtkPQlGnassCgHTT+1q6ysGL1hyI2l0hnq1Tjed8XrJ578/MEhtViBiIGfpkKReyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=uX3g+YWJ; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=uX3g+YWJ; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=q4EF+sV7; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="uX3g+YWJ";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="uX3g+YWJ";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="q4EF+sV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784726349;
	bh=JSBkiNzFfavHvbp9/1HikK4JUTMwJSEzZ5l4BpJfcZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uX3g+YWJL3g5Mhpninbb4NO/34fpP/LCLUi6OdJRKfu8G7qO8hwpKfzz9LM8Fg3pF
	 6ZkQyyjhtUqg45iXu7K7hesd9R98MMOk33JiB651vXx4uis97/eVccSN/v2K28uLJI
	 30ek5minVjAjx6TDDcIJRHpk0XahkkWqGMs+GKwnN1UaWlxxmqld6KMJeAo7wIeMKC
	 iRFZ7tps+zvOetqZRjnU8HvGiL5EADYPM2BF2C6jxXPYBAs5d0/+FoAZzq7rvO7KHE
	 4gFfGLOs/gF32Zcjcuu3F/GAz1wkOUigMFJj18wtt7s1e5yRIcPHid72WMwKzfaXcB
	 ZIenkDZwgGMdA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A0DBD17E32;
	Wed, 22 Jul 2026 15:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784726349;
	bh=JSBkiNzFfavHvbp9/1HikK4JUTMwJSEzZ5l4BpJfcZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uX3g+YWJL3g5Mhpninbb4NO/34fpP/LCLUi6OdJRKfu8G7qO8hwpKfzz9LM8Fg3pF
	 6ZkQyyjhtUqg45iXu7K7hesd9R98MMOk33JiB651vXx4uis97/eVccSN/v2K28uLJI
	 30ek5minVjAjx6TDDcIJRHpk0XahkkWqGMs+GKwnN1UaWlxxmqld6KMJeAo7wIeMKC
	 iRFZ7tps+zvOetqZRjnU8HvGiL5EADYPM2BF2C6jxXPYBAs5d0/+FoAZzq7rvO7KHE
	 4gFfGLOs/gF32Zcjcuu3F/GAz1wkOUigMFJj18wtt7s1e5yRIcPHid72WMwKzfaXcB
	 ZIenkDZwgGMdA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 8834517E31; Wed, 22 Jul 2026 15:19:09 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784726345;
	bh=JSBkiNzFfavHvbp9/1HikK4JUTMwJSEzZ5l4BpJfcZc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=q4EF+sV7A+lJMdrdu4rEL8C4VV3XdvXWXorAJZdd9dLqSH/3Z1CEX8p5fiaKqWQMN
	 NF7I116zpqSVn+jRDn5ajcLYeoKuu52cODMNQjiW89Irf8MmuCkgMMYKJjZBdr9iWR
	 VCVJuxAp3rZiPW/6S2asqiNflIUb0JCvRK4z6+/bh3ZAeFJrPRYuQRJcSXSnuVCOGi
	 jR1eOqiO4X7vAR6CtW/2AzzY9apijaM/s8FtovtBsAOIxUng/sZQ2EdSYVfiz/zCWj
	 OEITOep3p4SENIxiFT3CaCCBFtKT9WG08kbdo4TteeLVAEEJsrdY68CW3y3KfUftQz
	 WNl0kJjKz9K+Q==
Received: from sara (unknown [IPv6:2001:9b1:efc:9600:3f5e:3c30:ddba:e325])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id D57E317E2E;
	Wed, 22 Jul 2026 15:19:04 +0200 (CEST)
Date: Wed, 22 Jul 2026 15:19:04 +0200 (CEST)
From: Peter Astrand <astrand@lysator.liu.se>
To: Thorsten Leemhuis <regressions@leemhuis.info>
cc: linux-wireless@vger.kernel.org, 
    "stable@vger.kernel.org" <stable@vger.kernel.org>, 
    Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: iw scan hangs in netlink ENOBUFS loop with kernel 6.6.99+
In-Reply-To: <e2555ce7-0313-4fec-8bc4-739b51a009f3@leemhuis.info>
Message-ID: <e12fc0b9-dfd2-ecfc-de54-d5f7d4532044@lysator.liu.se>
References: <19b022d0-76ff-23cc-ba63-f00fedc65ed1@lysator.liu.se> <e2555ce7-0313-4fec-8bc4-739b51a009f3@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP


On Tue, 21 Jul 2026, Thorsten Leemhuis wrote:

> On 7/14/26 00:37, Peter Astrand wrote:
> > 
> > kernel 6.6.y
> > iw 6.7
> > libnl-genl-3-200 3.9.0
> > mac80211_hwsim
> > 
> > With kernel 6.6.99 and later, "iw dev <device> scan" sometimes hangs in 
> > busy loop:
> 
> Thanks for the report. We need to rule out if this is a 6.6.y specific
> problem (like a broken or incomplete backport) or something general.
> Could you please check if 7.2-rc is affected as well? Testing 6.18.y
> might help, too, if it's easy for you to try. Maybe switching to that
> might be the easies way to resolve the problem and a good idea in
> general, as explained here:
> http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/

Platform is NXP imx6ull. Forgot to mention that we are actually running 
https://github.com/Freescale/linux-fslc/tree/6.6-2.2.x-imx rather than 
upstream kernel. No changes to net/netlink though.

We cannot easily test with 7.X, but I have tested 
https://github.com/Freescale/linux-fslc/tree/6.18-2.0.x-imx and can 
reproduce the same problem; this is 6.18.20. strace output is similar:

recvmsg(3, {msg_namelen=12}, 0)         = -1 ENOBUFS (No buffer space available)
recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=48, nlmsg_type=NLMSG_ERROR, nlmsg_flags=0, nlmsg_seq=2510255223, nlmsg_pid=1468011032}, {error=-ENOBUFS, msg=[{nlmsg_len=28, nlmsg_type=0x1b /* NLMSG_??? */, nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK|0x300, nlmsg_seq=2510255223, nlmsg_pid=1468011032}, "\x20\x00\x00\x00\x08\x00\x03\x00\x0d\x00\x00\x00"]}], iov_len=16384}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_PEEK|MSG_TRUNC) = 48

Br,
Peter


> 
> Ciao, Thorsten
> > recvmsg(3, {msg_namelen=12}, 0)         = -1 ENOBUFS (No buffer space available)
> > recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, 
> > msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=48, nlmsg_type=NLMSG_ERROR, 
> > nlmsg_flags=0, nlmsg_seq=2511084235, nlmsg_pid=-1866444344}, 
> > {error=-ENOBUFS, msg=[{nlmsg_len=28, nlmsg_type=0x18 /* NLMSG_??? */, 
> > nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK|0x300, nlmsg_seq=2511084235, 
> > nlmsg_pid=-1866444344}, 
> > "\x20\x00\x00\x00\x08\x00\x03\x00\x0e\x00\x00\x00"]}], iov_len=16384}], 
> > msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_PEEK|MSG_TRUNC) = 48
> > 
> > This issue appears with kernel 6.6.99 and later, even latest version 
> > 6.6.144. 
> > 
> > If I revert these commits:
> > 
> > 346c820ef513 netlink: avoid infinite retry looping in netlink_unicast()
> > c31ee1695b6d netlink: make sure we allow at least one dump skb
> > ce2ac2e46719 netlink: Fix rmem check in netlink_broadcast_deliver().
> > 55baecb9eb90 netlink: Fix wraparounds of sk->sk_rmem_alloc.
> > 
> > ...then 6.6.144 works fine as well. Seems like there is a regression here. 
> > Any ideas? 
> > 
> > Br,
> > Peter Astrand
> > 
> 
> 
> 
