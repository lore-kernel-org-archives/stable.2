Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472336;
	b=2T/Uf8qqa4KcTYlhbisERu8MRB//RmzpYLEw+ZfI04MDCBkXFPfy8ufziKl6vx+zSWeX
	 hJ2Zf82Rx+oKLKE37/fHwdNCl799efq+9OtpjWwC+hxFNPVwvyjlFFQwEYFhda7h2MEsO
	 S/Qe9saMK2Yl7jA8HtohJ2Kb7OR9a8RGmULasudQQ8oj3gwjIKpkbnk1+Oyket1Rh97tF
	 vUSV1aFaS9eO9P3LTeZqVOMTsFXKDyODDM4JiMWKBDemJfvqAr7ko1e9IEubu7D8ZdYKx
	 r8IFk4+KrCvVNG33DM7Dl0JWWI4D1bt34DMjLTx5Sl7RldkXYEWj49ruf4UGbpB5ZLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PPWFCZPMdbZsiAXaewX5I067c3oSdHkIBL8gHJXwb+4=;
	b=oNCfJOnrsjy/t+BuXi+qX6gDtwDY3is5ECymcuzZb5o88g9Z0afUqAXeZ2zHmQetSkO1
	 0h5RUKAarjTjZUbaxhHhwqkh+nrFHrUTKAcpbLVdQ5H9iCao9obuUFMKVh8tXwETSXXHd
	 MqR6F9HzDgXEpL4PyMf0Wxf5uurWxDrICTAbZGbvH7nqTq5N4cXb0tP655yqMLC2nce2N
	 WhW1fIUu/uQ/vG+i4pPs8SewZiAlGIsy1UzGo8XuPL3W/IOcK7VXkKHeRJvlcKS/XGp1n
	 54XeEzNNQHBf7HAYA2HCxBVO9obopn7fWaNSy7EDfkucq4x/Nrg+B5nyAvbquXjoPlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mrvaoMjX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LlbJwqSK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDD606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mrvaoMjX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LlbJwqSK
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC548oq3477432
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PPWFCZPMdbZsiAXaewX5I067c3oSdHkIBL8gHJXwb+4=; b=mrvaoMjXok1Dlrsl
	WpjTc3NXl9lKsGAg51AWl637hNXcryK+bDkayb1E9faNuI/1UxEuEf+8Me0RGtbQ
	zYJv0HC2hrm6Reh6GkhhbWuTmnudxmx7l/b85pyA40gyKHPEf8Yj4IUFG7H8m29v
	RfZPM9NjBnhNOZ+2QGCMkD/9Dlt5V/riPBWbIVyo6v6r1zo/DRAc+rm69Eqog7Xw
	0KcwF0bghurfy/qD3iCYhBC8r5fF01UbTSYy+gYz3knxVoMvmmNIHs+pGGk5oX10
	39f1mOf7/KjsohUgrRYaHL0roskL5WTFZGkpM4QvPOU5ZEkRKetcwuwOeIhOGngJ
	mV2PUA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yugpr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:32:15 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9806756ea40so3108480241.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794472334; x=1795077134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPWFCZPMdbZsiAXaewX5I067c3oSdHkIBL8gHJXwb+4=;
        b=LlbJwqSKEEX9lVKTsnGMTeKhgcq24nHZDNr6JvsCOeyB0vcExZheamdpxl2uNVPY3n
         UsuO7QEXDopG/iJPacbd+CbUbiU4vOBK0PejSXCQvqbi2z1SCkXIcKipmBkX21tOrEAn
         MUY2gbmfw7j6TeiWbDu/6i4o9nGJjFEe7o4jhOjzSEaH9x1jimX7d5uVeerfJ3LjN9gT
         k+OIHk15fwP+U5jA2hnVAy2igAh4kYwLI3GhwFBF6cRidN3jA4RsjZUk0Xc3J83iqfMx
         1mOUtIejV4RCuMGtNsmdz8b/QKogjVejI+lok8GF1feku4Go+g0QrXszSDIxfhx3R1Ru
         Mp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472334; x=1795077134;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPWFCZPMdbZsiAXaewX5I067c3oSdHkIBL8gHJXwb+4=;
        b=v15xlsuIPKi35LrSfiRHupsSVNKw5m2Zc3hBRuO3pQpVwJrCah0tfLsw4/C4vFCcky
         stslLAgJ8FWx/a6KpHFrn9sJOTDmzgj64fCO7uapN74DOiELfXenpezxHjy3NA5lNhB5
         gjlX+RdZhKRs+WLYILtaXjK5Hwnx2TsI3v4NxL//JnV0KDnsBcwxQQAKiFVh3GFYY4b+
         usDtukR04cFTBlwzdXVSykm4FH/fYtS9O3X333VimChmhp/zXGmqaEUiRsyHEpzKX40f
         fXw5Td29FQP9aj2czORlwrFasOGFNZWr+J1spnmZAj8iOuDTLq5TOm1U6m3XEXQho/Iv
         eQJw==
X-Forwarded-Encrypted: i=1; AL+hErEOQZWjVb+jn/zwZzujGDxqe87ZhEkkqr60D47/qZ4S/vTlp/lDWxumEg2mQ2ePy44O5kJ+4SI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5XI9JUR22fskXY5oqefwdv1GccuWIefEbZBOeW/vMvvNFT3Me
	m0HMD5UFbH7V2J1Izyy/LbRMgJyN2nIAXi75v1nFl8wXYQf3R60QN82gxwR/VW13FeHH1584SP5
	ZLTw4J47tdK8LYBg2z12t5vNM9n6uwJu+rHAaoVYWU41uXMnIcDnwnG2bWMk=
