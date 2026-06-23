Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551337FF41;
	Tue, 23 Jun 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174625; cv=none; b=TEtk+MhTikrOLEfJ1oZKEN8VoAxFhwIPhLhzqEcusaM48TGh0kxBPDz8GKpRqj+UKzXUA8dwwh/5Nn5LKyAT7zMfDmgM/mpSyAZZU8632Mq19zv3tA0a9fAkaItOj1Ea19Q6meVmKDttOYvuRuQzP0HJacOXTLvty1mcSk7LkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174625; c=relaxed/simple;
	bh=tBMqPTTMZ/blwTEveTSY/DHSXD4CEv/VgroCrW1WXX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O+apCKDvbNrQaMwwajx+YrYXbOkG1y/EP4WWVJ3YKEXHn/Q6vcVgmXJ4ljICDm+An5bSH9CI54QEFM4mcWRLzRVBlZWNu3vMI++GVUoG8gtGjNJLmvKovLLGGTkH1XQ8993vioB8jCtKCnFzs+g5oVGSGhJL8wom47jPsXZk1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv8nvqVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv8nvqVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2023F1F000E9;
	Tue, 23 Jun 2026 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174624;
	bh=jJ/FeTwB958bqT0CvT3zpI7nxDka1yEjfrGPU9SLm18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jv8nvqVCyDJ/0eFpt7G+0RlJr3IbFQZCi7j82TcAkhtGKNzE9sV+lMjrf07vkgurK
	 WvcmCGInfrdnb8M4cVdqw5EIaywf9NeJDkcun0i/+LH7Q7gM28jGBcvF/owuZLHEAG
	 ju7p6lW89sew+pgDl7K8b9rbxpTFO9112pxooEaL8sD+pBZ/Yvypt2zGTJi+h6UJiZ
	 5dD6hYi5MVdkJ0E1kYuw5wwa9OK50g9iWP+v3HxxgCzaCy/430f8ayaI0LZPDmfPgp
	 l82tp9hcBknNF1XKca+6Zu3jK1XfYwH1PI+i8xo3QUnVobpwRPzK4sbZwgcntb1PDx
	 bLT1tMA4dblMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A45393098A;
	Tue, 23 Jun 2026 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] Fix stale register bounds on LSM retval
 context
 load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217461422.1476259.13794764203016830138.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 00:30:14 +0000
References: <20260622230123.3695446-1-tristmd@gmail.com>
In-Reply-To: <20260622230123.3695446-1-tristmd@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, xukuohai@huawei.com, jolsa@kernel.org,
 john.fastabend@gmail.com, martin.lau@linux.dev, bpf@vger.kernel.org,
 stable@vger.kernel.org, tristan@talencesecurity.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 22 Jun 2026 23:01:21 +0000 you wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> check_mem_access() calls __mark_reg_s32_range() to narrow a register to
> the LSM hook retval range, but the intersection preserves stale bounds
> from prior instructions. Add mark_reg_unknown() before narrowing (same
> pattern as the else branch) and a selftest that catches the mismatch.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Reset register bounds before narrowing retval range in check_mem_access()
    https://git.kernel.org/bpf/bpf/c/5e0b273e0a62
  - [bpf,v3,2/2] selftests/bpf: Add test for stale bounds on LSM retval context load
    https://git.kernel.org/bpf/bpf/c/644332f48fc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


