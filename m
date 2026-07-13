Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E97299A82
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970511; cv=none; b=ej/hYoBG8UmQrLkP3LY2OD5YrE5/z1wIY4oZgZSjyMh5+HF8Ht7KTtNV7jG+5QtTF6s+r7Tz3jBECVZ4YBSpJCkNPrgnc4LnRaDwA3uULjcjSkYfkwtUQCV7Ot9zBROfRaQ/CMvYwdaYfZJSaoNbf71YFwqliHSGicOdsiWxEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970511; c=relaxed/simple;
	bh=6LhmMs6hd+KSZYCGAq/TMAbEdTqYXcrYq1DH/orpYdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndhoSQ2aWmfOHo9GSaOwQzWw7w34vWvsgJ65Y0OFhpJ7xyzKWeZyjesMEf9pbcE6pkaKTPtQX8c+mdut9icZ7yaECG4qTQs10MXDUmdG7SeBxhkpO63O78PS+2M6zP7iCb2tmlwt/3SQsrz1ryD/bL4FcOullLfyf+a6QAk/0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fKrvpY4u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvnEZyGW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fKrvpY4u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvnEZyGW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9P7L2256696
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gv0EQ18+ZmfZit6oXwIeJv6aQcSqfBZoI0pZMq+t6LE=; b=fKrvpY4umBBDZcYc
	LnpopDJ4yAtfDAx/r8fwdN2y41K+ntfE6biQocPvdCDTjewXd7phctPYfB9dyECj
	quTxy7q2mSAogXu0sG9oAGUE1vo7ciRlLx2i00DxAuKd71lFxM4wWCFhSzaMfz7P
	G290R1F1eWf6Rygb9MM23yXV+aSIdf5Lc21012vNQxjRwMxTr0yo05mZokUjXqYF
	EJpgbWO4PK3OHUVrKYTAjF+Qyx9HJHlCn9v+VMpdjzhgP6z0rMEeyrF1AVEWITFA
	OCMHLckPX/XT/Ac4GNLcP7ffz9hisEK7oPKrjXh2oiqLc2S4p7uCLv/WorC5KoEC
	2Iet1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9t9a9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:21:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38869800848so5553851a91.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783970508; x=1784575308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gv0EQ18+ZmfZit6oXwIeJv6aQcSqfBZoI0pZMq+t6LE=;
        b=cvnEZyGWL+OlbM84Fabx5tWefvDdgE2JMjlGj8W72/wZ95jXpF/KH6syjtcDWSPWEn
         UpJraua4h87GpzHwNaqQ8fB9T9dt1VfNgukmdGYKXA6wxrg2P9jXHvvIHSY7C5v2yZiD
         EY9Ok/YvWsvplGBwrZHkBaBtXkqgoYYrHOYaR/RwHz8W/OymgKi7/IAKTEwDo3GM5wFM
         uhsexK3DzZImTWtPIrpF474HAZJVv/zw6Z0zvKSm9lLWqPhGEQm4DvJYU+nxgm96yqtN
         zROJQWcGlhYeOeAz8lW4VV1dZQjnuhgmK6Z4gukJESe1QR5cuJnbTgN9iHqgNPKiJOYY
         wE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970508; x=1784575308;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gv0EQ18+ZmfZit6oXwIeJv6aQcSqfBZoI0pZMq+t6LE=;
        b=RPQ+7P38MeY3iePJmnPtbnXcaZn6u3lXQ3oEUmUnvQf+maT/T7VppSKqw5RohBEDVM
         mcyvxRyzR+ZEuOjeF/F0eWQS5RphcSa7SS5ndfCGosjCfKnbgjrMQLwg3pAv2BYa6Ipr
         DzYO5wSVYnBsLSxo2eLxWPKFeb44VJJeoprqkoUCtUUkkJ7zm2j43zbIxKjEjgGqJgju
         86vOxzlwGRoO9KDN7zJPJpfB5kGhnhRLIfODv8k869Wcxl1BQao6s1y8YquwygIwQLIg
         heJl/62Ak/0NYz312nV9q2E7EerjYhqM9ki3t8MHZvGF31xPd15qzYOzV/rrh252ctDt
         wCow==
X-Forwarded-Encrypted: i=1; AHgh+RqXcBqoxnvOIc07TZV/5N4zSyFcHbEWO9a8jbnWYX1Sm4VBqwME67wuQwim2+Mqfp4FMuLzPbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2fwY9LQ+QBNd8M+Z53OL/ZVNZUUNkLrphpthMZp5xLdeFT7Y
	zOqNSoFgg7fM9rwRObyiEOi1gKzZmUyVm046v5DM6lmrHKTs5jNqWSf9IEB4RttpHGoB7Vyouf4
	7XKGgoohGWFnaOlXMIT/reW5QoE2rX5xfRv9kk1JgDriTdpV6meF5PtPzLY4=
