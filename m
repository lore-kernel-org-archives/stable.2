Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885032;
	b=uYJjIfHMRn0Hg35ZSk65cDY49k8GUjjh07k8KTL/tfIRG4odKMTgF8wumFHMdXgbun8g
	 7NqXcbHeGawAM+vGP9Ay5iIEO3H/2WPAHu1M3h5HVQKMM+LuJMViYbAAE2LOQEKvkevTs
	 WquWrH0rQMNM4zW2uzZcuQSi0ucP8RULSvZek6lKzvYciRG+5zSglzfqUbjQegYPJLoQ4
	 RN4ZOTESktk7+G/CMF/7QNBZZsLxDmVkoXJbJdrr3Kn4/nlzuqgRt62crkyGaKBdQJYAT
	 bWDfCIYc0dBA92++Jls2/uwGMffS6u5F/xpFI8e/15supUdaVWZ4B38RfE8V/lvktBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TRdxMZNVjHvNy5Du8W+cgRIYuVrbLC7KA1TotGIZa8I=;
	b=jT54CtYuWfJl7qLYUGOIUCAZh+VR6FhkUBk3Ecjc1E9eNjoDTDHtM4PeM08GLKaMnK1N
	 nkQ60os8dW5NVa9/mbgabFaioqRs2yCd65nqbRmCAQAlYtqMV3wmcrKPb7fwooKykGi9K
	 f+Z4nVQeJGBMSIAyLWuN+0iLfFJl5cU39Ug2pmdhC9Xvp4+/kLqZJnPSxV4BcaGRMgeyM
	 6vcoQy2vSkyEEWaUEaDY3Mi5iM7rinIO7AAVI0AgstkWDVHSCu9jGgvYCc6veNSOFEqlA
	 FuHqJzRKaER2Wb2rx2dS/or+0jHjPkByBcbvGBqPC289XNHOjCZQNsY/MAJEo0QC5nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VFgFUCiQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYXYWVLr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF009606D83B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF009606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VFgFUCiQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYXYWVLr
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tGLi082966
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 13:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TRdxMZNVjHvNy5Du8W+cgR
	IYuVrbLC7KA1TotGIZa8I=; b=VFgFUCiQj1DACVLVZoF5SJI2CqdXt6wFCTtkmX
	A+td797+6XNXi9fmnsEOE0sm3n4K+Cz5A4nKtgK2/VTCTpqsIvZA0upmCpO/dcj/
	AMaKHE7mxFk8nbDHIYIqtY90vji7q9jtroiJtwtf4TjybHLCEfSryKre0O0Vgyco
	1tosd/c8VCHrZadjEuH277v/Uc6liwTLTM4uc1qCToM+SuMvdWSXkY57FRXqKRC2
	v9P89rG1dXliOSc6NFezCR3pAEzVfeeijTnZsssumB0e+A1RmXhSiUPSMCchtrM9
	yj3N1NJQD7UKLkXbNfB9+OsmvvrNuGBE5zDphSbNl3U8d+pQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p10m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:23:50 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99939c0007cso323037241.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885030; x=1794489830; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TRdxMZNVjHvNy5Du8W+cgRIYuVrbLC7KA1TotGIZa8I=;
        b=FYXYWVLrCWH+QW/3bYsrKYe5Rs/CIO2vkbNwDamT7243Ypkbq0vdrhu5r425nzcaNq
         Xgrnc8AeBpAtF5wI75iyERjaADdbrNouTyWJSo25Ob4uwbkeyxnIR28CXwoC6+zfv6iJ
         6p7FcqJ6ckPSZOy89U+P1z93l3Xzwoy4TA+aQ1aNil5srJZjNBA60boTSqmLjM4rBt31
         X9A3S1wyvgBXVbfbnCEA3gZzvRBQaobjzyYWaWPMjLhVbV9b4QP8LXnaWGGH2OS2v5Td
         nsam7ynCpZI6z6rv67AkGDyy+m0LDwkIgXvSkkbQWWQG5j4N7OL2fj4GKF9hyx7LyGy+
         BNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885030; x=1794489830;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TRdxMZNVjHvNy5Du8W+cgRIYuVrbLC7KA1TotGIZa8I=;
        b=iO6BT+05w0MF6jkPFdiVK/HyOYWrURpENS8WiOIyDuxkMyU9qVyrfJ3sb6Nvu5e45C
         zA0YvHIt99iXzXLps5lCaq8qW4g1POBbfxRvOKDby8eXppBX8gW0l0CegLgJqpApRbaF
         62R3eP1ajrhn61CrqB/zWq8wFjVwpWABvwHy5nMm1DXK8Ppwr12hhNh/HRiXIev+S1T0
         mIoUXRFEo0T9PzBjHfMaAxLnvee6TCH2pC36Z/oJ8n7a8CJ8eBRKh67SFZeIg+bAe9YH
         1UVtz+HSDSLSQnxOsmopgN4Nh1re4HEnvCDK2/fRx5pzBYI2Esvw3ycqN3Oz5i+fC/yg
         Q/JA==
