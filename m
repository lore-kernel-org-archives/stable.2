Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC9279DCC;
	Fri,  7 Aug 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094931; cv=none; b=JeB4/hUnnPbTJ5JYBU43YInH/RE/0jRTxDeVlUvI0ZJlYpJoX/U1wEcgRraAtcdo/mXnNc1SO0yvT5v/4HzmXLhMVk2IxbiL39uIWA/T9iq5kYkYUfqeYlpZP1sObezylfvKXFdXKCh9/8msVjKvUap4MuR3nh0PRSaVzSJC308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094931; c=relaxed/simple;
	bh=b6Er5ShqF/b0yGY/KHK4ytFPtQPRNdyiktT0LTKIP0E=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Oi6d6aa5cOdyYIMVGQ7nv6bdnQbnPHsB/ADQP9NUacbB94apdoeJLw+u2J9UMCTP1blyNfqIYnBEOuCf63PDlNxrQ283F/eg6tje5uBPmCae68/RE3CDS3IcZoZ3J7a7swQX5frBP/rtcgRBz40ep9b2MR43nhLuoYbKYqxPFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JxRLzjrt; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JxRLzjrt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RFHzGwHdwARcBeZtvE1HMWPkjaYSc15ZUyxUDfzZkdU=;
	b=JxRLzjrtQ2gJGX9brEWGeK9O+LDHpICyegLWadHBXppn3jg2A1OzoUUGhE6+fPKql6mqe68JP
	07LOgFhQreBTpV27hRCFy2i/ez52k561oyJ14dLLDoaXLgl7i5DsOD9EhXskbarTWvVp3+hT9DS
	t4zamR1OA+d9X50TeeXwuqI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hGdq14t5szmVXX;
	Fri,  7 Aug 2026 17:18:05 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 98C5C4058A;
	Fri,  7 Aug 2026 17:28:39 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Aug 2026 17:28:39 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Aug 2026 17:28:38 +0800
Subject: Re: [PATCH] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Li Youhong <liyouhong@kylinos.cn>,
	<stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
	"Nico Pache" <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
	<lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Wei Yang <richard.weiyang@gmail.com>
References: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b726c265-eff3-f185-8eab-c2a9a3bdc77c@huawei.com>
Date: Fri, 7 Aug 2026 17:28:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/8/6 19:14, David Hildenbrand (Arm) wrote:
> hwpoison code can end up calling min_order_for_split() without holding
> the folio lock. There isn't really something that would prevent
> concurrent folio split. Consequently folio->mapping can get set to
> NULL after checking for "!folio->mapping", and if the compiler
> reloads folio->mapping, mapping_min_folio_order() would try to
> dereference NULL.
> 
> While very unlikely to happen in practice, let's just enforce that
> min_order_for_split() is called with the folio lock held. We can
> significantly cleanup the calling hwpoison code, and just get rid
> of try_to_split_thp_page() to hold the folio lock for a bit longer.
> 
> Just work on folios now, which further cleans up the code. We just
> have to be careful about doing the page_folio() after splitting, which
> we have to do already either way. Do not change the way we split for
> now, this needs more thought and should be done separately.
> 
> Cleaning this up we fix another issue: in soft_offline_in_use_page(), we
> would currently have leaked a folio reference.
> 
> In folio_split(), document and assert that we need the folio lock.
> Drop the questionable VM_BUG_ON_PAGE(!page_count(p), p) check entirely.
> 
> The folio->mapping problem was identified by Sashiko, and Li Youhong
> reported it by sending a proposal fix.
> 
> This likely does not really warrant CCing stable, but I expect little
> conflicts when doing the backport, so let's just CC stable because of
> the refcount leak.
> 
> Reported-by: Li Youhong <liyouhong@kylinos.cn>
> Closes: https://lore.kernel.org/r/20260804035828.2684059-1-dayou5941@163.com
> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM. Thanks David.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
