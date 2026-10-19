Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAF3E7BB2
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395703; cv=pass; b=IpS44EvEhkTSYJ3dPJER75aUoRGo8tST6J4CEXNDsU2Zg28i99ThGvN6v5av8FkPJJdYtaOwx/0GfykdU0/jC9CjkC0Nl94ZN7lAl7TqBrIlD6QG/mT19mEcAcsj6y0vwl8qKcPzhquAME2V2AjKF248VYJ+YsNzgA5CFtaLQE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395703; c=relaxed/simple;
	bh=h8c0jyzgi67+tCd3ukwwu6aqwYJd+LcuIZyhRhSGv/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghpddMrol6aQc4VEh6IHJZXxXQ+4d+n5WjSIVHfILGLWpP6vmJ9rxaZUC/5omto3O625Bjuq5ogV8tf5oQonkGRLb8QqIi73vo3Eqzslkj6ZHoZhRRBA5SY0Ma92obggCvA8hF8iUtQll7asMV9VeShS2o5HWqZOFx8XdLNZfiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ie6BG9nl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B1LYow1D; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ie6BG9nl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B1LYow1D"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4j5nb2177644
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rgncg1X2NqOexcfRvQJKJUsizuXyxT/HxxZeYT2aoFg=; b=Ie6BG9nliLhoxWdy
	55QRXTjafw18UlwduSmAdj2bFtb2v8IvtAWgmje920t7Gli0TgodefhQTDgmSt33
	KNkDwZG31Jr/TOA1xlhuHrfUhUMnsUr01W6pKsWqd808TkkLmNPvU74u7Qel6Szk
	nYCZUtFvlMYCtDkPRBoKMZeLZrWv6ViBDc/dhnkbW5vowKJ2aF4q96x74RCnRPaz
	lprc4fDf3OcRiWPHQqVOiHfLZsIEzhnoV7U4tcvlo1R2KZSOVzfTFH+qaGP5cShT
	2m5KlHreFpPCTnPGk3TPb4eVL0ubqUdyUCADhWnmRCLLn76sd4tBwOuxVYzZqkhF
	/Z4BKQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5u1hkwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:41:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ae8e7e546so406539985a.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 00:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792395699; cv=none;
        d=google.com; s=arc-20260327;
        b=R52kOEG5q1Egr9yfD9Z6qLLa8cK6w7ohl9mSQ00ZcNh9eoOf6tc4J5lg4SaPajON4O
         oeI9rDpaOA5CLFMmiV9baiVL/6vAmHibSIVqXxANm8nc21BaKV37wEEatD5D6nzoF+D1
         1WTLwHmPZuZGGBzv77BbmIYoX8qdHPLhIQs6+obD+iYVJXsILKkHFeNKHULgvxYubpF+
         Ypc6lR3L331L5VpXaQZquGopGaCxv0irsdUNx7eRgKNLcTzWSiWlnsMKUMun8nt4vG4M
         PueWX5HWjLAVPepTi7LfPUlffBLKlyKuwLwcpzBUfQrnKqA+g6y20aqkti9ORV+tlKhe
         E5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgncg1X2NqOexcfRvQJKJUsizuXyxT/HxxZeYT2aoFg=;
        fh=nWCYPoEcD37ARexqq/+T6DQNXxn0+P85k/e/22LjBGc=;
        b=m/P/G2hmOL6YmniJU/+MPso09jjDqgcKN8hEcOBUyLOqthKyj0dlr3og5ctANJug87
         ZboqFinLimysCfc4Vlo8JQikZY8qnj0dm/pNbgN14dC9R/v7On0UChgcD9vXWxj3AN1e
         0YdZpUVSXpp9uEzWbwn9B3MsbWgU5cODUUb0wm0ACnH/VhiRtswIiEo8+4qFiFwvI9rQ
         8iMwbDaSeV7JcxHlAKiB54yna7KHJ9p7ulFkuQzxea1PiUTEOtkBMtBMF/Fm/fKWs3KQ
         o5ncwEME1Tjt0FPRgINUt9CSiUCxxI9TTzdjXZana/wlMLV2X0Er9o1glaTZXUdYt1tO
         USUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792395699; x=1793000499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgncg1X2NqOexcfRvQJKJUsizuXyxT/HxxZeYT2aoFg=;
        b=B1LYow1DGophj4wq/H/Ya4GJLEfgoZAGGnkiAbwG8ZPcsQJrCyBv9yzL9w7MB9P3TD
         oLZwjPtbqzpnN1GNBakFPqd2BtQ3WteQDgnPm0nhKotwOlzZ2/dctJXYQ47Ix+dy9qQS
         WjNaP5qaSQNgTUdPyO2BfZr4N1VQKC54hed8IJVYb81TpncXbQA2ARHnlDAk7kFbCVnH
         XZi5qybx/DNZieRFG3EfGA/V2/QZ2WeOpblFlf0czNfcHobGLkhPxG2byPYSqie72lJ9
         dNF/MJ783epkJwEVgkXPKybk91UbA1gmKvwdrMV2euI8yuV3vBpqHLuj/Wmg6uzeCoKd
         2eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395699; x=1793000499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgncg1X2NqOexcfRvQJKJUsizuXyxT/HxxZeYT2aoFg=;
        b=a4wrmFii3MpWdh6MJEADy8qocrN1TPuzxmzBw6hmCL0Q0t0tbEyeG0mPuJsw87pHv7
         2O86tbBICjP1u/YFoQMXpljaNQlNY+19Dl+JKJ/jJp22aG7D7sKT1avh8sSe/SuhEcHy
         rbgnpusr7hyWMj4YZzIAxJjOqkdFvtRA996EZD9sHDj2YA1TTzuQddvYDgT4aIPOnL8o
         HgVklf1pRoELPo0DF4Hozk4H4DJWNSFOVE2fJzy4L54XQ6yN+/BShSbomvX/v0ViQoPS
         ZROirwgBBPNROJPvHnfCYjw7huolB3rkv6EMNahw/gL83i5zSZqT7NpklDm8Oq3/TQHT
         oyAg==
