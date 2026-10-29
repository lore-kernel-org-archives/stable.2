Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301479;
	b=ZULH5IcccEUmF1b5LoOVDI2H31slX8AUEK6LKuBLY25tUptthtdwca8bZi8YQ+eXSih/
	 01KP3niyPwPcD6BtCGWmfImuASmiU0zFtWdGZHm/7yZ9ypI0tdfh9qIof8AU4bZZ/ckX2
	 ylu2lucCYaEYx3G0BTEt0dBy911f9h6uZ3Qhc4VwKmLySaOFvmsuYoTGk9DdhTmIxfRhl
	 BGo3eoe5zvnIBmu8UjqQgU0DjzB1FdpiHFivnhaoApKjS4qN0l6GencFj2jwdqxlIzaik
	 68KwlDMJIYCwZy1kCPNt0JYXGO8QZO8lBUW42Xnu7nsIvVv/dlY68d3Nmej5v3IPXuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/ulCvwB2xwRabyK+mOG5zQB868mEQ7a193kjvrG/0Sg=;
	b=rn+FehibBTOXrfVu/U7N0rj3phmrCOLjEb61MtuuWSs04Skff/FBod1XpgPqRZiLL1z7
	 fhJpJlmXBpjjmLcsatkeamsvGCmhowo7qoJIxfkQOFjOsxlHr7SQwFCFutZR11ex4ofbd
	 i4nhu4Uy49ZhNXeUDB6bF7ORPextQea4vib978ASh9Npl3ZCfQMyeqfvvHWazlMxpJM26
	 TqyTFi/YO/SX5TCLI/TLDs2pUuKn5sF+BU/hWmqqS2rowNi93k3HrEoIC4jF8eUVENxMW
	 yIn7DakCvjFfQ/4nNIhrlHuZi4l7nZ4rXmWXygrChxvi3nELlQiymLgWdYNTgN7jQew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EA606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 569EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6798af41644so2051761d50.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793301476; x=1793906276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ulCvwB2xwRabyK+mOG5zQB868mEQ7a193kjvrG/0Sg=;
        b=gBMaCZnfEHzvdpxRC3G99RRCV1PII4S9DLB8gXI+TdO7z/ALvtzOGCkM3K7FGycc4P
         qB5oGn/6a9lIM4CFK9Dlq3PNcpINRq7KT/Rdvd0AsXW/TzJYsZZjwV1I7HGmn0SEecgF
         prDhrXvBNk02mgv4ZlSJ3vVtfSriJ2hqIaGiKYCAtm67bU8dkg5+x89EvuP5rNSQeavh
         llpzyFB9cQOAWMr7Q7ipO9/vGBpXxAuFxDPkUzCWublErrjtg+P1d84CkDiRWPPcUPDT
         OVqBoLD2+jw23OWyaog1gNH/0LIFr+RsdIcuw+lHkmzxVASAqu79nnqPWHAarLFVVIr2
         Rwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301476; x=1793906276;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ulCvwB2xwRabyK+mOG5zQB868mEQ7a193kjvrG/0Sg=;
        b=JQpalRNneRbkc54RD6f87rKcb0DuT9TsJOTFuvJzsm7A01bR6GyK77ADF1frPnlVxL
         ak2LDIZ7jbtnwIP4avjUsyyisumT8rl7yy09kFWVZrSnoSJfgGzVB1EMvnPB/6GqMhKH
         8/NS9K2Fmk9RNIf63R9HB2KBx3lWg7JtU6eK5sprobHlCAkRTlsNjl092dkiG6uN0URP
         OcCT9S+457OUizCDbLdn0bnQGPlCm8w2fNMpF/T58vrldsgaYH5f5uey+MWOJFJllC6W
         2/gBahrUATsiguKRIfkxtPccA4GyYEXpp+vQ07/RujH5xHQMeVXNaO5GSbnu97+LRJh0
         qICQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPvFzEc8ys4d8jUb1hbld/YFRju4lKLYdVZqkgAM+NZURINJ4tiUuOt3g51mmgRGPO78YcT8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCSQwRdbnqy1GRiBw7avJIt5Ufsh7n8l23Ry/Twr0k9xd3cmbe
	mpEWpmjvQTpJheVkbITNEDYvR9KN9wc1AHxbbfc1z66GymmV184ETdK3NxRlkflQi60=
