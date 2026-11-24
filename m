Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489810;
	b=YC9LVuOr4W5eYHZgU03Dh677I7tgs0kzmnC8tvq3X6hf6eXM4Q7N7qzBNVXDkr85colQ
	 iTHVp+WiqpIWqe7HEdDrczlZaKQwqveY/+owkO5rCCsSsG+fKb0NF3/JQSqwgn/vJEIjr
	 aSQzKerEfmLofyjP2fDdayBN1kabibQ9Jsr/8p18p5SWRzaI+mZL9a/kzEVJdkOdBiKyd
	 9F+F+Evn7O8jiuXTzDBDtp3SiQo6assg0L35Tt1CJwN7tKzXfgUhYiXqPMRuDnL9Bs3bF
	 D+RzcvxaE/G0289N7M0CIQE1HLmTSkIpGL9z9i3LBkowbx9FEIT/h+Mcc0ESjTWpXlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489810;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0SW+r6INMyfKAJrCWPlacgZ/AfP72UDcjJhb3l6CPuE=;
	b=J89cpZoNi5lixwhZY+iTtcMSlKDALYDRKy9o875f8RAC5sHEGBP3hH9ewP0KJs9cdaWc
	 D9tDfAY5w+uB1xr30vyUgPINyJJWaxSKTYx2z8sSvLCIe06ytSlS6u/EeCySkwKrwZJk2
	 u45nnMUz4L9AhvRzQVCs82uAHyrvXm6NogNBNvSz0lPTL3Cbo2I4XKzEnQdGkARyb8DUZ
	 N6k9R4FnkzKZcFwd7NnH98Te/IeL2j62rmDB9+dxm454un+jhfkwnn0Pw+bfG+eoeVGZP
	 d8geFCzWjK5jIoqgZ5pva84qRIvnLcGhINSHRwgAGe6nFfx93ku24KYprdSJyqfRjjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgA7F8vZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxha15Ko;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC7606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDC7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgA7F8vZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxha15Ko
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k25A4128993
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0SW+r6INMyfKAJrCWPlacgZ/AfP72UDcjJhb3l6CPuE=; b=SgA7F8vZYCl2eqhk
	Scqa9m7Y0kpz3s40wNs+bogYGfHThXyha2bNQyEtkVMHWn/0n/DTLJsdWVdAY4Bo
	Rq/WqAamOTw8+2Vq1eS9ARL7XXIsfEiIGk2o0eMQ1mGDqca70DLOtO8s/4Q/oAft
	48RYZyyTprsBFNKz6euynZEp66X7iOAuYnHO+V9CW8dAVoUrbYZtZwqMy1jycfLh
	Y/W7Ar3N2uGbJYPCFifapmjIiBeLdqLOXbz0w+gm0r0MGC01mUPPSlpKN6yqm6OV
	hf50Zb4DRqOBCLKvgL0qMcvqutPcA/AsMi1H56yrWUOQB5Ztv28A/HR137/tfH2c
	k9kCHQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yyt0ft4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:10:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so4453749eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795489808; x=1796094608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0SW+r6INMyfKAJrCWPlacgZ/AfP72UDcjJhb3l6CPuE=;
        b=bxha15KovaW9h5pv4at8q6iqDyGmb3/N5WC7A20k8Z127RD7v5VGaLgApvhPV/U+M5
         bKadqMvSffGSWSz/psegRwkEK9R5mosT5DS0mXv19A5eAOsjJcHvgAb/QOK/XLxwANAg
         z/Qg9d69Fg46JuHmkCp2JMFrNpmnh+dnKq0sYOCt/gpu4sUKRRGyqzspUcr5VuoYRCRF
         8KQ2HFJo+ZKmtl6wmyjSh0Zh/R6bY3nlzfcAwfwcuAsJJhRd5hcGV4E9qfiW5IYktnK9
         wjevLybuEUK1mTvQ8tcLoJ50MmA6we9PJIzUzRnX34+VSwrmechCFpVmm3M6hm5MzkPE
         p1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795489808; x=1796094608;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SW+r6INMyfKAJrCWPlacgZ/AfP72UDcjJhb3l6CPuE=;
        b=PrbIHSr2jf7J1Wgypnn10XEt+07ZEiH8yy1gVQmhFRaX0AWmpJxZUxT4f5y+lk5cYy
         Kucy/Cn7l/N0BPpdA+C0tv7APDSKYqQe8iG75hYesxSktan19RBextHbtqFAPm+OoKps
         d5Wtdhirx2k2pYvU7qX9qcXBdb+t+eo0Fw+AsXSuNCg8dQzCEDsaDy8d/xMTSJfcjbTn
         nBGmzQ2ZA8SNJyeAiPnAhRo+WEnfq3c0sO16r+/IaFs3CtybtJnXEQQoLKvkkGBYeEUR
         xFsMlHxRyGh0Bw55no3ZeE+rSD2jaiEunrol6iNjgoVtnTfa66SRw5SsRJXCk4MMO4ah
         4bXA==
