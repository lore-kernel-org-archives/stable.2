Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508418;
	b=rx+sp8YCRPAQXxn6KRzqqqvAyLA/qkxGjiMnEOtpCrGslEWT6+bmRlu9axPypcjUmpFT
	 hUrDG8GmgxtmFPPq9d35xlgVh6e76MGImqLoBWNNZy69YHJAO6iVh2ZaxdzZxeVowgIat
	 FP+ad98SiVXVtORBVrFk6KHDyk774D+qo0Bv/xhKgDxaeFfxwVj91zv27Y0SEKhQGKTmb
	 3iRNKYj8b3C4KxgyU8CMBE6Xm8Az4ci9p6JEVujWvjOQSn+7wrrSEMCV6BszNnsbJ5XBP
	 CPXfzrr/MX4d9g+DUTZXhDVCtxA/Zj66+qjuKysXDAV/ft3+y65mtV9qCeOvaikurmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=E0X/oBNSd837oq8qemdGMRW3gOZl3XdynAbQm9FPXsA=;
	b=WC+TSsYqgp0l5Yi/UTzdYyrrqMwectaUIDRsLBV1aqdjjPsrK/1boIarzXj92H9RAn6J
	 V2yAcM8D4qR/mCtYg198iq7vrXuqoXWXpjoA6VFY0qGRPiqrvEuhu1RZfizSt5e0VEdat
	 8HSZ2aXh+cYMznbNeK+YwCNWa6pGKyBug7OrrywNIRJz5rUdVZucePBzSefjapcA4hjvw
	 K3mfl4AyLiBzVgDAyNWA0xsDktMKg6YXFAf9sD07Mq65UYPTi0SYOb06w+swqOJuT4Bi6
	 ATZPgfT1TQwhIHou6COyVLMZCgTWi1zfmObb7icLLw3pZS5AXT17voRfa/Vto7AdLiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vOr2VvyR;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545C606A33A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D545C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vOr2VvyR
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91eda36322fso575526d6.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794508417; x=1795113217; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E0X/oBNSd837oq8qemdGMRW3gOZl3XdynAbQm9FPXsA=;
        b=vOr2VvyRtP+KBt6PNgpsroLYuZ2WDXRyTOc5i95zgwooIsYRcxqQzqiTLUmi/IXsxY
         hHwNRJhCrscdVv/HsHUP4QAcTt1cJdndeVKPMDxbJ861WXUxNdUDlH6/AnX5mNWc7Ok7
         gz1LKAJ7k9EX0GE3xjhFTEeo+pTWtrYXtUOm92dteko0p+d/6NHk9jVtPuT8NDgnPWvg
         XtxTBeTZ4wwWnSR7wfGblG7vb8M3uTKovXED6EyA5tN4BZTkv+jChVYvxAiFXwAYGK8k
         e0QYgsMMPmx9nO2Garn9QvjiEbljM9VzEiJMpYxfNqtFGezq9HjbZijLAU2AbIeA4Mjf
         wCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508417; x=1795113217;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0X/oBNSd837oq8qemdGMRW3gOZl3XdynAbQm9FPXsA=;
        b=rYyOOo/uKDlEJJHwR1pqeijeHy71bfd2aa1OdFLvzeBsanQa9Hs4ZGXu9dhxxsaCKC
         SZJxWnP1yaC0MpM5QzMqX0MMfjYEtxqbg9eQ1+ZI5fDZKepeqdbG2r/yXRW0KcSIzsIZ
         PJQdrVWnGPN0QoGFe7PVxlrHa+aJADlTPLZ+NiNsCBWehghH9h6DnyRENZ5ZAJdO0aMH
         AulTIT+GoOD19mStPD5jl0+HJk+OyFy85o46NgTWTSIklK299hnUAP11YyU7vQvJiyeT
         rZE6oRtAbiM9VNlr51ODYuoNLN0KYKY0PeqZc0gK9RbZhs+xQqnYaBWOjI+gvGpzBjuB
         NVJw==
