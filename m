Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF303B4E9F
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069663; cv=none; b=srwtuH56lcznHaBxKJhPlo/9SMrvOYmdQTtYTNYU1h6EMKgvGRwaLBOdsIQF3RmyD4QBF2mT0G5sLhOIRr4LTz0rS2vA9PdwDxrBxbulGw9sp2cGup6WZRSqCjMTIKVjE4Hy7+lGoyHX6xN4lvBx7iXKUvfdtNerDCkRGqRUNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069663; c=relaxed/simple;
	bh=JsClOCgRuCokHFBILVGVw3v/iG79Ak86Qn+tZASTVqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oHh6JqsJ7dNBeiY8UJJCslHq2VwA18ew6OMI4k0MNrFrEQaCmW1j8Or40NTJV7fbGDNWbFuJ0N5W9mKxuqjfSFk6K30fk+VaUr73uVIhBjIjSLKd5YJrALq/TfPUxt4dg7S+98hXKQYY9o0D07ueMBAl7D6QYogAvAUXPR1U5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5vCziOs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUZyxOM5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5vCziOs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUZyxOM5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE0hGG1327104
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eTaebYlrfAJPUGWuNXgcKa
	Ex/Nb0mBGfG0xk2KE5N34=; b=k5vCziOsrJpUaIfV9SsS5Mkf7A9WyOOKEiMBEn
	TwYUhIBwl+vn4qumZUKqWTJ5tHF+b9txeEWrhMuKZ0r9uk5hKEkgv/MLkqW0ZcyE
	6SPUYZuLfDjqLOGRgzPbyzvRtowSLbNjHE5lMveNxhOUG3ujlXINKKdSdBeS/IV+
	va9hIvqA8g+N6102/EGbqSzHLCzZcn5+WOFbwoG01IWKwnztp6sGiljxCyjgxY9K
	kPrZwXwORtvl2m1Lad99AcIdMKHNqZG8ho73CW60gpuDCTSLzEWrxmg8gW4nwwU+
	wV+8XeW6Rw6Ac/4OXRB5exo1VvnQFaJM25E3po+K/JVIKFJQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p325n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:14:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedfa3898aso4776626a12.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787069659; x=1787674459; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eTaebYlrfAJPUGWuNXgcKaEx/Nb0mBGfG0xk2KE5N34=;
        b=ZUZyxOM5bCGH3QnIlJo52yxb8Dt//OtwTJMvpAm3cbAnOSYorfmUouYGi8TdxIaGx4
         muK+oS+KK8WJTHzucN+Gg618h0Vhp7XjvGZ/lohwsMNAh8czi5Sbu+qf5+75aeBU4r3X
         tXdWSnQNaXCWhOyMqzgA2q237J2fbm9RIBQbdV2SOczf3RKhAJ9MXsEd0tTFJ0rYc8NK
         lw/vNTuUUazbMF69V/mu0umkScGcdAHBtjqrtKVZoH24N2Abbnu59GtQIsUhf87WFVlZ
         sz2Qffzbmc6x3Fn2Z/nc1cDU68KQpNtll8CD+AP+dXqd44bYTYAngPB37t16NsNTcjWH
         wpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069659; x=1787674459;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eTaebYlrfAJPUGWuNXgcKaEx/Nb0mBGfG0xk2KE5N34=;
        b=MJnp2jxKKRLcRS9qvrsSYHh/b4FHMVG6E8LnDcIQJxnP+L7hWqL1aV77UJtnJY8Md+
         492UCydePSVIMvyllb7PyrHp0Ad2ebZ1DknvfjkFJ+RHl/sVAzvtheaE02qfeYTbZi3o
         16/MZlFkgWjFQN66CFdIh5m2PMVLWGrSbjTicgric9Zn0EUoW2siDEolHAlagb+k2bBz
         xlU+pcFKXuI5zQjj5HC0W8jr0AQP6lwleLLeA1spOByrNV1pFAoDc5SuKtktJ+ByM250
         6c5Jiv1RZi9/oaL5vywWea5jXRBUYgKZcz9l9b/m8kZ4gTZ+9keA50eHh0cHc5aB57ru
         lRLw==
X-Forwarded-Encrypted: i=1; AHgh+RpKAEtF+DuW6wfuMqhIYp3wPjqraB6gPB3Mh95ru+TwfR2rQeJCy7EE3dK0trKoqXb7o9P1ack=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmBveMUXyMB1kquDyMKgZu2+ilOXilUkPmtYJrfpsyeXif/tz
	ZN9t3m2fp9uPQMqJMCXhn6pHlO4QO9XQZILtisqfrWiY6EP9dXyR82VApxriYoigY9eyLlr/1dJ
	8iDFGF9JClstlNFksBi+GsK63KRTW5gc7X6K/HSU4tBK1+5N8VvJG3F1UpKk=
