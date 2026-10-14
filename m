Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61714FD799
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970729; cv=none; b=hzjHCvKqZ3GIKvd7wK7zqRVOcpWugyJybMdHE3JsMovrG+48bgotMws4HrvHtrOVh2hS7NMAUAEE8Jz4PCzhx5uOVJViyfg+FDY34mS7VVz4J/YiaeWGYtGlTJYfb3RGhd3lLltN++1MvqCQ/ZjIIL9d37TIHanSBvG5ZEGMTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970729; c=relaxed/simple;
	bh=wxx33mbHAocw6OfeRFru/mTRHPPabfv9Mi3TkUFDJ94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lt3fXMOO2V49YDJFayShgrDbsQs9Ev+7BgSi5/0VnP/BjrqkFAKpSZnQXpripuxRPHz4FebPFWe7DYTFIzgdXKP0GQePAimLcFMXX1QaBb1sGynru58tn5AfrpQnAlJCr/dArdBERZptqNHabe8UB3H5da/PKPvN1IQYgAVLkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJ602C+2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZYxY3Vn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJ602C+2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZYxY3Vn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E96xWW3000871
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uD+Y8zqy9qF2/F+qvk+d3eryZB2TLW67qA34KHqZjsA=; b=IJ602C+2Xc0Q4mBP
	D1l6jOkjhzgY0KAq7tcXgCfZ0IOFaKaXzv5gVdQ6CPtZkx9bZ+es+I0SIPcW0CAB
	N/0pgnou41caTHEeSYzPmC86Qs0TLTM68EY/xPpuZsGBvYgD5/e7U0iNqMZ9QYrR
	pcXzMUdqyUXIixmJKAwoHOoEuxydfjpANXnO3D6hT/xR5a2e6A2qfC0+MJ7X4/hh
	m9kFmIcviIyQ+Pb1CfkeEF8odgZCMWFbPdtuAofsvqXDaobwARKWhJw7OS6nv1hv
	AybmE+ZKwT8H60L2l4Vdd2HeFBv4fumqxCGXgx6ob7kUmGkRi2T5ezeqiqUu7Y5X
	d6uECQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbeu9qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:38:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso144247185a.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791970725; x=1792575525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uD+Y8zqy9qF2/F+qvk+d3eryZB2TLW67qA34KHqZjsA=;
        b=CZYxY3Vng/9W1ngERpSUanbUtstjUzVmOdR4INkUrT0/3KAa+QkaD5J4ueN6jApO3g
         ueKoN7cnUOyzy3atZnUBnxbnThpt0gA4IhbeF5eGQCdgIIlqPKwRXH7qiMqpO9yyE94z
         es3Y+DQKliiItK+6Qmc3E6DF/eBCr96F8TD1GtgwkAaK68CpuuIIZgwFisVnz8CSs8BA
         9CpgeuIxEdFi+ZIm8SU7BbEreaKkRN2TQJFlEQqsIJ1VaC7eRgqiRrLVThP9f+0rYxTg
         +LbfBP4YPABCeK8N8+37KKUNoYvsmg/qDSWuvcdbwfcBn02GXsGkyZQhQmUPEYDDp+Yg
         W1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970725; x=1792575525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uD+Y8zqy9qF2/F+qvk+d3eryZB2TLW67qA34KHqZjsA=;
        b=WXHY5Ori79s3QNQhFR5iVT2ROSUFmlJU9WPvTheLeTbNGOjnZHH3Sd0L1qht6Bq1vg
         jOC/mLQYiiwBz+F8fbivoSLxY8n3V01FSL2yNZdTnCs5+fEGMVv2dx6vkWvSTsahrWkK
         Gow5Rn3+qualy41NNEtx/t4F4ZzlAzorAk50Y42zslk40Ci7fd4+z9/o3Rpiqz0W4wYV
         O9ftG1i9aibg3KI3WBJCBqxvawLtfv0O9llMNDgcuVEnB3IU+om0De1SWWQeER8yF7YF
         2LgOZ0vsyK29Lxz2w98S3rYBwmTBmGu9gsb+wpiGiFvc4uL2g8xxZuQy4bg6HbC8ipZj
         18Vg==
