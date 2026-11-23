Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455128;
	b=i2r65fjV90midKQxMh4TzCs4/MLrRiEEMfkA2MeSqc7TdMV/EgUVeWELKxxNYs1fKL+0
	 /TYoCTxviaIr3+U957i9BkOSktHROO2zOeZoTPZiIPX12ex/VcZiCL+BqEL0ojetb1qDy
	 BI+ShF25s4RF/KGE/aisbq63vlDQRPAVNcVRL8Bfuw3gbWzPDtfR6oIlhEWkOfrQCh78M
	 3baUdoepSvU52s+Bwg4GwK+EXUgD6zbHNMPItwx/bqsYZYJ2LX2TzPioK+gA1w3tDg4bE
	 6zi2+HPn9EMXGv6Whigw+P4+/xGSnCM/SWFmvOHlOiNzWnvfhGo042bFXUxWelXjevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455128;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1a4TM24Bx37KhzPX0EKcngcxqi/da9ANdKbxr2maRdo=;
	b=0fIMb2fTPGVYpLud1jYoATbr+Vj4rngL47ST8sfYU2TPVLIDRqaa/HkNo73BlijVbJAn
	 7/pgI+fOcfuU/Vbvge4ykjGKVeEO6HIDgYJDl4FFHw7U1zhmPuRDvR9QRhYJMhDRY5Xbs
	 tz3/X/1GLwLnBtQIkC3x9FjRp12ZbSDjWy/rRC+nX2DPjEOgH4C4L4yGY38CSaBWNgWd2
	 2C0TeipgZtX682oEWrbCWK68B7LnulWPjntslg4C6TyWfFx+gLXcZ5CGuY0u1TpSVDTWf
	 /h5/NvjNO8O5Wc05efF7euZJFL90uNEqVJdhb6OknIaYaJmgvpANS7vcMQ8cgmNyYpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e84uq7aT;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fgajgmYm;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66568606A33C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66568606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e84uq7aT;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fgajgmYm
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANFXfAB3631273
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1a4T
	M24Bx37KhzPX0EKcngcxqi/da9ANdKbxr2maRdo=; b=e84uq7aTN+paLgiRpBNO
	jFpZrFwSkNAZb0pLrPBFBMpeq7xY5VF5Ke74YGVhQQhgB2XMzCUH3wtB+DektBiR
	qPo9ynkIbzCzlLUmkih4RkrbewMTNmaLvk6XxPhBoaZ8L4ukPmaKxPqpWeBbJLLc
	uelcoHkyG8W6GveecAnwBSg3Yp8SkpLpDehjKoA99YhreNu9TwIUWlL5Tbv8AAM7
	bQOYm9/5nWyXZcsZXTj1dP+reEx73v7sueTzpgokaO7URE3kspWKIKGZsluDsTH3
	+sZgnA+tjE6t19HGhCCmkFQBefGvug9EszN1p4Ts6fdQLWzQIgVR9TFNWu/q/bNX
	NQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j4qg99uc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:32:05 -0500 (EST)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c2db10b1so5368903d50.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795455125; x=1796059925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1a4TM24Bx37KhzPX0EKcngcxqi/da9ANdKbxr2maRdo=;
        b=fgajgmYmeS2XJLI+qYcBemiE4xcL1SjJ3q6gm8aGHAabTQZq4w3gsWXurlCJ2bn5ls
         xaslu/vLTxTO0grqUUpYfv3R2YHBqaN3WTtsWeCI/vyAvcZnN/L/HBqXWOCqY6Tzz+YL
         i2jeC/2ToZ49F+CWBjS5pZLZIRz1ncc18QuH/N5wwi8ddRVzveDCC4Qj6LCTZ9peGRGs
         /n65F6pukhY1lsB2lp4S9LAr+Ri8arYWgG+IepkieWiAjyJ+jJGZHc9vZTSnxk4LlKEa
         eU5YvqCtEA4YwYi9PMKAkpy4nljRzmiVP4lU5u2LCpyanSlQr/UHsrBhhG9X5cMBQD8G
         /xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455125; x=1796059925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1a4TM24Bx37KhzPX0EKcngcxqi/da9ANdKbxr2maRdo=;
        b=0sxmynZK8Zz5RTP0hR2OtdSR+1A6n0fjmi8jQUJUg4RtdsR/eu7AmvWXl8k+vtiDlp
         Ww+0jTblRYf5fePyjMhYYGYuQgQqUTBReW80KtqO2M7Oh7bFnQuzQUQreuSxIvYxIsAM
         O7ODz4zmFUvtSJuDzTnOW013yQuvQkDIQYQ69Yg6bVoSY902fpFZCR2xzlY9gTTRAjYs
         S9ZLlp8s1dvPlGJ7343p48SIGLPgHz2Hnq3+Y8KLTv2Dr6P1wZLl6dLZxQ5riQ6UOMFv
         Easf0MePZWJfeYPlaqqgBmj/iVFP75xDy/xtf8+eiNOImK3yeVMkAFzT6NytdmgTt7mf
         lNbg==
X-Forwarded-Encrypted: i=1; AL+hErHDA8NmwsU/4+s7fhSQVobB/t6MDxf0xLgv6AYdGKaDcq7qLIdx0ERnA9KM8VdxVJ8L9DqdGhQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HyoqmzRLsLnXjHgDOHGpZpCFRJTk/R9bmwJ/et+ZrgfkQMy9R
	1e2Leq6YxxBduoCvvymr2aX1Dc2WCnB1cKF5MCy6K3Ls6SiVxNyOcLeOFqg+X54qovuIbPXYx9g
	jA2CXXmvsD4mRLFhsWd2yVQKItlGTTYZK347hA65l1X/x/j4OikGt3Q==
