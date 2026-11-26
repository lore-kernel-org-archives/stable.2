Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.87.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686963;
	b=dgjanK8yFfBQWoIbdKAV2bgnIVOeUYkmlT+8GLXcSDblWD9TW6bx+ymF4gUyZEMDujzr
	 VNJLIkO3hfO5XB4fcIK8y1ZBZ9s14R+rkt2lg+OEoQDe+GV2xwlmzQYaVVWPt5Mv4CXgy
	 J4H+oYQbpb8gf0RTyx1QMEmdbcrnBRpO3yQHGJGBGD4YBvt8fT087UGx5tnqKU/tn1ucs
	 U+W1gYImWD2ipkmWI2D20Xq2xhSLMKc65PSYfGxyNVOlb4+zpAvoNdm9nrH8APt+NsfAS
	 cRb1CcVhAedc2Y5O6wezNCsx/UV+3tQCtxc7AfGEDv0ItAYuOH65NyVz+jkjYrpM64Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686963;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Info-Out:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-JNJ;
	bh=rP/jTD2/f1MP5JxdM/crFR5Z+zyVxyrdqDuSKQpH9Go=;
	b=SdD7c3BX1t6Ok6McZV48XAqDdRRnHFR1VzjfVntfpR8O/wpWzrzH712qMGBCrG7SGnGr
	 RhWKPmXxZR83ZF/QuU0CPh8jnEetAezH1PD7sfoSdP33D0YM7LbqKMfgsAjEqXdTklTd9
	 YvNrofwNGGRZtzGD9Kv0E7cYyLz15KbvhFcXeU8mAvkG55XerCjtyzCCboFNkmsPBfu0c
	 su6Oc9uLphNECPquC9gKmxv4A2DbN+EivYRvOXaE5smiYLLJa5Hidv9Sx2F3a1jT+g/qH
	 HVzGaqL5zhroofXQ96ZSy8Rv8VejEGcUsY5rrIfobX+IvhIuLYZ+QCNdiFe7Tf4GmcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=lUcN61jd;
	arc=none smtp.remote-ip=57.103.87.53
