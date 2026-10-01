Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8C5172FF
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865134; cv=none; b=aeD+KTmO8d3McM8xaR+YGvhdJjObSREKbR6ML9f7x/nCBNX/Yw3Oa+SNBwNvsLD+NnO4GG3AcUBjwM4HNOMUjDTqCypDloTbMVF2yfNzu0kzRri6FgUstQv79xbu3tneC6s/pYAao9/I8OTn7QWeNTw3qIUCLhRH4aJ3snOI35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865134; c=relaxed/simple;
	bh=YWcagTm29p5qJnhkx2n+r5zM1nNxqP9qfROusu1U1MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3Lx8Fm8ttcscYGX4PxTx5j8vnNzQyOSVYaR1tUNHdxbcXFaayMt3o/V4fSn+OUx01ai1+UwXjcXdNjnNXtvdvj1dBkaJL/GZHeRHbw0Fu7+q/fLHs0apIY1HC+SfhGnra5N5ehPTdtYniwWgP9vc+lbBTYZGL/MwrYNY32QHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OGqrN62r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XwlDVzwD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGqrN62r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XwlDVzwD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DjKNO2825847
	for <stable@vger.kernel.org>; Thu, 1 Oct 2026 14:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X65urE6pCi4HjhKWTTcbc8dQLF4W93p9tRsN8DTwgwI=; b=OGqrN62r8dbb3fEp
	2hZ6FTSNhZU39JMJS13y6y8T6sQWGOWcjPfLhjI1WtFwoHhY6+dATFEmgdJ6LNgR
	yzgk9XJzhyL5dyMs5k3s1anYHC8FICec4AlKaURDkYancMNIOQAd7K3FMSDbZ44r
	fHkmxthDG4st11w7hzKLRlrX+VdCrkN4yiX38KebSsPHldWVM4uG+AhG0+QFPTyK
	2ZhfYZHZblXe8JG8NkpOeBFR/aze89lfRUCBSSHOPY57doCtdLJm4esqE2cb46/F
	0i3/aNbTuEjNT9vxbNLJlUipXiMWwKupLcqrRo+UdnF0ZOIJ9c2PXqNbuZbDHQ3x
	q2sQuw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcft0mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 01 Oct 2026 14:32:07 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c0bad5ec1cso20097137.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790865126; x=1791469926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X65urE6pCi4HjhKWTTcbc8dQLF4W93p9tRsN8DTwgwI=;
        b=XwlDVzwDsvBi3jNytiFJ6/De6tG/JsDBvCeOtAV4xpI8Why/4TaG/+7/Dm13CIdwJY
         IQlhVr31ezNnWZnayNd153sdSU7CXvSxeW4dp2vHl7qI1JQ9hKeXlJinoITK74heZn8M
         w9nKH7gFy7N5w7JwKuYmCe7p0NcLqkNtz7iBAFnP8lZ0H4MXMGmthFrcWwf/aAvNc1wh
         4/w6n+6M8zAa7bxXZON+tjMjFwLYTF3AGjQcYe7Wl1/Q1iiZrhbLWxYrYvTOAzjosutR
         K5ukOacNcChVnqx98v0VYj7ttQwM/ib4cntH96u7F/CVTLA56L4tJmN3bAgO0xXMvedy
         fSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865126; x=1791469926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X65urE6pCi4HjhKWTTcbc8dQLF4W93p9tRsN8DTwgwI=;
        b=JR6vehbQPLe0XlNc54banzJH6cgcbeY2Rqw8ZsBYFRPOl2g9f5dIjdwdWbgrNxs+bp
         OrUGJVMS9/BVzuHcGOJK6CYITy1bIGtacG5cg9F3dK6+hAlwRRIkkXx7+uby5I3bCZhx
         SuVNluYNvszqj8W3u0I76G4wiNvGdvmi6zsYwakfsv6kq8uFvCm5s250Rqkz4FwmTPFu
         0iEHSj9EbdKg5aKSJOnMsV4BlkRvs9H/7AgAdwv3J4UwV3pzXXDlw9ucUsOCaMdlHk8Z
         oI8pMD8dHdiaLq0PJNpYA/AH1p5zWsnsmAcCsKAvS6umF0u6Pk1CmmapFJzTWulSrWjM
         3kUA==
