Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB0426431
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650725; cv=pass; b=UY81iHbEeE4rniCJtprfILC8e6mwjhbYq+Ojt7Z1ruiuv+wyKWnhN+QOM32pz4YK9Jo6Vttc50VpV6YFNvWTddbvmp5zZ33+PtG2vPjWC09zgIgHmtYd+bCjEl1JasH3OptWFn3AI7IkHZAHZyYaqZBOgNw33fAMlCuhNdoupDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650725; c=relaxed/simple;
	bh=KcU0NhCjCM0mTgG0KIsg4O4+gBDvImg9fuTZ2t1JmwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSzwyc6UHLBCpM2NfDlHSMqMzFoRboVMkpDxjKKrj1D8LI6GC3AVVfNuh17X2xZruYJqGjlpwT3vijsRbStkz5FkuWW5TsSaN1PTvEoI/WEzVlu1Xnvo8D/TN8YpbIgdwvue2XcZMsWUZrIvm/YzpOv1g9nP9+ZqHsgQ4ztixF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mGe2dJxP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VKeReIff; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGe2dJxP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VKeReIff"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9ZWhI1257759
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZFT0Sm/+O+Qr/46avyREHDePIozflXgT+OQM6AD0D9w=; b=mGe2dJxP1fub/WPy
	LkjkjsAgh31AM75u4LElgySZX8+GcqUQtc69khI06zA24WpuMwPEy5AIbiLbdGNR
	Vh0ujUMvlDI5cJaCfsk0WF+BalNcSzZH+zP9AHDj0gXupUxd76kJtz/b0Im5rjQh
	6d36r+QG3iVlUtDqVaqeuwGu2uYWdrSqDp8G0jzkaEVbO1h25xPVQSqa15lRrxSY
	TkGNgvy+OAid2HSGYfcHH3MdwP62yi74iZMAb44iHWcTLjpxsttqHBB/PQrqATol
	8ZeNnMNEYogGZPKbJJMObrk0jFC8GkN1vGEZu+HZF+Tr5fUHQNqSJmrcsH9EG79A
	vEefXQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grdftgw8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:12:00 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48e5de5a23cso1245847b6e.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789650719; cv=none;
        d=google.com; s=arc-20260327;
        b=RG03MSJH2hk1L0EJEoMNfhY8zQh+85Q48mNmLQsJn7DVBIlxLjzdm1u20K3ey4siQZ
         2Kz809dUlRBfKO7pD/jRYJ0T22Zx4qWVX3kyqkV4hrXrffXi26OLuyhWikamf5equia5
         5glaiLcRGHYJtGkmrHtyBzA17ZY4D6KC2UXMleMhIAlpzdmS0oJAmzDLuIi8o6BDcfPX
         ihxLi9q2nTCgU1xMIaPb/rR9472gVXw2z+fy+scJ7aScC/3qJlsugQBwNzb5GEuu1d32
         ml082IbFu42qEtuC0DUcU6QCT8iQRg2nqId+tF0LiciZDp5JzP0VObU+LC46KxOMw9km
         /fOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZFT0Sm/+O+Qr/46avyREHDePIozflXgT+OQM6AD0D9w=;
        fh=LtRr9FSkXoj8mc5tdhGm42XP1StdL9TCY0F1aqxAImM=;
        b=nxYRQEXu3ZMiz5xx7A89XpB/UjwNGykdsEzO7kebEIpOFv5e4VtfOImHscLg92Czwl
         ivUNFEfAbIf8pnW6Dgcy6RFG8sqmSevmhCc6lAF3F8FNhJCO6g9tLysuAq4shDrfy/Rr
         pdaPoqLiU8xpEi/tCaXcE4bIrBwBPeF10EN9Ltv1lF5z3vvv70VqIMTfV/6iSkZRNTSG
         6SqQW/3D3QHbeJb54MCqiNwdSpQ/4tGqzgQvzP7PU78kRedq3F4M9NIxkTmlQx2RxnRW
         98KAqLOu806Ay0EJA0bC2pJykbYN/QBUKWUfPDrbV+qjYRJLl4c2GL1SXc1WLbB8KuRx
         qzwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789650719; x=1790255519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFT0Sm/+O+Qr/46avyREHDePIozflXgT+OQM6AD0D9w=;
        b=VKeReIffWG4Qt1Hx7zwn+Laxx5flc2s8LeEDKlhtmG74nq6+45dOapVWyPsgPTofBZ
         eA6jJjA01aemdSsvKPK3QEKBAcq9NRXHBjjoRjGThp+IXiuq44JnDdCWbZe57Arbl1S6
         KKCpImb8ERrMsWPe9oAzDl1TEjkVX9/2C7EAqDWphhVZOMn7AHKOVATiZwunUQTKIJ43
         EjXOQLBOqWjNi+loLSfHUVRlkHxj/Rps5+ALEIUzEp51X/ki20+kv3HV/TDBxczDR1+Y
         ovv7Ue9Eoso49DeQV5v5pwxAd4RUulk62wqj71454FUFgJ8cHH6/mhfvxO/182aeW4b+
         kRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789650719; x=1790255519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFT0Sm/+O+Qr/46avyREHDePIozflXgT+OQM6AD0D9w=;
        b=Wt9/Gc+fdDiMU7MQoqu6NndAi8lAwNb4Wi5bKgPAzRO5PaYze4yvT0/snSFvm83SVD
         hOuY8GQEFTCDIOyU7GuqaOin+CI6+5Benq+un0GO0b/cV9tmutjkrf3xD4dHobJ0+H3n
         TwZiQWUkjHd30c9bOqIRzirwCCweepSzhae80NInblrkbwukRIF7qvgUNkwClpGeidd6
         9lrw4YPAxxu1NiacBtgXt47+kyaleiXHq1taliUxyZK3CfMy7pz0mRn+uMW11goYUjRp
         3Ke4UFpKKsOgCx1Pe+UAMXst1fanH6PGEa1BEBOANCZUlG+fqu112I3xDvg/fAkfQylF
         0e6g==
