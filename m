Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69925785C;
	Tue,  1 Sep 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221465; cv=none; b=Ym9ekCOQKDdREx4WO0SI7vzAeEc700k0ifYxKijYpXdWRqSXkQAEz0VJOMoLN34geHK48d/f/D5Gms/hlj/a0IHI078JIPU/4EjZ5O787oHiCVUwkG3P5qy5JIymtTpJMhRq2/uifAHk9jRLm19poLewIWht8IJzWwIGyh1jCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221465; c=relaxed/simple;
	bh=9esIzLKSES/yTdoEcda0vaqHuRZpq97fmWwlGWB51j4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HM2OShwdPq6S0IHQci/ooPwa0fbpvliYSxznhBJMRjAvbfZJpa40qxSbqxX+oxAplkeZEYRsQ9oXjwmomVJvJYMc/uQL4NjouAeFODNYBZPDsPg4VNIkVDvQnVIGPkgmPjEHRsaLSxKq4EUGL/KY37/9yyZULW/u4XLK6gQvqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBoLkeLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBoLkeLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8411F000E9;
	Tue,  1 Sep 2026 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788221463;
	bh=yY/MvTn5HAr9uHWC85Z7jzROzj6u4LMopObzrNVoizk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CBoLkeLuq20yTEipfjjarH/B7d/kh86ajvnVI+U/WOZRqrTkHgptl1+FpYuxQXrQ9
	 9o/Cd8z1FfRtFSM2Oj6KTCJMaCeGVepiyH0ieknyQBoBK0yclv+4I2FX+baRP1suI6
	 0SaZfFvoFiSGhoTKlk1M4LiDoMnh9Qdj0aKm9E1VENJYypAg2VQ4w/NFTp94qcdg+j
	 YKZ77sv+v5cOsy0Px2/K93iYvQWqnrOWGHht/rcAwXOG6YMBp9GRn4ezSF/Nky9nkr
	 NBa+S11HF5LSQkM0rUhpBQ0nEeGK4sxz6Sd4qkPMnS4V/sYZQ7gwNqu0bo4tKBNwuV
	 wkNpg+/g8CjKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B62392447E;
	Tue,  1 Sep 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_flower: validate mask pointer after
 nla_next()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822140665.844764.11759804128837139787.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 00:10:06 +0000
References: <20260826025123.62758-1-ljp1205831794@gmail.com>
In-Reply-To: <20260826025123.62758-1-ljp1205831794@gmail.com>
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, cong.wang@bytedance.com, kerneljasonxing@gmail.com,
 henrymei@tencent.com, corvus@tencent.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 10:51:20 +0800 you wrote:
> From: Aohan Mei <henrymei@tencent.com>
> 
> fl_set_enc_opt() iterates the key's nested tunnel-option attributes
> with nla_for_each_attr() while advancing a single mask pointer via
> nla_next() at the bottom of each loop, so the mask cursor is driven
> by the number of key attributes rather than by the mask's own
> attributes.  The nla_ok() added by commit c96adff956191 ("cls_flower:
> call nla_ok() before nla_next()") only validates the mask pointer
> that was just consumed; the pointer produced by nla_next() is used by
> the next iteration (fl_set_geneve_opt() and siblings) without any
> validation.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_flower: validate mask pointer after nla_next()
    https://git.kernel.org/netdev/net/c/fee10655709c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


