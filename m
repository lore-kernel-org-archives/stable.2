Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FE332637;
	Sun,  9 Aug 2026 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315108; cv=none; b=CWkc3vhfwS18Y2rOLlPQ4Vb+Th1dYmntPlYVz5H8HzSPgCmx79aMR32Y5vUewHPaTkD2vPfFgxaPJ9r5Elq2kI6vC7fy6ET811A0y+IXYVAOouB3qI+tfVbzI6pmm/U+3tlUG3DSupL9kgWQaBPfNAZLv35fsg29CNsU1enaFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315108; c=relaxed/simple;
	bh=9uXVvbwmxJlVZdsy8/FM9pRUpIvi9m5XRfP/wZW+f7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpexLTBkVXr0CpV77FU4sohSr8cTmJxHuEny3/lnYQ0oxkizoLWcb8UK93DyHFWGh84Nd/cBv95DJ8hPvcqV42ItfmNXhanzFN4wbYG0DKi7OKZJBgIK7gBaIvZlEGF5T056LsZw8HCZWmZhLTuL0McvQ6wVCLDxVQFKIloqh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsNdqdn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsNdqdn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFB21F000E9;
	Sun,  9 Aug 2026 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786315107;
	bh=wZtIjDLVGmtQQMz9TIMBBoiqmko8Dygis52/ET3Z6U8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nsNdqdn9/5pv2Gry9QPiXBCjPia5/k207hYQCmR6BiyJZ+Vit126tNaUWahxLBKmc
	 IXFL0B8VUPvgJV0oBSC4aoK4wlDq0nCLSMN3NXLb/vusCNvzbiD9SA9xZ0cggI3maS
	 YzER26XA2HgxTKb4BRe/PhukPOVWqAvyT7E7Bc5jDv61xCAr/3iRCEw+oufNOoR2oC
	 91W35WuCgQhwZyObOWLTBEB6vPN/Q0MzxrxLmDGyreS9VmyQBq3L+5/sz8/pGTOis+
	 QaNJoW1/tvcqNqas/3IkNXGuqjPDrWaRiFkdSIXk+u5e3g/SP9Wz2bfLIQcJKo08HX
	 EJsdDQrpY9f3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BC03924A55;
	Sun,  9 Aug 2026 22:37:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] binfmt_misc: don't leak the user namespace when the mount
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178631506414.3049071.14867849911905814452.git-patchwork-notify@kernel.org>
Date: Sun, 09 Aug 2026 22:37:44 +0000
References: 
 <20260728-work-binfmt_misc-usernsleak-v1-1-dbd8d5e626e7@kernel.org>
In-Reply-To: 
 <20260728-work-binfmt_misc-usernsleak-v1-1-dbd8d5e626e7@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kees@kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 farid.m.zakaria@gmail.com, corbet@lwn.net, jannh@google.com,
 mail@johnericson.me, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Christian Brauner <brauner@kernel.org>:

On Tue, 28 Jul 2026 15:48:10 +0200 you wrote:
> bm_get_tree() takes a reference to the user namespace and hands it to
> get_tree_keyed() as the sget key. sget_fc() moves that reference into
> sb->s_fs_info and clears fc->s_fs_info, so from that point on the
> superblock owns it and bm_free() doesn't see it anymore.
> 
> The superblock drops it in ->put_super(). But generic_shutdown_super()
> only calls ->put_super() from inside the if (sb->s_root) branch, so
> nothing releases it when bm_fill_super() fails:
> 
> [...]

Here is the summary with links:
  - binfmt_misc: don't leak the user namespace when the mount fails
    https://git.kernel.org/bpf/bpf/c/b8206f516fe7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