X-Forwarded-Encrypted: i=1; AKwUvBxCnEhw2L/reOuDr/eR6ZytIVlpAkstsA8wlWSjnuOdY4okLPJb6HIAyEq74o96AOU3uBkE2w4=@vger.kernel.org
X-Gm-Message-State: AFuF++klYK86W9do3FBgxQ6mPw33ZrFuzkIKyjGwXsBp+VRl6keXlwPi
	oY3NVicnK74qiwy5ADOdAt+6VGH9n0bRQ2ZMCMoN5wHTUIQZavKoe77lCVi8qUkJQTIbfCZeOcC
	o39Mumq+Ouuxil2JVCuFFMA5PvLB9uG/n/t8r7D7VfIqbamFC+VXeHExdhiNqa4kPrnYsDI0Jkr
	FDwDr4j5rjco4oLSJVxuaZDvHiQeoVR9qiUo0zGlcS9w==
X-Gm-Gg: AYBFou2bfmnn+XTJScq6DHWBerrk6Ni9+F8YJzuF4SYXKfPEBehgnYF4n8PYmzeNTnB
	F3EhGgCkYcRUV73fuS6pTfLeQuhj+NDgMM5ACFUcInjCrjvBW+COxRQ7a0sFUy+FBRnpyznKbMA
	5nJmomy9uBlZgMy9hWEHk7Nl6R+/ppcxnUUi/tMuRr0zapa1C+BVY7cW/1/DDD1LZSIpdBcW2Dj
	irHhf4JYZVo+WDh9ZTs1fTf7MyH70fhTL6v9Bu8oAM1M4n00lAXvckZyORrjHuS448mrWgbIg==
X-Received: by 2002:a05:6808:16a6:b0:4cb:f21c:a79a with SMTP id 5614622812f47-4cbf21ce30cmr1379129b6e.34.1789650719592;
        Thu, 17 Sep 2026 06:11:59 -0700 (PDT)
