Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236435;
	b=tctOj+1Sz2csEiWKCrtXLzpokHCv1tR/VW8C9DJap+UAWAotNwjpm+U9wlS/nnJ9s0Hl
	 PpS5ope0vS9NtQjUjZpfqTgck4O6XYrgpKBoqOPIpl+lTE5Ahw4yvX6DdE7cbR2sFj0mX
	 CgrA22EaZAalzfVPIRLkq3inLXzRpp6SO6bz+G4+igC65eEibkn/fZxdxtsuIUSFUfFtn
	 eOwq2+JuWUHa7i7vz3QrHcw/8LZb8jZLsJ6BbveufnsSTl3wxw/sQRR5wI/VZG6AEMSgj
	 XuidmddehWUkYiq0+/wwyJm3u8eVykIIDMEh/X0Npeq92cAUidVFD+BuBNwRLFW4stg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236435;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yk/7s1DGK2LaMZgRPwzZnMgeWvDZ0DPNeBQ+fDXOGmo=;
	b=F1jLbkCqkNGbKgqUtyKDJvFbKVkmTRuNHCPY7htKEm625OJjaadJZaxkq3m08QeO4tZ9
	 tvBD3Pz4u2r1JMAZ+Iu0b2Hszfw3tKhI9TDLpjBDyjBZRQG1KRLNcn00tPvzD9TvhhHup
	 ysIPYerb418iAEssnWyhWvEXAe+0ELI8uLxEK7etNFBeg7dnXqFpKFKLwEUNB5WcuknNw
	 fr5eagLU25ncgjQp9P91fYjD4fDpIqxyW37vndUgfqv0UdKlltx/zSxtsRa5jX+XORK3D
	 0DpcqOTUh5OF60OIlWNm+DgZU2UwSV7eM5PjC3QB4OCzTT3jJjZK3h6PCJb27cggkOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NctNdtZc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="DOdx/ZyL";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF838606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF838606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NctNdtZc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DOdx/ZyL
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DF20C2928715
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 15:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yk/7s1DGK2LaMZgRPwzZnMgeWvDZ0DPNeBQ+fDXOGmo=; b=NctNdtZcMYdvTKdT
	/9OUZD/qmpDdrtC/gm7Dhj1O5TpiNZw9NlN9CRpWh3eB7qlyBIIHgLN+sV1rX8zV
	MJzpTe48JkfeUiRyNCyeteqMHnGAAmhCVGAcYKVhen+Of+oCYTinBibwY2M9FPft
	ijncgMxHX//+t5JRbYO0jkXtW0w5IsTGj1KhEDkQyuqaI7dZquDM/lOU1itfcVsw
	T/GB8ImYwPcIAiES1xdoHvcwF3faS24kVpURJinjg2emlZdk91+COykXUDXO7vQk
	r26J9x2Xpz+2YLx+kpeEdVFQy01oaWh95rIFUMdp3VLt8BJaS/mbouLk2o8GnBXT
	B1y2FA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8s2p5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:00:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed2803f863so10721835ad.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794236433; x=1794841233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yk/7s1DGK2LaMZgRPwzZnMgeWvDZ0DPNeBQ+fDXOGmo=;
        b=DOdx/ZyLJlw4ZkmpMle8SsW+CRgb65MC+VAbJiBuWwA8VeO/Ebmcqrejep/rG+l/gz
         atbcAmQv3TTKEaP871jf2XLszUZwKrHvlI39+J6QDxdNcxFjpKyolBzIKuXW9r7yTM9R
         RrCKKEAoT8aXz80M2SzAuTuAVQobB/wGxiVGud7fTHXAx9pq1t0t6QLoGHCfs0lvYvzx
         TTD+AldQHtettdQXxkIrDUz5V/Jq0KxXLTlTozTkcKzJwKMYV+TNNrRvv9cWB8iQVXjh
         k5aRDzlDHedPW+WFydneRE0NfQoHymXv0NqW2RSStauHNSVBvLoF3tgEqyvstUItv761
         +QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236433; x=1794841233;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yk/7s1DGK2LaMZgRPwzZnMgeWvDZ0DPNeBQ+fDXOGmo=;
        b=O2N2Wwj8ES7jaNoC3YNbKHN6U3rq0EKiRuP/QJM8fr/9dr2EoA2XSAdy7JNAcVvKGK
         hvPWKHQiUCk2QXBLsR3RGjQ7mEDFdQPLwnUGG8kHWP/r8Vl8yarNLTYkB7yQ2U5zzdrZ
         4TEFJP4Ec+DN+BeDrP6lTko/d4Sg0AGXWfvMUFVqJven7ShwrTn9+YKvtVIz3cMU4EBG
         FdfEPSkl4fXP12NYeoKUvYMXrKY3QSbS9g4+qPpMoAEl8hb6x4MHTMqEchMKqG5xbvMH
         M5CgTfLeO6GHB2b64Hthg5vxmCzsAvPrGJoHaROVcw9Vaid14bcNf0zhANDgEdveodET
         h5pA==
X-Forwarded-Encrypted: i=1; AL+hErFUixznF9zd9j4r0MCh+Czfv7AoUPprzECMAhqv9799xjGzDvtSRsUIR7AYlbxe0jUw/5AVEfk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xXs7ejd5dYQTcsnf8a4EL8K26uO5pwNlFYSSvdif2sVmOekSb
	df0t9OQghaGsQdfBrOoFMC/REkIX630tQ30bLyUnJHixwuFkrPM6kSF5vXC61u1MqYBhFqICzOZ
	W1c8P5C9lhakrqQs233qH8DRzfIIr3RyHCju5sCr2alAZzVou2ZBMEA+E25E=
