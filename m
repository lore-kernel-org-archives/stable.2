Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B325B0B3;
	Mon, 22 Jun 2026 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090629; cv=none; b=JKhj09qZqYs1qFgbvh6ITkJ8WxVl06oSSy6Mm1REP4HLz4AB2xbKHvhgw3yviq3gHz/x093XO5bd2oVpH/v1hdqu9tjavN6XV1UErftA5WXmZletIH3O9fxnxfegyR4mV3PATgmBYWtThaO26Nk3aHV171ZIcDxOmI+FI8EOY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090629; c=relaxed/simple;
	bh=okaSSlX2zsK2EKljbfqrXB/8Wg3kzVTvhcqstVdOm/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZ09dwh2wor09uHyxPiz25V9wblCsnW5vrn1HZvcu/9501Q9DWBgdCYXhK5oBZQ2XmMLH7EhwGkoScpfUYrKl/Dlj6mP2PFNh6y71r9mL9Xf+dObVf+prIoHUaR1+8bULdT0kglO1rVZoE9q/4xf+qa7PkvfRLSlmYpsTMONt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir4eCmZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir4eCmZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15001F000E9;
	Mon, 22 Jun 2026 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090628;
	bh=qhQqOjUJLNnukTok9daW+cbWuP9q9NoA69dCM5QadKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ir4eCmZXm8TLRm8b+CSh0LRopvfjXgXE6DNwe5/U//XDydxAd2PWLp1DnXm10tWIj
	 +KAu7Xd8Fm+J3DRwkye8DSl8DfpXTxdcemwlxcbxvJaA1WMVlUvpavOZeh/D0BMCuq
	 rL9zBhxbf6/gAe5wNy43GYFEnQlC6ZWTARGuT0ao0cP7az3UV9JHfyw0rHVWi2CtU2
	 wPqtm7x7PWCKvef5I0ULccpS54VoCPyti3GqiwukvSx/a2z4k3hNdi0QbDVka9Mdzb
	 cs5bJcHPNG/FJX9XyJ07dGJY26vxZ8z6TfnrP7DIjKLPrbRwZnKJiRIa9d6y729DIW
	 jwjPc1TeoGssw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C13AAA6EF;
	Mon, 22 Jun 2026 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Add missing access_ok call to copy_user_syms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209061954.558026.1860128949099362401.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:10:19 +0000
References: <20260616083056.405652-1-jolsa@kernel.org>
In-Reply-To: <20260616083056.405652-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 stable@vger.kernel.org, sashiko-bot@kernel.org, bpf@vger.kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 Jun 2026 10:30:56 +0200 you wrote:
> As reported by sashiko we use __get_user without prior access_ok call on the
> user space pointer. Adding the missing call for the whole pointer array.
> 
> Plus removing the err check in the error path, because it's not needed and
> also we can return -ENOMEM directly from the first kvmalloc_array fail path.
> 
> Cc: stable@vger.kernel.org
> [1] https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.org/
> Fixes: 0236fec57a15 ("bpf: Resolve symbols with ftrace_lookup_symbols for kprobe multi link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.org/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Add missing access_ok call to copy_user_syms
    https://git.kernel.org/bpf/bpf/c/d5dc200c3a3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


