Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310576;
	b=bw0KSjPNaFa86TNkvIe2ODHCcsXqir6+F0MpJ56xNrVspGNvmnXGtNpuBgOb1+mm58mu
	 qjhfg/zZzgTtELGgjOubzt+ZIFcNSKtBoB36QG6SEhDLrSs0Km6zSjmwSoKOq3SYMwbAi
	 +Mx75vn2LYgy2xfPsSOLhk5+jHuQHxwdKVx4X2R2+gEFZjjhtV7JevwySaG5RaYzPlMr2
	 Lp2UpMW+TLlBrUXji92H09+AC6Z8yEA5WJCQaCZXfXI17jgzuu0+gzpU9vCoFgXUpdfkz
	 5P3ISh05XcyL2HKI8r/XNKphYRHbzk++/8CeLHtMXSD2c3nzBcK5b0eH6vmyrMQo9SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KARVFzaA2emNcbaNE7Zlfo9u+xQFHA5uL67hKotT2QY=;
	b=muLPGwtbDDWhdqR6JqMwckZIEvBEtfU0il5pLNYXFX8f8T3TQJ6QfTVpkbAu52nuB3qC
	 YnP2U5XaQqJ2L470M90/BTJzJcno0+kgf3kzJpNTA3/GkrVmOyNvdCrV+KPjDal6pb5jC
	 CDyKNx1YMRAHN2KTp1HEUdzyQ3MxXvOf66TeY6W1dq3vlsgKXDDG92s6Nizy1aM29UZpL
	 KgXFcBmzDRX2JB5pATUx7yx23lsr/bV4gCoAWX1P7Rric9UyxPa8SKtKbRuoZlhj7y24D
	 BTAnYvCSuTGxxqTcwLoJ20qzZQB1mUHiWk6dd2NwbfqfSk0cLZDmyP9lkKHXMHsVMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rw5ebseg;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8873606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8873606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rw5ebseg
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215e64962so21761475e9.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794310574; x=1794915374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KARVFzaA2emNcbaNE7Zlfo9u+xQFHA5uL67hKotT2QY=;
        b=rw5ebsegRN1Bjft/2/4FWIrxGMhY08bhzAOpYaPg5CXXWQYAoujXytRwfsQgivSZFa
         LBv4hprncfZ8YS61fd0bNtRQNE5xOMEqkeN3rm4NaT0sGl300b5/WnB/xrIDvEqy3/ee
         zpOyMM7rUSXHTaJC0QMa3DdxfAT031eWhpVdBU1w2NB2kmqe44IPIjDsxlHFws6FXG5D
         rwoG5+o0rhLEQmMevMoCUNjQpMuJHswFJ4AGVpZ7owRWHdpTNFJdn/5tQsiHIDetPgnX
         4ZjLG5Wnx0VS72E8PX1au1kM2YZkzm7n/Au+dTEGRH1LNbcwuIt6x+5ikP1vzRUuJWyn
         V4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310574; x=1794915374;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KARVFzaA2emNcbaNE7Zlfo9u+xQFHA5uL67hKotT2QY=;
        b=KOrDEuKzOPgOqhxyBmdjHYZ3FXcSpbcs/gbQjbeLkEq74slV20kwpm61qowze/e0HA
         h30Nm1XEnruBdVVQ3CbAPQmzz8rpam+huzKWUCFxcfDwU3zssPKQUQ+/VqWtwaCQATGD
         NqYxSTRkkR8cDHHYmq0WrPe8PGYKfXthvXZwScppSIQDAP2z4uQwjagADKMXP0Yc0oO8
         7f0kaq+qjOwgvX3ORwE+6GAdCa66TdbUgW+YVIO4u/4Jjvs/XF3BeR5RDooECdA0JNRo
         QoAv2A/QNKB1f8niZ4bBHXtMKsByZ7mF3xMM5Gy0kKuytsOoXr+dqXw0JI6bSitd7xs4
         DOrQ==
X-Forwarded-Encrypted: i=1; AL+hErHV1qd1I5ZXKmw9wxQQPDoPI6K7amrr2WT2qZ15r4JyZTxORMJ9LLdyvRpnkZhgd39d85XthOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fmd8AMovbXpKzOy4luwZRYutKsg5kUDyj3DicifPfChbtbFR7
	WncLUlTVyzIHq+W2vx/t5CByJFP5o+jSeGPhz+7NA1vFHhEU6EOP6RcQy2Nv5+l+JK8=
