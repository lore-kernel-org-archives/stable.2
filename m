Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A85535FC3
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075615; cv=none; b=frvqu7ef4iXr8w129pCNmdhGTz8RPiuPOlmXZo+8yAliflQjwqvusyAUOwkryObk7IURvTc3hS8s8JVocZgnnt7XoqS+aXFmVkG1RdX6SMl3L6q9DAYFCfNZdRC0MFpRdRgGSZXzbq3AS4q2hCXkX+33L+4sf5suEHjS3iiWIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075615; c=relaxed/simple;
	bh=b5psEhGu33J6XAeJBkiV8PWWEXQuiHu7lH/f7ufztzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMohAU87JthB3yN1GAZFhenxdSqcTk10C8j5ipgivhYMrkntH4/9ZovDIK6oj8BTmBrBu972GADgIFUpLSZg1FDciMCo1hFvI9LgcxayhCeS36iT9kvNHZXVrRKVd51LXYTL9vet3Lxz1GKqI4NNvNG5tK+x7kJa0zAOnUQPDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pj2pRZXh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvlUILCS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pj2pRZXh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvlUILCS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jHFI4077455
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=; b=Pj2pRZXhZDHAO6o2
	1L0M/W8QrYfyPW/n8w/EwEIrtBLG5biGjdFyOSRjGVKzAQLzU+F/AjpU7syRPgP1
	aAHX8ynWAVeDtyyaV3Aab4KcrYC00QC+e4x2Jhl0uE1X2K8KFEM5coSJn+vzaLKb
	8aYBGUEW706t6LjZM/A8CZITR+le8OXM9a0HRtbm1n1mOzfHX2BTiVds+txQVcVJ
	W8+Ajh5uA1RAIBdxmstYNh63jbCIfH7TX3Um0hxjFv5KKD/ZmukIpQdkIrlVdQm+
	eyAwD/grVieLjnhedaYd0Or4Pe5hR5Wm71R5AomlTlE0TBLvrIjvAMghYRmXH26t
	xCTzow==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc18xq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:46:53 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5df0d59528dso1351766e0c.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075613; x=1792680413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=kvlUILCS5cNyoExkbaGPT7+9opy9k+1ZtE9jxG5+1ZCq+2zYZi6K/DEbkmO0im01Lg
         2G7YPMNsyeQJKOhBKhpbY11vZ+SoL5Q6LboozvKLaWiF6cYa4Y35ZuKfRLnOl/98mXBw
         TcWtxHi6JJjlVAojSg8dqODajCunjtAx3QfUaPXYY5WPpSpGi2o6aMRTCq7DkO91/3Ew
         AoSFJVsKtI+I5/MkQEDK1Idxn8kGI1v4dACTjj4GiiqQ2n9CUUpJ3moVDFirNIdgtWmH
         Mgm4JI0ZyzO1l3RtXNLDkXbIE6dsReQ7hylXUG3mGVWWraOMe6WCGQhkBL1dzITTsxsm
         2XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075613; x=1792680413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=Ux7slclu7HRLrUCwjBC27dhdvWJvocgKgHZSkJi9wbv1PY7jyIC9/LoJKxgaBOEl++
         fg7xo7mKv7w910zPrdknnjzfnUfThjgZEJSyaR39JSejnjUKNbPhq6per1BCziPjpKss
         FS1qqfSvKzyf20kwOCFvQj+D6so7o8OVsPHOlLM6dbKUnpN5uG7fwEd19ItuEdrfyw0r
         9EcXvWNblbJXBgnw9aQigTGxBNitAGymfsTpdMdqU8GLA6jMjeV3XCEbI01nQ52z5zIc
         akqbYRUwjsYsMo7SbpYaiAOvmwzCwClfTIk87RdPphu/TXrDf4eTb1hrsKcDGo03iZij
         +uDA==
X-Forwarded-Encrypted: i=1; AKwUvBztIp4auUvoINnLzU680R/T75cQn5Dt2K7rWJOzh9X2vEJcZCBwq+/tG88vv0ylmt7wGlTSeC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIVl29TtX3G0NOx5ONKPTvcVzZ4tRgUZbx5sZbpESrenQhHD3d
	ezo7zeav6j7EE2JgNtmheCMs4sNXnOMoaBmFJTJsPvN3D3cY9T/g7wdZmh9cd/eSO9hyaygrDMV
	/FwuFIirC+NUSgiFGWDHYAjhXfdoVKmR+wxJRaqKBd8/yIM0DsL+dCGSp4fs=
X-Gm-Gg: AYBFou3kK72qEeXQJgsM2dHsF0m2keY0McO7jyxtqX8ED32zstr3yj7K4KNNfmvlDfr
	72wsW5rLDCjQ5ubj16BBjZS0dUhVh4ra4rLFTeZCx6llkc+e+tGyBslVoo42tRIFfNgeaT0hMMb
	jwO+Nd/KMnabPoAEq5hNHXWyrD9P9XFvMDGJZ0wMcFRO4NHOzqcpK2duv7/61M14iSqK1Sbe4fG
	sh2Vce/awi0+3MGK0Uez3VIjfxRbe135S0rfdbphkUyH+mtGf0YAPIEXcc5mcQe1v5x69iFQWTx
	txJTfKdnlRj4RpIWX6xZxpbAC2gDi25wdAeYc4qmVrezyPwcxWyB8TG0T+c/GNz/vzEYUc+S/O8
	dFNTkcfGAYDVaelh/8oLiFfHjBXOu
X-Received: by 2002:a05:6122:32c4:b0:5e9:7458:9bb2 with SMTP id 71dfb90a1353d-5e97458aed4mr1657862e0c.5.1792075611108;
        Thu, 15 Oct 2026 07:46:51 -0700 (PDT)
