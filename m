Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18C20C461
	for <stable@vger.kernel.org>; Sun, 31 May 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780238198; cv=none; b=JfeS4UI+vtjqUBRux87s253YNfcUrta9FHissXQpgNyZf7v9QfWPfyJxAjdcd8o13Wafr3k9FUcw9dzyzd1BrCYFWYmkG17MVWHLymtHvRwBs/mtgQK4sE5sqGnEi44zbhY6wj8UXAy09hrDSWo8xBiw31GQBkNYvQvIdECggxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780238198; c=relaxed/simple;
	bh=VBfST3UXgyTlkP0EH/KCc/5GWH1k8BUjMNuhwJhVe3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHcL3DYYSD3JISleBxqWEfmwrhwguCMp/itpy04GnIQ9lILp0k/i7VK5vq5QCC/gRyatSMdytQ3iObrCTOYMK1VLkVAaGTzjoS1PKOIksOhi7c/LCAUWuj8E+4iEaYlEvJhfVQpmSNnhyEH+UpNRxv9t/Hz5bBu50l8z76VetF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFVBnxH5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFVBnxH5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf125989f2so20349255ad.3
        for <stable@vger.kernel.org>; Sun, 31 May 2026 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780238196; x=1780842996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
        b=fFVBnxH5kHPqoiPmu7l5fAUMMDsW8LZZWZ3AKlNtwKraIbQwlOXpguDIn5j9iNGq4J
         5RMyuPKsC/3lr6k976+ejmnviukM8S8FKLRh64CfDRdJf/baOgQiq3KG0Lr2Zp+a+yh5
         uYfFUM1DforP5ujnGIUnT0YAFOzj1k8NTxDJM0p6yjnHTQr22/SH2060SOO9iON9C7Sm
         N+KBa5C7WxXEjLTE3XuSzsQwFaC0jshNGgZlHcPr35S+QO/R2u5PTh0Od9fh+2qYr6q7
         NK/8vrxFvMk3k+nygKcUxprPviAsFQCGkRU414OnACp5y6S4084Va6reitM7ZDUufQml
         /qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780238196; x=1780842996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
        b=kfaGlmDYxH9286Cm/jngZh3IJ4i8uCNTalgONbEip/RZCDuEsXHLuNpIE9nLoOW2OR
         GJ09XG7W5U/OUKfXXsoMLJhilIJKGb50ZoKn7ob0HprziYRbCUWrdzMlYo6uWXa/ckIs
         Fn98doSZ6y8EpfMYscgINM9gP+5GEOjr1b/rWGa1GYyao1SMH4gC/Mw9AbuhdUWPX95/
         ZGeMzKWGv8YlMLfvHdTymz/ZJtmoV5uaoLDOncr1Eu0jqf+dtEimfkc6GRC/yPctmU8W
         R3uvW0APr3E6ZouarHHRQMhzSNKL10Ty9/81lz7vEAv4HKlR1pZLrMTUCJlqAGDxO0Zo
         U2Ig==
X-Forwarded-Encrypted: i=1; AFNElJ8N21hqpc8r5brt/SUeEGC8GSDxs9Xd1pzHyFrxvvCHM2LjQ04LIBFtknfDWD3kYf2edwByCHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB76nlAHdiDSap/mxexCcznsz7EnMgU0qBiHlDGwrB8QhqXOpY
	LTt6OW8vEwLfuHA3bdq3K/hY+wsE3x1hFZf+rCsPTONvFSoJoJmzN/AS
X-Gm-Gg: Acq92OExY3f2g4U6NUERiP5Riqzgyiqmo0TEo0gjHVsciB+d8zteKfqxr6Ec7g1mhlR
	ZkvtsA4Djs0p2kSx2x8OnD/YVbaz5T8ILdxfRMKkB3pfv6sMwmnV/MXxr2rjOhnqtiHnR9UfAQw
	B6+5UN75RCV1x7O9+gr73oUGLgyznfuCicsSvCpm0P/JNGpVSl70ICqxMF5WOJWkBN5/V10v9Fj
	5ilJbrsQk70FRJCv93WHm544DXZdRd1JCLGUhbXcixURzY92JDpbABsxwSDRoe+fnVBt+yzHR2G
	7UR7jeVzyMf0LaZQ82XiewdSurqW9mKd4CPAwc5eN0GbkkggdXRt0jmyqDtqNU9HYWp63MtzvyB
	Z2gFOO5WEJ2HcmEYkCdEJ/2LJxpBMJmfG+coFXgWMFgHJPkB69zOBx2v6MFB6y6tNrAPqMDoSp7
	3u/p+R02zHZwWtKu0LAGvS5I7VId2SGx7v9Gzdvpd+wnGl5QU=
X-Received: by 2002:a17:903:3585:b0:2bf:160f:7038 with SMTP id d9443c01a7336-2bf367c1435mr92914815ad.12.1780238196196;
        Sun, 31 May 2026 07:36:36 -0700 (PDT)
Received: from [10.4.72.5] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b0121fsm77749365ad.49.2026.05.31.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 07:36:35 -0700 (PDT)
Message-ID: <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>
Date: Sun, 31 May 2026 22:36:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
To: Greg KH <gregkh@linuxfoundation.org>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn,
 chenhuacai@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 sashiko-reviews@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, stable@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
 <2026053158-cussed-outweigh-6f0f@gregkh>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <2026053158-cussed-outweigh-6f0f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026/5/31 22:15, Greg KH wrote:
>> -- 
>> 2.20.1
>>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Thanks for pointing out the correct process. I saw
that PPC maintainer added "Cc: stable@vger.kernel.org"
on v1, so I mistakenly thought v2 should cc...

Thanks,
Yanfei

