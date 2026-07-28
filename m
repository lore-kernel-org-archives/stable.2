Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990F42047D;
	Tue, 28 Jul 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228642; cv=none; b=gocoynwh5rNodzeXtOkFww4dGGXgB9395MdwDKIV+TAYwA/d/v7B0DiZZDR+t5R/ILfM1NN9XJO/f2OX0lmFkTiGcny6LDwpcFVKZb5sXA2jmhor6xoKby1q+f56nEAI8QPFbAxgWdQo11D8zdesg2bA/oO7I4Ag41i3868pXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228642; c=relaxed/simple;
	bh=pJatyahlmXJqfXfpmHXl01ZPhxffYZHIizsPhUba8nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gpw+sXMbbw/q1C4h0PgYYOOVlRFcCfWlVTuuQySHgZlq71jORZ79zJuR1fHdcMQvG4287x0PRVsETMSOK12vgrunSfrvcliY8RUFRWPhZ3Fsn+vJm6DM42v1B38WKZ8N6Vc6DWiIfWwHVB98n9NaJUyUlAHD9w2DmDaDrdBxyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp8hVRnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp8hVRnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE071F00A3A;
	Tue, 28 Jul 2026 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785228640;
	bh=EWOAZsU2NagUIop06GmRHouUNneBjBO7FuShGyqy/zs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xp8hVRnQJFg2gWl0kd7la8xgpkHKScyxxevkGEAGkuwMg0XAfsGDRawH/bmmfTerY
	 XmVVLc7t44h6kkNgdwLqXfv+LFasmLElAlfgMkNahRKossu6d5vh+9ZfNTd2TZXWPO
	 tasfgxbvP1LGOJYy3mIPzq0LnEQSLyseAuRzefYV7vQbwZ+fp0wR2qu/8VVnBfQs+x
	 6w7Hu8dyLewYjPRTq2NTnEdokoflhEggacmMw4mAM9vZasGqyvwSA0VviD7p7Ki+1y
	 KmLOrLzRaF68Vx/WJ/2APAoanQLYH2P400ILdtORgqPUhrm93WYXhZF/OFpo9DllC3
	 8ts8C/njJakkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0C9CB380CFE1;
	Tue, 28 Jul 2026 08:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] fou: Fix use-after-free in fou_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178522860595.1625650.5330591908800710686.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 08:50:05 +0000
References: <20260722083858.182506-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260722083858.182506-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 idosch@nvidia.com, therbert@google.com, luoxuanqiang@kylinos.cn,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 22 Jul 2026 16:38:58 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> fou_create() publishes struct fou through sk_user_data before adding the
> new FOU port to the per-netns list.  If fou_add_to_port_list() fails,
> the error path frees fou while it is still reachable through
> sk_user_data.  A concurrent receive can then dereference the freed
> object in fou_from_sock().
> 
> [...]

Here is the summary with links:
  - [net,v1] fou: Fix use-after-free in fou_create()
    https://git.kernel.org/netdev/net/c/b14361aca635

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