X-Received: by 2002:a05:6122:32c4:b0:5e9:7458:9bb2 with SMTP id 71dfb90a1353d-5e97458aed4mr1657805e0c.5.1792075610187;
        Thu, 15 Oct 2026 07:46:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm86840625e9.10.2026.10.15.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:46:24 +0200
Subject: [PATCH 3/3] software node: fix unbalanced reference counting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-swnode-dev-notify-balance-v1-3-9e7537bd2869@oss.qualcomm.com>
References: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
In-Reply-To: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Eduardo Ruiz Duarte <toorandom@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=b5psEhGu33J6XAeJBkiV8PWWEXQuiHu7lH/f7ufztzM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0OdQPjTd4GxgYuJMtA5lOtb09Ol7UVKoKR4x/
 2YVbc0FKBCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatDnUAAKCRAFnS7L/zaE
 w6VxD/9BJiZbpWvTi5865mCNX2ReKRoFB0ADV5QZrYpCJpT5UiUolC9ZnSkJXQ5Jx1SkWXjkQYc
 TJdmeHFxa14DI5LD5CeVMLKuRayuepHi63Yv1/x4AGmKMWGLXiLW3sSjKnHzGy1Npk05hR7UXeD
 uA9ymDAhDBqtEr5pylUu6zgX4xcvcjL60pJ6MGulg/9OCGEoLFS2b8OqfaStyuV2CHDM4OMogUU
 /+a3wCpU6p2D2AflwMBlwWSBJxRs+0o5vBhlPoPomvoY3zzZFo6CQN50DI3uuthPJInedp6ur/9
 5/NmlvCDKpfjyRfb+m0wFcDVle25Dtj+PAg/aYYjGrAAtFS+CdETUQYwybTHLHlMahIohyQ3bsL
 d5SFkTxBsWDwR0iXwE4PqoNdx9A+N/2OCTU6KD+ewUMDj6J+PMJhClEeQlKwDR9DzQEbl42Qend
 0p5pa96qL/lCSttyucBVHmtc06pFpCfGmrm0sA9A4ikWWgQhHkzkCGLfDHhKIexD8gIiikkW9QB
 JHoFqHwyZeCau5ca8i1THq0mKhuXmZDbNJC7y4+L2EmJHyG1MJlmePkNEFf6SqASoLutPA5JcFb
 wJtVAHMUhtngb0fE2YbyQHukrq5C2/u5Q15c04p+ZMzX54k1H01S+8wyuudbreP1ZaHebLdKnME
 o3hg5gIDuarpSfw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad0e75d cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HsDmPXzSDgUE5-xNsXYA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX2LmRIiBwNr8L
 TxakWu3f5+TESeV8mOE2KvvX1Xcj+zvdW5vnXzOVYLtrj3wAe6Vq2hmfgsaH2P6jH517GvvP+m6
 uVxIwOnIN/3QCl0JTjOQZurVWLutG1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX5CMk3waaL5a0
 sgYVlXnx8SnBhssANq/o+j/IHYc9r5oKjGibokQYvra6igkHu5QGKBG4ZAeXURLCebJcRdclqT7
 MH8TfbBSYqO6Stq/V5mONZKjf+AXzXH2CVJUmEDAJdBr7MSbd+IoRxfPb/Qu504b7wb0k9ARTvh
 e0l05rubhG4Qk4MwmsvlDT2DN8jHAH/aOQ1Rh3A+l52fzYolF6tltUtEd1qjvPNx5KGfvsqtCoE
 UnzYmGOYy0vvjmRVPJ7ArexY/sGKklmSAcaE09pKsCiBg8QWWuEfU7Z+2HFATMBj0oelCYuuMzi
 T8GIOipOwp2Xw6RsbtPk82fxFxHb8tjkrE3zbDDthAa40zfgoSwf43SL5x8YcZqUfeKLmk/OALV
 uOIWor7p+a2JfoCBKUbofX4iOUrzqMdMCB3XDmhXmgEdVl+3t0+VUeSsQFLWeZKdXXJrMRgMmgT
 G884/d1AaQSWZmnNLig==
X-Proofpoint-ORIG-GUID: usd9n101OntPCMvz4fYqAuBD2whMbYtp
X-Proofpoint-GUID: usd9n101OntPCMvz4fYqAuBD2whMbYtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150058

software_node_notify() takes a reference to the device's software node.
software_node_notify_remove() drops it unconditionally. A software node
attached with set_secondary_fwnode() after the device was registered
never gets it reference count increased but it gets decreased in
software_node_notify_remove() all the same causing an underflow and a
use-after-free. Use the new device flag to mark a device that needs the
reference to its software node decreased on device_del() and do it
conditionally in software_node_notify_remove().

Cc: stable@vger.kernel.org
Fixes: 384f5a857bae ("software nodes: Split software_node_notify()")
Reported-by: Eduardo Ruiz Duarte <toorandom@gmail.com>
Closes: https://lore.kernel.org/all/20261011131518.48838-1-toorandom@gmail.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..9207d7f96f20f8cfaff2a4eb8915609c499cce24 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1176,6 +1176,8 @@ void software_node_notify(struct device *dev)
 		swnode->fwnode.dev = dev;
 
 	swnode_get(swnode);
+	dev_set_swnode_notified(dev);
+
 	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 	if (ret)
 		return;
@@ -1206,7 +1208,8 @@ void software_node_notify_remove(struct device *dev)
 	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
 		swnode->fwnode.dev = NULL;
 
-	swnode_put(swnode);
+	if (dev_test_and_clear_swnode_notified(dev))
+		swnode_put(swnode);
 
 	if (swnode->managed) {
 		set_secondary_fwnode(dev, NULL);

-- 
2.47.3

