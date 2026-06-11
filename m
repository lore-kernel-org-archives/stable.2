Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BF36607F
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214338; cv=none; b=dSL4nuyYYB0apf7iVhXymBlrThTB/Uw5zOitWMCE8SjcYTz+Q1x+6iWBWnzvNT4mwsYWLOde3BGYKox9SzpYGcEvruAJ3pr+95u6f7gJWUY2/gBL1pLr9YSYxF4IfB/iaS5xup+lCg6VGz9NnqW7kGmEXOitcwcHiTaeHFxzwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214338; c=relaxed/simple;
	bh=TWJOGOxVkpA6pYHt2k538f4kz5NIK8nh1QpbIqUzmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ7D02do6VMw7oeWwL/8JUQrspz9hHGlnQzubNCHxG04qQwV8oygAv3ZCUxGJ0XtpqXotT8NQnUCnErZM3OGqfEyCXVLvub0Ilhi1XjkWjmw45jTeCvCLv5VTMfzt+4Aos5DHfC0/moI46fnq8twE0tBTP/3R2SEGLH/sCrcWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=c9TXeOPl; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="c9TXeOPl"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1370417c01cso375615c88.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781214336; x=1781819136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykQKgx44w3X2k/qU7oxMtTqbK/zBreaZPe3qMH5/aXg=;
        b=c9TXeOPli3AVUUHXMKHoKh0ZJm/vYEW8IDs92gcSyG4niUUrB+J0KIRJRQYwNkXQNn
         8Pcbg4eIJ8MVSTLVKRehwA8nr92w4HEoFEkbACDSifkMc99hb/pdw60x/thf6Cil/4aB
         Tu+HgbL0gB7gwzw7gnyznMhlOuTrmedrM6GcDfLzjxcP6rEQRXmDzt5+fnp7wV+smImg
         0bLkEr0eXa5ZyWwFcJhaAltdq/+qhBZS7xEQqbIjm36M2d8OsBtSmpkD5zLBK9KHwpZ1
         SQQEnSnz1zTgRxOtTBAlCT8MEXp/JFftPzcwHIzZxaieHeRI59IU0Vfs3PVOoAXFQ8pf
         Uk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781214336; x=1781819136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykQKgx44w3X2k/qU7oxMtTqbK/zBreaZPe3qMH5/aXg=;
        b=RWLQBkmYcvSg0clw0nozxD8vwKzrXASkH7wMvzr2KVT5d/3wOY0lyrXQlPR3xBwTAz
         4G0SsXWOsDF6YXDIvvC0KM/mZsMHegtImtCKyxxOTR4Bt5nCOZTrFXO5e9hK0FEelong
         MRZZ658ikdyt/C95H2aqRHOCk8zXomla+UrqRL144alDcZsicgtzPuHi8n1o/yRrgjap
         espr8OOm2g8eJ5Mm7auMa2p2a6IPtGSFmwW4sgkUh6LcH0gBa7R4hZ5Diglnb8VFdTiZ
         MnmPxR6YifjNVK6XrJnixfbYXRgY6GINTSoNDxse54F7kLZ3MHcFNKWkG+YhvZpMmxn4
         0zxw==
X-Forwarded-Encrypted: i=1; AFNElJ9wi2OSKipgk7dRKKP7EEcm8ueRoK4caRCj5sSFwrg4X365ysqdkJnmwQbPZzDCYvcfAd9d2u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUA92wByf/FZQ3rIUZne/I3ZA6DFQAfMrath95OQ7eQc7BhP1/
	+USHqH6XQaXJ1lf+8Ncd9imyyAFSjKbs+M6xceLM1OpRXHXBAa+DhT/xVZ/6ATcKT84=
X-Gm-Gg: Acq92OGB0bkrrXxfFj94l8GXydn3Lzpgn08U8UtHrCilX03bpa2G7HIKIKncXWIfLKD
	ImMf+v9Qcx+LQJwyCBawy3MAiJDNB0bA8oK+HVcfSMahYkgx8kfMioiABfNH5h5jZtLrEwWwATP
	Xlx2LQ1u80TbU8FSBNFUAujigFpwNXe27QFcEV8pksJIakvyk0YO0c49sbkitycz6cuvt0Hkd56
	+aiJmo0K1Xnx9jqezUy5VHLGK24vIyJeq2wTwyqQnUHAse2cpSl0OhRV2PihZ7Cy/nt93+awEY/
	47NOpFwZzwxep06kXcl1wVkPQzEY4OgoBTjit58XWiq/+oQdPsnwY1F0I5bsMbfqcPF4SBcs4qG
	RrfX5TrlW2Sean8CnzKXho0eUvS+n6dTugjt/AzBjUKdnipjcEx5VzB/SeucOSQlMx5hlUYHw/6
	z8qP5b+T/pxfHOCq2o6innTXNmDPLEPW2aK8LVxLrQFLLdWDcrBbcGpg==
X-Received: by 2002:a05:7300:641b:b0:303:f295:4db2 with SMTP id 5a478bee46e88-3081fcc3778mr100907eec.0.1781214335754;
        Thu, 11 Jun 2026 14:45:35 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8d3c9sm464289eec.26.2026.06.11.14.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:45:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:45:34 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org, Han Guidong <2045gemini@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 4/7] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <aissftWzD7cdgz8y@pop-os.localdomain>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-5-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123538.156005-5-jiayuan.chen@linux.dev>

On Thu, Jun 11, 2026 at 08:34:12PM +0800, Jiayuan Chen wrote:
> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  {
>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;

Reverse xmas tree style is preferred by netdev, see 
Documentation/process/maintainer-netdev.rst

 
>  BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> @@ -3027,8 +3098,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>  	 */
>  	if (start != offset) {
>  		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
> +		u32 sge_idx = i;
>  		int a = start - offset;
>  		int b = sge->length - pop - a;
> +		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);

Ditto


Thanks,
Cong