X-Forwarded-Encrypted: i=1; AKwUvByaUeMwxsB2MHwb6aqPitJWAzKpAuP+OfFUOVRHDVtfSY2EI1Hp66wfA4IrNipJazT/VgwzqJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkxW/GNR6Mh6bUS7mRYEoaDp0TYDG69E/1XkPq4wxeCrhEhcXn
	za9Gn8hhcItWOwtIMWvOnAKKV+l3xN3tP+Fv81zBtphBJPkeNt5is86iFX0rdsPSGupiRRhOklQ
	N9fR4AqhYlwcPcrPLvCP3ohU0ddqsm2f+mbyKaKHmV7WlIpF+5iSdz+WYAFyE66n17plZymo8jq
	VX7Hc7k2NUNLHBMD7AXJs2b/dOl0JUlfQTyg==
X-Gm-Gg: AYBFou2Y5rJesmwLUvfYwhuKVZluKohgQTOTIZzimr7fGwTd8pW2mNECVzGzInokSg6
	WR8i6nCGgtRZ8L5EVeesP7Ny6oUgmMQJ1VPOqErXtaam5VLgjihXKFW0LjRsbZ+hz0dbteZzpKt
	rE0RPxQWYWkEohGb7Geg6DjLuVujxjk/9CMoRap980HuHwtjT1AwPZ/IRwo0fTOWAFk1O3Su+Ha
	Rc5F62ny4etlBPackKUAZYtu+fda2xUXyDAvL49ziQyGIwWuiVu6WXmuZ5b67aR4xpyGNpC0b0=
