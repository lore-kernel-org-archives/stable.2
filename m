Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302553;
	b=Fdjnm4RX2MxlqivMDw/9o8nWvc8bIXljBousgt4vkW0JzBcwI7vtzRJRA1U2gpkLCKjf
	 K+9iNQaePXN5lW9tR6EhOF5PcSIY1qa9HMe+dDwI6Tu3qwC+ctUuo7hFXY5AGGVetHnEe
	 VzzTZEjzLYcTHY2NPUzhrC+BvG7BO2VwFBr6rR2mDuis3daCwUtlXA6AmIzOQvWb4ulsO
	 rIsOCtpT3rf7SZeJZWht+y0Nc51eSvsSbtGwP9T9Lf/uNQb0KzF91XBPFmiIWwW9fEwDk
	 dx27Q8kVOxpzEmCeTDtN1WCznlIpnal0vrT3V+EdRP3l6wP3XloSmq6MtAsua4SPXDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302553;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
	b=yFvW+JOaouitakMlbiiyxunJfpt0CoMYkJ84fUnwdZL3TvztzzCGuLF9Igi4GzUwsKGk
	 FX5djIzTcySeK0lw77BbsBvIJAQOppDR+MRU0fn1dvlUHyfPmqdlVkTe6+wBVvsvG3Hp1
	 FRFUweCuXs21QsBOI7xqA7vpfhGvWIsvxceDT0x0UMRn83/ip7l4TpEPCF9JWb6+KVpFB
	 H9mcGkE7POt1sfF9uTnsXM1QfY3OiExtnOe/jXFm8ODqjBrm0aVhGRnlT1X5FcGBmKqN1
	 qp4fgBsiK1J9uqYZX5Qns8AWDpC0pdQoLhVRG2dXOeJmaAd0twlt1bHN8+6okb6QAlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="TEH/lf6z";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Icz1UF0o;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC7606EEE6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34AC7606EEE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEH/lf6z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Icz1UF0o
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7lDb82240799
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=; b=TEH/lf6ziK/UgIYd
	uc0AeWExH4ap+dhJha48zpFanrmUVquEziATbcTJvfSUXNvCTmGNORHwNU6BQEZR
	gq7Mw0UyQgIVlK3VIKAR9mCt5g7ay5aeJydPgyieZ3o2KzvXKDYbU/cwGfXtw2lc
	tODvs+qdhJ7XxoXfKAgBJcZCwZrlv8phRtO1/n5lSbvRDL06sUKUIPYKcavx1J9E
	mL41DhnIjwpXgrSTvkdHj3r1vWeXIW1jLgbY8s/cfE3H7dou+yb+k2rHLpwFEQ3q
	f263ZN8J3UJ4OZK3MSqsyYa5TOcLlFnYqwAwzumqX1v1r7GAcTp/LTdLflbndjsP
	YfAHiQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp1a4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:22:32 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e98bada22so36169516d6.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302549; x=1794907349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
        b=Icz1UF0oRH3yKlXDYLA4Jjllfgq8a4kz+nRwPkVVcQVE+rnFYEFPDPOkBXaOkoWd1m
         GfdtjYbVJjGlzytbPG793LOVIdw9HLoHAXQBeExxR9hJWMuGc8fnO7b9wbJO8HNtxqMN
         XQ3S6RsqWq+TeWwly8paPEzfPn8GcSniBUmbxTQFvnqI+P4SmqNebUonfE33CmThTSCT
         mUk9E4gYbhmkRRRhGB8uLtGZuG/wjWObJD9/JptvYC9Wy2fV4Nkjy/4DFEwDzEUz3E7B
         AGJZNPh2rsTnWwpGQ2ULqvF5cvwxJraMeQ5OWBGkaF9U/vVZP9lDwIdmjlFvGkA3sgIi
         mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302549; x=1794907349;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
        b=iAE84f6vmPmKgMpKtu+UrxibFxe8M8Y8S+tere7KkcxFAUz0gv+VSA5iiWkBRMOj+1
         KzUjHKD53I+nl76IMapWMPVMLQjUiimfzAH8+nqX2Ti9wNAyBvhI9TgM6R7xUdTZxNf9
         PM0XYrToJFDSs6apRfekx4x/HVsSKmWyQlbf+kQMMByMblo3KfBXuumj6R30+J2hcsHS
         juJJ+PZRvkcor+juR7bk4us3E5bJ54QGxtx9JBZvmXh9xEJOV065/La6JhtpjMyvQ3zj
         AM004fVVrRETjboFvcrwTz4zjlFlpxV0azS3gGoxnYM4ra3wE4rlqzZa6ZtaPOW36qkK
         n8oQ==
