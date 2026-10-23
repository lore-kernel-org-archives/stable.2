Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750461;
	b=P8seDnbcH7RFPhtavz1+woM+67YzaHhRffpXAXU7vGzx6G3rApHUUAaCsLARSXeD/g23
	 av3M27Z7HtoVJNJ/2XY8UDbpGjVoJJlfwybTm7foVmnyPzcvcg+dNXuYHFt75peao256t
	 WROw+ueSBOicR9gQ3zz2loeRuut6t+9WVydER/i9pqUHqTZ51pVcOwkDFIgugobeR2Jnk
	 wgAHGS+CTSY6xheH61M/dkVvp0BeZObhF+Ro1Lc6rn8qH1oru8a72ztLf6Qg9clqpg+Cw
	 DxqLgdqrJ9+7pNKorF50gpQpXGmic1uXkwY80etGqaeZCFf3gvk9Rx7YdgUhVwmFAcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
	b=QONWIHf8B+dwfVkBTtaxy214b701UdKyYLnWGoolBzc8h3d8Pd/WRmvTtQIB7JGtRZUP
	 PhaHZQioT6Ajxk4N+703Xh46RaaoKv09MDcbUpIgx5Z3SCBUEt0qAc+da7Q6M40VQbA2F
	 0M0Gy8kgUbMkwR6HpTc+BgrbU9pR5DvZpFyI6oi0pFt8xarFhWSeY7CE1rSp/dq8m9Xeg
	 uR99bpZRBIdqY2M9fiyEyHmyRzdmnUtgBQ02dnNRZm9C8ztkCFBDTxuRnTqetixTi3qtK
	 lKDhfNZJ1+PLA9oGfIyZywGtlwChpLXfLjZ7xMrfRPL50NOB+XTJ7YV6ywGlhhqwxKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJJ28prD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CT1EkLF2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEE606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJJ28prD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CT1EkLF2
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAASvO3550496
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=; b=CJJ28prDtl1Sa2a2
	Bm9KbcDV8XmVJil6iNkbtv86iosZdXfqsdZ+stkSO6KR+IETA+iLycFpoMnwm3Vz
	OqS5uLpavCrXU0lN5w1wjhl01oFAN76/lndyTFDm3iniHjSzZj54x73+XUI7nFCI
	ssTrImomR2xQNPVNX8kQqlpynOjzFr8j7pIHf8w6ybfU2ylBjb5eKI8WwYB2DKm/
	CqoPoPmLKvCtiuT5lGgIDtVCG6VH9v1yBsmahCgAHsPugfOayUdmbR6AKvxecDca
	6Wm2JKIL0YYM0/md9Px1MhlZHaHZ8de7BkGXSsWpiqkJIH9im6ntUJGNOgaIAONk
	rp6Kmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrb5q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:14:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb93c874bso325168185a.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792750459; x=1793355259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=CT1EkLF2/UdTRjxBUmVP4k0HdSNY9Dz2aAQkTuWazCuYdbB47gILHMFYCUlnH5tFIt
         5nqAfstaPrBdnn5rZVLGC9OZr/XLMFuYGnaWw3lvXJ2wyHKPO4TmG76CDguiCE0ABLEa
         vQWMAAq+M7wVyEIs0tK4bmGH3dZCXbeLTHru4HzuPgDIwN/QIwtQrcdF5qXWTSxC1sjp
         DNkiBLt+TzfpSdwlNAFW6YYFHFsOA3t4pVInCsgneUvUla0Iyms4/KpfPql4gORuJiLi
         Uq/NNuWcpTT9tL01PiKYAjPocV2VwtdB2Ip6JX9yJmqrN1+XEvAwW8y5DkA8q2iPpeeH
         WU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750459; x=1793355259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=WAVC5dCkhCO5xi/7WTJh9eEVhhxh4wwxzVeIHG26gpH2Qr7rWCdi848JSHoSAlchOo
         Gcx1YtHfMQ0xypgl+wnC+t0LFsP16zTDtCBekXfogs8uYHzX9aTzA+R6Ymcd1mEK0Rwe
         akWvbrGlnSIiQqEQU7rG6QonRdw1x1g3OJVBtRZhRB0gP88/SRNwoS5M32VpTQxweien
         ar/WB4yjmDthGuf935b3ijI/s76Orvun7VBRGuyCPeCtmwJCxtGQPIpBoVo5LHuj99VV
         4bBpVKFsFoQEdk/cYQm/RcVhG4t8IhQkLXY4PT29y7FfQS2uODSjUdpTj3vccCGgPZa+
         rMEg==
X-Forwarded-Encrypted: i=1; AKwUvByXKck5qStFe6+lhqrHsaOGvk7kbEEeZuoCbUdnsCUKrYECWcGjl2MK475hC1vGnidnu4Ev7iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrJOjuennoX2xa3gZauyZ9cj7vY8HroNZel62G2sZZFO3Ttodx
	hSCFBt9p+J0bNczwMP5bFrRaV9Ny7lqvN/akdj8wor6nl8HVowaXaedrXBb+yXk+/6fqTN42vJn
	ulIy0X1QhByXLKr+y4uC2EDKl2h7CgVx4wChWTVCTY8A9zuPiplnvudXnwUk=
