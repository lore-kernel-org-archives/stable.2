Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299324;
	b=OtaWq3SBcgXTMpe90QZ5ZGIne9nmDfL2dGZPNeZmVIqi1a7uXbrho56/cSYWlUf9MzST
	 6F6HjjAVWqJFqWBlO1dvHXYwv/jhRWzHP2tui9EtfjqqjsexLgBZK/Vd5u8vIjKYmzMYd
	 y/5Yqor+iWYn0R7BgzpI3C7cj61veXI4DBXnSaXj+UgIhKg+/ChoAKXFJ5QrQIew0kRfO
	 SPwm3kps0nlx7hy1bUZOrdMg/QBH1WkBu99qzgVE1HB0BCpsuWQ9+0XgK6NnO9lFDnUEX
	 pUr4eU47fxBKKaqR/eCiIUHZGk3G4ZS5EO9TkNbiNeiR3NvpI2o+O8KO2WXv5e3xnLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299324;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=QAC/VM4j0azMzjRmu/qDzPNqA1Z4LRzGGuurxGYzqlU=;
	b=ONH4aL2PCFIgKR/g8SSOha3hOm+Z+U9khOTUD8xlyPbcWZ1sW+YLkHjkS8O7m+Lx+LZt
	 eRyjkIlzH/qkojjElYQl933v/hu+YGmt15vQfP4EXdkFbCG+TR6iVaNV++/saX3PF8IQm
	 W06TDhywfNc7NvqI0sOl33JbsUhKkItntCmKnG9oi/vV+euS7iNZYLFmdid41B66zgQaV
	 GbloGXYo9qlbeMZQ/zcW1K9fNNV1tDegA0QvX7Tzu5QVo9wW06VxY1W4EmRGR6/Z5BwA7
	 QYosKUKdNg+2BZajiUqxRDx1368NjLLq4XqT3Kzrdmfm56x4kD0TWQp90BKPJOOlGzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.23
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EF606A31C;
	Tue, 10 Nov 2026 08:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jP0Cc6J3Qz1HBmG;
	Tue, 10 Nov 2026 16:28:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 85AFC404A4;
	Tue, 10 Nov 2026 16:28:38 +0800 (CST)
Received: from [10.81.203.42] (unknown [10.81.203.42])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0C2l12q1fJqWBcQAA--.5211S2;
	Tue, 10 Nov 2026 09:28:35 +0100 (CET)
Message-ID: <f1dc369f-d72c-4493-a591-e611d9ac6e35@huaweicloud.com>
Date: Tue, 10 Nov 2026 09:28:23 +0100
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
Subject: Re: [PATCH v2] evm: fix TOCTOU heap OOB in protected xattr reads
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <98d6c26c-3dc4-4659-8284-a7ab0629bb40@huaweicloud.com>
 <10660aa25fd9d868a391a1c092fe8b33@oss.cyber.gouv.fr>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <10660aa25fd9d868a391a1c092fe8b33@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:nRC2B0C2l12q1fJqWBcQAA--.5211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxuF43ArWfKr18urWkCrg_yoW8AFW7pF
	Z8tFWYkrZ0gFyIkr9Fyw15Zw10kw4DJr1UWr1kGr1j9an09w1S9FWI9F4rWFyv9rn7WFnr
	ZFZ0qF97CrnxGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATDWryjEw1CwAAs5

On 11/9/2026 9:05 PM, Jérémy Jean wrote:
> On 2026-11-09 10:07, Roberto Sassu wrote:
>> On 11/8/2026 12:05 AM, Jérémy Jean wrote:
>>> ima_eventinodexattrs_init_common() queries the total size of protected
>>> xattrs, allocates that amount, and calls evm_read_protected_xattrs()
>>> again to fill the buffer. This creates a TOCTOU window: if the
>>> protected xattr changes between the two calls to
>>> evm_read_protected_xattrs(), names and lengths are written without
>>> checking whether the data still fits in the target buffer. This can
>>> yield an OOB heap write that KASAN reports as:
>>>
>>>    BUG: KASAN: slab-out-of-bounds in 
>>> evm_read_protected_xattrs+0x15e/0x280
>>>    Write of size 20 at addr ffff888002c59bcd by task init/62
>>>
>>> Reject fields that no longer fit in the target buffer. For xattr
>>> values, also check the length returned by the copy before accounting it.
>>> This also handles the case where a size of 0 is treated as a length
>>> query.
>>>
>>> Fixes: 8314b6732ae4e ("ima: Define new template fields xattrnames, 
>>> xattrlengths and xattrvalues")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>>> ---
>>> Changes since v1 (after review from Sashiko):
>>> - Handle the 0 case.
>>
>> Hi Jeremy
>>
>> I already sent a patch to the mailing list to fix the same problem (it 
>> is similar to yours):
>>
>> https://lore.kernel.org/linux-integrity/20261029142707.2602008-1- 
>> roberto.sassu@huaweicloud.com/
>>
>> Thanks
>>
>> Roberto
> 
> Hello Roberto,
> 
> Argh, I missed it when I prepared my fix, and even wasted time preparing 
> a v2.
> Thanks for the pointer though, good that this will get fixed.

No problem, thanks anyway!

Roberto

> Regards,
> Jérémy

