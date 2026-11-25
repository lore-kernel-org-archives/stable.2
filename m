Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586823;
	b=acJy1YfswTtB8cNFedP/yIu9Tf8C3XnBrIZWHnGVAtY3+yM+5wh6VDJKNdcMP8P1rSnz
	 gY7fgSdb/onUykVD1/uDvtDbBdDlCdfdcg3KCN+8Voaqm5Wrd7tJeR2pSMgDP/IKAA5fj
	 xv2S21FK0NiIgaUaSBeEQcLokgAh2JiQ8T1Lb11TqjnIQ+W4Xwl22lsJQZc/qnq2NNgRd
	 1w8TxsObFDSA6pYsDFH4Zgm7/qKwlMR03XP4Dqy0VS40kb6ap5bdOrxpUEFdZQu4GmDP8
	 7O+RHvTNt+BotSLp+fi5VgiNvTJwc1tEtALZD7vbwPF3dJc6y93jDQwE8ExZqmGh8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586823;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Cc:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=S/j/fokvVKGClygxW4zKgxB1rxF0i22APYl8+ucIMeU=;
	b=yNAoxZBj8usO0V4exPMJSWjOZEwAHXC/G3/8cWG6FyQDB/v8y6e80ErtKTtVB2iYbDax
	 LxfaTgvg+M04jEgeGgrpNFKv8P5ptagi78WSwVTQhPMLCWjl3Icnb3m0tA0Ih0DrFwzEv
	 ZEZmuf8aOePBZpDz7phw3qDYVvq+TdDUg4idH0E8Z7x81j8xt6HLgIpNwR9JRx6PbHTG1
	 wBr6yRN/N3Nzjt5V2FPHlkoV77aETQ1KJNn1YELmZBGWiDdPCLSY2bEqbwM2kPLullFrU
	 7qKFG/Foevc3tgjRSKO6NUxDN3eWN6JyUG+9Zgo9be+17SyuasBi1TxLEemgVf5cHQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=el3yKmm8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e0sMkvGd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC8606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24BC8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=el3yKmm8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e0sMkvGd
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2BKrn2741892
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S/j/fokvVKGClygxW4zKgxB1rxF0i22APYl8+ucIMeU=; b=el3yKmm8H366C4vQ
	rbSTnJzefuOqwWPVz5gQaLQhXIKkLk3c0+5JKspHcJoYLuTCB/NBQbYvQn4+0/6t
	BSF1A0V1niV45qBCBmOu5K8Npg/MDQ8HPQavJnSLmDpAC3LGxJxlvni819Go97qI
	CKs2NXaiCaBKP1ux3ylCV4YsthF99ql6WvNoGlSp90abEyeJmA93ag1W4x3B2234
	u79gpEjnr+6kO+dafaCmTooT/Rn2BR8ldaM53ka+mGE/n0BlIyJ0G8G7WyGALF4x
	LNMDgnAnFStmRmjpH5Ts7SVBVShtt1IMkIB2MjR1f2+H6GndQW8x8sBUsqoNdV3e
	jLLmyg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egsam5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:06:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f0291cc0f2so67927165ad.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795586815; x=1796191615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/j/fokvVKGClygxW4zKgxB1rxF0i22APYl8+ucIMeU=;
        b=e0sMkvGdF62FIMQTPgeATiDrrJ76NDm+eBbg+4knWqnRzIlrm9L2aXr429xsroNTDK
         jhJcdhqYLVZR9OUYlI+3BQSl6xI6BlcTXKCSLrjHPE7xYtmAWfMNlOes5S41mdBJljIJ
         83LPwEK6Wgdh5dOGTpJLSWBv2SZpfkJ2hWr7WrWBtxD+J2ajFOmVPdPD9RT0Gj6rYgqf
         gN1U2juqhLxauMqBtHbRAPdcWAVbEFZukgFeK7PkJHRjPFo+ik6+oWODNjjMc4F6mF9T
         qYNtyePPbGoKZkwD+ocACFe9qhWzskWNpCGFf1xks0xvklmS+F99dK/eHv0ZkL+bBwtI
         qzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586815; x=1796191615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/j/fokvVKGClygxW4zKgxB1rxF0i22APYl8+ucIMeU=;
        b=wgxzh5/jAFqctz31mpm/sgFoFEJn26qEtVtcoxxfJVXoK8luwWTfwwqIFxpRj+ELVg
         xe8cJ/e6OM9ZaUYt42Tgn6SsKo706QkPIrM4sxViySXkFwUH3U25Js3RzS3miRmP31Jp
         40k/FOmJjIYtERYJU6T+Q4iJE0YNUAbbQh5oOCKo7MwHvZtqWXhPSqCo4kYstCViFY0I
         DAI++odbQs+ncDJpaR6BZ84N34TaJIro4Mtreu8bkngBWZQkZiRFWkOvD3CAlt1iY6Tw
         g456VpLMMbuvlQigv7DmA+lb7dw0UYBkbRVNxYuoJ3KiM1foOu+ZK8s2VK80toshUS3K
         Rh8g==