X-Forwarded-Encrypted: i=1; AKwUvByr7ykaim4QgPk02sszrAVtgN2/9QDvtxL40fBAXWQBvgdoI2mbvdY+ZBMkDCfm/99ta5x/zzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GHggY9O2wbonyJOTyTTpvtK/AuJVjNe0pxVjKg99qQvomvuXt
	CPkrTBKNgi2XpmT9NJwS2U1aPMhXy/zgpGF+iHPgllu7cyMb3XXMMcO49B5FyyFGWNY7KFHhuPI
	kduXSEOArae+o5Ol+LzHks+qEjKtgQOu5E+2/rvbMauRXfc+NxQ6Ua+FXXLI=
X-Gm-Gg: AYBFou109mddH0YkdDPtuLmaK1ZVYMhpr5DhFZi40d4dPzpE2EAg+TtNJwyy1lZvIjE
	3HspI0MbAaqJuaJsNrKbfCq6Iko5ZBzGzqkRUd5QqiMzCGyyXvhegD0qe91iZSow4LoIU60GRxE
	sztloq31IWoTby6E/NNOjY6eteq9jkTs4rbHB6F/jaqF1jADET6F7/U7maqYwteaDuNwKLkF0Pk
	WnXVN3usgf+O5n4WDC2YhxWBlKhW2g77Di3bmWQ3uEGS1RkmSRGT/XzuC3F89N8WOwLxpUmy3Bo
	dy4xIn+ypbneFub+2MoMZxYq8JTwa/0bjNJJfR2umQfnQxqHvpAeKztxAI2zvDFes8mE7yBwhvH
	Mglb4WnNwtNVQu9FylO6ezUkXESJU2eT2YaW2ySjxpR9jqBgvsWkqWn9pE2rBqW7mulJ2ODHuz3
	E6AQ==
X-Received: by 2002:a05:6102:3910:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7d0728e5ca0mr6759290137.37.1793885029814;
        Thu, 05 Nov 2026 05:23:49 -0800 (PST)
X-Received: by 2002:a05:6102:3910:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7d0728e5ca0mr6759267137.37.1793885029286;
        Thu, 05 Nov 2026 05:23:49 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20521sm10347207f8f.53.2026.11.05.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:23:48 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 14:23:45 +0100
Subject: [PATCH] gpiolib: synchronize updates of descriptor labels
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
Message-Id: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGCD7GoC/x2NywqDMBAAf0X23IUkxIL+Sukhj61dCCbsWhHEf
 zf0OIeZOUFJmBTm4QShnZXr2sE+BkjfsC6EnDuDM+5prRlxaVwLR1TaMJMmLCFSwVRFfm3rNmb
 jfMzWh8mP0DtN6MPH//F6X9cNDZyeQ3MAAAA=
X-Change-ID: 20261105-gpiolib-set-desc-label-corruption-d024bd14a945
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=S9dGRxbbLvzUONk3VoDctp97Hfpf//G89PtLXYijNqM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7INj5nfHiFIa+0yq4PcA0EtllMol9ctLKBAt8
 guB6XpYl26JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyDYwAKCRAFnS7L/zaE
 wwMREACcQVzemlc3w+9MfHvBXrli9QMVPeW/sAJjjUMW/Ki0E7bc1BapWc45DRPZWMpYE1sYicC
 Ige4xacg3nhq5ckbbNkMu/7j9GXCX72fZ8T0/o4qN4GdbS2/wATcuj+SRKtRnJI13c7lglrAu05
 D5BKrhI/Ut6laKyKfmgKPoJnEijlyvE2SoaX2vQbx2TPiLXQkoshwtOMXEIBQVb7+lyTGfypTEs
 7gKk+SE8SShuw98O6vtZBsBVCdu7UIio4NrfeKqdE5BmpGFol9w6WWuffOssVnof1yevfYgytV8
 pZD4jqL/onveJJPzwr/mhPfkW/s4L+qb9pyL6HyVHqQKVvHxp1oquCtJxX+bQamjpOl7KdSJok8
 OiqQYInokNVdOxh0+3DkoFS6MAXMch7DdWTDcOHTlKmWyBjT1lVu/fzxxe+lUKEF8pQdq9Wpt8g
 BA93cplfCjCRtiqi9ezqlEPOSkn85c7XfNUhKk0EXpeFbWn1onV+hbouG8wjE/FuFrN5TQZptFm
 lqQKHF1rqF44OKgqEvljL49lS8/Z/4bMDtpQU2E/bHvpmDTjRFXJFAZxhg3Vd/LEKAIEbFbUFST
 3kNkJt0c9xeF7dqrqGCSajrRiinMdekmNTwBZcoTR19QLGkVDcH0oROUXzon9KXMs0sjlCTU5BA
 LFFZeip8Sy5pDiQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec8366 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JaOSqjnWr-vPQE8BqLIA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MyBTYWx0ZWRfX0R07qHINnj/r
 JpUjQSjLmHqN9K1F2zTgLjIH5RKD9aQhPrrU0DQPj8f3yYmuuYHKXnfH3UotJMhiDsNtcBla02A
 UC4KsyE65XIEpAIbKa0bpJzz9P7444wLCSD8Rz3F0kPDevsfDbBYnIindusA0RUpeHEl5HqZn6j
 njP8Xh0HuVJLdOiwD08XEZrlqsKbddpNXeDQBnX74N3M2y5cCV1B3lrCXNmsa8TYGxYEal6beYl
 AeIcx/ARHfEa3GFbcZ5eXHfUcPRhrnTbsCU+UfaRaAqM5Coh6vg5j2q00CbwIv8tzhuF4XOg/k2
 4wPsbXYex7e+QXcL3SXm6cBqzpg9yMc+kG0A9Ke4fmnUsdv+DHHk9/hGMT3ytNgynE/EjtKb23g
 4NnhfLTPU5gV8ZO1k4X+YFv03hfo2TWPWZwAGAThC1Lvw2yZ4xVInzzRve+JdjlYxdkCqjiYbLg
 ZD8A3WVUjRcARHpdwXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MyBTYWx0ZWRfXwr+mA7LSXdv0
 guN85/bpfZnAcGzFNjL5Men2i+GYDaaPPjZW1xU/LUOIpSG+pxAS6FizinTbW187nxlrFLFcd4p
 un1bzqt+UlXD6e1rpLhQzh6Yax+UKUU=
