Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24239FCD7
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147513; cv=none; b=a1UtgNRCbh7ln+MRXYf3ZWp7PsHfVfZKpqr5iJ4v4OncxbycIQjmbAfea1mdUxwN1J5Gu8MW+MRBhHm3DQdmq/c6FqtE8cU1Kh0U69bmj8uT/8UBp8go3SW8z5EX/hqAtSyKJgZpmHY9WFlIKxQtTB7d9IJaaaymDGE9xUw8v/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147513; c=relaxed/simple;
	bh=PL3Y/OGVIddkHfghNwrPveSkZti8Tg9sJA/T7YXXSGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPqvGJwTfMP0UF+m6MrjIgTmxPUe7zDFWBWiomRQzs0Kb4e5TGYvw6Kwdy6HsgCsZtMPBck2VvrO9IvcdIR7Vb8VUxDV6WgqjaQkaG0obZD9wymn8OQgllnHj7Su8MBdoymtgBxfskwTCElMEuKPEgcUF8rJQvNL9yggq5gWH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gULjHIjz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLEFWGa8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gULjHIjz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLEFWGa8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N79b6k2432960
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cW+ibqBFuMIVxBlmmWUKocuRJOhtUmCAZ5zWJ8R1vY=; b=gULjHIjzzVanapEA
	nnbR/7uLhnJLtpd3LOmhEyGHuqNIBEEVwb8LnWDJVpLDQDAX47oT4kucSVqSks2c
	R0x/tA8YXVg92nBfAWmJeI0Ee4oq7oEQHVrQlaSkH49cCwCo8YsTtM8EcWGgwCu1
	d17Hh2F89zjLx+cK2pH67vmhD9lI9TSlxl17nUVSPlLjMUgbsvcu5au3M1SHaDg8
	f0AWFdO5NqWt4ROEqQlZmCmWDGaTfHa2ZVyDf47rZtMNjvx02cYsWUwK4GfGHOxi
	VNVcN05UtU2JGDY45qFpvx0+fHuMydAfdqt1+ttI712/TjVw7LQNLnUXsXGpb1vf
	+M/1gQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv3319hjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:11:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a08ff8451so113255485a.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790147510; x=1790752310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0cW+ibqBFuMIVxBlmmWUKocuRJOhtUmCAZ5zWJ8R1vY=;
        b=cLEFWGa8Xy2VTTwYJazENciS0EZT08OB3U/Sj8QxKtpnlKJPNws6GKdQ/2nrBBnuOV
         xOGjKd9QqUR2+HkZIrcJECnwsIw9S9+2NgQMLDCY1/NHH5cXqltAAxG9JwjqbR8iV1i0
         YLsEaruXpEZqNAwAN8tc8Y1Dg5oju6Ky0Iv+bCXJEQ+OXDfhWxwjgGBCTgyPY8SbH4/y
         8KGhiCghvDY+Ig2stD7Xen3gjrz5NaIfCgp6jTwSy6Dt1jAq0SKpNTYVc1n4uG+L3gKH
         TBkVn5PmU31VJA48sJuR2RZoV6rM87eDhOah+vKBU0T9OGoenRhtyau3qYxj++Y+i7np
         RavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147510; x=1790752310;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cW+ibqBFuMIVxBlmmWUKocuRJOhtUmCAZ5zWJ8R1vY=;
        b=pFa279dSAqia0Ch/8u+VPQAZhDPcPJckxFtNrsrW7YWZl9NDgQcw2tTVD4CtuzA4YL
         pKNjAtggTmtuTv1ctp/AWRX2JXaGRq0RZ9OUedjq0X2zuV0FeNEgU6GIEerKdI8awRI5
         bSa4sp1rRHhVc25XEAidj6FGr6spG3xZOksqBvgztUVHTyXfNs8MUT3TJFrFOM/Ry3xf
         +NNBLpSdJtrEXqP7mjxLW6Z9CmcbMn6sNGiJ/qIXVB0m1ClqI0O9q+F1vumGTG+X1gMb
         ZB8cYNQpiySrtNKzBhs86DnplCjGfF+pS5nzxuQHGoF2D1ASpFRCPcmnwKGtY8w/lK86
         IksQ==
X-Forwarded-Encrypted: i=1; AKwUvByNw2ezIDZNMf8jeNKVb0PEVA1ZAhDm79nzQ1HmLEBIXMoi0sg++IJX//5pHOBawdaIIgAAeKg=@vger.kernel.org
X-Gm-Message-State: AFuF++nQkZ/BzZcdu4cOMaQ6K5DNuSVHoHQE4OXYjCmWmlji1fam8+ZG
	AUxUtCpQJPxtpKK+qZ8wy++lJ175GWxJRrapcQZiIslKppUJC9EOZz1/kEvBp/o5z34DnMqQFqu
	8YUSDNlsFYCaoagRrPJN9Dl6EvjrOKrlURA7bF8sJc+PUnWklSS6oyBajUag=
