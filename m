Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270459;
	b=YgRywxpu03xJiAp2UY2h7FJE9NJNZKApjj0YuJ0Tr3Ap6fWRkDZgvqFMwprQXj+gdIwg
	 ahMQg849fa8kXbNPbuREzibhHLDZAHUNkSvZGsvNyXsY5La03mp2ayz//Hb5O8/FbaQ/e
	 yPt655CNGDYYqVoP6WwnHFAm7Me0Kh5omLgnct97AdKeACpu2WTg7yI6C5Wu1FVJqjAgz
	 eUG72hZBQnOSswFBtaNKRwJgIn6qHl7vjqzjX1H1UnQRTVo+vekjk7JhWXunuQBEX/moT
	 qhHV88iDOWXBmPnMkn5A/6h0oWpZQyz7eJyAM0XNYI8I4mYyVw+7U7WDePw/StJ56fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=R0bTkl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=;
	b=xE4Gt3zj9jeiC56mmHE2rZal1cZxKOEHUgynjhGgaIOO761YStenlESbWD5aX3ey3Gcs
	 UHsymhjUcLciqbLFOmIeVmZfQYNXl+e9R7SliMkHcRU5ctzEPp+gC4ttjYDWivkJ4X2Ol
	 CRpfipa7AUio6aRr3VfIlqrU3q69UA0bO7FITZFOzIaw5aIOpVrnoI5cjGaxgUPOXBJFV
	 hyeYg+S6SI4Gwy0jkvFjnUPOnbFugtc91Lc8MjHWWh95bpeK0TcOfYiIkJ3DpUwSdNDBG
	 l0XP+s7+Wod8qyDTZT6E2qfNdWYajMs9JAPueTcSvCSasS3gHptefZ9YU8yvGX3rHMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jOCviDoU;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=XrqTGBFT;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78301606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78301606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jOCviDoU;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=XrqTGBFT
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9NaPgt3754667
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 19:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=R0bT
	kl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=; b=jOCviDoUV/d+SBS9+iko
	Dp+sdqHEyd8SiXDTjRw3mosnYhHzzqA94GjHpHpXbj2rXDHIWgTioMoMgs1G0vx4
	yYqCJ3+A5N6xVan0OOtxwO8f1H+vX/+MkPsPQJulZtzLXUWsW0C2Iie93T14f1Fx
	UTOxKmkFqDk68PQ6FgUd17ny5o83+WVj4trMpGfmWZwucNvgIbUr9sVuy0NEBT98
	CqbC/arbYfWLUWP3CaPG9vKS4HgBNz6ZZpWbS8gl+xVoa5F9YitxG9nKwg7xRjBF
	Uf6eDeUFBvgVzo7KYOjH7cW8NXmfp+RdKdjwggD8VbBFbCRBMlF4F3VV9d3EfhIR
	ww==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4huk3gk2ky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:27:32 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91eb16ea5c3so42629756d6.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794270452; x=1794875252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0bTkl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=;
        b=XrqTGBFTrTL5xWvrfRA27+gRuCxOHy0oPG4RJ2l5KKEoKFi4aeB8EHZxGjnjqRLtta
         YmYMDd7J5NA2v0LcX0iInhFJbVQzfuPm4gHRT9hQQu5dZaMjQmzEL9e34MFbZ1d4pn5b
         0cMKq0UN2bKJV8SvTkbPCnPCgPdZxYd0xxf3niX86bwqjmBNWV9IWOd1W9k/Ltix5WMB
         YPRCOnexxITdGKbgpYK3n0hKBf7a9RzZH1AwYfaK6VS/+FDRa30o8A6Xcz0J3jI0sXs4
         MqHg4BcRlv3+qfqCnYh6ff3lCJgP36QmnHuKP4r0chTXaX79Vl8AJxNpc8octS5AUBQu
         NL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270452; x=1794875252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0bTkl0ZeS10Rc1qvdgpvqwy+jnWQCRdinOmlNk+hTA=;
        b=0CTbiOhhdYC05VgapQvUP0U7/RxgNtHDBPfB79nUvZY8V+tzyBgvA76+9uu0qKCqH+
         zf2yQZHJmYEfP+FGWfLeBD7nkL38KVmcYs9eqJfSBr3R7I6lQA7yhshU1XAn/ogXyIBk
         z5TPrQTV9XsRATNITtQr74NJFpCvOcWSXW2DiX8XgNo3/bJWFogR0hEipZojW6NkqQ9C
         jP1YoXSmcBEZcnFcYT19I8wnnvAN9hdb2dWgABkFiJYe4uCKvHXvbmeIk4Gm9MZ6qvAL
         dwOT1cEx9g5t8XS5qnqFQmX+t547n4e3n6OPhBVm/lDkDAITa0EO63ZyeMkMvI+7YBdi
         YgXw==
X-Forwarded-Encrypted: i=1; AL+hErH1+x2Cwft6dNhL00VJsrjgEhjNqzq9PBquJ7KWzs4ZuAWmqGSuVi3ooIe+f34XBAdUfYxa3YY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jW3012otQO/3nXosJjON5a6zb9hWNFXYn19FjGQuDSZkMlZmx
	+jiMIyb2HC3oogEOKq08bJj6IXbcTN8ltLtXh6/X419SzwCyUB3i1IZxXvpVDwHKM3+f7YCQdKs
	DJaIqQEetxv9X8mt/YhtJgxnOzLu6YsUJ8cYqa7VZC4x4RKeqTDg/C3sDV6V+6Q==
