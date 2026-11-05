Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885878;
	b=clOCmxIHzI5y5/VHzE80kX6IPPjE8Ztjrd+xqX9J6niiT4ESV7LLh0fKArtpEWqh+OGE
	 +nkxv6XscFAUoJ4Jpfy3Sc00wgI09rJzfuS1sGU5IiVNFBsV0Oj2f4rTDdJPHxcOHkDX5
	 hEw/lvijaNH7DesQA6X961tW5DJhwVs/Lco+oKJpNYUHIkTrPQd9Rb/SczNshDuICZJQN
	 vR+tRHx8YO+FWx/LGUdPCwUECiouFvyrxYAOkQxMnGtaPqhDFazRzk9kSsCcvme4UWWsj
	 ACeVl6P9sKcE4AFw/3q3d4cZgP1bMdZcCx8YTcIWBRRZISazZyjlcJrhNbGiw9cUEiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nBYAXaQCU5l+uQzIVTFnmiRDO5n3/EOCy+3rVyXrJ2A=;
	b=yD0gIvHQ0/mnhyvyCvRdHzCgosQ3FUm8LiC9LkHDfQ+MqYf2U0r8EZw6+rtC6WRHYgEE
	 sqwHFg+uaVEvQ4lnqPp/w8h3fqpcbGiWNpzd6g2y6v5aPS64UgDUA+y+j8GzRrSndsVJ1
	 MEy4/iGC8YohAexuICu3npqB6qFx9wZVV8nNzT087BunMBK27v0DoVF48qndcgnB5/k4e
	 xZeW7uFOXm7OpD2cXIrLmQFNN9PtUF5ZOASzFabhu0ASSBUw8iszORdGCZKPEHaozLY8S
	 sU8QGWnb0TkW57nsiA9+9WJ2htU2F7cXV5A/exBuIkj6UTgtKK29hCmzPNCERgyTaZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OfzZAkKU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYoAsOxD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7D606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA7D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OfzZAkKU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYoAsOxD
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tHIT444523
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 13:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nBYAXaQCU5l+uQzIVTFnmi
	RDO5n3/EOCy+3rVyXrJ2A=; b=OfzZAkKUfD1eEmEaFTGr5lSyftY4+Uy9As+tC7
	zpawJRl1vVRjm/7pLMV1QW7s2FMN7T1miiqme/4eUS2GyLft4V70JzizNVyZHpAW
	a2tgcKkPkbGi4Kt0tPDgje3wiw4V6u/elpP0SzArFlAw3jk07UScv9bxNO24uE7Q
	ETDyKKaPusLXkFD2gIg3d7z+d1Gl+az6iXwBpyY7z26iM9KR8gCPg/tw2I3SvaFz
	+TqjAK4w61O3ng4CRES9ROUVHMKW2iJFRVkPjgkFYUHVsfPKs9/ZBfLl0uua7zVK
	F+mKKXVQ+NchuSPaMDrFNGz3A3Btf8tgaKiJAB8Z0ZaD1+kA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaah8u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:37:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5338974c0ceso50420601cf.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885877; x=1794490677; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nBYAXaQCU5l+uQzIVTFnmiRDO5n3/EOCy+3rVyXrJ2A=;
        b=gYoAsOxDBDE12LWwC0HZqMWH+Inp59lXJv/plXN1oAsal3XAmLfSyca5vQfWE9J1sS
         kk/i8SYNj7ClXyiJ4J4tJYoQv//L2th8UsWdOO8j7uZPF8G2f7eRjttPCsHBQJ79Ce+w
         ynq05v+XHxb1ydPsxbH370aB7TNbjhQ+srK5qPMBcH0GoUdhMpkJMEyiczZVm4M7z6ct
         F7GqsUN6Cn7zrtzbga+tsZuoxtsSkjZVoq6+2jxikVYyN8Y7+73gNH9UeL8fiMqCCdtl
         ZiGI6KusK9HWb4sTtGi0ytCWbMOf0BWWBO93rFcWJZRT9u7vcHLt9/74L1/7s3wzG8yc
         KWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885877; x=1794490677;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nBYAXaQCU5l+uQzIVTFnmiRDO5n3/EOCy+3rVyXrJ2A=;
        b=DlHzN/WLkhMfMaahFdjDylo+ble11b1ZY9NyBFNmw9TE/jq/SQQOTxXMUnJ6TkGltS
         Nnf1C4W8UfoBAjCg94w54e+nUIi6gVHfadoyXj8smqozPqfpOcuCsFUfDuPVAnLirNHq
         SGLEFlXmEBKXqcuvQ0F/qDMaPPFTeB4H0CnSkc77noUCxHZ1VwZO+NruoVgDYLqr0JXQ
         8v8Z/ZOAgP9lvX5VtK7p/RTrMvzpMGIoLSmR64PjGDi9cyZcuon7e8M857403k5VBZ0L
         85pWTjF3OXK8p2Ng9VoKvvXoC4So5GFAbPe9npxrK3IbqgCvnH6K84Q5fDnMM0EJ3dad
         k0eQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOuWTRscbDuwLBNIrnyAPwBXU4J6JFAOgzoTUFfKKPRYYyQY4Y2yDzij/dNdKq6IITCWNW9t8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RvULy4TmNC4uVz4vGx/O2hCRZBebaL8lacddYn2SMU1y2LObh
	I0qCNefjEHOu1F6Cm+XD0aqsT05O/NgZkz2YMpWPYjGUfRQx+ixW3L3tZGiiJwVD4srMYmLjnXB
	eWXPHhKWzrl2J7tu2lC19ZWaUVxZmn/DoHQEoXgcNtpGX05wbj2f1M0UL0YU=