X-Gm-Gg: AfdE7ckHqXyBqdhgSK1HAWxSjXt1bvGfUlWC7Ovm2EXs1AEJ+llSDYREKc+buL+jwL6
	8XMCZ4Yy43NR4qd3PTId4lpip3OBRFyytXRqfUNBfGL+diRJNIhOIDFhKkb5Wy/u1FFsiNgGNG8
	HtQHn+R+sBrIsiLkxvMY+zXLGlPeGS2tssSa+EFUlry6RWhNmnI1bm0ujhxyvtCM0US4vvWSDf5
	bIRwD26mSUehKTbxhm6h2BiNqcHqY5xJS+xdai1buMhcS1vmj0LGMGi0LkAfP2hS24BPWotb9FI
	cyfSSnefoR37xcIxref947ESamQeeTqUzsAYZbQHV2iI5Fd9a6RabN295l2cs7OfieClvDeKmkX
	HcDdlnhLZ1h/2ffSVm2W952z1xZsxUJerDJy4y4LZgQ4oqeD+QERkG7ohKg+kYNoBD0sw
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr9489011a91.38.1783970507919;
        Mon, 13 Jul 2026 12:21:47 -0700 (PDT)
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr9488989a91.38.1783970507346;
        Mon, 13 Jul 2026 12:21:47 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm55950750eec.22.2026.07.13.12.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:21:46 -0700 (PDT)
Message-ID: <b1d96a25-e2d7-488e-b8f1-6452f4d83bf7@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:21:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI
 connect event
To: "Doruk (0sec)" <doruk@0sec.ai>, linux-wireless@vger.kernel.org
Cc: tristmd@gmail.com, johannes@sipsolutions.net,
        peddolla.reddy@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260711071336.58324-1-doruk@0sec.ai>
 <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
 <CAPdMp1okStu9UiWn-Kb4xrTEdGj1POT4t+moh77JHpLSzD-pZQ@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAPdMp1okStu9UiWn-Kb4xrTEdGj1POT4t+moh77JHpLSzD-pZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMCBTYWx0ZWRfX/+gQkbFeCygQ
 K1tkCzMIPjn0S/anD2uWdP6K+R3+zIoSdS/ThUJAnGbQkKNqwGKgDOutE64pwhr0+OSeesM8nPY
 CxYk8AamvCZGFIQw06NuDfsSW19xuJQpfXSfW+l1H8f1K8YJv//UJ+W0UnlKbGqvsjyIMl7S650
 NQpXNnHNREvI8gCI8o4B2VKGe2sFxnyzmTFLlt0jl2gwjYc5L7C5xObaM0esIOoFDiuX5jq+xFN
 gEsV5s2tRwKqz+MkIkHhJlx+pzOfGHa/jkqAKophlPvDSoAYb0hKNsyHDsaag6K4tk3UjbCrAYo
 Unrr9xLFQhpdnWXhruH/x9ExNvxW8sX95IMQO/Euza7b7rXqBS+i5iSpJ6OHP3qnwqzOoEcDx/U
 kUB1SY3CnZL6fJKtIHvWxr6XZLqIFXK6148xpR3U1/KAcBw6WE0M2rQjb0O2Jl7oyb4JHAh49Ok
 VZtplmYJbK7hVKByZZg==
X-Proofpoint-ORIG-GUID: ZndF8zcOXhEw5gZAv9kTTiWCqhZLvtYG
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a553acd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=PVemK8KFIP-Ydl4GPKYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: ZndF8zcOXhEw5gZAv9kTTiWCqhZLvtYG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMCBTYWx0ZWRfX643Nv+9lgFRr
 XBhYIE8uaIaNBNpcUdsE8aIp6jL1St3cjbbvPS8Jwa7FiwE19PYJm/ciC+UUD5so7x6aivGZFpb
 QcUl6OurDYzR2X4O7OtHAmGZ5idPXKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130200

On 7/13/2026 11:18 AM, Doruk (0sec) wrote:
> On 7/11/2026, Jeff Johnson wrote:
>> Some aspects of your patch are already addressed by:
>> https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com
>> So you will need to rebase once that lands.
> 
> Thanks for the heads up! One thing that looks like it may remain after
> Tristan's patch, in case it's useful: the aggregate check bounds the case
> where the declared lengths are too large, but ath6kl_cfg80211_connect_event()
> still underflows when a length is too small. It does, on u8 values
> with no lower bound:
> 
> assoc_req_len -= assoc_req_ie_offset; /* -= 4 */
> assoc_resp_len -= assoc_resp_ie_offset; /* -= 6 */
> 
> so an assoc request/response shorter than the fixed offset wraps to ~250, and
> cfg80211_connect_result()/cfg80211_roamed() then treat that as the IE length and
> copy that many bytes out of the small assoc_info buffer to user space. That path
> is separate from the aggregate over-read Tristan's check covers.
> 
> Happy to send a small follow-on clamping those two subtractions on top of
> Tristan's series once it lands -- or Tristan, please feel free to fold it into
> your series if you'd rather keep it together. Whatever's easiest for you both.

I've already landed Tristan's series in ath-current, so you can base a new
patch upon that.

