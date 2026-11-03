Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667010;
	b=iLW9byZcVlDwMrOtyT5v19yxe/of6hdMf10SK98vQb5nbLi8pNKHlip9LeAulJ0rHrGg
	 LjzX38vDry7lKeB4QbCH/WAbsua3WpdPuK32Wh0Xv+OGR0V9wkLK7jjvQQTXeSZsAWSS4
	 iozJTRKw8fT6E8oKOwXffs5kbSPUlteWG0H22oaYc9y26hVITIwmd9j54Hj/A8RLKyl+d
	 NW3hDbgpKGDkDSFP86wx/OyU52ksxUltlDRLWeLVScVsZgYhMCIfV5lx6i93q5Lw6Qd7s
	 +83x4aF3vKNzXMM5VD3RJoRzIvJDFj9C5tDRO6x9gyNwgHL4v0WshJDGa9tRP11jrHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sQM8DOk+zZLZYMqSaPiKyghSQOh+EEtZ/OBexp3ZNJ4=;
	b=eabdBVdP/U4JGTyFUF9V4Ub5rMuhrlAC009Gu2S7wjPop9BkoDpv/Pt+jJOj0tGL/xJb
	 umF91dpYpSMK0JgPbPPzSJF8KEMGToqOho5e1c82U2YFYH/1tgncQ+6FXClwjdJeGYepK
	 R6KFYOwLgg2BnN9iH52dx/ZkD+GeENRUkV6j1UwMOcVHszO1uh1g5iBdVMHJZ666hvKIo
	 R4WmMmeWhI68QKM9RM5t8qap2TXvHf0buMdD8rbm2ggbFWpdQa571JfwDmUOOy4P3xvHC
	 g9VWQZwAmKwVM5rJcd+rj1KU2WogsIteA6IU5vEKpIKHndFL08+y1opIOBbC/G4AeuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxTdKS3T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB5606A329;
	Tue,  3 Nov 2026 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxTdKS3T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B801F000C1;
	Tue,  3 Nov 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667009;
	bh=sQM8DOk+zZLZYMqSaPiKyghSQOh+EEtZ/OBexp3ZNJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JxTdKS3T/D0H8YXeBF7xqpYwd0KtU7EE0AJG6yUYf1hvBq1FPdyBLpNi5/yG/AGoq
	 EEmvDZCGxw8gboYd6u9cV5qNB/chUcuAa1BY1NY4bNZtrRfzPw00V+CpLRS9qxwl4f
	 3dXD9XllocKghwTvf2WZsigIL9Z/FZUsjxiMN1Jqy68WXCkqsS7Th8vMeMkbdr4uH+
	 bbpLMcmXRPKZAgFHOfWzMhjxOSYs9aeq3ZGRpI8loc+Yfut8lZzn+rZI+TCWMGsRbE
	 n28NeLOmkRHTwYmgwYBiYiaT78es2aeePX8rIbZfkaiBbdVJA8q3yJkQrEp9x4RVIV
	 LcCeYdKunvWrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D44B380821F;
	Tue,  3 Nov 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix use-after-free of quota file
 names on failed remount
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <179366700804.755181.9413256107192916599.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 00:50:08 +0000
References: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
In-Reply-To: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, sandeen@redhat.com,
 zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com,
 syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  2 Nov 2026 10:36:46 +0800 you wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> f2fs_show_options() prints the journalled quota file names without any
> lock that excludes remount, and a failed remount frees the current names
> before restoring the old ones.  Reading /proc/mounts at that moment is a
> use-after-free.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: fix use-after-free of quota file names on failed remount
    https://git.kernel.org/jaegeuk/f2fs/c/441baab7f06a
  - [f2fs-dev,v2,2/2] f2fs: free the quota file name that remount drops
    https://git.kernel.org/jaegeuk/f2fs/c/f0d620265cbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


