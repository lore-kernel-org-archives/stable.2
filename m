Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969098;
	b=qJoUSRvPGtoyn/y4dPLUiKJIeNlqCvjp9FAO3E9MeyFQXBLk17s83gri2TnrEIZteweQ
	 WZwqbTvjSqrInwnXuJxAElBtW1E4RAXZS8nvFbzKDFV80RHmGJshLOHOl9s7z6MJoGwSq
	 6GqORrHvUu3VOq0E49HcKzPXz5RckV2VSH2PYly27zr6wtvUjMwFcTFbNFtTGwmRo6mdO
	 PyGxdU4VnrAoZzEu3SMuqFi0efflg7G4SZXQdhFjM+5WpsOv3acYWOnxS4UdAcFGvJvro
	 mGKM9oOl0F1qiCKcv/XrVGnh+zNlsZWQu02bxX5/GhRfqTPM2i5ZUNuKWSHsWeEYE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969098;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=u9deMS9SHp1v8TdPFiTn32COaQpqdBL7sf3125pu2O8=;
	b=r+Z4Aznu+563RBpAyErlUto5N3+m5/EsYKurwmpUGMSN1EDXi9fPfdngb9u3C/+5N8mZ
	 ytcHXgtqDhCieYl7xlCogzFB1ShXmZyJRiagI68Q4McCquWHK5YN4dlgBoa7zw1d2QUhx
	 NyYv8reqtXq4PTnVfHyVJY+lp5j63kl4H05b5Y8B8s6IzWUdT20c+IdkttIU4aGfXbbpX
	 EmPRSogK5DAQBHBiYnoJgkSpczaJG+GFxonBYds2NhXjPA8LPcyQCdIVnKpPM8tYh6Sr6
	 6KjzRr6uGnyZB5b/eg2bzIGV58lIntTfEhHUMh2S5SlMer5EJp8dcps5r1adc2ey+Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UjOrv2qw;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BD606A32A;
	Wed, 18 Nov 2026 02:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E57BD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UjOrv2qw
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794969088; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u9deMS9SHp1v8TdPFiTn32COaQpqdBL7sf3125pu2O8=;
	b=UjOrv2qwlPp8bupeV1io9OzlzRxXxYv63RuAzwLyToGh0N1HTgMvbR9Ej0CEMk2kdhSVB8p5GACRboeqRX5sIg/iufPTx8HwjjeOaAbyoRz6tjAklPAsaZcRKIpd/PMy3XJLvnBhR3/IeZUhothZPRib+OMQuzVnkPBOWW449W4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF.332t_1794969087;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XF.332t_1794969087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 10:31:28 +0800
Message-ID: <7a692c99-e023-420b-832d-0727fb2f2d74@linux.alibaba.com>
Date: Wed, 18 Nov 2026 10:31:27 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: limit forced anonymous shmem huge orders to
 MAX_PAGECACHE_ORDER
To: Jingyi Sun <1045704958@qq.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Luiz Capitulino <luizcap@redhat.com>
References: <tencent_1B8BBAF215484255F04168752D9BA778EE08@qq.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <tencent_1B8BBAF215484255F04168752D9BA778EE08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/26 8:16 PM, Jingyi Sun wrote:
> When the top-level shmem_enabled knob is set to "force",
> shmem_allowable_huge_orders() returns huge_shmem_orders_inherit for
> anonymous shmem without masking it with THP_ORDERS_ALL_FILE_DEFAULT,
> unlike the other return path at the end of the same function.
> 
> huge_shmem_orders_inherit defaults to BIT(HPAGE_PMD_ORDER). On arm64
> with 64K base pages HPAGE_PMD_ORDER is 13, while MAX_PAGECACHE_ORDER
> is 11 because of the xarray split limit. With shmem_enabled=force, an
> anonymous MAP_SHARED mapping can therefore get a 512M (order-13) folio
> in the page cache. Splitting it later, e.g. on swap-out from
> shmem_writeout(), triggers
> 
>    WARNING: lib/xarray.c:1051 at xas_split_alloc
> 
> and the split fails, so the folio can never be swapped out.
> 
> This is the same problem that commit 9fd154ba926b ("mm/shmem: disable
> PMD-sized page cache if needed") and commit b66b1b71d7ff ("mm: shmem:
> avoid allocating huge pages larger than MAX_PAGECACHE_ORDER for shmem")
> fixed for the other paths; the force branch was left out. Mask it with
> THP_ORDERS_ALL_FILE_DEFAULT as well.
> 
> Reproduced on v7.3-rc2 in QEMU (arm64, 64K pages, -cpu cortex-a72,
> 4G RAM, zram swap): with shmem_enabled=force, a PMD-aligned
> MAP_SHARED|MAP_ANONYMOUS mapping of one PMD size got a single
> PMD-mapped folio (ShmemPmdMapped: 524288 kB) and MADV_PAGEOUT
> triggered the warning above in 3/3 runs. With this change: 0/3.
> shmem_enabled=always and 4K pages did not show the warning. The code is
> unchanged in v7.4-rc3 and in mm-unstable, but the test has not been
> re-run on those trees.
> 
> The issue was found with a research static analyzer for
> cross-architecture dependency bugs and confirmed with the QEMU
> reproducer described above.
> 
> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
> Cc: stable@vger.kernel.org
> Cc: Luiz Capitulino <luizcap@redhat.com>
> Assisted-by: LLM

Please drop this tag.

> Signed-off-by: Jingyi Sun <1045704958@qq.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
