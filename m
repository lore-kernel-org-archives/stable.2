Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391180;
	b=q9Se5ZQ2jfJuOhsujVcEtVv5LwRJ5RtCaVKO0PWGxupM2LaSBApCBk2H1rxvHaN2UsOw
	 idoqlYJHM/BuchpNf+qapVjZq6xqqnSMu54+Qmw624HbleXdWlUxiRXrbIcGHTu47MPkz
	 tx0k7XWP2UpFDLD62FsoglTPK6g2PZVs+MZNhBDiNKKkY0McNz3VwMm8SDh90yg8EFPo+
	 ugV25HnVJPa526aZbNqjjrvqilvQRtasHgNTcrO044hGv/8Zgrzw0z8ZjcvUF22p5MxI5
	 kiASupbde9pBo3qkq3u1pe/pkT6Wde0SLXfbR5QAPbUVRv6Sm+thrAviPmwl648aG6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
	b=fDRQDmrezDUMHt+j+QqkxEHfhrH0zZaMSbCtmBhq7sk9YA+4Ic77VpPWE0RptGHfzdao
	 yYFb7yw+adDztI7uAlu8UTdZ1pvxzW3hf/y7bZXZ7lHrDXPs9/pr50EFtaDWgDLbifF60
	 TpuSk7qW4PMXY7SEFNtzJlNkcUBPGy6yjaGtBQEivOqk5qkGo6E0hSFumKIVmZ/C2wb/v
	 FT5/pt5bD0cCcUwliZ670PguXQ5jjOcxYGUpH+jN2cxW0KgqeKc+dhcGyPS47FqWGY2f9
	 GH0iOg+JyM0EYkyOj5WRuOpP8HPpPiR0gKzlZMNJ1aKiIgifuzVGV1SV66dYZTtSJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbdZiQoN;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652C606A32E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4652C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbdZiQoN
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so563851eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793391178; x=1793995978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
        b=SbdZiQoNd9v8nZxQuOMNPRPAe3YN2K/2lS+7X9Bn5BxLITOLrcB/hcYjzkI20WWS4y
         fQtDhN+STPp2Dp0/8jJwHW/ofizMr/sz7JyYnt0QKsCias2AT1scQyiu3EUysCy2pkMm
         5+8smIXAqprspCMZSCaCNLCvO9EIOEqYqVaFzDA4ea+YmKxbDNbpYljFke/oD5wDjtz7
         KVbwuTxXV9dDsWLdse7wjZIq7JVItQopjnOPpBeL6CnpdEAh51fr4V/62fxwkrOom3al
         rq9la/RooBlB1Fx85WhoLa0CIdH4Nn6lEELyrTkCoIaEivYuHKS1p/GFeD36Mx+YqvSp
         eTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391178; x=1793995978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uEj7dkzggUb6lkggRktE0fOB+YC39Gh7yxfAZ3lKo4=;
        b=u5BpFVD1NBRNqYHNJlNNpqWx3f8PqRv+p/sePNh9almfDX47K6yr0ceTK78+0fHxxG
         0Yu81a7DspFmDDAKO1LeQ8c7pkPtYuthXwh51Sa3UE4gDdKdFmCc+2SrZElBw0cRjngo
         k/1b8p4CiIxWsp0wvH0YD/r9uVgV9bJyYfkyLVb0vn/6KvW8dTa7RkhMMgUX3JHrePZ3
         4a4UirwbQDLZCFcpGNJNp3JpLHLP7xS5pKFeoBMRxpjlL6OZnBhcsJYz/PRhZXLZtntD
         e8CV1UErJsZlNH5JkS5jlsuIPnQGfFFuQfKLbBN2jlxR0eVxzX+yg8vFpmxFCCg5zx27
         lhHw==
X-Forwarded-Encrypted: i=1; AKwUvBzhiJF1e130RgQNdR5ybCstvlyXwDxH+VYQ7pd2ql8J2CUd6BvK6NKsrod8OmbzQMX4J+cknp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCrhAudxLcW9P4jTAoWkLw0weT4PzlJPqTRT73yyiPfT06GVCq
	3ZKAXmSrCodYPR6OSwXZUYuufFDXPNrXRg+jV5P9STx4gqzVsubahX37
X-Gm-Gg: AYBFou3lWK1596zQ5hbtHxLDy2sejhV8A15O8NsUtTUINSxkZn5W8oEc1JH00g+jspe
	b6px1s2xx8/fIU5IWMsGxboNjK3gCmsKVFknIwfDyPoKpZVmsbYYrLwVZa7IgECEXyS9VmYtmEi
	j6pz5M21nAee+p5kc1DI4ZcU6zHzRuwiWiG0kH4g1nmyGPpMfVFX8p8dcow9a0PdcuwabsqafoP
	7ZD4lqU9d1LsxbvXYof7khLZt3XF3e14QKk4J3LvOV20vocQ0bH6kN27DurnEFWm7u2oC7WCCl6
	/BhoyVqdTkkc6cffX775Qju1iool5NKJCGdqq6rQKrtP18WqLKyejx3hYn2ZHBCXHCln5x3nr4I
	ZRBnV/OtjRG1JAS0BxCWmv5LLpuWuRmZqrl8g9UJp0+wzZlm9DSn456ygCmD9DeX29bK2sP1wD5
	bkNyOu2Mvwq8peaAxEeJ00BadP5vbjA/XTUevl5AIcWj0LLNce1LA7Sq9e1AusRjOGCeGxsmaIX
	7dq0c+MiUYNDMkXHnELwlkaRcpBTncpTr28y4qoxIoJJ8gLyl8UMJQhLhKJW5cgaQ9wXuRI4b5I
	gDv9BWaEB3N862YHnsBmR5Y=
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a4206d82emr5086488eec.0.1793391178247;
        Fri, 30 Oct 2026 13:12:58 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm9450626eec.19.2026.10.30.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:12:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:12:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030023248.78802-3-testwrzwrz@gmail.com>

On 10/30, Rongzheng Wang wrote:
> Extend test_xdp_metadata to send the same UDP packet using every descriptor
> count from 1 through MAX_TX_DESCS (MAX_SKB_FRAGS + 1), and to run the
> existing metadata and checksum verification for each case.
> 
> Build the packet once and write it into the TX descriptors in a loop
> instead of using a flat two-descriptor layout. Keep the first descriptor
> large enough to cover the checksum offset; the remaining payload is split
> across the continuation descriptors, with the last descriptor taking the
> remaining length.
> 
> Reuse the existing AF_XDP setup, packet generation, completion, and receive
> helpers in xdp_metadata.c instead of adding a separate test harness.
> 
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
>  1 file changed, 92 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..17da0a145666 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -18,12 +18,15 @@
>  #define TX_NAME "veTX"
>  #define RX_NAME "veRX"
>  
> -#define UDP_PAYLOAD_BYTES 4
> +#define UDP_PAYLOAD_BYTES 32
> +

[..]

> +#define MAX_SKB_FRAGS 17 /* minimum CONFIG_MAX_SKB_FRAGS */

Any reason you're not reading the real value from
/proc/sys/net/core/max_skb_frags ? 