X-Gm-Gg: AYBFou0BZBpz9sed/opHHZs6g5/VIPauea5UtEdipcWc2LdD7iEkwZudNGmY17OmS6p
	kY/B9Lg4BOXmh1n1r/T4rjU4ja62vwC4ROnyzNqFBdlzzGOy+POR4h1to8ETl707vbktfMmfeYU
	wWvwDHNCR8Wj/PwAjYPx4X8SmwLq0kvhryKZDaBN8TpQtoy+Hi1n88NRbp7fzoNNCkjIHpKfGbb
	NAKq7tURq8LEENcEPD/CKzHsWLG0wzoWDl3ZuyknLHUSEb0UgV4N44A4/qCwLEyPSIwev7svAzm
	cxm+0mpCBpxGqTxP1MrHCOybHySHMnSaYfPQn2xrOkguMe/xgtSDbCo7r8H4bYi6SAp8G8ljtQ1
	tRioGEI2mNGscE5OOwfuibVqlJX2pEM8eRJudj35ZgiGyhkwUickcmCfouE0KThgMd9Vswv2lNP
	ocp48+Wv52QF0lbep4g32ptqgizb6bi4fR+H1Ydzf0GhABwsW93/qmy5XITCNf8wuVHdkleklxK
	c0p8sfT5CFXjuITSZHhZg+Rrx04IcEkPfRD2fZtBQ/3Y/YmH4Z/7MGxPDThFQPZ2fTQm5vcaKvy
	5qMfHJvA5hbwSA+CYCh3jcxs7A5d
X-Received: by 2002:a53:b193:0:b0:677:cdbf:41ad with SMTP id 956f58d0204a3-67ba4c90d54mr59919d50.12.1793301476120;
        Thu, 29 Oct 2026 12:17:56 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba3a2552fsm148947d50.17.2026.10.29.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:17:54 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:17:54 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Chuanhua Han <hanchuanhua@oppo.com>,
	Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/zswap: drop the stale zswap entry of a zero folio
Message-ID: <auOb4tvXoDbsx4jz@cmpxchg.org>
References: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com>
 <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>
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
In-Reply-To: <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>

On Fri, Oct 30, 2026 at 02:31:41AM +0800, Kairui Song via B4 Relay wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A folio can stay in the swap cache after zswap_store() has stored it,
> when a swapin fault gets a reference on it before reclaim can remove it.
> do_swap_page() maps an exclusive folio writable and, for a read fault,
> keeps it in the swap cache, so it can be modified and swapped out again
> to the same slot. zswap_store() handles this, it replaces the old entry,
> or drops it if the store fails or zswap got disabled, "otherwise,
> writeback could overwrite the new data in the swapfile".
> 
> swap_writeout() does not get as far as zswap_store() if the folio is
> zero-filled now. It only sets the zero flag of the slot, and the zswap
> entry with the previous contents stays in the tree and on the LRU:
> 
>   reclaim            fault              zswap shrinker
>   zswap_store(D1)
>                      swap cache hit,
>                      map, write zeroes
>   swap_writeout()
>     zero flag set
>   folio reclaimed
>                                         zswap_writeback_entry()
>                                           swap_cache_alloc_folio()
>                                           decompress D1, uptodate
>                      swap cache hit:
>                      maps D1
> 
> Swapin looks at the zero flag first, but only when it has to read the
> folio. The folio that zswap writeback leaves in the swap cache is up to
> date as far as anybody can tell, so the process gets its old data back
> instead of the zeroes it has written, until that folio is reclaimed.
> 
> Invalidate the zswap entries in the zero-filled case as well. The folio
> is locked and in the swap cache, which keeps zswap writeback away.
> 
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> [kasong@tencent.com: fix zswap_invalidate() arguments]
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