Received: from outbound.qs.icloud.com (qs-2001e-snip4-11.eps.apple.com [57.103.87.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54922606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54922606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=lUcN61jd
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPS id 8C526180DB29;
	Thu, 26 Nov 2026 09:55:57 +0000 (UTC)
X-ICL-RepId: 01a21748-818b-7989-9c68-a19eb0b3ff9c
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1795686962; x=1827222962; bh=rP/jTD2/f1MP5JxdM/crFR5Z+zyVxyrdqDuSKQpH9Go=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=lUcN61jdofNfL0SjfDGGScuPq7Bt330IQqswppasvD1oSPOeJ/L//CRMqGflyFqsqZ9nBLmB9XbtstGdvGUr2fMqvlageMbC6XegyEEaFyYiG/DOvV1tQBK0Elv7d/5+rYv/8ajHMpT2/xQ8qqu5A6Uf7l50X8e/wAgdgfvFjmYHL8Gt+E7iYhtd1jGBEIH8Q/zQOTUKGbyv0G1YWuXJgv41rjUEp3xjfscnwn/NLJkbHoM0iD5opCX1J7d//hHdE/q/9M4Tm4b9LMeohcnCKqkYSe58gW2biK0ZrsoaJfzoLcBo2PeuNj+RBivz4pVOSLkJUY++uRUQJWNRjMxMQA==
mail-alias-created-date: 1772519804199
Received: from lima-default (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPSA id 54CA4180DB17;
	Thu, 26 Nov 2026 09:55:51 +0000 (UTC)
Date: Thu, 26 Nov 2026 17:55:46 +0800
From: Bingfang Guo <bfguo@icloud.com>
To: Barry Song <baohua@kernel.org>
Cc: bingfangguo@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/mglru: skip oom killing for order != 0 allocs in
 kswapd
Message-ID: <awgCInIqygIBMRGt@lima-default>
References: <20261125-fix-mglru-kswapd-age-v2-1-4cc37437af9b@tencent.com>
 <CAGsJ_4z-UdXQg0LYqymEZdoHALPmAZC7eGcXbGad6f0sdjmkcw@mail.gmail.com>
 <awarDrT/DT7tQu+U@lima-default>
 <CAGsJ_4zf5NabZJanr2_Czr3oVQe6tTTdXmddx+PxowbKBN9M8Q@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zf5NabZJanr2_Czr3oVQe6tTTdXmddx+PxowbKBN9M8Q@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzOCBTYWx0ZWRfX6LHtraZbWcF+
 abn6R4qKk7vzmQHsHkTOYZOrQIg2mVYmLwmo0rxqdcuCvtrsbSBHbybvZW/77ra2c2ELCnxc2H8
 uhnYvSwwOHxyNe+KMkA22Ebdv9+r19I=
X-Proofpoint-GUID: FCzsWs0gG87hjATcI8PVbH98kaihmpkP
X-Authority-Info-Out: v=2.4 cv=D+TSufRj c=1 sm=1 tr=0 ts=6b080230
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=vu5NlEYW-o8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AZoGnDOZhPiq548KR6q9:22 a=RKZYdrCfCo-aMvuV6FxS:22 a=VwQbUJbxAAAA:8
 a=ufHFDILaAAAA:8 a=v3ZZPjhaAAAA:8 a=w7ccbh9undGZvG0ET7sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-ORIG-GUID: FCzsWs0gG87hjATcI8PVbH98kaihmpkP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzOCBTYWx0ZWRfX+cOY7UhJBpCE
 sKb4rs+5mUa80+2LNJjNh91BnjHbbh7LyPA09bhK+mYmp5KLfy/JB81lWBI5heS7gqJsGZ5qOP2
 sgzE3JegSrQHHU+Vg/Sy5Q6ybcfxnFbtqBAGxOciLEvIgNj0ZjW1nPPsNECjcwPUcjhzaQ6dZEz
 JR2Gm1IWHhMV+6Gl2ixdRD17D5UsRkGrrGiBZH555g/1LUKAU+xO2oidzY8RoXe7yzjBJfnB5vK
 asPhS3ORlgX69w5jC5CtmE2fL+KNRmyJdaS7vRGhZqA6DcKWlVicHphETBn9qiiyb0CMKwkY6GF
 tDu4yFD1rHlSz6+0nbsjK/2QgC8gVi/cvyFbgdzNOjUcU+rvAdu0NwtDsSBst8=
X-JNJ: AAAAAAABKVOmNomG6Kor0xWo0CtsIZI8TyO4KtprHZqjLDJDWggiv3ds/sn07vJ0MfVakO
 dc3tMU/5xln2Glbv2fs8Bp+RfzDbH3LvlWSDn0DiOFgOF13zhn7AAzL6399OWDW7F5DbzM
 YqAPcv7pXk021SrJ7rumcMcPe8xdjvylCGY//yVJBBWQVedgfaHD/ACQ3EBhXHIIQ/x6VX
 UCctkJm5gmlCF4UAaBsOYP9feEvtI+3htbvzcQ+NyGDi63UAjjsiN7gDaNZK6xyneBZiWH
 V1tBrZG8UgWT6iBrNTjJ7xrvnTR+kL6aDIbtRhWzzySm9d9Mv8ZIjjTiV3EBnI8vJ0ynFo
 feasMl17vKbVN8yLJgMY+Ygqd5iAX5rFCd0ppys2bZmx8fGvar/9eULTXwwAVs5W9cwNY0
 /nS0hFhrOcSqE2qBoQJ745JOgoZkc5IZC/ipr28be/v/Bop5tMcZWAh5Y66JKewWSYMRLY
 +Arh7Grlp6zyZB7Zhd1O0S+U7UNQTJ/zAlqhzM1dK5JxfOwAGTmUPZNMumav3v9FEx8Ihg
 Vnrg01vSTXC2uem3mCcktN36WCfsJO/zN0dFz5k+kuSfO9xu9v4mLT8Y4w8AwQnEs6xSVO
 h66MS6MA8OiXaidkRzBf0v2PNofkVtUPY6B2PlDRuf4SjIyyefoed1nS9g7n2MxNvPCAKv
 mxJXYAjxLjOJq8mKvP3vzBMuqhcD2W4/58pxw5Pdl5Md9GE+e7epmdCYTUVR/sWGAs68Js
 f6bbi8J7m+O6iQcjCBt7R1yhtDqEplzAPl+fonXXlRavKSgsoT5hk+5InEbTOrx4m3WBXq
 bCZKlLyL5FlB74msvz2VoxIMrcuTxPcJ5blIsOGEIJ113O7QdoFqIWGKIfJwY5wnDM3HXv
 +bDxOyzgzYbrSu7A6TVhUxds/Lx89avrqO6ZNGmVuxgJNzxA+bRAVo4uoC7JqgsDcjJEz0
 pzAnrMKwhiwgO749tdXstmxrb7M05R0qASgCUBGJykrSdu7yfIbG627xu7DszXLtzlJczc
 IiVhM6RPFH89REsnTcetJQVofOYvAHibzr80n7a5HJJqhMpzeGRBrOjCnM38iRdC+IAb8C
 BhWL8vcIMqYTf4b35NH4/aj7fmmIkhV36xM5SNbBlj7yirVmsRA2uxs/X1DKBqAPBBwx4h
 SWe60qnpsKusLtZDPRcuwxHl5qJGWPlP1tSrtyiBvhL2jTwB2VyhaUUSxmjMj6GZ6soUgh
 JP21K2bgxEEj/+qo0hiVK7wJ9qRWkkGXfwAK1nv1pAQqnFH6568aWQQuubmtwHC/pxwgII
 cR5KTwwnnuaImwEu704nTusv8Ln4YUb4bB9mN446QtH/h3o93Pwk1x1RHaY0lQSCEPXB8b
 VYAyRQ0XiRSKxU+XjJ7Epw9DX5HodW45JAZbm+IzVuXnf4lBy1tAoaWOKWDEGd2lXzHIkG
 3DqzI16LIq3kN2O66hmTFMJbBtNyW1KMQh5ys3wXYg9tqdPI+fjo7VmdEQ5wm0MVGA

Hi, Barry!

On Thu, Nov 26, 2026 at 08:40:44AM +0800, Barry Song wrote:
> On Wed, Nov 25, 2026 at 5:32 PM Bingfang Guo <bfguo@icloud.com> wrote:
> [...]
> > You are right. Maybe we can start from skipping aging in reclaim path if the
> > youngest gen is still too young? And maybe for this path, min_ttl can have a
> > default value? Is that a good idea?
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d891ae46baf49..7f9b14b772d14 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -5136,8 +5136,11 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
> >                 return false;
> >
> > +       /* avoid excessive aging for huge allocations */
> > +        if (unlikely(sc->order)) {
> > +               int gen = lru_gen_from_seq(max_seq);
> > +               unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
> > +               return !time_is_before_jiffies(birth + min_ttl);
> > +        }
> 
> I'm not convinced that we need to couple the aging decision with
> min_ttl protection.
> 
> This has been a long-standing problem: high-order allocations can
> trigger excessive reclaim and still fail to obtain contiguous
> memory.
> 
> I've tried to address this twice, but haven't found a satisfactory
> solution yet:
> 
> https://lore.kernel.org/linux-mm/20260422021842.78495-1-baohua@kernel.org/
> 
> Johannes shared some thoughts on this here:
> 
> https://lore.kernel.org/linux-mm/aejtfpBUu7gNV6Tk@cmpxchg.org/
> 
> Do you have any traces showing how many pages kswapd scans and
> reclaims while kcompactd makes little progress toward satisfying
> order-9 allocations?

We encountered this problem when running a stability test on a 6G
VM with 2 nodes. It populates the system with hwpoisoned pages
per 511 pages so order-9 migrations should mostly fail. Then it
tries to allocate order-9 pages. So the results might not quite
reflect real scenarios, but I think that applies to unmigratable
pages such as slab as well.

When the system OOMs and kills all the processes, we have about
4.8 GiB memory free and:

PGSCAN_KSWAPD                 : 162,406,932
PGSTEAL_KSWAPD                : 91,233,588
COMPACTMIGRATE_SCANNED        : 6,542,604,811  (kcompactd: 4,041,105,566, 61.8%)
COMPACTFREE_SCANNED           : 541,265,798    (kcompactd: 348,448,520, 64.4%)
COMPACTISOLATED               : 174,688,832    (2.67% of migrated)
PGMIGRATE_SUCCESS             : 100,824,439
PGMIGRATE_FAIL                : 2,022,069

So seems in this case, compaction fail rate is quite high and we
have really many scanned pages compared to the actually used size
(about 1G).

> 
> Basically, I think we need some form of throttling to prevent
> kswapd from freeing more and more memory when there is already
> plenty of free memory, yet compaction is making little progress
> toward satisfying order-9 allocations.
> 

Yes! And I've read your and Johannes's previous discussions. It
also seems weird to me to keep reclaiming even if there are
plenty of pages available there. And it's quite tricky to balance
between that and concurrency...

Looking into shrink path in kswapd,

	sc->nr_to_reclaim += max(high_wmark_pages(z: zone), SWAP_CLUSTER_MAX);

I think this is too much, for this case. So I think maybe we can
still reclaim for scalability, but reduce its target. At least we
should take reclaimable memory size and free memory size into
consideration, and rescale nr_to_reclaim.

The check to restore sc->order below can be relaxed as well, if
free pages are sufficient.

Thanks,
Bingfang

> >
> >         /* better to run aging even though eviction is still possible */
> >         return evictable_min_seq(min_seq, swappiness) + MIN_NR_GENS == max_seq;
> >
> > I will give this a test later and share more findings.
> 
> Thanks,
> Barry
