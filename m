Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95B48986E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993006; cv=none; b=B5vmx5dA17ODuCvmJhgjhdCdQrlaCFGcBUvL8lsEVSkUCAGFxqpNimFfaCOMoTqJv/OA0cv5Vv7S+/99z149/oZwe6d7MJNi5XT2Gq1aGL0B7bkbUY7d4ZLePZDVKtS/yRkMSDieQT5oyG4PiXilNsiIeQ9ru3HeUfNkYA7vkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993006; c=relaxed/simple;
	bh=QM2U271Acf4FZQW/OKK11zrMNJwcmwAno4iDnq07zd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjRHgea8kyQKTvtulOOuh1fGhwCcVjk6NBKy5B2u/cTD8qNYo+zWjjL8P5pdXAOGvng4YGzvwbVFXjZmu1yAedaUAdAVR/oZS8TnqcD4fQrF5r/V7oLXFFElpcIFh6pt4t8u/5OtB3tTlxBKaPWQlGlaxMmYvMvE+Fn1Iw9uvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KyfwA9Tf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NnKRUpnN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyfwA9Tf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NnKRUpnN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdwEc287340
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YnyPyFINax9wnSB9nSbsjE759I4nGw6hd3qklAH9+0=; b=KyfwA9Tfj5P9y8XS
	ML7glImoY61B+lTic2LQ+NBDDeuKBVAd3AIuNGEqaPD0HWcwTAoSvO4HSedAd2j2
	j8zpmfqdiUqnYjK5Lo+P+iBzNlxIj9/TYBNwJaaCpLHVQdv7cBExnWUhAfqpCrk1
	pMsVibM/i3Viiv+2HqiU9Vp3juuKzJ+w60HGPMwPSGiwZAaE7dV1P1Jdzp8ewuHe
	flSxESm6CbwZ4TIK+u6VEl+RWEay4WH90JQ09hd9jR8cVKt7h+49nLjDofmZr572
	ND+o0Av6p21+yQgvri/B3uKkdEIQ5Q4pAQeSVsMPCMkVL6PYJQAmPsQFak9R78Rw
	BPRB/Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj1027-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:16:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7d6767d06so92027e0c.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789993003; x=1790597803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YnyPyFINax9wnSB9nSbsjE759I4nGw6hd3qklAH9+0=;
        b=NnKRUpnNv7BQ+VDM29pl8t7A0Dmik8YCJg4g8c/FIb2X9zg4AWt15eE5admcwOLG+0
         67/zkcMuxDcoUVY3VRWM1UBpH9PUILUTAhHoFbZSNtClAgdVgPiLHTf66QGtVrddxfiZ
         M3h/+3hoWmdAQSbvInwLmNAWbDOtvJyxaN/YxkAn8ODEFWU5oUVIvpA5wCuBQDbfNZR1
         SiynNLCqXT4Y+5Y/cDCBNgDedO+d0I4x2Y+oFpG0/pWW/ak6lS9KW4FbWhSUDqzbWc6w
         3zqDkRtrFd60xCqeUMmy0sJ5H1jeXpmqLczrBoWHyWPLLmlVb87r/AswiJ+m0JzFfDS9
         r+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993003; x=1790597803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YnyPyFINax9wnSB9nSbsjE759I4nGw6hd3qklAH9+0=;
        b=CWzD/b5+0VaI006lxYgI23lqdS5B6+w1nZG/osgC1dvPg8RWqT6mHZ7O1mIM6bhk4f
         qMM/mYdKpx4puMTHaam4WN7vTZ5v3i2frckGYa3THoT7cGcarXstDr/kGLhCtFwbIWxQ
         mi9ARx/XAULQATtkMUo9J7EfAQj5f4zK2IwNxecSsG2XauOLO82bpRduU5QT1RDI7i6c
         QG4NhgWWRuSQAjofByrbmYkpYDfYvLxdlr8GjaFGz7Hj6cgg++NAe6rZk9cePoSle+Bo
         YsvnKlpbPPeMhk4atjk+NU1CKVc9F3S2GOB8hzOnSaVIUkN7bzSvZ50ITCfGDO0T2Yzb
         xupA==
X-Forwarded-Encrypted: i=1; AKwUvBwcAs5+t2pYA7cdmMqLrWtdoMcUIJ3fYHUJ64oyugxa7njGHuZLKMACoUgWuIM90uTEEjg5Yng=@vger.kernel.org
X-Gm-Message-State: AFuF++k1ZTNQpWYzS2P5+qr+lArbJmRfdBy/OKb7SBps4uPxNaErhDDm
	ZuVQL4AjOH5gv2I5bwBoH9im2hoxwcavgEj+KagspLlF4mAvXp7awxVMTP1LNopsh63cY93aUEV
	NSvw5oTe5PGPD6yajalJWnvR1vG3LSNUD1nd3EqfwqU7g8TS4JOgM4v4IQ5Qcrzf4dao=