X-Gm-Gg: AYBFou1z1/2hIGYJCsx4d0y3osRlmD7f+WQ/hp2fSZWPwfXZu/ye3gh97/YHalYgUcE
	7Pa07CTUsRQ2hQukeOPMcXYLP3JiyNcKvrRP+deRsmlGYLy9bkHsmZl8ZgQ+xrqvxYqHXt+pSRW
	ie9s/1GLhHTaJUQz6DTAJ8DE8eHzvRbDlNHTSVg6Pq0OQDCFRejYU+SbsZqhaNfZNUf5xqvChJC
	9yUAeDqYVdzr4N1q4xnTdyGh5APut2dXmnxrzLzq2GpaO0vjQgEbUqAJ0gwWgEm+DLsg7Ij6clL
	aLs+DHlw6tonkhF9Xi+PD1tr6T+VRZ7oZEVhf6uNqYpAV9wiYhslEswfsrkIJ5DA9epv5zFmv05
	eI16DjEmLnbvjd7K4F9KvA7yIWvfeXzvIkb66PekCxSxVDcOBA7/o66iXRN4CzW8DoccZlevwFT
	YqaRBYavjwo34pGfjlBrN4oPA53BCZFQN0SYOO47Mdc+87srH+MmJ5IOoTP4kwRQ==
X-Received: by 2002:a05:6102:6495:20b0:7d6:2c4a:469 with SMTP id ada2fe7eead31-7d62c4a0557mr1170907137.33.1794472334499;
        Thu, 12 Nov 2026 00:32:14 -0800 (PST)
X-Received: by 2002:a05:6102:6495:20b0:7d6:2c4a:469 with SMTP id ada2fe7eead31-7d62c4a0557mr1170898137.33.1794472334012;
        Thu, 12 Nov 2026 00:32:14 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29d24dsm52998955e9.11.2026.11.12.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:32:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: shared: fix a race in shared desc release path
Date: Thu, 12 Nov 2026 09:32:10 +0100
Message-ID: <179447232869.4814.17727040416334916570.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110-gpio-shared-refcnt-race-v2-1-8a0b76e01714@oss.qualcomm.com>
References: <20261110-gpio-shared-refcnt-race-v2-1-8a0b76e01714@oss.qualcomm.com>
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
X-Proofpoint-GUID: sdxfDp00xssUqJpB0FQYobkRlc8yqEUs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX35emLpdKptwc
 hlhsDrytz8lwKXVYsUdEtVTsOWrkgDD+fzSQ+UMlaDNWSTKMSueEq47R2cBDFh260noQ+y6aOBN
 cs5Jvq6Wj+g4ItDVyL4ePKJ52QmldDs=
X-Proofpoint-ORIG-GUID: sdxfDp00xssUqJpB0FQYobkRlc8yqEUs
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5798f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZucQ2ySppxIqqdNBKgoA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX3MrMfdNL6Bd5
 UQrKNaKZtxRGzKcmNmfyRAfnSMIt63h6HsJ/3qRyy5ZJfYfyxKbQPRsoMKiJ6YHLHdSvZvk5gS5
 RmgmRZ9nlU8CvnuM2WxeGrkkvzZ7eUHIFSbTvdcuqDJufZ4CRZcqzvs8yMqawvkeJ/GdYpq/ubV
 ULMfNwbYfH+gOpcUe8QFJX7r7Q/KH3ab0aJ4+XEyr5ytGZTPJURaL+nwWeti5c4WkKqvyCjKH+U
 8d6TRrU+pZVHSfeTkEMTFYrGFv5K6lfzi+K/m5hoZ41rnThEPMzmmaogCKsrSP1xpaL5yVhtjhy
 lryb31mFv7zb26Z/9vdKNn1UsRMFxKfoLOeIxMvvoP2MWwGhR9iXGkSbKpUt041vMmFgXDD5Ibo
 Ubsb1kWKZ5s6ktERiILIcuIe/SPjQKT36thOP3yDaE8LXPLJfiR4e+XTwNoG4WDgpiQPnD6LxT7
 3BVi8E0GiL/h72yD45w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120033


On Tue, 10 Nov 2026 11:10:40 +0100, Bartosz Golaszewski wrote:
> gpiod_shared_put() races with concurrent calls to
> devm_gpiod_shared_get() like so:
> 
> CPU 0 (unbind / probe failure)      CPU 1 (concurrent proxy probe)
> ==============================      ==============================
> gpiod_shared_put()
>   kref_put(&entry->ref, ...)
>     refcount_dec_and_test() // -> 0
>                                     devm_gpiod_shared_get()
>                                       mutex_lock(&entry->lock);
>                                       if (entry->shared_desc) {
>                                         kref_get(&entry->ref); // on 0!
>                                         shared_desc = entry->shared_desc;
>                                       }
>                                       mutex_unlock(&entry->lock);
>     gpio_shared_release()
>       mutex_lock(&entry->lock);
>       kfree(shared_desc);
>       entry->shared_desc = NULL;
>       mutex_unlock(&entry->lock);
>                                       // uses freed shared_desc
> 
> [...]

Applied, thanks!

[1/1] gpio: shared: fix a race in shared desc release path
      https://git.kernel.org/brgl/c/53043b9e83cc7f4e30e70161b67ae93c4c9fdb87

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
