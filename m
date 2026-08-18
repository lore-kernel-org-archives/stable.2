Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE64473C98
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057453; cv=none; b=I+iuHKLiCusHad0Mp9UHdFQ4zPr9qYy1/vLfadJtm3ZL8TUD4Jp7iHra/3yr5ttQSiBM0hEPeUkS8bG1jUvNTrdcW6FNljGP4AS2N/B73yvcQABoT/s5OzsL3xGHsbo7cq+wnS47gsD/xMuOWIqvjKnAKr0YVYf/w0NohUOHw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057453; c=relaxed/simple;
	bh=9UJP0+UnLhNHthhnuhnSoK+fMhRJRgf6rxK9n9XSqLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOD7ALdXsP7orCHjumSGWmVaHFno2CODW2bP51vzUJ7wAQgLkZHJTNx4pCD2SvLxUwSaQrlMD/yDkJyneWjtGBX+ZJE8dIAj5Zo1Z/GbnV4wVYr1efUxbquCe/rTFie9dskfkunJpGzB7yf6D9KCtyBuXkXRPrSnQBMs1g77mlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5HJDyHM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A5QMnbsh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5HJDyHM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A5QMnbsh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABfSv820115
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hLfzkQULc5AeeCQ0RZxw/94NH4NiKad2ELWqLQgObE=; b=V5HJDyHM1Q9khnxu
	N1nhPlxx5Q9glIy0voaF65Gt+8Ww/mZ9MCYR9hUybrpVlfQBbtw1cudIFAddnOiU
	Zq6eiOgAe2/UDQ8dVmskJSsZmb5zfNr02UdiANc6CtzWhTlrvAoWCne6HIJZCT0P
	Yp8Beg93Zmyp3flBJOkw9BDu/eWWR2gDPilxAILg6jkXSEiBOhmhsd1cDjf1lg9Y
	QW7xaCRkN2aGGko0z/3VAv9/cE6thBAjzhu+4r/yo813dPdLFLjUOSA4/zRssbRV
	6Dou7itgtNGogf7IVnzfxTI2bf37K1IA2Gmk0jtEhb2b9NWd0PvH+sE5eic7VBNF
	8Et9oQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p22jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:50:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90786218dd0so10213116d6.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787057448; x=1787662248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hLfzkQULc5AeeCQ0RZxw/94NH4NiKad2ELWqLQgObE=;
        b=A5QMnbshqwe4hkQ6pIzCuH75oFh4+RlgWQ7OkYU4IvFuoDhZ8FAjcJIYdD7CTvS80E
         bhscWnWkhVhmUYBR7CFlrVbJKU4Hx2MM3jD4DViiVcUbDV9dfHvHwtshK5iW8VXNyrJ+
         jLjh17miUL0nqxbDlybDxmMJCqru5518yYSvBll4ul4ujQ6XEn5dcSQpYD+oa/XAK8/m
         daBRNGlkGyRn8fkjv429ZGP2aOCNMUnnhk13QN8duIQqIMzoDN09VmwFFMB+0Sr/GFi/
         QKTJDODHsjxqMRmiTl/ow0M4NzKRsEAyDXwolX1BLbg4VS3/Ts+olETFe57XuKsYky01
         oUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057448; x=1787662248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hLfzkQULc5AeeCQ0RZxw/94NH4NiKad2ELWqLQgObE=;
        b=QbsLe6Gnj6DoVfEgakTv7yOeBKOoi3wAupDkoNLE/kqHy1Nx2X6JJnAZT2Pm+e6PI+
         FeaWaTCXHaXQNtLKjERTqMA8o9kvbLrIJ9M2PCMQWXy5j5CQ2gfQju0nKdux+gDZ2n/I
         zAsR2IDUejWCi2GavzAEZ1sCoTsogR7tEXFFOTbB2qHylu2BJG2x8J1zrJLFWCSC1nJU
         AXVhywtw9kKSoap93fE2Xd/C0GXDhabcyMhTHriQlwjtkyBAKNx4hCUBGPLQLkPn/Nxe
         RjF19XyYjCPK3gle9kU6Y+72ILe6Uflzph9ILaYpKX6QHVbGqqWGyjHWUkOq0LxIh+PB
         eZSw==
X-Forwarded-Encrypted: i=1; AHgh+RqhsYTlbJT+X4nc6dHNTFxusJLi7DtTBTeU77cM7/VGdydGIk6/sW8b9r6ltykk/7ucvu98Idw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9erG34hv+tOSEa7EExnWCOHm1oGx9XQHdKVecCvVerzNSDL8
	dFvtu/WKkZNXIkh2luk0pEpJf+fNuHoRl6Pc/JAg9P6Vt2ZmyHif698Y/T1mART/RVjizv8VBzJ
	zAQI6gHuJ5vM4C5WCM97Tx4Ko0Hrif9aJUE+zek8OuaQnTyl5ZSDk/u512H8=
