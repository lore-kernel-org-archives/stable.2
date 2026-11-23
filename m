Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440486;
	b=0VXeD4AEBQjENN82m9NslH15DEc7ZUjSaQKnK90//mvmSqK5tuIHbeveD0k3+UJN298L
	 9t8wOR8te41X18yogpG4GnXpst2b23wZ36xZ6UYtobpCElGEwzm1lCkX0+T5IudiBDJRA
	 ZqGsz9f8WFN33fd+XVi6Bhu7jKYO+hg735ovP6EIqB/ZPQHFU/daTuew+HLVRY+rZ/+tY
	 AeswYDMxdQZHr2fc27cSisT2lXbx8s3TaAa88Xuie6i4suizKrDou8gpLmgx0YsgE+APP
	 7rkls4iAaikLSYJ8NgJQnfddmEK565YUzvyac8VhVp2xik8VIIfPegCsjUh2T0tOqvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440486;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1v1w7MNAFfdBbxkmqzc73MBwGVULgs/BT1kSk/bAqls=;
	b=4/R04m7Sdduidg/HuT9BhgsuGNZWfzzcNh6rxDbVl74+yNGBDC4u5gKWvBKNhSzJIS2R
	 EvwoyjgR7BbC0fJU8g4/aGV6TenJI21pDQucNBXEDAK4dp310MFmCd4MWxrmjNJ78IPgl
	 hYGDPBX7+J4M6BqM2dmwPInglJLW2A9KRgzWfFEO60I6Re65VbjTPo/ttdmh9u3u+CNTh
	 D4h+KbMjMA1haZbAerqYED0vfELmF0Nnn8INqeGagqpymdMrEnGAF4GwaI/hxUbtBCgDc
	 r2jk7NlgoPPo/4J6Ac+/UBFiR7HxIwMLCVMdluHPk9EWKQBcAu90YJpf8JvIDFY9ohA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RQgXNE+q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dSR7jNdx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760F606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0760F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RQgXNE+q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dSR7jNdx
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKxVu1937660
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1v1w7MNAFfdBbxkmqzc73MBwGVULgs/BT1kSk/bAqls=; b=RQgXNE+qC/2VTru9
	F52+bqz1hcdHng5YFEzD6FunAsLiPVOTJr4yD7UcXEAlnYr0csa6wJjb8rn98hXI
	mkj1oDxF9QrYPp+fobnupeFuVXLW72HMh5hwi5n8G8NtGViBHsX8dABcu/vUlAjE
	6YxxDwHSmZaMlUgocDocpjmoSzR08N0f5B5yeQmu8JSbWKepA9t9vM6Tn9zbV9Ml
	wSHXMxOPViIRARGkINXAe/3FLYVKknbKDua1cL+i8RT0gk6MH+4TpLp4zsKXU3fi
	TC3MRQG9CFGPIYLuk0NU8bcxoeh97lYgywPNSng9IZ9QZHMYdEt+1+xmFWo6cusj
	bj3ueA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx1rgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:28:03 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eac74b0596so2291737e0c.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795440482; x=1796045282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1v1w7MNAFfdBbxkmqzc73MBwGVULgs/BT1kSk/bAqls=;
        b=dSR7jNdxOUQ6jeqUp35h8TW4kAVV3DYTyKjnxCIVYcSKHVryKRdj3Y5bpN/T/Rmq0b
         +Vkh+d2CPoz8e9akpY9FYl8lMK7/Q+AWkkLb4avPM3ZvrulbD7k2I3HKqnfew4BtVBN+
         MFYFSFI33BppzZMyXOSNCnt7xXeW4xY8Dt6lvodIr1XFNsMOJTFFN5UTrKuQn+GXAEQj
         rqWnAni9UwZ9ta5wBBpFj5uSpMx1zjtNV/MrU7XnSTITV1CEUkX1nZCJl25IT37zMRzc
         gWxm/bUoT7qzsAYqtTd/HqN0ShTFvQxJGvs2s1z5RwMGmOW9/7NjxKfX+3Xc3UtBQBeh
         on2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440482; x=1796045282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v1w7MNAFfdBbxkmqzc73MBwGVULgs/BT1kSk/bAqls=;
        b=ievO9lM0o8e/r+0xsxANg7cDAbMbs6kODWeZYMhJQs11cwfouDj5An+03p3+cQXqbG
         DHHJjfSK0brFHyjhSmGDx5XOSR9iJ/s+Cn/aTTxZUjQ5wnOrs6sjOgR5wRtcpA1xz+Ng
         4o7WTUkrSQUjisihOAr/99gfjpDIFTbOHkAH3Jasd26zoxMQIA20aVOsC0nLirJIvleY
         pui2pUaEO8Wn7b85IprldUpDE/LVj1wy3gqUASHknEa+0MWSDFVZL9hGClTBl9t97IIq
         cwD2dcFPh7LO99zXX4f3V8Yr57BE6KFQTsg8eidEEYQoBYDbKx0V2+HIPlmj+g+7vfXD
         yykQ==
