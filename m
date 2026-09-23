Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E645C710
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151242; cv=none; b=VX75cAZD7PMEf/8GkFJNuztff41D8LxF5EuevI2VQ7ncb23sgVltF5RNHtbNtZGH3jcZ/JdV5fhTHXBWtEgO7aHaN6vW8KHa160tHKC8Sig2IswoGPC1qywIZkVeOt7kWwS/gcyf76tGxa08y/qbfTs8UuBAsbyQ6woGjpLLbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151242; c=relaxed/simple;
	bh=UC0vpk3r8udDGy5C5mG2ypH3ZjwnNmEG55Zvc9D1qJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKPI6N9NFb5dIaLgmKBsSIO/0GCY3MUNGfnT1OJzVReOtBYT3z8E1N6N+3LrNk4h5Levpkct94m06UAnlwRVGvp9AGIFqTMsQc26GgS4s2joUrnifz6GdSDAj9bMTOwXay1R+9FEnfxj5Eov7bA2x5JA4+HRmA1uGh0YxqZKgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pc5nEqxj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ae4TjLa8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pc5nEqxj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ae4TjLa8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N79Rg92819115
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nIV5BrLbaelpGrDb/+/9Cd2ytJ3jtLQA2lmfnleQxbk=; b=Pc5nEqxjyffDYNoL
	tCcYpKJMosbu75RawY+Dy8ZYulqkAZflg/y6Oy7BWAHRGabEX3UExzWlyyrDKS2v
	+U0kLdTnitIgjKeznvUsuP45A7vKa+gXh21xgveKaswqj0dkQFHDKYQxcxCJ+AOO
	jRmgaF7CV9A/K5FmndAcZGU0gsocGLj5XdsnogVlLSN3XQXa7c24JaL1osIvNdiW
	MEwyDIhbhRJe2uZcNmOYVgcwA+X/26gesM5C9X6yPwywAm1cbXYvaLsQRbSgTIxx
	AesRnxzogbCvjmiVjbD7AdKR1ICPfjTBJGSkBbE5LoZ0ilWlP7IFM7PL92/0Gx5r
	db0C1w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n0wts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:13:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a1b824e84so164737385a.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790151239; x=1790756039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIV5BrLbaelpGrDb/+/9Cd2ytJ3jtLQA2lmfnleQxbk=;
        b=Ae4TjLa8EWwIWUEO5Lu9Wu+kHYqcwUHMKrBGYxqnEvUuYolI0wDxVPpRBHxr0y6c/U
         eDKv6QGi2T57j9ihFDPt0YBvjnO/eiPyrFvPQntOOETUqvocdSukjbzF3CvK4+Cxy6FZ
         2G/0nN73n9C+XR4rlsnUqqzeyBAqEcNTmjXy8bGi8YkQISyMFWGC1cN7zA5o09uXvNkD
         y5rhNlh6tUL7SsWBEKmy8VLVqQSW6Z1HCTfoS/NTGLf/Q2PbGACNc4f/Cp6tVI6E0Ln/
         CKRxn/OyoY6jwGnocIA/zoVjjmV4MGMfKuxDDo8rcLEiUfioZUhinHUkeZefdxzClRhi
         K6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151239; x=1790756039;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIV5BrLbaelpGrDb/+/9Cd2ytJ3jtLQA2lmfnleQxbk=;
        b=TaK3Qu8V8y54GqtBUy9HhB3Q6O8iov9+WhnN6XchqOV0TS2XXyA0kDa9Zzj2T3O3lK
         mModgXMHS/MLhclMX9qmthRQrNCQTlTWS10k+lhw0JcvVCynp33TSDmMeX8hZYptPh2q
         b1my8J5l+PmSIXkBIM1mi88DcYORGm0HMDbLQwd+eKF7ukC+03u4Znbk2vAHOuzeYveu
         Irk8jEF+bYuvwt87LU/J5S40hoWJXZ7dFobGeQbnq118OVSNPUrzypeTWmT5IBBSM0i8
         jG2l0Fp/L2z5pWhH+ZZjP0m4YhNftXtBr97X0gnXdvfC6rZcsgVwZxDfkv+7U24l1iTM
         znQg==
X-Forwarded-Encrypted: i=1; AKwUvBzIInL/ogDtbTVFtwZlN6qkI7k3MniXFk65FAjG31RoaZAfaLhMaDvO5Q0LVrYhl9tFpFsxwBE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgCnIGTS07chNZ51QdWVJ5YwxpvYND9F/LodGhkAz76ogih8jW
	8Y3PMPGavsy9f4gbzrpLdojwsL+HDsxfoVj8lLiN9Wa1mlHn0UY0O7WPm+zEnBXy1/BwL6NhGnK
	aun6w6Q3rGUKCnJdJHewwKIaeJ/dlE2nwTA6Rktq+909rooBnQK9a/RF4yqs=
