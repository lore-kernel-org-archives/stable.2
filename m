Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459980;
	b=e7cQBC7mnRU23hqICJCqIaZn/D22V3PnQiaBF+WNNsrkLpyp09WNV0x8MnHCvYAwwBor
	 Wofhf8vjGVhu41CeFggb78rYQCctEHoxGxm7L0UO8trqMjdPZ1yhhDhb1QiOeRsSlEPeN
	 Aj5ifinb+R2GrXWymH0G0iFL+9kQvzFf/5xPc5nTQj7MRo7CletktRA2U+v2V/+bIXwl+
	 l/Fdb8ZpK4s9x8iQdwZYHS48csKfoeDgHBSxD7lXimQJILHwabQhy1Q2z6AvDhPcCoJGW
	 ipa7EQq3AR/fLVWo5ejJEv9nXrUzcQskyMMS6lgVHyYHVWcdh7IXDi/YPZ2+zr2ypkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=P6R0QSCNbNk1SukQBtyG2ylmuRMbEBKxpRVoIoiV3uQ=;
	b=5D+++ftOXFWLGDo11IZSvBqkTNXzRpvVQjUedEZwFXWLxCnp4rOVIoiuXh0Moe2drOPZ
	 Gde/Psqq9m0bkHY7/1W/cu0MTA3vBaXc76Bjsv0tu3XfVmGU/0qKYBFQdnzIhXUDLGrLD
	 IdrG3rnrqHhrdWOc+sXqEh6otlaZpPkNHa2lrMYf3Hlka7ZiTnwuvYibpjZbh0mt6Oajq
	 yKkIRmn2bl+OTWTFGmBqyjqUBNg+v9e4MiR7g63zPZjONq4VeHZW1OviaPuJW0OajU0rc
	 WWoevb+IfMr07uzwDuovYra877abu46mutz9zt+NDj4DDUfdDIQmSaWJtinxb0lmLmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=temperror header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gzuXgMoA;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GaOzzKHE;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363A606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5363A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gzuXgMoA;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=GaOzzKHE
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANHXsGF2997913
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=P6R0
	QSCNbNk1SukQBtyG2ylmuRMbEBKxpRVoIoiV3uQ=; b=gzuXgMoA+uckMmlPIc5p
	OHUQNFI2gJNlzZrc8oyiPkXdE2EiJ5o6d0vzLCVftfYXFPDrScbG7mSP1PZWXMku
	arTqF0eLNWJC7iW31YXiJukQwX3XY04g2sgpmnBwMLr+1UwItPUtZkgDKLOe7OTP
	ANkowItWbAYvWiZ/ON9u+XZkU2O0lqNtZaD+ea4p0vPJieNxB5L4kw3ruDkkyBzo
	GnPT32C5khvaFGQ0m+YLlByja7KJU9OHfst03i8b2yzgEVz7FaikMZTx3iQwxfgd
	s+yxwPXyflJ+bflynH1xsA5ab+QWEUQk91ZlJ+PliG4k5tzZAVzkicCHVSueY3X3
	Xg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j4qh9tkqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:52:52 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-544019b1831so76287201cf.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795459971; x=1796064771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6R0QSCNbNk1SukQBtyG2ylmuRMbEBKxpRVoIoiV3uQ=;
        b=GaOzzKHEwQxX0kp8JHsriAJ3PXU46myEtnkvBrRPHiFl3c8j6XG6/7X4qfpJZm85a3
         uPb67ZIw/acO69+Alzo1dt5Ibolgub4fh0BlIJu6w51sHPopt7zIr+0jz4CMncvn1LZa
         GXFGAn10qyvaF5fvKp5RwW9yPzeLxs9jKXavuONdoRgrcmUcF8DGjzadLB/0Rasrs0Oe
         4VVpKX/Jr/B33dOikiu2sTp1ULPUGah5++fHoz/mB4/nPpiMfLFRFVKxU6O8f2ExCMWO
         zuZ8+o2q0hPymqLm67NAGaeFkJpr2xBwmWQPLH9Vi8mqXtUGdXBJ6TeGnR5lYVFgYgzV
         mT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459971; x=1796064771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6R0QSCNbNk1SukQBtyG2ylmuRMbEBKxpRVoIoiV3uQ=;
        b=1tEHt+lr5/jRr7ThxhmtVPzi37lIuE8Y9YXO9GA5C2ojyE2UNB8ZahrwDmagWNqYdW
         jjeogx1hgDaDk/vmzK2WpVJbYwBHyv+G5dhJjpeoivgfdKiRzZV1bqLvU7bAZAu/tZuf
         Qi4nknDbukbTxN1ap5sc/W8tzB40FuORqo1ItmmXSnBPU1oEmAk21ah0etcjY1tWB3ps
         Y2o6hwg9EnnzkcUk66LiQES6JqFp48GMadAf6s59TTfCf7gqRIdqTCXCbfIwpzZJEnYP
         3XiSDD2PfBCEoqwPEmEUb8p+ns16T92rB2V9gszOCzMubZVtpsFlxXyj9PyuyNHbBzZx
         gO7g==
X-Forwarded-Encrypted: i=1; AL+hErHCLIYLLHydeYwzsKMBTWE5+EjUESSP/bxyrDUojhmLS+yb0tuqkOoNUhHqK4T+8IReIOzFccM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cBLywCngSh6aS+ZA6EbdXZxJmKpgsn9p/pUmfdc8PWTfobCZM
	TbHBLyGoxgXLHhojomhszDjbezpHvG2DJN9mfvw9T0ghaQJ04aNkfZPqZJtSaBhP74IVHE9c1s0
	3zG1buff1uujtmG1dtPnVGpFydBQTJMfBT4wx83XHY9X0aA2w9uQfZQ==
