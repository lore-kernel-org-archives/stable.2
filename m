Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.66.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599130;
	b=nCvcPMn1zsgXOQa5dJACNnGiMApRIKDMOw54zOhYoMWqdonZeBj7LSPlPBNHn8J01gYJ
	 d6ITWN8X3/rY/DPTKv33sIvx+f6uVrRrsrgOCFwwFgglqjAZLGSfyD9DqGAFcH2m1WnXd
	 2dnX/IL9GQOopfzux8Mu9Gs79kG27zTTiJ6cbhqHCinYHbslMthklNrLs5qviRAUILUqS
	 kB9Mf7lNgj2lNWOUAnyRvLKRm0M60j47nkEKdbDEghe3WMJXkft9Vcyyok+M7u118rFOt
	 SmLfmHdBmzEdw1Sm2Yhj1UQaYr3BtYrMW7Skc5mKZd9pWQGH55HhNGwgUgKffCDdyqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599130;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Authority-Info-Out:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-JNJ;
	bh=qo1g4G9jFo166r+3Fo9N5fuvXCpK0cNzrzPppaY4EZo=;
	b=mV84LMIH2jzD2frx1e5thCaxUsGcAqsALEogId67cakLC/PamyKcVJ2pNwB4bCQLsoGT
	 ovytQMP2/67FtGbnwYD2oeDi1Sd8HLalfNEZh6MrdixutYHwXAqoywgJ+LVczCWkIyJo8
	 iwV2exNgBwhCYR0IjrcBPyADlLlKoP3mSM457iQulKUZnH8/OyHLxfuD3zW2M329B1/Gl
	 oPLACVCkXGnaMNCP3bCBQRG61Rck4wEDomocI25MuzT7M8hMUYforTVgWRV3kQV56Epk4
	 K7K4H6Qo6wFXNokq/GoIe/gPkj07dVrMXIm6koiYCTU7PKfA0QTzAJtJoqFIkjqft0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=fGcX4iiG;
	arc=none smtp.remote-ip=57.103.66.151
