Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64D4A2610;
	Thu, 10 Sep 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056069; cv=none; b=AMfT4RfBOtpV1YIln5DwmKhjNgaJtceNOvs5kpsdA0zqmk7UgxFuV/r8Ga7WpfdCA+eRqfYpI1bkEr/yLuQXiKB7y2tLXjLlP/zQ8aqgIcRZHJG42x5OpCEKn1Q83FYUQtKBP02sXd3jPhCuhG0+7qTXUvuP4QDmE+GIuMmQCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056069; c=relaxed/simple;
	bh=xCeFymzysRji8HRN66OZSL+HwevXxehkdKRI/pOyZFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LA6T0WzrBAIP34c/HTJ+UxRdEcIOXS5MamS09RtCoO6BnGsVxcZkX1xBBBUKYiSs6KFLY9JUXTw90onJ3Ycu4z233kEj77Nk/8sMd/tryTkwE3WlUWZRLFchdFy86vsZ7Qf+Rfv2nlcCS8abSlFiPeJ7dwtDRJq5Y+ZCsyut31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDogIjF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDogIjF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685B61F00893;
	Thu, 10 Sep 2026 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789056068;
	bh=KjCpqPT0NmgJO0mylOG6ylzWUkgRByMpTpjBq0pKbPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lDogIjF3Vc+d7FDXlcrgc5/lwoN/Iea/cPrHkLjpjMKzs5MLM085dAuhEWqyO2FEL
	 cilncDOS7uQogZj64eAlZC1ap++Eo0HO+ms8NsTrhLm2mTZcjuhQPMzhUYTu5LmfjI
	 n4snYkqgYn95wD0Zch2dHdqxO+6c7n6UQI5YPJENBWGVQowQvJxmJrzLE0a+fm18nR
	 YEZNkJZboZbhEtmQGEQckFE8K74xdpSqRBC8Y2Spx3q4YKGFiro9r3W/qKuFrXrRpz
	 IBCjwIJpe2CmbbqLcY2Ye1tPWfMAT2CjYKDrAxXBy9V8E/fJbaxtuGDwx4NjhJKtMM
	 VeUCiBcQilLAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E6380CFFA;
	Thu, 10 Sep 2026 16:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] openvswitch: fix wrong flag value in
 get_ipv6_ext_hdrs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905600587.1516091.849499929178273628.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 16:00:05 +0000
References: 
 <1b1582eb07550d71f3cbe210e5cb31eeb8d0ad86.1788876917.git.echaudro@redhat.com>
In-Reply-To: 
 <1b1582eb07550d71f3cbe210e5cb31eeb8d0ad86.1788876917.git.echaudro@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, cpp.code.lv@gmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 16:15:17 +0200 you wrote:
> The ESP and AH cases in get_ipv6_ext_hdrs() used IPPROTO_FRAGMENT instead
> of OFPIEH12_FRAG when checking for out-of-order extension headers, causing
> the fragment header to not be recognised as a valid predecessor.
> 
> The original code used IPPROTO_FRAGMENT (44) as a bitmask constant where
> OFPIEH12_FRAG (1 << 4 = 16) was intended.  IPPROTO_FRAGMENT encodes bits
> 2, 3 and 5 (OFPIEH12_AUTH | OFPIEH12_DEST | OFPIEH12_ROUTER), but not
> bit 4 (OFPIEH12_FRAG).  This caused incorrect OFPIEH12_UNSEQ verdicts in
> both the ESP and AH arms: the ESP arm failed to whitelist OFPIEH12_FRAG,
> while the AH arm accidentally whitelisted OFPIEH12_AUTH.
> 
> [...]

Here is the summary with links:
  - [net,v2] openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()
    https://git.kernel.org/netdev/net/c/e184a4a6f423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


