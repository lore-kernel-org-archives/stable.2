Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501475;
	b=05HCLN0Q9s31jW8jM6DtYLz3g5CihDvSp/DmpSO7qNrlBSzQPtKGNFb7kBAUuvqZprOm
	 V4WQfgX9+d0d608URaNuTaSqMQ1eZAH4rreUMmtBlR5toU0uU2nN24sQx5ZejqBhPEfxe
	 UuHflvJDdu50omtATBQq/SFGkdmF4vEFgaIcYEn1L9UbEwhU9pTr7rFQuisxeu8boWhKH
	 fM6jVIDlhehL0Z2QPcfI7nCZdUzNVvLS1S0vQvPldfrkUj9DwK6FmNvmXp4eMLI0yiUPu
	 JIE3uci5rfcl+tJjUUZnrnC6FZAMlxlazH76GhZjIPPBzuC5LC1Ez9/GB5fxnihwpnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=nvjirMgHIxC88ZUFqPd+mUQ9zs5Wq4hvPV8uQmDh82Q=;
	b=ztlsYJzzPge3hoipP3i7oV32XZ638YRyk+hwuVV1xsLPbEbVyFOPl1by3qHyMn0dzmaY
	 PNObDKfTERM1LB+QERouDf3FHcKpoOPe/jrtVQMhqp1JG9J7rte0JyGrLG+e7sJUWexSC
	 5+MrR2iiOuOFVIolhqjNqqscQHWF11gO59P6MAD8MVvRDUZdpnyAfMkIMwoio1XhufvXs
	 1CdjPANwP8xxulJB0XHh1EjPuWJhT66FACA1stTBjXV8UQdiSSfH/TPxLwuM0Y27KdTc9
	 ZoxO7xf80wAbKAscABZnebismbRFUA8cNetflRVKcP0LjUN5G20eubXNp41Itf8ENXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EcWg5X0n;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1C606A338
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C1C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EcWg5X0n
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c616c84so416010285a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794501474; x=1795106274; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nvjirMgHIxC88ZUFqPd+mUQ9zs5Wq4hvPV8uQmDh82Q=;
        b=EcWg5X0nzGoNsJ0lB6GPdQ16HEXrDhDFvoQsS0VrzVleAIoPDVqS/h2acM8q0TQYfu
         dFvoIUBys6Phs9cm9/zUsvGd4XXiUFUgl2Vvh3DVjvMRwzUYK9Q41zDGwVwWXB0/n9cw
         dMU8taq7vFkwnnEXKmC9KIXbeUMyYq40IdG0OPHGeX7lvePvlpnmLRTcmVqFwecD6gPO
         jcjjBvWRzbqYTQEOYNjHIngi9klLayXp1nffRLMV2zEQTxslQf78Eyf+TpWKysHmuy3J
         4JKN5sNVVBr3UPxXRJclimCFmHmsOm3RQFiy8w08BBtCyPXwzXvbPbyunw60CSaGFLTm
         yKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501474; x=1795106274;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvjirMgHIxC88ZUFqPd+mUQ9zs5Wq4hvPV8uQmDh82Q=;
        b=UJEXQsg5gFsyPW7QQ4u8uDbgrAuGlC/3yg4mv16cJ4i6d6NYSsekgcu8wUpw2HiIlU
         kjwQAX7oP5Q3qzWKF8MIKQeB/H9n1oUcnpCEf4CJB9AATFnL+nYaau2ZmrKabUNcTUVY
         uqWHeGtv79Bn7RGvAMqKZaGNfSPlt5gaU7s3JwvE2IUlw7KVgZoXqB96+F8dMed0EToL
         WUnyFjK4DGd6mYA9DhAB647ouSu7L9eLukpGg2x+Q9538wfWonbX7h2vBh9FnT4cNRxb
         QyOo8TbwaeNUmgK2vgQhTsR3sgGaCyK9W16m32LGXjNaIr/HkYNBcFlVYadF5YrOullm
         Awzg==
X-Forwarded-Encrypted: i=1; AL+hErGi4a8FV9E6/zYzbD3G8afQTt9JZo8cm/hXsiKI4REzEXPRolwMfykOBVRrwaQOGhHmuRI/fdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+r1UJgfj3jt28INr+MDeZgCF2lNmO3qumRiIMqx5UMJndwsPId
	aqYoeRof8UqbgsYtUKWg4U7rsmJOMhCLg1ff5vLgBVBoRcfG+haVjZnlzC69RYjtTHI=
X-Gm-Gg: AYBFou1AXUIMgI3uY23zHeL3/TyNAVZ/LukBiNjmHxp11q5Mh1XkxaSHXeidlzu7WXE
	+jy6/D9YMKyppB+kx+weEq5LIQChJhUKS1tTcCpYIW63nKXhe7F2gaw2QYepveYSUrN+mrv0m7N
	PaebZGz4NptgGNdVbprsJ7QSIKhTTQzqZEnjFCZ4aDUFaUpGjWiHcBY++ygxKxwQ/eTD28UeSEQ
	jPBm3U8m8W30XfzFSTnKROYwsp9Q4lKNrxEk1nyQjtJHqXr2hFLoz1yLoES75SShgE+EBToFmgb
	VIBH9UOgFhnjOL5xgvt2yP5SrgfqJ5q31986z8pHbLYS4oB0Vpls3dbeYsu9qjA7As/93xoy5WM
	MNcIeAt+msJYIdjxlEMM97EAN20PdCv3ivY8E/CkfgdtAvDHmsQlDr3lMKCT2nBZRb21WbDo6nz
	aTN4/B//voXyhMwvLXbSlr9NtdZwYp2FmqjuU3vbb5ymmgor1qEx71J1IosfbHhLRANuYExryOb
	WSY3M4FCGdxYSuW17iV/TY7MW0NGxkz3sJkVPG1LNkwXbmQJClsTRoStc1KRDtJ275tlOzZMCrM
	IHw7zRmTaopl33AjNPK5dujLhb2okwVyPr00EMags+g4w5bk14kuQridIUA20JLGPMJNBN7rjel
	nd4k0fp0=
X-Received: by 2002:a05:620a:28d0:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-947aff8c925mr1038556485a.46.1794501473963;
        Thu, 12 Nov 2026 08:37:53 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02df0333sm51261056d6.27.2026.11.12.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:37:53 -0800 (PST)
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
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 11:37:52 -0500
Message-Id: <179450147215.482102.15685424149106944496.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> It turns out that filemap_cachestat() can unwittingly return incorrect
> page counts, if large folios are present.
> 
> This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
> kernel if the input range starts more than 64 pages into a folio that is
> split during the call.
> 
> It can also occur due to pages after a large folio being skipped if the
> range starts in its second or later XArray slot and the call reschedules at
> that folio.
> 
> Finally it can be caused by pages being counted twice due to folios in the
> range being split or collapsed during the call.
> 
> filemap_cachestat() walks the page cache under the RCU read lock only,
> and for each entry it counts the pages that lie in the range. It does
> not track how far it has counted, so the counts are only right if the
> walk returns each index once.
> 
> But a large folio can be split during the walk, or small folios can be
> collapsed into a large one, and the next entries then cover indices that
> were already counted.
> 
> Resolve the issue by tracking the current index as one past the last index
> in the folio, and explicitly using xas_set() to set the current position in
> the XArray.
> 
> Additionally, add a check for folio_last_index reaching or exceeding
> last_index and break out of the loop if so.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: updated to use curr_index, fixed comments, updated commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