Received: from outbound.pv.icloud.com (pv-2005f-snip4-11.eps.apple.com [57.103.66.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E8606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27E8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=fGcX4iiG
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-8 (Postfix) with ESMTPS id 947011800198;
	Wed, 25 Nov 2026 09:32:06 +0000 (UTC)
X-ICL-RepId: 01a2120c-5008-7a53-9b20-f0c7cff97bae
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1795599129; x=1827135129; bh=qo1g4G9jFo166r+3Fo9N5fuvXCpK0cNzrzPppaY4EZo=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=fGcX4iiG7DOeJ0CajBkifqjFwlGd37BhrbrgUKfQUh8n0XMNFKBrx5fmqW4kJrLclEKKam2pCqOstzD3x/2xifU5LdPRXuGJ/MHQFg1s3fTWi5hQK6zCXGL7NCSg1wida70A9BqCDeKwPkV2R22Im0Z0LguIqGRcgaHSOqNV3AoY/+XvUHnZwoHH8k0+O0ZojJZx5v+NDpgBWxZu0oojH00Tz69CRa1G9DmQb5AMQFLleavlZu5tAWFGm9m0VwEK6e+1dkKPaJ+4p8y5DOcBA28VN+gMFGTtXNSmtw+Fo1zBbpWbawrFDAw93dk47oI2L1Me+0x1q34NbFSJrGljTg==
mail-alias-created-date: 1772519804199
Received: from lima-default (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-8 (Postfix) with ESMTPSA id A83AB1800181;
	Wed, 25 Nov 2026 09:32:02 +0000 (UTC)
Date: Wed, 25 Nov 2026 17:31:58 +0800
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
Message-ID: <awarDrT/DT7tQu+U@lima-default>
References: <20261125-fix-mglru-kswapd-age-v2-1-4cc37437af9b@tencent.com>
 <CAGsJ_4z-UdXQg0LYqymEZdoHALPmAZC7eGcXbGad6f0sdjmkcw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4z-UdXQg0LYqymEZdoHALPmAZC7eGcXbGad6f0sdjmkcw@mail.gmail.com>
X-Authority-Info-Out: v=2.4 cv=MqbHeGae c=1 sm=1 tr=0 ts=6b06ab17
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=vu5NlEYW-o8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fajnDIswKVxD1YtQT70F:22 a=M9Sav1zvfn_GK7Wt-FcF:22 a=VwQbUJbxAAAA:8
 a=GvQkQWPkAAAA:8 a=xlM2Ei2ykzIjzGhbHIgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfXwxTrftwv/Tc6
 csrG9PqyqfE2bfF2Y6abmezyQFJEIsCJTlfbopHrFuORRjOt6rLzEE93BSmY1hoFxOjbcYTqqN4
 x/I3nqsDuHFevxXXAwRQvgyEzHkbSVjQzocCTnAu4MV3SJULn22+FfwN63slVPrxeKcD48QX4NL
 /5vPbR6G+VBg7Hi8iIujZXFuISZY0flmbqOp3ALGNsQHO6mloU7QauYuAx00naSbB3r/dAjDKhR
 9xAczaQW5OgNJ9dYLZYaxnXqoAdPtJo3Dm8yNiDU7cvi1KUDyhAMNfD+jIAm0yTneC9a9fdh2LN
 TRNtWBHfyNA5VD5s6AyOY0QTAGsM5XJp8cpy0/rRKbdWrqYMmohTllaleNA138=
X-Proofpoint-ORIG-GUID: niLA3Iup4mDdqm6hyrAuqLyUOOnPSeJp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX9YEiGwbP8jmw
 HrJ5PCD36ioCKAYHW0kMd9St6UXwxA4D+8xczCpPnzViNvvFye+iibmjjl6mB4+eq11QLtbouvE
 bTJH5IDyl27hRxSSVKuJ3oN2NcgA95o=
X-Proofpoint-GUID: niLA3Iup4mDdqm6hyrAuqLyUOOnPSeJp
X-JNJ: AAAAAAAB5cDsmzSC9ZfTQE37S/1cmH2rm5agffjPd3p2oMuVj1LMQ7aZm6r7N/dDgwWPFj
 v9b+7dT6uhVDxWkR/A8r4GVFaM1jSW4EJOd4W3veL2uVuPzHCrGRgLCTl9OI02bDhoDA8C
 I0oEk0YqoBT6/vahlWAhRE5xopJEL3HkzIblE+Yqmv13LZTqvZgJpWJQE+2atc+JoelrGr
 KH330CD2L4gglrMzTU08RTXfQpRelMJe1irYOlzB/S4f8wu4oG6kiNv99SrEIvwnNek933
 kPSwxKtRlf3lFGZsG/LGl+D3F69j5Zk94EDDltu1Ztj3VSBJSUWQCZqhxmC8xonfh3ro0S
 r9AxFY0tcZdzzDCVadwDwadxuLZJWwnuCsqZWl86Fb672El+xtBAueDsQg+aL1RE/rkmQG
 JVJ6d2cfTzpu7BEGoSDEtrKD849DRguH9F2VUyuodZIaNPth0OI3ZrZHx3pyw6O7Wdrm3V
 XsZo80QrRGdLinTOkFEV8yEhpHKtObTm3KZzBFujx0OHAIU7mSYFf0GsXic9UjoIjDS7e4
 hXJ75jB0SVYE1IKu4S8Y1uMPk6iLe2s7RWSk4coqj/Uisiz0i0Ki2q/HCwcgKF96klT0Za
 w2qHv+yhki1Scyrcs3VLKcrTktmVNS9vcqyVWg5j7l9IXrE1TdmSK3mV4yIW5xLJFRPMv8
 td6slm0wJHfdiZp7U+MC4I3dtxN611NFOFHr5hsQQjx5d/hTAfD4cLVNEVodD1oRFlAGMu
 f+YXzZ9U/bwYc+PJCfEN9pGlLPj8sO0eDI9YtqONmbT+Kv/CtMgWg7pGC6VDchp+0Xy3lc
 3n2jGJYzWS/d7tEb1FW4M18Ue37+tqvqDU9XJ60XUojM0nFRCY9t7mpEO2iXJ5n/6W6scd
 +/xY9fc6ByGXo0M/0NpK/gbvBSOTaqNJpD7Rm8LL+wyPo7inQq+86gKB3j9Bt0GzrVCvLj
 NzzlY4DSqG2E0C6tlsfu0IoAN88DGcqc9/iJPvGQygd/COSYvqCQqjtmJfTyWyPtcvjXFY
 EXBQloKny86XEsy0Or/sxqsuY21wBrm93oHB0cnyW31AfQ+ThnzrIXPg7BJcKtKGs8hsCk
 Bcin1o7Jt9hZRnbI1W3jRHgDsNF7bRLWhy11NB/dMvway3Gal+rNIohf925a5HTu4EKlSJ
 59dOEjOptqNi8XGDEt1c4D4dcBG/yuVoQ8Guv0QDTxzlzMJ3wrCMvGRTANzIUs0dKKagy1
 vrjhIrdDBUKV6qN7Ei4d8gLF8s1D+BDyE0hvzOAyFwlrP2JPAw59qQ+VlJbD/roGA7Lo3X
 GFCye5/LLpi7wlEdDrZ+xpOru3hi93eXEJCZEQkk/WyC/onfvljtOAQJy/OzyVMBm/ijDN
 jqV72F5rWztXMPUwXr29e2kGoDdrM+mZ6XUdd8MJavbLpkq+wYpZOpUNowkXnMqKgEk7/Q
 VMTe7V1aecBqnQszkAJLiXIuYxXAk5WGnJE3AJzOQHFUBahDGphOfB0mYwhpqrEDCFK1zv

On Wed, Nov 25, 2026 at 03:38:25PM +0800, Barry Song wrote:
> On Wed, Nov 25, 2026 at 12:32 PM Bingfang Guo via B4 Relay
> <devnull+bingfangguo.tencent.com@kernel.org> wrote:
> >
> > From: Bingfang Guo <bingfangguo@tencent.com>
> >
> > We observed that when MGLRU min_ttl is set and the system is highly
> > fragmented, high order allocations (e.g. order == 9) will fail and wake
> > up kswapd. It can not make any progress, while pushing generations of
> > memcgs so that they all end up younger than min_ttl_ms, repeatedly
> > triggering the OOM killer in lru_gen_age_node(). Then the whole process
> > repeats until all processes are killed and the kernel panics.
> 
> It seems we should address the underlying issue of why order-9 reclaim
> keeps advancing memcg generations until all memcgs are younger than
> min_ttl.
> 
> >
> > The purpose of the min_ttl is to prevent thrashing when all memcgs are
> > too young to reclaim instead of preventing fragmentation. So fix this by
> > restoring the behavior in commit 30d77b7eef019 ("mm/mglru: fix
> > ineffective protection calculation"), which skips OOM killer invocations
> > in lru_gen_age_node() for sc->order != 0.
> 
> I'm not really convinced this is the correct fix. It seems to work
> around an issue with min_ttl for higher-order allocations, but it
> doesn't appear to address the root cause.
> 
> And what about order-1 and order-2 allocations?
> 

Hi, Barry! Thanks for your reviewing!

I agree that we should fix the root cause. Reclaims triggered by high order
allocations should not push the generations forward too frequently. That is
really insightful!

> >
> > Fixes: 30d77b7eef019 ("mm/mglru: fix ineffective protection calculation")
> > Signed-off-by: Bingfang Guo <bingfangguo@tencent.com>
> > ---
> > ==== Testing ====
> >
> > Tested on a VM with 6 cores and 6GiB of memory, HZ=1000, MGLRU enabled,
> > min_ttl_ms set to 1000, and a workload that fragments the memory then
> > allocates 2M pages.
> >
> 
> So the real question is: if order-9 reclaim can't make progress, why
> do we keep triggering memcg aging and end up over-reclaiming?
> 
> > Without the patch, kswapd kills all processes and panics the system even
> > with plenty of memory available. With the patch, allocations fail but
> > the system remains stable.
> 
> I know, I know. But this isn't really the root cause, is it?
> Even if we avoid OOM kills, we may still end up with excessive reclaim
> or system overheating, right?
> 

You are right. Maybe we can start from skipping aging in reclaim path if the
youngest gen is still too young? And maybe for this path, min_ttl can have a
default value? Is that a good idea?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d891ae46baf49..7f9b14b772d14 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5136,8 +5136,11 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
 		return false;
 
+	/* avoid excessive aging for huge allocations */
+	 if (unlikely(sc->order)) {
+	 	int gen = lru_gen_from_seq(max_seq);
+	 	unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
+	 	return !time_is_before_jiffies(birth + min_ttl);
+	 }
 
 	/* better to run aging even though eviction is still possible */
 	return evictable_min_seq(min_seq, swappiness) + MIN_NR_GENS == max_seq;

I will give this a test later and share more findings.

Thanks,
Bingfang

> >
> > --
> > Changes in v2:
> > - Reword the comments to explain the purpose clearly. (Kairui)
> > - Relax the skip condition to sc->order != 0 for soundness. (sashiko)
> > - Rebase to mm-unstable.
> > - Cc stable.
> > - Link to v1: https://lore.kernel.org/all/20261027-fix-mglru-kswapd-age-v1-1-b1ffdec4ae52@tencent.com/
> > ---
> >  mm/vmscan.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 836f50814ffa..9fadc6f9da49 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4351,7 +4351,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> >  {
> >         struct mem_cgroup *memcg;
> >         unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
> > -       bool reclaimable = !min_ttl;
> > +       bool reclaimable = !min_ttl || sc->order;
> >
> >         VM_WARN_ON_ONCE(!current_is_kswapd());
> >
> > @@ -4371,6 +4371,9 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
> >          * The main goal is to OOM kill if every generation from all memcgs is
> >          * younger than min_ttl. However, another possibility is all memcgs are
> >          * either too small or below min.
> > +        *
> > +        * OOM killing for fragmentation is not desired. So skip this when
> > +        * sc->order != 0.
> >          */
> >         if (!reclaimable && mutex_trylock(&oom_lock)) {
> >                 struct oom_control oc = {
> >
> > ---
> > base-commit: a3d0117e02bfa1c3bb6c50e7afe42bbecdbb3459
> > change-id: 20261026-fix-mglru-kswapd-age-98390614c746
> >
> > Best regards,
> > --
> > Bingfang Guo <bingfangguo@tencent.com>
> >
> >
> 
> Thanks,
> Barry
