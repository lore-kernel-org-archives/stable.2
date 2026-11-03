Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735946;
	b=Gu6iuymdvubALRLLWxiSggY6agyTwspUktZj/eT+HutZs9ZI2yL/TPJUcqfQrKjwprGa
	 jTRQY1e8Ji9pfawvz1WsBegPSIFG2PhRQRQqKMiSID5qi1fGkLGripZb81lj/tTcA+dUT
	 CCnvii1r976aYt1Q/KsrLidBenGJb6T38C8dYdW4rxhCz5ijSc7+6gyxQkeNPpju+qyIN
	 VWM83LEPoDvZf4qz9BgrCMKorcaNfXUCcI6Uw7u36R011y/1Brcm87SOuure5LUoPXm+M
	 Yz+MSCTGha8gDazdW72t1cZRG67x5vs6WdTSfq2G8+kISTVshi+9v0D8UqDtiuzMjfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xpOJgsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=;
	b=aK2UJxHHIgFCPU66Ykj1qb6d6dKqStb1WZR6fBsMXYo7YuNLiYGrffj/thzKZnVuLzA2
	 dyRUwCeAXqZos5Ar3ATSZ5NSmmkU0/DJmLayDzSnAhxH9hBEjDKzIHfI1IheDg1c22goP
	 Tbr0umpbx6U9jorgpDmZlJpPLtoHJASc5NxMQ8STKA/12cJHHWt1+k+YfEcAEXAPLbfd9
	 NYZDuByE7U8oUVX6g3rmjKAAAlnb9Hqowj3oZhRh4sz01/BEOoWCeV1gjRXan/nqDUIES
	 emW2XI1t+rjSn10rMXIF7tAzZJoeYbiM9JsD5psbsCC5Loi/E9pSoeaQBPENjctVAZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FXwGhxDE;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GaQODNnC;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91278606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91278606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FXwGhxDE;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GaQODNnC
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3I4isX560687
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 14:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=xpOJ
	gsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=; b=FXwGhxDEyiYhfsw+MEKc
	iO0eBRAzcshzu7iioSTg0l4c/nSPG+/zQx8xhKoqHzoxaS/xYHaWqQyNCBePASkp
	cJlVaVT7G9ZeiWlELtAN6O245MoqLDujnT4Jcz8wscpAP9RqI783TDLEhRf4Jyj4
	gbOQPQmMARPk7y6ytdo9OoIhnD0kTrjSAYs/uio5hAxfXmehy/LbjJFA1teyeQSw
	88mjVAEfgt/vw905KGKiSzeLnQYg3s0X9LpfJiYDGaSBtqzY/iHCcFMePyi3VEmk
	azNZEYGsHqT8NXwYiuZEHSrMwnTAczP3IO5Z9MY5nqKvsVVUBYfMfDhurMMbpK2B
	gA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hqmjvgskd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:59:04 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2c0e6653so1798285a.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793735944; x=1794340744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpOJgsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=;
        b=GaQODNnCTY0xX476g3KSgDPSnWSn6yB06/CS7MdbnsVgaGgZ3uGMseiDqwU4nIWj+P
         LWEOGKTO6VVhHqmKRCtpf0EHh8DU0hqtxFC+ZOApIsAzwkSE3jkfllsPOL6BZ1sKfGRh
         x9vIYvM2MD/oS8Tc5IwdsGHExElcWBCPqeojOtrIBkk3YrPj6dH0wmbi1tsygjeI8Zep
         L3ooHLjUgTbzq7l7ALg7V/lv2LRbqRaUSUhM0v3zCQXCN0VYcuG3F6S5+WOQBqt0qe11
         NGtBkaFUmaZuwHjdV+uP849NMhabki+EzDsGoMJTqWyI1CHmcHcR+bHCcPcLEyKiMWfe
         ZJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735944; x=1794340744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpOJgsJz0sB9K9v/xEpka5H4yAVwg4X0Reyl3yXA6Do=;
        b=xIDfwntqMrmy1loxKpdjaqIgfZJzCPWTXWh5rX6CxM9R+uBdF9OMZdfp+XwyFsZ3yq
         gO5DZj3/adhHkwZV52a+UfPinbyGQxmBiNifJImiRPnZ7P1RUaXSHiF0aXevCUrmCZk4
         pidr1mhv89ob7XSligtfavgN8VclOAqwzBGOat2NCvdHuxzr99UVumCW3uvpebcKhxAa
         bgDiM0KIuMKGzerO2OsDeJDUkcuXnCn/CEY/KWT6j2co0oeY7CE5IC9okXJzraUTKhm+
         oKGBGyMFal6ckCJev0X3Tg7CwtDuSb73p75BVLt4m+MfaW2dGZUkz76KiMWEuLDmkGZq
         fgOA==
X-Forwarded-Encrypted: i=1; AKwUvBwJstq5nxlmVZuBny+NgIIDrLWwt5v4jCjtGkouzRQgRMvak+sJ9XOSIfpjXWdFTTvBvtG7leo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R2jZq1Ow6No9akufw9Ojux4tqQOtVYa7kh5UzG1hCIEeitH9b
	avjtORCmu9l3qvTobUNzYc5vf38ID7jl+POknxHuEGFu5L21F8HJmiyMLwEAnE7kMbZt/iE72yd
	OHc01ODaBWojYIUgcuETh3deHxXSAoGBLLrofpAKIc0zib5SN6l/rQQ==
