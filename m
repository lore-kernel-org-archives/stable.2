Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441001;
	b=DO55qrah7AJvmHKWFU2kBeTCgGSTwH1Ice3JEuKDdE7VHd2HpQjf0cnOiH9upUdX7lX9
	 AxD3FMOC9yx7aKJJvTSkcmbhLfIqe3KaHLGHghXE+L/rKQVZeOW/WkKhCv57hfotCs5e9
	 dptPyTNR/abV7OJlIBiju3GbE7itCJ8EGgdLcZupa0NRIHPNrbGe5Jjmu1DYqbH1C4eX7
	 s+dJu34fv6yA1ccJUJh4UVgUFURVE1mspflRfg4LIBRwBiSdbBA9o06podCLH1qmSykRW
	 L66SwcfTUJkyw9BWik+yxsnkIIOfUYiVOchdu83NpugVIQUFDJV7Zt8XuVeT4lEeQ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S9eGMwv9EqBbEEX2MNNoILxQ3TMBAugbnnLoMrdF+dw=;
	b=k1Lx3DlFIN0+/TDXmCr61fuNc5dghStAREjU8tGjNEj+ZYh55mOIoAN0dNeEZzE4fATJ
	 50IIKpVoYukdeP8ikbFmhUnYckDZuK/+99/iwvGoM2EJtwWQvobE3JuATzWSZ24vg0+OJ
	 rCIfxI9z+PBQJMlbF2m3XWUgCSnDMQUx+JvtgqO1HKEvZcuQNqHcz2zH2wZZIBBcsPkVa
	 lVvg2JUP9q84vidyXqtMeZwPpWNBlBnf/fbixjpiUMCXe6bQsC4eSfnUun8mDhkaquwj0
	 GLUWfl7Bo5jnMT6hTr8U+5ISZdz5yNVWYoBfOK10TG0WjCwAqxLoK0yktGyNWjiy7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=M7nz4C2M;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB50606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB50606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=M7nz4C2M
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b8306b9f8so38721206d6.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792441000; x=1793045800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9eGMwv9EqBbEEX2MNNoILxQ3TMBAugbnnLoMrdF+dw=;
        b=M7nz4C2Mz8ane5eW/WdRbOyTKo3Q1vkLsYWhhB+2iQ90BZ24DpYvskXhZsXQDRntxR
         NjUP9PLKr2m/6Nx0WSxOx55ZSOJnW16QsVyhnmqxhtAC6Kfh9AwmSusTomdgbR3Ux5ka
         WqQw/cuw7tDXDNNDsvYO/KOKUclDffUAOVwJoZhlBJxrLyHiVAmCav9YGWXaOF/mCFpb
         FAfuef3n0bmdlyJqA99U3I2hStpW6IdMJEJ3Mtie0/drpu20ct4h3G2plTFpo2EMH/+0
         WHg8pSokOWgfzO7THrTl4XenWYkRsAmbHHAxI0QP2GPXNkpRgelf0cN9ytXLJBg9WxsQ
         ue/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441000; x=1793045800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9eGMwv9EqBbEEX2MNNoILxQ3TMBAugbnnLoMrdF+dw=;
        b=jV61zJU3JbNnPJp2hgqUIi1MNph502FbBzo6UQzgTc7F/cQYmf79mOgGqX3NGxRETt
         1X9JmJzYj24FEUYO15uZiVz8BybM1ZyleVBdJAZ4MEjaUabur2ycblospcndO15F8Kq7
         43NmUiulR1E/n5zggyFIPQIfV5qq6AF/FwXbAFV8IP8kuRkU6wnoglTsWcy/awz3QoCc
         IhFCR/3p7FZPVGUGsQ35er7LxwVGjf1bbMhtv7Sm09GD0+F8sma/wMWtyDMj+JiToEej
         0rF27UJ3ecmXF9S0AG1lMvfey4PHyJX3PHWDH8vdxZFTJWte5pA8LvHYA4ixFVpewU7N
         vtMA==
