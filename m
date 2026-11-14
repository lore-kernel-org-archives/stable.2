Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686213;
	b=KXyynhZHT+JzaPquFqxCm9f8HmHYhrLRpmRrs2okVHUD0LTobNMxier/C3lJEU1pHTJ0
	 wOfvbG8z4bBAdICJhy1fT098lNV0I6Wp3jNw43V/S6cSeVulX4krEhtoWf+X+FOtwYS0A
	 +vkLBkTi+W7ih7EmtCI4YsSVoIIrkyg/Sk3AQuCPzkvEdYwS5I2spDcY4eE8YRuTJTnUL
	 nvL0Mi2k7kQCED5f+kWLS6XTR4Yez9DxBEXmReaLb+d3B9xYpl87y4feoOKkzDFMUF74G
	 XumPyvic8LST99gG4Y5wtCB4fraP1ty0IJRF91uOWLYrPzlvkzTl4Dsy/HqyTm/Lf4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=jUPvgjj1PBRfdwLGObCdW0ZVMBq40+Tj39RcKsF/1KM=;
	b=27mDWVHPhE66xEtJdy+EliSS7NXmV8tFh++VT0XjawkgnjxNoohQ7R0C+pHqz9Ic/GW5
	 LfPYEsnazgyZv1JslUQjHwG7jAjSshStN6QS7o3GhOAHwJ74RbjtKOjC0AtD/Sm/XCsy+
	 5iu5/ReY4z8sJMoEvlk8nTQfh1Msm/Z3c0ZjyAjKduOKN28iTJdl7lXHyjgoumRveiIAP
	 KyLlNCI/O2WZknx0cv5OjKdv5DlIerc145pXYY2tcKplblJ4l1lWIB9ipJ6RIOgHj1Kzw
	 EbuJDF6WImxtIeia9F+HqUpg8GfopD4WmJvmppPftrcxQvOOmk2+kJWC9FzjxAWi2dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pRiTwZzn;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7A60A2614
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0C7A60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pRiTwZzn
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd69954c755so2190182a12.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686212; x=1795291012; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUPvgjj1PBRfdwLGObCdW0ZVMBq40+Tj39RcKsF/1KM=;
        b=pRiTwZznyJjRXEwfZ2Yj6bQhTMfhAND8SF1yLLCDprlMuuVUEfuXxcMAeIcXT4oMCb
         h2mWAMZ9RLugktvlsTqKXyz8lJjoTbqH9YlZA7iLPtiOJs07kKmXDovd5gz/xA3lrkUk
         pSf1nT3EqnybmBBib+Jjaw2cWu4Mh32UD5SfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686212; x=1795291012;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUPvgjj1PBRfdwLGObCdW0ZVMBq40+Tj39RcKsF/1KM=;
        b=tDK5Yn6pkMWd93wcaTaIYwZTVm7vfjtgi/b05WPT15dI461T07TZ1EtWD5ZhTai3cp
         NixuEENnf637PCsmVrYNkcgYA01/NxXmjnCoon1r2QHziINr9PChXc/83qcKZ933AfCg
         is0rp1gRv0cHZ9E6L3A9+xz0670xmWa7QpJahzqZugAgWBvBw6Y9FHt2ALMty4nGkR1M
         uyiLxWhI8k28qmUGEF4uCXv/8XI9ND2wEbNCfMIz9Gzm67b+8yjXL4H4JdFSuE4d3Ep9
         YB+lqwA1XiiwyLq3u9tGFUHtoXjOxa4UOBC8GjfBqz/LV14gHB6NJcyns9UrMOHU74pK
         jY9A==
X-Forwarded-Encrypted: i=1; AL+hErE7aLIW6VnQXJhatUSF3YnFzO7VutfKkNSKrmqNLBqZErRdioX1lzB1PU6dxvvY5iA9Fag4wpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z//v7hUQuKcRGiLqtydDEZ+CMz0YVgpa+a88XHDBX0bnG/F9unc
	UQak4s0HhfPaTkSBd5tUOFF2QVFMZO3N95Tl7sDE25S7AfKTd/M99bOCo4w9tDi2BYY=
X-Gm-Gg: AYBFou1bvbQn/2mxzHWtB0/NeikagC3COLc8mUTaUR8VBVvFKsTk9ilkhY8fr3okQzQ
	AroePkgHQI2Km8NwYrEzBUmQ5iYSoED4wiHOCwYoxsdOnDiC87X30OnmL8Fw1Y2NzGPaCjV3Xp7
	CKZe0/KVHpvclnmKtiPAqKeL6eEWg9v6gWW9MSkuH5l28kIryHQWGS7WrG4zBZBlnbDwDIlYvLz
	JOt0m9sbHzAx7yUAPkpuvTZm7g4YYcyK/Zv1rP3tt5bKbv/cUfI9agA8JQqy3WhhwjnM5NOGfXf
	7JO6ni48sdKYf3tz8i2UG5PHPCGDgjFWxKoS8fosokfWhMh7/U9M8v+Rcn9hGH8jHlP2fpBJnDR
	4CgKTlnrs6oLbI6yF6nHNVFU8CSKC6cxJOxwMDVIa3irmDhuKKR29B8NV6C4UPtmVrEsdrluSdx
	KtAxOdz69JSzTvWNMikGhZ2q84p73Mvl7u4ufxiCkM0zpTBp/ULQ+EKmWXfaTxl5j06EGIjj3UA
	OnpM4UkUBt9IOs1yGL8PHgcDMMpZjDL9hEOJt9UpBOgHwdHabHwujaSOT6yLJ5AAKJMbOGPi/J3
	j5DhQbnYP096E5Abmja0UyBuPEVZDo/ohNzF55cNQjH9+BuNpEAsSHDpGspB5EW5xChxQCO7hlE
	rJZRFOnW/w30X918RLgMt3WK/F9W6peHNRjaV3dKMfNMUrQAHGOzDU7rfOJMl00ye7jQFa5BoYB
	7+ENRk8fNDXDqfRjSV+Qy33B+8fNPpGKnzRfB8UhoFvLim6BQmvWxDWT4T
X-Received: by 2002:a17:90b:3551:b0:3b3:8194:9e4c with SMTP id 98e67ed59e1d1-3b381949f14mr141149a91.34.1794686212209;
        Sat, 14 Nov 2026 11:56:52 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm10009272a91.12.2026.11.14.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:51 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:49 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 06/13] mm/migrate_device: don't let go of the fault
	page
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-6-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-6-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115649.cafa06b8b8401e8a@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with the HMM selftests that split the fault
folio, and it works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
