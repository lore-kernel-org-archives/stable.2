Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE6377017
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316571; cv=none; b=kn9Yv0LDQhzq9ZnfHIEH8rS14dCFHIsrSHgeCiaqcAIIMRrQX74IhDK8O7nEOkAti3PVXkym+XVp5lein2UwOWWz1FvRvYLGzImStWqQ6cLWF8ndaM+RBRQdO9tNx36wMQxwFYXVRH5tI9ezvk312M8VBpluIiVT8R/SMHzQxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316571; c=relaxed/simple;
	bh=2WgfNreLWJxft+zoPVPrApEmJdxucipKkpzWrRjPZeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv1gQEHLUxxkneNH0WDRubUAYhFOXeHg0Ka7hyR58pcj3/z+vfLFT17zjuoC+K2xK863yaBvgjcu04fwCqWblXn2KF/FVLCuju2hHybv9pEh5KlNLzoMCb197432Yq9Yq+LKTmOa95bq9OAhUcK5XOmAduYRdgN6r/qvwH7Dnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/nScCcT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/nScCcT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso1175342f8f.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780316567; x=1780921367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIha1sal+E5YftvHy0Sy4Bf69FGdGrpFmedRP0jS2Og=;
        b=H/nScCcTtdE9Lwy6QTD/1oevOOZFwBIZiCeE0/KxbXlpI32FDQckbMn+dFMtTodzTI
         5hNXye31DOi97jDhE1YBEWsjegAkl4dRgXHjm/PnyQLMnlgTi43kEZYbnGZvJkm/At+B
         Pyr4RpkXOWk6+OnQyNE38/qm85uiaFpWk+4DP+n3z/gBabN4BW9dsThSAbNW+yCmmRm1
         NpN0bo3wf8PAfEL1llCQHPD6UXrgi2R0G0JkEtgLPB0hLEkevTuTxMOFUFj3Z4Hrv1uF
         w/PF/Zfc+ro1+SLESfhW3FBGUsm3LgoU1bAwpRsSYL7wZYmmufDqmXq3MUxSMlGdmmMF
         9cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316567; x=1780921367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIha1sal+E5YftvHy0Sy4Bf69FGdGrpFmedRP0jS2Og=;
        b=EPOHBlcamKhmCYH+ofc7dqytfBw2vMMSxQtlAp+qScJZrG5rv7JQQnVCmYeyP8FyNC
         XlSf1SooVt/Ktp+3Xgn5ShLOUYV/US53QfI0kxIU9Qg6QTauLSqYIQlwD26XwM9CQvAd
         i4dVBUu0uMabSEvfJm2iY73V0tTv7Jf2ntz6j3UnhtxbCLB7BEqI1v431CVb9FHdzK22
         COFM9uO25Ox4NrmX2sWQ6UovCuyGffieThrqj1C1vo3ZkbGwvLovCb4wkX7Xv3oGRtga
         d4mbzscvuWX0CaPemJEUHrmI5cX0yddUII+lMcYTapARPOvaD02eXi1cKrQVxV2g4uwH
         bOoA==
X-Forwarded-Encrypted: i=1; AFNElJ8ggZ5DylA9+DKSZ7nXdAs0dC9Fg1aXRpEzG1yNkWxNmaXToEKi+y4ogGrQrkRykkGFUfx5wbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzro8w728eSL+JHWXTbBLzt+laqgyRWm/wWn9CBeAzYc8qt24WR
	ZMjUQWiFA4kFiDOazw0/EVcw2ANeMGY9o/IxPBa8xQKfqRdVDgFAD8yV
