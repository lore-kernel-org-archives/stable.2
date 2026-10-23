Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786947;
	b=ATTISabQySKKnYWLL/CoEzKdisenGpv51GmiYCDDJofzDt6bV3EnQuxdJbY+MxWFM2YK
	 /JyuW6GTdsWMbgwCx5FiBrR33FVcOMm4OtZ7IRAUrxh44lFSzNbq7WVzglCQ4/mlxhuXx
	 oqTVmAlW/IwbIyuoJbMVhyX8qbkb7n1RWbZYY72G4LG0JUjXrDo9Q8SYd3r1vU3tK7PCS
	 fd6loPFdWgBYMhGJbd8FgD73CtyKDbNC+o0jZxLFtRFNlmF9tfziT8AsalhmoThapOyNL
	 dBmCchhU+Vp8RyGdbpPHCyQQ0sbDAPNYrlcQHXd4ybECqykYqUFqF/orKshd2nPKupw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hRTDN8ZAsYemcjS/tFt9qz2BoHVnCBymeZ7iDpjSWck=;
	b=pqP8YvQ7+RpHgHotn97iUHOt9ilZm1oy086fL4CxEa2WePhhdIp3mu80YYNlGuOw2OUn
	 KpDP3QdAmzXtqodViDFSHGvPC3X+253BFtFj7VBb+VjR6Oq2podybdy7tIjtFnjyWSDmW
	 SH8kBuEveVWxoPkUDLITM5uJP7GOvdjd2Yv0SmRpD3p2FLrY0+jmW9zYclcXhrI/MVO8e
	 prhPNHQpg96XQyRyGq3uoGhzlZkb4SdncA0iRlpBsdmp6W19WjCWQPbn60ShtfcQ6pMS3
	 rM5iDfHG1FRl85n+j4Dlw2rYtnJO3wIfGYF3xqGq8fpR2d4cfEk+cmWdFcnrrZ9MyRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=box3Q8r7;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E2606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C2E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=box3Q8r7
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso6393405ad.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792786946; x=1793391746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRTDN8ZAsYemcjS/tFt9qz2BoHVnCBymeZ7iDpjSWck=;
        b=box3Q8r7L7dQul91gH6PpdTfj/Mz0dMEF8lnHN9AlPnA8b3tvX48tDfeb6j5EiRjKU
         YpZfrrunfuJkgsF67Z34MXEAqFB+dsi0NBjOY37w0+GfQ7UWb7QMAEoIZ64BUxaX57Ny
         OfbmkRJPu7kKrQF2avdp8El+WczJvGDJAWs+FBuuwFVLGRGP9ZKIQCv4BkJfMNqY8pFl
         GOMd1RZz+aY/S/DbF5axndQIPr2m0XcQuWTtTfuvoAgVBxncdZBREJdMgtEHSZlhbjQa
         MGZ177dVj+RM3xIrdAwaKq/fdIfyvEm7omk2CfCtscW0GHbsOscYdFYJcebcUeNQtArt
         zDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792786946; x=1793391746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRTDN8ZAsYemcjS/tFt9qz2BoHVnCBymeZ7iDpjSWck=;
        b=t1WaSLtQrbT/oc+NR6hxwuRY/71IswMR5LS00LfvEoiVx9hlNEDX9ePBcJLrMFgXzd
         SiE2RuMzYjz20ABkksLIOhd7zwqxuCq/Rc0Z0RDZIlOkugQww6BuXiRjC+q5kAZUrz8/
         jlU18x2f3OQkTQ3eblzkpQNSIOoFkygpntp8EX8X6+D6Uok1/Iz5zoWOj9NAiHB0SPXE
         oxOT/K+NuyoOM9f8uWx5eqZorRvX1boNoo4AtRLYceUvusQU47z9MpPYSzM5m9VcOLrK
         i1AFPkvRvow07MDS7rNyUbZ0DBlnNhqQoqODDcWdCqrbEtKjMIJ5f5AEzXckBNu5W5Mh
         2ajQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5GXh3cn+nLaP4C4guedkZT8PkMrT/RLMWdUtv7U7jDDYB6ts6DvG+paG+I6GlmSNYt9kzdjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDAk1iNQI3TyOHjAnpbUjJSm8hAaA/LkJc88+t1x+JUwtlLXuN
	vvEqZSJmL0vby9nCcd/KifbzPVeNA6XNjK43fZoqj+x5jYTjRJQZXeXW
