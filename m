Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223234;
	b=cnVCvg9Lyf/MF+OSOidpWnHLEfToLOqNRdMQ5a3wFsQqRQsPrIwOSVWS3Kog5gZ6vSIb
	 FoSuzzb6Lm1n8BEkG95FGfC55JQgH7kHMdpkZlmEW39zjqgCue++GQ5fXtrStJok5WUNv
	 3USvMrY0Fv45fo0Ij6v9PSfLZJwmAhUiWesZynr+46WD39Pao/nwyxMP4Md+suxyhnpDQ
	 SVKvwwwQUyabVF5bBDrkaNpS4IqZiuJkbQb9IaHJu0lIB5/b+5720m3yOvGBR6mlT7mXv
	 kIi4oUKdjETJEQrkqpD9PYWWnhCpKv1oKJv06TT8OpUN8JBxfaiae1XSkX0AqKPwl/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223234;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=96kg8hVCc1U1u1y1GTIS1aXfAI5RYyXMEb+MOQ8pCGc=;
	b=TIWAVACVMMANaI9K0uRBRp1GUB0kGdImUIpxd0aD2v+QnKPXzvyi2PZhm57xpLOAzGWv
	 bdhiFdoUUBcxAj8o78XH3SknE1rbvNxqe5R/QjNeuy7b2gVobN4WLisHXXAs5ywG6dnSH
	 f/mjvOYcuufNiC/G3itIsocs6ZY6c+5sG+Yz0KKNS2AiZVlcbnisISFGJNR7d60uvGdqS
	 hiBzxLwQ1fn6/sY/fT9ciWdCACOOi0W1L2beTZIEurWHIaHGttw6b8yZvMe3Qt0y46lhI
	 clk7MlTe7gX1W9iOUWNJ0XIfderKScyG/ooPSmZrtopI/PoefE64UFMo24zL3J6xo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KETUDgnM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OYHYd73t;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD1606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82AD1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KETUDgnM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OYHYd73t
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIPSOF2970541
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	96kg8hVCc1U1u1y1GTIS1aXfAI5RYyXMEb+MOQ8pCGc=; b=KETUDgnMzsFH0FtU
	B8sB6yaUHUIBaLV94NO9tCO01n/MGxJ/4JhP1CfcPFMUi1+1blbOi5AOm/6UxYjk
	Cj7eR0dyK+a0RU3zYc2pLt2rl0QXQ/UKo1OD5kILnYqJvL0iNgOh0Iv2iGMvb2zL
	9BkCey3M2v+FZomI/+ZoMWwA0WrMXYYQ+2lVQyv0hAhr5tcuxtOztCYrClzDLzcB
	nMI4lRvV3FqaNXhumsm7SsGNoLAjT2hVSy4TXq8kOmAQ1XsHzl2jQ4T0R99Qx6km
	cYJG11myJNUBOrqsRnJcto2Iq/I+cNs60Kf6J2LC2X1jCs8EkSpCssp1oa4RUkSM
	60IzfQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehsjxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:33:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so4828138eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793223233; x=1793828033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96kg8hVCc1U1u1y1GTIS1aXfAI5RYyXMEb+MOQ8pCGc=;
        b=OYHYd73t0OYHJYTW1+XQgFsUyVF17MeWedMcglAlXc94WYbyd2snI6BozYkRPyivhS
         RjIR57vCNLZSYBChReODrQuBk9QuWBeh00Fd5T5D4RRM8k5PIPlSCy1ahJ6MzwwwTHwV
         ekdq6dckEE9JFYkCUaEYcE2RouOFtJJWXle79kdJP3/nDnpKMhg4+D3Prbqy04kU4nzj
         qtyidDuqlcmYcfQzDVM2KMIzVGLhRqGxD8Yp9Aeq+B5SHbIvi2TNH6wCHTRHG0kRHb3d
         eKA9J7k7m0hlBGHClhTGBs6iqJgR9BSFXd2R9nIu9HKtk8g7uT2Mmphq+HWa6QOjuQ+0
         no+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223233; x=1793828033;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96kg8hVCc1U1u1y1GTIS1aXfAI5RYyXMEb+MOQ8pCGc=;
        b=WCV/QX86iT+IPJPmciz937tT5mAASY+ae4a7Dr/hCsgQlO+k1c9uXOgRne3v0diTLf
         6h1BGzmCnywvy/QEpcd6cATrln6ooOaRaDfHqMv0X5taO6YhROUJHy0e1rCmnYAIV/qp
         HZcb+BKpJADnuOk4iiALRK7JIbTYMllhhQ8ISy0203rDTuT2YkDEFLqdEDHB/G6/XxQ8
         UGF/duYCk25BFAVjmdtrbTIVyogUwduYfxw+9BY8sNmNPDhr6Nbei90EBMXeFtzpM0bv
         3ZAR2/7RE8v1VSlwY5rzV2ez0sqrxsdPMqgHzxuJyfJ3A21rNPrvJxCULYE5h5hP4fq+
         Jdqg==
X-Gm-Message-State: AFq9FYIkY31efbiDajQugHu4IJOAtYxfo5Zf0CStNd8zkCExb9y1P4zr
	pouqWZzcndOaeaLKdJhx7C7QZWat5TiYdWHSF3sGKZ9RD5SzYJ+wz/9A4oCpvuuprkz7hgpqF6c
	cYrRbEpZD2If6c78M79SiYU1Ef2yHUdYeCfTRQG9t6jBSPquvviFUrNV3Snew5eOa2H5oKg==