X-Gm-Gg: AYBFou3tDFbdFHNHvkyPERwYm6P1XWkWUNzLReUAZTyD9IFwLphQ+LOwtCxM/SAKoTn
	l89Bum7RFK87yPiC5tYDGrGOfw0yIKAYBRqKoV1oHcxlWnOf7BD6nGmMXn+tx7mkV7VDlnajKKr
	X9ffDOl4Fjp4UR6DZhjWiStolsKwkBPtqSvR+TyJammF7c48dSz/6sgGEEIefoCj55kmRV1onqF
	jmT5xWUcJNl7jK+H08xHJ12FifHE4ZAn/h9lRcjaEYVPAwYMOXdVG1yTFvAHLF+HzRJV1jO3FfF
	5KRRDIxL2z8wRhlAjDQs0zy+6SmRSeVJc1UXUlhqE2ds7igpo+7bSwHjKC04Sv7zVcVjwmBJQc2
	/Mlv+TZuxJeK+4Hgvr58nu13/AThkqyawLBhQBgKG8QrWSmk3coVyqRw9w6zn8JOfd+wrUCN7JJ
	xGWLjGSw22qEH5iLFLMJUWsz0akcfleEw=
X-Received: by 2002:a17:903:19ec:b0:2ed:3f47:9691 with SMTP id d9443c01a7336-2ed8378c6cfmr48205585ad.42.1794236432482;
        Mon, 09 Nov 2026 07:00:32 -0800 (PST)
X-Received: by 2002:a17:903:19ec:b0:2ed:3f47:9691 with SMTP id d9443c01a7336-2ed8378c6cfmr48197085ad.42.1794236424114;
        Mon, 09 Nov 2026 07:00:24 -0800 (PST)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed8173a8b2sm12837335ad.67.2026.11.09.07.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:00:23 -0800 (PST)
Message-ID: <a39b1918-5d04-452b-8b5a-0703963f4587@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 07:00:21 -0800
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
Subject: Re: [PATCH RESEND] wifi: ath11k: release the rproc reference on
 teardown
To: Wentao Liang <vulab@iscas.ac.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        workflows@vger.kernel.org
References: <20261103102915.1341148-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20261103102915.1341148-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OSBTYWx0ZWRfX4r5WdgzsBN7+
 IYf6F5sIYfa69c4QJLriczHHpuC9F4CLxF6G6x9RE60bF9tMAljSgSlrS0HJOi2R/qQ55hSsKeY
 SloPJ9nKuZ0iNiPSJSGdxZtAVvGAFP34yy9aaewELjfjqX7HKZN7ClHDBjs41AQEmolrR4YP8Xg
 P/+Hfjo/M9xGbTRfc3epPDNIKJP5Gt+4kgCcVCSIZw1jGptP07033fmfRFUNqnbuncqJhkdR+VB
 QWgyauGccJfGgd1xRUIwN21ghKQdcQCDoGbw8EVJe2cj5d+r51EfDzFYGGsEoXgfD5N1jrU3vpX
 ExY1K/wzkPV9wXeNMZ3BKedsHBJkqG0ukTHAxPVNYWnR177Yq+UbGBOKfnGIk+87q4KBRtAegrP
 fBbRH2QCNrXFmltAYuPnAlwHF4sni5TN4NAVWUygaXiEP0tS9O1xt62v3mEBUio5+i+rbnwfDoT
 Oxi4RP0sE4ZdKWUb4eQ==
X-Proofpoint-GUID: zVRQ6CxFLRvK1yy5vA57Fi3qYIUujAvu
X-Proofpoint-ORIG-GUID: zVRQ6CxFLRvK1yy5vA57Fi3qYIUujAvu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OSBTYWx0ZWRfXxa5hW63xniIp
 sf76LwgoJ1bodbBRAodNzzZ2+YumFvBNbsIoIC++TwUDoZOPIYUg7aLI9j4FTjT+5xw4puqUjTO
 1/m/uUPCbjMYa/8YPC5z9UZEESGlXpM=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1e011 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=mvyCH3EIRwqJGMeifaAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090059

On 11/3/2026 2:29 AM, Wentao Liang wrote:
> ath11k_core_get_rproc() looks up the target remoteproc with
> rproc_get_by_phandle(), which takes a device reference and a reference on
> the remoteproc driver's module.  The resulting pointer is stored in
> ab_ahb->tgt_rproc and never released: ath11k_ahb_free_resources() only
> tears down the firmware resources, and the probe error paths after the
> lookup jump to err_core_free without dropping the reference either.
> rproc_shutdown() does not release it, it only drops the power reference.
> 
> Release the reference when the AHB resources are freed and on the probe
> error path, so that repeated bind/unbind cycles no longer accumulate
> remoteproc references and the remoteproc module can be unloaded again.
> 
> Fixes: ba929d6fe31a ("ath11k: Remove rproc references from common core layer")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

+workflows

I am no longer accepting patches from this e-mail address.

Go away or use a separate e-mail address per person working on this project,
with that person actually responding to review feedback and adhering to the
Linux kernel etiquette.

/jeff

