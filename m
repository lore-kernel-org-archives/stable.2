Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0C3A1687
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337479; cv=none; b=rDh+3fMGxZpkK5MvfuFnrJ73kGuV6U9otE8hgxgfhtmpfcbShx2PB/RCXGP8KoUWKC58k8S9wXdG8GzeJ1M6BWF/q/pqSayr7/sc0xC55rmj8BmumFeQ/4nJ3h6IoreIvzqkhlGHBbJHelFwRBn4QMbdEdE637WG/WxasFED2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337479; c=relaxed/simple;
	bh=USw1vEHEnGZ577Me1GPxccUL9xDu+6I1Z7yk0147Z8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIUoz5rPeXb5PC3Hy2ILbVSPaKUGPi5OqKxm5cMCxIQZS9P1XtKiaPDstK8JIN5VvJVNolMI/6L4M/x6eZfLRkqaIAylFPpWIy9Scao5vrHkNzQSLHXB0wEFIOQ9I3XQkZSJxy42M20uDbxSKhFDQgclkEbnm+v3Ey3HacObYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=binH7OZj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bRE8VPsc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="binH7OZj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bRE8VPsc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VhJA079313
	for <stable@vger.kernel.org>; Wed, 2 Sep 2026 08:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zo52MvMbBViPq0rbxALKDgNTDWskVrOQXYF6VoVWBAU=; b=binH7OZjSuchccFh
	TQeSgoaZ082lvCimYr2/uz0AL8xWGNhoCbRPgif+gh0Rtd1sdPUtuNm3V6c111Ol
	lMsSr83w7FYMfRdu8S1mqr5v3t9quTnr9M9RX4CeXCtRejok91MeSO+qd+6ri+52
	/g/3DvinbHoWNBjr9gyeCRP4quke3x2ov3AhLqgzH4Q+QgBuaOePo1PLwoiZt6m6
	zYbUa88jESItg1CX27yfBdqakJEqRwdiFCgv3RGJTn7YPB1yg07ETa9YmOejKVgJ
	CsFQFXOqWLu3nYGnTSRq5b9nYJkqCZqnpXNcYbCo7TmPIhVZjilWTROZtO31hPQQ
	biPmKA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k2y8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:24:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9392788b3f8so21468485a.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788337476; x=1788942276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zo52MvMbBViPq0rbxALKDgNTDWskVrOQXYF6VoVWBAU=;
        b=bRE8VPscJdxY87PsgukSi1mSn2YJGcLPTQGRFnTer66K66K5vQTdE4nwCGab812yJg
         kOb7kRtFpzB5XJtInpFiydmOZeRJjUKY8UbO2gMMAEvDuhHhblwuTDvyigvf757VVfm+
         zqYnGvVfucWLNw1WOgkZIlzMxHup+bn3Z7cvwJun1fah97QBAvWGStXPGivH8Ifmnfpy
         zw4sb4/JxdBTpHUjM2xbZuEsgUUSZeXQx1S2C+ylQucY1zuvYTFN+W+zXVcDdJSMbOff
         OZR5CdbZ2SW8jR6P/l/r0VF4oWAr9APqisE/VQ+FR/PkSdUWl6ssyd/GOvsydbCZvv0a
         NhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337476; x=1788942276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zo52MvMbBViPq0rbxALKDgNTDWskVrOQXYF6VoVWBAU=;
        b=qk6gebJhyPTlzyzAfxa70d7/Wou8eVCiomRm1jpH82qUfmZdwQoQ7MhuV+wVPN7VlQ
         KnJQMRltseNump3h4YlDiTKwCIczTJe+Ya2mnI+i+XQkrsvBvD9IdD3R641Db6EbHdcI
         r//wmZ7Cpue9BITDmhC+VWI75xyj2GWSgUG+fbHD6MzKHoKK7wEUdfazRy8Ehq2+v46L
         xy5aPILkR/noCa9CyagEW/MxwIknb/y4AU6zO1ryXHhNjFHnsF1NNSwCNEcoEWFoDnBz
         HfLfj0loQi5ozhFKwamb6Z3zb4CI1WsCxzl2YAOeLLYUFHo1BvCanl1IgPsaIf7SuHFr
         9YwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqP+5Au2ZgTRURWkrzr4R8EcsmrtOJNYQoDz+4xZIISuELBREYJwfH3q3Kx3Uql3Lf+PzRuZAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ljWvisMP+8DzM0kT/5tqBzdezJVSCUGq93YaHZtStk8S148ITI
	FBzln6FaoP+6scj3AoKNpHYl/AbDk5SZM2mPfkinYWhHe75L6uOjClTy5XtYY5jTz4lPzOFSrYe
	FlSYuWgg2blsVEEChB0Axxvp4lfb3Y5Ntoq/i0ScTmjt3dREGbGA7f74sE80=
