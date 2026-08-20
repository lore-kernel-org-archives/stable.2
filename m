Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE1397E75;
	Thu, 20 Aug 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251862; cv=none; b=oUWh34MPjNq8fNMC/mkplt2rLnsHdjWsqhrCSmCPX/OLi8y8ZOyUNXxpI1h+3ZTDPWnsYHuChpZ/tJIH8eC0LVUtpmvAGY2or9di95KVKyiLYQE8Bqi4l2AiDZFRRCBcEaY4fiuVUc2me0xkS0onVwwfL7zzfJgsybb0LsRrngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251862; c=relaxed/simple;
	bh=+aUQykaM1J85EYZdGf59N6/NJ5EMaP4DV6DPlZ/ft9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XudV2ynE+uDbWFtYZFiAROwmuPXjhk7xxoKFd0bC4rZfj4DjzP6pcpYivpQzeTvLB42k7Yl3H4LgSvUoLAnFX4PsfLD3XOrJiPxE0dcE3PG4em7F4YCBiaKV8YztGTbnKZ5PdRWlbocN2NIkFizPuGYy87V92usVnFSU+owWIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9qB42qY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9qB42qY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E901F00A3A;
	Thu, 20 Aug 2026 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251858;
	bh=6iq5mvuMRD2FLICLcE7t9NmCojvc/d8pLabUwGhoyck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m9qB42qYhQtr1zvUb4Vz8Rjb2CTLQDFnLfBjDUkRzU3oTUaZS3IfB1642jAVfQjLg
	 hwHYxaimd4BtN40Es3rpmOHR5tTIBKHKiVu9I49c1uSWxH0kDQXvv+YXKufIDyxsoc
	 1OIwGoetzpWR1i82H8V5Xaci8uHlgdINQTVoO9xhTP1dnxZsFeDkcbIwb2+oapGpRn
	 Nrl1RgKpO7sEvybg7WoAxBUeZtpRbIqBXY3Ceg4C5Qkhdv59CUuZQV5STw79EJDnZT
	 52APt5QSQx6GfcNB0yhhQCW+ltfP4Q7Ec7yKl2IQRCivvBo4reWL+Pu+ITyUOr71Bf
	 88iOItaOhT83w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569163822D60;
	Thu, 20 Aug 2026 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix infinite loop in pcpu_freelist push with one
 possible CPU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725180892.429815.3721455388690610183.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 18:50:08 +0000
References: <20260806175600.1993595-1-sh_def@163.com>
In-Reply-To: <20260806175600.1993595-1-sh_def@163.com>
To: Hui Su <sh_def@163.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 martin.lau@linux.dev, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri,  7 Aug 2026 01:56:00 +0800 you wrote:
> __pcpu_freelist_push() can loop forever when only one CPU is possible
> and an NMI re-enters pcpu_freelist_push() while the interrupted context
> holds that CPU's freelist lock.
> 
> After the current-CPU fast path fails, the fallback loop walks
> cpu_possible_mask while skipping the current CPU. With CONFIG_SMP=n, or
> when an SMP kernel is limited to one possible CPU with nr_cpus=1 or
> possible_cpus=1, there are no other possible CPUs to examine. The loop
> therefore makes no lock acquisition attempt and can never make progress.
> 
> [...]

Here is the summary with links:
  - bpf: Fix infinite loop in pcpu_freelist push with one possible CPU
    https://git.kernel.org/bpf/bpf/c/efebf6496685

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


