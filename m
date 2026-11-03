Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708880;
	b=wmLHonPVgkA7Rv5A7bVzmQQ/vf0j5fveDHw6TAVOEM0OANV759YKc/RAUPYdz4ATm7BY
	 X4HpN3hBU5m5JV/oyZCtZC5ptAaNVobNmGyA3gNJzB5jY0bHRchehpVtWhDJqy+FQWYr+
	 h1gYibEd0U7DgBrP/G9kBwGV4/KCUS//9iWsweY2SZGhoFitBDfxlhJVAlzR3bw7PQzz4
	 qGR92vYKwlc7pl9uy83GhS+WtNwEzisEvoUe/6FS8wGjkmw0dgW/WW/iWgntXguYjlMrA
	 MV2u9myCKdTcI2YJUIaTOA1CerjRSl8ozFHYE2exfz7ZxH/wJullaVcVFyUr4DZ1F9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708880;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jq9z8RFA4dazThWyCz2uhR2f4H9dYXNX0jntKIXAKg0=;
	b=XFE5QSHjHDQgsw/yn80AdxnCjW00onk07wsOHsMsQElrGlmJhomXZJDGeeJh0l620eKr
	 YOU08awUOZ8PAcfyEBtKAHomIAVFTfMOsczePPA5VajlSr3DMTrBCnjsWsJbPARphUaP8
	 oeJJoNZT2xgiU98ZUx8KARw4Onk43uSL3fBcZFOGrIjZw4wXKBzX8b1bvelOnf+jqlbY7
	 XskatytOHd69rAuJU8jjSplIDKuYLvDGgr6xcznE1ccVqGE7vZZCoFInwCwO+MwozvluK
	 IxNuOclpmvfawPkLrhiapSkUrIErQkswjCn+Tc1ziNEDueTpNq7bjQ+qi6jbC3gWJEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VhclsXH6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T1VfbRAr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DD606D833
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 188DD606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VhclsXH6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T1VfbRAr
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3CPRFP2497470
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 12:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jq9z8RFA4dazThWyCz2uhR2f4H9dYXNX0jntKIXAKg0=; b=VhclsXH6+Yv91vvl
	EovOPCN2eJHAfCD21gEdkn2kZYuhYi6kBl61YPaDGYQW6bQXrCOOnfxjuUPTKCq9
	5GtQxDtwGp0IcxgS3S0Dy0i812sgRwDh+uyPNRdHPY9vLAiLEGus0uIP1IUiXQVq
	c2DzhlU9pQ6ySXp4/munh385bNNY3EnYG2Q7zCFCVaoSoK5FeGq0GTaP1VS2CEMU
	GOzpSOkLFXobu1kGEpRWBv/OQuTaed2ZDHUE+rOazxS2UsjN4EGqzlZ4EBd2DkyM
	E6Azuf8OF3QIHB4Mt1JTlar+vOd8ww4e58KMkJdhTaHbH3UiZ9CLo94fqBF7BHY5
	fR5HDw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3q1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 12:27:57 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99082f450bfso3197936241.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793708877; x=1794313677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jq9z8RFA4dazThWyCz2uhR2f4H9dYXNX0jntKIXAKg0=;
        b=T1VfbRArcKsKizfIpdLl7lKFSM/CUP/KIbyAc2zR6YIGMuJ8NRgk4grTDXLEVt7vBq
         9Nyo3M81FepRfGx9MJGb8kBsNALSv1IgTI7pdXNzzfIll4IUmkErpinmrgvZcjXxm3B/
         laJ+udEMrgXY3WvmZ+mJBhDe9V+1KyEbmBS3Gix67TkQcR/hjE2dgKj0J41lc+LsohdY
         DdqERsG4zhePD/a9J673qYBbC6vsHqV8a7trDNU2wQxUkpoPwrzMiNhjty8mEY8VGma1
         H0OA6+e6Gnxc8C+FfIUpBHr1P/6gKzQxS8dBfB0EVDbjhARwQ/HaBlPITnknyWSuO/8+
         I8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708877; x=1794313677;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jq9z8RFA4dazThWyCz2uhR2f4H9dYXNX0jntKIXAKg0=;
        b=FJaYnOA+ustt16P4od7nVuUCPR0kJJYvec8EXs/30f5boD6GfuBuwFOHUDpF4o8tv8
         JnlGXhSNFrQEJQ19XKkxxpuCfAS9mTNIyFc1eR+gU++VWU+UybLgaLY3fhyOXFTlUjqf
         lQuCL3Yz0ubdxQW2zevV1MCkr1h5cNQlUrmR/rsibJQXB/3Ci81X2/40Ap62w2jHgnKz
         lIR+nfG8Nk9ZZApJKZ1MbBO5eMse7CVVLc6zgnl/IXaPao7vABm3tDkrVa9S5TUmV5Tn
         wskIuFsK0Q62vScp3FG8p0iJLMvidyZdbOPi63m3Aa6aIkCSNAApgzsVditj9uX3YyA4
         L9Yg==