X-Gm-Gg: AYBFou1MULlaO5Ed90JU4oTV9vy/ulv96OV8/kVJWaGYzZ310RqHtihaK/1DNqDjYWB
	SMXchMBoLSioSkOXAk6Ts3ig/AMQUhXZoEszJVnlkUY+0m5JtP/4ChiyZuxQR1yJMcn+pEYffTd
	GFgv7KJOjQAAOLbehif/Az/ORqPcDSC+Q3zsDVH+2xuWiP2oyHEDQxkizCJthgR/tjTHSFAD09T
	mXRC6w1V3bwIQKGEGtNHj4m/TuTx0HOO/4jKDPQWys+0fbYP7gaHJzeKnYE/R88lmTjz0Y8dPD4
	/9l393ejkTMM0m6qNADsRAkNIo4Pj39f7ADj8TF6EbSiuqKLu4MdsUYtjO6s17WIuS9O2BtTnoz
	vFtaxL/iT5JhpfwYAMzFAyYS3/KU=
X-Received: by 2002:a05:620a:701b:b0:93a:83d:1d0e with SMTP id af79cd13be357-93c251fc9cbmr279979885a.38.1790151238611;
        Wed, 23 Sep 2026 01:13:58 -0700 (PDT)
X-Received: by 2002:a05:620a:701b:b0:93a:83d:1d0e with SMTP id af79cd13be357-93c251fc9cbmr279977485a.38.1790151238276;
        Wed, 23 Sep 2026 01:13:58 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:34c6:dbd6:5b58:a3fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf9691e2sm50454405e9.1.2026.09.23.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:13:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ridham Khurana <khurana.ridham222@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>,
        Brigham Campbell <me@brighamcampbell.com>,
        linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: zynq: fix runtime PM leak on request error path
Date: Wed, 23 Sep 2026 10:13:54 +0200
Message-ID: <179015123239.7939.12868400217735279583.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922092102.1053513-1-khurana.ridham222@gmail.com>
References: <20260922092102.1053513-1-khurana.ridham222@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMiBTYWx0ZWRfX6e9LVtO9uNXC
 1SJj6043lpWq3ZUm20F7R8k1a694YPw1P1ZddQwj9W7+7yMboNoHi5SYn5GuqxuPtJ6XjZTEoLO
 piP2he1VDdGHyXNixyDIIVtzlNM1s1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMiBTYWx0ZWRfX0lzDKUIjahvf
 kAk3E9LETAPb+jNDmRCnk7sVIs/tASIIBpAuAVL5DvtyVZE+stIQ/r2YkpH1Ryw3sDp2Nxe4vwY
 j8JwFRrFtzfln/G2aPOiNKgqiVYRahKF5t7I4Q1XssytEPNlApow3Bijg469qTp1ALDmoEDWsw0
 FyDFJ3FMoaSZglnXMssWbTs5atAHMRTi3vd25buBZrQRhZjTTgBJ1N51qeqa5PsAEXjt1im/YE1
 Oa5I+tiXbSs/fj6kiVr3APvtl2me2/0lODGXglqpfaV8dMw0D/S/zFx35k8zuRZVzfimfoBaZr2
 V/TJ6ZemE+Q0uWu1PjgqgrxgMgXQq/WzZaL6d+2R+OhR0eRkghsnA3OD6c/avfqeNJGgbzTezbH
 caqffn85cQ7aWuzXoQJxKHe8ELuNtGmHx3nz9bVLhB/DbjXL4oQWvgtgJX9Cu6+tXEplAoyaJCW
 1hA4giv4GAl1rOcQr/Q==
X-Proofpoint-ORIG-GUID: UcaETOrdvBESZI8z1kP19PFa0yMi2CRP
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab38a47 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZA4Iygp0GN2kJPZu5X8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: UcaETOrdvBESZI8z1kP19PFa0yMi2CRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230032


On Tue, 22 Sep 2026 09:20:58 +0000, Ridham Khurana wrote:
> pm_runtime_get_sync() leaves the usage counter incremented even when it
> fails, and zynq_gpio_request() returns the error without dropping it.
> 
> gpiolib does not call ->free() when ->request() fails, so zynq_gpio_free(),
> which holds the only matching pm_runtime_put(), never runs. The reference
> is leaked and the controller can no longer runtime-suspend, so its clock
> stays enabled.
> 
> [...]

Applied, thanks!

[1/1] gpio: zynq: fix runtime PM leak on request error path
      https://git.kernel.org/brgl/c/e9438ab5328a177c9c0e5df87eb92a7162841e98

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
