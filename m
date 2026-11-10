Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318431;
	b=jyd0/P+TpzfG5Aa353pLV2M0lWAwpHHvnlcRLYo6yUS0COrgj5s18mDxpDa2fL9eleu5
	 9sIN3Wx7AzHj0RXvE26FFOoKwBmhRySDdvhVSr3ZX1QVKWitekBu7oXd3DlJx6yWhbuvN
	 k1gRX7x0JYUXWPyuWQ+xzzT5VCqD+kzv1wy7joJBm7Pw29hNDU4K9lsO3fi5XafMDHLhc
	 95VqQkQ5frNF6ErxFIX/jpmE7IEezQtIH5IVYVry5ZYge7D1+1x7mBdWPTG/4Ix4XZSU4
	 AlnijWSTCIf4viCPP+SSZ4iFIV1b5doHG/tEdtfOYecqwivOek8lAz2zxrK9Xc09tOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318431;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LDxrpSTjR1x207YXRGbENckCJGicT1QoyDbfvYZYoM4=;
	b=AWmXLQrbm672EOTYomgMf5qkGLsIpNYNY4rVVnbS1Bw19vsEa89BEF+0onlf+BqJy64V
	 gcJJGa8XPaGFCocUojIeIN1wQcGKi3vk/oYUoVQ8qNNYHQOOSTUVcNd0tbATTzm0mXdA9
	 PNSalhbkYph/RACBYGZXupfL4SWplQx8S5a1ewWYet8Z3bNLqgX26vM9Jotn70wFKtRDe
	 HkzlhKfvOjLSNMjQv8eiHnM2NU4nZl6q/sYFZRt1gl2YFqonw9k6b2WZuJlK9P7El7/Fm
	 9Ze9U987sS/ZU3HwgAi53AnbBmpT4nXtXG03hTkJ1hZtEeh/HYwGPDBnsOdBNCMVkBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kw5g+aab;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fosvUbeC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C4606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9C4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kw5g+aab;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fosvUbeC
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABANN41599659
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDxrpSTjR1x207YXRGbENckCJGicT1QoyDbfvYZYoM4=; b=kw5g+aabvJBAkXhH
	TWtO6NzzojVwT4KzPfrRCdfOuh+vSOtOoj5fBcsYMyoqDmwcwYv9uy9yH6Oqq2Cg
	dpUXTxUrIZOuccCh5Y560MtFpjbv03XRxlI0k7cYKNsemEYN9qfN3JMqHB9ukCaf
	USDTuX70PmhS47ohtWw7RtuiYg8EnRo+6888rEkRkEFTn5YUyToIh9UDjecf5h9d
	J7cZt7fSy0GbE/jb7VxIuP7C6h2TREv9DiBsR6t0p71m/zF1yYHdoxwTyFVFGMbf
	jyMp2K0LHTTYPEyhMoowDgd/3Nk4GKVoBw9k7e4LrLogTYK6szR+naqcJ/ULDOuf
	NpyhlA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv4aa6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:09 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-999ef3a68adso340304241.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794318429; x=1794923229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDxrpSTjR1x207YXRGbENckCJGicT1QoyDbfvYZYoM4=;
        b=fosvUbeCFR0ScxBEKjM0KXSRVFrAcNodvJBtCSyB48I09FtDEZbNic3ebyqJyxOvbi
         YMkBZ1x3pdAThKKnllj6J4Nq48IDlsoydaECPYYEaA6Yi/8I8CZP7wu7G+qEZ2Mt5hI0
         TgTkEAAcZ7PjxR+cTwcHZT8dVEsTW83K3rn5zEBQpdscmFvCVzWVrNRvMX4YSH2T5eGh
         ZD10K17NuzIYKYEnMB1t1T5GPKKArWdCrVgzwrfL8kpzxJ7hh39tSc8tV2UP2MrESfUw
         CRVL57aJM2X7PMzjglUoIA+UVcCKsrw0VL5BAV7z60Q+W+wMd9+VL5d1QWUtSdijOPbP
         hrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318429; x=1794923229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDxrpSTjR1x207YXRGbENckCJGicT1QoyDbfvYZYoM4=;
        b=J5eKmBNNiTeLyO7JmNfYBLZOv3mmtZhK80xltzh+g8TAfSRjry7HI7Yrj5mqbsVoLT
         M30F0zwE4PeVfS7qYPhxHEEljXk2o1NUFqIDRFP0egHHBH6Op8n+42xwCu3xgwtBcmOv
         1BtUv4uIlaPvoOlNdXThBYaWcmi1a7PLZvv9dHS6XUt9jf77iWNhqLQPoUF0XkifRta8
         fOe1/Z6RSBjAVC0xwv6TntHWBHd7U1xR/+VIijIQzVK0lC4cnM+ZYm63TTbmv47VTbHw
         eN9N8eMWwkhEC+Pwi3RUxJRZ+7822k5LljJb+xJO2qCPQlIayNiJ1fD7Q7vQblxyVkKl
         uD6w==
