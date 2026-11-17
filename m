Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794952431;
	b=3dyYTzgviz9jZkeeRDAzJpaH9espviFtojRbpSMpfGKwRsacmeA6igXwKhLaWSTBmtIp
	 4qTkwUEQKo78+Ubl0NTtMhlig9LvYdzfkloSmil8LrFSlewmr7qGRvvsJcSD5wDL9gfDi
	 X3BSvU0MqGyh0zr2hf16IvtEmWlxdIlLDseNDv5P8d5cxoH+niGBj/fAculBPYkDQjswq
	 L5tIDJ8uxY1rBYtePYI4mSMCFFP/KDiTvCeJWf7yf6kHuT2WSVA+Xe6Ty2TZWEETvBgEY
	 90HjdMRqwsdYwAs0MP6cmYG2xLm0Oa2iym6NBUOQbDohFpQtdOortda7A0avctEi8aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KA67CSPKfAaW50KrAR7ZlRBvAWHajM3WvHASRWCft94=;
	b=LRxh6RZ1CfUnSGOKJiqQoddIKTTadFhMevn4JjRJVBEbeOQlg0DGNNbEFGs3YqrUiyYd
	 iQzbV7iJHAKUDogeCFXRytW+BHU7lyn8JTXbY1a2zKEu5Bc3Z3N6HyuBMdKKmfFfdiQJX
	 8KmS43z+z0Z/HbYA3kG1TSYlA3r2mHz4YuC3JdVwLM0B7hJTnmxTzmcziTe3ctAEObUCd
	 m6a7bA1T7vFJs4lfI50BVPbSnekxZ0iTPhH5EQA1xoJZOchefXmgzwBnsjvjV4fdA2ecN
	 1Ef1FJ0S16l3AcXCkjtxf/7Zf8/M/k1jQIj6kHs+KL6d9Z91e4biXtV3b1dxn8xYeCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oASUNEw5;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAB606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 21:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98DAB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oASUNEw5
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so3018185e9.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794952429; x=1795557229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KA67CSPKfAaW50KrAR7ZlRBvAWHajM3WvHASRWCft94=;
        b=oASUNEw5KdMbMH8EFpX9G0hPIJ6d2qhKd8wNcKaGE/1JKxHVYAAADbGpUKJFnT9gTF
         /S1a8Ebrkr6WgqySoDT9YHGqfotJwZkX5zaVyd25bDZD1jJqRlGGR9pD9995NoplNbAX
         cfPUijm9FSUw6J5zRg5kEzL/nI9DTQZx05cVveDWYU+BoehD0UodQmPdkbFG5SVtAJod
         1fieqRXUd5h2dX14f5CB9yT2UQvk/u311LNoED/vkkYjNzs4S0Fa4aS81YOvBy9NH0p1
         4JuW4uqAaiRWD5WyDfHdKwDyh1UNY7moGaB9MdDUMHrbYMyweb+xKCyAP5nKU35ef3QI
         ej8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952429; x=1795557229;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KA67CSPKfAaW50KrAR7ZlRBvAWHajM3WvHASRWCft94=;
        b=OUMBkGMQ6KHie8N3Bwj8Y9menVWqtGPKGyoZ6B5GLSKdB48h9zPCNDbNWIgSaorJSN
         05pscgIXvMf8uz8nj9rcrQ4RLWnoLHXDdaWfFzAwTDhMFQtHfweb88Ox2xlaYQ8yghL8
         60gdGnCFT1OuCViEr2mgSwrMxqnW3T3GMdf0KSs3Q+UFmc1fcKlGkkLRAJbSiYQndQV1
         WgrYtNOocUceU2NCo9CmT9TpqXvlcFRxwMs7f+5z4ipk12yEr6MGA4S98DkRXt4Vg9UA
         Ns0LjU9h+bZTERAiWD6hRtknbl+YoawZ6cizwrSj2YEH2ApEwxp7kVoasmH70s1z3gqE
         NZXA==
X-Forwarded-Encrypted: i=1; AL+hErHeRUbvK6eX5PiTCLHZy79j2deB3JnllvMgOdf6CfH3fIoBa7Ny9kWA5Zn53sXZaI2AQbz2tDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+42CJe2R2ot0YUK3lcgWnsEjS+uMLyCKkMU7/XwGUSOti3v7YD
	xq9NU7IhcpEZNNrxTZBZaXxXZqfyma49c92xEzReGFwjDIMhkHWL9Cxk
X-Gm-Gg: AYBFou1T6Co0wpNlkyuj3kL9Di4uiHihwzHDOKPYKra3bmiZIQd6ez8hFsgyaqlTa1v
	pN4egfN0/CM9JryKxKi1LCe8icDVuErqEN4CqqTe5qh9A/8yh1gyMx09BJ1VZh5yNZ4UhDlYfcO
	YPYNjVRAs5oSyvuHpctdmDL1hBHTIDm7amD7PTicYvNJ72soBT5KT8lUi0ZJLPNaTirRiF6872q
	ig/GIWi5yjt2JJ5eJDf49fSyGDWGNwaIQTgcXHAjcrIkRBsUFtmV4tRQYeX09QHzjWLzF11RfOX
	/QuRXNxEF9TLhcd2CbKTT0wuEwMG4uijnqZCunjMrEuT9qWU4rwPBoPRTEV0FRtNf82szMjm49+
	Rwqe3hHyWuG9M4vCQygWAexVoaQDgyOwJ72nntkvoJbPedZxqNCbC6RjB1z3NI97wEEzoSz+nIV
	W9zHuXJnyxM1fbdL6ecQJLQQV5+jAKpPNsYKKp6SKmcQrDuA8IiNVaRV4lkqFX8TKbKezDuH8ac
	M/6E9f/RA/B7bMrKTktkZMFuVbc3MlGhCVdKpN7UVGzIr5WEbAKzDv2PDeuxixHUqv+gBG7W16h
	SIt8+gNYtJqNV+zABrXxQtFp
X-Received: by 2002:a05:600c:4e04:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4bb7da18a01mr8456775e9.15.1794952428596;
        Tue, 17 Nov 2026 13:53:48 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d256f64sm14712755e9.1.2026.11.17.13.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:53:48 -0800 (PST)
Message-ID: <71e860ac-3a79-4ac3-b8a2-09a115f5e97b@gmail.com>
Date: Tue, 17 Nov 2026 22:53:46 +0100
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
Subject: Re: [PATCH v2 1/4] mm: update walk_to_pmd() to explicitly return an
 error
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
 <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 7:31 PM, Lorenzo Stoakes (ARM) wrote:
> Rather than callers inferring an error from a NULL pmd return, explicitly
> return error codes.
> 
> This allows different error codes to be returned for different failure
> conditions.
> 
> No functional change intended.
> 
> This is a prerequisite for the fix to insert_pfn() which follows, as that
> needs to be able to tell a failure to allocate a page table apart from a
> race with a huge fault, so mark it for stable alongside that fix.
> 
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
