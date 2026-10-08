Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104143A3E97;
	Thu,  8 Oct 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427211; cv=none; b=dzcaaZfBijtvDwp2e/2huN3HqQl4va2gh3AZr0sKg3e7K538ACOeGbScx3yk7oCrJD9S9lqIgA/JnsHzYOnUY6hfVur+NPt54jgrHwuxLPDvUZYEFhFkk/AN3B38qbj47/eolVUV3fqbnruRe6jnk1VgjmcAmrNkTHwvcStg8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427211; c=relaxed/simple;
	bh=dBVPxzXuV8kIyjq8bMSJwecBu4MMCYXSHqOUS+EmTcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cXpjH4/GWv+MpAc3Cfc52P/bUe/b6sqP29oNfRR0ZIVogmKA7/IHfgzPisxPvqr0YDp1K5qxSGJAQPFX3th/kyL3i+SdBbefgHuLEdQ21wR1Z8ucscUgQdfySRAUof/yhZd4pKAmG6jE60EaLzQlnm0ftF1iXiS6n7k1tC3Hojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLKUrhOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLKUrhOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD021F000FF;
	Thu,  8 Oct 2026 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791427209;
	bh=rnLQl5HBuLdC+SvHobLCtFBqTVBsdq6er1QYiXFNKXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mLKUrhOY18fxZqbh6JBlbsHr58/sUXNWp12gRU9zKD09oXXxGDF18OeC1NfCWhn3F
	 Ue5KWMLnzDBD5tmWTZmvK3UMzB2e/cT08X/5Ya433bu/65+HiZ0tM13FE1EbV0qLUI
	 97V5Rhzwe/03WVFzWNkXEgZlaGDvgQyYXAfrKUJ4dvo17ECEnJFM2W6xn/BBDIRgtU
	 td8QjML9dmG6YKFqs5rQPqDDtdXRnbbk/m0AbXAgF+N/WcdnrP81tKA1sjSujxx6O3
	 dagWpHEzHU3J8XBMpIOjnONa44tsTIzHFKol/JDERAv/0VmPIaByOTF8mdcoQDZd3o
	 VmDXll85JGThQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44A33809A09;
	Thu,  8 Oct 2026 02:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: entry: gate shadow call stack reload on
 sstatus.SPP,
 not tp
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179142720833.3779518.9095154686634071421.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:40:08 +0000
References: <20261001135711.934152-1-guoziyi114@gmail.com>
In-Reply-To: <20261001135711.934152-1-guoziyi114@gmail.com>
To: Ziyi Guo <guoziyi114@gmail.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, alex@ghiti.fr, samitolvanen@google.com,
 wangruikang@iscas.ac.cn, debug@rivosinc.com, conor.dooley@microchip.com,
 namcao@linutronix.de, zong.li@sifive.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Thu,  1 Oct 2026 13:57:11 +0000 you wrote:
> Under CONFIG_SHADOW_CALL_STACK, handle_exception() reloads the kernel
> shadow call stack pointer (gp) only when the trap came from userspace.
> It made that decision with scs_load_current_if_task_changed, which
> compares the trap-time tp (read back from sscratch into s5) against the
> current tp:
> 
> 	beq	\prev, tp, _skip_scs
> 	scs_load_current
> _skip_scs:
> 
> [...]

Here is the summary with links:
  - riscv: entry: gate shadow call stack reload on sstatus.SPP, not tp
    https://git.kernel.org/riscv/c/4d0697f19297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


