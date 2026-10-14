Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3574FE2D7
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970731; cv=none; b=ju95cLeGMSpv/7KHU91IOZ9eC6Zqq8eSuM8T37NW1/Vh96+Zcx7P5F9wgkuteq2JKTEFmOaeVtcT+51qKbedyZwqVi9utyM3k7oHZ1GPnO3KNf+BiY9sUV+2XqR9i+IRP28TBqM0NhSrV5ns9jtZKP7LfLh6erqc+NDyPVcwsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970731; c=relaxed/simple;
	bh=YWcagTm29p5qJnhkx2n+r5zM1nNxqP9qfROusu1U1MU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XC3m6AZMKLWCxv04RxkqRq1ZEXUgqdcPQj17/HNPorpO3Xd+NWMaIJgkCM7pW1cnALvKQo7z5EhV7KsKDHrZiHJlAFuVwZEM4J1Hqvl5O3mkos5B5zNqvPYg6K7Cbj4BN44ceBvmwDExNagvviD7CjLJVvuCGKLtbBjzGUdwyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fw9FD9Va; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUMvSNcp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fw9FD9Va";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUMvSNcp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8lAve3000921
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X65urE6pCi4HjhKWTTcbc8dQLF4W93p9tRsN8DTwgwI=; b=Fw9FD9Va9YXWtKaS
	k6nAc00CFrdSM8IP1CuglAK4kaMayWg/PV2z2qybRK+FDvVJHXWsOq0/gBMpUui8
	kjsEEshBI6kb7RKq0ncpxlRFZmHVJiDYUlL+lzZqlVgjIg2zBwgWG+PX7PaLTWbS
	P4bEe/YWBu4l2xiztknnooqp8Lbi7ZUl/jGJSnpKjCndntUSQ8hSXKKAdw6PzVns
	79CbO2EcIrca5zd2kAiG5DimjUVZinf7XRx8O4fO2TdhTzpUdQWFSifDwTI0jIbb
	Ok3/U3NuJBKggbkCQCBS4a5ybu4jVmhBs49yDBRDjTZJlJZbe8rSSEot6cHTyasN
	2S7DXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbeu9r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:38:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e49a1d3b1so886622085a.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791970729; x=1792575529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X65urE6pCi4HjhKWTTcbc8dQLF4W93p9tRsN8DTwgwI=;
        b=BUMvSNcp+BcYHjvaibtRp9l1WBthGq/0owRjif8/9FZ9wjNvx65EobEzcAhGXjrQLk
         Mcre+KA3Jmdktcda1E78slipNOF5befiqsJxd4f5jsXFT8cp0EHwbsoDkpEFEN4+EQpj
         9N4j5lJ3BbEw14zPi1n46Qq1Uwl6zKKifGQCkIJwKx/jzTwljLN95fPD6gNV3l4c9FCs
         RD6+mL/YS7q3WCSpEIF9zYOZpf4OeRKcJqBnU+AVem91e0hWoqUa3mASV+F5Pu0EUP+I
         yqqyrohOAT9WlxYXHZ8RKO2bL0yYqzLNpDm8YjaA035G5xTxcJBV/rWd5CzYvygd5jE4
         mRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970729; x=1792575529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X65urE6pCi4HjhKWTTcbc8dQLF4W93p9tRsN8DTwgwI=;
        b=y00LdRyjLjZwc8SvXg9d6sAJdH4NU7Q4HIznnaKdtzdo/fLmJEVAJxCQE+GY0H7qez
         tdlnF9VMCXQRjBss8m6mPKUh5CaPmCTlJhyHUrMJQIbYGGHgJkJqPBNWRT/dyizCLoiy
         FVtLRm51V7H/UJm4iSs1IiuJaKqrAL334ZRFB5A8IBdaQ4gGQSBM7JOg9J/nXmEJR0qP
         d1gU7yF2qw/gypwB/Xkd+0kPKzDTwQxembLm34xN+vMJoZtR4xVSGF1g8O/7WsmUEIC5
         T/CsdkR37Pu94idYn7kTcKQPFJWFOYWiXabDwtMr7+zatSXlFVX/D5Sheh+cGReP1Fhx
         dg/g==
X-Forwarded-Encrypted: i=1; AKwUvBwCC3cbxCGvLrDp+lSZ3RbI97NVpHLQ8xlDmHZwB/+lt6/k4rpG3RmRqMCvOaCJ9bS1MbQSf70=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAP6MsJezyWrnIkUFEeTa3g8n8nakW+yjJVkFxoXv7L/VLB9LV
	pALgzmkupTFGkRjoTQd6SWUdakLLkA1PZ5UbPayH1JKzWd2yGb7R3k76CdJQDH/afDE6k7gvg0d
	5Gi4RPo7OT7EpF466MxJM7JsL95gzsV9Ut9ThtNmJnvz5q686VlLmKAS9mK1z4AK+cS4=
