Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145277;
	b=0gU5sN86qbecs+ayGhnsuBKh0SiMNMG8tEXy0hfbqwiYtz7cVieuImr+Q1s6bN1AlANi
	 mQPNmonWj3Ein8hdNXYbvgN0hre1VTNqGEBCtlLmStQfKTMlXQJeRyNCwaAiex7gJOu1d
	 /GLEBy6t/aW2da0nyC5XJ3Z5AkQka7QiaTaLvzXSln3SUmu3cpuhIG0WJY+M4oDk05H+4
	 LCHSpkJKNiSzZCIQRwWcEUTGlYg1Z4pqbXu1UqCYWikkItXzjuzI2E/nKT0Z7+x0YTl12
	 HY1Quz4TfxWDuJi77bGzVC3WqqbBgLF3Y2mu1XhHbhCc5xisztZso7LURTw1egbcdCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145277;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=+Dg095nuQm08w1mrGur5FXxR8nXjuDgQq1Pk8wkGwVI=;
	b=AcSFJs1cd/ZCF7/xStV4GFQsIaGev3OJi6u6fCkK5owCpkfO3sVuKtVLPt61m1EBlCB+
	 B3Kedi7X+K97gUBGJy0dV6wLqggSmIL1Bq1z22iSQIBio97UuN+GSSfiatj2tjVRQU3pm
	 HBhNviBrKG2Kuxc1GOQD+2um4Z8IIdEH66wvUc53ngg869TKQQlnXPpirSnU51wMWgAYx
	 m/nxBkY6ciVFzeG6WpUBoffyQHAfqRlG76dXV6Ts0fgOwDjfM0KxzA/xgFrTphAnZdyxp
	 q2KIcqzY836cxZlIu+aFfCrghbsdiggdeSTo9/PAk00ti7hrjr1ze6dHsoXaUWPezEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bJdtSXo2;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C9606A339;
	Fri, 20 Nov 2026 03:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5C9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bJdtSXo2
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+Dg095nuQm08w1mrGur5FXxR8nXjuDgQq1Pk8wkGwVI=;
	b=bJdtSXo2zsPNNAWZHoqmIPvvPsucTx4ac5NrM9rYFhJ0E8wOXluASdeBe9kfYY0AIPpR/asys
	c6ETQCvnJrDpYQn0VZoOBlmVN4JhsRkQKTs9M+QbLBhTOJfxKheQYpVyRjNfMRpDncLXZzA5RzZ
	a0FAogV0ZKyp4dOS0sOJPMo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jW13S68TDz12LHl;
	Fri, 20 Nov 2026 11:27:00 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 143EA40683;
	Fri, 20 Nov 2026 11:27:52 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 20 Nov 2026 11:27:50 +0800
Subject: Re: [PATCH] mm/memory: don't map hardware-poisoned pages in
 finish_fault()
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<stable@vger.kernel.org>, David Hildenbrand <david@kernel.org>, Usama Arif
	<usama.arif@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan
	<ziy@nvidia.com>
References: <20261119134236.3745231-1-kas@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a5c04d15-adc7-b7c2-fb1f-a68b0483fef7@huawei.com>
Date: Fri, 20 Nov 2026 11:27:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261119134236.3745231-1-kas@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/19 21:42, Kiryl Shutsemau (Meta) wrote:
> When memory_failure() cannot split a large file folio, the folio stays in
> the page cache with the poisoned page in it. do_set_pmd() refuses to map
> such a folio with a PMD, so that the poisoned page gets its own fault and
> SIGBUS. finish_fault() then falls back to PTEs, but maps the whole folio:
> 
>     do_shared_fault()
>       __do_fault()
>         PageHWPoison(vmf->page)
>           // the faulting page only
>       finish_fault()
>         do_set_pmd()
>           // backs off on has_hwpoisoned
>         set_pte_range(vmf, folio, &folio->page, folio_nr_pages(folio), ...)
>           // maps the poisoned page as well
> 
> A process that touches the poisoned page takes a machine check instead
> of SIGBUS from the fault.
> 
> Map a folio with a poisoned page one page at a time. The poisoned page
> then takes its own fault, which __do_fault() turns into SIGBUS.
> 
> Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
