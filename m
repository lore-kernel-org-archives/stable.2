Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979231;
	b=rb5aLH6Cgf9PupnKQkPO1wYORghudbdMlIA7Mc7WpIIGdTUkSdtUjcYZfpZKr1Kjf21o
	 dS1m4RleYvpNjAnye8FJLrdTRX3n6v5C1E/afTA65Zb6x1Syven5Xkwy9yef3jSf/fiLf
	 jLKX0FSQlYg3Wwmj+WFQzAtU31y0/Q0kAKeywopfJeXNQjbLITYnL6m0e2B1Y0ODuehPC
	 FXIxjFubXD9dqVwdE+86A/X5xd5oZ5rmF8gY9ARlfwTf+/cVcUmnV4VgTBg/idQ4o8jBz
	 cmjbDerhRIpXwosJWf4Nam4vqtdGt/LxeoOhPpKgzWwlwWIcKSVE+NGNDOvZL1x3MKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979231;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G1ZFrJmoKEm1ZQDDeV68P+KaD9B3DrntJ9AbviR+4p4=;
	b=LU7HXt9yvh7nTRtqz93iAFVlmhNFoxhBiNHJkLU6hEn67TPfJBcafpFPB/k9Rw6JCCzQ
	 kI6vTjV8KmxcZmDHtaZhhWu0rWLGEpiDkt16eIZcNUn+EWR7RqqnKlWcfT26hKg/eJdF1
	 BDf9vNI+IMKq5BGw9kEexZsECTQw7WOJaMy1NpWTMibPWjJxSmGn3dnFcvlf3EkJoI8/M
	 7pHQZocnW1tBXwiwTwzyuwkl9wr+x1krVU9XjCT2XoZEjD2XCqYCnHhJpQ6YHG7t0PeUN
	 aIB2GeU5oI2P3ZIdXdieqMbkQhF6N3faDt2jaBOmwbrqmm3YSHABTWBnKlE4t6dgGrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dKmAXkp9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TU3z9QQH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E72606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E72606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dKmAXkp9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TU3z9QQH
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F04NN3184999
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 15:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=G1ZFrJmoKEm1ZQDDeV68P+
	KaD9B3DrntJ9AbviR+4p4=; b=dKmAXkp95NmceLrq/G/h1IQgYjyZ9yuOqaOU+X
	CfXGQnEz3xscfqUT+dvK3Ds6WMDeqiODGV0ffJyKSYli4WbofArlpDMDwTzE4XaJ
	XRW5fyYnxlvzHNqaQDsIxkquTh1kWor5nQ7+Vhp8YDRTkQd5i21F8F9R7F5s86Mq
	p4oTvU6vKh9hh6qHuUoUoVZz82oDOEFIDWJtGz9yWJHjxrYdFNqjUN39zHfR0W1/
	6BgO3ZoC31d4IqucP0olgPppPisF+PE9+G5TfGsMGu1oyd1wk8ttZd+3zmSsPfHW
	NOD1Sl2x9R3y2F7xX9LjFg4kW+7QlZyiDFLmznfnn8Q3A8+A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pabb9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 15:33:49 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bf5c02f7a3so130716137.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793979228; x=1794584028; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G1ZFrJmoKEm1ZQDDeV68P+KaD9B3DrntJ9AbviR+4p4=;
        b=TU3z9QQHX4BqLqVTZ8f2Ms/wFhCRbv0eEVqCpZ2zd/xm0piQ9HQ5X6sOJ5k4fk5xOA
         8TmVBjY/+ibSIaGu6W9QaXJJk8ZrX6o6u9ghcNG1FlfMU11rqYu6oHqYpl781/opURK6
         bjQjQ66y8fP8JLw3E0YASPllZPFc9la72Mi0Gyr75JYxAuH4Kpa5My2Zo6ynkz4rfjx8
         NZ4U/1qaxJjwcbtW8UbGpf1hLu++d2Egm/ojX6XwulL7IB5LHnK6QKYwDOoEFIM8662D
         jFeBdz5l3whYf0cskbHceEk3+azRsXiy7ghD5XUcJCIaucoDA4NJEq65H83PJtjEF+Ht
         NlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793979228; x=1794584028;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G1ZFrJmoKEm1ZQDDeV68P+KaD9B3DrntJ9AbviR+4p4=;
        b=oBM5ope8fvcjcpkmZMupmooNqck8N0UiYbL0A84IQ/kXEY4wzDm2F2e16YsRn8SswY
         HqnjVdz//mFKaIsAN739SzcK8Zdskn1MtO5nncEcKjOUvXrw6X0rGS2jV+9+tKuavflE
         JJ0u0Yb+bK9ZhvEH4/V64zjcNP+/Xrs3sp/BR77LBkYEmP3RzUQPDPnt4j5LiUHltfSd
         UHGHx2LjHXDBLSVpKgMW3VWAZ25CjJxi8PzNuW6Yrw483TVk4sx3YB4ARgz7Q6o+fQHo
         aeXu5+Eg8PtvBAXSw7nmHUFXVo2VBp1TkoL7GTPj/qR7ocmwd1/k0GVY3AOzvXqaEw3q
         qdfw==