X-Gm-Gg: Acq92OGLClJrGMqkZ/lVtTF+8UzWOqaelND8iZFzf9BmxIQuzX4MnyvRRKQiHtsEc3i
	OxBipZFQUXs9mY8s/dYgDEWsEE2uj9fAR/xUWRuJvZZvVNAxbjy6N7q6yAbGMq7xRvYTQvZPIwE
	MjFh3ZiOv9HQ3uvXYC5Zt8GKFssvtJXrQP9p/jtVYmrJMjuGqQd/tT+0zrfMUkwlwZugxqRDgRX
	4xgcv/nRWHGELGAC/j9G1Glut89Tsztd+0MfvAsiyLouGSisqx97i1VnzDRrQBIkkVXQyjfm0Jg
	b6LsAfI77Vop+pkV+V6AFcpz8GJK+FL1rQCpAnDTf/le04dPepD5CMyPEEOlUh5Z+sNK78IzO/F
	mQBazOqxpjsLwREjuzyiT5N2Zd6ZC4jkj9nVZMiyXSJyGqs8zdl6qC4s+P0JmiYHWqOrfwdKpek
	eBZjCNHtANZFArpm3lmGD1Azei9CwgLMrV5uBt+nUWBDRSFVh2m07SJZMpobl2PneI5ORuwPA=
X-Received: by 2002:a5d:453a:0:b0:45e:edc8:d440 with SMTP id ffacd0b85a97d-45ef6aea822mr15326542f8f.1.1780316567078;
        Mon, 01 Jun 2026 05:22:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd87sm23765184f8f.24.2026.06.01.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:22:46 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:22:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260601132245.4be1b32a@pumpkin>
In-Reply-To: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
References: <20260531153946.1627418-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 23:39:46 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> ipv6_flowlabel_get() still reads the shared per-net sysctl fields
> flowlabel_consistency and flowlabel_state_ranges with plain loads,
> while writers update them through proc_dou8vec_minmax(). These checks
> run in the live IPV6_FLOWLABEL_MGR path, so lockless plain reads leave
> KCSAN-visible data races and can make the policy checks observe stale or
> inconsistent values.
> 
> The race can be reached on a running system by toggling
> /proc/sys/net/ipv6/flowlabel_consistency and
> /proc/sys/net/ipv6/flowlabel_state_ranges while another task repeatedly
> issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> state-ranges flow label.
> 
> This issue was first flagged by our static analysis tool while scanning
> lockless IPv6 sysctl readers, then manually audited on Linux v6.18.21.
> The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEMU/KCSAN by
> concurrently flipping the two sysctls while TCP reflect and UDP
> state-ranges setsockopt actors exercised ipv6_flowlabel_get(). KCSAN
> reported races between proc_dou8vec_minmax() and the two plain-load
> sites in ipv6_flowlabel_get().
> 
> A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side reproducer
> also hit the inline ip6_make_flowlabel() reader through
> __ip6_make_skb() / proc_dou8vec_minmax(), but that site is already
> fixed in this tree by commit ded139b59b5d
> ("ipv6: annotate data-races from ip6_make_flowlabel()"). The remaining
> plain readers in this tree are both in ipv6_flowlabel_get().
> 
> Use READ_ONCE() for those remaining sysctl reads so they follow the same
> lockless reader contract already used by other IPv6 sysctl readers.
> 
> Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> 
> Representative QEMU/KCSAN reports from the two target reader paths:
> 
>   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
>   write: proc_dou8vec_minmax+0x206/0x220
>   read:  ipv6_flowlabel_opt+0x6d8/0xd20
>          do_ipv6_setsockopt+0x873/0x2220
>          tcp_setsockopt+0x72/0xb0
> 
>   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_minmax
>   write: proc_dou8vec_minmax+0x206/0x220
>   read:  ipv6_flowlabel_opt+0x129/0xd20
>          do_ipv6_setsockopt+0x873/0x2220
>          udpv6_setsockopt+0x21/0x40
> 
> Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/ipv6/ip6_flowlabel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index b1ccdf0dc646..1ab5ad0dcf24 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  	int err;
>  
>  	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> -		if (net->ipv6.sysctl.flowlabel_consistency) {
> +		if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) {

That can't actually fix anything.
If the value can be written concurrently it will still be zero or non-zero
even if the write gets split.
So it can only ever be the same as the write happening a bit earlier or
a bit later.

There might be a real bug if the code looks at
net->ipv6.sysctl.flowlabel_consistency again.
But a READ_ONCE() in an if won't fix anything.

>  			net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consistency sysctl is enable\n");
>  			return -EPERM;
>  		}
> @@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  
>  	if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
>  		return -EINVAL;
> -	if (net->ipv6.sysctl.flowlabel_state_ranges &&
> +	if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) &&

Ditto.

>  	    (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
>  		return -ERANGE;
>  

-- David

