Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE633B8D7B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622316; cv=none; b=Aq3EXMk8iZnJOLbJQzpLecznXtwdUJ7WL7bauLf8YZhWGvw0Qa+3Gsi8NkBsxyHvOq53qqMFvUfj/B6rJn9qHVJXPmNe3Xs/sDc0ibLev4CayK25kwRub4WeEeUzsarbLdOZ8NyxN5ObSTX2C3hfMNjL/4CZvzOFzP1OVeMhYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622316; c=relaxed/simple;
	bh=zfTn2Kc9WqhfDc14tF4xKypbGNJXvuqTxtRlcOWMzUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+Tle8zR76+5fn7HCoNNiDq2I3LeRqt45PtXTSac8JxsGvySAFdWO1abS+tW/ZirQuXJb0VdEFXJpQmogpy6Iosio9SjZY3jYPiO5eJ5Ypu7EdWQJw3c1AE/KK/zjAuptVYPMAnQDtXe+FrMO2x8s0f/pC1rVSG0WGDBcgrtPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCrU7rNE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OX203Bus; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCrU7rNE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OX203Bus"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L7fas9091338
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZOpXARkKmNj
	6Eb4RGQZtpa8uRlFLKJu52rmjCAOrvGE=; b=gCrU7rNESdBaziZfASg/j/KEnMQ
	sdlPBSIT5NYy8W/vsKm1PIHRQOoaN1kZx+0mOp3sFJgxqa9gnVQ0+LjRX/x8uzcN
	C4ZwgcgIDNI1+mIUyfLz+6J/yhejv6Elal4j7p/vmpumcaIPWtLNfXMI+Vm7QjOd
	4DeNvwp5dVK98Axqbt91dTcWJcT3r/slntjW+4llujsAcm4OQphLHGyvD7/T13Gp
	EDs4bp8O4wcyswzyNF7j7ifD03hESYOfCokjbvfLYXdz4w9+sD7iVhu4HBkqmVOW
	vXI6NoEScJ2l4LZPJBUggIzVUavw7yWejaIGwva49mQJ6bKPhHA455WGdRQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a9bky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:25:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0ab07320so157855981cf.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784622313; x=1785227113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOpXARkKmNj6Eb4RGQZtpa8uRlFLKJu52rmjCAOrvGE=;
        b=OX203Bus17ZpjFIj+OCPVxUoQM/Mc9QZ3YxXZzcrROltYw9uwsH9vkkPAk6nXhVkdO
         /E7NaaX9XQ+qgqMJjVCzbXGDaWgTXpaY/YeWxNs7lBeep8W3sg1abwevG5EHvUFQPTW+
         c+J8XJhPAAoxkRag5B2Bs2/bCle2TeZcyIlC1+Owpn2Xi6BCpXc5kT+ovBj+14dwsaN6
         G64qiC0JDx34JYZSJbjQJSbda6WzPRi7ylyFzy44yiFmlFlMK734zTgkn/UsRc9LzF/d
         3L/3cxTGsrjKxQFcOp/RIMUaurC6uFZC3LPqsLTqABxAcn6dcfgJtTgvFeICyU9kKhAH
         Xciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622313; x=1785227113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOpXARkKmNj6Eb4RGQZtpa8uRlFLKJu52rmjCAOrvGE=;
        b=byfA4XK9w2CMmMwC92TbThXEdxL2dr4Xo49y3ZhqrrJPOQIhkqFw8SedxC+xaXw7VM
         sR8Q3wSrRHiXVO8HWtBlRYkMreFf2bLBggNViKujsxsnwqXagjspPYp5GriYfEcSHcgA
         Zx1fObBM8ba7Kklynk55zEFTLcfVizDbqAsy12b3zrHMcgnoXFu7yn++4GJJXQveJjpa
         AmoY+DgHXj50yLxFg5w0Rtb4rdmXhRTlaHTOkKhpzhGLHRjIHOD4psf1FFkrGwEvm2nu
         6sKLSNZg9TCkDNnmX1SqPm56jQrfEf8iTvQFN0LOkZLqN0SRzQJuRk14QdbSxDFMleB6
         Vuqw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1vhl+swQO+QAofFWfKppg5QgN8JW6On0N84qBqP5qeccbJl8OCvK85ain5qOsILtIgVR2ulg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYMm0UBA31xM4JXFwPqrkDTpdGYOhY4/7a9t6nzsrDtZx8eT1
	S8UZcVMIZSL3aTobo6eEnHFOVyu1pVVrEtbJO0jGI2Sgo+ZhB95wUxRuoQV6iB4iG/izRH/n7hj
	KztXOC2vOJju11rD7VLuhGvh0NLuC6BunrIULh1We5Ylt1j8AVeknqyWjiHA=
X-Gm-Gg: AfdE7cl53IbYkbkm2WH+JOe0ezeI6m/sH/P5yqLgt5C7fHAiYrP7UMkj5mJXwmtXnW1
	Z2ohE77D2dBkU7UFrVN7qnl10nQcBeYDuSXi+eKAX1X2OIDl886Yx6JZQbWj7VApJiL74DEDkhX
	2c6wnqt2eOdq1DKRJqIggd4YxEks1aLr5qCnsorH0piVJtFP2Hx7TyUekr+D9c9uZgagfVsTyHw
	FVIdeSYAliZwxf+4inXfpJs5oR2DRGKznyAY0DgMPSBsdaSZCdPtX2bWZ6WWAwhHms7eAisJZvn
	xJATH3PB0JYFO53ltuyc7GWDwkrRhnuvk7d+EuHEDzyJXC3SV85VwDuFOUCeeWrGIvr0MFeG7Rv
	wXQ+sA+k6IbZxkKYxbI6RvGwfm1Ik