X-Forwarded-Encrypted: i=1; AL+hErEQo2tcKBZ93ghJBjDQk2OtpDnUk86Qxp1GzMbr47cb8xvAM3ioe4TPqW9huHORyxtw0YiUiQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sM+8aJNwNsgAKwHdfa+X311k4F5JdsHUtvBRV0vCdzEN5XlLX
	yf0wUagefTZIc633maFFXn5F4PXuOLkM62x4u4sR/8LoNoVbv6EdBh5WOHi7DxkZEWkHrFoe8pF
	rjHRT/lV7g2roanxETzNOmmGUmIBxrY4I/owzUGNKUs4njETu8+CvihHrd7Q=
X-Gm-Gg: AZFdTZcqnzKdQhjqM3WLYfnKD1ETB6egSdhtKjPfHVOkPVRaP6X7QrEo8+miysJagX9
	sNwm3XHy3rxYV18o/29a5lLSzVwy8mPQQ7a3r8TJwDBMJYKbZB7TQCsFy+ohWq+s4M9AzhG3JTt
	LuM+ajDpHa6Du+NSIcr+oqUsbLpRAF6Fb+7Rt9XRzHrAiGBDeM4jPJp9qWAQsCx4aUr5tVdIBp7
	m2MCvCdUJKsZt1WItoC4/D6/YD5I2rxtXkC5JpUzMaJ1MJL+BlG7Pe/JVxeM4IgxyVJPN45pMuQ
	n6tDGAsDxcHTTFq/dren7QRQihaPxA1sDFJOVDnd9D8Vu2OqX171zXckVKnENx4ZxWrLxdq3NaR
	gYsyY9WdoosmFJzFx1d3thYhVRta/KYcr87UmiVRHed3jZkFPg/LgtE9zYTIuUmqE+kxWNmgzhX
	85
X-Received: by 2002:a05:6122:8c8c:b0:5ec:e6b8:ebad with SMTP id 71dfb90a1353d-5ee8af4a759mr5658312e0c.10.1795440482136;
        Mon, 23 Nov 2026 05:28:02 -0800 (PST)
X-Received: by 2002:a05:6122:8c8c:b0:5ec:e6b8:ebad with SMTP id 71dfb90a1353d-5ee8af4a759mr5658291e0c.10.1795440481691;
        Mon, 23 Nov 2026 05:28:01 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm401690135e9.7.2026.11.23.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:28:00 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Dean Sellers <dean@sellers.id.au>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: pca953x: restore output registers before direction on resume
Date: Mon, 23 Nov 2026 14:27:59 +0100
Message-ID: <179544047516.57001.1642387166743976170.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118070321.2557621-1-dean@sellers.id.au>
References: <20261118070321.2557621-1-dean@sellers.id.au>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b043f63 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VMBGBFbNl3An4jpmTXsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: XIu9S10rBSoiowwBDKu_tv2osyvygak_
X-Proofpoint-GUID: XIu9S10rBSoiowwBDKu_tv2osyvygak_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfXw9MusRQjDyKc
 Rs36tPcP8n3ldNzW54qDR2M6HDnZmM0dKa6BWVzDtorCMkO619Mut8LEP2paXWhbU2/St3oAbN8
 pVyESPek3rhaookL4qI+KGdgVk1Bf0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MyBTYWx0ZWRfX19EbPS9X8rLO
 VPx9p93Gb/+3xYi/IUxg9nkfPPoGT79rYi5OBisWqxlNDAG2ti6QdbfZb+rfksYS+cfj1XCqGhh
 pm6BhcHDw14Uxze1XlI1ffKjgZ/MSG0DMAEDt+OHQb0x4148zp6M0jGYKYEv6PFdApwzdNTL5Iv
 66EwxnfImsRbOp19oesEtJqcZOYr7p5Hl3dkEZ+oKqricSnzouu/XdtzlBDUTpVsr8IA9WSb8x3
 godBOLPEwXcBeby5htjFRIfOptNb6tNA3DvI6Y4bhaveLyyAwfT9s3X51trC6AIVSOvXN/AWngU
 VRqh/uMEPt8+mND/0xc8mqZk9gQKKPnETv/PyQ5WhBUKjRd7C4rZC+k7+Ml3C8Kg3U/ErCjGJzk
 oXEfvW58Fu6/u8oqEmiidbIVwuiKgzxAY6ySNyUIw0AWJY0lTEIyaQsN5roPzFOwhgOEPEr+edb
 9l045Qhedla4kyznqcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230053


On Wed, 18 Nov 2026 18:03:21 +1100, Dean Sellers wrote:
> pca953x_regcache_sync() restores the direction registers before the
> output registers. If the chip lost power across suspend, it comes back
> with every line an input and its output registers at their power-on
> value, which is all-high on most of these parts. Restoring direction
> first turns the configured lines back into outputs while the output
> registers still hold that value. Every line programmed low is then
> driven high for the duration of the direction write and the output write
> that follows. Where those lines drive a load, there is potential for a
> spurious output.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: restore output registers before direction on resume
      https://git.kernel.org/brgl/c/354e4d6f907ad7a60377bf817c700a674f063044

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