X-Gm-Gg: AYBFou0xukiV3gW8TlQpc4ZUBv/ZxSoXfGPOd32CirWtX0YDU9geuAIJ8B05jl/LB7B
	/bKSmwKBSaf9HHvwAvrjRmhhYj6wwzsM+KsjuFDYneERIY8A1f9aryv9kPvR3+PJ52FQE+vuosK
	fBeJMmBZFavjwSOeUgvXpAYnffm7SXYzHxdGwmtTsBX8nQPGe9gFfIErBthfDidU7x8JHW+bSWa
	ChcWe6xhCkKpE2IApH8PPG5gGOsfO+4WjvtdoHArlfNvC/uWv93ixkLW2hiatTURzzDPpVK0b6W
	61pcKaI9tDiIrZj/2hX8ki3ohSosY4aPUhMRMz1SgobslLCdQWXTJzeeGUlK1DGU+zntJMAF0QU
	ukXylwOu8F/0Hi/QxlaN9gA==
X-Received: by 2002:a05:620a:444e:b0:936:2f59:dfe4 with SMTP id af79cd13be357-939608b0e19mr205845685a.0.1788337471097;
        Wed, 02 Sep 2026 01:24:31 -0700 (PDT)
X-Received: by 2002:a05:620a:444e:b0:936:2f59:dfe4 with SMTP id af79cd13be357-939608b0e19mr205842885a.0.1788337470667;
        Wed, 02 Sep 2026 01:24:30 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e542sm89009966b.14.2026.09.02.01.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 01:24:29 -0700 (PDT)
Message-ID: <e9a0a9af-defd-4894-bb3b-e6e19ba3370a@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:24:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] usb: typec: mux: ps883x: add a delay after writing
 config regs
To: jens.glathe@oldschoolsolutions.biz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3MyBTYWx0ZWRfX1P3ZNAU3xkMs
 48HBC2keeiS/7NGUhEHeYHuGHLPUrpp2RVcA5A3xIZCjqVsg38TkU84s3dFwIpT71r7D4N7yNb7
 ZA9/qvMGZmwo45y5QU6ydk96djYaQqr7CvQLhW1E6F+VHPHP+da+oLu1wofT5POX4465QGckaY/
 ib0Rz/qiQqMokZJQS4kl+GxUSs+VYYUxECMkT0ApgVvyOw4cBUAo23cgPC+HkaMIpdjv1QGw9hA
 /UxGwIMmEgRJfokS9t07Lyp4yeroVBEVYGpRZhTG38Ahi3XQoIbF56LX0MOAQ7M3emUYDu1ybH9
 BtgrJDDj+XDHxpjqh6yE82yZybSsO8dpTdamiGbJpSeZaBGVLtHlCF7bAFZCRIFR+cDBVuRRlj0
 TPs2M0DSjKp2p3l3gOUPYL+ElnVy/V/twDhwTr6uSUIqH2CsHbl75wnxWrL/F+8z4u9LX9weG3t
 grYwA86xj4fgxZ5YbdA==
X-Proofpoint-GUID: LjFC6mda4lsN-tbZsyaCMZXN_oPb6Vg-
X-Proofpoint-ORIG-GUID: LjFC6mda4lsN-tbZsyaCMZXN_oPb6Vg-
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97dd45 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8 a=vq9KN19LKcxqXYNRiqoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3MyBTYWx0ZWRfX4A0UwBIE+ddO
 PgWKcbjW9BKTODj9wh0w5uJU4brFnViQfCOTVGsNfvEAHBQL4iqOhz/Tr/YJVSSWOgh8pHNeNau
 0nYH/04sjjcxcfTLEN2xHGrBS3l+61E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020073

On 7/18/26 7:06 PM, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> The config regs seem to need a few ms to propagate the changes through the
> system (like, PLLs). This improves the hotplug dp altmode success rate
> on the Lenovo 40B0 dock to 100%.
> 
> Tested with T14s G6 and 40B0 dock on the HDMI port with a type-c host cable.
> 
> Assisted-by: Gemini:3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/usb/typec/mux/ps883x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 3533d4f363286..3ca2952e6a0a3 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -185,6 +185,8 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
>  		return ret;
>  	}
>  
> +	usleep_range(20000, 30000);

I learned our firmware (which drives the retimer on Glymur, instead of
the OS) does that as well.

With Heikki's comment addresed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