X-Forwarded-Encrypted: i=1; AKwUvByPJN8ik8oDUviDp6e0rXTmnmt2pbzlsHpRBUkQXEXELfa2rbsMwhajWVWjTEAkLdH/nyC90I8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fAc6xJn+eOEWPxjNFvdXbHKfrpFM/VUp+g8otYJDtSZstI/Fu
	U3KQtkictcyh1YH8x6DcpFtZwtgcUigR5fxOPSfDLgrXq5tsC+71FcmXjquMEgKchLj68USzjfk
	J+lAc6oFOt3ACL9S8IPNGCIUD/hpsdxDKZWWHMpeExmSBpBXkGNNvhvmA2mw=
X-Gm-Gg: AYBFou0ctdFKTZawHvI1EsePhE74WJhBUf0YoAqDJsHPK1Jm2IIdcKDkgDfQFKDkBle
	d1c9YboMxI714S4GlARwsOGvY9OPB2zFfV00QWvTlkXCvEamrLeOPl7XU5kHZ3nOU+XSjA9r+0k
	bk6dJFgidqufmce7US3OSA5Ckq4b6Bk8smATOIkOO5LbZ1EpBHT4dK2qNQ0HHDiDP6wYCOWZab8
	xch+Flr5XW0jbwd6tOAG2IMGn2gq0xpQloJWluTNOaGH/aHX8jT2/XEcQ0uWHubbK9/AK+NdAWh
	5K2r3vaWTet/iwokFyTN6qCSSMnVcX3btKuSx2GMvK815+F2M+W/4eMWxzt7+9NsjxfSw1gKSVd
	ylkeRyQOX6+py2RF9v+MdPrkDm8PhIXD/mMZrFKGtFkv/eAOZt9VeGuGH7IuqjhFG7NeA512Qjc
	Oc
X-Received: by 2002:a05:6102:358d:b0:7a7:198a:c2bc with SMTP id ada2fe7eead31-7d072d5e4a4mr6184606137.36.1793708877278;
        Tue, 03 Nov 2026 04:27:57 -0800 (PST)
X-Received: by 2002:a05:6102:358d:b0:7a7:198a:c2bc with SMTP id ada2fe7eead31-7d072d5e4a4mr6184595137.36.1793708876792;
        Tue, 03 Nov 2026 04:27:56 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b789ecsm23906739f8f.29.2026.11.03.04.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:27:55 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Yu Zhang <yuz08559@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: virtuser: remove the debugfs files before freeing the line data
Date: Tue,  3 Nov 2026 13:27:53 +0100
Message-ID: <179370887056.27597.16992402623638417415.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102075707.41742-1-yuz08559@gmail.com>
References: <20261102075707.41742-1-yuz08559@gmail.com>
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
X-Proofpoint-ORIG-GUID: pIlM-2a3mvq49INASoZ_-P2vY-bob3Sw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX0zvKS2HoX2XU
 YY//63Q408giJcF7RcIQtC6RO//JWKqS4ttD0XNxxK4l9nvtiU4ggHzV5YhLFFB9dQ5aDfnIWU2
 TxBSBQJmbKA6kiNz5I4IHGeofodixgianeMOWjwY/P4Cpu16rQlWi3RV7nN12NCyYOMEyIQhZ2i
 UnOEjCD55qY0cYj2PihGWHMLeB/9TfpGMjs0N9Txhbk+SYPRaoh4KKiA+honJ01lM1O86yO2/pS
 gtQRyQWxmwdrbhFob/M7dCVeu7OJyT6Xq5ZTa8JjVgWmw/h2NwAFMJBh4I6WGACKmf+acRK9AQz
 HcwZ7N1lnOkBZnjB4ZAg3tOYmEdDG4qHC924/2HZmCdeqRcgMHA0XHGcei1Aawp4X9bMx3qJfgm
 Xo6WLD3uMztmS5imn4nUxYa+MPloVhBUSshMWnfBkKps8UUM/z6qJCLVI8z/Q4OEg09fjA9MnP0
 m/Ia/kXvhssAH6jrcbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX0+bJ9y9hR2z3
 Vu408T/ZJSU0SLpvczt/7povQToRl3HL5lPJaMhMukje2ASRwobZKMAPkPkk3RpfPqiK7jYCA6O
 Rrl7xDocAiAXYcAlJ01L2GDsXUUHPCc=
X-Proofpoint-GUID: pIlM-2a3mvq49INASoZ_-P2vY-bob3Sw
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9d34d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=J7LRkWeI4YL75y-5Oa0A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030049


On Mon, 02 Nov 2026 17:57:07 +1000, Yu Zhang wrote:
> gpio_virtuser_probe() registers the devm action that removes the debugfs
> directory before it allocates the per-line and per-array data that the
> debugfs files point to. devres releases resources in reverse order, so
> on unbind the line data is freed, the consumer_lock mutex is destroyed
> and the GPIO descriptors are put first, and the debugfs files are only
> removed afterwards.
> 
> [...]

Applied, thanks!

[1/1] gpio: virtuser: remove the debugfs files before freeing the line data
      https://git.kernel.org/brgl/c/c2d0710318b8cd57d0ef6088d0ee4bbc1e827fd3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