X-Gm-Gg: AZFdTZfPzZkSy8sMgBFQxOTGEWcquwtWwM45VbNKrV/vafRkZmNdojJ0iux+10IHVuO
	ay4acRCMinO+7yVPxzC2rkLSpCSleCsWXYV4WhULtxgNnEIUxPfkk+VScMRga+KkORowLxvsGX5
	4VijypYwp/VW5v4917p3gtlih1go8w9C84wS95iLlIdXZ2XsF4cL2Pe6dRH+Eev5E2L18gZWIyV
	a4o12zElG/nirDxLx7hpvwH2U9mWd1qyvD6kg08ziotZEJUANYYquXGPUmsdEZpQxqF8CNh/+gM
	3P5htn8O7SStXSf5mwoGFKhDDP95uEsFTEOrNscMJg+SNooLQaWf/msd9NB1hdHNgnJYwEAeWAU
	B/0pS52nxxU3l+l9q9pacSOMi46gcKHT/pURij3Hws3YpAHGSAPSBQnceyXL6z7vkkpAkeYLeEs
	TcZwIUJoWZqTJgjioFjeTIxYDQx63YIHc5HFJCbW3dvLv8uZ52jwZQZRnYFC7ZpYblizOF10Y5x
	5FqVE9XsvPjpZ4FTVsfFuuu8EW3AAsL1yNHgyqUkFF5Oja1KrJ0m0xAvj4Al7S8CXA=
X-Received: by 2002:a05:690e:1209:b0:67d:c588:e55c with SMTP id 956f58d0204a3-67df42cdb00mr3845651d50.5.1795455124696;
        Mon, 23 Nov 2026 09:32:04 -0800 (PST)
X-Received: by 2002:a05:690e:1209:b0:67d:c588:e55c with SMTP id 956f58d0204a3-67df42cdb00mr3845632d50.5.1795455124303;
        Mon, 23 Nov 2026 09:32:04 -0800 (PST)
Received: from [10.206.149.246] ([129.236.230.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f2186sm113214946d6.29.2026.11.23.09.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 09:32:03 -0800 (PST)
Message-ID: <625b9f25-9d9c-4445-8920-b8a4e549127b@columbia.edu>
Date: Mon, 23 Nov 2026 12:32:03 -0500
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
Subject: Re: [PATCH] mm/shmem: fix swapin livelock on a mismatched large swap
 cache folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        Hugh Dickins
 <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
        Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
        stable@vger.kernel.org
References: <20261027-shmem-swapin-mismatch-v1-1-84e30aa3b9e5@columbia.edu>
 <3c61a49f-6a0d-49eb-8682-aece4e7e7226@kernel.org>
 <4af8b7ef-8028-4b98-ad21-5620f8b92f42@linux.alibaba.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <4af8b7ef-8028-4b98-ad21-5620f8b92f42@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfXyA+WKCSDf2jk
 cI4r9J72MZFaKifIxINbQrrBWVQJ23d451KwGPZUfXx2xyqo7/M09dyTNe3XLoZ5NTQYgz4KA7O
 q5xuVyB4Ii3wZF9PaXrlT68ml4IwarXFlBh85shx3+RiTh4PIaKV
X-Authority-Analysis: v=2.4 cv=MYv5KJ/f c=1 sm=1 tr=0 ts=6b047895 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=0AiHgshebfoioin7TVvpCA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=EcUMADH1NWUpQPqG1_UA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: CRdqHwUpVwxUTl1vQsOEl3actKVwR_U-
X-Proofpoint-ORIG-GUID: CRdqHwUpVwxUTl1vQsOEl3actKVwR_U-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfX/HU4UKHSoBwL
 dXC/J32V7ExA/Fm2kyxmlKEpTWcSqAc70BM6fvF/J/uV5OxsYIdSMRV0meLL5sibNMtZgaIjNpL
 pWuV9+2AP6bq4wTcbdAl6FKZwOxa4v5oaKxkHaJo6BoIBSbs0I21DWGAvaSmDit27VfibTgFk7d
 AHRpjwM5myEUvNtFl000apXqQOQwxL1FqF24vT8gA81jEVQLeU7zbTJ5dZ4aMOPkQBKvHkRPuWF
 ZgYXqNwLWXvk97ofYPgEKcRs9M6aYxsJkGOuE2H7NZRhhL5ALC9c/guc0kNwv56G/Rjvhzk/fVz
 fMfefjxSor7JcSYHiNYCTbKS4GWet7W6rr1I6WQP7lk22c117yUqJcPgpjjXvz7eJp0l2Oul/j3
 MOurEsS6ZHJZATRGxDiRgxM+uo39pOGquhvrVQu+Wt5uVGQL/nPAvsQfrk79U/Xyg++RdlNBl07
 gSEB2P82yjlEMXtNwkg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11975
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 malwarescore=0 spamscore=0 lowpriorityscore=10 impostorscore=10
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230069

On 11/23/26 2:18 AM, Baolin Wang wrote:
> That makes sense to me. If Mani has no time, I'll take care of this fix.

Thanks Baolin, I was actually about to send it this morning (and just
did!) And yup the race is real and the patch fixes it. sent here:
https://lore.kernel.org/all/20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu/

Sorry for the delay!
Mani
