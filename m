Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488367;
	b=1mqqh7wukaqTvkEuOSbbXznIRkeZjpA/mH08m01pLRmZOF2uAksdF+VLylhp11EYXJdC
	 omJSKItx7okae24hKKlO+0cZolj3tLS6BlaoWBiAPaJ812u2/xEKabZlwtPavpshMDjP6
	 2BGJTEndekap+yEthz8I2neb06DwbgeQj6hokiD8Jpn1dcgcBeFZtbIhOxaX9p2Vfl4yO
	 xNs6T1jGaKNWFpd9bOCzt5rFn2BhxyPaZofpcZ1TY+wQi/+PMSFfReR8mKuoSWuCGhgfd
	 tooa48I8wCk+9ahHdj3YL+uUhDWNpV1J+F5UOCtN3QOPUMMwGCDFPEz4w3hH7lAPnyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488367;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kIjgqnAMxUJVZUYFKpZcA6Fzrzt75uPnZ5rkJJUeTcY=;
	b=QzUYHBwjRqDRGKkFkh1IUIlzPiMVdIhA4iFUKkDVjMlI9MNHEK2KXwP9s15NMdrUu6TA
	 dODBuLKSiWUyXXzkqjB6YlDpUHmBJeAtm9BcW3xRHtI0RiE2xv/jBWyu57vdYVIrNWvZm
	 XOvwTw/JmurIPN9ULP9lzSSNn+QkryIHbX+iJDxzRQBcn+scyu8kMhLpGjoj2yt6tv4Jy
	 gTOBlzmrt9Cl7myo+4Gh6OyahP2w1pTTkXyEUxiSzlSU6zJcP9mOd9ISNLj+ma/EBhGYm
	 j8EhkGvoLxsS+pfatL8t+qeMMwt/5L46hnWPfanEm/Hii13uRKbh+KL+mHWjSGHeLKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZiSCJRwh;
	arc=none smtp.remote-ip=91.218.175.142
Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C8606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A78C8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZiSCJRwh
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=msJI9NHi4PrS8E7yp9ivWhqzbD6z18uYwbGmXJXPkgc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795488364; v=1; x=1796093164;
 b=ZiSCJRwhnVSheIp7v0YyljMzaLadnEVPeAlbfjCZMRNuXliqUAT0X5N+UI3f58BEHFWI/vtN
 Ct0fIG1FHvqs63vrJEINF2aF6i8jXLHb25duq8k3uthutjavRt2G2TOTGcVrEDw+LVpoa/KzKf4
 vfxNbDBJw5XTWkWmGfeSvRuY=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id b74d0136862a6145;
	Tue, 24 Nov 2026 02:46:04 +0000
X-Mizu-Trace-ID: b74d0136862a6145
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 10:45:53 +0800
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	donettom@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/mm: verify ksm_zero_pages is not
 inherited on fork
Message-ID: <awT6Yc/rFuyp2r13@dgvxl46587.localhost.localdomain>
References: <20261123034136.209410-1-xu.xin@linux.dev>
 <20261123034548.237302-1-xu.xin@linux.dev>
 <16d172a9-bf5c-4a69-93d1-b48cd53b67b2@kernel.org>
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
In-Reply-To: <16d172a9-bf5c-4a69-93d1-b48cd53b67b2@kernel.org>

On Mon, Nov 23, 2026 at 05:49:30PM +0100, David Hildenbrand (Arm) wrote:
> On 11/23/26 04:45, Xu Xin (vivo) wrote:
> > Extend test_fork_ksm_merging_page_count() to enable use_zero_pages and
> > merge zero pages alongside non-zero pages before fork(), verifying that>
> neither ksm_merging_pages nor ksm_zero_pages is inherited by the child.
> > 
> > Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
> > ---
> >  .../selftests/mm/ksm_functional_tests.c       | 44 +++++++++++++++----
> >  1 file changed, 35 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> > index b871d5656688..0e128c579d5c 100644
> > --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> > +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> > @@ -655,45 +655,71 @@ static void test_prot_none(void)
> >  	munmap(map, size);
> >  }
> >  
> > -static void test_fork_ksm_merging_page_count(void)
> > +static void test_fork_ksm_statistic_count(void)
> 
> "statistic_count" sounds odd. did you mean "statistics" or "counters". Below you
> use "stats".

Yes, I meant "counters" (my phrasing was inaccurate). I will rename it to
test_fork_ksm_counters() in v4.

> >  	}
> >  
> > -	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
> > -
> > +	ksft_test_result_pass("ksm_merging_pages and ksm_zero_pages are reset after fork\n");
> > +unmap_zero:
> > +	munmap(zero_map, size);
> >  unmap:
> >  	ksm_stop();
> >  	munmap(map, size);
> 
> This ordering is odd.
> 
> Why stop in between?
> 
> Also, I suggest using a single label, like:
> 
> char *zero_map = MAP_FAILED, *map = MAP_FAILED;
> 

Agreed, the ordering was just kept from the original code and looks odd.
I will unify this into a single cleanup label in v4, unmapping both
regions cleanly before calling ksm_stop().

> ...
> 
> if (zero_map != MAP_FAILED)
> 	munmap(zero_map, size);
> if (map != MAP_FAILED)
> 	munmap(map, size);
> 
> -- 
> Cheers,
> 
> David
