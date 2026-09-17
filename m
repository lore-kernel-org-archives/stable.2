Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E350E5A6
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666341; cv=none; b=YZGBrKYkogPKryGdnXrc5g4AzMsxopzCAbIZbJEVTwTKMzhwZkkCGdEM7ZbkqlBllqqtfbted2OOTN3ezN6R8rikeWKZTfxxFzCEs5HkrWKPsdGzNYfH56r6dPNM7sHgaO6Fh8vIFK7f8BRaFGCtdhdgTBEnBOVqH7cOecaKEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666341; c=relaxed/simple;
	bh=AUxsR9+Q30j7A8KTn2nOOxy8tNIwmuhqtluI/wLUA40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxxltnhS4edtKtrRqxngsDLvFHpAieZccOxyJQ+FB/H+HkKeg99EbQGrAvkiVqQnvMRdItPz7Q0TnGpTzv1iuIvnTRwZbHNKUFyAQh5G0w24PLkKHpGOjggxN59xSpKop1r5uIJ5C+ZmQ7NljaPg0DJhDd2zvWkf+LMoo9eiyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVTxc9QB; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVTxc9QB"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso631340a12.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789666338; x=1790271138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmSH5NHQUw7amQNSN6+eO65bUS5munkLsHOJPnnYVio=;
        b=eVTxc9QBFvzIBl1WVawBp1hTceELY3djkOUpapBgbtgPZ79XXg8KD+Hi3OZNmlvbJS
         zNsf3Pb9p+AfpGOpr6uouP0B7XIUqiElT7GKsbSM2uO67uFFvkbCJvojEr/7IHZqAiyY
         gm6Do/ar2M7bZKYXNVB41soyHo+0ITpoXaC7nszymrOHf+uHWNCBjsyMhrZmrxDY+7eZ
         rmSe8znEJSIhH5N1tj6hWUAP3Dg309a/DiTkOxAyjHIK30tSwYEJ74Xv8zYduFzeW90L
         VzvmSP34mpwbxGerQkJbR/OMgyD04ATluZXA/z1d5AjiWj5pqxEgx9hKO1rNxlB1A6Xo
         Tryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666338; x=1790271138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmSH5NHQUw7amQNSN6+eO65bUS5munkLsHOJPnnYVio=;
        b=f9zKoF38rfFkmREhYCepKQ6/odKWULzYA+Jj39iEYaIlskJdze+83guNpkcGYOXZ3d
         YHryOYbxDQLH4ZsDIyLdIQnmnL3WIPts5eJagqk6+M1Ju3uaU8bxOtT6szrZnqFRK7gp
         Mb9kwMHvz1NWTPAgoPknADzw5RL9e1Zeninxin98MuuPRtO/SciVtMwqbml8h7gLEbmU
         HGO8+RNiFoILaR2f4JyF32zol/fm9DSOx96c68Iujc9WQEwgVI/c7egcJgaVMGNxy+er
         zgu6qYJuRd7MAsEHYUg+ka0MM8yGHx/a9f1fCYWa/QlDg1XsWYFVdqNtd8RNmEImFOM+
         MsJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBeoSa96UNNRlBXmt7pGROYC/t+mYhN5iZbr+ZmCtgb9RZ+KUM6KGTHkjmh7iRoSYYgexch1o=@vger.kernel.org
X-Gm-Message-State: AFuF++lz0hqnYKesBm8oKH6w0j2nF6LNTxtTUYpeFPgz0dzKYtXCkfEQ
	mNg10iS7mln6AnNEFRrtzs20XC89YyCksDVEAaF/lS/U4x8rYCtQk+Gh
X-Gm-Gg: AYBFou1Ew4ZfF3/uWyvCyeYR9L/ZmPLioeFaNRb+QPWYPY5HAylAdmRdWb5uX2OICaJ
	6Q42idj2hpmtTG4gLunFua6ZeiwrQzVsofliPSptJzrlOh2TV+kXv69ZkeCv5iu7tvE06vtTBus
	SqGsSzG8PSCM/zSGhywUPJFbKaKVMr0kTTzlb8Or1ermOHZHOoWcOZkk/Cb9Fbvnu428IY6kaeR
	4kQ0G/wIKTILR03c34K0VaXQ/42EZ43Rm6d4Izs3n6rhITisuGA6AfJTD/NnppxD319AVP3ZnAf
	yP1CgMyQZlc8VbPuY6F1gJ4KoimOGTX6euzWav9jsL+AILVERKTsL4d/A5uif5R5uWmznsP32dr
	4Q6XQDwmHtrTMJwo3NMXx6Te1UBhe++9zs4YLMr5gufLEuV+z/wa8Lp6emijXxHn49J6rwhrWGM
	d1g+u7jW5nCpPwmLM1sD1XGPVddGX2JfnXIQDyvFENwLm7dkNl4NpSgZ4EOSteH/ub
X-Received: by 2002:a05:6a00:66da:b0:873:1d5b:278c with SMTP id d2e1a72fcca58-8731d5b421fmr8838431b3a.23.1789666337605;
        Thu, 17 Sep 2026 10:32:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872025db965sm3240288b3a.59.2026.09.17.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:32:17 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:32:10 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: bestswngs@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	stable@vger.kernel.org, co+ac0a8c41de69121d@bugs.sh
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
Message-ID: <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>

On 09/18, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> __bpf_offload_dev_match() falls back to comparing offdev pointers after an
> exact netdev mismatch.  Bound-only programs normally have NULL offdevs, so
> unrelated netdevs compare equal; one loaded on an offload-registered netdev
> can instead inherit a real offdev and match a sibling port.  An attacker
> can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
> metadata kfuncs specialized for the bound driver on the target driver's
> xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
> stack xdp_buff as a veth_xdp_buff.
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
>   Call Trace:
>    ...
>    tun_build_skb (drivers/net/tun.c:1739)
>    tun_get_user (drivers/net/tun.c:1856)
>    tun_chr_write_iter (drivers/net/tun.c:2091)
>    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Restrict non-offloaded programs to exact netdev matches and retain the
> shared-offdev fallback only for genuinely offloaded multi-port programs.

Any chance you can also add a testcase for this under
tools/testing/selftests/net/bpf_offload.py?

> Cc: stable@vger.kernel.org
> Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/bpf/offload.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0d6f55695..8c91d00d4 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
>  		return false;
>  	if (offload->netdev == netdev)
>  		return true;
> +	if (!bpf_prog_is_offloaded(prog->aux))
> +		return false;
>  
>  	ondev1 = bpf_offload_find_netdev(offload->netdev);
>  	ondev2 = bpf_offload_find_netdev(netdev);

[..]
 
> -	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
> +	return ondev1 && ondev2 && ondev1->offdev &&
> +	       ondev1->offdev == ondev2->offdev;
>  }
>  
>  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)

Why also have a null check here? Why doing !bpf_prog_is_offloaded above is not
enough?