X-Forwarded-Encrypted: i=1; AKwUvBybVH8M4oOzmJXL512x4WGpRKdlpLNKRkXaP857WJtjoze5NcE3rSeqcZtQ9uzbVMiuECCVpoQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEtA7XrNpgskZwF8QsjKNzXabJKcI0uw1G1059dnw3dI9biPdw
	D+nBN0KUGqVghMFNTH1y9xLJ0sJFwsIi+nbsJJw7rrn2oumA5Xb5UzMnekiLfPwFfNn1ceAXBno
	eGfHxXNc5M7cgIXtoh3HPMxz0H6N4z55zHMoNIfBrqD9MOZxNuG9tFWIzzPutmcYRoAk=
X-Gm-Gg: AYBFou11vesPAmv8eV9id+sf1nJtDohJP0n/qFAhnqs5hpgdCJaVwrPrkkt6r8mXs9h
	K0Z88Zsbm0Ipiw+EUs00UEjCVwpiBZmVStG84q4SGujT4cLdM/8/5o5+I6jB11nWygG+DKPUqiG
	MNa1C/mSHiMTUvH7/Xs9wEnxymzjEPcj7S/EP2R4u+IgM/bPufRY/C/V1RbrsejvUsu3N09qMg8
	y2Z1gp9KzKzsno8fPZhR7HPuZDhAqo4HwEb9sAkUnhNyZ76fvM/wtOL/KNURFCn8ZQ6G+HLmL5+
	9r+s/oO3fS+yQkxf6C+fSq0ZlxAESYpKAxglhIn+xybfv2/xbPMDzb9y84xoQ6WWFbH4/+Nt+T/
	XKuBM91AEGIHcc7e2avV3sEd9xAUr
X-Received: by 2002:a05:620a:8810:b0:93e:787e:bd72 with SMTP id af79cd13be357-93eb969fafdmr2394631285a.35.1791970725050;
        Wed, 14 Oct 2026 02:38:45 -0700 (PDT)
X-Received: by 2002:a05:620a:8810:b0:93e:787e:bd72 with SMTP id af79cd13be357-93eb969fafdmr2394628985a.35.1791970724607;
        Wed, 14 Oct 2026 02:38:44 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b4b9ea1csm19510655e9.3.2026.10.14.02.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:38:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:38:25 +0200
Subject: [PATCH v4 1/4] gpio: shared: fix use-after-free bug when adding
 shared proxies
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-gpio-shared-fwnode-lookup-v4-1-2253ad645fd6@oss.qualcomm.com>
References: <20261014-gpio-shared-fwnode-lookup-v4-0-2253ad645fd6@oss.qualcomm.com>
In-Reply-To: <20261014-gpio-shared-fwnode-lookup-v4-0-2253ad645fd6@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wxx33mbHAocw6OfeRFru/mTRHPPabfv9Mi3TkUFDJ94=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqz02c4ki8ArSu2K42mMrGl6IpVTxg7yInVhMQX
 jiu66KOLfaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas9NnAAKCRAFnS7L/zaE
 w864D/4yMaU3Ah2I9Cl4p+rc8lt1hzrrii6M301OCyXVpu+2aNotF5TWiNz0rykwQ9B9uAIfnn7
 KdePLiqwCEkrAahXmvj+hZoXqvdOM6I337tcXLNp6aCAKYUdyHEtAptP0qOBGD7vi/L/zoU2HKz
 /Y6IOxZ9Hh2OgMqNx8KNtAffybicE8ULlw9sUNMh4D1fxsqgD6yN0dfAjbUyZbI3EmFMG+jgfID
 Au1Mz8GO1FEOY1SOzcCVT/70aFxINbDUaW+waIQshmNLLp6BaNB3QZIfraiEK6itty2+io1nNng
 c7LXG7W5m2gGcn0vmP5yIONOEQCJxV8D69kUw/ivJ41Z7Lw6YmKJaBE0CuMKxHTSE3LaVKi9fpS
 WW3Fkj7oFq8NV86JS7GmjDEa7zHLmuWWx80tQpeKylgGJt0sKK4x/EfqA6A9Hb09JQC5qQ5vcFx
 qVAo4ZNrKHuvN4k0B2B21+riEWIiNwBRVOstKs9H/hLe6nLpb4VnK1zeZOAjFA6NcLqjp/Fyl9T
 FyLLZcjJpng1gTrpSh+Qhzf8iCOvxQZ1I8S3VKUn15ruIRP6FZRxxC6EO/A+stwMumF1MWGCzEU
 7WOCNMbpOqfu6IYTXgaH1KLIKiqzShChRuM8fa0TGpNkODIm8i7yEq3siXHBr6w5q5KEfsBxFzq
 zyvvaTgYSWKtlsw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: vPmYC1NIWB8N67XoavPsTPGLtV7tSnzt