X-Forwarded-Encrypted: i=1; AL+hErGQOf+Yyu1vg9k1NCTdC0zi+6KpQ7DNsPaj1HF4Sj8DHdMFfQ/OPWk1Y+fIfwerPro+dY6AhKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WvTFirOUFy58osUS8zpslY6GtLCgyEqhQ7TSeXeHzApme08R+
	fAXqlmTe0ORuhTz0D4sVQHizyrYQW+2s2Yxm+eVR1o4kVGeNnpwi4QScXXzMwS9ZWppiG3kc0vc
	KfFjx5oPBccamprKLWdkLOoAcqG+QMxrC4kW0WeXh8RlZfB9KOJ89udNzbsM=
X-Gm-Gg: AYBFou2WnOZ9bqctc7aE6lBeFFE5oF0CfousSj/Q2eggnmOXFsccvy7pPbQLcGhT0Lw
	2dzjHRCM8STif29K2/JwpjjIG+rubGg9aySVdsMC+XIGw2jwkW4ZKM6OvxmNNEtTiUo21IWjUT6
	biVRbrFCmktqUn6SwQRJ0gXlGcTsxzTP79JwBRlq++CiU9MuCddjjTcjP2ubIZqUGzeCq7UGnDt
	K3/Yew7IXbmURweH8OnsmdDgqMEywlbMDGKkC2AG34NjPSVABVdQ+p6789Fx0qPQQRO0pYkMaEQ
	NW+VcX0b4z0Pb2M0oHygylex4nwQAno1S99fd0TsLL8fkIXTZMuNxHQl3ZWp/9wkJb4HMhHzWUb
	2HJfnHKNcOspXwNAAdIWRCdWsGPitOGbhATsNwuOiGE9MHv/ZoC0OWOkWEyDYlZhYO2UEM0d03G
	0oe70tJnB9HjK/YrMjaOfz8+BgKRvLTchCZIqqw8kRc7E94VuBmVnop6cSH9o+EYA=
X-Received: by 2002:a05:6102:370a:b0:7c1:6de4:9f67 with SMTP id ada2fe7eead31-7d301ab04aamr717322137.2.1794318428828;
        Tue, 10 Nov 2026 05:47:08 -0800 (PST)
X-Received: by 2002:a05:6102:370a:b0:7c1:6de4:9f67 with SMTP id ada2fe7eead31-7d301ab04aamr717311137.2.1794318428229;
        Tue, 10 Nov 2026 05:47:08 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02387ad9sm75913445e9.5.2026.11.10.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:47:07 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:47:01 +0100
