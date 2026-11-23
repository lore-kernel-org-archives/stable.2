Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412787;
	b=l/TSBUIj0A3f/fwpgRilT5JfWkl+3zwwIpAgpck2ow68NqNN8MH1uiIGNum2kHOYXL5t
	 ChE2dQuThPgwb3QrKW497grUEqWk67Syvz4175FNqfGYGpTTa9KDoPw9QkqtikO2g3NWp
	 IABYDnhAZHzv2Ml5fvtYP86/BIo+2rCs/Ri1qeQVcRonr25ctDu9QX30jDIzLu+gnn7a4
	 0BgM82i2vo3UmkIKx5yydeTLwkZCyU4Z+XtC8RH1ulaIM6NU6LmwN5v66X+D+XqzDdtRn
	 0uViaceMfkER5QxN8QvONFFXY1gSqMl83mIra04ggNx9UguP0E6MXxdWSsjU4bVxeZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412787;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WDdOZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=;
	b=wQGG+9DwdrSNZNokJv5dVlYQSO3Zv8rafMvB9tLSzjhqCbXlEHYtoG8U941usCjhtUST
	 SOUDzcCiwffdDjnHowOxru85OMUdWUd6W84y/ps4emT76h7To+l5YGs8lePSbKzx49pnv
	 1U9bBY4EzwEOeYPoTZwS1unfzOQ2TfjwchWSEIvW7vo8hcRNlAAHQzxzOlI+SZ/RR3t5Y
	 wc12JQ/7e6nvQHsHY/lnDAPbF+f9EpZj5SZMRl5RiLcctf2M+1LxGc3ipKn5NbC5S2caU
	 NUvnWH5WRwXyM0kp5PnUnfRWNg/ea/HUCOEn+Cy+vSbwGl9uWPjq4cncY9+6x0+m7ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eyBQmLoc;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iY5Le221;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D878606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D878606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=eyBQmLoc;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=iY5Le221
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN3XktB3167023
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WDdO
	ZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=; b=eyBQmLocBEnxAn3RL7SN
	cxpvSnKSDfx4CShgBEFehjOQkpPAto2AqDp1fZc3OV6rEchZANMo3ed39PVKMCuQ
	rlIaSuz6+KHv2xwQSPeGMJCwwzyGmyteNde7PYNE4qOcfLkq8m7RQf4df9WqNU5S
	OGu4TKiVPPLMEYcukEciniTiC0A2W99NS0wwhyL6s/q9LBLCoFhEJDjH1OLYebJQ
	s40EfeUkrq4RYceMa4Sk+5kmmowqEer1xw2BkHWOB2dGL1BPh5AACK7oW06otfwy
	h7uu2lNzh6gdYQz1I/9lNZsD9mOjkRcIBpzSURKurTJk5wK2lumfS8J2jFrUz4nf
	0Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j42wju192-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:46:18 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-921286add9fso52626406d6.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795412778; x=1796017578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDdOZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=;
        b=iY5Le221neFbE3zr5ARx+0f1B8tbd8Q1gPbGPei3hF+X4oLEENJjEZtIZRTjY5UuQS
         aQykmgvUNHDc9mhC+YlPdytgTm4wQQlDOa1Zzwu6gr5+vdihGK9bqwvNW/TbinvnM5Rj
         xXyACtSh2oVFn0rwGSO4luDQsDw5M4JgfK74EoQxLeKtICr8eRhu2uMO/cZCRvTxPm8c
         /wq8OfinG7ofM80QY3mUrf3zpD2f3TLbERi3Eyz+Xka7Z4MtMJ05iyovkeHskb/unl07
         Xvk2gXCwu5VHYZDf/2rVFxgTMMTRNYCvrATFpjyB3pvltkROK+HcarIuuXnKgfumTvNZ
         qMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412778; x=1796017578;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDdOZbAef0VZJUq8GHeZZN1Befvz7h+o1H703vna+VE=;
        b=yNG+C8Dp/XBoNn3URCoimZ9RW4JEMNFfpqanKLFpi8Z8HVwsqw68KQWdM3Wl/OPuHQ
         ouTjuwL+nYEN5gwLjPL6QOFu3CIOOg33XVwUoMJbyBtiSaDV7iC+aadx2MwVGkQD9ZAd
         B5mnevC5x8WVL2+Z+GJpOAkld5Hh7yLJZr8xteb6sj8NiDnlPBif1iMUv4Jd85Jp2qlb
         t1YKLUTE86qA6GBcQUbHBPUPtdGJgcMuwsIqw//xxOxg2I8BCJaTghyTHIwzW/gWd1vQ
         lZWWSk/qk8P7j15Bh+8KSc7dY467ruwF34uzAih9Ml4gtrUO0V83FoLKQAKd2DtiiwzU
         A3dw==
X-Forwarded-Encrypted: i=1; AL+hErGV6b1sUj8ofD4yGH15PoRh/WdAqazvoGBdk1kO38jWJMk5CR+Ftmlz44sXmOw+d4G4H1W3BmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BN7BliZv2pZnv/Qm5WlhD9CjDb6jzas1v6jCx0p3tg4FE49/Y
	BzR9APl4fNf9rGsJeR6P666j3g4hxWFEueUXnkSuSQzZGaMRvUPbRTR4qUulgK2h2dAx/61QBR/
	k27Pb33KFnDhgUPzAKHezKvRCM3j9ED/JVrw/NxLJlk3gx5USAJL3Wg==
