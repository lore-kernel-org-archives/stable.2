Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923F1891A9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691508; cv=none; b=iJ8hR1co9iK1/K/SQcCRk8CoKOL1dEyX1LqxcubRLYeFZts+At0EdWXPE8m34mtPKD3APQzwBZRlAygY0p4Pg4plMfDx5B2UH03wt9J222ys/C8E7EZ8MJdPjHRQOJLRYmhY+k/FUZNHvls1FtKoLND0kTgR9aP5CGZfF6UcHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691508; c=relaxed/simple;
	bh=5gvFEqbkiiTA7FQivxZyuIoOZ8BI2pX49LbcCYDPnVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmUkC/d1xuxrIfStlUE+spPp1LSZoUZixvFX+r9u4wKxYzonCJlouYctH5S1jVKYjOoimZ0oFwdi/w7siZ9Bo/TK6h/KIz10YbFI9bZJ3uVg0vu7qLS5wHeNshaurZ+1BlBOP2k9s6ET/HqplHT3C3x1iNQ0K58ev65FaypEQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBJ23xMd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBJ23xMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790691506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbXDTdZnaMARV0PaqG68M0h00pQ3SsjxJmf4zOowgA4=;
	b=CBJ23xMdQo8bc38di2tTw9U6gvu6mi584ndVh+mXCaiiK0xcyU4jDF+VHxVcvJbzrKqTaf
	9VHuX2HCS3jLDLaOmJvsug99vfq5AlHF6W39xWkQcQ+JygYsy14DeOUPHGIfD7UtJwBVM6
	X99fB5DhbRhPBAK5A7iZbuWHAxYg+nc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-1E2aK-mLPpSo_3tL_hPNLQ-1; Tue, 29 Sep 2026 10:18:24 -0400
X-MC-Unique: 1E2aK-mLPpSo_3tL_hPNLQ-1
X-Mimecast-MFC-AGG-ID: 1E2aK-mLPpSo_3tL_hPNLQ_1790691504
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ae8e7e546so853833685a.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691504; x=1791296304;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbXDTdZnaMARV0PaqG68M0h00pQ3SsjxJmf4zOowgA4=;
        b=JgXmWKoZSxSQQexR5Im1VuBmtL/rIdNeMjB5WFOfSXjU0/QW53PWhWaZUp0jq8jWeE
         yNznbhvkufeXk9z/4MhxUClmqBWTWfHAHqC5CnZDnZB2aHt+S+LnEsiPgd5/CqCZQikG
         4iVPHxMHXr/cKB7tVOj1WZ94AzPiFiYo7kJnUZyzKKxdrCZrqXr+r5eWy2OybB/kBOFD
         dQmnzq9MwxFszcZguh9xnzNi1RZ1ReGNtIbpMr8KarBjLoowi62O0aM9rmy6P/Em5zTk
         mNXa2oBEjmYEYieUGO1XmfUvcDvHKLoaVCo1jNphCOwgg9Z9VrENrlxPqSC8ImTiZ5Zl
         jgeQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1bWCMzhT/L/AeEME+SO1PsFCqkMbYzCC+iY2YA9RPewQxtujMkqngTfRbz1SRhC1HyKOjaxc=@vger.kernel.org
X-Gm-Message-State: AFuF++mj5Aj/l0VbDlSliC2VzDJsXwg5tR7y0mgMVDzsz/wV/raogebl
	5fu0L1msha02+WiUjXIOWvLiLIj+/rZbom/e1LtdIARTotfdzXARufgE9aZCFzSmAOHFZdBF3uI
	bBfG2VlkMR9xAdByJOgr8wl7BbQbFdld0KaexTmeU9mTM0EvWYPAsmvsAE/35b7lMfhMx
X-Gm-Gg: AYBFou3q8W2++3C3aW6d/PdqREZXDSUygL75dHnuXYH92VlmAuE0UGrc+xksWLC0zO8
	xJVxRza1oGkVhJyLfkHS5vzYbZ2GPbTqJR0/8aJx+nzeSujM8Z3Lakj1pnVCcJbp0z3ZnUzf+0q
	Z8xIMRMz1JUhPpgjXnyCtZMUjbntzASibeB9A914xTwtXOcF2oLp/0fU9aM5gg8rWx2Db1Nwu+F
	0MpCwzRjgvAH/Vb3kq0q/9efgYk67zJelte1bhMkoMA5m15r73v9VBSaqE8JCiPNX5PlBfm7ejV
	Ub33ro2FRg2pNlMlsKIwGx4ZUzJTAfiMtgkNIlBrBlRaG81n9T8lLDgYcFkrsC1QG62zchSx4bd
	peYY=