X-Forwarded-Encrypted: i=1; AL+hErENEE4OxotfmN/WLhOeytUdhyKcvOn/+Mh7tsF3+CeJG+gcTW70BRcQrXXEKSJQe8/qo+QYtOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/K8OWcMWAheb45Z7T4FaFRCTG4TfVsQi5nwXfMBD0SaySZsi5i
	10AW1fU2QYrnbPrnorgPH1KQ+HIvC0Q6ca+rcMITl4mZVRIp+FQ/qS/eI7To/HjJqeo=
X-Gm-Gg: AYBFou39eRKT/zaWsbaSGOqtmHRsPNawWNpUqdnaYSiE+rNUkv04GRZKMhUi66kXDx4
	du91k2F3P8KqTpocgkT0H6bNGw4/MkaaiC6kenJ/aq5GIDnNcXl6WVSW4svMJUhiw75GtEKpN7O
	o/6Cl2BQpNFUoi3A7IPmvOsa9JNN7hmMnVj06i6PNxOxkYLQ01TOukwPVyhgzTntpiZF7qGi076
	uQ+hffPHg5U0WlOWheNBBvKm5KRssG37csHAT7gdf3mKcRoWhbNgSZPz3yFaM5rSwpgmQXK6d1U
	S9Vq/l/LRdzHyxDuGXIWORuE11S3y8XQAmScCfkeUJYyoFhMruVhoswBViH3ZsYCKUeV4hByXMj
	z4LuAzfcC7bWeoDZE7ubaRSZJ2pXtxRDRZcCF/EsbbCI6oHuAwvifbFV2xcvG5VAbF5LjdAKPEg
	s/bDN2uCMOqYb5q8HfRWacnGbZg7DMvRiHf8D34/x1Dpv0ZvYAG3p9I4tZ2d4zlFEbtOtv224jL
	gi32HWWn9IugbjC+fqNyimmPjycItRQeY9mXh8CF7bWH5dZyo8ReVhN3MqkrGWEljvRdxN20Vay
	ZTHyzKrFIJ+2EAnrVMQ4d0FA9P7r4+iNzwuKfbDnObRRSdnYoQgToICWe3NfFT1/QzWH7lzBk+S
	WoCDRmns=
X-Received: by 2002:a05:620a:27d0:b0:945:ad43:1d59 with SMTP id af79cd13be357-9494bbef3b9mr40481685a.75.1794508416926;
        Thu, 12 Nov 2026 10:33:36 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d456b2sm2035036d6.12.2026.11.12.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/13] percpu: search the whole reserved chunk
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-12-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-12-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 13:33:35 -0500
Message-Id: <179450841509.482102.2272758511939089806.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> Loading a module with static percpu data can fail with -ENOMEM even
> though the reserved chunk has a free area that fits the data.
> 
> pcpu_find_block_fit() does not scan the allocation bitmap, rather it
> tests the request against hints, starting with the contig_hint of the
> chunk, which describes its largest free area. If that area is too small
> once aligned, the search gives up even if a smaller free area fits.
> 
> Consider:
> 
>     request:      256 bytes, aligned to 256 bytes
>     contig_hint:  260 bytes, starts 4 bytes after a 256-byte boundary,
>                   so 8 bytes remain after alignment
>     also free:    256 bytes, starts on a 256-byte boundary
> 
> Ordinarily this is fine as the allocator moves on to the next chunk or
> creates a new one, but the static percpu data of modules can only come
> from the reserved chunk.
> 
> Fix this by searching the allocation bitmap of the reserved chunk
> directly rather than using hints.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 13f966373f92 ("percpu: skip chunks if the alloc does not fit in the contig hint")
> Fixes: b4c2116cfae6 ("percpu: update pcpu_find_block_fit to use an iterator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced the exact issue.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

