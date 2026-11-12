Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500012;
	b=tXwwf01f9K5qZ1v2il4n7U2svQJgo7zbXYPlNjyZ5lvClCr+BE/1rUGVhwSA8L+A6NAI
	 inAtETtGN7U6y2GUfm37RROxWMhirJ0TdWABAwspXRz2ukTo8mzevCI/a0SIFZ29NacjW
	 y61tB/bCnVlE8odJ6xPQ+g+28gjsZhPf/IuqO5TNJdv2KemSqChCdORmWx9xtkz3XNTBF
	 /DDEeyO8Sw0zmGkcnaP+iMxVi8nbRdl9ESerZ5f/tEHtvBXbGQgKbrmfyMPn/bBGochPg
	 eaNI5+AYKYFS6dC34OkFeNtgjFhINl2XYSEXr1ybFZtPYbL/qPateppJSMl7nZJRQKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/SNlzExwuTi3WbPB+pJy/Rdg9j690l3UVVEipCGae4g=;
	b=iEHTNLPkbbPdA7nRF6JT012NrYOSl1T3utLIr26yhuJel1Uftw+7m5l7qA8Dmep9CdCq
	 Cte/mKpIdcPywLosw+FS3AXfra3w85PrjVju+P2OiF9IZRQMaOwuQtrnHvSUsbiQI9Bhg
	 ZeEjR7qvl/nYWy2ek5V1INc/hHpQNbo53nWv9i7QaJBeFUQWwZLRyH7CooAx6vcVRiyP9
	 X4n3rLeh9foG79pktVFN3pRSf64FVrxAObd9wHJIdgeBckLs0TBEZ/R9ToLFflSmfqvr4
	 DLh6V/t1vMQmTsfL7C+mbG1fjboEPpVNjP+kRUrA0CORO+K+V/s+xMAQhtBsAQI+Zsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b="mscvbfX/";
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA385606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA385606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=mscvbfX/
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67d8221074dso715381d50.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1794500010; x=1795104810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SNlzExwuTi3WbPB+pJy/Rdg9j690l3UVVEipCGae4g=;
        b=mscvbfX/np19cXZfqf03A5JubaZGcQnOdRPEso5ZtATeXHb8C7Bvj23mu7X64g/EN3
         QwAOJlPBVZukq6OpcBrzGmArUgoPeZw2Vt5kYDbU9kFGnmdIW4tgN52NieHN6bY0yI/Y
         8qGXx3lM5/s/FVRkcsAVaU/y70hq1jAH4meA7Z2HjyH023lPYtWE7cG6D4uT4QYoVLru
         9atHvOkISWTpFFYJHw2yLsCEH7KhKFFPJjGjGQiKyY/8mITUKqDsFHtqUfiHayOrFGpy
         HCBf4ccp+/B91i7vol6oNv5MfCIBqxSriklzVvFsQegtN3eVRHj0VXbRiRFTlwXd784N
         RshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500010; x=1795104810;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SNlzExwuTi3WbPB+pJy/Rdg9j690l3UVVEipCGae4g=;
        b=Cl/V7+BOhhtrthIVddTZiRIk9JGZhKpQ7NBe0wZ1QSG/kZ2FDnHHNSbdcvnYVhRvNk
         42Rwk8MCtiQbLchKiUsN83cauGWISh3DOC4UTmYBLGBvahAIHOvuvMQmMKIzfr0sxOMH
         1RTwIBKgDoODYA0w+1SEoUoriBjPvlaGC/ha10rJ6c8Fg8at1dVfva7amEuRKjEIulZU
         gcP1vzRkqOBpwskVbtk8ao+AegsZM0u1iytpsL1oVsfywhBVIdvHc48CuBhnIUdcUaDS
         3LN7fDJQC11TNmMc3IOFDXkxxFyYIgtrvfm2ZbmlycreJ1xXCGEFeNhDWHo9rBN+0vBF
         YGDw==
X-Forwarded-Encrypted: i=1; AL+hErHe1dHy7UYzEtoxm+DXvnq1fQqSZiSMQdUFRjmkCLWrcT9aau9L5jeS/w4wM+3eTIsdfGKtM80=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4WKsc93U0Ey4xftpPawEKRdByFVroXD8wccJAMYkRKoV5Elbu
	v9Aqtyw1sGrtaUFYZj49EN23Aowevao/H4GoTmUJbhuRv13qcCy/r9spFX3P/s++Xxk=
X-Gm-Gg: AYBFou1e6WbIXVsVHK1MLkLn0RD8Ue9RY0plwNKgPqlc5lo/dhr6KMBAYqagcX+PrDG
	PXK4nPG+flWObJwmjvRAmeKE3WH2s3X20ipu5NJrlla87TuzGCCmUg9fwNM6qdKjiiqVvN8WlFA
	p/k1dUwvtDQeHxQJfr/eb5YOWsUcWutIqe7v+ZOlMmVQ6EjX+dJDnkXAIsVmRilaB8hVigE5tA5
	D4M36oc+HBb+Pxx1eRBj4V/MuQaZyYvT3RHfmmiyPfl7/cSrOntz0LBbOEdeYOp0a1+IBFlJUea
	zn/hhN7NLT6ZsbvIVSsFn1+IPT2Qchkpg3n/JOlh0kslzBzZDsT72En/4KNsoXans8GHEMZldCq
	zPIUQhUytVimCcGKdYPTbCHr/YRK0FoYiq6nP6pCfhSLKJiFPdXrdf0trfnraMmALIkG8sgqkHg
	6j7g5MbYlpoa2JJJnpaqZ6l8fBmLYY/caK40WH/teOOHpeivE5rv9xkv8CJU27RAMSB3spauh+L
	Vfgc46ovW99mlGaRpcNkurL5p7DGaUtWT8Brvscb8Imgaz7SKyJPwW3IXQmWP/5OoHtoYta9yGz
	1zdoBaTjlh9sDZJGfGhcdkTeYt7F
X-Received: by 2002:a53:d711:0:b0:67c:1557:7b48 with SMTP id 956f58d0204a3-67c67fd9f14mr3153613d50.64.1794500010621;
        Thu, 12 Nov 2026 08:13:30 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm73138157b3.27.2026.11.12.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:13:29 -0800 (PST)
Date: Thu, 12 Nov 2026 11:13:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
Message-ID: <avXlpVZTs5_ytZtV@cmpxchg.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>

On Wed, Nov 11, 2026 at 06:13:16PM +0000, Lorenzo Stoakes (ARM) wrote:
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

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