X-Received: by 2002:a05:620a:404c:b0:939:31b5:4e08 with SMTP id af79cd13be357-93c439c33fbmr2664002185a.0.1790691503758;
        Tue, 29 Sep 2026 07:18:23 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:939:31b5:4e08 with SMTP id af79cd13be357-93c439c33fbmr2663993785a.0.1790691503101;
        Tue, 29 Sep 2026 07:18:23 -0700 (PDT)
Received: from [192.168.2.110] ([142.172.30.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a4587sm400548285a.7.2026.09.29.07.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 07:18:22 -0700 (PDT)
Message-ID: <cd4c16d1-d23e-4321-8f2a-6754294b74b1@redhat.com>
Date: Tue, 29 Sep 2026 10:18:21 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.18.y v2] selftests/mm: hugepage-mremap: fix mapping
 alignment
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: rppt@kernel.org, sayalip@linux.ibm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260928130916.231112-1-luizcap@redhat.com>
 <2026-09-28-2-daily-reply-0006-re-hugepage-mremap-alignment-6-18-v3@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <2026-09-28-2-daily-reply-0006-re-hugepage-mremap-alignment-6-18-v3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 6:39 PM, Sasha Levin wrote:
>> commit a914785f6349da754e1226420bf4e51961956769 upstream.
> 
> a914785f6349 ("selftests/mm: hugetlb-mremap: add setup of HugeTLB pages") is
> Mike's commit, but this patch has you as the author with only your
> Signed-off-by. Could you send a v3 that keeps Mike as the author with his
> Signed-off-by, followed by yours, or otherwise makes the provenance explicit?
> 
> The same applies to the 6.12.y posting.

My intent was to explain what was being fixed and why and, as it's a
partial backport, I decided to author the change. But I'm keeping Mike's
original changelog & authorship now, can you review it before I post?
Note that the subject will change as a result.

"""
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 11 May 2026 19:28:25 +0300
Subject: [PATCH v6.18.y v3] selftests/mm: hugetlb-mremap: add setup of HugeTLB pages

commit a914785f6349da754e1226420bf4e51961956769 upstream.

hugetlb-mremap test fails if there are no free huge pages prepared by a
wrapper script.

Add setup of HugeTLB pages to the test and make sure that the original
settings are restored on the test exit.

Link: https://lore.kernel.org/20260511162840.375890-42-rppt@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Luiz Capitulino <luizcap@redhat.com>
Tested-by: Sarthak Sharma <sarthak.sharma@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Liam Howlett <liam@infradead.org>
Cc: Li Wang <li.wang@linux.dev>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Backport-notes: this is a partial backport containing only the aligning
of 'length' to the hugepage size. The hugepage_settings.h include line and
the hugetlb_setup_default() call are omitted. Without this fix, the
uffd_register() call always fails on arm64 with 64K base pages and 512 MiB
default HugeTLB page size causing the test to fail with the error below as
'length' is 10 MiB and not aligned to the HugeTLB page size.

   # -------------------------
   # running ./hugepage-mremap
   # -------------------------
   # TAP version 13
   # 1..1
   # # Map haddr: Returned address is 0x7eaa40000000
   # # Map daddr: Returned address is 0x7daa40000000
   # # Map vaddr: Returned address is 0x7faa40000000
   # Bail out! ioctl-UFFDIO_REGISTER: Invalid argument
   # # Planned tests != run tests (1 != 0)
   # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
   # [FAIL]
   not ok 1 hugepage-mremap # exit=1
   # NOTE: These hugetlb tests provide minimal coverage.  Use
   #       https://github.com/libhugetlbfs/libhugetlbfs.git for
   #       hugetlb regression testing.
   # SKIP ./uffd-wp-mremap
]
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
"""

