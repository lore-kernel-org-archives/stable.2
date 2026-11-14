Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686227;
	b=xZRkJzt8cUNx/bIU59ujGMAO4yCSDkApwAKA/D7WijR+o8+95FyaXbyL10JxKfm6ekNX
	 OYJHGxUpfpcI0/RPUxW4FgYastVEU5fgYOoIBYFjEJoYwIxkIY3QIxW94fEkx3oJKea+9
	 fIj+k3mSJKvmcgSK6F2SLl4Sz/RrdINdMfjduWIzP1kYw0J8wGKaLxEpMMfaPQrQ4THfj
	 490y6YTVLgTP8YuoJst8BeS5Zl8dv0WWjXBnUR0hWGPg5OH+S4Zo/I9wYlr1HYc/bK81k
	 3wuEfCHF0YNFTfgkQiOqxwAi6O67JU+eaUHwjKhhF+ohXP5GwuXlQ7j4d92Jnm502tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=OCVS5zlhrjN9ps/q5PiJQ1tTNBzYlAwbpXMt2B00TDw=;
	b=F3SqaZz01HJm5wixtJydQSm0aN/Q6xZEJIZQegGamAcM7ZOOSOn/JgK8yA7VMst8qk/+
	 jmhp6nsyHuHrCDk12s64zCQgQC5gjil4RLPmZFxIpWctvqY6WbdX7Ip4ndKHFY0p6O4mp
	 OMpNqrBpgOH/BPqUJKmntgQpfP/0pQLAFGI5gP8MaHKIOeWS22TVLnC0Rp79sIdHGac9l
	 w+wAuKCDN6oQOY1qBTGG0HaLIsMH0Y1vbA1ngaHOS/qmLxHaT7jy2nZC8s91RaF0CW3Ni
	 LjfMucSNtRy84CCZg2YMksVPmLsDxEigPJ5DLaCnjvdYm//jazV2U5AIliNcKJMzRmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tKE5crcb;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547960A3834
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2547960A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tKE5crcb
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1084915a91.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686225; x=1795291025; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCVS5zlhrjN9ps/q5PiJQ1tTNBzYlAwbpXMt2B00TDw=;
        b=tKE5crcbDd+Y66qKVu1Vo3c+QvvnO/kxPzwoZf5v4mpLE2ZSeWaCIBA8P4Ywjwk8LE
         6eAKD0Ql/Z8wrCqplLWn+PPZALQxAhRRDPVpspMArDyx0yyERP6CerQs47nTp/4HbwZT
         CPItrLkJkt1N114ET2W8m0L40PB9j/iiLow4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686225; x=1795291025;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCVS5zlhrjN9ps/q5PiJQ1tTNBzYlAwbpXMt2B00TDw=;
        b=UIMDxVUKMldCMLYNPOC/5M6y7CcYQFi0XEg/ewPqPfYFwgP32huzBbISFjqr+mh92r
         FbhQVlL0rdecSPjKYgvWgd0mBDBcnRYS0WVITOTEf0FpfijSfO9zmAVS2v1i4Es9FVBE
         dBDvN2F8dGnCvEpueD/5VgbwmbS4Pig6fWXHLGaELz4s8cCwEFV77ljt6A0t2PW6boze
         X1aJ3HOZ+PwF5b8K0k/MuZt9qijWyAWr2uAWwnyIuMFsbWWm1cxGYRp3oppecsF3s+DY
         Jt2IIIcmNnWWnRIFZ7wMDTs20p6rfhFEOv8UKOJB9LPfRpoxL7tsaNLwxaKFPeEW37Id
         MEHQ==
X-Forwarded-Encrypted: i=1; AL+hErE4bPZDfcpZJGVdsA+AGTE9SubE8pRi3IVpOnsMQsK4CromT2UQLna09vymq9sJHHPBmobDxvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CBMs4tUh/sEkMdsXAlVVF07LcbQCztmPxoKc4NRy1l5ZpLoZL
	pRO58PvimL/7p9xv72rR/1fjDkq5bos/cL4pN5/uI24LosxJ5sGlmRlEMRN0WK6TL58=
X-Gm-Gg: AYBFou3stZ8cn05NP6bCzyru86qdDpBuE+PsHZw9ooGPZNiCuNiJXAsJ2pD63YDlUd5
	uJdd7r05tKEAnFCSClG1a4rv4lhW+Qs5Iulr/b472Ni+VlAeHH6I7DW8joPM1GStswZ5KNX/v9A
	0hDtR7evUD2vlUn9GfHitlCgjx5fTYdlulZcfB8sNG8wHhjPeNf3+xgIx7udq7htl8g9EqL96BE
	tfnM7/Hm43+HSEAKuL8NxkwxynMymQTKoa1hRNnRm0TwP8gi0raMGamgBsTeXYXLDgmtyGcPjeN
	4SbgCTJrHK/rjs/qDUcgOy/LZSJBzIK1Fr/rL21PtrCCQxIaU8uvQVx+dWh0tQgeqd7KfpuYoXm
	DvlTg2Dvb1Tm9syb/CnNVHiNzn9bbjCQ8Ry9Ak7JK9me+4Z4uy3asAT8tmLfHKNNKSspntf7rvI
	W8CUm09n43ZuDCWpUu6cFqZyMIUncFAuFuILpg97Ms7OJYQXp1hzb41nnGYPy8AJ8kTl7K0B+P1
	aNKs8DePW+5fsGJSmeGwYjH1f7H+Zk+8kVoXGSmbDRip3SqXKA7nJ4+khOurHG9tiNUnS0/iiM9
	oQpB83fI4kiJgzSk8o7pWYyymeEfsnpKdzMGYiruvKF5Osav7Rs71fjB93yiewEe4Fm9GfUKpgN
	8wSkS/4iDfjJ7efXNTZVIP/JWuHHx6LXGnkIoNT3nCbmUqeILbGFm9EFxyL2zEkgPLUPXR1w/TM
	XxkD61dW4vI0PGGeMThNwoWGUq1Ui9y5t0o/eUYNsPo9FUv9KYJS0bjAY=
X-Received: by 2002:a17:90b:4c8f:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3b1b0b983efmr6301490a91.46.1794686225426;
        Sat, 14 Nov 2026 11:57:05 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm9589262a91.10.2026.11.14.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:03 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:01 -0800
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
Subject: Re: [PATCH v2 09/13] mm/migrate_device: fix use-after-free of the
	anon rmap
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-9-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-9-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115701.3a5f64e24081d09f@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with test_hmm evicting its device memory while
the pages are being unmapped, and with this applied KASAN is quiet
again.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
