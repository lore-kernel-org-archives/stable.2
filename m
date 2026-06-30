Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB53C943F
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814291; cv=none; b=Y6ubwEm1xcRNE+klzZlSZlST+0TOFie8dxFY4g1MNbw1ECnWBScYehr8cJLsFmRLDvU+R3cprNr2fpvx/0nLjNvHmbItjy8ckPeZDmsWRfMtkk6MNXj+ciPigtl4tD5SBM9gwUOTV+Vr4gdyZacqQqxJAHwi/PhkQP7sd1P0cIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814291; c=relaxed/simple;
	bh=S7AI+YFxLu2eH+drottiu3LDKyfzmbZsb6AyqgvPOSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQcr+V7aEidIf6Vi5cUC5owucTKUqwha7W/MPaaqZyDgv8aFiUqZTs5c/H3ixUPYZ6KvRSKDaDg+yL44EAlZBXeyx5WGkVM2oVTg6AWIhGfgh78IZUuqXQ8NwYlVCEenECB/AARMCnAmFLN2wVwVNqOpXFwV5xt7b+sIYMNcnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WW/woxRp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IW16Uj/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW/woxRp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW16Uj/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782814288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAnQNF/BG2hzcnpQlhZdj2/19/pQbi7MYSIKu9RdeiU=;
	b=WW/woxRpQbCPLChN7Aa4R+dthYW4yMg21JuibeFO5a1rBgBUs/OHTjPKyn1rOK1TNn4xTs
	ES1h8bulSeHMiKAuUNlZOnbgAL2If0ZYuRex35rVwMrsBtpHX6DtecgkIh5LazbjeEf/+/
	fYML/sqEkAS9wSwlQrV3HjVLU1ME3eM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-MOBMvkmWPi-EOJsymLCFUw-1; Tue, 30 Jun 2026 06:11:25 -0400
X-MC-Unique: MOBMvkmWPi-EOJsymLCFUw-1
X-Mimecast-MFC-AGG-ID: MOBMvkmWPi-EOJsymLCFUw_1782814284
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so46455615e9.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782814284; x=1783419084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAnQNF/BG2hzcnpQlhZdj2/19/pQbi7MYSIKu9RdeiU=;
        b=IW16Uj/mgrPaWGXQz+65l4gIZRF6EwG1EIpJd6BXfxI/FfoGes+lv4y4NfHYgH9LF1
         AiidRFtKqzxMLz1NuhxSldcOhRYBurXAtaY2Rax3MrfHvWrxvp06kB78lX4jGuyxlCQ4
         lZ1EBOm2xD5IDndlgTISSpqfs5ZRayBNIUBrpqpldLZMLJY8DzhKTac5z9jssHS0TF4w
         /h/3sfUkrh+pmXfvnhhXVClU3oQMKeqCji9Lv1byP9AVMpklbFrtvQ4lBg45KB9nI/JH
         5T0x9mbmAtKlSrvuwyUexnprcF8gfh/2JC7/YZKTHBdvACJoh1WKSDlm/7Sxv969Coum
         sF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814284; x=1783419084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAnQNF/BG2hzcnpQlhZdj2/19/pQbi7MYSIKu9RdeiU=;
        b=nIAzziHkbxUOnI00kpM4/j3ZvQGtnLXhku3LACIy0quGppegfeM4IkF+pDDTG2yP9A
         elKyc3CAlkz30zaAhUixBUxjSxLQSPEoRnZi0b5MZYvJsBJ8+y7Zl6LLHIvIjuXhHFQT
         WeqR1gC2M/Hcn/RNjoUWTBtRhzsT9jKxsMr3+JNAivmIsQLYkfF6JT2BnWnvhsExfQxR
         VM24Ss35iRyqrlgR5AJm5RU4pA2zzsjmq/Dcv11KX7r7lSkG9dLupzGdDgb7k+zPM4uG
         VhidWMI1y37SkLrc2paN5vl8qNkU8dZSLqkCRQ+xbV6vcfwiVBUaRKMg+rz/JcwBsUhU
         bO2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rosel3LtAGOa1UGc6Nc/gHvx/h7vPjJNWA6d9DVs919RQaHjIRnWJfCJPiLcGr1QnU3Hx+WeCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKaCTMdMqgpI0Eg0ZCCu0A7xtyBNKNkwx9GEjKwYkMxIjm+E1
	FbTmYJSNRLJVQOkmc0yn0sHE5EGBwbE/t3mLSHEBw/emb6i7l5t/pKENgNTx31085YiT4QHgKuV
	+SPPU4jgJCr5K9Xk6IOXndHmPS+nu3PQ9A9/DrDjL6Ynh7QorJXQKaHKVBQ==
X-Gm-Gg: AfdE7ckGLi4IilXW15oMcF0xi32W82FwDqH4OtEihL9YO/XDOyKKmrk5GtrK1Nh+UpK
	IN0ou8P5/pvD8DfV797MgCaxkWmQn3ARoXOWA/9v8PHNjiBt+hPF71xh5cBSKAyzqKAIE4yLtHH
	/TPYQBUYOXZE3iTBWVAE3joerezej8QLojRGAn+ZlVvtnvb+pi1cDt9cnCG0cDZ89e48iw5frBC
	pvyncdF3qY5NnqunGpkpuLkF+S+GculDk+dAeAgS3Bw5HoRKlwuQfaBspeObDpnLbIDkTQT0Wyj
	Mvq30+OHNLy6M3DqYe/T/5Ii3hoa88WI5O1LPT4sHm8KJdplCY40vGm22j3FEwUux04i6x6lsyy
	8nVKm6J4ZzN47truXHmDtZmDU5EluyLo1UESfmY1mUs5kPhb1Xwt3+yEh/ZKfLy1sAFJ6UFrfIp
	HunTus02GKkw==
X-Received: by 2002:a05:6000:25e3:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-47551737cf2mr3519497f8f.14.1782814284113;
        Tue, 30 Jun 2026 03:11:24 -0700 (PDT)
X-Received: by 2002:a05:6000:25e3:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-47551737cf2mr3519449f8f.14.1782814283688;
        Tue, 30 Jun 2026 03:11:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d194b0sm6739249f8f.1.2026.06.30.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:11:22 -0700 (PDT)
Message-ID: <2a1c4eb4-a4ba-4fc7-9bda-6a7a8d0be2f1@redhat.com>
Date: Tue, 30 Jun 2026 12:11:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: make busywait timeout clock portable
To: Nirmoy Das <nirmoyd@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626144902.3214350-1-nirmoyd@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260626144902.3214350-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 4:49 PM, Nirmoy Das wrote:
> loopy_wait() expects millisecond timestamps. However, Ubuntu Resolute
> can use uutils date, where `date -u +%s%3N` returns seconds plus full
> nanoseconds instead of a 3-digit millisecond field. This makes
> busywait expire too early and can make vlan_bridge_binding.sh read a
> stale operstate.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: stable@vger.kernel.org # 6.8+
> Link: https://github.com/uutils/coreutils/issues/11658
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>  tools/testing/selftests/net/lib.sh | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index b40694573f4c7..fcaec058be6d0 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -70,12 +70,27 @@ ksft_exit_status_merge()
>  		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
>  }
>  
> +timestamp_ms()
> +{
> +	local now=$(date -u +%s:%N)

shellcheck says:

 ^-^ SC2155 (warning): Declare and assign separately to avoid masking
return values.

/P