X-Gm-Gg: AYBFou1MgM+Y5nxk8lVRtzCz3XZ0a3Asf35oDHSXzRZfX+P/DzlCNubCxIHVHfJV77R
	P1zBJW7zAYVSmmx/IoU67Hu3/NzsxW5rfpvunIxzSleJLQQPKpzYj5YkvGsAj+lplHE2daPsB02
	3JdoNdhe1YgtQPX9F7RwpKHW5MwJut8mAyiZ5Iw5qXja2lVBGcI2XaSxicA+yfTGBM/sIxnZSqN
	roqdjtG9VvrJ670a7BfDM12jqB6YhA2lo5+pccu9o/2lcfCwBsUGKYSFrYOQSXjPodz10RfdEjA
	T2T3IDkELiKrPMKxIoOdeZ64QTapQ9iawvrrHALuFudwtzJzuI3cR+qthycNG6xudB4y7o+gIpN
	F16RCZNipEXmWxJoXTXav42Fk3VbfVVmTugmes1TH3jY32X5NQE2w5zFZTai8OCVBeeAYV/Rtl9
	c+rmWCRC3VNz/eXi1/3HVb1x0chN6Jm/TKxq+P12YPx1QAAeXHh5Rqj8qDuDQOG8T0xiRy9vL8E
	1+gzljRd1/skNRfj2Brt4nX9OXOsbiNqSPWPSJib/gp21b8MS3Uj1To0te/sXCiwAniSOzLurbe
	ictZWcTJldEJHOGy92Vs4w==
X-Received: by 2002:a05:622a:2a10:b0:536:e29:e774 with SMTP id d75a77b69052e-555293bb0e6mr16117091cf.77.1794270451588;
        Mon, 09 Nov 2026 16:27:31 -0800 (PST)
X-Received: by 2002:a05:622a:2a10:b0:536:e29:e774 with SMTP id d75a77b69052e-555293bb0e6mr16116841cf.77.1794270451295;
        Mon, 09 Nov 2026 16:27:31 -0800 (PST)
Received: from [192.168.0.76] (dyn-160-39-51-212.dyn.columbia.edu. [160.39.51.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555091eb801sm10414481cf.2.2026.11.09.16.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:27:30 -0800 (PST)
Message-ID: <0bf0a413-7f7e-4701-8907-cc44dba4509f@columbia.edu>
Date: Mon, 9 Nov 2026 19:27:30 -0500
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
 <a002901b-715a-4adc-bdcb-7a6fcda67711@columbia.edu>
 <a2ec6814-d3d3-425a-b379-f99b219aa55e@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <a2ec6814-d3d3-425a-b379-f99b219aa55e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwMSBTYWx0ZWRfX5pQP7+PUUF8u
 Kcfr0mYeNR3SrkPb0Na0Q/6GXDuBqLGC3T3OKFfxSR4kmOwboyvp6yRx2/INZRXFRwsttk/QQEK
 z/HmmpR93RA222gTiO2rsnUqAUUVi0st2FfTJWcJlFVPHqYs0DiD
X-Authority-Analysis: v=2.4 cv=RotQvymK c=1 sm=1 tr=0 ts=6af264f4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=l9izRfKDRJJ6Wn/vzKnQSA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=C_JoN6WlG-creS2BCkQA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: r6k6PzSP3rev3JAgCGr4Dl6XCaSNhBTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwMSBTYWx0ZWRfXwXgRjKs0pGNC
 Xmzu6le+z5LGC0U/3/V5qX3URxKYLDj/RLRoKJ6XaVfxEgfldXB1khDEHBJe9VjpeKUEwHK2F3S
 Kur1V6kB0ANlj6hn3adf7F3AUfNOAgjTubxPrObPruHrgIPfx07y12DntJ3Jm9MzVGpKVqEizqr
 oJ6SkjveRRLC4ikoo7g7Bwk6z8LH3Q8eP3TK445UdAZrkT91/aXxbJ+lGWUD2VZXZRq7tUF2rXq
 2uiOmVmk6ukyO8bb8gn1j3RrJxFZR0Pmqla7nbfbnd0GrtiRIOMZuJJbtRFATnl1ZkP0nQuloxi
 FYaUl5qpUjQ60N/fDfNwUHSSn6NEo7haYZMMeSv+Ky6lPOhVsMgEGsHtMUlTBCvz7wItwlfnyyR
 0HaaRRL+vIEzKAA3Zf7F92RG8rrOYuDh1j/DrYhewHwHmEW19bRNIIu71mbnAlMDSpBsPq6KAsD
 ley7ia5BFS0hTlCIfdQ==
X-Proofpoint-ORIG-GUID: r6k6PzSP3rev3JAgCGr4Dl6XCaSNhBTS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=10
 lowpriorityscore=10 adultscore=0 malwarescore=0 phishscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100001



On 11/7/26 2:41 PM, David Hildenbrand (Arm) wrote:
> 
> So the right fix is to fix that then.
> 
> We'd need to sync memory_failure() with memory offlining, correct?
> 


Yes, I'll rework it that way.
Also sorry for the early v2 :)


Mani