X-Forwarded-Encrypted: i=1; AL+hErFE4ICzB3/6TVT6rDjHve2DnZ+aLQSEKZLeHy83LwImVgaVlV5lekdPJoMSCc92LV995P6+gz8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Iw5HhNkRLiTe4C7j28d5zCo0JZn7h1uvYl3p8bE7HbmPqMkqp
	cutFD+FuIiaDUyrvbFIuhPk6couBo6wR5JkvqN9evMfcRnGtx6fKjQc4vUfFI0o9UIsJ64bg22L
	oxzcTCqX2oG/mAikGLCJ1fOUfnPYitlSJQIwMOZdyISOq2PkJ6EMW68SWc7E=
X-Gm-Gg: AZFdTZduDYAr3rTGnuLaIxJAx07U4zEfhJUqCixUBmidqVQghz1DicRPAUpDXRmvNOZ
	2dpQUfqIncMdfYOcg6yEO0hvNoIiJ1QrmRtybq/L3PaapI4in2MlxKpWII9liHy/66FNFibEqn+
	6P9H3rAnHflY8ia9wP1tgNU6JzDYpjZ37pyi9HcXWVREARFoLXOrjqAdE9a+tG+fhsXXim7SDky
	57iS/xaveQHZBL1/f7NywTKe33TXRsyKqTcwX2ev66xNjX7BrRjBJLcMb/yXHJkbX1X4vCHTAHu
	YJjr7Jdk59muCZiiJYyDe2fq7U0H8Fv1Z0TjH3GifEL4dc/cPqFCmY5yA+SEEPwv8q5joe7va/0
	Bb7dcPhJnASWoAj4atPYDtjhAaojkxqxUJZ7vkIn4bcrjLSYFZKz9VbhM7VADLGWgdeX21mdfaJ
	2+k8irTw==
X-Received: by 2002:a05:7300:a228:b0:386:6685:1492 with SMTP id 5a478bee46e88-386668523cfmr12340350eec.12.1795489808097;
        Mon, 23 Nov 2026 19:10:08 -0800 (PST)
X-Received: by 2002:a05:7300:a228:b0:386:6685:1492 with SMTP id 5a478bee46e88-386668523cfmr12340327eec.12.1795489807624;
        Mon, 23 Nov 2026 19:10:07 -0800 (PST)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3856456e6c6sm36076974eec.2.2026.11.23.19.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:10:06 -0800 (PST)
Message-ID: <bdddf7b3-76d0-a8e5-2c9a-c23953e6b97d@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:40:00 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] media: iris: Skip redundant decoder input config
 params
Content-Language: en-US
To: bod@kernel.org
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
 <20261031-fix_dec_seek-v1-1-cfedf0c267ee@oss.qualcomm.com>
 <179492375803.2846709.17266637550647614190.b4-reply@b4>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <179492375803.2846709.17266637550647614190.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfXzocsMzDe3TOx
 PouDMugbJ4krHAgO5ctIJVIogTqz3ZXCe/sHxWsEVCVl9T5TmILjZdTgnEu/7M7plHHxcH46fFz
 ImwOMS9IH2Tg/gDNp0qAkv0L3WLETfk=
X-Proofpoint-GUID: ZpQEgaAkC2BsBoulQ-stlUavjDr3OXSB
X-Proofpoint-ORIG-GUID: ZpQEgaAkC2BsBoulQ-stlUavjDr3OXSB
X-Authority-Analysis: v=2.4 cv=W9OtxhWk c=1 sm=1 tr=0 ts=6b050010 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=RZcGvm1UZh7VgU8MZDwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfX0jcnYovM+ehm
 +gT4aqEfsTPwTsC+qDALVB7kM7RZBcycXQ8Fy6CiRMXj+lWW5cEKgch0Z4xnO5mGgnLpq8IQkNR
 ZELL/CU1GEy3v4W6NRAzgyBY+dr9YqoiNq4+BiUym++shoBm2jQOYulKqW11xnMhXeSYplwiS1/
 3eNUrw4DP0de1kgxumIIMsojhkYa1IV7o7+RVUqCPp75Wj89Cq75CH/XvHLTJTcf6lB7sWnxrEb
 v1Z74DTb8agE8/A/eKhKSUMjIB43evTO38qy+M73o7j/Ugug6dRUrmmEU0SgFntVGMW/RgDtOcH
 5GDR0e3d2QCh4dBgmmKfkln6ymQQvqUBDdG7+BSxwXgEzIgGZ+yIkgugCO7c1yjTdJjG3sh256e
 NNaWrwCzIuVtIgOXNqTwJS4H/E4XZ0AD24w22276ixYhxLWnuz502csUzAivPWFHLKRDMOb8nqD
 bufRxqscgaHXKlM1D1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240011


On 11/17/2026 7:25 PM, bod@kernel.org wrote:
> On 2026-10-31 01:49 +0530, Vishnu Reddy wrote:
>> The decoder input configuration parameters are sent to the firmware every
>> time the output plane is streamed on. This includes streamon after a seek.
>> Resending these parameters generates a port settings change (PSC) event
>> even when the input configuration has not changed. The client then
>> receives a redundant resolution change notification on every seek. A seek
>> hang was observed when redundant PSC events were generated for the same
>> configuration.
> Its not clear reading the git log here where that hang occurs. Userspace,
> kernel, firmware ? I think you should specify that.

Ack, the hang is in userspace. Will update the commit description.

> ---
> bod
>
>
