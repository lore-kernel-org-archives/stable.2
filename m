Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8A522F08
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685142; cv=none; b=TdzoCoAAZk5QJcKY1dWGtJwJNvrqKp6Rw9w8WTRIc5LI7JfmsZfQB247I36YJO/jx5fyDctZiMdx25cCCy77aqlvazd4dfR5zC0SZxYyZ3h8iqtEa99gxA0bwK2dqtdZjnxdvT9JXjERMx/Sa7brqXyKWb8XXZAOd2DPmpILhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685142; c=relaxed/simple;
	bh=yy7Pib9Ot3rjpbb81T81P2yualDkr9btrCVtiyjdhb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKsKWqQzoLjOCMQxi/Qu4TnaIfCiTHJQAtp43UZ7NPVScorxhrMVI1gSM+Ozxe/fJCkhGRilrRcnxMuij2eCD/GXGz2jNX+0fmOJ4aZ3kK4X7d+KYNdplod8Oe83qMogDuZWTJcJ+WYWjrhgfNKPZJ6hCw3QynVBTTUGfHXHP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGVW64ha; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsyaUkYZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGVW64ha";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsyaUkYZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCEA7x773254
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1l6qHI+GEmzSB7BiAtUswOtZV3l54Q989xT5IOSPZw=; b=ZGVW64ha53PsZJNi
	qKe2cJLotDwLrYtKP6cvmEgSlBnX7U+VbRUb4orvJYilEt0HraIfrT9pZHhwZw1J
	AyS6xAjAg5q6oF1w2BskOLdB8PY+PAR2f6gJ/DE5/MvEYdk668sDonaVy5S0IIBR
	cjOvRxJCl8dHZDWtrV0PcNzLaG0XEmFm1cu8Bo7+227QoKRGkO6p6vkI9GUHdVd/
	Ykkotng+6O/7Ttk0frm8ri3ARAUW8rY+rEd8QxrmR2SLFJGZV5LyhwUKDiqdEbPG
	fbz/6SyfLKWYnhyVnVj3yzIW3T5Zt2ad71aMEUVjEaHGZ13TupGCWHV7/bQSRwJ7
	o/2qfg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0hcs0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:32:18 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-988bc0ef0easo150070241.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790685138; x=1791289938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1l6qHI+GEmzSB7BiAtUswOtZV3l54Q989xT5IOSPZw=;
        b=BsyaUkYZQCDkoEqlxd4ukEc0YqL/yHKnmkpKWh0gs+3lM3ylm1I+4FDDOSugtRWgPq
         papY+ySiVU6umX/wB2UENvOmoRYJ0ppxOhlOOuM7/uoQ4LjgoW6lhoLo5hqmqnLFV9wM
         nymfn8/00VNBMQ9tqTTQNub1GhOzkLcKu+nLg1MatNxEFkkDkXbbURtrLR5lpdmUKhC4
         suyoqedKQ4NdgRUe97irAJPCxOA9o0I75fuPk2Rso4af9CkZevU9f3wbeNEPt3UfExBy
         o9YaIBo1+FgF4838JpDjstxk5T43cPy68NaWifE+FFnoCESmvJe2wKXJ5d1t8hMdVcrN
         +f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685138; x=1791289938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1l6qHI+GEmzSB7BiAtUswOtZV3l54Q989xT5IOSPZw=;
        b=2kLtMPHLs1zL7sixNc0J1SYCvEdHFvA5Vbh3ah2mSbPVeQ5u3cGaGOFmcnmW2k9QXQ
         rUdfmqqNQgrZd5fhHCst38QxXgUhu/sI9aVhjcJvNEM8U4sWh5v3EHvGP5k680c6fbbr
         zAtKLqqSuR0xDct0t1jCly6lYhbfs/Ec54I0Ft9Zfbk0aleswyk9vy0BmwujBjl97/Rs
         4NaYD/X0tzBvtznOGOeUQSZa2KhxrsaRNY0lgX+T6xWFQjPGzdMP9C4ATWxOZPuz+P33
         aZu4c90Nhfj595au4jaAIG3VUvs1K7AkrVa/V61GkXtpcJB9T3iO7IYmbnTPmq5kQGdo
         9NZw==
X-Forwarded-Encrypted: i=1; AKwUvBz1c329YIpPZVIhi2xvC2KRB0JxHsy7T3XFd2J73W+grZ2KfUkhneCPup9NElY6/A8GUB9GVAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjRIzFRc9c8A9uZXbsWfPFXvsOUqSdgM6jyFlkRJ5rLqz1+BSq
	eR38eJj3nBDLcqrNR9MXKglDjTqXU4CfXvYZKXxYEYjfbwBc1ux14RsOw7RCHn/cGPGmFqOWU8W
	mJLu7JJHx7MIW/x3qDFInW9ilup558JrWvsZnjng7gIx/MJbx5heNhM6bwS0=
X-Gm-Gg: AYBFou03OpZihgHQdMWJ/G8PaFNdO647Lf4CD2S9UMzOivqB45X2tCTT5atnvPSFAit
	Yzx/D13YgqTSsxyKmmomLiZIkJeL+aEemCMUx3koA5yTjn3ltZcYtGSs2UB62rYpUbVGu93X41C
	gH13lraHfYHlkSrfn0oyKMOETLCq4gagkk1iclGU7wmJjnCPJVjVjjQFZWzgNqnfvwqMHd/bhiF
	G6kjbh2hNLa1S8svnaWT/DPOkihaZhqekKxCpsrkC5d5WkGfW3DGXodtlXIsQFGNGUGkmMzq4Uk
	CMZTLrRS5Q/bLEJFMcDEr68PnfEJwfKJynjEhwo2PNXjN+KhBeBsp0c1l8ufzzthd7Rjr3yBiYX
	lFQiWXYSRdL5ry0JQeFOhCpnLnfuE4A==
