Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB014A60F;
	Wed, 10 Jun 2026 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057637; cv=none; b=YbkeCyjPYYAS7N4wM3ehGfpUdWgkdG9kr/Q1fKgOjvpMf3R2IS8zFiwsdKaI+aT8gz+tYZuyRFe2Bjnm9mZ4in/DBZUWKtFC763PUeDO0S/v9N4CZ/gK2gclmDpK01lJAY93WogWm1xIfFy1JkcE9eqzaoHOFRTEFTAbNxXhdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057637; c=relaxed/simple;
	bh=ae2u6BF8XJgUTCq2YhqvZI42ZqIMm2FylYu08wE3rZg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N/sLMPIVOsKYFMbIbwi8bb6CT2fnqfKNAzyhoh1B2JOVDuuIcHDwc+IR2xr2hVD5OtqMQxqixUgGFp1G2FWSV1QfZ/Z5Ck8Ba4cnQdgvTQoqCxYk/HDB+WBYVrkIq0pNB8A+HHwsRPfCj3oy+o5c6LmWPp3Fwl8H3Hg9jKRIBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yxBYkWpT; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yxBYkWpT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ae2u6BF8XJgUTCq2YhqvZI42ZqIMm2FylYu08wE3rZg=;
	b=yxBYkWpTHpyuYvEwKM8EdFV3WOMW+QbryHov22h8OaxapdZbHRwv1wKZIfcchZsnAiS2LqD3O
	BvnbGGNXZikQYC2UNUEL7kSUNrE98AoxL2ZneD8avDpz/RnFtE2UulEW6EjT0yG80H9bY9fr6QS
	lI23+Sligm1AUm3/zpHonho=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gZpz90mrGzLlSZ;
	Wed, 10 Jun 2026 10:05:57 +0800 (CST)
Received: from dggpemf100012.china.huawei.com (unknown [7.185.36.196])
	by mail.maildlp.com (Postfix) with ESMTPS id C0CEF40575;
	Wed, 10 Jun 2026 10:13:50 +0800 (CST)
Received: from [10.174.176.103] (10.174.176.103) by
 dggpemf100012.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 10:13:49 +0800
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
To: Eduard Zingerman <eddyz87@gmail.com>, Paul Moses <p@1g4.org>,
	<martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
CC: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260605234301.1109063-1-p@1g4.org>
 <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <53d437cb-e2f9-ca99-4242-6a985393ceed@huawei.com>
Date: Wed, 10 Jun 2026 10:13:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100012.china.huawei.com (7.185.36.196)



On 6/9/2026 4:01 AM, Eduard Zingerman wrote:
> On Fri, 2026-06-05 at 23:43 +0000, Paul Moses wrote:
>> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
>> and btf_repeat_fields() expands repeatable fields from array elements
>> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>>
>> The remaining-capacity check performs the expanded field count calculation
>> in u32. A malformed BTF can wrap that calculation, causing the check to
>> pass even when the expanded field count exceeds the scratch array
>> capacity. The following memcpy() can then write past the end of the
>> array.
>>
>> Use checked addition and multiplication before copying repeated fields
>> and reject impossible counts.
>>
>> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating btf fields")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paul Moses <p@1g4.org>
>> ---
> Regardless of the sibling email I sent, I think that this is a good
> defensive practice to use check_{add,mul}_overflow() here.

There is no need for check_add_overflow here (it seems Alexi had pointed
it out as well), because it callers have already guaranteed that.

> Having said that, it would be nice to have a selftest in the patch-set.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
> .

