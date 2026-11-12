Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496865;
	b=T21lBwo3wl8EIXiz20PSk249fpOHYnOjbUZFNvc90BtQ5dOjNJO1jaLdqHGek1w7dbOo
	 bGYB8JuIVagHenGrwCN9r/w4G9TuLcLKQs4kuiYSkUTzeM93Cfqru2BddcLIPIvRicJSQ
	 9p3q6g49tFxNZA/4GpoXOcRA1eDoaq/kLnQjdVYqoAuUocCwig6Hs6jUkGPJ43OFhGyK6
	 5guanJb8GHhfkMfBGzXRR/IZ4vKrL0Eh84kar2NYiWP342iPbnvUbOnkdMfEHFMrgjC/L
	 KJrF1faMpozH/GBgaqhIRCNDYaB1zuPEJPmN/ciodPSs5m+w8g9UQ8CDNm8prXlP3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GrQWj8i0KMpWLvGJmSZCRH/S1lTxVViz3a0mVq2HUbU=;
	b=CJHtFeCwV9sJh9cc7ChKs4Oy7wTc4gfAf+7sztf5A/gDui2uj/aCmUa6Sjb+rBdw4rTx
	 h/0+r9BTREiPlMz7JZWt3qJGKmVD1qIC/1rbBB9BOTs6ljuhyvhWUYLEaXYoia6A4V49w
	 j/BKqJZqyWEnD7ktPcRUtDj1vYwCoh6du0aQtgHcUAxSyEKZfJx/hrpdFOo/WlsfVyri3
	 uxz+QinT1or2IIRYyx6qZTIGsl3r6kYL5jHBb/ckJwJ0RPXOkh8vJT3X5HXCDnutBgs0G
	 IE2VIq2BUcUCHGLjA/THsW24J0lXM4Ee7VsqsUtbVSo9MB4v30c9/PUPL2pf/G+hk+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=ggQnnAzW;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3D60A382B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA3D60A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=ggQnnAzW
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67be7b9abc8so3947055d50.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1794496864; x=1795101664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GrQWj8i0KMpWLvGJmSZCRH/S1lTxVViz3a0mVq2HUbU=;
        b=ggQnnAzW2tUrxbYZukvFoa7FkGVSd83TsnR33Ct8XFJkRpgtyATThxwMCXzgWaKWZS
         HmRCgD8kzAtgX1W6cJMMs8MR90/vUe65QcJtX+qH/LH76cLleMocQfmYch+ouc7RR3Ir
         dVbMMW03JOMSXfjL4VmbLNN7t6+fKrpaoTnxJwND0GtPqGvj7KU5xWgUyeRH4pP5+1Yu
         X+uGZEeUfEnqHOGeJEro3ajanho9vv3hMijzffpOEMrnkr9ECw7DAlsDKrPSy2y4yg1/
         vWPwjJ8wID0yWPJIclgjKldW8bd/XmmAbnoOoYIFfX3/YWW5dyB2POUQZvs9Zl1zgKBM
         DgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496864; x=1795101664;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrQWj8i0KMpWLvGJmSZCRH/S1lTxVViz3a0mVq2HUbU=;
        b=AbAiIYo+5LVnmI4cTTOY82/G5QjJkRkPKIPGRG1dbJEE3JNcrbbfKYXHMDQGF9rIOC
         IP9vq4yY9MRF7I3zG/GBMMbCMsYTct8MOxXoR31BjSyQe5UikWZfz8+4I+l+f/ab7ScK
         U2+XfqYiefFZHI5TTrFioZGT24J0g/zaOcNRx/A8vwlxnIWVwsCCFZBv/C0pIkiaAb4m
         nbHfeCy1ZOuT9DULSyFtNpOMas8i/o2viyJlorS0kxmujSeYTz68kdloEo4UkRzULjm7
         Oh+ksQklp7noo9g0GU9/OeRIb0OgsMk5nbrru7Q7zQgx6zTpEWUhO5ETyMQfdRPIyz+A
         4FUw==
X-Forwarded-Encrypted: i=1; AL+hErH0u0EoknexiPJO7mUMXIw+1FUxmCUEfcjIOVK8CMX7eiLR5rpDNMuZTSwjyYBEO+puTJDBLh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nHklsZNk9Yxh6xKKIS6yQtDa82F0uosjTkkPG+HREd5eInS1/
	AkuaW68R48A/6ar75+Zvtxqan566cGnB2h0CxtovtM0CSdZ4Wd1mJYuBXeK9g3pFVlo=
X-Gm-Gg: AYBFou3HwzHPBq1/9sQfGTLgGuaw+6JNoDqr4LAae1d6ZcmwGErt+g/bpUWg1CRgsB7
	0FS12ZX03i76SqRzF7ruE55Sa4xiAhsaOUBsPVsISHW8RQwW2PcE2HYznLGAZflAERPbRf8/WnB
	XI4RQLA+2mYv4yTbHrhfClbKf8WvIORZeRH4IM11bZXAkZD8Y/d7nzAUC4cAGWIsL23up6plKGI
	D2svs38J3kJjksm2ewZWHasiui1ZqntRMQI9+za+viyFj4J8UPZgsHYiLwXCK/RX0iQx3vDXFjo
	47FCjo6w7d8Ic8aMSVyJFD2tOo8rucu63/zb91c0bbYIjp8RusFvBFO3/cptGT+39veChFcpI6i
	MF8lz6IMuwDM70f5pMtxRiSDaXaQaPtqMPuD4hrXwc0Do5AjaQSEHK608mJYDJrhr5PEqe5uX6T
	loTO9hypJpKjmiBb+0Lieerg7IhsIQPQxGPAw1oh0QDMDVBooHS/wz+1Mt1lTtVvxrW8rf7Yyuh
	SM9JW4QldDvZH1X1An10oxhQG1zargZdBornv3eq1UK1h4+wLi+3dnzJ1GLxWKls8icmCpwID8b
	uw4wU7W4MKiUU4xsmul6d8ceNiEo
X-Received: by 2002:a05:690e:1519:b0:67c:23f2:41e4 with SMTP id 956f58d0204a3-67c67ee5aecmr3870192d50.27.1794496862680;
        Thu, 12 Nov 2026 07:21:02 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58a0f312sm7504466d50.19.2026.11.12.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:21:00 -0800 (PST)
Date: Thu, 12 Nov 2026 10:21:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: flush nr_charged_bytes when the obj stock trylock
 fails
Message-ID: <avXZXMp_r5VVXS-W@cmpxchg.org>
References: <20261112013220.4064478-1-shakeel.butt@linux.dev>
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
In-Reply-To: <20261112013220.4064478-1-shakeel.butt@linux.dev>

On Wed, Nov 11, 2026 at 05:32:20PM -0800, Shakeel Butt wrote:
> When interrupt code, such as an RCU callback in softirq, runs on top of
> a task that holds the obj stock lock, its trylock fails and the bytes go
> to objcg->nr_charged_bytes. Nothing empties that counter while every CPU
> using the objcg keeps it in its stock, so it can grow without limit.
> 
> Users see memory.current and the "kernel" field of memory.stat keep
> growing while the cgroup's real usage does not. With memory.high or
> memory.max set, the cgroup is reclaimed, throttled or even OOM-killed
> for memory it does not use. The counter is 32-bit, so after 4 GiB it
> wraps, and those 4 GiB stay charged to the cgroup and its ancestors
> until reboot, even after the cgroup is removed.
> 
> Fix it by uncharging the whole pages in nr_charged_bytes whenever the
> trylock fails.
> 
> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: stable@vger.kernel.org

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
