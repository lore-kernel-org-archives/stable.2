Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490269;
	b=r64x8hVMzYOMN0RtLsA/y9d9Uim9I321eM9YQ8WFRQWrgbWTsuA4Y58eYQ5H8jG00IL2
	 LZ8mhOhrXU6EmonR7lXFweNhrgK8I27+2IlI4aTTy9+HqGuxtxYJBRX7fGZ2PAox2P10D
	 kgYlLe0nL/HsWKag79EK3iEgDOjQ/vwwb2ZqEXiSnJ+Gmpmc0iw0J/CzSy5sWzInIEDPX
	 JqbxKzb/F0e4OUduL7JzmpwZR/q6EfQl+WhvWYoJ+kcOwoOgsKE4OrnLc44SPwELaPNWl
	 MisF5Bv6dOiwtvOmwk90mcZp8o6ykmPnuM5yIc5L+bLdFhcCUA1cyXajec0Mxa89q4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490269;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Xc1Jva+P5RD32pY3oC31LLn2mJzvWkGZ2xK0oVerZnM=;
	b=iyNKBjXl3kj03uwGMwk8rLeD10pkZakEgUcNVCoN6p+Hx99hnEtDpVJDf0pO99rHXxvj
	 42O1Rks/fm39eKR/CV3uz1pdDtRA5pSKmtJ8dW4Fwc2sxzIlykM4kHrCqdmvYfbkJI8aj
	 0oJXIMGd+BQ1BeThY2ALbFfT7ubscBDWduaNc3ppLtJ1WTpvaCOy4e+xa/cdRF+yfrhot
	 6WIMJV0m1TEuRX0/j4KBrm2Ws4oLghFJm2xTrGCk406oEJ9VD2LeEzNM69jrFQw/btHu+
	 xI+wNB2h6lbNpu8SqVnSa0JRX0bhJSymFK9JUiaJSm9hsTkqFDFf2G1q2bdgGP0AJMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NJrWZDvx;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=rQw60dI4;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D2606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NJrWZDvx;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=rQw60dI4
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2bchC737843
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Xc1J
	va+P5RD32pY3oC31LLn2mJzvWkGZ2xK0oVerZnM=; b=NJrWZDvx6gQLk5DHzVnU
	5MdW6ovmyfdbd7htr9RqakV/rreAeRijEH7NIT5D70kiQ7HVUl+liLtLmC/Xh8Ik
	uUCCWYwSzbWxbSQMxvbUIyUOMEDtMFg2w0c9BqbvyykPGFj2wGASSwFxlCQonuZH
	cLhEtDIunLIe78ulwC/2giQUM+e72ZFXlpd9GxiPWWR+mrUIGzrTv7Zh567gNGVm
	I9uDrTy8dpJVXxAPWRp8+hIbnELGoYo7ujzH91KKGLblNQw/bYdDq+bLnlTIOiXu
	1jth3z36K6Ymm50as4Dr0xG4k6QoSkERut2znQbTX7i4VGVIPHEse56HVywu79sG
	mA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j50h8rg2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:17:47 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-55d2bde4c78so61264001cf.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795490266; x=1796095066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xc1Jva+P5RD32pY3oC31LLn2mJzvWkGZ2xK0oVerZnM=;
        b=rQw60dI4i+/gdc7xlMgurusfZmMYsIKhqTZDHioeEdkw6Qf9yfbJDhn8NB7fZRC51N
         CnF6tLps70jvEIPwXcoCYHDFGle4dZgP9bgtKZAM8rNAJHn0hRykXnZmjjLzlyfej8Uw
         dFvNHHZSL7zZ8We31QElLP4VICUjMEKtq35J3zU9WX20s1hJwUZa4nUs9paFnVw/YDrz
         aeWzm1I+nFIZmrREsniubILV7oNCwSGq/EErYU7mnxkiz1ZudyoroX8v0OPGSRtkXQVF
         w6zSHmBAXs/houfGI+cfKDShd1lhnOln2KhKtdwihGXmXz+dFq9ep7RyOu4Ydt6L04uV
         sq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490266; x=1796095066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xc1Jva+P5RD32pY3oC31LLn2mJzvWkGZ2xK0oVerZnM=;
        b=kDr5DQ+A/E/YqzfPigD1K0ev9+DcfwW0ZTy6xhMAw0OjuGwVeT4hxJH8dDZREJVr7T
         HX123jp+SE5YvKXxmcQk0yvVHDTIzMk4/7B6il4NL0syFhsdZUO40FugIpH/VG1roFJ9
         Kjk5SQwJAu4dc6fwMfXSxXFVdy7YzwFeqCXt6h3n/AMyrcituaxg0K4PlcvYIaa7aSok
         faSxOoMLtxlcaJMOSXKwQsFz74AIEgJq1RXGysQUWUIre5TaG/CE3WRxQ9x3d5Eh4r1E
         bBJ1f1NkP7RFHfmp1Z7Vy9q0pe5VUWVv0ZJelfxdqS5wh6VIXh5nAfjDWErqsHKi72ip
         dPRQ==
X-Forwarded-Encrypted: i=1; AL+hErE3zGv1zDBDiaX+FL5fydG9+tepmPX2sBHFGMoudxRKbqHiVi0931imCLteS2QkwWCsTQF/tVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RIp3Bx0Z5jqeZyitwE80bxJFr2fpgO9kIUU+hhrjUQzX+78sr
	lg7cwPLwTE2+Z4RfMzRcPDXz0sV5weFfnp3lmFAxyfQQ+INN4uPixZOOxErA9+YNBeAvEcP/yae
	jnUwOMOEmEV43RWZ8yzyIS7MsNRyP3zhf+c9m4vWj5SztPWGHhlv/vA==
