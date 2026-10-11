Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14843E5EC0
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700808; cv=none; b=gbwC7Yj2j6pSXnA4I8TH2O4bRqlolyX6cf8j3EoajjhzlgHmpr7QVrkNZXl4yK75HMYEe5FiVfHMDkb9c4bPqAQasXw7qBYqTjZsVuhPu/Ahjvpatb+Vy2PKxOtRQuKxmyjpLuM8tjHT8k8ZqnkWaf0+naTie0JyaqiRc+CyZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700808; c=relaxed/simple;
	bh=/ttv6f6dsluA5uZThmcG7fwuw5ldScTyjNi0Up5a3ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKCbZ0RHaTYd7DnX1zsgVdF45n8NQdayjqMrp0aRGnvPYdaUlpj3+vS1OgYUB+agqE2IfBi8jmeyS1Xq/eoho4QVq9vjkLUu+agMV5m6ImZIaabLn6sDoEyDjOj97IippdIgpq/mxFzUTXr+5serVQV6H/q8XanwwjgRuQx0luI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J2YPTxyF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dEmqAMbo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J2YPTxyF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEmqAMbo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B50aWX2426391
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lxQNniTxfj5zZUHLI+CqiLbzb4mfvWapYlrk/rSG0wY=; b=J2YPTxyFIOo2TrpD
	r6YHmsOhuEbaG2hf9Yvwb8aB4R8LB6HY5rgVme7XpOYln1z43cg7I+iuWtZQk2Iz
	aXOb0eyiKCqexF4Ysip33quqVJ1McbKX+5x8hcz+20uy+hOc78CQXYw7EIPo439/
	LZNCaem63jM+IKY9bkRmP28tguo8dXvztuoHTGy4ciAxtbQ+ZqCpym4xCQ/8wtE+
	sxsiiZY4u0q9BQMzGYLptCDIZrDe7mnqXjk4fPx2B1oQmTNxwWaqC2DNdgEmrFHs
	mUha1aWg/XI9Xy75N0rPjdA+//5OWw/jHjP8noDyqS9Zq10Kf2lrh1UD95YskNeA
	t3shVQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7aqmtwyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:40:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3592749a017so542451eec.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791700804; x=1792305604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxQNniTxfj5zZUHLI+CqiLbzb4mfvWapYlrk/rSG0wY=;
        b=dEmqAMborMpA3qNzCSxT+rSlJjArnMnxwr7IwhLmr8jj0EZ2giS6rJuAv02MdpvH1O
         +IL8cTc+wbtqNJcU4/04amHGQl/Lk7f7dBpDFUInv3e6mfFfPI5113vZ4dI9ajugBF4p
         CWPYW3l2ceEuVVfiezUUUu92x1RHTk1jqzFCi6au0HkLUfz3CTNmLGDkTEUrIptGxQO/
         CTUT+Mm+73G9FbkYjtexS8S4sDRlUWl9IcYwd4YHySNbKc2+SGDle2VS5Y0auAis4689
         mFxDPcbiPULScuzPLYNJvHOJezp2iGEdj/X2wHTpCGerfrTcS7xJdE9TRqjF6+OpGI0I
         W9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700804; x=1792305604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxQNniTxfj5zZUHLI+CqiLbzb4mfvWapYlrk/rSG0wY=;
        b=ZuyhELf7Y5hToX6ncL/OaFpEgbIoPvfl80qq2jvx0m4HDx+AzzfGDxqxh/nsH8bw80
         lIsLEjiIjnTk29zbpxwXVHMq42jQAkLZ+OmztN3QOTx4MBC6Ksa58buGqs6KFOgw2qni
         7CyqeMH6+fk+hh+qcXSj625Ff/FX9u0oUUWmoVR/KDk0dVCDKnEYz6RoKq28A4ivx1AT
         6/g+AxNQXKwns80tGTRRGeHvhHKU0IH+m+ZW/dM1UpqkzWkOaU374NCEl9t8teO5qthF
         7/mDEyQMzjAALyvlyDaB+iV+9VLmOLwWinH0ey3lsnL/5mYjPpsR46qXNALH5CBVWoFI
         be4Q==
X-Forwarded-Encrypted: i=1; AKwUvBz4d5nPlNUNU6bXs7vH2AgVZYzJyG74ZRqhF6Q4xCS58/0/FfLAjU+62JBvHfEJyxLuk0IkkIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAQlpDSte19XbM6i2K4bsTfalLCcVGwQqFedBUcPL2Zd0+UmWI
	Qh0sf8zrLoXykheuZDN/3osHhjPjgxIx+oRWzKBw//u5oakwGiVEBF3JCQ/mJEJKUMc6qPouW3o
	FR9XOHR8JWUhp/4tlR+7a2LV67BEAc6nepdkPNyPoks5G8hzyD8Sx3/LNEMs=
