Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981883;
	b=tBDY+5SvH7dzfSQwNcn03zMKn+DJAhpH5Z/jwLXEJFe5KfJcW3gf0fuUVvSILUPBtES/
	 +k3fvApBFuCAHXz7rRN2z4Ti6tdnatNIxSj86nkaGWmB/G0B6sdsf3EHI1EaOIIPKiXSM
	 hYG2hVhyk6ftGQx0kb3NlBz0Hf0z3uop11Di/jeY+zGb23y+sC6898jFPjtSmfmdxdOVT
	 CDZ6Io6N7C6K3yew1LovlJOwSC6unO56PO1YKPmw4pBc0PSNF7nU4QZghbFNaRulKfQJS
	 a9Mj/RSmdUpKF0QEpKPkIrUj7mvXs2XiM+HJT4kv4qR6KW726auVz+X2xo5zQFYLzPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981883;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Olb2PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=;
	b=k2mOr9I/GZmjbH9hTRlIX5FsCHrY5VNAh/PFnoETIy1mdCuZ4OI0pUh6GMw+qHBKwKyx
	 vaRZsqxqVk8pEwqg3aaJbtyNDqigv8u6XjrWDu/ipsmjdDUbDe0aUskav/gLyE074GI4A
	 T0tBWbchaYxAPZgzP7yuuSenxnRFkCSvBOwox2gSCougj6vhoeeJ0LlKmRaGlE6YSZenr
	 B2m6mcgG+4iZlrbWrEa/edonkU9SwBF/25DQ6Ozda/2sfIAsc+CrgidX1+ZurML5IaJ0T
	 3zmS68E508lASlY1GSQf7jHBieIaslHPNewhmQhRVPzNsMDkJUQ0hbTzIVpmltYiX2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=temperror header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="hgTjL/Ji";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QUSmsZCt;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F1606D826
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48F1606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=hgTjL/Ji;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QUSmsZCt
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FhXW72567227
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 11:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Olb2
	PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=; b=hgTjL/JiqI31WqgneDhZ
	0QZb7smQM9Dx2axu7QuG9gkXMcso4fLw4hbRvQ+6XLhZCihsk8tJLPqkDIzn4wvw
	UwbrCe0GGDAEAS6TBvTWOIkBaw3gFD96cUlIjJDQe+7wjiIjtuoehPb2/QHPnhLh
	QNADb6psCkQBHvz7mYa7mpDqfcD7fILBRKTttHMNN00NDpnvSOREow5wdekasHkt
	KkyGK3Hms8JbRenQXE5fun5v2w2Q5HbyxZc9ZuGU1p67q0xd3tECVxaIiXcACp78
	ZwUVRm2DX0dEybUju7gtJaU9IV5vGoaxXN401XU3gTTEuxm/wqNjEj6XW+3o0pyo
	rg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hs3pcch5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:17:56 -0500 (EST)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97e8be2221eso155285241.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793981876; x=1794586676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Olb2PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=;
        b=QUSmsZCt/RQlqjl4nZA3MPJhGb9f0YQlG1cET4a3SSMHs+U2M2inWUQLEhrS/8rahg
         zwsy3iDL9uJ38ZOr7aC5A+9oA4qwzf/C+MHFjEncz+wwxYwggCzcffcPOunowa07182i
         9knyGK0ys/noZbQ78rgInWoGyjFxatM/R4y8Nb7KhJ6kPWSTQSycVa+ffPKflmaE8m0F
         apm8udn0ujmswV5I/JLEAKf9rCXKc229P5TRvm/f6Zu52oNM8ST7DuMwnqyw7Ag0eVQN
         rGiSExtdFZ3Y7xCEAssDQuB6FlebMgtRsDlgNPIJjePp8vjBnjXL6HDeplU0FAOJ+tPX
         ai9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981876; x=1794586676;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Olb2PHgsBhMTLDa7xs2/HL909OsHQObSPGO3kPeXsXk=;
        b=z9d5IT24Keed1yTXAdTUOmiOFdx3bazj15XeC+R8jSj/Exxf0puvgv3hP67iC61u5x
         G02Qk6jGVwYaEY3WKDOZm5QUeldHUcD1/xiF5qC4yS+oKTYOw/yVZaoGjr0LzNByIN9/
         0bU+AaIYGezktjGtv6fXRvmPtVJSZH7ZFkzzYDlPH8LlV4CfCK6Cwtykf2wXA2v4yrWZ
         2PApVq5oDeBRyL+ns9jIjEG50aZhIoLav/wvxAGM5yNMxRg4JEGUVLcqSB/l/z38G94S
         quAfeIdbLqc8wyoBvWpv/ZBNZs50Xdv4gnbxTpXCEkVX8vri63mQfgGr8xeoVLg0EalY
         0vpA==
X-Forwarded-Encrypted: i=1; AKwUvBxB+HhoON4CDv+OPwzXHcIkpdye2YryIHVJla/vlJ29AcGx9y6xP45iRvc3D1IwH5ojSRpwm5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VeyPIi73wlQEaTk98aDCd/gZRY1YFX++qwa+oj5wwzkCvNoD2
	vlFYUK24FBdgDuqt1yArn7AaWHm7gaIeji4sUvas6El0SufsusRIjdT1paCZk9ou6rk0R/tN79W
	GJDolEq0AVt54g+4Nvk12sLVJE5ohS1xE1rYBiKbbJv2uPhq78GNnzw==