X-Forwarded-Encrypted: i=1; AKwUvBzJKmHqwy8RNjfE/wx24nFRaVb5AhY+cd4mxOt9wn2tGQmxUR+oWLrnV3gqbDtWPK1zr4uoZCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8/bRKr5h0h1WZbGAilXc1zck2i1fcWVaYisCkefqi19qfpYNF
	OjmgGgvQM/AUQ1cabX4Z0J/nV2dMD3Ygqd552l7NVzUdeZWc7LmOanTQ3tfGlLhh8boYgCBcitf
	Nx5+4w0/ajD0kU7w93Fopjf8RLf57vW/Uzk7SbAhIplyrfG8HCsu5sXTpfMs=
X-Gm-Gg: AYBFou25Rchju4dcZPgWGzfolgMI2tg3kWYJJPY0SGJAV+Bqzg4lPZDNmpAEeDspEFz
	hFxyB2p7zKQbPtEAPb5jefxTmj0hcI8bfK3gzHH5Js6PmmrM+YwBElKmCg/La2ogF/OxFshsATD
	qyf+M3Jdo6rvA/UAgrQsqBPVL+L/2XkpdhHbVMdhRL9Ppyjy4+4Hevwo6w8U0ldNrFb0DNLDAgR
	R/vWR9zCa7y4et60wVl3Pf+W3rK/P2ayQxTBPISzlTDJHcXdkyJJOcSStUhL+E7ZxQnk4LmIgPR
	q70QbkMZEcHqPith5AXgl9P0olguYJvkN3nYye2TQcPlZvy6Cv1HaJoeNT+SQcHzQs48vaVaUcb
	1lxDo/1OWTz0q1kzM+PzxNV1PpKklvqCffm0zBUZHyyy76pxYRplSRpXlf2ghOgT6ZCcyXJej9F
	b1rQ==
X-Received: by 2002:a05:6102:508f:b0:7d2:8dd0:301 with SMTP id ada2fe7eead31-7d2a166f095mr1397426137.29.1793979228418;
        Fri, 06 Nov 2026 07:33:48 -0800 (PST)
X-Received: by 2002:a05:6102:508f:b0:7d2:8dd0:301 with SMTP id ada2fe7eead31-7d2a166f095mr1397408137.29.1793979227771;
        Fri, 06 Nov 2026 07:33:47 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76031265asm29603215e9.4.2026.11.06.07.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:33:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 16:33:45 +0100
Subject: [PATCH] gpio: virtuser: fix interrupt leak and UAF
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
Message-Id: <20261106-gpio-virtuser-irq-uaf-leak-v1-1-ce9772d8ad0d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFjz7WoC/x3MSwqFMAxA0a1Ixi9gUxF1K/IGVVMNip9URRD3b
 nF4BvfeEFiFA1TJDcqnBFnmCPNLoB3c3DNKFw2UUm5MmmO/yoKn6H7EEkU3PJzHid2ItqQmo8Z
 TYS3Ewars5frm9f95Xix83yNsAAAA