X-Gm-Gg: AR+sD11RSYXRY0pA2KxIDEGiSTIKmnIek0SqFylTq0QIOyohgGuKgLkigeZ7+FI9OGG
	e8lSHQRQHNgloifhfYCaz2zJSgvI9l46Opu/uPkiJcMJHdy4u00ZzErHo8sQg53DPeiJK7JSlaQ
	UsAGzXEQ5jShbq27QNCHwM/eWOeh2ZTNyl5V4UVCY3EW4UMC7wO9EmNGZt/Y9avuaB7BDNJ1bjA
	u3u7jh2TEuV8CLQ3ZrH4+prXPNesnuwd60FzQ6DpELwx0yejvQPG5tSrZV7ZT2+vLGbgSKJcRet
	HtLadH8AIzWlf0amwcJIqB/KmrG/ARfLLy1kwBRnTqTg3r/dQvjJqoZK5aek06VfxG43cVXu3q6
	BMdI2NpzUCuDtokVubHGqWRm6CTSlw231CA==
X-Received: by 2002:a05:6a00:2d8a:b0:84d:ff47:fa53 with SMTP id d2e1a72fcca58-84fddfbf187mr34504811b3a.2.1787069659395;
        Tue, 18 Aug 2026 09:14:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8a:b0:84d:ff47:fa53 with SMTP id d2e1a72fcca58-84fddfbf187mr34504740b3a.2.1787069658972;
        Tue, 18 Aug 2026 09:14:18 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0fd9sm1692482b3a.45.2026.08.18.09.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 09:14:18 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 21:43:51 +0530
Subject: [PATCH] media: iris: Fix bus_info prefix in VIDIOC_QUERYCAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-v4l2-compliance-fix-v1-1-77f8076d5ca3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL+EhGoC/yXMQQ5AMBCF4avIrE2iJZSriAU1GKGkRSTi7orl9
 5L3X+DIMjkoggssHex4MR4iDEAPtekJufUGGck0UkLhkUwS9TKvE9dGE3Z8Yq6aJM5EnCrRgn+
 ulvz8Vcvqt9ubkfT2puC+H0MtaPF3AAAA
X-Change-ID: 20260818-v4l2-compliance-fix-98b43713681d
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787069654; l=1538;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=JsClOCgRuCokHFBILVGVw3v/iG79Ak86Qn+tZASTVqs=;
 b=snLPWCq3gwplPZ5mg8MMB8elV9akZMO5CI3yHMc4MXKmAr2TOzVmWT5ljSYh8LbK19PfJMP7r
 Shwmo+bTtc6CqA439qxGUBvfmFxUQw633ss7iTkz3GaLq3hIR+6/5Gz
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: VLDjvJwVBz7g3D88DIxzJiury2i3nBaW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOSBTYWx0ZWRfX5qfvKoDVW80o
 NInf5fAgpkL/GC9R92l/A4jniObtd4mmCD/7QO7j+caLq6D5jcoD4oCNlbI0ibufDl20rSgZaH4
 vfpLmkS4YKTwEQ3UvmuzCvEwLm70MMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOSBTYWx0ZWRfX/HS5KPNnWtb2
 brz/3ie9su/uBGDaETxi40MfyW7Fh/qWEulvnq1ti7VnA4jW66ds3IS1cGQnfDjDdHM6+DA1ybq
 anoJorZ/7KDDOaMS+9OFEauzsOCeu8iME++6ZrqQSUo7pqM+7nBxwd3XCiW7B1D69LjhLQ/q5Tg
 noPTE6b1+IAnuoMtU7GALertMQ0ZDJCaZdp2EWa5/mcJAkuKIYRwInhqV1Xbzk+FrgmIYAL9A1v
 ajLd0t0wJEWuAq0c7weUBl70SPJSso4IvXVwsncQ515h56i2Yr3LV/2g0nfbFBv6bLLKOYk8nBB
 q6nps01LtXJkQRrE03oK+CUofUka2yz7JphPmEJRYlbDzYa5QhZ4M3P4ROTOXJF5/eaiF5upuTL
 wkw+1inHo8N2vZ3+woMP5IEkmZQ4kGw0JlT6JQD8HyXtQI9kpGI0kI6OsMuoy9TnXnoL7IOtBiK
 GxSU8u+0oCR49YcYfVg==
X-Proofpoint-ORIG-GUID: VLDjvJwVBz7g3D88DIxzJiury2i3nBaW
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a8484dc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lPpRzfh1xTU8B-oGVbwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180119

The bus_info field returned by VIDIOC_QUERYCAP used the abbreviated
prefix "plat:" instead of the standard "platform:" prefix expected
for platform devices. v4l2-compliance validates that bus_info for
platform devices starts with "platform:", and fails otherwise:

fail: ../utils/v4l2-compliance/v4l2-compliance.cpp(671):
missing bus_info prefix ('plat:aa00000.video-codec:dec')

Update the format string in iris_querycap() to use "platform:" so
that v4l2-compliance bus_info check passes.

Fixes: 94ef75095d5e ("media: iris: Enumerate cap->bus_info to differentiate between encoder and decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vidc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index fcbc60016bee..d39ac71a25aa 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -466,7 +466,7 @@ static int iris_querycap(struct file *filp, void *fh, struct v4l2_capability *ca
 		info = "enc";
 	}
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
-		 "plat:%s:%s", dev_name(core->dev), info);
+		 "platform:%s:%s", dev_name(core->dev), info);
 
 	return 0;
 }

---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260818-v4l2-compliance-fix-98b43713681d

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

