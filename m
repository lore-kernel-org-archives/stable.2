Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318433;
	b=gw19UldJRmG4ORbH5fOxlwKPb0citv4Uw9z2i5vyy3y6lrVL8nfDHba9gTPqMNfmm2wW
	 qNtExOcUdwsBvaj2kXj+UsAECzY3yt1Fnn32SVtsmebNuXB847fBjbKTOpTu3XWqqylSz
	 2xYyc5VuD+EXDvryzp24nvuMuv1ARo3316pymgJBtDJU2qyj+0iYIstqsxVGCIAnt9o52
	 wNEBG/K5nT7sqaEOoFRhWmReDw6w/yyySOHFxMG8n+3BcGaJbmoJxIGxxCBKhQvK1aKCJ
	 G2nNcP/Ki+xHpYkuOtPuvZHPvVsoS/EjCp8ahO/ROP5c0gXD82iga7d7k1Vp/pcN1+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318433;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TQeRYkQmJ7tDCHRVBmpwt2sZ5VPFxjPdGPyUcZkNU+U=;
	b=oXAxaK4OX5Y1xwn2lbj3j3Ry1Aps/5WuImpwg3pkVDG469b66XcPH5WYkyFGGP829U3/
	 WbOOqt9VF+5az4Y3BB9pgNAHrTYGMpJDjEIwMxMRZHRiZT+59F0Q/NviCtqJ6wSAnUm24
	 ZUCmnQNrL37wyhqmQXCUnPIzjXNBUT7pbONQ/3FAvI8qxUGg7PkdEgLx5IHAXaexUEUJH
	 u9N5dAu260FYhHn2OPRqrQbeumtYAZEm8sbbHj7OS4kpqv9QCfCKOrBO2XOZpgnSCTcZS
	 kyxvP+egs7QIrX8cXTNeU9ALCMmvo13GHmnyvp/TSa+pxa2jHfd+8KPgxFF2WJWhfiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HibgPE2C;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YDhlGcwW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766C60A261A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3766C60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HibgPE2C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YDhlGcwW
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAbJw3850926
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TQeRYkQmJ7tDCHRVBmpwt2sZ5VPFxjPdGPyUcZkNU+U=; b=HibgPE2CYo0ZoCjq
	bn4Ej/ls73SqO81dC1lhA8bih6HhHGyKLjwtrdIoP1EhnB5CG4fVz3n8KTFSTDul
	JLXtOXZWHnmNOqxKka3Y5ZZXBCFe5PC+Uq9JBoB0jckXtbSMilOcSZpOleD3IEOd
	uoDjSgh/9iIzFAMzrctJTD0dbr8Y0XA/KMQRHJl358ML0/nBMnhfAFkO9/kutOJJ
	iPjDbzhUa5S4agHeous2cvJd9jSUS0wxHHuUNae5sE9CBXffBSmbNC0+3VnzjoEO
	MN6JhITI+KSvqvzAagYsISClUKnq8eKsss4rN49xIXjBeiTyun6MKMhUNme0dPlo
	8BcpNw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx84xdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:47:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7d2cb77c7abso196300137.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794318430; x=1794923230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQeRYkQmJ7tDCHRVBmpwt2sZ5VPFxjPdGPyUcZkNU+U=;
        b=YDhlGcwWs8ur0o6n3TYZqJOn0noq+rnS67dbJeA06iZpCdzCcgyKjgXE7A7d2maOB5
         9v8yE7PR2dh1PEFRxPcA81C2YVkfEBoOTvNriX4yzbgmfoxTkBzvYeSzvg7mblM1yeGm
         KQrIqP8q5qseZr1iSa02sv0X66+xNF6ckrUmiBToxBZNQ5i4RUl80jxh+4lwvTKlLOuT
         dBbkLqzZPV7PWtWJFvXDDjkCcN03aOXP6ivPrWR7VBLyvTYuhQi2pWOHc/y0MHPGxy7B
         jJl4FkDJE3W+021bMlAD+gmGWXllOUAO4BhqD82/5to34fpz/6iHCfFmxhsa+JNAICCS
         eDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318430; x=1794923230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQeRYkQmJ7tDCHRVBmpwt2sZ5VPFxjPdGPyUcZkNU+U=;
        b=bfCpGsgCoRWUNEL5cIYUAlA9HaK7/mBQwJnODX9RIJP5cXsl2ArA9Ofu6pKIJTm4iC
         EdNNYFN641KUCfoJPgeLMV3Q8Ef+QfZ34n3kBx5p1XrihrE/bZpEtmU4jAZvOIlrStQW
         yUCUIeV/ooxzP9d/JlnkMlgDcSk8gmz8PLBsmDKuG6SOR81WczYsqVrZB19AcmM6oHEy
         FH758OaGaZIZozzXHuV/LT9VEnjjtejyrgrV6Szwln10ZWa4Q8mMW9T0I6Fx8Jd239hN
         CUxKKfKj+eaYZPeZ0giyKgUkLiIb8nUNwX6BmltU+WlnJ49X63VRS/SRayjhD/LrukpZ
         WqaQ==
