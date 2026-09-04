Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EA19F121;
	Fri,  4 Sep 2026 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483067; cv=none; b=uvaI3CmwwNIndVqehdRi9J1JQdB+GXOk1DDqWLEyYm+eDBEjcedElbi97z3fOogEU373igfpo7SEQuTDEJk4NDd5F47lfFgox4PwiiHkb3rSXYFUHzSCkJbBnmxasd9QXZ/oi7dwuI5E1cXjEBVQxNs/13fuXoRZT1faANxdp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483067; c=relaxed/simple;
	bh=ckwJPsucUqT+zhFydqh6KKuVu6WFZbLd0D6CbTlpOGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hq1cFMwzf270oBPYmI2bRELtSK6WZWsYCS3Zlz/+LXfVX+tCx9xIbWB/I4uHiJE/RLKVlIWZdinHBFIOlI/ASNqnoJJhDVsteekYjeYj6RIU0Zc+oPDxsZmMxmw5FgFxJ0keBES5xF581kyu3NFxqg5chTLZb8yehZ7kA+EIVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/0UbV/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/0UbV/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDF1F000E9;
	Fri,  4 Sep 2026 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788483066;
	bh=r6eF0OFcFwV4YwtUVxvfEo8CvnRBDfkdLeuuZjej+mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m/0UbV/lCSzfwVimf3j+JU4BSoKPcgOVDxfbbFTmb7EFuzvl1o+mNcTTprlY1cPvW
	 0CEDJn2OH90+McmlMgJrd48vlFNVjV+aXHScKLI8S1XGONUr/+jQuwgwjNPrJSPH1w
	 o6EUoHoWGKv1MEQGdUYHzDfOPmBZw7aOOU8FZt8UoTjw1lxUKoqD3OQtStRN94YYPq
	 7COxvIIq8KIq7YfbqVRxpidHrxwsEmwMtFcvC8v545zHMIf78FkeEJr1FSWXCimmG2
	 Wt2paBx65jPB2fCnRgpPwuXhDlt7h5cXZ4HXYn1vX0ZJFj5UUHyjfzLThTb6YZvrGd
	 10u5cyTCKsYlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0C38119E3;
	Fri,  4 Sep 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for
 PMTUD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848300740.4094353.3141970410159062442.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:50:07 +0000
References: <20260902190112.4126199-1-idosch@nvidia.com>
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 aconole@redhat.com, sbrivio@redhat.com, gnault@redhat.com,
 laikabcprice@gmail.com, aroslavdudkov622@gmail.com,
 rough.rock3059@datachamp.fr, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 22:01:12 +0300 you wrote:
> Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
> around an overlay packet if the packet is going to exceed the underlay
> path MTU. The ICMP error packet is then injected back into the Rx path
> with the source and destination addresses swapped, so that it will be
> delivered to the overlay source.
> 
> If the overlay packet was routed to the UDP tunnel or locally generated,
> then it is already carrying a valid dst entry and this entry is not
> dropped when transforming the packet to an ICMP error packet. This
> causes the IP layer to reuse the dst entry, leading to the ICMP error
> packet being dropped or routed out of the UDP tunnel interface in case
> of forwarding.
> 
> [...]

Here is the summary with links:
  - [net] tunnels: Drop stale dst when building an ICMP error for PMTUD
    https://git.kernel.org/netdev/net/c/b58d74963320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