X-Forwarded-Encrypted: i=1; AL+hErHGt2c7SUYMNFiGQS19AyC6B+jH6gzcTtrQKQTZOS2QZ2uP5aWXtVH9EOtWRox4ws+z87xggaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S9VnIuqhybStyJ9egA2T6fPAus2nXHxrGG5SCX6mqDnmdPWLw
	RP2TbcGJ0l8V8Nxn1edSemiV1oX837EqGDtymWkKXrkregaEKI1eKEIOmI8aMArYXAJT1FVtY7x
	8857ltsC83LmrVJyEamt3ji5LTVT9vLeOUOb0Y3vZ+4m8b9wQaqhh6perPQo=
X-Gm-Gg: AZFdTZfh4V68b+JSWSqX5iwD4Uua9dYoUpZoeIFOmMBFPoJPqaZQcN3E4ZXs7n/2ZKY
	7nUSwJj5gneofmwqoGI5ThTIvtpQ8njMUnqS3iJckh+U+abEYG4/psCP8gu6m/hkfw+iK0VYOhE
	rjeC8NCBJvp3w4VdxRB3tt8uRk4v+3MB0EWQ2T0njgy3eQm34zkrPt3f3FA21LqhiI+mk847V8+
	i/nsGy/vRvLYjCRakX+57LZDPCuwOiLJg8DvqKQS0HyTMky1l86nF7YVndYXbL0sVzCs36sbet8
	H1Macogd49ph4k6KQzXaBaL5UdWT6Rna0rPL/DceB8dWv2lxaO5qx1szJp9iRgnyLOyn59V/qdY
	gTOoXeVYirenEtR1P13zgYbsUHF4QMyNv1vvpq9ZVXCqCDktgGr2hqiEgv03MpQSzzDC7twstVM
	ky6iwskNN1rq6d5c3R0O+QAUq4GmYtJsqYD1txgGs3ORc=
X-Received: by 2002:a17:903:b4f:b0:2ed:3c61:bb83 with SMTP id d9443c01a7336-2f03f1cee2amr178125215ad.16.1795586814792;
        Tue, 24 Nov 2026 22:06:54 -0800 (PST)
X-Received: by 2002:a17:903:b4f:b0:2ed:3c61:bb83 with SMTP id d9443c01a7336-2f03f1cee2amr178124855ad.16.1795586814357;
        Tue, 24 Nov 2026 22:06:54 -0800 (PST)