X-Gm-Gg: AR+sD12wGy/VBrG83TF3N0kUrHLVY3luyyUMyRmd+XxfDVRLzGzI1eDOtqP+P5p62pj
	GEOcBn4Z5YfUISjGSe2wch0RjDvglyUvxAYYHhRiuWtoiwN+PXgmoaXAQsY1jlX8NfZ0srHxFqb
	x1MrfY8pIdxlHsuvL4ux7hxSAHceA589XT1b9PwtTTcJuPKX1wuWQ9/Yd5DkvyWeiTkDCwhJc4b
	DY96Jk6bvkFg52LGhptkx3FvJXKABlyq+E/UX193UHyh0LEFC/KXywHCZkex/P9TE/pcyEMA8td
	7onNkbcYHJ+geMBWfduGpk/J+8Ny6UL45LKz2dTkI8tWaNEnasJPRjm1wGy8X6cauEmSzp55j0+
	kr6f9tPW/SSVgPz6jcrKp1vbH
X-Received: by 2002:ac8:5a8b:0:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52d8547a9e4mr243319931cf.3.1787057447604;
        Tue, 18 Aug 2026 05:50:47 -0700 (PDT)
X-Received: by 2002:ac8:5a8b:0:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52d8547a9e4mr243319601cf.3.1787057447138;
        Tue, 18 Aug 2026 05:50:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b99f78sm152538566b.50.2026.08.18.05.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 05:50:46 -0700 (PDT)
Message-ID: <84be0a35-b088-4ab2-9111-80809d6d2d53@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:50:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: match downstream DEF_ACT_CHAN
 encoding
To: casey@samaritansolutions.net, Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260807-slimbus-def-act-chan-v1-1-fd542efb3d30@samaritansolutions.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260807-slimbus-def-act-chan-v1-1-fd542efb3d30@samaritansolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ATciZHjv4RsXUkYBLzewWLCb84Q0hELy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5NCBTYWx0ZWRfX1oISoo7b4fjN
 tAk6eKrbvBuE73i5f1KC789EQa6ytW29EaDb/HA22rtAHCs/xDB0NwNu+MCp19MuG1l/pvEad18
 QE08qyiSyKraqcD6iwR+U/IhIsu5Rh0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5NCBTYWx0ZWRfXw7UdqWDwyZ1+
 iM2Ife/LNetTcPdnpJo/T30LBxOptXbBVWaf1XrGOuU9W2YNuZ1SFZ3CSudZ6SJROeU8hbCu1CG
 hHPqQnx/qEPzKil0FA/GbP7DXwgURPAUFN3GGKFv6CECqgSkRZmATy/7SJGHk5Dvxm7OL5zP5DI
 QS6bIzrhlAFD4gchjMstNb9Ioy8/+hmyr4BOYA1mgBIHLXLAuFHzAIq+pwNh+XNxUK2ytidi68T
 HuwmxdQeiM0wAxdQoqx3jPcZLzzWWvfB9pck09fM6GWVyB9nc7zVGk2hZFI4fgaIhnT4ER+oLYR
 6rninI+HLPTLCwS1/CdjyDQ1X+atuWQaCctz6L9d14a3E5JJcSndkRG/ifSsLkVZNw+n31rlTId
 c8F0AQ7JYaHXJcE3YSBSXvf+ZrM/dquEbKwkmLkLIBN2XcVgQMnf+dCY4JmEC2aA0P+nIvkwjbu
 +Lf35sD0sx9KDs7tJ4w==
X-Proofpoint-ORIG-GUID: ATciZHjv4RsXUkYBLzewWLCb84Q0hELy
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a845528 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=oRWL8vWFAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7S0yl7ldlo6rjceDY6AA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=ZSzuMzu-C871e8vGMv2q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180094

On 8/8/26 2:35 AM, Casey Tunturi via B4 Relay wrote:
> From: Casey Tunturi <casey@samaritansolutions.net>
> 
> During my investigations, and some rather incessant cross-checking of
> blueline's SLIMbus path, I found that Qualcomm's downstream driver
> packs the first DEF_ACT_CHAN byte differently from mainline. Bits [7:5]
> hold the data format; bits [4:0] hold the five-bit client number.
> 
> I changed ours to match. It made no immediate difference on my own
> hardware: blueline's current values produce 0x0f either way. The
> downstream layout is correct and should help devices that use upper
> logical-address bits or a non-zero data format.
> 
> Fixes: 52490169cddf ("slimbus: ngd: add stream support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Casey Tunturi <casey@samaritansolutions.net>
> ---

The semantics match, I don't know what side effects that may uncover

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
