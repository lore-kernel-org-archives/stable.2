Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF53A48E2;
	Tue,  2 Jun 2026 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427080; cv=none; b=OxEyfFfr9J5/IVpaLixP+xzdohopND9kQ4HizXJD9lTVynCKKyJ4ZSTny7ToSaY+O8qRYENd/TNoj1AUJjDlxN6Yr7ZJZzJMufs6NWgnzwqEgnMzMsQ81MecKL0BecmraXDnJJnunKzhtqwUW/+mrrB3cA4sJJu9l4OqGrdLsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427080; c=relaxed/simple;
	bh=Tdetz+xBPFsEj1Ectozg+hExtWWW0WUG1Lp2rxojg0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn8FsY+/Af6aY3cVHpryZkDz/KAlhxYYUpViX1Ajts5k+7C0oAXdKgFBgV8Rm277l5c1Td+7sVcORNqr6XhSLLHZbU4zXTvwugBDh5KKq6Oc/0a/y1aHfjSLTIIe6x7xhhxy/vzI6TE6e7K2DMX0wGiATyhCb2MN3rc2+g0s8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J85WQRn9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J85WQRn9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65288lvB125453;
	Tue, 2 Jun 2026 19:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DHY3ocO888ebTqDcF5SVre3m1pe29q
	lh67ao8bDXC64=; b=J85WQRn91HazVk/KL3domL9DBJajZq0GEO/DLN75sOH3SP
	Ye79CxrdxMPy0g6Z3mBMUy62csrTAqmlv7BLNhfK1sEE0vH8VNKO3HfGdtHcVeQJ
	rF4CXdhPO7S0gN7bjsWO6nuczctesIKXSTZ0Z+1JwDJgX3wVsXqkG+oBfWrxKUrB
	56imt98YR8jaZ5Ln03Ucu6YL0Vl+vqZx/DYxiiB//ohkab16B6idFNWMdqigwnbQ
	hluMJg6Z6DCKpIxbhY6CVQSJrBsUt4EanaciE6PiG/xSnP0OMqFRLPVgFXCip/RS
	qi8s/bjeJFodXfShHuVvVVD3ijveCpq4CEPxKLvw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae75u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 19:04:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652Is8C3007856;
	Tue, 2 Jun 2026 19:04:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegmhk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 19:04:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652J4LPM58196278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 19:04:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25AD320043;
	Tue,  2 Jun 2026 19:04:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA4720040;
	Tue,  2 Jun 2026 19:04:18 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.222.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 19:04:18 +0000 (GMT)
Date: Wed, 3 Jun 2026 00:34:17 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, harshpb@linux.ibm.com,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v4] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be
 used with KVM
Message-ID: <20260603003257.06850e8c-5e-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, harshpb@linux.ibm.com, 
	stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
References: <20260602121706.8423-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602121706.8423-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1f293a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=CVMXPQV5iiZ5r4vfs10A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6dIDJXalcTdr_FSQwICWwysB02J-crqN
X-Proofpoint-ORIG-GUID: uW4kRzFzjZB2-9ILBAon9Lja98LLw1Fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4MCBTYWx0ZWRfX+KD8xsQwi8Ys
 E8flbnLg/ZiOxfq7slI22AmegARrXKacnPdXxxwTyJdVq5zEHNZ5bIwYco7DUvflBJfuF4clH+u
 QYRE7dpfALe9dxUNolQ4hX+9sBpahpOpdnQ8zrpJD2AZ445QxtSOdCq8huiPWzgxAdH8qJZr0mo
 42LgncVw0brCintm65ONuxoDUqLGENhVoLkXtlnAASVDwQteyetGZr10MnQm+a0nQCzxDiEmze8
 zOJeAUCBAfMop7QqJW6R47wdP3t79I0wKxGodPEIsW8FFgG/w8d0bELYKboUvY8zrrMqV+D59v2
 RYRClk3yRObb9kt5Zexqv/ErpMsrlVTzftiJSdEBlXH1+ukR+uTfhR/HWO0gj2i5XxhHO1XvUQ6
 zs/xJB+TXVx9c8ItY5RDzP6wV5uV10JidwrPCKnMn3MpgnBF8/zv0RLt7poMT3KJ+0+TapcYCkK
 uJotuxkRpuXeAkU7XRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020180

On 2026/06/02 05:47 PM, Gautam Menghani wrote:
> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
> 
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
> 
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
> Cc: stable@vger.kernel.org # v6.13+
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v3 -> v4:
> 1. Reword the patch description (Harsh)
> 
> v2 -> v3:
> 1. Make CONFIG_VPA_PMU as default m so that it can separately disabled
> (Sean)
> 
> v1 -> v2:
> 1. Rebased on latest master
> 
>  arch/powerpc/platforms/pseries/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index f7052b131a4c..74910ce3a541 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -154,6 +154,7 @@ config HV_PERF_CTRS
>  config VPA_PMU
>  	tristate "VPA PMU events"
>  	depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
> +	default m

LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit
