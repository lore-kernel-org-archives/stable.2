Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480406;
	b=K173eotSrWBC3ITHD+PzhV1ypTZARVqtlaPOLLIw4hMsiYcBV10Fg634n/j/CFOV2wXZ
	 KRhmNQ2BALzvuykwsFeIRqUSEzCR2gTmiHBKQm8R/6avIWnsHDmSYTKpXybC2PK8fh5L5
	 XRhUCXSwI7gcs/v34TK8pnnYuM25K2vFKDOBZB/snXOyQFDQt92b9XTPWeRcsLKlV1/xG
	 BqU3e63OUukVtQjSn29U2E17uL85W8uRm1wOqLdv71oEJd1kdKVPjqpXFPU52QJ08t/46
	 n6N9fax3b+cEchozFGXcsr7mkzEYm6e8Ipdh/VqsaHm5Od13BkgJhGYcNceZIvm7Qew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tvaagE412ZZQ2C8Td0wspnEHPgM7JnRmdMvv2uNBtj0=;
	b=kFA2qGPRARrzVqcVAbCvzEkB5yQYhbujMzf1itbtgKDHlETUWwUAYtDtjBDR0WPkGagc
	 MXdifOJSSgLpVO+XyIK95Q5mE+itBpZKLjdJGde/L0r/jFrR05A83v6fa15gw8fSRfyUC
	 /uGnUE+nhH6QvASp12D3023ZoP4A8tHtNPuiJN8Gh3PydLiCdf5CMPRnrsXQm+cptpL0u
	 ggll5/TXRkdA4N+jf25XUkJ07ga9Mp8LnR7jkvtOk5P3Qy+yRv71Pj8xmLGLe03sXLv4y
	 Rh3+/fk01BK9a1hTrVhdJaeiCiwH9P4NL9a5Bn9Or0MIB6YWp8O9ifnmZ/GiCEZKvYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4g4pH81;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCB606A31D;
	Sat, 31 Oct 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4g4pH81
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5AA1F000C1;
	Sat, 31 Oct 2026 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793480406;
	bh=tvaagE412ZZQ2C8Td0wspnEHPgM7JnRmdMvv2uNBtj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B4g4pH81uIqm004gaxn9G3lWKFMUoAyQqjZT0zhUREj54rEet78IRU/SgxAwmMwxf
	 lTCfiTGHrLzAia1+hQHzcB/K1GMs7JL9VGPES2M9Ua3Qi7psl1QjAuA5F7y1TxXfig
	 Z6c74XzLP8FyfAVevxTKLT3prVEyF07Gguni2RjBSrN5cV67w1JMTnfroLnY+v/O2k
	 99xeJyPGC2T4lnmn/zOrrdITLoUirP3oARvcv4EarYXXUkSJBqZ+QWw2yL1gfeJqbo
	 pxBELeHcJdxiw/iZ4TpTiDXdgH4ED4g5Aft328+GimaH/qmWjGWI6tcy4VMc/Io6t6
	 K5SVn+8pxJnVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031723809A3C;
	Sat, 31 Oct 2026 21:00:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179348040456.2232106.10839463350905272434.git-patchwork-notify@kernel.org>
Date: Sat, 31 Oct 2026 21:00:04 +0000
References: 
 <bpf_redirect_neigh_short_linear.v3.r0.20261031153053-1@mojatatu.com>
In-Reply-To: 
 <bpf_redirect_neigh_short_linear.v3.r0.20261031153053-1@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 kafai@fb.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@gmail.com, jiri@resnulli.us, victor@mojatatu.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Oct 2026 15:38:52 -0400 you wrote:
> The issue:
> This is a follow-up to the short link-layer header fixes from Eric.
> After vlan pop_eth, a privileged SCHED_ACT BPF program can call
> bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().
> 
> __bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
> only that mac_header < network_header.  Nothing verifies that the MAC
> header is long enough, that it is linear, or that the IP header the
> redirect goes on to read is linear either.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
    https://git.kernel.org/bpf/bpf/c/23503acb214c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