X-Received: by 2002:a05:620a:294e:b0:93f:24e6:403e with SMTP id af79cd13be357-93f29d6fcfdmr1150743285a.54.1792395699225;
        Mon, 19 Oct 2026 00:41:39 -0700 (PDT)
X-Received: by 2002:a05:620a:294e:b0:93f:24e6:403e with SMTP id
 af79cd13be357-93f29d6fcfdmr1150741285a.54.1792395698710; Mon, 19 Oct 2026
 00:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019055109.49922-1-slark_xiao@163.com>
In-Reply-To: <20261019055109.49922-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:41:27 +0200
X-Gm-Features: AclHuK87o9aE_B39B5wPYtHeWDW3Kp1B7I1cs-f1eftQiD1mAzEwlv18JNhWfQY
Message-ID: <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
        krishna.chundru@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: AsfLwZFilDiLPesZQBWQGFgK1Xy5EPrC
X-Authority-Analysis: v=2.4 cv=NItAaE6g c=1 sm=1 tr=0 ts=6ad5c9b3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8
 a=vR8mXinTnKmWltssjH4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfXwOF6dAk8Dgtl
 PSyaLNTpG1FuZEoN8brh00HSnIc0+cBcRyfOuOWoA7ttAOgQ1dVV4Aarb2H/MCHlL3AIgvupVUO
 wRlKQTsyhqDPgkGzustZbN4JHAWNILE=
X-Proofpoint-GUID: AsfLwZFilDiLPesZQBWQGFgK1Xy5EPrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX0MyC9uDquGEz
 v9fF6vHctFrbaXglO789Dt3RDUfg0kNnwgkrGkECxBFHByLf50d+yEfnFJm5EV2d4c7M3XpkA7Q
 juC75JppheCFIdp5h5KUNfRjFbhoAxdFyGoeYoso31ncsJiM7vNfiwo90LQfYszlok7s4RXjh2Q
 LPeIDt4Y++hIqKUZ3fwGbcxBf5xO+D1eSqJYBFEeoqRBMumWHC0/7E7y20KKVzg3qCPE/rorY78
 z86qc10QY4nIYhTajaM46ygEg6cnUHi3QcqJ7QDlNNbL2VBwi0YIRqGsbLcHw5KWKX11MWU3YzK
 ajaPUaDX3FVi3FzzE2QASQirmJ6QAIHfhRx0kJnqN43v3pGPcI+acPfRDGIhUT02lsPQxyBh8lg
 iaQ0qn/qwlmB6Pf0eWD9yrCD+0AfhZBINzMVpKiEjqd2ClxHqexEVxqrHkLoU9CyDqWY6A6N9LA
 zbyYCCdxHnw49bxXM8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190030

On Mon, Oct 19, 2026 at 7:52=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> For some MHI devices in some specific scenario, the default value
> of autosuspend_delay_ms may not enough to handle last wake event.
> This may lead to some unexpected problems.
>
> Refer to the Qualcomm's Windows settings and we checked this with
> Quaclomm over case, Qualcomm recommend us to set this as 5000ms.

Qualcomm

> Qualcomm also suggests us to update this for all MHI devices.
> Since this setting has affected some existed kernel versions, it's
> better to be applied to stable version.

This looks more like a workaround than a proper fix. It would be
helpful to describe the underlying issue, including the timing and
sequence of events that make this necessary. In principle, either the
device can be suspended at that point or it cannot. Relying on a
delayed suspend feels fragile and may end up masking the real problem.

>
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index 7193a384cca4..40735beb46cb 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1483,7 +1483,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>
>         /* Allow runtime suspend only if both PME from D3Hot and M3 are s=
upported */
>         if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
> -               pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> +               pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
>                 pm_runtime_use_autosuspend(&pdev->dev);
>                 pm_runtime_mark_last_busy(&pdev->dev);
>                 pm_runtime_put_noidle(&pdev->dev);
> --
> 2.53.0
>