X-Forwarded-Encrypted: i=1; AKwUvBx3XvrD49RGr1hAV2Qtob0Y+UorTD6uHdWU2YWQfrME5YureNjzps6WxQJYXnVbFTmWzLC5cU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxsjrBw1V+BgsMfRTj64utdQoobvj+iLcSrJ6ZnAA61aNMCZJb
	QzuEnR+2y/8ubfuM28p6y9bPrKqvduCXevZHLHitu7LeFoRDYnSNq2jiC1pHdJZf557iCD7ZmqV
	b/q3LEw4AIKNUeM2KqsX2jY1zd+zYAZcmXDnepZIZUMLjGLLTtad/EV0M9/g=
X-Gm-Gg: AYBFou1P4nW1iOsKQ4TOvRFkRnwwO18nS+c4IYFszCl/AUwadF5ayMh95ggvvzuEcKK
	N/PWs70JAwr/gtBVynL4FyUs+JYeWaJ3MZoy6Ha6YOI7cC+9BHii9+C7DOjRRkovpvM98YpJ8EX
	ddP3Q1GzojBb9lxKPM/Kb5eAiSNZT6bPLbkQbY1axtHnfGK8pZrKkGCyNCBzt3tP27oNFoYnYmu
	j2wzDi+qqpURd92XdTgGYngEESqHmz9iZ2wpqnClL0KD+f2FvRgQsJ/m1lI09RwXxBtmch40nyI
	PodlquH4/VIeEOTo5ubBcV3QGSjABQlvyVzwgYNPOuq3UzTxTGXn1goElXLjqUW9DPbHv21xaiR
	Q/C+s/lK4EAwMUZ98Cpp2FkGCAb3K
X-Received: by 2002:a05:6102:6a91:b0:7a2:2a4c:606a with SMTP id ada2fe7eead31-7be729b71c7mr1290574137.15.1790865125330;
        Thu, 01 Oct 2026 07:32:05 -0700 (PDT)
X-Received: by 2002:a05:6102:6a91:b0:7a2:2a4c:606a with SMTP id ada2fe7eead31-7be729b71c7mr1290564137.15.1790865124851;
        Thu, 01 Oct 2026 07:32:04 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027276b6fsm321855e9.6.2026.10.01.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:32:04 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 16:31:48 +0200
Subject: [PATCH v2 2/4] gpio: shared: gracefully handle no-device lookup of
 shared GPIOs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-gpio-shared-fwnode-lookup-v2-2-9a40681713cc@oss.qualcomm.com>
References: <20261001-gpio-shared-fwnode-lookup-v2-0-9a40681713cc@oss.qualcomm.com>
In-Reply-To: <20261001-gpio-shared-fwnode-lookup-v2-0-9a40681713cc@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YWcagTm29p5qJnhkx2n+r5zM1nNxqP9qfROusu1U1MU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqvm7bckSZ1ybY+o//FlZDq/jTtSz+dIe0sFgLf
 ckeiMEZXbiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCar5u2wAKCRAFnS7L/zaE
 w6jrEACMGUiniK0U8wh/NiIcHtB5aUyJYoxD1cYjoMCf4ahoj+bUA6SljzCnmgdhAT1wSWsvNNk
 3p7KxOxGj+xYFJUGoPgK7kdAgxzxw90Ie/tHYJWk5lAq3/PAXYKuE+QmnfuhhfQ42Svuus8BSII
 I4jEd5DJjRFsl7nMKQaCGecRKoYEMPaMkiQticpPD9vaC1WuGfC3VglrdPMzy74HBVxinJuo1oX
 2VNf5Rzjor77EkC/7aiwSPDmGYo2hpLK2SNV7Xb4n+5+Q+zerAc+tzYIxe2mrTyIlx8lh96Al2K
 Ib+TY9h0HlSzGi6kljlq5NUXwlX72Y2RTf0sMA8OBhXoFdE2SecJoN2wYEkjwaCzcub9kcbK7Al
 xLKekx14hU2VLBk4PD05BvDtAazNPnz9hWHIT/WqSVV1DMbJLSfE3GQ0ZAL47pebTCLuSrpfD1n
 Mavz0rwmitllhjeUiTlvUjjTUrfxYHjhU9bShFux3PaZ9emTJnsGmo3a4t2kTwMzcKGbfOMzvOA
 Hk0E9mrTSI4j1iyCPEE7+UUcarGqaWKTnvjEomlDrLPSylF6AlE0iDtHg7HMxu08FvDNMUB6v7/
 jN0SXpftUjRID6wqFYShz/Bv9mM3BYLaOluZHOyDKxQo3jSTOl2aF5ZB6n9j/Po2brsYk7Ig8Se
 HSY3QKg88aZz8YA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NyBTYWx0ZWRfXxnwWHtMEuL5D
 BBzYuGF8zwCuMoUOxVPqG/V8g++2nF2R9UMClO2ohfnbGt3ui0p/12Pua2BWREKWGa3o5WMMECV
 5Inmkbg5KvfKCpOv6N2PMh0JU1c3Xbc=