X-Gm-Gg: AZFdTZeoAtGYRZ9+lmwA6ZHuwCiuQk9miXo6kVt/aGVkrQTx3VHeRZOyCjYHYDX4K/O
	RLCkcK6/BxVyUmQDMV9Tluj2hjglmdRxNEQE935+aVsjAGLKTJTk4N4l57IFak00TepuLlxd0PY
	z8DOQUBBUJwljewctZ4NblV/ItaGE1d8p/MkFBINGehRF2Vvqjvtm4S3pnXRrze9a49ekwcR2EP
	+wmHfYNQYrYhIs2UQpGid7zxqGO3dHnWnJSApgaY9jt77I49Dlu6YKuqS7s/agmMM+neYBDwR7i
	5FCqRBQHpKU6HjB898Tf+COCPk1Z88goJwhB65w9Lfv4CQzA65FNtjnIbIj5qPN7fVolMnZdiW/
	TtwckC83Qga7DS3vG4PcGXSE3HoU3IUHooQ+DBaHFAIZitc1SS1IgvSOU2Zl9a4PrYZOVVzdzhN
	IgUuEF6uqFXlyvh1K4w2CLYFGYrpyP3CNzSH8eMe2TGEbQ2KJQ0hjs7HDhHdMxtO5DYCVjKH4f3
	BpP7NqSP1/ZUlBfaskX5aOANCAfgNP1eBjpEklGk1fIARs9bilH0+rW9NOY2C+tOhViGdyYaaDW
	wLCQSK2r2MDUyOaNd4lOhnc=
X-Received: by 2002:ad4:5dcc:0:b0:91e:76a7:187 with SMTP id 6a1803df08f44-92134a9e8bcmr183189976d6.43.1795412778485;
        Sun, 22 Nov 2026 21:46:18 -0800 (PST)
X-Received: by 2002:ad4:5dcc:0:b0:91e:76a7:187 with SMTP id 6a1803df08f44-92134a9e8bcmr183189906d6.43.1795412778183;
        Sun, 22 Nov 2026 21:46:18 -0800 (PST)
Received: from [192.168.0.76] (dyn-160-39-51-212.dyn.columbia.edu. [160.39.51.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a0a454sm95684796d6.35.2026.11.22.21.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 21:46:17 -0800 (PST)
Message-ID: <2e11ba52-b5c6-463e-a5ea-c165ba935704@columbia.edu>
Date: Mon, 23 Nov 2026 00:46:16 -0500
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
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
        linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
 <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyMiBTYWx0ZWRfX16UiuQ3bWPQ+
 4Obz4SMp5oztRZoTMJpv+Pr0fFO6Vh0oAmBG8R65s2qP38Qngj6FJ1K58bwnGZHiz6wuwWjwE8p
 Q9P3jRn064ZYmim5aOqFP8vMHAecr/sEW6+MOjxuBMweVBvu2IH7WHWUvBL7p8gca2C+bzlhoIb
 GczTt5R2cikzy03hQkNI9GUuqCAe88oLqzwJ2ZO8n0DE/KCrsrIi+y/oy6qk7ROjMLJnBLcyt3S
 xNC9/W2ZW8vHcCrnualkGeKQeyF3SwZ3lMczaYIeao2ZlGIencHF2GLSdVpW6xIjNyLOUfpsz8V
 sIh9gVY9uUesGVcLmWmmgA1rO4omA5OnhkDzXg+VwaNKx7cgQjZdvHimusbwnFr5mwb7QHIaJ4V
 TcxEGI4kAcLx9kzouVdDJndQtEb97O3zVoO+Xe/pzEdFKeL5Mn/CAM9awmsm+WyEbg/pGrmpx88
 74jCkAsNO/GVkt3as+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyMiBTYWx0ZWRfXxH/nhg8eb9dV
 rLTPih6IOQOlcIFcnfG0luNQR8amQuBPZaXiarqbV3RFLgY5tXlikm3VJ6q5eBklPMbC4ik4zLP
 r8NFlTilWPK3grYClPmC6rWQUi4jvg1QjPuUrjBoxFU7Kins3fSh
X-Proofpoint-ORIG-GUID: 5f3v2jQEa1WdPmH_oIjdb81mKydkCBuo
X-Authority-Analysis: v=2.4 cv=G+mJgNk5 c=1 sm=1 tr=0 ts=6b03d32b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=l9izRfKDRJJ6Wn/vzKnQSA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=CtMvlx9HVXp8zQbR6KoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 5f3v2jQEa1WdPmH_oIjdb81mKydkCBuo
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11974
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=10 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230022



On 11/6/26 3:58 PM, David Hildenbrand (Arm) wrote:
> I didn't understand why just checking for the refcount is not sufficient. Can
> you elaborate once more (and please not send a new revision before the
> discussion is over).
> 
> Memory poisoning must grab a reference when setting the folio hwpoison. Any
> other reference (pin, pagecache, swapcache, mapping) keeps it alive.
> 
> Why can't we build on and?


Right, but memory_failure() doesn't always hold that reference. It i)
sets the flag before get_hwpoison_page() grabs it, which waits on
pcp_batch_high_lock that offline_pages() holds, and ii) gives up with 
the flag set and no reference when get_hwpoison_page() fails (e.g.,
a pagecache folio briefly off the LRU). In both cases the pagecache
holds the only reference, so offline can't tell it apart from a
page memory_failure() already handled.

So I think if we move zone_pcp_disable() in memory_failure() before
setting the flag and keep the reference when it gives up, offline could
simply treat any poisoned page with refcount > 1 as busy. That'd cover
pins too. What do you think?

Mani

