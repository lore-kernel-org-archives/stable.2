Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3D4908DE;
	Wed, 29 Jul 2026 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285654; cv=none; b=pmT9yWSFkIW//zQxuUYUF7o3eqaU0gxaXs80mBEMhG3XOn4Jj6B3ooszi3ZQVUnZ6dlj89YGyMkEl1CbVTOEOG6W5+ktPapdalG3bIYGld7lMg0QEqlX0omHMv8jJ6kV75vUOtqWPBNgLh+SHPqlHltR18oQ4N0lI6E8EhQDB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285654; c=relaxed/simple;
	bh=A60+ic9XZRw92ehwx9OPHj0EOLYP4/NIVI51+H1+fvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEdSFbYwDCTilY6cvUBI7rLqnc+g8RKKkeMlZt5wRduSAb2Nlh5HOmKslz9H7A5JatE/kJ1CSaO6s5I3LXVJNq4f0TpjSqGiK29sx/5N2/cdM2GeAZ2EBRkvtWjXVj0q3tW7wxmXngzPfPjD2ygLCPon0YyZp0ynP6+RS2c4A5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Ym+VI77J; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Ym+VI77J"
Message-ID: <2ec41792-d40f-4b11-ac87-6174780f8a08@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1785285636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1j9tEVwNukiUf0NLNWnvvjFUUnS8IQBqim45lx+0LE=;
	b=Ym+VI77JNeXdV+/f8yRq1yMhTKsIlfvRyg4LGwbCN0Ly9Ur267kRh5B97nI1o+9l97TerT
	slnnuJn48m3oRcu7RUz/qYHW0vhmtenm2Bn/I+WV7+BrtXFc26296hRRdWl87SzS12Xx4D
	E44oa68SCWk4PHjq0AHZGutM4thVQvE=
Date: Wed, 29 Jul 2026 03:40:34 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.12.y] net: add missing ns_capable check for peer netns
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "Eric W. Biederman" <ebiederm@aristanetworks.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 Maximilian Heyne <mheyne@amazon.de>, Greg KH <gregkh@linuxfoundation.org>,
 Kuniyuki Iwashima <kuniyu@google.com>
References: <20260617-pats-coif-316245c6@mheyne-amazon>
 <2026062556-residue-anybody-e756@gregkh>
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <2026062556-residue-anybody-e756@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Jul 2026 00:40:35.0882 (UTC) FILETIME=[DEBCD8A0:01DD1EF2]

Greg KH, Jun 25, 2026:
> On Wed, Jun 17, 2026 at 08:25:31AM +0000, Maximilian Heyne wrote:
>> The upstream commit 7b735ef81286 ("rtnetlink: add missing
>> netlink_ns_capable() check for peer netns") doesn't apply on older
>> stable kernels due to refactoring. Therefore, this patch is an attempt
>> to implement the same capability check just directly in the respective
>> interface types.
> 
> Why can't we take the full series of patches instead?  Otherwise this is
> going to be a pain over time for any other fixes/updates in this area,
> right?

The patches that produced net/core/rtnetlink.c:rtnl_get_peer_net(),
being fixed in 6.18-7.0, are not a refactoring.

Actually, rtnl_get_peer_net() almost literally
replicates the “peer net” management code that can be found
in vxcan_newlink(), netkit_new_link(), and veth_newlink().

These patches are part of a larger new feature series:
"rtnetlink: Convert rtnl_newlink() to per-netns RTNL"
From: Kuniyuki Iwashima, 2024-11-07
Link: https://lore.kernel.org/all/20241108004823.29419-1-kuniyu@amazon.com/

These patches in the series
v
¦     In git log order:
¦
¦   636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP")
¦   d91191ffe23f ("rtnetlink: Convert RTM_NEWLINK to per-netns RTNL")
├─> fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type")
├─> 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type")
├─> 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type")
└─> 28690e5361c0 ("rtnetlink: Add peer_type in struct rtnl_link_ops")
     cbaaa6326bc5 ("rtnetlink: Introduce struct rtnl_nets and helpers")
     68297dbb967f ("rtnetlink: Remove __rtnl_link_register()")
     6b57ff21a310 ("rtnetlink: Protect link_ops by mutex")
     d5ec8d91f82e ("rtnetlink: Remove __rtnl_link_unregister()")

At the time, rtnl_get_peer_net() was named rtnl_add_peer_net().

Having common “peer net” management code in rtnl_get_peer_net()
made it possible to “add missing netlink_ns_capable()”
in a single location.

If the series is to be backported to 6.12.y
then the following commits must be backported as well,
because they fix bugs introduced by that series:

48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
954a2b40719a ("rtnetlink: Try the outer netns attribute in rtnl_get_peer_net()")

Commit-by-commit replication of the evolution of
rtnl_get_peer_net(), vxcan_newlink(), netkit_new_link(),
and veth_newlink() means backporting a new feature,
introducing and fixing bugs.

It seems reasonable to avoid "introduce and fix bugs" roundtrip
during backport, but then we miss commit-by-commit replication.

As we miss replication, we may also discard
the “new feature” commits as well.

Cutting these out leaves us with a targeted re-implementation of
the CVE fix. IMO, that's exactly what Maximilian Heyne's patch does.

Regards,
Konstantin