X-Change-ID: 20261106-gpio-virtuser-irq-uaf-leak-392b42bf2833
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3951;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=X3CGwkCMFhQqUGqNpJL/j/edYRDWPzS7au0W+PzOmPo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7fNae0WZiDuvb9VaFd+CIUlczloIyURCFjRFs
 TJ5j9sXRI2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCau3zWgAKCRAFnS7L/zaE
 w2YnD/4om7aGJ+28/5A42nhYI+A6BJkBAJ3yo+n7KlsZ0Cc71YOQXSaNJKhIdXaNzAZ+sU9ReKo
 nycGF0T6ryFnmM8mdfMm0bwP0c3Nv/Hw7yAGVhKr/1EDYOVQ2Z2EU33uYV2Btm/aJSZRgnoq1P7
 V9NcRA00a9jWtS+MladYM/38CzUYmBhpv3i1W5DXLGsG2GeEo7kA+vLOUOGwLcAKL5oe5kLbJWL
 GOqlV29DmZJPIpoSsgfY5NZYI+ZWGoN1+cich5LWmzXjn3FOhIOX2aamwc9UdIO1BeEl0f9MGPG
 aQvUJTR4ZzqBFm9OdL5xcK4by/T0Upk9GtIZFqPZ8bZxj8KKcEPhmHq4RxGC/Noi0KJM35kbtdK
 /hhDnIOgTtDAtdi1SatNQMIo8gtSN4PCY6ym2pQRlbsTTPrxc0YBO5I/wcEjjlFKtF1EY0Oi4HT
 NOyzpxyfC6D35F7gTVwo/LiOeqDMgsgy/07prUmXAWBznVajPiFwavpl7wZoWTREA2CNXAriRG0
 NHHqbaQLtORIFLtTitLrEuv9Omif223gxIXDKcAKrsYjddo7jbjTMdkktqFt2i2m5jzr+HRCpg9
 eNQG/yPuJ2k6pCduqMOUtgpZCn6YF+YB+SUaJ/7h/lNldzKkVh7NalCjvUVUBblm29DmURFUTJH
 6mjgXQLLpwpyAAg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: gYBBihk5h9XP17D-dLxK_6GMMqUlbSVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MSBTYWx0ZWRfX6JGwT5+N/+k2
 GYznmi19p26QIaCYK7NONOMrAlq4pPlMiI6WiFkRgHa0pThlwC6PaD+Aga4qH+Ihor8KK/yB1+e
 uABB/uP2ib3+AoOfHsoeglfQcIXNWyeaomNQaAMZnyoPBFjmdP92ldM1dNNQI4VwL7C9z5rB4Yx
 w/xMTA4ojo2nILMvXKwntbiySG7co/ahbdBQ2UsDEtWq/bDAa7jCJkGxe+wL+KJvno7qdzZBwST
 Q2kWm+yxviguJ2b54Pwe7vDTqn+6NgEkTPW01nkvcLkPni0dGn2fDFf9IWHqFfaM6cSfz5xy5w3
 75iioIh2eX6ahZ0JAViV2lIFFHXl8YJZXZ5iUpOLhrB2RCkY2BXbyiSaA02c7BXdZOiDTeuDvX+
 4Pk1v/PptjWuer4gyf2mq/uXfUdVUWLQWvG0uWlXOGUYeGPCh5cbn4r41cRGwegknOY+ch/9784
 Qt0hFC1Ges1gwamtGlA==
X-Proofpoint-ORIG-GUID: gYBBihk5h9XP17D-dLxK_6GMMqUlbSVK
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aedf35d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WVLbfADCyz3l7nWlDDIA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MSBTYWx0ZWRfX9Uuypha7AGFm
 A3AWZzGU2NbF7CDmNOik9sQQ9u1vOfj78uK7xU5U197bS69Sq7cVGkXRejZ4Hw+hRKy1rDqMDH1
 kIrxEDNq4ZFLqzg9jUPq1qvpj0cY7OM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060061

When configuring interrupt handlers for GPIOs requested by virtual
users, we never verify if an interrupt has been previously requested and
just leak it if it was.

We also never free the interrupts at device unbind. This is both a leak
and a potential UAF bug.

