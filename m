Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E8313547
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342449; cv=none; b=Vsq8yb6LDMtM30fkk4BPzmvR3ZhYX7VjgrrhzhT/RW0Br8T/vjFpaloOHG/2HhjltNT05q38th1hQuAbU+HaLNZBgFYnSyF3cfpLSsAbjN1pIy3T3U32w/NhkImZwSIvyIf5A/gBtEn5Yykehq7FAFTjSxSFAZDd5wS2h3W8zHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342449; c=relaxed/simple;
	bh=yu1rVqADOBSGTSSCeXaUu4pqPY5guKzhnAS2O2ZUtec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQqZusbRipV4MlANgr0vI8/GIeQ8psedC6CR3kOIcAOXCYG/uUF7rSQ5MZYVb9HIJOG3QpasRju8frhbvsnhUSejbDnowv3QRLBp9Hr2+uBbsoGErd9SO49a1zcDspjqCrJLJ78cy4HP9ss0/IZQt9GxvZeS7tmy0VKk/JECHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=PSfd0VRm; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=KKqT8rAE; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="PSfd0VRm";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="KKqT8rAE"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DMZ1oK895871
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CfiP
	tIpaVHaFgHCxzYZpBn2tB3324rBaeeRf+dOQHKs=; b=PSfd0VRmn9GZFlSpJeog
	S5dgc3N4oV1hg867SEsh5JrtaxyJMmB1h5o9bY+OFMD07wd5WLANakrU8L0DRrOJ
	G0EFeXRbk3i689WWSVRBaPtm4pTNh+OtnL/Nfube6B1ZRB9HkCmqh62NVe4BqhNG
	v+xm15X6pKcMheiUfx/BdnuhsiiulQ2v2HbOU6zCYfsEWDn112E5aD0c9FZlVLm1
	CPRAC0hsw8kQTkhKbuoyuGtAyn2jDK54CEYM9Ayjan48SPgyVXgk3VF/CmsRevgX
	NeYbX7Fj3xrMomScKOMSPbIFQx9/rgP0fU4Wgpbku+xZ3fpjIj0GRBjpgcX82mS6
	kQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gp0qmh4ug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:34:05 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e7de22fddso61196346d6.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789342444; x=1789947244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CfiPtIpaVHaFgHCxzYZpBn2tB3324rBaeeRf+dOQHKs=;
        b=KKqT8rAEs+FWjNb5EsazeS2yY+G6BgNHSwWsrlbb8BJgNdppOlilEpqpXjDZP6FO7w
         tRniwnun3aqTUtDYbQtj+57h3rY4fButgqc0DuEaCtPuM62k6O9VNRcFsm+QZ3s/O1Lm
         AEdF9qsfv4g7M9xlhwBRm19YuXpZboUtg8pcIZItXJEk4CSx1YAJuqCPYJCFmYbnzP87
         GA3POR5ktZrzD+p4jWUYksn76LifevvpWlDmdw9YKMUBo99IIqj3URfm23I5Mm09HwYo
         0zY/T1Sy3lkljh7RMp9UK8cdaAP+Tr3azl7oaYhxzYrQul6t9yBjNb53QwQut2uSGnNx
         JUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789342444; x=1789947244;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfiPtIpaVHaFgHCxzYZpBn2tB3324rBaeeRf+dOQHKs=;
        b=k14/kHgJckZvnM2TLbTsvnKoHkc7qE7QBzRCzNvlpzqXJEyrlNb5ExX0mCClPqQuoE
         dPMUM/I3DHVrrMs7brOKIafAX58H4gzfsMLkzsrh2M1cKZxHrUmr85TcNjFcl9VVEY6K
         JptvW1hA5+dGlVbB0GvSQSJ9sjDXPi/dypYzRI9uffqfTfRVrmw9j17XNpAG7PE4jkGP
         BrdzkTeiWksZA66hX+fN2G83839IVgHRNtv1bDCfLhw64CKnjSBwXUE3qlUZNuHAGH58
         1TA7u0iqzaClCVslQs3w6CcUEmCMcFAzBvgN9c0O+G18Ay6OEk7AX9PvEXe2y5zuvfab
         Zngw==
X-Forwarded-Encrypted: i=1; AKwUvBx6FnQ1hc7swIcfMtE9bV2v5Wha/bAgBBAgd5f+rwJIBnN2/G5L1Um6WLHW9/lqxst5AYCUAr0=@vger.kernel.org
X-Gm-Message-State: AFuF++mXyJxLtOjaybZFxUUpC3Z+XiMFMlNwHMfLVG36S9ZDvz9Z20Hu
	PIePUj5+kznklgV2DG2zrVIWB+ryscULs8gFyvUgjbcmkoWyOB199pUxBNrprt721WOVV2hg5dD
	MX1BRp6hhYhbnjXrhXaccDllrCVkH4zjAfPcHUutCKMRp+TNtZNjFNg==
