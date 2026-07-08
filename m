Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B347CC69;
	Wed,  8 Jul 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530029; cv=none; b=Lv/UtFGJKda/njtSREaNjXNhcuQxTDoGGEb94cxl+p8eX7h1+PJeWEkJBhsfM4pibItm3P1nPgn7pKFBGF8phUQNFCDxIMtHFXTAA9frxA3cQg9r25Jjgk7kdl95wv3pW8J/gUqtLWit7/PPwEz0Y1LTnIoIskaMZdMOVABukpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530029; c=relaxed/simple;
	bh=Jn1P8LdWBkxPzQCLnUprPTJcSD9EzN5/txyB7mJulBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnZe8o7Z7y4jsQ0k8FgQfmjuP+oWSkQCDAt05uT9bDajAqQYB/x1V+DceEWJRZv9N4JzwT54Vt5XG4aR/ji8N6NDYuO9JU4qlva0COe80+nmvCEcUMajdSZaAQ6/n/l4REJiWkJV5Y1SkTaSg50aq0eGXge3w+9edJadO4MS46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCeM0wDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCeM0wDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15791F000E9;
	Wed,  8 Jul 2026 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783530025;
	bh=c+9/nNYjkvw0jgf1j3Gv5o89wJBSkJjLM95B716OQQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HCeM0wDY15E/tfFBnPMEbpinf3jUnu6sLOcrDRcP7xct+vgE/zvGyQRqtaC9R2pj6
	 v6hcmLN/XY/M0vVJLAm4gcJhiqpYvPm3zncgmMEb2Bxc+ag3YAEffoUDPk4nYKKVhV
	 pQB6JsfSfLPMSz3+Ntg2STMsws+ADpTuVKLJFLoen7tr/SqH5vAtOCWu/TiJDQJBwE
	 L4syWn53xAzTAgK8uiPTi7Xw9VdqpUFcAA4Jty2y49b5MLb0PTn2ie7vqCov12VxpM
	 j//n751hV98KrZ+jc9kJuyhky96ryLExTgiMj9lRLkdACIEPUS+p3MUpamqN8IEhab
	 FnE8TTELk9meA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1A4523938446;
	Wed,  8 Jul 2026 17:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/rseq: Fix a building error for riscv arch
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178353000492.3027451.2869777955092824432.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 17:00:04 +0000
References: <20260707082348.36896-1-hui.wang@canonical.com>
In-Reply-To: <20260707082348.36896-1-hui.wang@canonical.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-riscv@lists.infradead.org, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, shuah@kernel.org, paulmck@kernel.org, boqun@kernel.org,
 zhouquan@iscas.ac.cn, ajones@ventanamicro.com,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Tue,  7 Jul 2026 16:23:48 +0800 you wrote:
> RISC-V rseq selftests include asm/fence.h from tools/arch/riscv,
> but the rseq Makefile only adds tools/include in the CFLAGS, this
> results in the building failure both for native and cross build:
> 
>     In file included from rseq.h:131,
>                      from rseq.c:37:
>     rseq-riscv.h:11:10: fatal error: asm/fence.h: No such file or directory
> 
> [...]

Here is the summary with links:
  - [v2] selftests/rseq: Fix a building error for riscv arch
    https://git.kernel.org/riscv/c/a2ac823d8a22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


