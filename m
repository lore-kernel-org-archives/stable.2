Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368134C806;
	Thu, 17 Sep 2026 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605685; cv=none; b=mfh6EiAsS+wmshfNhJkJBKkKR0yaVKy8Sptdkoxi9QTz2xH6dNLDvcE0ogo2e+fdCF0GKwZwoHNE9sKBVmc5K9dHtiMtB4j1e7/S47lpyzuP1AJ1ZsApUmDN6hyk0Cp1tE0vBhkaW7sLzcTniwV2EJZrnF0A3x19I1Knm45SZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605685; c=relaxed/simple;
	bh=r5rbyUTsdMXYmj5ltu4cUnZbfT5oVUZAkV47iyZP8jE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z3DBvJlNY0durFzvgFCoUIwR0qi95atoWzh/e2SQykrk2MjCTtGK0+m6OFNQuUvVgIqz8r24d1FX73qadNoh5/TGcnd0flLHb6CRgSVl6B+tWghVm/iSnTTrjlRU9xdp7oO5Ttt57WXPA928uS8Xq+QXmubHYAwckiY/lere64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkPgoc51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkPgoc51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002DE1F000FF;
	Thu, 17 Sep 2026 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605683;
	bh=od+SWvUpuda2vYPLHCaUafhjlNX4+pOCtITdQxr2+Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZkPgoc51sCkOcKPM0OTew9zAWB6WyZ7h584dMdorYto6ofgNstzy2LllyM1GuPHvr
	 pJmZVXHet7HcfYaFpufWliWV2txelN4WoTrQMfNdc4g7mGz5RlfFmuoeHPjNAns4Hu
	 9bqatTukYNWBla53Xk0gpM6RbSxaIhQ0wj1646KwivukyendNdPOUIvjPL64ez39ET
	 njH8ipUEXQCkXdZZv+b0scewfD/xO6zLU6dDvkqe0nDaC6i6fhifJWvaszzKdRcdZ4
	 5A1QeBZTvYrsC6OUbMCqXONCuGzbg83kMfARjgIE/HHBIl2k7UpM56x61+4x+fFIbY
	 EUdMwqoEBi1gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1992D39E9601;
	Thu, 17 Sep 2026 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] macsec: require CAP_NET_ADMIN in the device netns
 for
 changelink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960561671.3354472.1262902484358147109.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:16 +0000
References: 
 <AS8P251MB000176E827636EA185226908C8BE2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P251MB000176E827636EA185226908C8BE2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, atenart@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 22:33:10 +0100 you wrote:
> macsec_changelink() operates on two netns: dev_net(dev) and the netns
> of macsec->real_dev. They differ once the macsec device is created in
> or moved to a netns other than the one holding the real device. The
> rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev), so
> a caller privileged there but not in dev_net(real_dev) can reach
> real_dev's driver:
> 
> [...]

Here is the summary with links:
  - [net,v2] macsec: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net-next/c/ed502e485685

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