X-Gm-Gg: AYBFou1p+5e4y474i1U5uzW0f8s38gvfIPEuTvNYZYClxT+fKkao0P1UHAIpEBduhrj
	F+6cSKrM0PVk+7MQFzTVtM9W7Um9t5X478Eij5XFvvmgZtwFrc5GCXb6D5Bzeo+XXHhLOlITQc2
	iSJjcUhQltJBfTyDv3b86cOOEUiUYbXOxF9TOxVSatHJB8UVY6AJmKSkwq8pl+FYdwL1+2t9KB9
	3E1vgLsD8kV0FGd/RrqKex0KZavBkj8lnYEdZgGD0I1KvtOTMacoKItKDARDGvDJGwxcrNYGGJ+
	A8T75/gh7Xm8Fi81hC292CncHWFABhEV5cYiod5bxFV3w6lWVBugTL1X2ZIGAbbM0J32WYTKhd1
	EicsmvaFy2K1I1tVL7nbPeyfkLdOOQJB7Z9lPvCKtbVcQsvHpDBzVCygloR73RmyLHDJPY45/4x
	Il/A==
X-Received: by 2002:a05:620a:444f:b0:93f:2158:9c4a with SMTP id af79cd13be357-94421711b08mr2944063785a.15.1793885876622;
        Thu, 05 Nov 2026 05:37:56 -0800 (PST)
X-Received: by 2002:a05:620a:444f:b0:93f:2158:9c4a with SMTP id af79cd13be357-94421711b08mr2944060185a.15.1793885876196;
        Thu, 05 Nov 2026 05:37:56 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38c26eesm846167e87.55.2026.11.05.05.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:37:55 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 14:37:52 +0100
Subject: [PATCH] gpio: of: fix potential misconfiguration of hogged lines
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-gpiolib-of-hog-uninitialized-v1-1-fcaeaccefab6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK+G7GoC/x3MQQqDMBAF0KvIrDuQES20VykuopnED5JIYkUU7
 97Q5du8i4pmaKF3c1HWHQUpVsijoWm2MSjDVVNr2qeI6TmsSAtGTp7nFPgbEbHBLjjVsZH+5W0
 npnOearFm9Tj+/We47x9yeiNnbgAAAA==
