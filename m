Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206565;
	b=hr6D396+3Nkiw4pOFxPWVFvP0NGeovcR9ImcuAgwe72WU1bPEM+hKGTzaN3ry4kUynVk
	 zyyeqWQhVLganohK+BY84MUHbCU3P/sICvdH5eyzSduGg28v/TAXlmp55ckKCeoiP4iyr
	 FJv0CyS/8LdlltYJFIS14EBfeaSA6DWTq/Re4OFDVCyfRprMP1Wkg0+VUOGxX/Nnw5XCh
	 hNBLPn8IS8+6mtiauhhrgFtJ5myTPepS1UdqUO/IH2brt3pRGYMg2eg/gSSIbepRAxv1/
	 DUu2KdIO1H6bllYxKU3DXyCUntnkmqhb4DSAkZPSzBwPDcH5yALwreXx53geJnw+WEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
	b=FglUkfabjn/ySjMutdQB0Hnbc1kU60kBmJnIEOivcJ2zby2MGJUY/8zies3C17/PuL4W
	 VxNdOZuOofO5lMSXfziLWFRXi3EQaOSVy9MlPgPOKsuzhkJq+32dvB43qv/hPYK3Wxgzx
	 Jkaps/r4UE6Ew1LZI4/B+TN5CLBeB9i4Q9QAcVAMoB9CJnTcBwEKEUQB9irurmk0jxlTz
	 TDZ5d637eUBNO1aQHNYX40Pv1HzxXMzv3UjlQHUxlB7LnGpNXJToEN6L8YkFwUXgVr47i
	 H8oHHJPXpcTgrmifRoI6R6XTwoBrNYGXlu0Arzpj8paJ0O76dOH1+3QfWI/Ro8kUBHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RLxEwpL1;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC90606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC90606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RLxEwpL1
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7ce645a1c6aso744085137.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206564; x=1793811364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
        b=RLxEwpL1hIyB/8de987ZDlpeLtVUV1o6ZwdAJJ5mPDG/A2ay9kTAD4XqeALAUEZc7T
         E+rNOMrhz40DYs3ycXgV4yPyi2Usq+ABEvzGTdQ6EpE08oZlMGrXBuZn0oksHESP214x
         HOhO5Bk+S9aZF/Fy2QjBdly76Bg3QJbA3fHIMsPq+C8FaEknA6C+IUV0EwW0bTP9/zWQ
         OOiQwebdi3deLoTwUunNlh8mr6V4B5Us/zvAKXtM1PltIwFDSzlYp0tYCGFgZb7w9dqp
         BlbKIJP2xgxwiBLxFNlTcmwU0vPots5dguJS0n27G0NkKxZIVloQxL0s3OxtMGYRXIkB
         K+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206564; x=1793811364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
        b=oAOcv4YUgjNYH/qqGuqcLlTXS7SrMltzpsGfX1FTZFkYrdcxLNrCBtXEiHygZnCDy+
         b4rVcVDgkL3wyI04v7zfyBx9TYx3vpAFrTM/dICLzmRJZ1g+ROZ8AJYL0qnSTzpOyjqO
         t/Y/f/lv3Jai6sjugQTAT+KnxCON9s2OnLObCztWQpFoSaJ1g7zXJWB1griAnsfzn1nT
         TqldIqrTBsgx7U366fBd+qPOYJ88ciEApXf8dAlVRXMdyH8Xd9geLOPHuy6812/i8vj1
         27q3gNEpsI+Iifs8qKv6Ly+cG95D0V9kcpfIs//ktsc6APLVV5DH9gHbjmHHEbOBdI1P
         8wRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnBLAqOO5/K7rF/5GDz9Du/qk+Y+OifkpsxdVPEKOR3gJJwnkOF27YxpXTyyuj+7ykVs7c/jQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv11Vr49LlStyGDOwVU7Oni4Yn15DlAcFPw14x2LpRa7vGrzUi
	H8XEW2hdC1FeLKie0POmqqEFDVyNMcoNnd2VseY/xPTsIEnELgNh/oVAB1HlFR7e7Ig=