X-Proofpoint-GUID: vPmYC1NIWB8N67XoavPsTPGLtV7tSnzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzOCBTYWx0ZWRfX8DsbiX/gQNQC
 zKaSG9SOpD4vEzPa1aaBiWT9M50ngHTv/zZq+8G8cWaM9RXK6cD6GlhGgMDaPf72j78LUfTAZh+
 ErmqM0hhsYBpBjs8HH53zakytLrCj226K8hEZ7M6yggVSjQiSQ2qJHixM+xzCKyswz8lBDuNxPy
 k3NyrKXpK7HpxTxmpXSdovCPiMvGe3aAuvQ7wXYAtqNkjOGyJcLz0xBu2QhSd8zDdpN1HX3meDD
 Nd6tpHV+ly9DfQcf33ymOMxgEif+og9djQ+yxR+y576zJyUJqDHPsph6kOP6vUMJctCGWUWTbCo
 alDMojuhNauSmAfsqlKUkvBD3PLdiSsW6oSR6rS9ZgQoBgq8JI+sni6hCi6Y3s0NKN9FyTiw2k+
 w63nIWjwT15Q6NWapyE5AvPkgXPHgF4/bjKeOKRVcpWNpHnBBW0GA3vP8XO+/zRvTeVObh8WAxH
 GYsdic9SAW7uV6Ail5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzOCBTYWx0ZWRfXyFaKn5fTYYKQ
 uteP+Y9JkxaDTO0d8XPv5xUBoPWq6u8DB21P9iVmR8P4e6HowilBqeXKN5ACDiZM6iCnk8UIDr1
 NE+JpL9pK3tKNzk0mwhf5jSgVzeQoGM=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf4da7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KwuEG1lCUIphvGhCtYAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140038

The GPIO lookup table can stay alive for longer than the kobject whose
name string's address we're assigning to lookup->dev_id. Fix a potential
UAF by duplicating the string.

Cc: stable@vger.kernel.org
Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 5f9623e40b0fbebcf318fcfb2e75768cf6e3f313..6acfec73b73477245c7e4c593f2925efbc8980c6 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -450,7 +450,6 @@ int gpio_shared_add_proxy_lookup(struct device *consumer, struct fwnode_handle *
 				 const char *con_id, unsigned long lflags)
 {
 	const char *dev_id = dev_name(consumer);
-	struct gpiod_lookup_table *lookup;
 	struct gpio_shared_entry *entry;
 	struct gpio_shared_ref *ref;
 
@@ -480,18 +479,22 @@ int gpio_shared_add_proxy_lookup(struct device *consumer, struct fwnode_handle *
 			if (!key)
 				return -ENOMEM;
 
-			lookup = kzalloc_flex(*lookup, table, 2);
+			struct gpiod_lookup_table *lookup __free(kfree) =
+				kzalloc_flex(*lookup, table, 2);
 			if (!lookup)
 				return -ENOMEM;
 
 			pr_debug("Adding machine lookup entry for a shared GPIO for consumer %s, with key '%s' and con_id '%s'\n",
 				 dev_id, key, ref->con_id ?: "none");
 
-			lookup->dev_id = dev_id;
+			lookup->dev_id = kstrdup(dev_id, GFP_KERNEL);
+			if (!lookup->dev_id)
+				return -ENOMEM;
+
 			lookup->table[0] = GPIO_LOOKUP(no_free_ptr(key), 0,
 						       ref->con_id, lflags);
 
-			ref->lookup = lookup;
+			ref->lookup = no_free_ptr(lookup);
 			gpiod_add_lookup_table(ref->lookup);
 
 			return 0;
@@ -611,6 +614,7 @@ void gpio_device_teardown_shared(struct gpio_device *gdev)
 			if (ref->lookup) {
 				gpiod_remove_lookup_table(ref->lookup);
 				kfree(ref->lookup->table[0].key);
+				kfree(ref->lookup->dev_id);
 				kfree(ref->lookup);
 				ref->lookup = NULL;
 			}

-- 
2.47.3