X-Gm-Gg: AYBFou3bcxTu5tum2XV7Rnj7jJwHlzW1eh8FsIE4Zl0rOEKAg2JAwb1cjchSMEvKBRb
	Tdiz/220lzZci3QtkSYLiAHhmCJzcSEwWLB35u2vKoDvZf4VCkDtUqVNs6bjDU7Sa4gxbiVxftw
	EttEzPq9lzwFlJ/YMdm97nz/L4Apu6+4nKYELSQ4hXWMTUX9TYkPv5t1KWLNwz6Pabdxsty3f4J
	l3B9p7zOjbXuGCiWFnVLeLhxfTKIu8mC5U/TWvr710HZrnoc2SSUpUC5kRVbho6VwlkxHiuGIXJ
	bBY7edVHirZIdYT2MsDFrQNC3YuDUwVLNFHYtvI9hsZVz4uQvC3tutyveSg1S0H8EkTd/gQQjYV
	aaUYaBwFb4Q2JkavEtebzPsQIAx8pMD6EaQVRSxz3XAX+38/B4G2HUzwO7g==
X-Received: by 2002:a05:6214:319b:b0:90c:5947:7e60 with SMTP id 6a1803df08f44-9122e4ce87emr5954226d6.4.1789342444476;
        Sun, 13 Sep 2026 16:34:04 -0700 (PDT)