X-Received: by 2002:a05:6808:16a6:b0:4cb:f21c:a79a with SMTP id
 5614622812f47-4cbf21ce30cmr1379100b6e.34.1789650719177; Thu, 17 Sep 2026
 06:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917120810.2150534-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917120810.2150534-1-vulab@iscas.ac.cn>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:11:46 +0200
X-Gm-Features: AcwNN1Vv-ei9g1d-xezvG0sj8-CUlz2SjT2lgneKNLOHWe_wBi9qStJQdwrc8YY
Message-ID: <CAFEp6-1sjie=psDi+uzfN14GXiRPOg1FTTbEdkSgejCg8qNweg@mail.gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: Fix tx-rings-empty state leak in platform_get_resources()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andersson@kernel.org, kvalo@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4NSBTYWx0ZWRfX1QR5ZCjBVOcU
 6L6YdFkRIGwI1RaYBXDqT0Ns/QaiUawutWh588/7O9SukEGX0JsmOBuhOWVho0ToyShUQFxhr9P
 S57ShhF7vpYc2aK6mFP0ylWOHTbnLuTiEpyphsEQiDikfCq5QHY/vOm6OH0G/Mm7zkz6f+dHPdD
 rM2EaBsxJamZxwVCnrQCbHoGLGPCcqCOWpHbbnWMgBBSV8gdnq41ORUA9UYuyCu7YXAMU0Y3IPF
 vGLO2VXfdLE3HvV53RnCfiDIoAdlQIj/EEz+ikMpF6dUrE0LX0u96HcwVYyfkT4iO4zSIGJWNH0
 59JCxjrNd5JZD4vU8fv6WFYAAuo7dAHQIwN7/FhubS0Od4vx79Ti9PJA374eMnSGf1kUY2YqsXc
 g+FhzxJ/NnHjkyV7CWsB4CcT5sYX3uQUrdgPQy7NIRIdahqn2FiPIOASnXVdqVHFexAtrU8DPEo
 X++DILTpjOGz2URuEYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4NSBTYWx0ZWRfX8InJxom6Qh6a
 xPltEVB6ueuWyhDlcvx1xsio5TbU9KTM1/4rdgyCYQSnfYyOV1i5ZhBLPzkNsMF8cURfzDsUOUw
 QommJ/F2gq5nt0nApU8DGgh91C6mrhs=
X-Proofpoint-GUID: 4bFIS6LvQeYt2FH9DGLbG40Ajo4QkjpH
X-Proofpoint-ORIG-GUID: 4bFIS6LvQeYt2FH9DGLbG40Ajo4QkjpH
X-Authority-Analysis: v=2.4 cv=K+W3jCWI c=1 sm=1 tr=0 ts=6aabe720 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=WtPzXf8rR9-QfVEoJm0A:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170185

On Thu, Sep 17, 2026 at 2:08=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> wcn36xx_platform_get_resources() gets the "tx-rings-empty" smem state,
> which holds a reference, but only the wcn36xx_remove() path releases it.
> The reference is leaked on all the error paths taken when the mmio node
> cannot be parsed or the CCU or DXE memory cannot be mapped. Release it in
> the common cleanup label.
>
> Fixes: f303a9311065 ("wcn36xx: Transition driver to SMD client")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wirele=
ss/ath/wcn36xx/main.c
> index f34d64464f64..a55861e65481 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1555,6 +1555,7 @@ static int wcn36xx_platform_get_resources(struct wc=
n36xx *wcn,
>  put_mmio_node:
>         of_node_put(mmio_node);
>         qcom_smem_state_put(wcn->tx_enable_state);
> +       qcom_smem_state_put(wcn->tx_rings_empty_state);

Look like you depend on another patch you submitted separately? Please
keep them in the same series.

>         return ret;
>  }
>
> --
> 2.34.1
>
