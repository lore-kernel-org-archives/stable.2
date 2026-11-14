Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686230;
	b=VmZGFuTWy0VJ2Qx8R4KkoSN3onG7dWiRJ8VR3cAaIAhFyIx+4SgSUqcXWqMJnwOKSSdp
	 Nfj+V+pzGca8I6zOpgwyktsIM7PQx/Q+Yh2TXHYTalBLRSg1Y+vQelHdRuwmAryBTU78e
	 ONI7Y8iiYk/k0Y2aAZVUFHPHAZwkVamKsqunUFSs5eEkKEt4D4ZU8ikUxFmDd+S9ME8uk
	 n0NScAzeHqJsJj/3NYWapVIkeVCBm9MVFoIeXej0oSHAjCZ+hebccWq4h3av3Zje2QVEm
	 qGzu6Ly1nzv/KOJ2LoV3d/nfY8MG7bubx035tlQcrNzLjo2U0SR7piZUL2dCpQGAN4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=ZjCjNVe3xcYFHoP26hhziA2QWpcFTVQZGwosE+j3wBO50WqRg9Wtvzn/D0gf/UGs1VTg
	 +jR8H5ggDB2PrGqAchaVlr4a8lVumUBCSNw4DDQH2fDVXZC7C9KkYjrjyv7XK+YlSgeWc
	 4r68zie4lCUzvqnNcnkFgbJd5VN6sjy/Yyigz5ChmUmh/zLe8zEBEJc8/S3X+PudVgfYA
	 03xV5zqigghTOks2tDDGyS/syfGKL3UtijG8Ka++9ljhCKlRHaQb7iBYGkOxh0ERGXhmA
	 nEwFzwWRw4MgvZpxMKNd0PFPw62iQw9d2boMG+9Ai03igtm1SZegLozHXe1YmwmayCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DBzXyPrK;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031160A383F
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8031160A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DBzXyPrK
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed408b0d9dso8347685ad.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686229; x=1795291029; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=DBzXyPrKsDRPTbSaxgSes1jjg4+nqKN96POlblWZ7GlEA4M9Ge4VvxQutRKppkXm9/
         JtjE1SinjwOrcnYUgCDHg4MIs2Z60pDVRm/qt1jTjYTqlliRteCUH0E0AQOuFS9NjmNI
         8UIHSjTNwfrHv19avkLNL5JWrSHqkU2o/qOhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686229; x=1795291029;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=s8jEmNHAZzffwuGJ8E3iWoMsVHCTm0Sli4CvzqdlziMrGPzetA4FcdWkI+1mepFprK
         MCjcpocuEcLPa/UEe7+EVY9X9hbjq/uHZO2NewNNNjRg78r6SMb5OjOSw5/mHh2JfG0J
         WH1SQjD6ehx/rVuYY7HJVTYy5osEf0mFUrcijB9Y/s63/R+pGnfW4MTth9m75w+aFLcC
         LEPbWu8ma7zOdjXc2aYQB3rHuPrnd5tZHXPRF5R/PrQbs1gblKAXlGvHR7IZ7KtrHXVp
         BpE9z4DqOQzalHmvf8VsHwWzBBaMhdZvf/WzkXfaJ4RK7Trc/LWcUpCc2J5N3OyVXXyV
         +7Iw==
X-Forwarded-Encrypted: i=1; AL+hErFq7hK+nkxfEHCg0cZCtOdJmDGf6PHW4sXNkxbLnFYUBphJs+Eh85LD9zLcqVXf3Eh/a77UQpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p7bK98Pllq1c+HuRrDjFv4eMVFZfhE/b9HEmKlFuK9u/EAUDi
	vf8ErYEHMDr3THQqjg1Gmn4wVaYQVwOeVuvNvdqeoYoDE4y3ALTYmgwbs20Yi48N62w=
X-Gm-Gg: AYBFou1XXVBLGwM9mfarwVXgoC4cMQHNqKVDT0P6Nnt6PE+bc90396VsoA9nMu0CwOL
	ShbG3HYN4vG3Pq6eqO7QogVeHTJXvY6Od7Nh4tPUiyBx5Y911d3It2+TfJc3TteUzHKayBDzduC
	jToZ+0f5vVyp8DPQuVa1awccj/Ubcy/SyX/GJXqQBpRz55MS/MxUOEmKW0YxhwZXIwj93pJF4rm
	Q2RqPchnvtaZ0qtWi6RKZJglQguZlmjgh4Fpf1y5Y7PdASmIsSu0FumRf5PO9c8gU0ehLIdGGcx
	rwhz3FuRY7c4eImBr2+ndfz74ERXsZH/l+MvlgEK3CkOysgJ8yntQK7CnuGTHQni3Lbc30YpNJF
	SrqE24MWstIruNb2/df4EXTvDTG1DItNn0iLzYP3nOTG4uHmRayIgfr8oPfouHBEbE63YcuXYcE
	acLtI2/WnmmNhZ1K+pMAR1ME/B8FL73OM+ptuKvio+93MKPauPqR6aCo0WNep2+AM64uubIJkKC
	YW+qoMqnvo5qj99wuQQZvqifhkhE54VMHjvDhjErqQqNxn8kxST4zZvr/GeC1aAFreoeIAUDft5
	0lOLD29cDOJGorRncQB1+/8thxiP4BLO9IsTZTi/vzUSGILImltdTqW/9xIa67Lsqf85SEhoLie
	tiMlH0zwbkPbCww9J0vpiBHaVm4clnn2+bwgXiE46AH/GeGi3YzHmPjfUIJmAYRikLEP4FhUT1M
	tbvd4MQbbeWVDInGpWAq0WWOAjAEfCrLckb1ltqganPLk1By1BrmHFDw==
X-Received: by 2002:a17:902:db04:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2ee0d9eb41fmr60393715ad.5.1794686228885;
        Sat, 14 Nov 2026 11:57:08 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf33asm22947505ad.27.2026.11.14.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:07 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:04 -0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>,
	=?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 10/13] mm/migrate_device: refuse to migrate shadow
	stacks
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-10-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-10-50a2ed382b61@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114115704.9bc8ba24d73b8bce@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