X-Gm-Gg: AYBFou18rHSqFwuFjDe4gCE2tiiZim9CXYdF78J6+bcHMzIF60nAogcrCuF6KeEc1wS
	y3C7fCvpPSbs1gv3P/DEuoE44ERgvv1N4JMBaVvuU9AMAWTUwlPEdCVigSSiNy9ACPj/7ky5quX
	r3u/jXFVGznCzSC3ERwqkbBig7H8+7y/IY9zlFyNjOsoHPDxSXyQ9N+mLV7reJNgIMmLkXNLRl/
	QQ87ockxJMe3q6dR1nNZDiM+RpYjrut968eMYYx4p2466SD1PzUu5xs0gMDN0ORWNFrzUTmXLj/
	eeJIB3i7mWJb+P3zv4ku0cvDC0RorYSCFGbDvszzqh0Nj40uYWspKh+yGCNRcmTZ8vOhY8EF3Dw
	NGlpODpuf7J0FEcZEyAS1eTkofHJR1VsWhAUkxb1vUoLWRQ+flRnWHyCo4SEMn3I6QaNsM1dAnH
	53C+y3lOicxE26+6vpIeYf7uZaKiVd0t8FGYO+bRJafxbtSfuoYk9oLwXxQ7tb5pQqborLfZcsu
	p+5WMH8LZ/89SzVeVRZqgV+Cd/poh3cqwYXRx/lPVe4MTVTLKqATtqw8xbG6huX
X-Received: by 2002:a05:620a:2909:b0:93f:61a6:b89 with SMTP id af79cd13be357-94421588cd4mr2307140685a.7.1793735943854;
        Tue, 03 Nov 2026 11:59:03 -0800 (PST)
X-Received: by 2002:a05:620a:2909:b0:93f:61a6:b89 with SMTP id af79cd13be357-94421588cd4mr2307138385a.7.1793735943552;
        Tue, 03 Nov 2026 11:59:03 -0800 (PST)
Received: from [10.206.225.113] ([129.236.228.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4799adcsm15298185a.13.2026.11.03.11.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:59:03 -0800 (PST)
Message-ID: <a002901b-715a-4adc-bdcb-7a6fcda67711@columbia.edu>
Date: Tue, 3 Nov 2026 14:59:02 -0500
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
Subject: Re: [PATCH] mm/memory_hotplug: don't offline a hwpoisoned page still
 in the page cache
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
        linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu>
 <1b6a6d13-8a01-414b-9bbe-cd194af1f539@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <1b6a6d13-8a01-414b-9bbe-cd194af1f539@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: s9B4BCwDTALIX3ATQWPKDY5aKDQ7jEE5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfX5FIMskpeUOHr
 OZhGvO6WsXT7V8yMJf5bhjcyjCZGS6eT88FECLqozhiDed/jBgPfKDpk2cQw0xFsFZO3amVzrQp
 HBdqLC5aPbKy85bZyBYidVKOMB4IjZEsh9urr21wWSnaYbzN8AWQ
X-Authority-Analysis: v=2.4 cv=D5XSufRj c=1 sm=1 tr=0 ts=6aea3d08 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=hEunIlkDQR9riCPXO4CBGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=qOjK20r3ws_Z4Kvo5k4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfX4zNYVyfYZKM8
 T8qKh+YaFZGi8LBAbMG4UJyNEwQqIuz1PHElT5agGPktmS4RJswNh4nllwPVJKMDKWsCgGQqsRC
 hbHsNqcfGKskH1KClK4loR0b0jttgdcnbCTyu7sib6IWqOsLTBRi2SvmL77szQT650LB9vWwV8u
 JiO7mLpbYDgIbTS+9zb/twrggAQlgeyFOlAUOjIf3tYzacmG411B9Y8ENVLGQAxXy9fzEM2APkm
 DotNAFG0Rc8a7Rl8BWbkDEwTBodDrc8kBHizxJzc5uRGcy3zaaUiFuHFTHOx8nggtAxK4qlisgQ
 f6wZZOPQRZtwl1ozyneznC1YLPSSvXyB/vcw8+nXR+taMxtj7Ty2QlPCr63eTU0Tu8YcXjgRP98
 hCd3WZErTwhNjWHyeayfYsOClJErx9gUVrcZtEfmcHdwwlt8IlaRLVOGjrcKES7ojZsHX6jP+gw
 zKLEaaZtFVmYCFrmpkA==
X-Proofpoint-ORIG-GUID: s9B4BCwDTALIX3ATQWPKDY5aKDQ7jEE5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11955
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 phishscore=0 clxscore=1015 impostorscore=10 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030079

On 11/2/26 1:56 AM, David Hildenbrand (Arm) wrote:
> 
> What if we still have the page pinned somehow? (vmscplice etc).
> 
> Wouldn't it be better to make sure that poisoning code holds exactly one
> reference (whoever set hwpoison) and check here that the refcount is 1 ?
> 
> Pagecache references would turn it > 1.


Yes right, a pin isn't covered (neither before nor with this patch).

I don't think refcount == 1 can replace the mapping check though. In the
race from the changelog memory_failure() has set PG_hwpoison but is 
still waiting in get_hwpoison_page(), so it doesn't hold its reference 
yet, and a clean page-cache folio then has just the one reference from 
the page cache. memory_failure() also doesn't take a reference on the 
kernel pages it ignores, and a poisoned page that gets freed later sits 
at 0.

So I'd keep the mapping check and add "refcount <= 1" on top as a
follow-up, since that also needs do_migrate_range() to drop the 
reference it takes when it takes a poisoned folio off the LRU. Does that 
sound good?

I'll send a v2 soon with a small do_migrate_range() change from the 
bot's review.

Mani
