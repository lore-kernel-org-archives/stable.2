Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220036;
	b=V6847aOzw7Jixv2166nZwe63C+JQPHgNUhbec88ULO17dZ85z/zOXNoRN10Pyap19uGU
	 SAWCD2WuVVpHdCla0c1xISernD186XpuVflxIfPakvI4pS5y81PBTiGR9jJ9E2I6uf2Q9
	 yk4Bpftqzcb9lDHhzz1DYBMbeQBo64nLcWsP3Fi5CSLbvDAZRSkYjPx730rYExeNGE8CW
	 Dfo2Ob6TZqDbT09ANsp0mFTWGRfv/HNmx9u4n0HS4qD7TDkQN8BSc8KdYDL3yyrt/25fP
	 RkGBlikzzs9TnR3Xd++gGB13yIZnNEUghlhegJtHp8KS/HsW6Sh9ZUeeWiPscoktBDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=;
	b=yILsOzMvqQa8Gms3ver99yMu4kzNiWHaanim8YPi0/m3xJGXwyFJHBX9AFuMS0yIKwUr
	 TBUo7FKVPiBZ9hCsb0wzvqKGGIsRPJmETrOeFI1roi5f9YD8M6Bmj07bVTRusE+qcZEdq
	 wvZcdxQEbhzfghLwJQ3RpoyFoYQKVYqv2DHBJWkccjnDuBPipVgOuzgVk8b0aD8Vn/09A
	 6naxSMTI39wPCxabboLlOWg6J2j+zeRu4gfUhIEEYP38OsIjrIyKPvlLn+HR7ASFgMlQF
	 ciq/QMOAfOlJQ6LMlij6ylvz5xtTpdLPmdJLzJyMRyjENckRGPauvMMxPknz6qa8TNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ddJ+Jhib;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hh0jLnjp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049B606D815
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0049B606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ddJ+Jhib;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hh0jLnjp
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A99ukPJ4130899
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=; b=ddJ+JhibEptYfH2w
	tO93LiAUU9lC6xorTfIoNE0OzlX+4RiYzUwYeEpI3dyhx+wmt36jwV8RBo6Yu+QC
	cQPCvR0rg/MC7hYjHZ46gVG+SgByMUKO/9wYPx/hiZ5rDQNG1FZ+Hm853utRdq98
	r9MPSP/c0CvUSFoN2qxv6PuhcilxumIWq0V4OtxXV5IEdPMl7DsYP/Mo8oHXA6lJ
	LR7QeoEqxQFHZrBk94XvvZn8oLH7DIS5/ROUS6oLOcZYO0pYdbPVzsuiV+CrISWx
	4JQ/QjL8cFPPzkJCMESY2IncrDMUpdUqH3ySm15cf0C2UQgbwNNVlHDlEFDrxE2d
	C8NSZQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2h85k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:27:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so138634885a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794220033; x=1794824833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=;
        b=Hh0jLnjpx9ou7olmCscQpn6ssfkhxC2ZK64KTcF/Md5BZEVEZ2/MHTKEB/wTfcM/VI
         5RCuHSo5rNPiQIH3Ji0BrIwt1/R7YqSm3VWnb22IVofYVvZk8efXltjIIeb7DeeJZUCT
         JgGQi+flOZArQR4F7/NxEFIFQMmUZ8+QDq+3ScHgXyRqz6wiblhv18/577Obhczvig5B
         VyuTHk097HDTBBcX4KJdvFeeunGNvSj4qqO8v6norqvCJr6mkuE5gywsuo3bEYhl3woF
         91zg+t6M95FkY93GX8ydjcxKHlf2NcVtWbWPhDJK6F1pv+zio7TxdU8qeiKlFhG5kIdJ
         9LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220033; x=1794824833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VkGul/A8qLYHFVGluV9qcJV3TfbgVqP3JtUTvoLxT0=;
        b=rKZKoEGIWTk4GyfxGXZVAG/rlyFW5VOxaoY8L2CNTd5YZlG67/MudGA7e94Gn2pGQ7
         u4fH3Naj2byHxMem0KHWh7vFkqLrfjcVQ/ezcrAtxB3tCK6g9VFzRUYSbxE8CbwX/ubb
         YAHND5GfbJRy5PH1ZyQyHotObT0tpk4zWZBgm/zEmPIVT48TlIV2RwJiayMFeyvaxvxW
         o1pet5ZPbaLLCYW5UNhx8vIujaAmnA9P7a+AQDNL8a2ccJqpVm9DzQ2W6KGBt8962i6P
         R1L6m+0v185NM770Uc+ZGmPhVCCtrqJnCfZOp7ajXIdblE87N9B/qR0qorXNcFQnCL8m
         GS6Q==