X-Gm-Gg: AZFdTZdENhIV1pPBvWhw4G64ny4z3CIIE7j+/a5+H87Vn9BaBJrnmgzYRndqkOGwon+
	SalCf6yGELpZ/ZUAUl7dDD4pEn6cGSSa0O7pfStbAcwep8ds5ujPEa4DZhxi3ommmkGKOG5xTlD
	oGKWBNpr7oDzgXeP+Lk06UBIrQVQHykwtnW5XwOSco4ji5PAFkVsTCLk/zgzmZdMyLKcstnehvh
	+sWLDBysHD+zw/Pt53IsNyn5SgtLakmnoqgdoWpm5AbWTsEV5dKY86tIyENMP3M8MH0pKsaSGd7
	kNUDnR4A1mrxIR9SfTppxfYxrcq72QBBlyYOOToPQu2UjyYzWK1TGLudBX7rpWIa9fg4JzL3gb1
	G06GcrMPooHa6igjRnbYMWpz5FNqcBU4dyjPO2PSbxoUQG0sROEW9LpEtoNBg11XabeAFsz4k7H
	iDPj/e54yMFIw476zFQNlJeXHS76jMguzM8fgJwjHP1rP7PSnWKk0TRO3cR5RjdnPAloi6XLZbR
	N1u7aMcDKzCBtB7KqgMSg7pjL74f6e+Flgvw5DNlHGRpZRpsDQFcXHd8XWXI8nr/RY=
X-Received: by 2002:a05:622a:4d96:b0:535:232f:ca25 with SMTP id d75a77b69052e-55d7698efbemr222965791cf.7.1795459971442;
        Mon, 23 Nov 2026 10:52:51 -0800 (PST)
X-Received: by 2002:a05:622a:4d96:b0:535:232f:ca25 with SMTP id d75a77b69052e-55d7698efbemr222965501cf.7.1795459971100;
        Mon, 23 Nov 2026 10:52:51 -0800 (PST)
Received: from [10.206.149.246] ([129.236.230.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788116c9sm106773881cf.4.2026.11.23.10.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 10:52:50 -0800 (PST)
Message-ID: <56de516a-c895-44a0-94f5-ea7bc5bd3ef9@columbia.edu>
Date: Mon, 23 Nov 2026 13:52:50 -0500
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
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <77680005-7178-cb1d-6e20-e23519839222@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=We+Z+EhX c=1 sm=1 tr=0 ts=6b048b84 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=0AiHgshebfoioin7TVvpCA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=_vlgSMKLg18XzmzXuwUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3NSBTYWx0ZWRfX9zmg3hsNK3JJ
 s85kv/XnRw4qAaQOS7t/QK8uZyu/63GIu8v6u10xUCtDVzOoxZ+0/O9g3I1lf6xkM7J9qnSbvC6
 ISxSnokkJojFlz2Lm/gqxJTHWFT2+PpirvwVWsUepcUGzGA9Mbag
X-Proofpoint-GUID: XHJbS27nf_1qlMFGdRIeRWH-EYUc3T0p
X-Proofpoint-ORIG-GUID: XHJbS27nf_1qlMFGdRIeRWH-EYUc3T0p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3NSBTYWx0ZWRfX5CNDUTJPQqK4
 LqtzZr7xNGzhD0tT6fcjlvbbMDQYzNSvaHpOR7VtXWYaCwfmt+H0KpQWeHXdluC2B+skPUfaeX3
 /e859tmmBmnV7Z81NTUAjunnTFn9gFkRq4Lz5FcWSu01o6PHT/sd4sV4ObpUnEesiYES818pH1+
 xVe7st2AFaOQ9Z/ns0RUKWv/M9xxaVAlYtpm9r4nNGDOA7fwyJhJ75dMJFgX0k6kpv3SDnFxMiW
 /1DTnTqB5Hfj4l+3K29S4g6gCpmgF0a0HO9cer310O4n6qevLwTl96TsFa35IeTZQ4j02qQ0/tC
 eH+/v8mF+LlDz1aCZ57kd22bXz6Q7tsyHnrtBkuTQTWQWBIwboOCW4LXHcJbN3vYGtHpSpsB1X9
 8gsf0kN2cJfcczH1V0w4fJWshOLgQMCtc4nEWG+m+YqKIYNL4jp0vHntaSDqxvFjB8knfIVU40P
 BR2+FzdGsBpzbaWGniA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11975
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 priorityscore=1501 phishscore=0 impostorscore=10
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=10 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230075

On 11/23/26 2:26 AM, Miaohe Lin wrote:
> If P's struct page is past the first vmemmap page, the hwpoison flag is lost. In this case,
> do we need to do something? Now that hwpoison flag is already lost, I don't think so. And
> TestClearPageHWPoison won't do anything in this case. Or do you mean TestClearPageHWPoison
> will always write even if hwpoison flag is not set? If so, can test + clear do the work?


Yup, that's what I meant. And good call, test + clear works too.

> I think we can correctly clear the stale flag from the first round.


Yes actually, so just this under Muchun's rwsem:
if (PageHWPoison(p))
   ClearPageHWPoison(p);

should be enough? I can do this for v5; sounds good?

Thanks,
Mani