X-Gm-Gg: AYBFou2cEu/6KITVro7pNEb86gFQjyTIbRSIFw43JEaD/wF79A6KFDlFiXliQmmZ6Wf
	UxZNVZohD4SJ4GNd2UPQ6HffNu1V43917U8ovE1c/p8lFSOBs5L0lbmzu8XVf1r9pUXl32mqPs7
	RKzJvjYAEVsFuQhpNo6Wmljj1SKz3x+OfbLfsqpVmkbMVtPDiLzxh5SL6L4diuqAcnwj5o1SA3Q
	f/Pby/nEzHhG1l6/KnrGtKJrvdn7NYUcQ+BQHPOXQC4izCTInFap+Y4T7nptXWBZR1JO3ZQ3jNK
	cwI7zhVZl3qq9hvWJw/SWO5mBQ9tq4mapTlih0+DDE8XF2PLOuIYzzc6N4PdQ6nocRmdG36iyWZ
	PevVNxktJ1sSZ7FCSKUDoIUuE04Ka3+OvctBgMw==
X-Received: by 2002:a05:620a:649a:b0:93b:d79e:18f7 with SMTP id af79cd13be357-93c2521b50fmr271387685a.58.1790147510361;
        Wed, 23 Sep 2026 00:11:50 -0700 (PDT)
X-Received: by 2002:a05:620a:649a:b0:93b:d79e:18f7 with SMTP id af79cd13be357-93c2521b50fmr271385385a.58.1790147510004;
        Wed, 23 Sep 2026 00:11:50 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:34c6:dbd6:5b58:a3fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868266822sm5199633f8f.5.2026.09.23.00.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:11:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3] gpio: cdev: fix kernel stack leak to user-space in error path
Date: Wed, 23 Sep 2026 09:11:46 +0200
Message-ID: <179014750449.4502.8575996857218879087.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
References: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lvkZyY-H622FO9U-BL5UV9dgvrFTyi_Y
X-Authority-Analysis: v=2.4 cv=HdaB3SE8 c=1 sm=1 tr=0 ts=6ab37bb7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oykLyDCHHkduaGUpGZMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: lvkZyY-H622FO9U-BL5UV9dgvrFTyi_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyOCBTYWx0ZWRfXy4UH4XAZeuJ+
 1mN8r2sv/KRTiSqy4iZW2C+vKsu3NVcx+NJ55obBFaXlWM6UKTVbR81FaIFisN9ymwxdC4JvXDV
 QS+SqRqGaI3jqcX/s6dr/U9vwi9SdJaGmMGYfD4cEf8ez9NuUFJYwsHkOLPxRdKpD8bt69eBMKf
 1/iqpQybGfX7h7dsF5soV35+eB22Izqe2CxxNWFsN9JAhUGI6+hO3iY08y+YPQSVB++XxcHCaXJ
 iVAzOnXQY/lXd5UrvoCJ4oAlk+5Yw5sbBpFqSLLAqx6QFp5s3PPz8x1ouIer/mKshEezGl6F+o/
 xlZ92hduvbbvUuNRiGAP5sHrnUxeOWG1uVI+yOmdp2Cuo0dJeVky2J2gHjVNz6izsXmmKSsY1Ov
 L1wh+q5Hw0rOeKMe9HaXk3fKZoot/wr+anblewZ/0KE1gZqa5hY4oQIcIwqID8zTTFpoD0XK/ru
 1m68Bh1nDauKaxo5uSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyOCBTYWx0ZWRfXzGSRzSa3pXp0
 eKvhPcIZ/znNgQK58suMl5ADK+aNemRdZ5LhzUrmuJ13SJAK6AN5aCorLvoppY7S8pffYwfTbpB
 zNi5UxO5eEcZA/0EDQkPDh+zs54y0ZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230028


On Tue, 22 Sep 2026 10:52:28 +0200, Bartosz Golaszewski wrote:
> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
> return immediately before zeroing the info struct we'll end up passing
> to the user-space later in lineinfo_get_v1(). This may leak the kernel
> stack contents. Make gpio_desc_to_lineinfo() return int so that the
> -ENODEV returned on failure to acquire the guard can be propagated to
> the callers.
> 
> [...]

Applied, thanks!

[1/1] gpio: cdev: fix kernel stack leak to user-space in error path
      https://git.kernel.org/brgl/c/1feb5d39b05afd902ed9fc902ec5b15be03a4bdb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
