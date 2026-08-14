Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9A3DC4D3;
	Fri, 14 Aug 2026 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677906; cv=none; b=bmItAeHxyMePFf6eNDMgE674xKIcFuwMnNOFHHDf2oiDBfo9DNtbK7IjWx+9h2W3TizAybX+W6VJ3+ohtsa6zDDL0YK/bSr724vEaqLXpE18DgHzxSVxafCReTAmKhBkv/LhrdxqgE/cmAKovZ+9QOkUvrlSYXg3yJuVcUGyfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677906; c=relaxed/simple;
	bh=HG7yMl1fiHIA7F3Ob8V0YGHV5wZKXcZwBw84TGgIeH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gM9I65AUJmBNuZRy4fyWbOEieVnoZbeL0i2JgimAsqYfwHCyAhQw6srpOOckK0O8qPqtQECDkkrX0oMm270PqDAVCjUoEIwTv8z9ofzS1G34mvVbbOZiFSZXrnEdCX1IOjO+K9Sp0FVIcQmhz5jESTD5LDW58OX3Lnp0fqBswk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+IhfJPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+IhfJPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AF21F000E9;
	Fri, 14 Aug 2026 03:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677905;
	bh=aWp1YHiBJbCs/EP0NMgAa7XsggFzI5w05Kjt4g6NKd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g+IhfJPRuhrMApU3e5N4QpY7wvnz28PTXlQan9NhXK4VCQSWEB1mB4iNVa93O+/29
	 4QdRBL+/tCXl3f36woIvi1PhTzuiNzwUwbUFSph/v54CdRX5mkCzDXO3AcrebBJul6
	 4wki+P0P5Omp4ZjB1Wz8bmGeQ8KyFtXE9ElobBlfbBzH6yZidAd8lrU99rGTGzbvuf
	 4HeHgXTjzI3tbMAdQ1F9amlcPAS+psw/payKmLTW7O712G5ljDw1x12Lx+XcyGAgMX
	 DBvE5PE9PBwjflelMo6q4UVHH3D+adIVB9gXPj95OgmWUK82tuye0A+jSSKOu5vX1Y
	 bh94fC2vbGpYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A793810900;
	Fri, 14 Aug 2026 03:24:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: send netlink notifications in the tunnel's net
 namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667785939.3150297.10317133569625215552.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:19 +0000
References: <20260809094252.2107242-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260809094252.2107242-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jchapman@katalix.com, tparkin@katalix.com,
 gnault@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Aug 2026 17:42:52 +0800 you wrote:
> l2tp_tunnel_notify() and l2tp_session_notify() use
> genlmsg_multicast_allns(), which delivers to listeners in every network
> namespace. l2tp is per-namespace, and a tunnel records the namespace it
> belongs to in tunnel->l2tp_net. Each event concerns one namespace, yet
> every namespace is told about it. A tunnel event carries the tunnel and
> peer tunnel ids, plus the socket's addresses with both ports for a UDP
> tunnel. A session event carries the session and peer session ids, the
> interface name, plus the L2TP cookies where those are set. A listener
> needs no privilege for any of this, because l2tp_multicast_group[]
> carries no flags and genl_bind() asks for no capability.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: send netlink notifications in the tunnel's net namespace
    https://git.kernel.org/netdev/net-next/c/ed267f783c0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