X-Gm-Gg: AYBFou3XQ89rs8xxusZ05b+5tc9/QnjHV2gaBHt4omuATJ+62ciJ8pr7aqPuiKjL8mW
	deQKrkzvGkeY80JKdC2G3jsMW6c6v2TsRhUnC9LsCTAzCxX/z4ArVDbRRV6/x2cuJiK8ARTaPwO
	ua37kav0nviiVDIUhWZvDuDlzbZZVWYub5/B0AgaMN0O4b4vRNBZ/EXt/rcjVVP4Jw8VxkyHPZ/
	B6rKXIIdSM7jcguXCN8VPQk/WtRRvrq0Y8uXdhuaBesw4gk7O6pChEEIqwCXzx9ttb5cGdFHNIb
	Q8eenfLVF85SNN9TJhc8WptP2ETz5yIg2MMo5Fn04zPAj6zcPpKV90OsaL6gPixNdF8skB00/fr
	FJOaPoNjh0ayCszYgGqkoFw==
X-Received: by 2002:a05:6122:4a4f:20b0:5c9:ac9f:b7f8 with SMTP id 71dfb90a1353d-5c9b86e8c7cmr3185206e0c.0.1789993003155;
        Mon, 21 Sep 2026 05:16:43 -0700 (PDT)
X-Received: by 2002:a05:6122:4a4f:20b0:5c9:ac9f:b7f8 with SMTP id 71dfb90a1353d-5c9b86e8c7cmr3185166e0c.0.1789993002756;
        Mon, 21 Sep 2026 05:16:42 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67c6f08fsm4064392a12.4.2026.09.21.05.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 05:16:42 -0700 (PDT)
Message-ID: <6d5dad55-0eb5-4a88-b679-ae3d39df1ea0@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:16:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: qcom-ipcc: Guard against NULL con_priv in
 send_data()
To: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260916-b4-ipcc_send_data_null_check_upstream-v1-1-bfc61f5056a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260916-b4-ipcc_send_data_null_check_upstream-v1-1-bfc61f5056a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX87PAk0ws3+5/
 RDeAwOqnVpO5UhCK8MOCsfsRg0qbz/3vnR8sbNhOidGZuildHg1Lvy+aFYjbt2r8RtMXpB7VQMt
 gbuqkSJzf7tiHWP7rXx7UjXgsNR3FXw=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab1202b cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=L9zY5Dhm9UC1ejkej2IA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: HoIfOvq4S0mLXIvjtSyzoaJsNAbIcxQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX1KkzR8EFcaE2
 nN/zFqj8cQkXsvrylQlNuOTua3M+ro4hboFnnVnqqqrF0sfljjZ/D2SklYqGZdILepRrfenlxvr
 yFLBS2g3l6tTGMXtt0uvCV7BSj5n0jgDuqM0vmAOgo/DND/sLKqGED0/gAhiqNLjedej5LwkF0O
 YzUNtq4SfpedfwxTmSVkPyBRLHYIzc0V18emZ+6bQNEbVpu6zLYz+MWlVHarxJCHLo/mW2RYEUv
 PbYM5VidulYukyGDnDfzKF3xVlUDsBD2M6eYudg0yK7NMfVRPBv+VhBQPfunP8aiHOaTRup+CQj
 txHcxj2S8B1QOJFi41F8FYOcEvBPAUwTdE4VPiwDO4FpBn6lIo8AAlxe40TBMixSDSI4QkeJ6hg
 eHgo4xQOlloEADufCG9dVfyWltU8ZnWtWzzBeM9A3NKWUbojoehpVRzJCVsHcii3yJfsTSwBe9U
 XQH90NQERpQVtBwTSiQ==
X-Proofpoint-ORIG-GUID: HoIfOvq4S0mLXIvjtSyzoaJsNAbIcxQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210177

On 9/16/26 11:56 AM, Anup Vishwakarma wrote:
> qcom_ipcc_mbox_shutdown() clears chan->con_priv with no locking.
> qcom_ipcc_mbox_send_data() dereferences the same field without
> checking for NULL first, so a send racing a concurrent shutdown can
> crash:
> 
>   mchan = chan->con_priv;
>   ...
>   hwirq = qcom_ipcc_get_hwirq(mchan->client_id, mchan->signal_id);
> 
> Add the same NULL guard mbox_send_message() already uses for
> chan->cl, and bail out before dereferencing a cleared con_priv.
> 
> To close the remaining race where send_data() reads con_priv a moment
> before a concurrent shutdown clears it, acquire the spinlock in
> qcom_ipcc_mbox_shutdown() using the modern guard(spinlock_irqsave)
> primitive before setting con_priv to NULL.
> 
> Fixes: d6fbfdbc1274 ("mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
