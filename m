Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387962;
	b=ayiqozMEKFKCLFCQD60KpfJZkPcvZDmK1op5TLu+NmPr7bgqps9nPo8hSCkBUe6KUrPA
	 c/3N7xJNnJ+1PNiCNl0W6iSE2TFspjJCCwiJinsNqxJGVvOYDp/9vh3iJoaDd6v2608UE
	 93y31Llz8W9R6KDftsR970/XzbQtPNbbTMImjwI12KAQpStd4Ahu0D6qCdRf3BegKEPfW
	 r2kmvSzm1VBJ6Ro0wr4PFR8TCHI46gkWohbksDaMYr4hS3JsziS/Wh+x3uHE0Rp0fq/gi
	 g0hnFNRrWVm3tbgJ9Tl9FwJjADekIJ/zWOXFToJSn/AsI9k4lmZmMlro5VXQM3QDtpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387962;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=;
	b=e6JJ/rJMXvKxjEz2TqVQCuRu2lN+hLtZaLMM5FAM+YQ4fyRBJhW2IbyWwGDEs5F2TJr3
	 4vmFsfe5urlismQq1fj0PnzCkUmS05/SlXwRDGjjUVXl1ThKpwtNfzVebEsZ53GwFFkUs
	 4p6RKKnGMOKqyYLRBheuE9fJEhpVat8JPWO8/Qaq+Lr5lwNfOJMUgY5tCGdAMJXcPoyqQ
	 eZr6SsdsqYDp8O9BfKbmeoeC4Mlg0ks7AQr6zinFEHHQ16F+nqg4YVd7wIdA4Q9iocxpk
	 dLDRjQSDz2N6OzpdVGNE7YMJlXL5QErcU9JNVBGNx9NqYujggCahhR8bf7L4GQ7gWWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjoqT0KD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VbN+f9CH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37356606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37356606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjoqT0KD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VbN+f9CH
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KpEF1052622
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=; b=GjoqT0KDHuZKIFSG
	gcxLqcDBpvdsaHA+ld/bNgzJmDDQjYjLDqBq+/DJowUtCWxj5cnbxpeMkk6II5H0
	7Ho3fKM5Wp5VOiIVGWP8ccQ+ekArZmiuWOQeDgNogB4b3SpZRYp6BMa+UojlGNEB
	dLf+tpB+OGejv3moOOPjKKbv+AikqpuXzLh9O+7W0fryn2MdskF1CNqWzdOklH+5
	YAHWmsmEyOkvnxma3Ik9p/6KQhznjXYYqsFlqhY10jWZ/nB+I3YQa0+7myXuIK2H
	JyT87ZcyfOgmuSUhwupaabDiXqQkbd4NEh5dv0hyQ+hqZZXkMKa1uOYl0Qng8Znv
	8IxRJg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh1rvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:06:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so5802428c88.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794387960; x=1794992760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=;
        b=VbN+f9CHA5idfFemD0oK+BWaYpaDJv6Yxj7yQga1ipcYXx0E7C9RD6RlvyEdIIUFhn
         WJV6Do2TeUbFbluNgmoQFaRMsJ0xPWNdCnysHDsIvKEyjQAeGHk85zbaYoQ4E2H/AEwT
         R9qQ4nAM67Vh1pXouW8GvRua1YlwlVBNBrXRkES0AaFGIbBxPN2E+0+cORwAeQeN2Opi
         oLjf95+IWC0w0tRXmQ37rXapbWuT3xgh5Q+QrbIxArS4J35SMUwZEZE5JSPve4FF8+wy
         zil43Sb8XTkjYLLbhWWQuV1NjN5b4liG6ScuTtIjZETwtwJZP8KFy3Pb2QN7md0h8sbj
         xFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387960; x=1794992760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziTRJRTyTHrXpykIexrVW5H3SlT4DMRvLBq5cG0RzyI=;
        b=p0Oa0Y1ZYhe1tNXmNUk1H1AeZ8u6icPkv7gMCgNhOh76TTvRu6QSdd495bcKjzxs4t
         cUIE5T5fkEILndAadUpb2KQQekgQ58K/kwuIqYsRRdq6/pnxXtA6rx6lbnPHKc8udSHG
         4mEU256GC6Samthz+KAdUDX1yyFF9dRbVIDdenTYri660KPXSTKWGGArGFwo24l/S9tb
         3ee8KnQemUYAnT2nhvVmNojfZ3+lF1oWf04351r/xnE1C/Wwm47fVA+aIHTXf1spTJXH
         csiF0zerBjcJunfwrwL9rzCeVMH8RvZEalamToMvPgguzyocZpZHQ5dfEJWEBTXrWdTM
         0eOQ==
X-Forwarded-Encrypted: i=1; AL+hErExAqntdT5OHEa7RYKhFg/GHw56mupFSdaMybNC1dHl0jR3VDyVNEFLQvZmUxihNfKu5496wXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l0SqEQ3zKOE4fEa6Wd5nXiU5XoURZmG/qyjBTsKnlfR8IttYw
	5ZHZsQcrsPvhVzpTuHZ1FjfXkJiV+Cv+u+M1tt5mNkOwU0WKmmOEmN4W/lcJkOoLK18o+pdfaF0
	NJQg6g653qk66qyNhOxKdqtudjM2ZUVGMsj2yLPVyrJYp6FdqrXlbuFlio+Q=