X-Forwarded-Encrypted: i=1; AL+hErGfqhlWEDthYaP2a6WtGZIEr2SxapIbMKLGoObzdAKJnoY6KoVc4yLZD+stFb4sRZb8Ijue6tw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/73RXgzXmNa4K0qqkkuwftOTF1edLCo6WX1KetYbEPh12E69lc
	HbVVwmSWPyYDE4PL4EmSE4wTJj3Ofmu9jILhoI8HRLebWL0vW+fnRx3f9lEwPB7EJ2IAMJ1zmpK
	TLzaaJZ7dMU69My9YnN8vNJf1SgoW7BnWPfbHS0uBpJ3hB/r6rEnIsrp8t1JW0uWP5I4=
X-Gm-Gg: AYBFou0H2CZ0D96A5uiDNxE4bJMd5XwhLlelmjQfAYc5I3PU5nrPhjp11+f6NYr7VGg
	vLrXlm0uZmOcEyEvXQ2+TZG/UQPzioh+R0GAbuQunUWlUnJTuFATIN2rBrjYuQmus/Eo5Qd2Cnu
	V7+g+p+yZRjBwVQzdMl/o657LwSLIaaRew43mWji+TAswYo4Hexzm/BQm+GZdEYblWRriVmtd9k
	g//1VjTRLQ2l2oiM3vDaTjnpqh7CV7iP07rvUH6C3HIgyJSZehq8GLj/w0gGCMdTlyRf5bEFM6v
	7y7zTBTDHYOsmRv4SSZpnIsYiFw3P51oCrz0xrjIC+3X7hAiTt/m1CngAkW997GAU4Iker8lkuw
	kp7WnH9guMDITyHsZ6AF+ky+OHd87bBqi++0T4cAi80maQ+AggJz71vUGoJWmFn9XAblA38x61n
	utg8NBs3yKkD+ht8mPWJYi9EDSzqozXhOHc0/WjC1+w41LJSO7PxsI00025KgSnQ==
X-Received: by 2002:a05:620a:4514:b0:947:1d0a:c89c with SMTP id af79cd13be357-9479f326c22mr318964485a.56.1794302549333;
        Tue, 10 Nov 2026 01:22:29 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:947:1d0a:c89c with SMTP id af79cd13be357-9479f326c22mr318962485a.56.1794302548873;
        Tue, 10 Nov 2026 01:22:28 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01ff3428sm60703515e9.15.2026.11.10.01.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:22:27 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] power: sequencing: fix use-after-free in pwrseq-pcie-m2
Date: Tue, 10 Nov 2026 10:22:25 +0100
Message-ID: <179430254421.7208.10083406967609133170.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 3nlU4pcCp5Z9ESqr8x9Mw-XigP4LM0ki
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af2e258 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mVFbF14yMUIBM6kXvQ4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXy7pRFCOzZPk3
 dspnuWVhN7xNQXqJiOvVMMhk66CvrWt9Q3pdf/EIrwNW4OgVw4TZV+wNZHK4qM3LSXaynr/rEbU
 gFYaFpxFPw5I7phHZpKnjNdxg6ZMdiLnczB5Zm5hkQV5YVmQlPH3bAmXHcAIPxKfwbCFy8117Ff
 Ur7HuBV+nTFdRn8jXJiFdaWRc/etEnaPsxLkWYfR1a7A1eLcPbcMUX1nBXSDT7WtSXrFgjnZmA0
 zObEjpsSQmkztvjodSjfav1djFF+E+PbniTCrz//D29v89CMDV5MJBsZ0IatqaoRrSnJfNDlSmR
 5iD0wxlUSeKAZ4AwYA+yPJJc8PZPct+b5JF/rl8fuyXx9r71PA0Nm5xNTaFoooka9UqQchJ4QTE
 xMnN9o6uEgGDhTyTSpTXFzfHJZVrdnxxH7lPn+hcmwnIDDorHk84gDdHowH/26DIQU0lW8fsywZ
 8G8Jm07ZppXlg6d4WRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX7gNdxRduXbAv
 5fxEupuUVDnvFE9keFP8gCd0anQ2oaFMs/kXo4uq1w83XpWsd0ggsLSQ9rh13esAnzLSBCDd008
 z4QEDshBpHIQKzFskWdEjGzZOXCBWeg=
X-Proofpoint-GUID: 3nlU4pcCp5Z9ESqr8x9Mw-XigP4LM0ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037


On Thu, 05 Nov 2026 09:28:34 +0100, Bartosz Golaszewski wrote:
> This fixes a use-after-free bug reported by sashiko and then cleans up
> the error path in probe() by switching to using devm_mutex_init() and
> dropping the remaining goto labels.
> 
> 

Applied, thanks!

[1/2] power: sequencing: pcie-m2: fix use-after-free in pwrseq_pcie_m2_vregs_enable()
      https://git.kernel.org/brgl/c/cd5f26ed96604b18e4235052525abe6b4ba505d6
[2/2] power: sequencing: pcie-m2: use devm_mutex_init()
      https://git.kernel.org/brgl/c/e551848a3a80aa2e2aab5bcd8f022c594b14eac9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