Subject: [PATCH v3 1/5] gpiolib: don't overwrite the entire flags field in
 gpiod_get_direction()
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
Message-Id: <20261110-gpio-desc-flags-atomic-v3-1-2f463bce8086@oss.qualcomm.com>
References: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
In-Reply-To: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WCMvGrs2u26s3lWSOpOqkDNBquBfAiITChjb3XLJa2U=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8yBYfY0Stc5FLMf6u4h3pBHfM38Dhye37GIzB
 jjR0jeUgy2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavMgWAAKCRAFnS7L/zaE
 w8EnEACyn6QziGCeIMzcjdSwNQbWeiTpCsy8Vvuk7aKQdPsZCQWKQ2V2HvFuadkQWQTAVZFoo/M
 hggqxBX856AdJ3vHJhOIWZpu5gCpLwJTLSvEHI5m6Mz6flFVmrX8w3picd/sqdlGmuacifk6XTR
 dupMrLAnQERTfPjtgR/Gz0ln4EOVwlP4bVkSjqraofu6IDiHO84I5Qa1ma89NwnjDMExdtrJzuC
 jeS5J/UB1mDl577SPRB2iI7TVYa+AijVuRMMAeO52yRIEvW3Z9TxT9jKRoiPokQogR6my7U/k4K
 dOMbQJi6i9UBTWt4FkMBnUo2pmCuJAKh4Ex+mEdn+7V12AGawiq2xvS+f1WApYT63J85DuzvK0n
 iiRTXu/YlzWbPs7h2rQt3pulYZpN3X587/3Hc4+IY0rVBIlEPeKE2f101PaduDtnat8kUGY+SU9
 DCNm/1abqyMndRzo1b2EE5kUmy02uccGfsJBkAOA/+A/3bUWltCsnZv9ENrNZhDKLLx+8Zybk8/
 d7YHVY7Aely2cs6TpDzD5Sd/6ir5omx4+L35Oq6Pt9vdwpCb+eYM1ejWqG48vGf9AWdG8BjoKNw
 Cp2huQ5l7ZskN7JIs7P1sFIpDo9agCjNqBY26lMn5uGYqCRsfZ5IdVo7HJPnbjFHO93DBB7EYdw
 gVOG8Rq380Of92Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfX66sORtyxZ3At
 sHo5oAHL3AKwS2JXklr8BIDKSU+5TBsUMBIpPzb9cEwfwl+liKc0VAsxdxxCK50VsQZXFxAobR2
 UKVP/hDJzF1rmxQUR8JILEL/2j6Wr8Q=
X-Proofpoint-ORIG-GUID: B3gEChyvjrZFe15Rt9-PH-__897pkErg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfX/wmuuim3sfpE
 5sqecrKqERMQaAATSQLr0RJnUJB7vVPLJ5il592DjS7gGDqBuzxHiYeZ9q1b3G9IuGG0m9NZ3YK
 jenpasxn80IvRUD45nyg5Tbfel1YnsJ/2d3dhaae0B6J12CyeJUH8tIcENPTeG9dJFgfPegJ0Df
 3axMUGSSZmdSK5WSehT2yjAfBXl3+yRNF92s7PVJgPuaDQt7uJWEtpgsvSoUjA3LMAbo2ZS1CiN
 SNQZpfJ19t+eYWxQJEsHTWnOfnSN2Fg+MH468nv+wYafGTEciPyaLkKNpMDJ8YUGQcp+YWpfhn7
 6saLgZP8zs1Lzq0I4PGr7Bc8chqvPB2D16lqLxSFspUyJjnJfm4Xnb2mhWJmnUiB8OFvrVC8gVy
 S9F0MME2ihy9QLsEVnwan8yl5Istl/qCnGGsTki1SF3VBu0mJGpC5R5gisOHmpq1lFvvRN3zhei
 350z95H2raREL7DECsw==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af3205d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=i4ZC8ekb83Sdn_VXTnoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: B3gEChyvjrZFe15Rt9-PH-__897pkErg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100054

gpiod_get_direction() snapshots desc->flags with READ_ONCE(), updates
FLAG_IS_OUT in the local copy and writes the whole word back with
WRITE_ONCE(). Any bit that a concurrent user sets or clears atomically in
between - for instance: FLAG_USED_AS_IRQ from gpiochip_lock_as_irq() - is
silently lost.

Update FLAG_IS_OUT with a single atomic assign_bit() directly on
desc->flags. The earlier READ_ONCE() snapshot is only used for the
open-drain check and stays.

Cc: stable@vger.kernel.org
Fixes: 2559f2e09211 ("gpio: reinforce desc->flags handling")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9282d9874e1109b7f030a3e83598ad016c2bf629..1285a993a1ceeff719142ad019451d2e9af6a520 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -486,8 +486,7 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	if (ret > 0)
 		ret = 1;
 
-	assign_bit(GPIOD_FLAG_IS_OUT, &flags, !ret);
-	WRITE_ONCE(desc->flags, flags);
+	assign_bit(GPIOD_FLAG_IS_OUT, &desc->flags, !ret);
 
 	return ret;
 }

-- 
2.47.3

