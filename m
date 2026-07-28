Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA8277C81;
	Tue, 28 Jul 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200458; cv=none; b=b19TjlgXmWIeg/4uEqZBPFhIjWwVUy+1a06f+PqD9wALCAtzjcEViDLwfDNFddrkY7Tr85x/cjAeCcoiXUReSicgX19eMsyR/q98ofF7ImEphQ2C6OMmNzN3WTnLGk+ldey81ZYxIjJz/BS4/xh86rxlnb3r0caIg+aHvpCZ8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200458; c=relaxed/simple;
	bh=8L+2noyg+1jsCNwkRJzxK4rIbtTsBUgm2pKKC7E/qdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YFQD8lG2oyqg47+e0/BwwDNK6pxS+R2J+M9plpZJMMjnQsLbxIhGgcR4ZIIv1toDdgMwRnO25Qe1Y3tC6oPtu63nNHfEXEBD+/LF5ER/3RpZFgPWEb6C2yqCkeNDROobZjci+EiSD8gSg91gnvu+DRDNIwUCVdjEVsh0ssqWBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSo9WHEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSo9WHEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61161F000E9;
	Tue, 28 Jul 2026 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200455;
	bh=YRblQhH+uVWut5p5K8lZwDABtoCwMjoVNvbtRet4Gdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CSo9WHEjnd2dmgqvCw7qN0K2fbI2JHUCr8YJMtY5kvMFblWasUMHPNUjpd/l8jLp/
	 YaseEsb33z275Ub4i8obhjFaVtoI70JAzTAFsC2J+AjMiWcvYGHkpPUsqDKtuMDB5a
	 2ebrFNR2FmT0DO3TWFOZ7IJ7utl/MVs5xhGtAlQSJ/2gxantr0UMWGpG4/H6f3gp9B
	 /HQ9A8753kp1tAYCFpbQRpLYET5N1X2mFdBK27qgy5B40JbRJgOMjtBNlowMmPxnSY
	 fq2QavulcOwpMET3eR5aUj2vZNaG0eLMVwGtQch44EAqIGloGyn7a/4egJuyfwJY6h
	 ei6FFH/OgfFEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56964380CED8;
	Tue, 28 Jul 2026 01:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix dentry folio leak in
 find_in_level
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178520042088.1482784.9634568618514854667.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:00:20 +0000
References: <tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com>
In-Reply-To: <tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com>
To: Guanghui Yang <3497809730@qq.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 19 Jul 2026 16:45:14 +0800 you wrote:
> find_in_level() gets a dentry folio with f2fs_find_data_folio() before
> calling find_in_block().  If find_in_block() returns an error, the
> function stores the error in res_folio and breaks out of the loop without
> dropping the dentry folio.
> 
> This leaks the folio reference on the find_in_block() error path.  Drop
> the dentry folio before returning the error to the caller.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix dentry folio leak in find_in_level
    https://git.kernel.org/jaegeuk/f2fs/c/13f88c0865be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