X-Forwarded-Encrypted: i=1; AL+hErHKGjtF5IliVepjHzfgYIcsuBFgoKhffDEPrQFz/aeJgkGZvyBb3oT1gloyl0vJ3zWdD6mbWR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V1jCTHW1mKKGSWXbFpQhn++LLE7To+7pqaY3DKSDR8suHNj8G
	l9a5r0puVBg6Wxobm9lbCk+ISa42UgMuxqCvsgMCRvvnwRFtKtAkDZ0nqaiAj2I8+SJoqyMliXT
	3H/r4Ua6+I4COFxR7LF+BKU+EQOSirqSAJZhK7cHC/wZLUgll/nI7JiwMB9g=
X-Gm-Gg: AYBFou2lbgeJsOL6rSTyZWj4HAfiW8l+I755lO4hL7DmBPFSP/r1Y4/i21ONOcjcoNs
	aZ6qzcKRSq6d15Yb6Wx8reVF1Nz16C7fKziknU7OwO5CAZrJO/iSXiyFZhIDKB2MM1JMrbGVUDo
	37zXjcpL8vxzAPovfIf4tyF8cNXKdB7i3IWdN6ZwEL7Ym1spTF6fBonm2/rKw9AFyJqbTUXVwMy
	FDtwMf35PcymrmIX51ECCCfAgWjQsZdJMXpEyIYfVU4qK/CRN9l4L5qDBmwP9bkzsDK8oAveR/V
	0pjhNJ/l8tSRsT6vxu9aIrPLv9MxDS0vBqNM3PRBYxIxQoahSrWCAZjFMiKT4Ct0/FD2xnCnBGe
	aejnWCu/og5GoINZNAYr7SXBg8I3Y399l3oHwQJhskuEsJ1+XstZ0xudcTvSpOOPbis44H92QKJ
	0uNpZre1P1pWbBg/m01nVwq31Pe74y/z1K0veH6xqr2qoYKlA66iSIHUcNzTaL7yc=
X-Received: by 2002:a05:620a:2a08:b0:93f:565f:e40 with SMTP id af79cd13be357-9478476e63dmr532069885a.65.1794220033348;
        Mon, 09 Nov 2026 02:27:13 -0800 (PST)
X-Received: by 2002:a05:620a:2a08:b0:93f:565f:e40 with SMTP id af79cd13be357-9478476e63dmr532066885a.65.1794220032851;
        Mon, 09 Nov 2026 02:27:12 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm237381545e9.5.2026.11.09.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:27:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 11:27:06 +0100
