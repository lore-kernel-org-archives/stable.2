Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D35427F8A;
	Tue,  4 Aug 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828651; cv=none; b=bECcZVLn4/Su475Sv04ta4qBlr6aSsNy3mQTFF5xz2hmGYNUFf7X6Q7Na7k4HrwfOXHmOweLIP0UAHl6YzZaVwzk/IE7A7OH0SLQDGSGd6EuIDBfbdq7zAiD3li0Ue1ug3sRY0dbpMfxZX2S89SGPzpNSnTl4zQxvdlennvOUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828651; c=relaxed/simple;
	bh=SOLTJEJEXzwaRmRUywBLmqrxVfDxNPkNMw1db+bkp5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bm3ypJofMffot8zUqZQAdEnJ3N2aiwXT5xkz5TIoo2oUOjmHX9omLBHQRzRj1zIxj9Cl4HKUbEkAq5T/eGLDyUVbnAKhPd1b9YWDx5ARoEmNVY+U2y7Z6jpYFFPiqbTowkGqHxSuFCL9j6iGmzFvesmkJdrywM/Z5PxahjE74U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLLtvy6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLLtvy6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E061F00A3A;
	Tue,  4 Aug 2026 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785828650;
	bh=oYV5O3eWZLdXdoL+FVkjAr1wH1gOiwtwjBSgUcld4qM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZLLtvy6V64IS29HeSFNsiy1L54s0YnzkP9fhy4b84TZle3bqd8BgzVIBHrvvL3161
	 3eOFRheE7Y66k02D2I2WdJHidsgMjAo6ljQcru9l3Oo4JhKMf1Vv1dyvXbT6XONBBz
	 CKRQ+KfZJc7dQfF/iETPQYPdKauhgS3b0a23PgTG8+SeFW4C5hn7NuxmsrJX+kODKv
	 VzzASV1hizn8h5k9C7Sl643XmV2eC7PgUQptWNAsLBTL4s13hDsZ6AhB1Y3MXvO8N3
	 9YW/x0Dtqf2xfXZFZCUHXWGfi73vno9WggK8q25dTUD7jDC2gsThmYf5i8iz8epEhp
	 e/EJNxRQwFUUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AF3924A65;
	Tue,  4 Aug 2026 07:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Fixes for bpf_get_fsverity_digest()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178582861063.3014158.3566038608254697461.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 07:30:10 +0000
References: <20260803181232.14743-1-ebiggers@kernel.org>
In-Reply-To: <20260803181232.14743-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, emil@etsalapatis.com,
 jolsa@kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon,  3 Aug 2026 11:12:30 -0700 you wrote:
> Two fixes for bpf_get_fsverity_digest().
> 
> Changed in v2:
>     - Added patch to fix silent truncation.
>     - Updated commit message to clarify that the size > INT_MAX case
>       seems to be unreachable currently.
>     - Added Acked-bys
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
    https://git.kernel.org/bpf/bpf/c/3e8ec7c03872
  - [bpf,v2,2/2] fsverity: Fix silent truncation in bpf_get_fsverity_digest()
    https://git.kernel.org/bpf/bpf/c/7c68ed5c5ad4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