X-Forwarded-Encrypted: i=1; AL+hErFWaMEJvfVGDDCZBrE3YWPPgm1lpAtIOAZ+Q3Qighg3FwGNOY2cfZXeOvlGpqUfJkD3niqpDKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z98157DJcVrvdLyxuJXgW1/YF+K8wB1D1UauySUcpFo5UZa0OiH
	KPP4Yx33sVNOrG/ze5p7nAa5HcNaL9ORGLgjJRSQxIopgSAuedjdBD824G1SYbrPqN1YH4TCYp3
	DLKHIWiwzIbixE8rWzvZEA0HGHli7/Dh9Q6zBFD8srKM6E2dJKYlXgI+fG54=
X-Gm-Gg: AYBFou0SXPTxKEE8YVAt1EpgGgCddVQlFHyXfifr2J+n7EE3dC1GqrQPvH5DOw0c5I2
	9naqhJco+nfvjUboa5U2wOkCzzCwKUi7jiYpptKwWZtCmHtjW6mqEo6J4LYBj64f0Au7lW63T1t
	O5w5iG4hCE0IK73X3P5iGfEUbM2PWdwBOxZ9ERpiaSRciZ+B+seBPG+MvMo6yClyqs3BC7dJU9w
	PRhZNOYJcs+KT5jtoxX55IoKIuX7yd+4AEX9JVsBFtW/DKp1S++F1NeGPU0HISCAhqKKdtfwpP7
	dPOKGWzM4J0uXdvkvECgwfSY3tYV39dm1P66v4aTGL3uVjFvTOwjc3eHllxBbtvxaOQt/0jvWhF
	wr1EDjjAFLgtvB/UcYzCCG/jbx3eWgdc0PUveAM7w4x3SZIzfWVDO4dWIGWzp3WEfSDWqFZrCxG
	66Ma1V3Cy/meUkRDHnScJD2eu9xUZWELdyPs65I4iB+ZptkIu664uvHxgd9R7i0d8=
X-Received: by 2002:a05:6102:418f:b0:7d2:b21f:ce1d with SMTP id ada2fe7eead31-7d301bf6bb0mr655107137.25.1794318430487;
        Tue, 10 Nov 2026 05:47:10 -0800 (PST)
X-Received: by 2002:a05:6102:418f:b0:7d2:b21f:ce1d with SMTP id ada2fe7eead31-7d301bf6bb0mr655098137.25.1794318429980;
        Tue, 10 Nov 2026 05:47:09 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02387ad9sm75913445e9.5.2026.11.10.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:47:09 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:47:02 +0100