X-Gm-Gg: AZFdTZccNCPaPtYs6B47gVJ7h7JuP8OZQMXOWKjr9MZB86nvFdaR6mNgHjDJe4U88JK
	7rph8ldwYLrsztBeQEjzjTulcdupj13nJ2BSxy7yTkA7NG8HQBNHmwMFeOU8il7dkdG1Xc9q+h6
	1E5v/gHWLme3gUmBQC/HMv2RlPSjY1jFJoVSXgsS2GtezDseuAee2L4Uv5Ki8q5g+H9D60jlyJD
	2ANRECcuZdgzvf2HQmygNy39J91A6OM36Cvj9MMeXwFH9P040oBamk6cnVuugw9r34lKpMMYDOL
	32RxDIOZL4jE3vUFTnEcH3Ww9cMKDG+IlUks3TraHk+ejeKJZiLA+Y2yFUXFwrDpgbPNAcAL6/J
	V8X3g0xr7wezxxqmtODAqCDGCnWCud78CANl8SnhFT+Dsf9479GLjBDRhwd6GC5YVnEFjTQ12a4
	pTf1JgqJoRa1ivt6ZRfo3aATwFcz7iLQf7TzXahxIn1KE2Vk6FAlbM2Axx/s3V50FRyVNlDEzhs
	Rd50ywWMgx1DPujZlCclk/0veu/UIgW3xuS0gwM8qBIEDqhIe0jkqKtVWH0qEyzj7g6YjLPdup5
	hXEmG4H19FM2DykHAWbxVFE=
X-Received: by 2002:a05:622a:4014:b0:535:a5fb:6459 with SMTP id d75a77b69052e-55d76a97e34mr243107751cf.68.1795490266607;
        Mon, 23 Nov 2026 19:17:46 -0800 (PST)
X-Received: by 2002:a05:622a:4014:b0:535:a5fb:6459 with SMTP id d75a77b69052e-55d76a97e34mr243107601cf.68.1795490266274;
        Mon, 23 Nov 2026 19:17:46 -0800 (PST)
Received: from [192.168.0.76] (dyn-160-39-51-212.dyn.columbia.edu. [160.39.51.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a2806dsm120277726d6.45.2026.11.23.19.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:17:45 -0800 (PST)
Message-ID: <ed5e6771-785a-434e-afe1-90ffd10a34e6@columbia.edu>
Date: Mon, 23 Nov 2026 22:17:45 -0500
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
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@kernel.org>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
 <42a60f57-5323-f981-8ef3-2e5d67623902@huawei.com>
 <a87cbd92-0e07-4f84-9a6f-8db0b1778fcf@columbia.edu>
 <b0f30561-aabf-2bf5-2204-20907c40ef43@huawei.com>
 <08b18b88-3ab4-4681-bec8-f4564fe9f1dc@columbia.edu>
 <77680005-7178-cb1d-6e20-e23519839222@huawei.com>
 <56de516a-c895-44a0-94f5-ea7bc5bd3ef9@columbia.edu>
 <53d2f7e6-581a-ec05-6dc5-59a892ace835@huawei.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <53d2f7e6-581a-ec05-6dc5-59a892ace835@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: a9ecnov4IxEp9F_f1EQsc33ZeUoaq28b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMiBTYWx0ZWRfX8lWHAmxiBPon
 6/++sEJAkKKhqIH//WNM0FYbaA23j3drUCK8jQNdfLYXh6wZRwi9755+wvIkkift/w/gPGC5GTC
 VXnDn15C2wZ1lLtDZdQoRP8gc5uIz6GAI9zd+U4RhYaIoekybUhI
X-Authority-Analysis: v=2.4 cv=OJOyTiaB c=1 sm=1 tr=0 ts=6b0501db cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=l9izRfKDRJJ6Wn/vzKnQSA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=ksQGBAMdBnAiGY_M9A8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: a9ecnov4IxEp9F_f1EQsc33ZeUoaq28b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMiBTYWx0ZWRfXxUk6oM0V2Ngz
 qYDXTlmxplwnz/N7keyCB67+Gg2ro7vhGJUskcORNwpHINBDjn0aRklk5MyDuiyRIN6ExXO/3ha
 xLHSK+HatiKM81oC2Rue4gGLWkp5PFfm+M71ZRRdXeMDsU0IaLFqyFi+ybd6/A33p7xmov/U+Kj
 mvb456cektYUx5hGxDxeyDH9YVXWq9fse7yvJ/zwPahGjvu3Hq/PBki8YtyG5ZsYnW2+my/Eu5e
 HX/5S0o7xCLpglFytL/WzPdYpkK1tcbiFXChzh7YQ3fYuwtAdZDW8zRuO/Ne0Ft4wGNHI0feYot
 Mn2XlBlZBbBsBgrZgvrQyj8g73GV5jAhG1qRXnE1X69gPAdRw64XW9l3t8ZkV+StgBULQBpOKoB
 ZFGNaOI2UB7XtnbiBeAdWdN/9wwKsdlKOBYn6hP+BrkrgoqGtqEQtWIg1Wye8zIjgB3ZZ1ZOncI
 DYrzpPDhyO9mBCq9TQQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11975
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=10 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=10 suspectscore=0 priorityscore=1501 impostorscore=10 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240012



On 11/23/26 10:11 PM, Miaohe Lin wrote:
> Yes, sounds good to me. And some comments might be helpful. But do we really need that rwsem?
> Could we avoid using that specified rwsem?
Yeah let's keep that, otherwise HVO can copy the first
vmemmap page before the flag is cleared and the copy
would still have it. + Will add comments too!

Mani
