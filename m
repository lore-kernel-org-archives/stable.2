Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBC32D0F5;
	Thu, 13 Aug 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612852; cv=none; b=tdeI0Aa1D8d2IIVO99N2e8VkkyblQbxBWR1FcX7ImfmnoGvHdKt9YkT/KEKFk9inDOYVWjtZydhZFmIU0ijF4HZFzPbcPuQYzkQqLGVoo3P/6Sy7txdDtaOsqv5AuafUINHPkvh7I/XGBzA+d4asi66OVrcrK+NhksKbqHLCibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612852; c=relaxed/simple;
	bh=+hWNlACPV1r5ZjvYyRB8eJsY9EvymMsZGIfqw2VwIGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mn2A3ATAKwB2zCjexzQ9CyVJAdRBSc2qUGZ3jjvkuYqBI3ouR0v/P2GYniQNLiN4Foahz3W6xMGpLnGyYAehnLVw0HYV0yIqPVfmLNu9ccB5DoH2eAs2BJzihmFS952MZA0Oc5hyR8eO//meh6RUBmB+srWCZBWYkqY2ov0sDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrByzPC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrByzPC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0521F000E9;
	Thu, 13 Aug 2026 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612851;
	bh=PByVorD38sb5689NNgvGruvFh7glv+12yQyN0Z9E6yY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TrByzPC1Br7UlaVTZZQTbHfnSQpO208hCl75RnzDXooLNFj5XEqdjX+g0kaoHzGwc
	 t8VZ6cQnqbC1D9isa89jKH8na4DAEn8gsUWWLxR0wVTjwDA6GXsY5LRlFltDNhoraD
	 8Nf5xIy5GngNj1rEQOtqx0lzwepiXLAK63l0JrbzsR0nMy1/UGtZHsptCE/Dtb1oFd
	 NUG9z3XQJWAeVb7hDG3Po7NjkONJvCbdeHb01LRula1xrhE1JTS27IQEZC6Gft65gi
	 foF63kIauXyLWrb9Cwo3UC1q22cB1JRaUnebrL092A/DaotHj2mMyHh12uDgn/1xGB
	 6HELrerGzeNig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691A380CEF6;
	Thu, 13 Aug 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a
 different device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178661280589.2324085.9605319277143570297.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 09:20:05 +0000
References: <20260809094418.901607-1-jhs@mojatatu.com>
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai,
 victor@mojatatu.com, kuba@kernel.org, qmo@kernel.org, horms@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  9 Aug 2026 05:44:18 -0400 you wrote:
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=1).
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_bpf: reject dev-bound programs bound to a different device
    https://git.kernel.org/netdev/net/c/120977e2c096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