X-Received: by 2002:ac8:5d13:0:b0:51c:bb79:a52d with SMTP id d75a77b69052e-5213aa6d813mr166971021cf.14.1784622311887;
        Tue, 21 Jul 2026 01:25:11 -0700 (PDT)
X-Received: by 2002:ac8:5d13:0:b0:51c:bb79:a52d with SMTP id d75a77b69052e-5213aa6d813mr166970631cf.14.1784622310894;
        Tue, 21 Jul 2026 01:25:10 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:9dcf:9ab8:bffb:ec35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm39901054f8f.21.2026.07.21.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:25:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        demiobenour@gmail.com, Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, brgl@kernel.org
Subject: Re: [PATCH v2] drivers/crypto: Mark QCE as BROKEN
Date: Tue, 21 Jul 2026 10:24:58 +0200
Message-ID: <20260721082501.6128-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <alnlaCXmoLRAlr96@gondor.apana.org.au>
References: <20260712-qce-broken-v2-1-b2dfff47f7f5@gmail.com> <alnlaCXmoLRAlr96@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f2cea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=SHEdVmtcqMJQtNp9YQoA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX5mbN5LgCXKFf
 1ZPigKwMUcj5cgR8qcZU0IK8iTngLMN1ct/Xp5O8YGCayhctzQSfDwNiLiziOKCv4GWWs8n64dV
 oUYBH7XbdPYSi4t1E+CHecN7ckxfeNr/7cTRMDglPsTjCXz7zEmxt4+bKzjWFUPw2rEuob9aWnm
 wp9CKSfSB5zJ59R/ld9y7Nnlv0F90AE2uiCzFR7aLvFf1wA17tQZGziGv59ixzvf5Yvz5yfetZf
 hXIpySVjVfqL7QrMOYOENfaCpGNWa/aOGIjzSGXeYxZG9DdNrx+Lcx8Li1iv1TK39Xqlu9iMnK9
 dpkPSChHu+RnCjNel5D6wtWz2mgUNw6dGoWyTf8bHgbixt0YlSHfJ5FTWS29zmFIDW9h8R18GmB
 Qqe8NxjQwF8FGm2qm5bQjsfF5Q1O6aVGcAucjxQk91d9RorzLS9E5hw5VmdZ6XWbNMAeTXRwHD9
 miWTS1i1q4yLfnGxyug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX1OYiWnSF+Rq5
 a6lRzhwKGRtr2SQ6uSTdPNTx6r5sp3Q1FuJFvUroFoixIcv/hjRa8fbhsFgdInS4gj+MjRTpxX1
 GUGHiu8qn0rCUl/peE5Foicn0nn/+BA=
X-Proofpoint-ORIG-GUID: ZP9-r2tlAaghgA_qYxNcuZQJ0wadz12w
X-Proofpoint-GUID: ZP9-r2tlAaghgA_qYxNcuZQJ0wadz12w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210086

On Fri, Jul 17, 2026 at 06:18:48PM +1000, Herbert Xu wrote:
> On Sun, Jul 12, 2026 at 05:31:31PM -0400, Demi Marie Obenour via B4 Relay wrote:
> > From: Demi Marie Obenour <demiobenour@gmail.com>
> >
> > This driver is harmful:
> >
> > - It is much slower than the CPU [1] [2].
> > - It Has a history of bugs [2] [3].
> > - It does not have exclusive access to the hardware [4], causing races
> >   with the secure world.
> > - It register its implementations with too low a cra_priority for them
> >   to be actually used [5].
> >
> > Therefore, disable it to ensure that nobody builds it into kernels they
> > intend to ship.
> >
> > In the future, the driver will be used for processing restricted media
> > content.  However, the kernel does not currently support this.  Since
> > the driver will have future uses, allow building it if COMPILE_TEST is
> > enabled.
> >
> > [1]: https://lore.kernel.org/r/20250704070322.20692-1-ebiggers@kernel.org/
> > [2]: https://lore.kernel.org/r/20250615031807.GA81869@sol/
> > [3]: https://lore.kernel.org/r/20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com/
> > [4]: https://lore.kernel.org/r/20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com/
> > [5]: https://lore.kernel.org/r/20260524204537.GB110177@quark/
> >
> > Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> > Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> > ---
> > Changes in v2:
> > - Add Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> > - Add Cc: stable@vger.kernel.org
> > - Link to v1: https://lore.kernel.org/r/20260712-qce-broken-v1-1-85e2bff17871@gmail.com
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 1 -
> >  arch/arm64/configs/defconfig        | 1 -
> >  drivers/crypto/Kconfig              | 6 +++++-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
>
> Patch applied.  Thanks.

Hi Herbert,

I'd like to ask you to back this patch out. Admittedly I should have NAKed this
under the v1 thread but I thought the discussion we had under the Shikra series
and the subsequent patch making myself the maintainer of this driver (note: Demi
did not Cc me on this nor the Qcom mailing list at linux-arm-msm) as well as the
pending series[1] fixing the QCE issues was enough to imply we should not mark
it as broken. Please consider applying [1] if the fixes in v6 are correct.

Bartosz

[1] https://lore.kernel.org/all/20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com/