X-Gm-Gg: AYBFou3wudOX8rMedN93sVeYS8gDEanoV/qB5tS0aESvY8jjXJk/OsPVdgtiizvno1P
	6MihpK+fOE7dvTblZ8GZyplG9VnsuzUVUX4F42KeLfAi+w3DF7iQNjTQc5Ek127r0Y2OwEZcNWr
	9cPRrSouNinUIkA54FtmaHMtQPYGrKf1iuPQcty1OSdxuTZPGIVg5ED14j5vXe/O6TlFcacCLnE
	f4f9U3BRWJFvNphrUSli47Wjib/mL30RUzpI31U3FyFW5mqf2dxMiffOzCRsU8TDF4kODinK2KI
	e7/cXtQX6cMeWqQ4GFrQOtIzsNLJo2PFUTfbU/7ggAZMZ3GCVte5jPHUP6PCJGXCUPC0BRf0SV8
	grdCrQ3szv3Z8qxYZeD4lrrMP+wqD
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id af79cd13be357-93f626db3bdmr810337385a.14.1792750458910;
        Fri, 23 Oct 2026 03:14:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id af79cd13be357-93f626db3bdmr810336085a.14.1792750458529;
        Fri, 23 Oct 2026 03:14:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025da3sm4397734f8f.19.2026.10.23.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:14:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:14:05 +0200
Subject: [PATCH v2 3/3] software node: fix unbalanced reference counting
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
Message-Id: <20261023-swnode-dev-notify-balance-v2-3-948d920a79f6@oss.qualcomm.com>
References: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
In-Reply-To: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2zNz2YE92ESzC392G1x8G8Br63rp3N4Iy8wYl
 osTmT9ujOyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatszcwAKCRAFnS7L/zaE
 w+tjEACZmRinXVoCkP4Z22vT7HN+sZsXAZ3M6U2IGuy5XXzSQeIY6JlnV9m0mJCkFXDahSXeiWy
 D19YDdUAXI/uoG/dR4rb8pvKJF3W0GQj7Zz6wmrGKbF//kZuPAR9BryX4tSKkY/9l5v35G2w139
 znuZpjq6K5wdLUDxX8ovhJo1rpW64PM1NktFoJ+V6NkdeZcXPtXZQ0Dlkk0XbnDPbPFkFETL3Bl
 ZI5E1562GhXyu8zfv2JqD9bFyW+76A6h/bMIjq3AeAByGOvOFMF28gV9ZSp7aqOsCSokk+/vaHe
 FF6jf08LYBRFVyVXhVVQYR7s2qPFnKXlc5h39rZBPj30HEWWDX3s8Ykxyunc+Hzd/9C/SjmZODW
 RAeSSKpGwB1nxG32AbhUPw03xXLW8911/p3kQ0YZ4wApwrH6OGPvtA6TDp0ThmQanuEfFdSHf/8
 SLvLXf1yRqs9Z/mnLuIBD7KehvSUPNDYsBaIV76RHoo/Xfn8truO40GsqoMzIUZcF8q6Eu0KQMo
 yqoG0u6jUt8nKfQ/y0vEBOKJ5iw9X8NRQ80AiYXTzEGQwwrh1N4Ke74y1bqHoe1uxOTv9KXey2D
 IgpwLgtwd2xqUoW8/0hdxpjOy3FYlqC0AGX9m2MeonHD8agNn1u7VPFE+SUXkozISCQ2ghANq3+
 VA9wzGn7riXedQA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: -VyTO8Sj2L2iqv2zrNYbvR19FMD2hU3g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX0v8L3WtUZu3s
 oMmEkeL/TTHLqpYX++8oSdSiWdKH74HkDz03P5PJIPciYkjuJxMYkHsUzfQMTSwZ+nAc6GoIliv
 SOB21afnU27E/EADJTkEHjRB6H6KvMI=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb337b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HsDmPXzSDgUE5-xNsXYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX0x2nA5mQeeDF
 0HnvAN+or5BILEF0rDrkUYnUm3D4oJLGyAzcCU03KHE4Ve/b03lgxkZgyblMPGqjm8Bhu7Uho9e
 73jsAeJT5d+Aj8HW/WKvGv9659bQXd9PRu7aaZU9YY88bG5Bgrb85zo0yFcLgneNSKnHXZqgSCw
 YR22dc+qtqX1hZgyPVhMnyG7wM4B/hEtybJBFBxM1YvnJt35cv1XDESGClawZyaiJE4Bf7ekv3k
 HFBmJDzSaaGTtOdObrMMvXInCDYalzXUt2Djz1AtuBjFmU9ahP/13tjQ/VHASVSI2zPhCxcSUaf
 KsAgYvIQA32iMOCkYnvhwoQbUugYBZuK1v9B6nv9wcCaVMw5WJHZGDwEhVD2jU/+z/TDAhtC3qO
 GYxQ6gaQHAoSlmQ8kRQ9ej8Fd5+VI5HZmemmvYjBi4PVI9KOGtTjeKziv9Uf7116Ag3XJ++lNfu
 /m7TJrKBQOwNtZnE5kQ==
X-Proofpoint-ORIG-GUID: -VyTO8Sj2L2iqv2zrNYbvR19FMD2hU3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039

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