Subject: [PATCH v2 2/5] gpio: shared: use atomic set_bit() for descriptor
 flags
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
Message-Id: <20261109-gpio-desc-flags-atomic-v2-2-c4c54b476628@oss.qualcomm.com>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
In-Reply-To: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sMmWnya14YIAq0vwSErMArXF2T6bT5ovzCJ95r5ENFU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8Z/79EFmR9l5XZlP3sbhJA42a4N7m/4Mg2WYT
 uXgHckUkUqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavGf+wAKCRAFnS7L/zaE
 wxfQEACg7P01dxIa3BoYJBiBN2CoMxns5UKycoYlNaX3cIvU1a6MvDTs/mafnFvHGm5XLdfsCjY
 o/uuqyaC3WeXDgjV7mxCH0wJfm6TyiK45GPjdXp3pi96WyIPlqEKb/Z8Ivmtrfmwlc3HsHub43p
 lND6r7vQkWV1yrZj1xD8aU65RTWB9utcTm5aTXFl3lw1mM9gQL7EX2a2YEtZWu6lCv96Zp0sGum
 ANqHWNiAtMIFi5b/QQUKNSke1WMlzmU81vswqUSRiG1pm0Vw19x0eoqCIEE07VWXl9LHzuZZFqr
 pWArCoK1ws9As+SLEFOGimmGYL8x5Oz9kyop8aGKTHqh7DkqZawzeesH77lxsxHr9oc8zV1XIVP
 iqJs6pHDBS+DjLQ0AVkpPPbALxMPdZvKf4dW9WQtBz3IpOKVgDc/R7RgSWa7E3UJ2umSabbgugW
 gLfO4vOj4tfr38M27DnIUaTCdpd2UEHlKZJmM3AseqDBOLFcm1CagxGkvF6b6iEI2s9axJ0GQcR
 sTYJYqU+y3HPqgbPdMvEPqMMQblcPxjCLrzCgFdYlhg4AEhDC7En3gy59aETUwoxDvXldfzPHEO
 8f48pgNYWSRi+nHf2Glncp4Up4UlbFsyzGFoKaAiCBr7tH11as8b2r7SZbr6bekSCblQqanmi4i
 K/JiI0P201tFvZw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1a001 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=H6RLajfuJ0QrpAsTGAkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfXza4l06chQxfv
 xgSIEFxx2h1ZB1AODOZ/PtT65P5hR6H3KWjnTMTlZ1N+38t40JhkUj4+6V/6Ja/zhoLzw1DRIQZ
 7NqlxjYjBNtbofQ66nC5b8ObY9b1P1rmCJL8dfspssJecxOiIfp8MOidWO3U++eSbkuxaefMPb8
 hlweYKfDAeW+zXCMrmtox1p5BwBodLfhHu77UgMXqJQh1TFOBqdGRMOiYdRcpmgERuqpVJw5Gwl
 jVBN8/okHBMsObCJAtD0+MV9rdywogJDxSZ+67B7t6S3nCtQ1SIMuYDKNE3WrSvIAJDGKQDxeU1
 QG25fQRP5PElHTJ7bMPfXZCUmwO///MYf6DVnDpLgILgQh9nr4vQ8AKmY4D5dVBkDxDCagdsALs
 tC6L6qGRqkijBZncBvv8BwGjgnAEYsMpPQrqE08cxJRbfL3G7sCckflEmwlhYnC+IP3IuCY3arE
 QPFYVyouKIQnGu+WNmQ==
X-Proofpoint-GUID: hrSYmjXAo0Dhn7j9eOAvOW5yfSVtfLjY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MSBTYWx0ZWRfXzLofkHFEn0BS
 1UGlAYVvCtssLsRuzHT+CXlOfLHjh0ZXaJQ8UCP2whUnoyj5H2CmhjLrgk00M4tb5cHUuIw1Gwb
 moYb8/KXZmf8BYdMPH+fhaePaRyrLdw=
X-Proofpoint-ORIG-GUID: hrSYmjXAo0Dhn7j9eOAvOW5yfSVtfLjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090041

Use the atomic set_bit() instead of __set_bit() on desc->flags so that
every modification of the field uses atomic bitops. No functional change
as these run before any line of the chip can be requested.

Cc: stable@vger.kernel.org
Fixes: eb374f764a70 ("gpio: provide gpiod_is_shared()")
Fixes: 310a4a9cbb17 ("gpio: shared: shorten the critical section in gpiochip_setup_shared()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 8c9ac9d9330490b17fb3936b8758beb97a308a15..d94fb94f31c2f487d2e45924e11c33570466a0f1 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -532,8 +532,8 @@ int gpiochip_setup_shared(struct gpio_chip *gc)
 				 * This is a shared GPIO proxy. Mark its
 				 * descriptor as such and return here.
 				 */
-				__set_bit(GPIOD_FLAG_SHARED_PROXY,
-					  &gdev->descs[0].flags);
+				set_bit(GPIOD_FLAG_SHARED_PROXY,
+					&gdev->descs[0].flags);
 				return 0;
 			}
 		}
@@ -573,7 +573,7 @@ int gpiochip_setup_shared(struct gpio_chip *gc)
 
 			desc = &gdev->descs[entry->offset];
 
-			__set_bit(GPIOD_FLAG_SHARED, &desc->flags);
+			set_bit(GPIOD_FLAG_SHARED, &desc->flags);
 			/*
 			 * Shared GPIOs are not requested via the normal path. Make
 			 * them inaccessible to anyone even before we register the

-- 
2.47.3