Received: from [10.249.29.132] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c6e50sm79782845ad.13.2026.11.24.22.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 22:06:53 -0800 (PST)
Message-ID: <3d04aa51-7301-4d8b-93d4-1a7d28e6c614@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 14:06:47 +0800
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
Cc: wangao.wang@oss.qualcomm.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] media: qcom: iris: Fix IRQ synchronization during
 power-off
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
References: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyMyBTYWx0ZWRfX8lnWwG8IP2j5
 BjqJ8swDbF0hO5e2pkJdRZSF8sGRZBcWu4VVm6vw+txhcUM7M8TeG5wrWM3TQ82wL59uds8Qfr+
 KRkogG8F5YFfaIW2/rTmYPLI3ujz7+rllrBlci7yJhi3h5iOxvcZqaRWd3bNTZ2URXOtU6gJlUE
 vp/O7DQlhBfW7cTAWkKcPHc3fpoX2Z3G6aeMsbik4k/x1R9CxBYCwEHQODejxBtfC+JAFNRxWxW
 EV9B3aD4PM4cvS39Rs4KT/yTb++fpQdHcAkG2PMVSwguk/A0qC+gqk5oVE0G9XiaW9a3/n7xtPY
 B/yBVZ5HOOhdVgl8A3TQ4DA7gXFt9bJU8hJSXx9R1SAbA4U1u7Q0ph9TS1J/D8Thi04ItNn+MgQ
 4hegR1bK7XMkGE+8YmRZAMfB/EpAJltKHav3Z4U7FAFRB8gHyoXnr54UaRelgBzK1msJzFORans
 R5Ce/0EUN4fMnabK9Rw==
X-Proofpoint-GUID: wpESENsjjJkgByKHyNsqd8Vpus7Q6MKy
X-Proofpoint-ORIG-GUID: wpESENsjjJkgByKHyNsqd8Vpus7Q6MKy
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b067aff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=F58wanNFIcC05fkyUe0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyMyBTYWx0ZWRfX05xSPJDuCewc
 a1yX5n9YIzJuw9cgdR1arRzzya1w0kJQeYWsLU+7ORzM4PQb8RDR7WLDVVtyMSwfLu04yxnTiPD
 SjQJxkRZsO/4fVyZybAHppUkesw9CDY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250023

On 2026/11/20 15:42, Vishnu Reddy wrote:
> Commit b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during
> power-off") changed the VPU power-off sequence to use disable_irq()
> instead of disable_irq_nosync(). This was intended to stop a queued
> threaded IRQ handler from accessing the hardware after power-off.
> 
> However, iris_vpu_power_off() is called with core->lock held, and the
> threaded IRQ handler (iris_hfi_isr_handler()) takes this same lock. If
> the handler is queued when power-off begins, disable_irq() blocks
> waiting for the handler, while the handler blocks waiting for
> core->lock. This results in a deadlock.
> 
> This series reverts the commit that introduced the deadlock and fixes
> the IRQ handling around power-off. It keeps the IRQ disable depth
> balanced across power-off and power-on, and makes sure a handler queued
> around power-off does not access the registers of powered-off hardware.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
> Changes in v3:
> - Used IRQF_ONESHOT and dropped the manual IRQ disable/enable (Bryan)
> - Avoided the irq_disabling flag, waitqueue and unlock of core->lock during power-off
> - Skipped the register access once the hardware is powered off
> - Link to v2: https://patch.msgid.link/20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com
> 
> Changes in v2:
> - Added new patch to handle the irq depth
> - Link to v1: https://patch.msgid.link/20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com
> 
> ---
> Vishnu Reddy (3):
>        Revert "media: qcom: iris: use disable_irq() during power-off"
>        media: qcom: iris: Fix IRQ disable depth imbalance on watchdog interrupt
>        media: qcom: iris: Skip register access in IRQ handler after power-off
> 
>   drivers/media/platform/qcom/iris/iris_core.h       |  4 ++++
>   drivers/media/platform/qcom/iris/iris_hfi_common.c | 20 ++++++++++----------
>   drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 -
>   drivers/media/platform/qcom/iris/iris_probe.c      |  5 +++--
>   drivers/media/platform/qcom/iris/iris_vpu_common.c |  9 +++++++--
>   5 files changed, 24 insertions(+), 15 deletions(-)
> ---
> base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
> change-id: 20261004-fix-disable-irq-safely-15b2f712800b
> 
> Best regards,
> --
> Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>

-- 
Best Regards,
Wangao