X-Received: by 2002:a05:6102:4b10:b0:7a8:15ba:c509 with SMTP id ada2fe7eead31-7af1c99c07dmr5073499137.1.1790685137461;
        Tue, 29 Sep 2026 05:32:17 -0700 (PDT)
X-Received: by 2002:a05:6102:4b10:b0:7a8:15ba:c509 with SMTP id ada2fe7eead31-7af1c99c07dmr5073484137.1.1790685136650;
        Tue, 29 Sep 2026 05:32:16 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1e:67:47fe:12a5:a874:db1a:dab9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0ea7c0sm79190355e9.11.2026.09.29.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:32:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:32:03 +0200
Subject: [PATCH 1/2] gpio: shared: fix use-after-free bug when adding
 shared proxies
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-gpio-shared-fwnode-lookup-v1-1-57d54811de1a@oss.qualcomm.com>
References: <20260929-gpio-shared-fwnode-lookup-v1-0-57d54811de1a@oss.qualcomm.com>
In-Reply-To: <20260929-gpio-shared-fwnode-lookup-v1-0-57d54811de1a@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yy7Pib9Ot3rjpbb81T81P2yualDkr9btrCVtiyjdhb0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqu6/KKPm878XNDCTnNFpGOUUcZmHlaf3N1KVe7
 BedR6oLWbeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaruvygAKCRAFnS7L/zaE
 wxc/D/4xy/R6QzFl7eS8c/Ql2wjUwJmyWNPvYnfVtWKQEwHFkaqGWZQqf4hD8o4xBrRSz2K4tZk
 WHTmslLUkGYffNz8daJ4w7opK47PHgI9LF4EwNBLIV1+Gch513ELwO+NOKyPOOlhc1jKW71zwef
 AYhn0jCxpIGzXMWqqznn/g82O/z9cgTFiEKaelWvkbZoK4ilfD3WeZfd94hH5mUYUDFjC9pmZcf
 AVzAhnzaIHwNfuPwekvwbwTlNIr0RZ6BpuQ1RVW3QNOxv3zhuLgg5ZiExfgpXXcQCBeOUlhn5DJ
 7MR+7eMUADf1g4+8L4JR4PfEMeNL2HDp5XvD+cTJP0l6bnnhhXAsKNFAbHzaRJnNI0pqaeT3got
 HFolREEHUgT9PZ2WA8UAMd16KeflXCKih6rDQ2xH48sKQmx+mPWfZ+Edw1dHIb5Pooxq7/wjXcz
 h2ZpvrGP75VoLkAwJ5yBUJkutcTSzTayBIGVN4+7hZUF6MJif5A2QE0NjJHtg+b/nOsesGPboB1
 hTkcFPEdCJrdWfCDkkVM9B6IVMiBp+WiM0BNHYSp7vM1E+o5EFBTc/rfm2v1sHtCpiIAQ4pxAZu
 qvdpagWJQWfzvXEuTpPIpQdd6+FY5Vv1jGdFZvfoeUHe9yW1PwnjRXad8zaizFsyDHyCeDnmGMG
 96TnPeRfFt9z3fA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX36E0UDPc/HrI
 vd/G+Kn0ZolQb1MUbV2QogKwTcNAQmiZsNYU1mBKQJ+xTcE5Phvntn93nbBYws2JOE5XcHJf9oX
 do1WbqJLnMXBlhWS35Q0p3YuInSU7qc=
X-Proofpoint-ORIG-GUID: f2kiJINjY6KsVB4wyuKF0ONdYFON_5D_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX1To0/iH4ydBT
 znotsNzkh+gIVbKjPUNDyKVbu+q7+gcDHVjSbQnNvpZRFXRkL1HiFHLV+uDWx3Z7CyLbj1sFnL4
 2tt6UO+dertG/5FHelkQagG/2FB9lDRpcCNw1AVTnaBgR9BXF7PpGGO+KEPM9RRrHfqxsh6JeNm
 f+vVDxwKUr9zDg094b3uHROF8qEOtPljp26OQXjbO8Qf9glGFPU9fx8t9MQHz44/rEscmjSpB8w
 MRBxsfN4juEFLtYKTIFc5CxGoqHjUAOy5mN/ip6eIuGp698OtQm9ahXbTLaKc/j/dD44MKP6XfO
 rN/v14fGOwoaODmpJLTnOA84dj0uXLXA0zYpafzx+/F5Yc3l5uUkbDCV42f11HenYa1W2nD4wfn
 oFHxdoCpDyP8GkYdjLok01oQeeS5fhtQNrtuyfk/nr3P+z1ZjqmIPYoDkcVqqYzQDO4hVaTdLYK
 qtkU+7NcRa7nfZM2ViA==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbafd2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KwuEG1lCUIphvGhCtYAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: f2kiJINjY6KsVB4wyuKF0ONdYFON_5D_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290049

The GPIO lookup table can stay alive for longer than the kobject whose
name string's address we're assigning to lookup->dev_id. Fix a potential
UAF by duplicating the string.

Assisted-by: LLM
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