We use atomic_t for the irq field for now reason, it can't be modifying
or read from atomic context. Let's repurpose the existing consumer_lock
mutex and serialize access to the irq field. Let's add sanitization of
input and schedule a tear-down action.

Cc: stable@vger.kernel.org
Fixes: 91581c4b3f29 ("gpio: virtuser: new virtual testing driver for the GPIO API")
Closes: https://sashiko.dev/#/bug/linux-d8935133-0e80-487a-9e00-e748056f595e
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-virtuser.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index 185c1be39b27760b468011acee1c21e649e87f8f..21b4bc64d4d346c51811491ab1d92b4af36ec3c6 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -55,9 +55,9 @@ struct gpio_virtuser_line_array_data {
 struct gpio_virtuser_line_data {
 	struct gpio_virtuser_attr_data ad;
 	char consumer[GPIO_VIRTUSER_NAME_BUF_LEN];
-	struct mutex consumer_lock;
+	struct mutex lock;
 	unsigned int debounce;
-	atomic_t irq;
+	int irq;
 	atomic_t irq_count;
 };
 
@@ -607,7 +607,7 @@ static ssize_t gpio_virtuser_consumer_read(struct file *file,
 
 	memset(buf, 0x0, sizeof(buf));
 
-	scoped_guard(mutex, &data->consumer_lock)
+	scoped_guard(mutex, &data->lock)
 		ret = snprintf(buf, sizeof(buf), "%s\n", data->consumer);
 
 	return simple_read_from_buffer(user_buf, size, ppos, buf, ret);
@@ -635,7 +635,7 @@ static ssize_t gpio_virtuser_consumer_write(struct file *file,
 	if (ret)
 		return ret;
 
-	scoped_guard(mutex, &data->consumer_lock)
+	scoped_guard(mutex, &data->lock)
 		strscpy(data->consumer, buf, sizeof(data->consumer));
 
 	return count;
@@ -675,7 +675,12 @@ static int gpio_virtuser_interrupts_set(void *data, u64 val)
 	if (val > 1)
 		return -EINVAL;
 
+	guard(mutex)(&ld->lock);
+
 	if (val) {
+		if (ld->irq >= 0)
+			return -EBUSY;
+
 		irq = gpiod_to_irq(ld->ad.desc);
 		if (irq < 0)
 			return irq;
@@ -689,11 +694,13 @@ static int gpio_virtuser_interrupts_set(void *data, u64 val)
 		if (ret)
 			return ret;
 
-		atomic_set(&ld->irq, irq);
+		ld->irq = irq;
 	} else {
-		irq = atomic_xchg(&ld->irq, 0);
-		if (irq)
-			free_irq(irq, ld);
+		if (ld->irq < 0)
+			return -EBUSY;
+
+		free_irq(ld->irq, ld);
+		ld->irq = -1;
 	}
 
 	return 0;
@@ -793,6 +800,14 @@ static int gpio_virtuser_dbgfs_init_line_array_attrs(struct device *dev,
 			data->ad.dbgfs_dir, data);
 }
 
+static void gpio_virtuser_free_irq(void *data)
+{
+	struct gpio_virtuser_line_data *ld = data;
+
+	if (ld->irq >= 0)
+		free_irq(ld->irq, ld);
+}
+
 static int gpio_virtuser_dbgfs_init_line_attrs(struct device *dev,
 					       struct gpio_desc *desc,
 					       const char *id,
@@ -809,14 +824,18 @@ static int gpio_virtuser_dbgfs_init_line_attrs(struct device *dev,
 
 	data->ad.desc = desc;
 	strscpy(data->consumer, id);
-	atomic_set(&data->irq, 0);
+	data->irq = -1;
 	atomic_set(&data->irq_count, 0);
 
+	ret = devm_add_action_or_reset(dev, gpio_virtuser_free_irq, data);
+	if (ret)
+		return ret;
+
 	name = devm_kasprintf(dev, GFP_KERNEL, "gpiod:%s:%u", id, index);
 	if (!name)
 		return -ENOMEM;
 
-	ret = devm_mutex_init(dev, &data->consumer_lock);
+	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
 		return ret;
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261106-gpio-virtuser-irq-uaf-leak-392b42bf2833

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