X-Gm-Gg: AYBFou2pzguBS+DDoqusByV+PGtMem1OJEjsFYfSk/LzX+sJdr9zGaDeRoD/igjBXb4
	udBKOX5ulGhvF9VutVCKt+2tKDAo2GYpQxA0hqkHXnRIqwm24AEVSGP+6t7PFOXiPsFsw35N2rs
	pXm6w7C4h3hijxdbC8CglDzHNAyXMDexzRef1PBIK6CRO9Hlw5oAqlA/9h7/sySzROzVQyhBCKO
	SEAFqeijLwbLC0XD5xAsF0xU/4HIpcLcR0KpD8KORS0elekOgxQ595D3znspjaDMBglK6v6AHWk
	vhwyuQJmV9oC05kbL/McvYoHycz+SBwCLlCC8j1oRMb0BkA15MBC6ClgxzsHMTyI0/gPBiVInxT
	7ymngkacI8HV2u2epMbaX8vC7uf0+bqqocne/WXw+uZXkwRDo7TBN04EGKDMmCoa1/CmdDEuPvI
	E4P68gVZcbxWqj+U/pfwEM45WnaMKjQUT4FiLuQHrmqG8TgIyIHcCKa0zLYXxcQaHRO0KDUWfJy
	fTIjO3XdXUt4ighoqpLiK4uM1nsIWf4XnX2FYPNEVbK5ym8Mxc0ahkHiWnH6K3wv80+PEYQUVnv
	Sm3z89R2YG4AiQ2kWmwdK44LEmtLI1fo4w==
X-Received: by 2002:a05:600c:34c7:b0:4a2:150f:1609 with SMTP id 5b1f17b1804b1-4ba0233bd68mr41274365e9.8.1794310574048;
        Tue, 10 Nov 2026 03:36:14 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba020485bcsm54874055e9.11.2026.11.10.03.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:36:13 -0800 (PST)
Message-ID: <6d0fabcb-79eb-4a17-af3e-b58a1d1c93fa@linaro.org>
Date: Tue, 10 Nov 2026 11:36:12 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] perf cs-etm: fix a compilation issue in
 cs_etm_decoder__set_tid()
To: Valentin Caron <valentin.caron@foss.st.com>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org, Leo Yan <leo.yan@arm.com>
Cc: Paschalis.Mpeis@arm.com, aaupov@meta.com, acme@redhat.com,
 corbet@lwn.net, irogers@google.com, jolsa@kernel.org, leo.yan@arm.com,
 linux-doc@vger.kernel.org, mike.leach@arm.com, namhyung@kernel.org,
 patches@lists.linux.dev, robert.walker@arm.com, sashal@kernel.org,
 skhan@linuxfoundation.org, suzuki.poulose@arm.com,
 amelie.delaunay@foss.st.com
References: <20260912065621.463708027@linuxfoundation.org>
 <20261109171457.1233670-1-valentin.caron@foss.st.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261109171457.1233670-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/11/2026 17:14, Valentin Caron wrote:
> When compiling coresight tool with the command:
> make -C tools/perf CORESIGHT=1 all
> 
> The following build issue occurs:
> util/cs-etm-decoder/cs-etm-decoder.c:551:15: error: too many arguments to
> function 'cs_etm_decoder__buffer_packet'
>    551 |         ret = cs_etm_decoder__buffer_packet(etmq, packet_queue,
>        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by removing the parameter "etmq" from function call to match its
> declaration:
> cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
> 			      const u8 trace_chan_id,
> 			      enum cs_etm_sample_type sample_type)
> 
> Fixes: 99d324594165 ("perf cs-etm: Queue context packets for frontend")
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 277da9f767b9d..caacab8c92e26 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -548,7 +548,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>   				elem->context.exception_level, tid))
>   		return OCSD_RESP_FATAL_SYS_ERR;
>   
> -	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
> +	ret = cs_etm_decoder__buffer_packet(packet_queue, trace_chan_id,
>   					    CS_ETM_CONTEXT);
>   	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
>   		return ret;

Reviewed-by: James Clark <james.clark@linaro.org>

I tested Coresight decoding on the 6.6.y branch in case there was some 
other non-obvious dependency missing, but this is the only fix that's 
required. Thanks!