X-Gm-Gg: AYBFou13RZ5WhG7c3PMvWz9D36yYW00eo8iurDR0IQ0QL+6h/SNAh8CaXpdTWxBV15Z
	P/jGIPldKAftUklyC9AW86nUgDTvu/Bm3n+z0mfslA5m4W5nQfm0NhzC5IvjZxV8HYt1DwwEILH
	5kFnwophRnBUhpIyIz2Hv4tNzpXfuVD3EgvwYa8p4dWnJbDet56EAdKz86BM+62oANdcIjWrJUw
	nrtWVSnFhTgk5HYJBx6bwbCzSxc320ezgQQGfLiyF1ZouXwoM02PkTTPUzY3y5N/BjUV9SAUWo0
	56FaKSVFAhr3JiSgdAqHJjrdoUqD5W3QkxfgM5Y2+waj33P86Om58Gdu3Xn/UTXCaHVMPTw9R9W
	6ZbEUOmFi648a/VxJxx7GCfxQmXL+powQk/+DZt0cQ4RhSnbmzd4OGGgquEAroTZU0aUetBObKJ
	TfKcjLSoi/2TEaj4LTM3XzJZ7YJsptf2aLIZSRZW2ugK9uPvQaiJR9WJMNCmeeRAqUmZG0+5SLS
	TaMlyAEoB7yUhfuUFGW4mG8DYJot/whXBZBkg+ukL3H5SRLqx3c9ymrjROJml3GCmShS97pWl95
	PhC5uiSGXTgbb5JA1XX/71DifniogfuzPOVYbGpWVBjdvbwjLpWx9163edstJPduMg4Hd7WSzrf
	lqBTJxgAx8XkJ7frTqejS+4GGg6ImgVAQP9O54j8qP0uaRqqvnzXH
X-Received: by 2002:a05:6102:370e:b0:7ce:a79e:75a9 with SMTP id ada2fe7eead31-7d03a59dbf7mr1528233137.36.1793206564343;
        Wed, 28 Oct 2026 09:56:04 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259fbcbfsm6525438241.10.2026.10.28.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:56:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:56:01 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
Message-ID: <auIpGR1VG7lOxJ8P@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> Each full scan resets ksm_nr_node_ids unstable tree roots. Enabling
> merge_across_nodes resets this count to 1, even if per-node roots were
> previously allocated.
> 
> So when toggling "merge_across_nodes" 0 -> 1 -> 0, a scan that starts
> while the setting is 1 and continues after switching back to 0 can
> encounter stale unstable tree roots, resulting in UAF.
> 
> Only root is allowed to change "merge_across_nodes", and the documented
> sequence is: "merge_across_nodes setting can be changed only when there
> are no ksm shared pages in the system: set run 2 to unmerge pages first,
> then to 1 after changing merge_across_nodes, to remerge according to the
> new setting."
> 
> Let's fix it by tracking in ksm_nr_node_ids the actual number of
> allocated tree roots.
> 
> remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
> more tree roots (skipping the empty ones), which is harmless.
> 
> Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbfb8f98b1892..9c51925825cbf 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
>  #ifdef CONFIG_NUMA
>  /* Zeroed when merging across nodes is not allowed */
>  static unsigned int ksm_merge_across_nodes = 1;
> +/* Number of allocated stable and unstable tree roots. */
>  static int ksm_nr_node_ids = 1;
>  #else
>  #define ksm_merge_across_nodes	1U
> @@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
>  			else {
>  				root_stable_tree = buf;
>  				root_unstable_tree = buf + nr_node_ids;
> +				ksm_nr_node_ids = nr_node_ids;
>  				/* Stable tree is empty but not the unstable */
>  				root_unstable_tree[0] = one_unstable_tree[0];
>  			}
>  		}
> -		if (!err) {
> +		if (!err)
>  			ksm_merge_across_nodes = knob;
> -			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
> -		}

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  	}
>  	mutex_unlock(&ksm_thread_mutex);
>  
> 
> -- 
> 2.43.0
> 