X-Gm-Gg: AYBFou1AWTpyB79EJTNXH41soSTE8MkNZ4pEPj7BJtjdLkNAabhScCWjuurQJ5+mTLd
	nhiweYNSWHHIcdbLmvIyN7al/AFIhkUVBLlQ5uotAGnBr3F2aBdvB8akWTVEI87x+dKKGpPK0nN
	Kimvfa+a1qHxGMd35qGVsBepdD0wDXOMyJvDzp0qF+AgoNEizFqBip7FH1NSiNwsU43+BKecd14
	BIO1eL5Ft5yDD3uE8fCGjcWvdz80uny/AfDoykv2VUK11bH+Jdiv20korEouVsZLZTAioz4ypQg
	9c60i1ieNZFI6udYrw+tNv/QY+3NQOLve6oy98gUNKXR5dI3ufHcmhXnWO+L7nXDl/lNm+/XHsc
	MbtbV+aKOmxMUC28BWk9Jc8LfQWZEuQ2KwXk6IgMYeMMZz24uMe/vfJEtaAGCmLSSidIi/BTWBW
	ZLcrOXPKSYO6WA1UbID44GzW96Q+ZxoJkz1LSWoJdPlTbDBZOJrsgslGYp3BQ3Uu+BTCRfpRlGP
	kzfvnjk7VlYaLBAcVPQ2ifuXgacLqim+RXU++oYuRbz4WFjE/sYqT3GBIeRAJzGpSsUkMwxj9qL
	RHCzcODXH3jufODMuRNL+muPfjSynSwgI1wH9Vb1yBIBy15VMwny4+BKSRFOme3myLzA2ueMYjw
	8d+2HhOS8Cq1B0Gds0XHBbbJPtZbf28ogDOVtRjwptMamYv+qzgHZ3Jj6fLaOvgKJbbAW
X-Received: by 2002:a17:903:144f:b0:2dd:ad74:ac2e with SMTP id d9443c01a7336-2ea9c69717bmr902045ad.23.1792786945303;
        Fri, 23 Oct 2026 13:22:25 -0700 (PDT)
Received: from ?IPV6:240e:b8f:9094:9600:cd72:3ed3:a066:44ce? ([240e:b8f:9094:9600:cd72:3ed3:a066:44ce])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6af0dsm270798a91.5.2026.10.23.13.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 13:22:24 -0700 (PDT)
Message-ID: <27353e19-7cce-4fae-9655-9928e0641593@gmail.com>
Date: Sat, 24 Oct 2026 04:22:17 +0800
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
Subject: Re: [6.1.y PATCH 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
 Steven Barrett <steven@liquorix.net>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Suleiman Souhlal <suleiman@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Wei Xu <weixugc@google.com>,
 Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>,
 Chris Li <chrisl@kernel.org>, "T.J. Mercier" <tjmercier@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>,
 David Hildenbrand <david@kernel.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Michal Hocko
 <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Yuanchu Xie <yuanchu@google.com>
References: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
 <2026-09-20-daily-reply-0009-re-mglru-dirty-throttling-6-1@kernel.org>
Content-Language: en-US
From: Leno Hou <lenohou@gmail.com>
In-Reply-To: <2026-09-20-daily-reply-0009-re-mglru-dirty-throttling-6-1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 1:50 AM, Sasha Levin wrote:
>> Patch 1 wakes up flushers conditionally when a memcg is about to OOM due
>> to dirty caches.  It restores the flusher wakeup that was removed by
>> 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle").
> 
> The wakeup ends up before the "done:" label in lru_gen_shrink_lruvec().
> 6.1 has two "goto done" exits, including the !delta case this is meant
> to cover, and both jump past it, so the flusher never gets woken on the
> path that matters.
> 
> Tree coverage is the other problem: 13b6b6209104 ("mm: vmscan: fix dirty
> folios throttling on cgroup v1 for MGLRU") is absent from 6.6, 6.12 and
> 6.18, and 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to
> avoid cgroup OOM") is absent from 6.6, so 6.1 alone would make an
> upgrade a regression.
> 
> Could you respin covering 6.18, 6.12, 6.6 and 6.1? 5.15 and older have
> no MGLRU.
> 

OK～～ I'll cover this.
