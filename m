Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636607;
	b=p2szuHC9Exx0Oyut+fFpmMB+0PoZppeYKU1Y+4S6T3tXXDiOhFXqNnrLGNGa3AcWEPoG
	 EsBadvCEMjxTnwgXZEDFUWLk11HOiMpN6PhRIqrBt/CywtwCUBsJsgcMZUvx2aSRKMeml
	 dntiFUiRvdrp9rIEya54hVIwv6YNNPCg56rLTBDvqCvL2Dk4WbocATANN9JnP4KnfM5aT
	 SG5x+hMGqGxuQ8lW1QChBFtDeJihwhsRJJEsZcbeAWmV2qqy74a8ObeTt4Slm9Ot/55Y8
	 rGHp0f3CErIkDYn3HOqJyCbxAh7drAwmiMhqH13m3A2JV0P/jsqSdT8A8KkUD8XGQxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=L9h/UAPmbKaXk4/qoOHze3vgmQg4+hfv0Rqo0AleFgg=;
	b=dgshc7xHE+obHiOULAOuQevdYQ4KPJuMkD+vRkO6eLa9rQB359P3CxqYXsV+X/hAYEu3
	 l2Y3FiOsnQk3npUwNrKFL+1dUU40wZTjLQpHkXwXIZAx7rJKg06lcsFPC+EydA/2IrkNY
	 Qi6QowQT1McxmdhN7uW/WCltAXVHXpEAgha9ouQEmx47rTkG1WPSbG3WbOHKhM00utztT
	 gRZGLjhE0w85PzXjdsZBeUHu89Q30udDTim2Ej6At72AoWuNLOaESgu12/FytFuF3+aRD
	 LXVQB62uUGPDsXQIthmgu7cFpWe1o/ebYLjUlsGwt7VKgxY63NuGaXlXxqEr/Ghf0VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miP5RfLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F60606A331;
	Sat, 14 Nov 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miP5RfLL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818521F000C4;
	Sat, 14 Nov 2026 06:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794636606;
	bh=L9h/UAPmbKaXk4/qoOHze3vgmQg4+hfv0Rqo0AleFgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=miP5RfLLvwei/QZ/+fFs90TyUZvbAEXReUZaafBGtp8xAs1/Nhb9sTWfwQ4jVDnrn
	 HG4jILtrinnkOJXe0RV3ehjAcecFUsYToeVLXuzVNiNPNwp4M502GkB4XuZ5Q65lTE
	 n50kxFrWoDdh5NNVKoFraAC9uuWE0qDm9V6q0zklrRUmYC69Dc5hN5FYuRbmVtlCLp
	 Ga+y98ICvBeM/eU8v6E3unN315obWhMolCEH3yt1QCL/iaUBAdfRlxin/FsrEyDlH3
	 ZjOyfbFyW5ORrRFMhT/ncfJlil10pEhp/AwQrHOdczoSfEDo+xD/8expmX5cesiXW3
	 O7AOaGAPiM4Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77435380821F;
	Sat, 14 Nov 2026 06:10:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf] bpf,
 lsm: Mark backing_file_alloc/free LSM hooks as untrusted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179463660529.2025154.16083428356016903156.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 06:10:05 +0000
References: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
In-Reply-To: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
To: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 stable@vger.kernel.org, kpsingh@kernel.org, matt@bobrowski.net,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, serge@hallyn.com, amir73il@gmail.com,
 paul@paul-moore.com, brauner@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Nov 2026 21:35:52 +0100 you wrote:
> The backing_file_alloc and backing_file_free LSM hooks get the backing
> file as "struct file *backing_file", but its f_path is not populated
> while they run:
> 
>  - security_backing_file_alloc() is called from init_backing_file() in
>    alloc_empty_backing_file(), before vfs_open() sets f_path, so
>    backing_file->f_path.dentry is NULL;
>  - security_backing_file_free() can run for a backing file whose open
>    failed and whose f_path was already cleared.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, lsm: Mark backing_file_alloc/free LSM hooks as untrusted
    https://git.kernel.org/bpf/bpf/c/ab86b62012b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