X-Received: by 2002:a05:6214:319b:b0:90c:5947:7e60 with SMTP id 6a1803df08f44-9122e4ce87emr5953806d6.4.1789342443979;
        Sun, 13 Sep 2026 16:34:03 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-179-215.net.columbia.edu. [128.59.179.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45adbfsm80697456d6.13.2026.09.13.16.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 16:34:03 -0700 (PDT)
Message-ID: <65a2c7df-0d2e-46de-9580-01e9c35a7e32@columbia.edu>
Date: Sun, 13 Sep 2026 19:34:02 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Barry Song <baohua@kernel.org>
Cc: Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, axboe@kernel.dk,
        trond.myklebust@hammerspace.com, jaegeuk@kernel.org, chao@kernel.org,
        qiwenjie@xiaomi.com
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
 <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu>
 <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
 <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu>
 <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAGsJ_4wj6XvPB+QF+_X1BJ_8Y2sZEEFAw6RaJJz-cHaDWLkxaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfX6nsRquZko+sj
 fXlJw/CkE7GcA3Dp6kO6guugwEdac2RvLIr4PUq9zMQuNG0hqA68gCI5xBDGok0KzMifm4cpN7N
 TkQy8EhAoPzk6cOm2jNXOOkwxmAz/QnRsGxShlvVTSZ2E+oyMX54
X-Proofpoint-ORIG-GUID: -bgIuKQBEPcXLGE7pfZFKnnLx-fsgRSI
X-Authority-Analysis: v=2.4 cv=EJ6TQFZC c=1 sm=1 tr=0 ts=6aa732ed cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=IeNN-m2dAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=xcoSihzll435I0Xx0lMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfXz9tUqUUOAkO7
 oMYnDdYPO6lqQ1Ap/K/QIB2k7QJcH4Hbl/iCU3A3W6voEKRUW9jo6hS3OoDhH+Svgd0KzKdxnsQ
 UWSOzCB4wZWAomqRzpUeRVrvWIP7J8bAs2/o7RkJZ86s0Z1A5oeWL6MQnlHoTzczON0tpwjGQhN
 ShhGraTqNbHzydRw/KiYFNr2bNrpBfwifNlP2jFjWKGfCE1abZ/CTzR8dZWgNTv+cCtVd70HCjk
 GTMcM1P0qTltSPUfx/agK2hu4w+td11DUo5ytrKphL8YpsNStit7oPDamTGH5dyn0atIF/a9G01
 p+pI2KVWS7zjjmnhNgNKccQ+UHtGR5ZJznVKErtam+t3jfwWXRl0n5Wa6D2iYT4dX3XfKqwggxb
 +HP7k4WaAd8yR7S2tDC6x0HpR/LZgWM4Li760tGzGNa63xc1jrzcdtib6oqySXuSmggxH4HFlja
 fEv75llVAV2tJIIT/KQ==
X-Proofpoint-GUID: -bgIuKQBEPcXLGE7pfZFKnnLx-fsgRSI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=10 adultscore=0 lowpriorityscore=10 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130337

On 9/13/26 6:51 PM, Barry Song wrote:
> On Fri, Sep 4, 2026 at 6:36 AM Tal Zussman <tz2294@columbia.edu> wrote:
>>
>> On 9/4/26 12:28 AM, Barry Song wrote:
>> > On Sun, Aug 30, 2026 at 7:59 PM Tal Zussman <tz2294@columbia.edu> wrote:
>> >>
>> >> On 8/30/26 6:25 AM, Wenjie Qi wrote:
>> >> > From: Wenjie Qi <qiwenjie@xiaomi.com>
>> >> >
>> >> > Fault-around can map ready dropbehind folios without going through the
>> >> > normal page-cache lookup that clears dropbehind. A mapping represents a
>> >> > competing cached user, but writeback completion can currently unmap that
>> >> > folio. A later mmap access must then fault it back in.
>> >> >
>> >> > Retain mapped folios instead. For a mapped folio,
>> >> > folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
>> >> > i_mmap_rwsem and may sleep. Retaining the folio also avoids this path when
>> >> > folio_end_dropbehind() runs in non-preemptible task context.
>> >> >
>> >> > Unmapped dropbehind folios continue through the existing invalidation path.
>> >> >
>> >> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
>> >> > Cc: stable@vger.kernel.org
>> >> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
>> >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> >> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
>> >> > ---
>> >> > The mapped-plus-dropbehind state was reproduced in QEMU. The patched
>> >> > kernel retained the mapped folio and continued to evict the unmapped
>> >> > dontcache folio. I did not reproduce the sleeping-in-atomic warning and
>> >> > am not aware of an existing report.
>> >> >
>> >>
>> >> I was able to trigger the sleeping-while-atomic BUG on current mainline with
>> >> some help from Claude. The reproducer itself is straightforward enough, but the
>> >> configuration was a little finicky. The atomic context comes from using
>> >> threadirqs so that virtblk_done() completes requests from the irq thread under
>> >> local_bh_disable() and the vq spinlock with irqs off, so in_task() is true but
>> >> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so completion stays
>> >> in the irq thread rather than softirq) and ext4 -o dioread_lock (so end_io runs
>> >> inline instead of on a workqueue). With v4 applied the bug is gone, so:
>> >>
>> >
>> > Thanks, Tal. Then I'm getting quite confused. Since with Wenjie's
>> > patch, we are no longer going to sleep for dropbehind in `filemap.c`,
>> > do we still need all the complex logic in the block device and file
>> > system layers to move dropbehind to a workqueue task context?
>> >
>>
>> Hi Barry,
>>
>> Let me clarify. Wenjie's patch prevents sleeping in a very specific case.
>> The existing in_task() check covered most other cases, in that it just
>> doesn't do dropbehind invalidation if we're not executing in task context
>> (for example, block device writeback completing in interrupt context).
>>
>> However, dropping the invalidation defeats the point of dropbehind, as it
>> leaves the pages in the page cache. If we get rid of the task-context
>> deferral mechanism, we wouldn't sleep, but we also wouldn't invalidate.
>> Wenjie's change is largely unrelated to this.
> 
> Hi Tal,
> 
> Thanks for the clarification. However, I’m still not convinced.
> 
> If `unmap_mapping_folio()` is the only place where we might
> sleep — where we might take `mapping->i_mmap_rwsem` through
> `i_mmap_lock_read()`, as Wenjian pointed out in [1] — we have now
> prevented that from happening with `if (!folio_mapped(folio))`.
> 
> So no mapped folio should call `folio_unmap_invalidate()`:
> 
> static void filemap_end_dropbehind(struct folio *folio)
> {
>          struct address_space *mapping = folio->mapping;
> 
>          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> 
>          if (folio_test_writeback(folio) || folio_test_dirty(folio))
>                  return;
>          if (!folio_test_clear_dropbehind(folio))
>                  return;
>          if (mapping && !folio_mapped(folio))
>                  folio_unmap_invalidate(mapping, folio, 0);
> }
> 
> Why do we still need the `in_task()` check in
> `folio_end_dropbehind()`?
> 
> void folio_end_dropbehind(struct folio *folio)
> {
>          if (!folio_test_dropbehind(folio))
>                  return;
> 
>          /*
>           * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
>           * but can happen if normal writeback just happens to find dirty folios
>           * that were created as part of uncached writeback, and that writeback
>           * would otherwise not need non-IRQ handling. Just skip the
>           * invalidation in that case.
>           */
>          if (in_task() && folio_trylock(folio)) {
>                  filemap_end_dropbehind(folio);
>                  folio_unlock(folio);
>          }
> }
> 
> Could any other operation in `folio_unmap_invalidate()` sleep for
> unmapped folios? Otherwise, it seems we don't need `in_task()` at
> all?
> 

So I think you're right about the sleeping aspect, but the problem is
that this still gets called from interrupt context. folio_unmap_invalidate()
grabs a number of locks in a non-IRQ safe way. Just at a glance, the
spin_lock(&mapping->host->i_lock) call could lead to a deadlock, since other
paths don't call it with interrupts disabled. And xa_unlock_irq() enables
interrupts unconditionally, which would be incorrect from hardirq I believe.

- Tal