X-Change-ID: 20261105-gpiolib-of-hog-uninitialized-0159fa4104df
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bt5WAnktT/7z4dpWnfgI0LPlqoaHeMaSqU7OOV98urE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7IayGr6XLD2TmtYggAWFsuPVUX5xi9oBIRZoU
 m/TWN1Ci1SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyGsgAKCRAFnS7L/zaE
 wz8vD/9roQsE0oxTdin62mb4TKCj27aEGH4Zu66ck3gRawTNqF1d54P18f4PaM2hBp2mKKBQV2q
 W2nUcO3jXdtOhp8o5EACR9OoF3ajTJ8czJbRCcjg9v5uAN69hjn8a8PQL9+x/xMc6Mx3/FfeuuV
 G/eJQK4uCJgeZcQ8ef+XZ3of9ExJQQm3TsflmaYzuJg4p6U7hO4v7vds4RPdlPvWza1igVa/bha
 lmViSg9DpHxPP61M3nrwMDjMfSHJuyitu/TkL1cV4R1ADYkqPAeKwOKIzlClm9vqTs+E10XK83T
 oq/2Nd3HW4dltcJzDkDmSFMOTUOev5hnZL6o1eUujy2fy094H5lJqdE1WdnraVG2OkSfJEEuwyR
 Ad0oZPlogbWClqtKyTVMNRaupLKUcgF+KAG0M34zcGu+HK+cQ3LyWRNmAF94c31D1I3UFiFi2WZ
 TBt7HNFjwaPOUSY0bgD1pbPy9kvwUPUaDEGlJzDfNEBk4j3UzoW3DZvTzR8ywgxmtcx3PIBRFpR
 eUv6wQkAWt2RH4TKn58F5Qx/13CAyGXvcGg0MzN89L6PkdMh3rwI4l4b+dmu/FixlPqRrgYbmgb
 um+IdvCqe9mdUD8md5PBsDTbeJ5OmAMKcyjPpI/GNH1Yuvw0YNqs/nbXKstz7utcutB8mSs1e9s
 7aTgD55njnEOdGQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX+et7mpIC+AD3
 GXJ2qeVez9q4Hn3NnUUOB4pQ3jdHtH2dtWrdxyPDcT+cIv4rhMnS/2kQA/fKijTAn6bapCSyYC2
 /4UTdTkuoossQ54wNIpQZLxfLSX9gLMLaXuvZXZXSKSiz2tPtHgrkcV7oY9b/qxDaNVQDsIOg62
 7gB8ciXBFIixdptnW3K8V2tPdMFTt7qcCs00SxttnJjaE47i5ds794om34x0pKxv44P8Sou6mml
 WIv9RbX7WLFpLTBT1Fh5wRNprKELxAaHuqXF5l3E1ttyF998+PH0ztm5lMqQrUd5ek0tgv4qfOP
 HCzZwK+Si5y5Iv6vgQmUawxggljBTWUkOpmv+zm5DjF9LLB2pctOFtidcwggINVtgvUzkARI27y
 BmLUmAfUjfzqnqHYS89rwIg7J44TaiE9SbYKgJ1szWAPZSeZxO4DFYL6hwW/jTthWvIbSUMcp6z
 7FEsmX4KYE+0Zk8edxQ==
X-Proofpoint-GUID: 2d3-xwr8yOlWHB8NqzZiei1_ZrD2Rbr9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX6R13qAbkDmCU
 uhfIpfxRKKCxQgM2YFKj9fQn2blxlAjsNzqp3f8UPhVFiPCKiqq+siUXsJvyOBNumL9tkYeLzCO
 JljXqk0xmyPlUP9uBUafNTMeYeYkfY8=
X-Proofpoint-ORIG-GUID: 2d3-xwr8yOlWHB8NqzZiei1_ZrD2Rbr9
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec86b5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pdO2fDfkyHolN64SMbIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050054

In of_gpiochip_get_lflags() the local variable xlate_flags is declared
without being initialized before its address is passed to
of_xlate_and_get_gpiod_flags() when processing a devicetree gpio-hog
child node. If a driver uses an of_xlate() callback that doesn't update
the flags argument (like gpiochip_fwd_delay_of_xlate()) we'll end up
passing that uninitialized value to of_convert_gpio_flags(), potentially
misconfiguring the hogged GPIO.

Initialize xlate_flags to 0.

Cc: stable@vger.kernel.org
Fixes: d1d564ec4992 ("gpio: move hogs into GPIO core")
Closes: https://sashiko.dev/#/bug/linux-2bb44847-fd6e-406c-878d-9739da2cb8b5
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 25b97109f97ea88c83c744e496e24263ee71b8bb..8bc4562608e1141983300132b90758ce68d7625d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -753,7 +753,7 @@ int of_gpiochip_get_lflags(struct gpio_chip *chip,
 			   struct fwnode_reference_args *gpiospec,
 			   unsigned long *lflags)
 {
-	enum of_gpio_flags xlate_flags;
+	enum of_gpio_flags xlate_flags = 0;
 	struct of_phandle_args args;
 	struct gpio_desc *desc;
 

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-gpiolib-of-hog-uninitialized-0159fa4104df

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

