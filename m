Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD1217659
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781340121; cv=none; b=o+Sf6czNBHy/gQ5agqR3HxG5ezfOSTSi/oMw0TBQLtG4RriWnf/bGYMFR3AJ9XMTM/2anCH4QmLSd427Ro7EVUFC1ikX7w8k4fL1ewmSYPbUVw/lt+vjPY1DrTA5tYSnMX4nLnukK57atR6iU80DHq8OkegCyrT5mVzuLNg4lEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781340121; c=relaxed/simple;
	bh=IaywYboz+fU/JPKklrGFTfyvFjd1tpc8+yXTZw7fh2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4FSZDKfQjUxP7UURCsajBKb9BXNQxz4X3PJdrZv3XIVTR2KaOIYulAT1kyPvG8uL3WfXlRLRBVuwMlg4QBq7veLD4XsZQnbePEMSyjgmF9U0RX7nMmZCMkXRrP16jyun0KQ/2AERh/cWokN23HDbLFbOk7WS3KGtGEaZtU7IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ita42ngD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDnv1mUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ita42ngD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDnv1mUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781340119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uJWP9tqMCHTtoSkkYE0M+RWI1R32XPw5b0Ycy+j2b8=;
	b=ita42ngDDabhD3UqUk8rgrIEbkUT84cyLrt+0IDkRwPxwlm5n6j4ugt8PaClJAHilmbxNE
	+xtnBuO98x5xRkHbjaS8D1s5+Ke8DriPTZWT6kb+qztsU8aEhMjC3qGwX7SHfVxc7wHsJk
	aLCgDXtBp0NDxeKpQQqZvmNraRnl4jM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-em7U7o35OOCUeg_jdnrD0w-1; Sat, 13 Jun 2026 04:41:57 -0400
X-MC-Unique: em7U7o35OOCUeg_jdnrD0w-1
X-Mimecast-MFC-AGG-ID: em7U7o35OOCUeg_jdnrD0w_1781340117
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccd3213beaso35785226d6.0
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781340117; x=1781944917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uJWP9tqMCHTtoSkkYE0M+RWI1R32XPw5b0Ycy+j2b8=;
        b=FDnv1mUSUxntJSIH0LFoCseFFFewp2hlRQj+pUshQhnxBmh+SzZwPW3Sx94u6jjaKd
         b8ZbOSh3zuxcDjuUNb08iW1nHLAzL6xbUuJiX2gOh6geLiC8Hhy68AkGw+29WwU1xKsj
         dt30oSVmVO/c6FwAL1Ca30MjYYb1rSbrUoHr7+kJUvWoiJsHxSKzhYiKAvesIwu6bukg
         NPWqmbkY+Kx0Q7Ke7BDJEfAcoPaRsMGGnIvx0a7E1d+Hrgskj060YjNN8kYwTdv6ex3s
         IYVImq1+WQxrdu1bDZRtD9eAhIi/thAJQB6bAfSL9PnYnlXqobKudMlYZiDD0dpu0l2Q
         xW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781340117; x=1781944917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uJWP9tqMCHTtoSkkYE0M+RWI1R32XPw5b0Ycy+j2b8=;
        b=m2WQrCifQi8JW57+BXA4ML7tZYMIOdaZnSKmYDwA5b5Z2HDHqifqPP4d/6NfDS7QJT
         m5V2l23AEA6AYHHbKMltmsqrmAq5AuUkVHgeptEm0A2Q03wzm3CvojY4XQRiHCbfNtO+
         ZsoI2TrOUFWj8/YZmRRQT/hP//TxfqUjxa/G4SVW305RYsCbf7nJjjC4Y4e0V4tHpnTD
         5/N48dToRuYtwUIQpVP3L1T9zAj/neLXSHYwYMepQElrm2O51lTWsStXfsdsJ20GV5k7
         e+mOs5Fl2jHFKvJloWgRRGPtXJYUojrnki40zhmR1YC0zHMR8K2UQqAE5XUDU2P4nYrT
         14cw==