X-Gm-Gg: AYBFou31f0Wdu5ElkoSoZ25tNMoHCGr+ChQtXQUemlpHDzXkn5vEOzvKyHrgZE5580m
	kpj905BOOsYTHcrUnJ8OJdTlJCZ5t1RtIEwNIU+4U3X3iT/L8hA6IKfLuE42AtYgnue1q1JO0Id
	iCsw0l3d+wXK1RuJGXV5UWt1reCc62cBrPWt/2xUWBAXfadcDklg3nmeD1eVVi8/dDZAL1wtZaf
	vmFq7ZPy5SHDoHS2fdeChDz7/4x5jTryCVmcQhcX72++hZ/vkSSxxioE7OV+811k+rRspCTpLP+
	IfHZrJ3akRet5REMMfytpIQ0F++kCO5hr5fSIWme2ZGqeS7frM5T/oxSaWPpgqrB3VQmIfCJre9
	VyCsCvsikRxoMzY4mfT6W43wLS9u3
X-Received: by 2002:a05:620a:4694:b0:93e:d1d0:67f with SMTP id af79cd13be357-93ed1d01a42mr1924516385a.51.1791970728886;
        Wed, 14 Oct 2026 02:38:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4694:b0:93e:d1d0:67f with SMTP id af79cd13be357-93ed1d01a42mr1924514485a.51.1791970728519;
        Wed, 14 Oct 2026 02:38:48 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b4b9ea1csm19510655e9.3.2026.10.14.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:38:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:38:26 +0200
Subject: [PATCH v4 2/4] gpio: shared: gracefully handle no-device lookup of
 shared GPIOs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-gpio-shared-fwnode-lookup-v4-2-2253ad645fd6@oss.qualcomm.com>
References: <20261014-gpio-shared-fwnode-lookup-v4-0-2253ad645fd6@oss.qualcomm.com>
In-Reply-To: <20261014-gpio-shared-fwnode-lookup-v4-0-2253ad645fd6@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqz02dRYcKHgxCNWX94B551ajsTpI9ra7JSvhEo
 ddYdwuZRYOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas9NnQAKCRAFnS7L/zaE
 w3mgD/wOBcoyvw4aqPV7r6BA67P5UtfdC3TKdUzhGCSDzIWLIp7Ffn09VXHcvUuEYrlBEX33Y34
 fcRr/WRhQmM7tKew5vInbTSUGlUgqS0LO0nA5u3Mlufo6P+4JohrkKHPvVe9XwfNKF0YbnVHjcv
 AVibJT5guJbi0dZc2MSlihg93h0aqklBbAYDnN6GcAxroRUNIcjuSSgmn4AgYSLuYFSul+F9hH9
 5v7ovR0/9Zp0QztPFUehgrqbYvmIuN2Qm6+h5cgE9EdVhHqvlZVJ7Beu9mFqQHWX4kG7FEk3650
 Sgkzz7aVRCyZysAEaq3RJB7w9c+bDclXLbXVwp3SryYlS5xtyEhlFUdt+NiROZXozXYVQMYWfCx
 ArU210yP4QFCLeAaJqQtOyllIoeF/KzdUAH2pmj1NbLG103y821Orx2gtJXd3AN40FBKGch1PrC
 eH/OD7hFpQARE3XeFvqXzmHzIIAoIcHjy15Jz9yFAZSGLnP3PCutAnaMTeNywtts/FkAJinviHP
 HuveEXdrEcYZgayBw0QuJTJ00DVumJ8vC7O2IiVOETNJhuaUDJCsCR3dGy46+x4vgIvY9sfe7n5
 1YHDnH+n79gtr6cR2qMNWn3eCDnfZx0M4uD1gVlvS6U6hHs/8tJTM9MIDPphHI8v0+muVGOSN7x
 IvimziQYF537FAQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: f3FLEK0bLG14iHrrbXccjJqCULfS9Zgb
X-Proofpoint-GUID: f3FLEK0bLG14iHrrbXccjJqCULfS9Zgb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzOCBTYWx0ZWRfXz0hPBDXWo868
 Vlau0CDELsIrh1AsTeUqc/+zLnOkHoOF6h4LPWxuj7zlcXcQdTZfLJy/UnaUi3H12Zac+EW4ycS
 apeY7rTN+0S1eFJZwWemoLm3Syvu+/B0JPa39xGSnmENQzuXbH3YeFI0D/7abo9m7wi/86vYsNz
 onChEYzgML490Kb3XVxuzhQNJNyXwMNBavoox5A2ip5vViAWnW8NPd/ZJMBdWc5LXDeb9wJS/s0
 Mc9j/7qnr1XtP65n963x+DDnjTgtH6F9lCM4tsIKyZhDwRO+5GQ7XbR9LC8GpkG2Jk5cNb8phHo
 TQ1T2rff/hhmovadc3PS/werQnvkYGskg8UBS9GZuyt5/6zCgHl/+5AkFwBvf23xvuX9qq2kNF2
 D8FMsE+Mt0DiaWnPkJi7wgS0HUFxy/v5+InPAbpkYj2DHBMR8BjGnfdeMOFBOQgf1uBsqjE6B+2
 wv7AQZznNJOSfIZW2eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzOCBTYWx0ZWRfXx19+DX0jl8a+
 tICsMAHEbp8JRfCXry44DM0w2zEeWXE2T1fi01eFAPiub0a8Knx2SvU6xrvrE2SlbA9HBvNUotZ
 AclN3DEmKSJZyta1B1OteQjeCLk9QiM=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf4da9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Il3CDtT01e2KgOc3ggcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140038

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