Subject: [PATCH v3 2/5] gpio: shared: use atomic set_bit() for descriptor
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
Message-Id: <20261110-gpio-desc-flags-atomic-v3-2-2f463bce8086@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4MZFB/JlsIQls6voOiVQ+Wibv3mjdrlerjol78TPPcc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8yBYx4jd800vQenp6odZ1Gdf0mNQcvRrYNO56
 oaMo6LneDqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavMgWAAKCRAFnS7L/zaE
 w1UiD/0ShLDYH0Rohl7UYOWbHwrWX1HDtQKjUTTjjWLmjVOmZuUr4RjDaPaw40o0aYPD1NIcgOa
 haaMVUDQFtphI1BwE+p0SuR+AHXwR3FRbCuinhJq7VlIXfF8BEGDCXVV46ledJkDQL480Mu6eHY
 3LELcg/aOOjmKH6j/M543xc2X56LvU7AXOMjmontWUpekKMnZeBXLNZvlxxGRv9dNP3P1FshJBb
 /UKAil+H7abucpiRiXsDttHojdsKH9pBAAp4A6b3rA88J/YEl67+qxDXLsVcPqBdICuYfhKhpPG
 TJxO7+x3br0hbKzTkgVbw20j8y92/uDU7dyMm2UZQtAcDdkj7ecEp7fjPgnnDxdpBslKzkgi40j
 b80+t8HnNH3kYy0VSh4zrZHT0N7tjhtrYqP3+/FPraYeal4i/28tdzBmlzX13o+LIKuOyy6Hzmd
 swc83vDZR2tW1DeVxB5ICa/vFiXYjnncMTQe8kin5b0qP4VequIsFGox48qoGgrPrZUjXxYPRBl
 Sk6tfD5l1hCDqEPMIQP5eR0hNOT39hIs/2TxleZd842fs2mkV0CysmHlYb8mhXSWpH/uB6ZX/pW
 uGJ6/reMo0X0QMSKnX3V4LObdY80VXIVUA9Oz+W617HK1Xx/fam/42VPg3xsEd66cUlnAJcINGR
 unpOfhPwCUvZl8Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af3205f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=H6RLajfuJ0QrpAsTGAkA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: HzWYQrchy5NnIAhlVjXZPTuRveOmBSM3
X-Proofpoint-ORIG-GUID: HzWYQrchy5NnIAhlVjXZPTuRveOmBSM3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfX4o1RbVj4hTC2
 Yjm174kyJ9kHQzGt7QRjZDCdS2Oj5/5rlCgM+sZMkjL/EV1EOvCjfEU2nTJQSzA66jVG6rAUxjW
 nfO5k8U3c01I+yxGxClA1oPDISJ30Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfX86ogxKc/eDHo
 vUAm/ZWMZU2e2ATmRvjw1vc8t9A181+e3BjLD5Bc+a7WlMSEIeznyILrBGj6U1W23Aq2f05Dsh3
 3WzpGWHWA0hT9oX8Q/manLakQn5kz6vKtssV4ujV+0Vbl/AzfIJeyQjl+CK0jJ9UjfHpuSHjmm5
 wj0T1elFqsjYqPkwl7F+HRTRwd88GKZYzO3UPz/MIBypbNbzoJdww9jkfEHII5AjlvxbKEC4P/d
 TKBmM8SC7iBALQY/qjDZ2A4XC4j6806kIR8k4mz46oVouuH/AH7Dy9hLQwFf9yoFdUhlHoGC3if
 Z9+yhRicjePZZ9boxnmtXmBRyo2os7ePl/l69mcUy+zbDaPxTTc8t7CIN6KC/U2aFS2SfNStlTd
 Rxsc1fiHHynFtfZwE8hmQ9YuzLteigOl0j5gdcf1n7V3HUXlG7wTS404GVep8tWtnzihX8dUJSS
 IclwesQSLVIILAT1GZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100054

Use the atomic set_bit() instead of __set_bit() on desc->flags so that
every modification of the field uses atomic bitops. No functional change
as these run before any line of the chip can be requested.

Cc: stable@vger.kernel.org
Fixes: eb374f764a70 ("gpio: provide gpiod_is_shared()")
Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 8c9ac9d9330490b17fb3936b8758beb97a308a15..7faa5109617018af84896163f3602ff7dc2ab62f 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -532,8 +532,7 @@ int gpiochip_setup_shared(struct gpio_chip *gc)
 				 * This is a shared GPIO proxy. Mark its
 				 * descriptor as such and return here.
 				 */
-				__set_bit(GPIOD_FLAG_SHARED_PROXY,
-					  &gdev->descs[0].flags);
+				set_bit(GPIOD_FLAG_SHARED_PROXY, &gdev->descs[0].flags);
 				return 0;
 			}
 		}
@@ -573,7 +572,7 @@ int gpiochip_setup_shared(struct gpio_chip *gc)
 
 			desc = &gdev->descs[entry->offset];
 
-			__set_bit(GPIOD_FLAG_SHARED, &desc->flags);
+			set_bit(GPIOD_FLAG_SHARED, &desc->flags);
 			/*
 			 * Shared GPIOs are not requested via the normal path. Make
 			 * them inaccessible to anyone even before we register the

-- 
2.47.3