X-Gm-Gg: AYBFou0jzbMUZpBKKQ8PVEIz2kJ9xrxBz9VhW52VaLgXDfQ4yox76YPyvC+gjDmnQfz
	K/2fREzVuc9gh2Mgp4jO+qfFHgk8D2qZrBBtCY6lUO6Nn8S0HLmgpTqXyY9PuBHbY51G3i2u20s
	Sn1TEczW2QTb/8oYkDc3Qhq1ltbPtecw5lEojM5uv31y0/214jcz6pdno7wia3hLPbLr9TbQJ2I
	z50UlOCCY1zoIx29OAuXN+fFQpxiNfGDsPFQYoEWTt366TSfjDUJIH7+1PATgij5CJc/i6FLk/L
	znNYYXyR+4D1oEeZKBEgVixIHsvUa4w7P/vwHF4lZCzvv4Qlv7AuhirO+1I7XDmEgNUUBJGHmmS
	PrGqBTXiWTlmjqHlCSeGb+EsW97D3snOuoJwupk/OQMpu5DdU5Tllc5rxxVi7cmbCeKDglWnF8v
	C5/l5i0gKCUhlNE/MCX2YjqY7Uv4BpDTnksNPvAYBraTaUtc8PCGqoaouplwWBoZZ82T3hGBHDi
	n6pzVy2/c0CN8B6P+wEPSQguzGHZqMdQj//0h4YVyj/uTfU0DKRXveROnR8X1f6
X-Received: by 2002:a05:6122:4b1a:b0:5ea:f1eb:b9e2 with SMTP id 71dfb90a1353d-5ecc4431e14mr1609536e0c.19.1793981875719;
        Fri, 06 Nov 2026 08:17:55 -0800 (PST)
X-Received: by 2002:a05:6122:4b1a:b0:5ea:f1eb:b9e2 with SMTP id 71dfb90a1353d-5ecc4431e14mr1609520e0c.19.1793981875395;
        Fri, 06 Nov 2026 08:17:55 -0800 (PST)
Received: from [10.206.221.57] ([129.236.225.236])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a5ea5sm1678794e0c.4.2026.11.06.08.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 08:17:54 -0800 (PST)
Message-ID: <c0a08333-c236-4e41-867f-d94bc34ede6b@columbia.edu>
Date: Fri, 6 Nov 2026 11:17:53 -0500
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
Subject: Re: [PATCH] blk-mq: take quiesce_lock when removing a queue from the
 tag set
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu>
 <b7d03393-79a1-4457-8ddf-e0d141e4b3e9@linux.ibm.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <b7d03393-79a1-4457-8ddf-e0d141e4b3e9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tfvEVfMROZEHeDEMv-8iEye6L7v3tiiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX/9peHFedxqd4
 lFQyvOK1lgiCgBYDC7pP2doakvOjijVGhFIqVKi8emrxVCoAwFs/9/tZfa+EiHWmVPUEPatELKj
 wqfYx/KQVo2RwyAtDeTIMLs2tH/6wDBiMWwMnMPHIz3LrJpBNtvLIgMuJ0d8lro7Mx7cb0pngCr
 kKkY0TIpGlccGHqQer30Ioni0f3DVc/gytU8XMd2gQuLuqh0weKj7hQhbY2QYPNcThmAM3cGZ9v
 IKxZgnsNQ8eV2SuYRJ1qsxI89yLri1gdS7cRFlXsxyhJqsvp1uV37pmmJLuqCq3BhZL7TNdqndI
 yUAK1fQZF4gww/BfrKxJVjJCsseS9RhQza8xidtj1lK2cQJJp1RYJqTdsVCNfQJ9IsHPJqzEvgl
 5Q7/3GsgTSznsE0QLy2TjQRQBlzNGfj12D5tBqGjILUs4kbUWbyZuwVakCFytegnQuRWG4xvMEi
 +tq03MItpgxO4YrIcGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX8JV4OfeyKhjv
 DnGQG7hsIxwKhOWWoQn2SZhTBF85QQ88O5MoifrIbpmOsWYbSQtVr7vXH0NmBEsyQGJAOagEQLz
 nj3NAIAhHI4hutgu/GusmDcsRQk7ehq9bYQoKlv9wzdwENuIMDR4
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6aedfdb4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=Z1ioWkiWWmTAar9A4mwgfA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=EY2qA-gEnykLEDzTMWoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: tfvEVfMROZEHeDEMv-8iEye6L7v3tiiT
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11958
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=10 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 impostorscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060064



On 11/4/26 8:19 AM, Nilay Shroff wrote:
> Now that set->quiesce_lock serializes both traversal of set->tag_list
> in blk_mq_[un]quiesce_tagset() as well as modifications in
> blk_mq_[add|del]_queue_tag_set(), do we still need RCU protection for
> this list?


I don't think so.  The quiesce walks are the only users that don't
hold tag_list_lock and I didn't find any other reader of the list in
block or drivers.


I'd like to keep this fix minimal for stable though.  I'll drop the RCU
and add the __guarded_by() annotations as a separate cleanup.


Thanks!
Mani