X-Proofpoint-ORIG-GUID: Kbvrt_gN3OaG_cDzeFn6AQRQ846rRM5s
X-Proofpoint-GUID: Kbvrt_gN3OaG_cDzeFn6AQRQ846rRM5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050053

desc_set_label() swaps desc->label with rcu_replace_pointer() but
without any synchronization of concurrent updates. The swap is a plain
read + write: two threads can observe the same old label and then call
call_scru() on the same SRCU head corrupting the state of the chain.

Add a spinlock to struct gpio_device - we're using a single spinlock for
all descriptors as using a per-descriptor lock would unnecessarily bloat
the size of the desc array with very little chance and no consequences of
contention - and use it to serialize the pointer update.

Cc: stable@vger.kernel.org
Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
Closes: https://sashiko.dev/#/bug/linux-2f7ac8b6-5034-4ff1-9afa-5700ff44e3e9
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 11 ++++++++---
 drivers/gpio/gpiolib.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fbdeda2f278713a47c2e3d2a6640f387f6d92227..574f1b161d22c41e5f9248fe59efe25d7fcf5032 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -154,9 +154,12 @@ static int desc_set_label(struct gpio_desc *desc, const char *label)
 		memcpy(new->str, label, len);
 	}
 
-	old = rcu_replace_pointer(desc->label, new, 1);
-	if (old)
-		call_srcu(&desc->gdev->desc_srcu, &old->rh, desc_free_label);
+	scoped_guard(spinlock, &desc->gdev->desc_lock) {
+		old = rcu_replace_pointer(desc->label, new,
+					  lockdep_is_held(&desc->gdev->desc_lock));
+		if (old)
+			call_srcu(&desc->gdev->desc_srcu, &old->rh, desc_free_label);
+	}
 
 	return 0;
 }
@@ -1201,6 +1204,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_free_ida;
 	rcu_assign_pointer(gdev->chip, gc);
 
+	spin_lock_init(&gdev->desc_lock);
+
 	ret = init_srcu_struct(&gdev->desc_srcu);
 	if (ret)
 		goto err_cleanup_gdev_srcu;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 650a702741dfb938fbdf11db65a46ac85b6af512..8dd8ea747f8a907664ca334b29b6602661c3767d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -37,6 +37,7 @@ struct fwnode_handle;
  * @valid_mask: If not %NULL, holds bitmask of GPIOs which are valid to be
  * used from the chip.
  * @desc_srcu: ensures consistent state of GPIO descriptors exposed to users
+ * @desc_lock: synchronizes the updates to descriptor labels
  * @ngpio: the number of GPIO lines on this GPIO device, equal to the size
  * of the @descs array.
  * @can_sleep: indicate whether the GPIO chip driver's callbacks can sleep
@@ -71,6 +72,7 @@ struct gpio_device {
 	struct gpio_desc	*descs;
 	unsigned long		*valid_mask;
 	struct srcu_struct	desc_srcu;
+	spinlock_t		desc_lock;
 	unsigned int		base;
 	u16			ngpio;
 	bool			can_sleep;

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-gpiolib-set-desc-label-corruption-d024bd14a945

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