X-Forwarded-Encrypted: i=1; AFNElJ/tpu4SI5UMvOdDSbMgF6mBzO1jxnsFLkBbTddz67YN4LHDfFJGgdDofG+1bjePGZa2YJqgokY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylQSVwoGECietl42/QuRgCmIA1DJSYnKNVszrdgKjJvCEY9zCG
	lZrnUmQjEfHyREBpsUJKKXFfQ9gZF6O+K594HhZZiHlkH7SsfFt2igkIMCbNXsJy/J7hYopBvuu
	ZmrnVOtwENDIvUiCn47yGU2uLS9KHC8K5p1Q7gY4+uO2UX8fpyGnhJXM7PXoRAIbw0w==
X-Gm-Gg: Acq92OFH0KewWlvyLMXEoI1SaRDX/1kAx8oNl0GlrXAHimCYrsKhyOgJ2xvadz4f15E
	9zAANxZNCEXQld5CQJG8LL5p+Ai7965nUxFB8Oux+hzMWii4ikbZgmWyTdtAUi2JqtX0YRFW/63
	0VYNaARx9c25STnNDAPXOFAUKNGcvq9hAnYXokOqXg8CyF4YmRkEJ6aeqHkdBztGT7/4yCgo+D7
	0SOzct95TfekzKBYStWbjHoijIqHeZ3IS8DH1eAOXLUbJUTlbA4IMYVrmhuhPSBvQQedMhGsVen
	JdKxOCffuIraQ5+tZ7shHDaD241KpMkgZfjVWmncTdfNTalv/JmwvMZ+CLUkX4nUvN/lL90KyMZ
	pAUgaxBwpqAGy9ftPiuinMOl5dsrS4yBnBR0h015Alg74dyZ03yIHgKY=
X-Received: by 2002:a05:622a:1102:b0:516:e086:89a with SMTP id d75a77b69052e-517fe4ddbddmr84850801cf.26.1781340117268;
        Sat, 13 Jun 2026 01:41:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1102:b0:516:e086:89a with SMTP id d75a77b69052e-517fe4ddbddmr84850531cf.26.1781340116835;
        Sat, 13 Jun 2026 01:41:56 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb841970sm44912311cf.30.2026.06.13.01.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 01:41:56 -0700 (PDT)
Message-ID: <9b78ed2c-f664-4c56-9626-63ee73c6177e@redhat.com>
Date: Sat, 13 Jun 2026 10:41:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: sja1105: fix refcount leak in
 sja1105_setup_tc_taprio()
To: Wentao Liang <vulab@iscas.ac.cn>, olteanv@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20260609074002.204113-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260609074002.204113-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 9:40 AM, Wentao Liang wrote:
> In sja1105_setup_tc_taprio(), taprio_offload_get() acquires a
> reference on the new offload and stores it in
> tas_data->offload[port]. If sja1105_init_scheduling() or
> sja1105_static_config_reload() later fails, the function returns
> without releasing the reference via taprio_offload_free(). The
> stored pointer is thus leaked, as the driver will not clean it up
> unless a subsequent TAPRIO_CMD_DESTROY is received, which may
> never happen.
> 
> Fix the leak by calling taprio_offload_free() and resetting
> tas_data->offload[port] to NULL on both error paths.
> 
> Cc: stable@vger.kernel.org
> Fixes: 317ab5b86c8e ("net: dsa: sja1105: Configure the Time-Aware Scheduler via tc-taprio offload")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/sja1105/sja1105_tas.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
> index e47967b12d5d..96cb5aa04910 100644
> --- a/drivers/net/dsa/sja1105/sja1105_tas.c
> +++ b/drivers/net/dsa/sja1105/sja1105_tas.c
> @@ -575,10 +575,18 @@ int sja1105_setup_tc_taprio(struct dsa_switch *ds, int port,
>  	tas_data->offload[port] = taprio_offload_get(admin);
>  
>  	rc = sja1105_init_scheduling(priv);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		taprio_offload_free(tas_data->offload[port]);
> +		tas_data->offload[port] = NULL;
>  		return rc;
> +	}
>  
> -	return sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
> +	rc = sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
> +	if (rc < 0) {
> +		taprio_offload_free(tas_data->offload[port]);
> +		tas_data->offload[port] = NULL;

I think the config-cleanup issues mentioned by sashiko here should be
addressed.

/P