X-Proofpoint-GUID: EaGXfPYXXbX1JPQAHwSSG4UgcCq5mEau
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe6ee7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Il3CDtT01e2KgOc3ggcA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: EaGXfPYXXbX1JPQAHwSSG4UgcCq5mEau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NyBTYWx0ZWRfX9CHTSKw1Xj5V
 fPZhc8e/0tyK1LtOGe5ZYPDKM3XoXNPyxZwBkYrIHRtFn/qZO7rl401NR0KH3iUZg891mom2Jjm
 IxC4hIZlwXZsGvilwRp3gs+RP0rXuD+/Ss3wd57fCHhs/OKV3ydfXHB/lpP5FkjI0pQDm5hKxM5
 /2G8hhlruZp8sLRLibbZAK5HeDAgbGLjhxTWLqDqe3thTP0yGmwMbnOcOHBWJCLcMBYBLCARElm
 obALLPMx/jFxXyDxbzF48XEF1EUT+T57ZP48SSaaOUU8ufm7KA42czTxDGKP9GKhzNViWHo4VgV
 /6KnY+it7+MsqDR5vbMIIYA4ZjgqpD37qzIwL3K/jIfo7BpM/0Hl/saO4QhP2VWWvRptVzWj0qW
 oWrxdi4/2egQgrpwVM8pA0gknHf3VB2kd2vzon2cymCgd/Vi8c/b103or+yEZWLZ4FW2ZYkYgEV
 IfcDE/v6D0objLypb9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010057

We use platform lookup tables for shared GPIOs. This mechanism needs a
struct device to work so fwnode-based lookup with no device associated
currently causes a NULL-pointer deference.

Adding this functionality will require a larger rework and it has never
worked anyway so add a check that allows the kernel to gracefully handle
this situation with an error ahead of implementing that functionality as
a new feature.

Cc: stable@vger.kernel.org
Reported-by: Abel Vesa <abelvesa@kernel.org>
Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-shared.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 6acfec73b73477245c7e4c593f2925efbc8980c6..8c9ac9d9330490b17fb3936b8758beb97a308a15 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -449,9 +449,14 @@ static bool gpio_shared_dev_is_reset_gpio(struct device *consumer,
 int gpio_shared_add_proxy_lookup(struct device *consumer, struct fwnode_handle *fwnode,
 				 const char *con_id, unsigned long lflags)
 {
-	const char *dev_id = dev_name(consumer);
 	struct gpio_shared_entry *entry;
 	struct gpio_shared_ref *ref;
+	const char *dev_id;
+
+	if (!consumer)
+		return -EOPNOTSUPP;
+
+	dev_id = dev_name(consumer);
 
 	list_for_each_entry(entry, &gpio_shared_list, list) {
 		list_for_each_entry(ref, &entry->refs, list) {

-- 
2.47.3

