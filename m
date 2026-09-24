Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8535DA6D;
	Thu, 24 Sep 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266890; cv=none; b=D1zeQMhutR3h7OzJb9FrhqQiQrMXXJr3KcXvGFoX/SEOleM07mZ1V3QqS3OTZ9BClQr3tlVYn+Xr3eu3RMcC3nOoBtCt4en7UikadIPEF/r0BfB//SvSXsg3YPKFy7Zv5lC36ZsrrXQmN8NnNrtZvQ/Ti2WSRKyfV4uJRR7m4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266890; c=relaxed/simple;
	bh=OyNcoh7rwr3HWY8uQLiDmyTO+W5d82q6ouZuHZWyWjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+rMbYOkYcSjeSYMyuJ+uo9YZg3fenLZTQuVztL3ha5EZ4nSqQ01D7s/+1wBKLo2torjAn0j8mo0zRWyRhUUbHEFHoYZ4IRZ9Ua6YvkSCu86S+tHK5+zSjFXZRP8ov1eVsLTBlM456YJQwGcFoY2dRPL+qSRPKE2u98QnbiosIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrsZHKjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrsZHKjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE76F1F000FF;
	Thu, 24 Sep 2026 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266888;
	bh=aFF3jpWjzgNe72gyggXPjo/4uBVR+yIn5hvkUqaQaOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MrsZHKjr3yp6TZJ1myPBMErhKy/DdJedYNnLkEjsChfa1aZf6yBWuKmsXlgRFQHJP
	 maMhv2tRHctnZiRyvJ3RQrpSlI2eYFtYI+X43Npp2HK8n19WMAQgcbhD5kjd9ZoNQA
	 bJU+CYYaUtmMKXGZOVwpuN63pLDXIQqeHThvl3lP03789lposUMvAneT1WV8p+8UcZ
	 fIHMSmrK0Ag4yFp+y20vBkq7t2noPLzyq/RY2Ctvh1R8IJ+uIyvua46jSK7LHL0yQ0
	 IYOXwnKCnhaqVf8I1fEBFeEQB8OLd2N0GO6R5haxzo7an8UDKHXNO+8w8vrSUfrZM2
	 eHmvlA+dKJjlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BC3A566CE;
	Thu, 24 Sep 2026 16:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mctp: route: iterate socket tag list in
 mctp_lookup_prealloc_tag()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026681759.1636687.12917065683024965803.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:20:17 +0000
References: <20260921051002.1656692-1-benquike@gmail.com>
In-Reply-To: <20260921051002.1656692-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 05:10:01 +0000 you wrote:
> When a socket transmits a packet with MCTP_TAG_PREALLOC set,
> mctp_lookup_prealloc_tag() iterates over the per-netns &mns->keys list
> and matches netid, req_tag, peer_addr, and manual_alloc, without
> checking whether tmp->sk == &msk->sk. This allows any MCTP socket in the
> same network namespace to use and consume another socket's preallocated
> tag.
> 
> [...]

Here is the summary with links:
  - [net,v2] mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
    https://git.kernel.org/netdev/net/c/26cc0e69cce0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