X-Gm-Gg: AYBFou3QyupXzBBkxZCPkOU2Y7ahCie8zePl+C6jp3HlTQrGdjRtniNyafuV0gOM1N/
	WDvVptq5ZN9mGjw+0/SsPttzZAKFa9DT8eZ/kYA6TT6w6J+eUQibUoOEBxm8G2MbQuqyLaTgttK
	9KXk5mVTJgRO6EuplJotv/qeUQmWpHNr6ul8neh5YKZ3M30wxueaAdoh1G77N4K0Z+pLa51HEDn
	zGWRFbhAV85/W7K5ms4ok2bHgEgsB5fBw/NKI7oiUsM+nh5sYkoOtKrG8ALA62X+rPTUO3qpc8j
	3jEq3gkSESbjnhfPUmWkLzeS6/0mbpyhLCV+TB/aAPKz9FthYSMAsUXtBMyKe3aSrqy8JNmcbUg
	mzbBqIhCFybnv4sE5jXpUzfL2sYAUtvOVbkB+mqmFsk3JxTMQf50/nUaMDWdzO+dCvgWnEbHOdT
	MI7O4Fjw==
X-Received: by 2002:a05:701b:45d8:10b0:143:26eb:18e9 with SMTP id a92af1059eb24-1b3c032d6b4mr1818512c88.28.1794387960073;
        Wed, 11 Nov 2026 01:06:00 -0800 (PST)
X-Received: by 2002:a05:701b:45d8:10b0:143:26eb:18e9 with SMTP id a92af1059eb24-1b3c032d6b4mr1818486c88.28.1794387959552;
        Wed, 11 Nov 2026 01:05:59 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm16915277c88.11.2026.11.11.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:05:59 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:35:14 +0530
Subject: [PATCH v2 1/3] Revert "media: qcom: iris: use disable_irq() during
 power-off"
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
Message-Id: <20261111-fix-disable-irq-safely-v2-1-8e13f68c2ef9@oss.qualcomm.com>
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
In-Reply-To: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794387948; l=1211;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=OJRJ4n6Rjp8IwVJxm+5+cJyXLWroXFMzWgufd/STv+8=;
 b=OTeb3Fut9eI17/5ZEOA+56fDKV66fy8SrYjYvNGchCAucQVvQ/T0uPh0FhK+1CLl3eSZ74GjR
 FLwQB8Q7PQaCSEcrYuBLpEqbE880dxOT65FHw3rnqWpKoXDymmadW+2
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX9PPVTKOxEEIo
 SdbJr0NEvEs7zgHe3bU7Ys3en/WivQHFRUL+9wTM4mPQ4JO1PrFLyWYGJ0r59doa9K2l4uqqifh
 yN2MP+7oLHfh9ZSqnl7Z+p84pn9LAgY=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af42ff9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9tjrYt7ayRFslicBUeoA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: ryCVqjnKsfkOiNsOXxMm-CNPqkVvEk4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX1/vJDKb0+2YT
 fU1bgJwEwIPIBEcCnKp+/i/1AqDL9DGsoeMw6ddV7hM7+tppYA3JoUFNM2G2Xinac6NIFGZ/Bjh
 17PiUl2f6Bq7suOvNyF0S4MjP/PtghxSjdttMEN1AR9OlfBSB+K3jS8G/Bo+8Vdq/YbHFpiWTGD
 Qhd7pGtr/bv7CmLw8RXYL7s29p4l68dpmjeECABdTWgLgDXk1s/KhmtBVBUASThWFTzU97T5Hdl
 6tSb6R1oBXbnwephXNdZzpcXfdE5jO4WKNaHqMmVBclJN0yYxrQvKfnnwAWaQqeBBI4H+DGB6ot
 yet3fftUDkDZ+K/vWV+Y9fQ9AoxaYdAqxmcF/+C+aiwnZ+4TCVs31CO1QQjILuGbH3x7Rb6xa4o
 YMWCrGxQWoB8BKb26UQJCPS7qNrHPWzs3tTmyRc1g/AvrHvr8zIes1lULyLX4t1DzZHKGKPmLAk
 v3t4E35v9vNn5gkhNEA==
X-Proofpoint-ORIG-GUID: ryCVqjnKsfkOiNsOXxMm-CNPqkVvEk4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110036

iris_vpu_power_off() is always called with core->lock held. The threaded
IRQ handler also requires core->lock to proceed. If the handler is woken
and queued around the same time power-off is entered, it cannot acquire
core->lock because it is held by the power-off caller. disable_irq() waits
for the handler to complete, resulting in a deadlock.

Fixes: b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during power-off")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 243bd845349f..1e183fc4e58c 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -240,7 +240,7 @@ void iris_vpu_power_off(struct iris_core *core)
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
-		disable_irq(core->irq);
+		disable_irq_nosync(core->irq);
 }
 
 int iris_vpu_power_on_controller(struct iris_core *core)

-- 
2.34.1