X-Gm-Gg: AYBFou1JW2OgxtCa59cpbXaVMFVggusNVV/wUoFMF4tacoyPPcF8ubJtxFvVdahBvor
	pDt4CxnREyFdhJ4H4EISjDSArHBrCviUV096Ig4SE4G2Zlf1+VSn/QePfUVM/qAJ0Td1o/7HtEO
	NJMXkfxPRGBJtIZVEwg+PZdDJopIIjPvanldQMYaybHoZrey1Qp40HhGeAj6TrAygJJgBuftxCr
	Vds8vcekKlPA+Nks7afplMATEhMjNKf9B8DV5BRSj/t5s0Qh6bzoxHJE+snNUMbzM0Zp0OMKAzx
	nBLFTX2+o84eLJryO19kFnB1Ih0TxjWaQnGK3m5NPEvM85GbDb18pjt9XvDJwaHM96oCjU5p8OO
	pGLAHrqx121rdOBAW5Y5Rq8jWyjQFUITj+778C4tOn0k60QZmi1JD67RG54c/ZVnWJdTcXhNK5z
	dAWtqj2ig1w/DjiMj//KxpAY0=
X-Received: by 2002:a05:7300:d0a8:b0:36a:112d:fae3 with SMTP id 5a478bee46e88-36a20469b0bmr4858508eec.40.1793223232983;
        Wed, 28 Oct 2026 14:33:52 -0700 (PDT)
X-Received: by 2002:a05:7300:d0a8:b0:36a:112d:fae3 with SMTP id 5a478bee46e88-36a20469b0bmr4858476eec.40.1793223232400;
        Wed, 28 Oct 2026 14:33:52 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm9672541eec.5.2026.10.28.14.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:33:51 -0700 (PDT)
Message-ID: <436a2d4e-9297-4bbf-a305-5f6913e83aaf@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 15:33:50 -0600
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
Subject: Re: [PATCH v2] bus: mhi: ep: cancel reset work during controller
 teardown
To: Jiale Yao <yaojiale02@163.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261021110428.4143200-1-yaojiale02@163.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261021110428.4143200-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R-LiLhWMMNoISpDrDE05k-1_HvJ5-8uR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4NSBTYWx0ZWRfX8GsWNcwwJHFw
 HHX6lCDmeZWeQoe+uriC/PfC8hPTCypAXB+rTxyfKb5uVvda3LIDPPi7L4oC0ipg54E+JVlszgu
 xufzREYQnpUXnzq/o0iwxC82SuqK290s03sUV5HaL7xDLnr3w2Ea/5jb/mKkpb3SwrilLRghem+
 zCuAcEp97qXTVkAwGnBPZVqSN1Y48PYuevg0cePK1zrd7FTWc79UPsfT+R63mLoRrFSqNoynlrw
 lVrQPMe0kbV0PwRYuvgw5CbqPLyiZS+SF4iqE5J0m6Xxo3ShEiErNLlpURfz0V4jccg4TkdgXCA
 6QvLPpFPiX7lU+U7T3bOmNELUciVos4o4+bRDo1jKNEHPH1HqL/VoPQPfzFc3eyJV/2HHU3KXvy
 8mC2Kn2Mp9wGI7RjOOhCHm2OR1n0dZwwC9nnz8ZDRvFxS9CbczYQXxamGhax59aCA7zOiq42ZZy
 TLdOuicvqRgepWG/w9g==
X-Proofpoint-GUID: R-LiLhWMMNoISpDrDE05k-1_HvJ5-8uR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4NSBTYWx0ZWRfX5jh83dtsk9MY
 +vfMFqcKIpNFWrCtc4ZSK9FFbkWE/LS+043sZ7984fbyPD6q0pU0Bd5bidhN1fm0MGeI5xafxsk
 zOM6JZbM+CBVkhZPFJJd5VRqw/EL6ro=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae26a41 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=AskSUVmIeMB2-BZEYoQA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280085

On 10/21/2026 5:04 AM, Jiale Yao wrote:
> The doorbell IRQ schedules reset_work on the system workqueue when the
> host requests an MHI reset. The controller teardown only drains the
> private MHI workqueue before releasing the controller state, so
> reset_work can still run after that state has been freed.
> 
> Cancel reset_work before destroying the private workqueue and releasing
> the controller resources. The caller is required to power down the
> controller first, so the IRQ can no longer queue the work at this point.
> 
> The issue was found by static analysis. The fix was tested with an
> out-of-tree module that registers a real mhi_ep_cntrl backed by a
> software IRQ and a fake register file. The module drives mhi_ep_irq()
> and mhi_ep_unregister_controller(), and delays the reset worker until
> after the controller state has been freed. Without this fix, KASAN
> reports a slab-use-after-free in mhi_ep_ring_init() from
> mhi_ep_reset_worker. With this fix applied, controller teardown waits
> for the reset worker and the KASAN report is no longer reproduced.
> 
> Fixes: 7a97b6b47353 ("bus: mhi: ep: Add support for handling MHI_RESET")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
