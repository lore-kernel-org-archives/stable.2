Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686207;
	b=p14wdecQ+58bNFn0HAirZA6A0RRLepKwycR8SgYt/+IMGxqMuObVCJ3AmEpzLB2Mssp+
	 M2eAF9n71bNNtwNZ0ut2TLQMNfRkH0yWgYRRVTM/n+wK4edYwnUnnheTpvffGt3/VY0HE
	 oLY9jx/QwbS7KxUAZN0o9JsfFcbegf0tktL5+4c1SCqLzqbsik/m0oMyV+Pk7qvtfjo6J
	 q8aji9ziWZrWON9M/6DTvSrqwEaWbivKWgEVP17Irxx0j/pwJcaA9cumFi6mPlIIF4mue
	 8RrawmRdZfeQPwAXDAbJKODaft0LzJI0GwHtj+AWlBzDCarZpGeswBfDFetS75lGS2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=p2FvWA6CWZEDhvwtscmjEDIo0Dx+bIAbYiK0/cRgf1A=;
	b=WYj13nXqW82xflWKpH/taXxRlrdWLQ01y2ELhTj1L7NiO3Cnp4Ywfr56/FsOWwfshS7Y
	 G5vrl3wBdn0hDZ5FI+Ea9r9yAddTeE9UjbOGWmRaD9W2Ut0fbLb8wNLu78fBVHVPTKIQX
	 XV5Ald5BLsdofRGSH9zcMPL9E/hPB5+069QNflS6DMh9fyXBo83dAlnzovB/bj+R8LD12
	 DBs4fcnLbgN8cVi7l5GUcM+sc9PSVy6YkrYIIgSPI9+RIfLz3qRivyIdzkVkJuoDZ0cmk
	 ECFKrbXdd1SM4fqAsRi4D2QX0CD4N5N7GY/kt6ecy9WN35JO6jq62ckF2EaAeUonXfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="LDM/h6MO";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023D606A89E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B023D606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=LDM/h6MO
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso2356511a91.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686206; x=1795291006; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2FvWA6CWZEDhvwtscmjEDIo0Dx+bIAbYiK0/cRgf1A=;
        b=LDM/h6MOiHEX7xFKKsejdh1WkOA2YmMpAl3w3H/gpPvZkvUmcKi83r/TD7OH7qRVQx
         t3gQtx4/UqonZxRhdQhnsdqPX0K2Aemih7kxpmpFq4GkeOPU17M2qXE+VkBcrcCYV8fj
         h2A/FJCTmVyu4uzm0xehrNHDwFPjY3taClT3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686206; x=1795291006;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2FvWA6CWZEDhvwtscmjEDIo0Dx+bIAbYiK0/cRgf1A=;
        b=zuTTOw0P8u8g5vfPAGJF+brbMhdq++8oZq3qAkCh9aK0A6WBepbdwkZxsN/UJWC9jm
         40fO3ClWOCBYgYPBNva1+M1I1224BvXy4sR6XA3jDlMhK5f7coZcUAL+bej3nXY27oiz
         QWuykwZBLjBCNjx+2CWysR0AhryKBFPXdjT0aTjTUF23hirt7omkcYXXz+OloT53sohd
         btX3IAXn0vBJLg2V2pph1LCe/oTwvEMlpW9RdLAqcQt1K2PxipvrPz4b3XWqFZzS76AV
         9kyomWyMC2jnxWW2l6HWENHSmtnoaRhKbmMHKo7tB6LTTrcxqyoyXsbOYP7z/dNdHkBx
         QzVA==
X-Forwarded-Encrypted: i=1; AL+hErGNqpofAvJOQe/qvD0yI5VQES6qWloOhGN75cwIaXIToH7JL1Xr5Xlh7lmnaedna9pVtTUVMs8=@vger.kernel.org
X-Gm-Message-State: APuU4Z84FK0XeLHM4ryYcqD4Hs1SjggeyCKaX36zXnA64hOfOgp6zoSn
	jHzYIfrLsrLig58KjzZzQk6btissLx6Ucf/GLmjC6JOJQzxz5nTdECzILhNfn63f+Av7utCbLyA
	Y0aB+VN8=
X-Gm-Gg: AYBFou1svRMy3nb0j2RZCQTMpj32fZHH9/XptQfODjUZc0y93b9EV45rSKGD8UtuWZx
	iQ8LPbbCCZrGVIavkWpFHf+r/4nr30DidFSitze2uBhpbn14vLJauBf+zEq3vqJFlOERmn/j6UF
	KkfuaN9we+G8sp75wPMUVjObgrrnfe3UUCy+TOcQ5jo+LUAPX5eNdOMWjS7F2CnxFYIHPKLELdT
	KceNX/X6mJK8/lUan54NAWPD4j33KYuBk9KNm9h6egsrQ/aNHT0r3T5VNODnVyI7j+7SvZSB45y
	dacZYf4PguhdspTZNPxFt4X0QOwqp4O9MGRdZYLC7HobrJ2UAdEVZuau759i0Eagt383GAgY03f
	AHVT1ASaGJm/VwkFoW+XQlPKg2XLpQpMLs/o0M7QLLOJdQLs6plYW7idlZLsi5/OuYzlzTAI1VN
	Q+63MxFqMkZDTRyRUHrPXEWgVK2+hmU4/Z8EIhinkRBCp+NTQUkCebuf4tmjB7EtrnU5Na0p5VJ
	PLjX5gaSZ/lX5EA17bjpVTJiouKUTlVly0HE8d0gVHZ+c6+JvOYMTWXGCl6RMGe6G2m61xcuwnX
	bvlZsaoMBMimKJKFde/ytQ7+3H5HgBcZscI0aaJ1Lv2UY5noFqId2rAdWfxB21o3EO4kc6nLgIk
	gggSXbpNslsvQ38x2oNcu8s26dkN03H56YwGVMKjoS5RzVyOQ1HLgtIHyOxOHwKc3gATq28H8YI
	5Drxeg5IkNH0KwGrvUe/08ekuFLRr/Dnrc0HAY736+p4Z/gW4hOZMJa53U
X-Received: by 2002:a17:90b:2803:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b1b0ba1693mr6466266a91.28.1794686206120;
        Sat, 14 Nov 2026 11:56:46 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm14613174a91.13.2026.11.14.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:45 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:43 -0800
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
Subject: Re: [PATCH v2 04/13] mm/migrate_device: allocate THP deferred split
	heads
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-4-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-4-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115643.a6727abe20ff6cd1@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this by migrating into an empty PMD in a new memcg,
faulting the THP back and partially unmapping it, and the warning from
lock_list_lru_of_memcg() is gone.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
