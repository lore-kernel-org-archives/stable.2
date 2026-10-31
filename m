Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793443868;
	b=lvp1KxwUEvMPtpD6ydChzHBEXPU/j6FKTA9iBKWGjxCxzvxRNAuzIJMlP4fT3Dx0U5sm
	 21VzVkmDYAGJ/gRfA9d9L7TcQwQiwyuY+h/Si6CKWSwL9hNjqWQUvtPTTE3p8nBx+RAFK
	 iZXpzU3wcqUvLQn5WoVPAdZbNWkmnMnYLs7lyhwLMcjXCksQqn0C/hGGDg0FDvsOqOKxe
	 Z7+sK/0yzaEj8u7+6ymfSYFYnNJDzOPJ7vs4x9mNVrGFsVfQJ6c/4XxgGHijzMp8dwmLa
	 u6wKro/9HO88x+/DR3ZL6V6a4ou4E/wYbek6ixGMtdcCFzvzJNj7orc55AfQpmD6/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793443868;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B+jxDJoZ2NJnuhxlFqog+6PCeIn6ndLBhf8KyfLiV6k=;
	b=Yqum4gK7s9XRSVbOaOiF3WkATic99A5LK2P72yUKh02yiyvsAewJZt68fFmaGts1mPvw
	 dP0ACmboklmT1GMBo8eG3y5UVSrE7HfA7gTH56oPRuwVkmoqrgyoJ8UwWEjPGzANM8IPw
	 ZQ+yrA3KPjI2s/ggwKnUSHJj3BV35hT1FL0e2MmLmqHP60mzOa99h1cnzsU5+9h6xLdxx
	 +FyDZEiVWNEUMGyS3i+MJ9G93EPw/Iu86Rt0MmHvAQYyRsNLdPqLTOM6Zaayk6MbXvQIM
	 cHBVvq2X5KPoauHfnzn3OxWmf1sQyfgLugyXRoFkCdXmGmuwwGiUAPWomn7hmRvvcBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Jva9haJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D31606A31A;
	Sat, 31 Oct 2026 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Jva9haJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3054C1F000C1;
	Sat, 31 Oct 2026 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793443868;
	bh=B+jxDJoZ2NJnuhxlFqog+6PCeIn6ndLBhf8KyfLiV6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jva9haJ+ipJNYhfANxPztypI3ud9UGF+NpPwp+IoM8fuKJtLIWnQAa12TjZhTMUXm
	 HXjxlEeIJ6ozR3hBLCnXpnvttKpSekaWRc9uwodgoihZl4uvmOgmD395n47ZWwhsgb
	 GWnMvciZCDWg1G9JJcNu7MoJew5MJ3MYxwSCgNSM=
Date: Sat, 31 Oct 2026 11:51:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Struan Bartlett <struan.bartlett@newsnow.co.uk>
Cc: stable@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Subject: Re: [6.18.y] bonding: please apply 11ea9b8a88dd and 70fc6649b36c
Message-ID: <2026103152-plow-bounding-4370@gregkh>
References: <20261030225119.40765-1-struan.bartlett@newsnow.co.uk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030225119.40765-1-struan.bartlett@newsnow.co.uk>

On Fri, Oct 30, 2026 at 10:51:18PM +0000, Struan Bartlett wrote:
> Hello,
> 
> Please apply these two mainline commits (v7.0) to 6.18.y, in this
> order:
> 
>   11ea9b8a88dd ("net: bonding: use workqueue to make sure peer notify updated in lacp mode")
>   70fc6649b36c ("net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block")
> 
> 70fc6649b36c fixes a fault from 7a9214f3d88c ("bonding: ARP monitor
> spams NETDEV_NOTIFY_PEERS notifiers") that is present in 6.18.y: in
> active-backup mode with the ARP monitor, if bond_ab_arp_commit() fails
> over while a peer notification is pending, bond_activebackup_arp_mon()
> decrements send_peer_notif a second time, on the strength of
> should_notify_peers computed before the failover. The counter wraps
> from 0 to UINT_MAX, and the bond then sends NETDEV_NOTIFY_PEERS every
> arp_interval for years. At boot this happens whenever a backup slave's
> link comes up shortly before the primary's. On our servers FRR's zebra
> counted each notification as the bond's link coming up, and ntpd never
> rescanned its interfaces, so the clock went unsynchronised.
> 
> 11ea9b8a88dd is a prerequisite: it adds bond_peer_notify_may_events(),
> which 70fc6649b36c uses. Neither commit is tagged for stable. Both
> apply cleanly, in this order, to v6.18.60 and v6.18.9.
> 
> Testing: Debian's 6.18.9-1~bpo13+1 kernel, booted in a VM, with the
> bonding module built from v6.18.9 against Debian's headers. A
> reproducer (two network namespaces: an active-backup bond with the ARP
> monitor over two veths to a bridge holding the ARP target; it fails
> over to the backup with num_grat_arp 255, then lets the ARP monitor
> fail back to the primary with num_grat_arp 1 while a notification is
> pending) counted the bond's NETDEV_NOTIFY_PEERS events for 3 s just
> after the failback and, if there were any, for 3 s again 30 s later,
> after the 255 would have run out. With arp_interval 100, a bond that
> notifies on every ARP monitor run sends about 30 in 3 s:
> 
>   bonding module                         after  30 s later
>   Debian's                                 29     28
>   v6.18.9, unchanged                       29     29
>   v6.18.9 + 11ea9b8a88dd + 70fc6649b36c     0      -
> 
> Neither commit applies to 6.12.y, so I am sending a minimal equivalent
> patch for 6.12.y separately, with the reproducer:
> "[PATCH 6.12.y] bonding: re-check pending peer notification under RTNL
> in ARP monitor".
> 
> An AI coding assistant (Claude, model claude-opus-5-5) helped trace
> the fault, wrote this request and the reproducer, and built and ran
> the tests above under my direction. I have reviewed this request.
> 
> Thank you,
> 
> Struan Bartlett
> 

Now queued up, thanks.

greg k-h
