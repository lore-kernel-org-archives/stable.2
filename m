Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8543803E;
	Thu,  9 Jul 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616429; cv=none; b=FDt6jeTbqXecDIIcZwBXRnnWRID/4LFRX/+DGVRujE8g11xTfi1Hx9JjtFgKUunb2EbeisHakVJ9xb7wWoLTarEZ9wHC/7/Ef38J+JeJJH2+aGBPW+FnIdzGcQQTj4bgXBzlMvcJW5pB6QYPtUGKrUCWa/v1R+nBKXmGWcj/pSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616429; c=relaxed/simple;
	bh=TE6TkSRxEPXrOws8eM+EkyEB3zf4y5nj8R7Jc/0QgU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ca26nOs4s/KG9bodZtgGAGSgDdHA6dzXBOdJSAcZ2JMAV8dNnEfg7msuCUv8abPxA5m9yuwX+V8h00SSA5uRYlLF3q+pTYSGVBmKGze8qR/myGeKl8Uc+uSsJw1OzuyRrNVGtOjDEclg0IeLoTEPc0otCOCsUwsTQ5thJDB4xTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRLx1Lf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRLx1Lf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0671F00A3E;
	Thu,  9 Jul 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616427;
	bh=3Kfy72ehgyZBshTSOMM1niwkdrsNSED9pTDMvKT6/UI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jRLx1Lf1bH7VTcHD4HPkYz/7o494waP48d/i25rQtBBJ5L1vWa917pma5eh6KMrk+
	 aN0YbqrSeAR5hvrYMtiQDoivnTIuzACEtAMCefJa31AAIVUNjOxonPdfAe4DXxmIvh
	 UTEJQzQDLBjOyNI7PaK9YctMSix9rnNH6k0qF5UKxN67g+4lIbiCzz7HWAICZZKCpI
	 1KcUhYIpmLGoD5vEm5PnverDDNUuP2yVXIgQZr91b5YrgLldrqXJYabK45AMUBD8dj
	 zF5rHgnyBfB5SBa1UlIRoDM4aAYMDG0rcqgGeUcU80OhrXdifwbpWA12RtyBTsWMVn
	 mkD5nbuWYt0ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C5139250ED;
	Thu,  9 Jul 2026 17:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178361640615.4028285.12738139082638292350.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 17:00:06 +0000
References: <20260709025316.999913-1-mattbobrowski@google.com>
In-Reply-To: <20260709025316.999913-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, jannh@google.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  9 Jul 2026 02:53:16 +0000 you wrote:
> Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
> before bailouts that access it"), sk_clone() performs an initial
> shallow copy of the socket field ->sk_bpf_storage via sock_copy() for
> the cloned socket newsk.
> 
> If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
> to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
> to the parent socket's BPF local storage. When newsk is subsequently
> freed via sk_free(), the deallocation path (__sk_destruct() ->
> bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
> leading to a use-after-free (UAF) on the parent socket.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix UAF in sock clone early bailouts
    https://git.kernel.org/bpf/bpf/c/7cbd0c4cebe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