X-Forwarded-Encrypted: i=1; AKwUvBxn8ogixITQXTkko7Kt5qHo8AQTfJY2yhu0SacpHa2A5LvR/C6jI6a0pjhQO7yWRO4LTB3uqhw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK810kxZM7Uc6cKH3HkDYH6CrzJhlVfAhQauDyzF0GxX1TjTgBV
	VE2CrJ2pnFuDy/nlQmVoNncf6uHA5WfWNAGXxGbTGA47hyi/TY6xjKTIBas5bD4721Y=
X-Gm-Gg: AYBFou1OrYtYwyr8l6kdX7WkabzTdAmr9tsy70X2QKA+hwnflzD4k9xEYDsvW0b+woY
	pF1jthASTvcZlV6EFf6JG2t3VSXSzsm47k+BeeE7QE8OCNVhVLlGxZFU/SQmfmB9UiRHwUjc4/l
	zpRN1VbRSKQkfYbDFuFmEjMUsSbd+2V6nTIdrT6kGB5K1zETvhifIj6MQptCbva9HVc/eu6VNTJ
	qyhr6Eq/S+cdye6hmTbT9c7uIgPw7VEI1UIgDKCgLMr12WsWEqGbE3mGJWhsS65QadI5j54qahj
	+89lA3gM4FAusO7az743ouuycXZp5mYBiF8sV/mBOg1T6NEhkecTiiIDTjGb9QiKPF7kSywIVRA
	ZN+Xk3XgufkulHPzydSdTckMAJ4ZsGYTR9f5ckV2Tz+0ojrxGO8mRinfLHGl2rkPWWIe8Y1RPxp
	6tjLATf4Td4sIHx5BDBDQQjyQEuvG+VD/vUXXQOvU8hm2HgiIWVJNKUvouzKwQY/Qv7eghyhX1U
	EiXfJXvrT9EZyGJ2X+sOo02OFPQxCYEKMrLKyFTpAAqmB1G6XyyDZu9
X-Received: by 2002:a05:620a:2954:b0:93f:167e:d990 with SMTP id af79cd13be357-93f29d76b1dmr1324305785a.50.1792440999939;
        Mon, 19 Oct 2026 13:16:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b05c917sm46679685a.10.2026.10.19.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:16:39 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:16:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, 
	hannes@cmpxchg.org, flyinrm@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: let the highest memory node recover from
 hopeless state
Message-ID: <atZ6H6IIx5gmiAkg@gourry-fedora-PF4VCD3F>
References: <20261019184850.3427905-1-gourry@gourry.net>
 <DM92ROTIF1U8.26CQNH7ZPEBG@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM92ROTIF1U8.26CQNH7ZPEBG@nvidia.com>

On Mon, Oct 19, 2026 at 03:51:27PM -0400, Zi Yan wrote:
> On Mon Oct 19, 2026 at 2:48 PM EDT, Gregory Price (Meta) wrote:
> >  		if (kswapd_test_hopeless(pgdat) &&
> > -		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
> > +		    num_node_state(N_MEMORY) > 1)
> 
> Why does a runtime behavior, clearing kswapd hopeless state, depend on a
> static memory topology (excluding memory hotadd/hotremove in this
> context)? There is nothing telling us if a fallback node has available memory.
> 
> Just reset it regardless. kswapd can go hopeless later if the node
> cannot be reclaimed.
> 

I mostly agree, but this was more of behavioral change than i was
outright willing to commit to in a stable backport.

I can send a follow up commit to drop the check altogether if you
prefer - but I'm not sure we want to drop it outright in the backport.

> BTW, LLM also points out that kswapd_try_clear_hopeless(), called by
> direct reclaim, only clears hopeless when the node is balanced, but that
> rarely happens. So hopeless state can stay much longer if there is only
> one node. Adding Jiayuna, who added kswapd_try_clear_hopeless(), to gvie
> some insight.
> 

Yeah I have some additional things in my pile on the hopeless flag, but
i haven't gotten around to them.

~Gregory