X-Gm-Gg: AYBFou1ChRapAutVDMDiq+bxq2R1QliYPY6qaxfxaDTU/Xod74TbFXR6P7wGVxTWnzx
	hDVksJ4DZygJ89RxdGcnykJ2mLoZiB7Iq/iTbrGeKMZUvP+9ZkQX5U5lEJJ/LchcuHul1gkdvPL
	mkVByq639li0cuJd4Yl8npvwXBFRP7S+6pClFxHyJxGdvhsnj7kEQgPMYHNH+Z+wLV9F7Soodvo
	sScnRcoGyg2bzFeYgKpV885x7DU6ppFDJFavc62x4xIL+SZ21hzA7P2hbqnPF5ltn1viD9+5JIo
	tMRBsA9SzOa2Mfkw7WjIa6jK8/SzPeQPxY+Nd/MimeHI8NcHwBPO8vxWfMckYEcGZZOEjy5/d8y
	yWs0Oqjc809FwVEmoAvPLfGAnAL9LFQ==
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id 5a478bee46e88-35382a3ef76mr11703220eec.0.1791700804426;
        Sat, 10 Oct 2026 23:40:04 -0700 (PDT)
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id 5a478bee46e88-35382a3ef76mr11703162eec.0.1791700803560;
        Sat, 10 Oct 2026 23:40:03 -0700 (PDT)
Received: from [192.168.0.8] ([183.83.143.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm24442161eec.0.2026.10.10.23.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 23:40:03 -0700 (PDT)
Message-ID: <9eff23cd-9f9b-e57a-9e50-a09a9e3520ed@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 12:09:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] media: qcom: iris: Wait for threaded IRQ completion
 during power-off
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com>
 <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
 <CAGEkeHd_KRRUZ8Kqvmf2BWF8stVg=_FSbx701ibS=KdoAy4FZw@mail.gmail.com>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <CAGEkeHd_KRRUZ8Kqvmf2BWF8stVg=_FSbx701ibS=KdoAy4FZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDAyNiBTYWx0ZWRfX10Gc4HxqC2Dn
 ab3hJpveYBug/PLzGIw0H8eSRH4iByQMvgCk22CIf1J+QONvV9tjW8qyh1zuUVpYkcR6iQQHoAo
 j9ktq/DZeQFaWmCIEkzDufIRMjkOA3Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDAyNiBTYWx0ZWRfX5mKOt8SuoBST
 UxLM4M2CSMWe1xwIeExcX9VbD96uR9A8k6+Tv67q5lP+2OepekButHNKtMjqPO7KZJdvSXO6noJ
 RYIYUsRIS+c7wOo2sVpxy/v0qoC4H1+/iOo0wTwFla3dh/XS37+HrWszu/lNAhCh1zcsYEMGYXg
 npqNYPfMv8JwLfaGbpR+6ZHTNIizlAhwTHgstggZSEcI91/uh/Gj/wcnQPuFRvgp285eR+AdtIA
 3OFA8XHWAQpK7xwu2OHT94Vv7bQpn3R7ZmnGayVD+JgGVJ/WkPd0BgggT9Ud3s4QYDyXAFK4p6d
 1TCcq56UbPdvS7WmbKEWp2ySPjuyWP0jjXWAYG1F5iYm8eBD84873hixOkjQ1UQPpBJhT9BxHZK
 90ksd4/hZSnh//9OCC930T+8ki5qypoDMbxnyqVcgOxdz/ePkn5kPeSle//v/V4ErHH+bbpGWx/
 +Hs35wX+hKLG7UiQ8Vg==
X-Authority-Analysis: v=2.4 cv=Uq32pOwB c=1 sm=1 tr=0 ts=6acb2f45 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ijl8aQlCsSTD5cfZelNzAA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=wXOP9t3OkE-NeulZwrQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: hoPK44RM1Rf9pYEjNStoIb2AV0Q3cr5S
X-Proofpoint-GUID: hoPK44RM1Rf9pYEjNStoIb2AV0Q3cr5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110026


On 10/7/2026 10:59 PM, Hungyu Lin wrote:
>> +       if (!iris_vpu_watchdog(core, core->intr_status))
>> +               iris_vpu_disable_irq(core);
> If the IRQ thread records a watchdog after this check, while
> disable_irq() is waiting, it skips enable_irq(). The hard handler and
> helper would then have disabled the IRQ twice, but the next power-on
> only enables it once.
>
> Could the helper recheck the watchdog after disable_irq() returns and
> core->lock is reacquired, then call enable_irq() once to balance its
> extra disable in that case?

This patch is not about the IRQ disable depth. Its purpose is to make sure
the threaded handler has finished before the VPU is powered down.

Re-enabling the IRQ here, during driver shutdown or removal, could let a
watchdog interrupt fire and reschedule the sys_error_handler work, which
can lead to a use-after-free once the core is torn down.

For that reason I would prefer not to add the enable_irq() recheck in this
patch.

Regards,
Vishnu Reddy.

> If you use this approach for the watchdog fix, could you also add:
>
> Suggested-by: Hungyu Lin <dennylin0707@gmail.com>
>
> Thanks,
> Hungyu
