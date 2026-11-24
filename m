Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489913;
	b=iDXRYy5i/VZXlhpsFaqoXq3Ck3y2MTPoju1DyiKYeTpS0A+T/MT3A7PnurI9r9J8ZhFn
	 C2wDO5p1P6wZlBPDgkJWjkTADYXnGKI1ylOByPQP+xPQCvivdJDkH8ERh+nnTDuqibCOH
	 AGck/IrlDHWgZFWkbSgy1Gp6ik9ABudPn4YNVN+C2HgO67PMUo5ZxjzExNvtx2j63y5LL
	 PWe9XwftDXgAYFJWuA+99E4dpX0YW/yvZm/QKyMRv94cNqvISdrIJuAUVxNYiklVjZn0S
	 skGs53nI7WMmbUyi5Vl82yQu+vDIoMn5x75+OUKoSia/CN03S3AYZWcaE6GaVQOgSEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489913;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=2ZgqWwZi6y0m3JBXH+oDDQOBp9DTmzu1OxZuchkyzNM=;
	b=zJpVtI2aWxpnO0Bl7ymhFAP2OwPj31datH4sZcEmn/4tM+T1nrXnGdUU0jDwgUNmCpOQ
	 Hj4F7e/FEUDP75alvm9L8cxGD8B+vyVOUdLBf7a+wQTw1bu1dZ4D9lnwLFrHwWLwwcsVI
	 FyQENJzB3j32bLNYxM0KuQRZM8Y9jyffQkejJ83TW4CiQIiS9tRXXy8oMxhJW49M4vmat
	 Uo4jJ5GtzW/1Eu486YHTI2dG6gfEH/TWaVz9XKSLhYFf+PwJHOLEPm6Le2++9oInkFF5o
	 Ydh68FAa5VvIicbVk1cUu1wZkctElcdiu1mKb7Hg/2finH6wP5380Baxb48f78vpCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BZb2wHrh;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212ED606A31E;
	Tue, 24 Nov 2026 03:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BZb2wHrh
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2ZgqWwZi6y0m3JBXH+oDDQOBp9DTmzu1OxZuchkyzNM=;
	b=BZb2wHrhZ0+3hf+fCa70sfJb0yGBURbMoRCH9BAzZwSvu6Jkz89gfEzqn+ONfG9DyTftTGsaC
	w5F5leIcO66mWV/ey6ndbY/CF00BN5PQ/ZTZ2t0cTu39FgFPu6iELMKazyte2OcmP2L/yVzd522
	a0ZKQK4P1aJrmvwswqBi9mM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jYSWf3Z2Vz1K9Bh;
	Tue, 24 Nov 2026 11:11:26 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id AA66A40565;
	Tue, 24 Nov 2026 11:11:43 +0800 (CST)
Received: from [10.173.98.163] (10.173.98.163) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 11:11:42 +0800
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
To: Mani Tofigh <mt4022@columbia.edu>
CC: David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<tz2294@columbia.edu>, <stable@vger.kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
 <42a60f57-5323-f981-8ef3-2e5d67623902@huawei.com>
 <a87cbd92-0e07-4f84-9a6f-8db0b1778fcf@columbia.edu>
 <b0f30561-aabf-2bf5-2204-20907c40ef43@huawei.com>
 <08b18b88-3ab4-4681-bec8-f4564fe9f1dc@columbia.edu>
 <77680005-7178-cb1d-6e20-e23519839222@huawei.com>
 <56de516a-c895-44a0-94f5-ea7bc5bd3ef9@columbia.edu>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <53d2f7e6-581a-ec05-6dc5-59a892ace835@huawei.com>
Date: Tue, 24 Nov 2026 11:11:41 +0800
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
In-Reply-To: <56de516a-c895-44a0-94f5-ea7bc5bd3ef9@columbia.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/24 2:52, Mani Tofigh wrote:
> On 11/23/26 2:26 AM, Miaohe Lin wrote:
>> If P's struct page is past the first vmemmap page, the hwpoison flag is lost. In this case,
>> do we need to do something? Now that hwpoison flag is already lost, I don't think so. And
>> TestClearPageHWPoison won't do anything in this case. Or do you mean TestClearPageHWPoison
>> will always write even if hwpoison flag is not set? If so, can test + clear do the work?
> 
> 
> Yup, that's what I meant. And good call, test + clear works too.
> 
>> I think we can correctly clear the stale flag from the first round.
> 
> 
> Yes actually, so just this under Muchun's rwsem:
> if (PageHWPoison(p))
>   ClearPageHWPoison(p);
> 
> should be enough? I can do this for v5; sounds good?

Yes, sounds good to me. And some comments might be helpful. But do we really need that rwsem?
Could we avoid using that specified rwsem?

Thanks.
.
