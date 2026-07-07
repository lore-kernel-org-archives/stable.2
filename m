Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FF3A7F4C
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406152; cv=none; b=s2OIwaq/m4OEJd+3ThiIHmBXejANv5IteTFwtnQ8+q6jA8gpzb+UN3b2XZ6/SEeOz2uRW8Njv7YqOWWs1KyHSkG7s2AK6R7JOs048sQka4FamuKfdL8mAV50lciXGgI0Of17RWX/+lnWAX+PtAvCYY/xYZCB4ZlA46BGgXNc9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406152; c=relaxed/simple;
	bh=r0NQcgVWIF3QYqJ4mnNHJAILzS2N4Wgq7EHm3cD0oHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flrpxml1iwG0gBt372mjbGI9CH6emYdxCaN8QiQP8dZjKRuWisezDVwu2K7LkqVZizJrGp8QjwOa7d5uhdl7gGS5JDYtGK1f+95W7ngs9XcQfsUcDbgp92hNH1m/hahigt4a3ITfOSUUp0HEGeKTaKlJVQ23sjsFG6BTniNvKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mRdrq3NM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CEKYxWSO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mRdrq3NM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CEKYxWSO"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748hcR2449836
	for <stable@vger.kernel.org>; Tue, 7 Jul 2026 06:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1hNNt27jWnOZ+OiFVXad0UrkLnA0nIc+AMtFumubcc=; b=mRdrq3NMFT+VnlSb
	w6rT/DTseWlOJmPZUsJA07GNfNipWMsr0SdudKl0XZMa2ObJ1aHHB2C8p/JkOnY9
	7gheAQ2morNwNeQOrvfPzn89BMA5gZ9SxtDO/q+9nfOQ9oomdrkv3FAvmRpy3b3u
	69PUf20cmZD2+0KqJe52sruINhsBGJPxyy+HSstX3Pjkz9DmInogsaiyV8ARoJ9T
	vpgOlCPeEi8raijSMC4f/UXQKYyL8bRaIYfytdNNr2/+Tkz11Lnj4TSWAXd5/GmB
	2Vq3Bo5X6WtHFyJk9oNypiYzlFpBcKj4C700iCKSfAiDC3DieqOlVzVpKUZKXbeo
	fidEsw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su70gyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Jul 2026 06:35:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8479586724eso3373291b3a.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783406149; x=1784010949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1hNNt27jWnOZ+OiFVXad0UrkLnA0nIc+AMtFumubcc=;
        b=CEKYxWSOia0z7qCfEKuu7ODORi594B47VwJ/oWFjRratXan9IErVj5FNGMthj+UxwJ
         0F/EQEZtPC07K/x2nInLtMVCtKglf/8CqjfFNaC22VBpmhNqe0DYOAKvuDewYghYnBbT
         dHWUb3ZURdtv/UaxHVVV5izLmABl/MsMmwq5V8Fvr+ZRe5L8Yo6ZrQnsuS1mSj88cPJZ
         y1HFTRdc7pK5OmY7LIDxVAaPTYDG8KsLjwztwm84I3tEU9Bvwh/p4tXiflkBD/usFhl7
         wbrUtUegiMdxSfKq0evn2rMFXFT0xC9VNq+s4wTlFPa6UsTx1OkWVstFO+oGNXlNovMO
         Iv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406149; x=1784010949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1hNNt27jWnOZ+OiFVXad0UrkLnA0nIc+AMtFumubcc=;
        b=LEtzNJuHL9gf0IH2DtRBKyukoRHfcYgWsrjUsg+bmO/dSupncRz5STKbOvLoZ+pFee
         yvb1SeKaYfI5soOq4IBJKRjhRN62yyY+OCoHbAFfX/mJ0/5iX3XvSpXf77kuSs+UgX3t
         j4SaroXOeY6GII6psNcsveDIteoLf53zOuvQDfCxN9jifBA8+gEu/QnB22zpTcoszi0H
         fBwzJi0vyNXq8ZhgdYIT+DRqz+y/++jeb830bSslkvrbYoCWLmjFxZHVfRwh/W0J+N+v
         qRxgyhi/beoB1ePgwVDqoHl1iiqoHBRKxxsbaTN9p0hU3dkZzSBoqDz/XF3XqWUcbRgm
         7lgg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5h6qwFnvm12Q/rBDunHbkWMMiR+zafimI/a0WXsZBAW0OCQ88z0GgWaCQQh+v8gKHEP3eHqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1pOyG9UVlwMPoblVJBiRwbMMENKajhVZ+0h64Vea1QnQoDpt
	mEsgHiEYCJdl4ZHCYGrXidFadN0YaXxs6SMAoL83+ssP7UvjKBfReK19JjSNwUtfMbxIuobGueC
	vSRDrXbbgEKQ8BWDozwqcM/GVsfLde/A/S2BfD6i9D95yeGs8x0fgRaP2B3+9m6yiJY0=
X-Gm-Gg: AfdE7cmU61abClwNkHqgmeQeCWDDEtMBnYeOkYnAAi9t/V/2kKpzddnR72Mpovcd/5E
	R8hIcOfBgJlorMSmkOx6hOxQ7lnwp8Srl6B0DGSxnxm9wsqLu5ipI8y+8TJz9xEX5Lm2Kmjh/8e
	fvx1tKLLNAtqrmNt2KlKNk9E9sLqn0UPAcby80h46sZobA6I9JdoG3EgO7UPN3lktsMTDykRTmE
	GIsDwNnmNYm8dLJW/Fq54Dk9c20YficTPquJxNmWRyhhLO7cHtF1NCGGmlfULpLrhjLbPVvpCLq
	Q/Nuedu6gXGEMiSYYzuNJGVgIRc3049SbBO+cimO5IoWCgzZ2DqHeOENRJ0STawYLdujKhc2ac7
	5oIcxFVXQAs7MttQelNXsNpfffAvP2Gf8AsRJzn1Fm4nu
X-Received: by 2002:a05:6a00:1796:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84826e28b2dmr3860449b3a.35.1783406148992;
        Mon, 06 Jul 2026 23:35:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:1796:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84826e28b2dmr3860427b3a.35.1783406148494;
        Mon, 06 Jul 2026 23:35:48 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm4889973b3a.53.2026.07.06.23.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:35:47 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 12:05:23 +0530
Subject: [PATCH 1/2] media: iris: avoid bit depth validation for capture
 formats
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-1-33fa130bc535@oss.qualcomm.com>
References: <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-0-33fa130bc535@oss.qualcomm.com>
In-Reply-To: <20260707-qc10c_fix_and_disable_time_delta_based_rc-v1-0-33fa130bc535@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783406138; l=2154;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=r0NQcgVWIF3QYqJ4mnNHJAILzS2N4Wgq7EHm3cD0oHY=;
 b=YS5HcCYaIYKbnA2YywI0czjqnCJmNdxLlZ+W2pdvia8EPCS4vQVHLoCFE2MM9nQiN0XmHTWIh
 7q+B+yp7A2bCuLcXTBI6mN3HIW7Hr0KX3iaqo9/OFldGVZYJN8uvzbO
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2MSBTYWx0ZWRfX1Qww4lNt2psz
 l2qYlkuwMYNoRmvJ28f2H7CcAZ2YfDdSrUNx2lheX8nLf2ieckgZVrDh7dzD9ddVav7G/ZHagWy
 7LE+YW4MOzUI6fi9KIGoyYpyOuTqWNfsefiIcjEjnZ95+FNbn2g0ZmZ5Yw6Dy4PBAZEIXpLeO9U
 FVXM59bbML0h06EKSdS6qsd/E5UX9EvofcgTYOUqh6oEmDtIE/pdF2o/4DRWB4Z79RCjgSWoy0a
 OAn//vr9DVL77q/NfLGEk9jgmsQjJSXgumc/dcUddJ+v5eHTBaNQr6dSoqWCreWZ4vgIDDifKg2
 Qs8vc94OybuVKJlosb/wuj659FBJ7IKcPxu9sO+RhsINxFPlJu9ZQgrxGQ1UAcl4ZX2ooM9ihxv
 dvZso4dCThj7GSm/8y1KN9aEoS6F5La3qsXReF4wP7K6wvNbmWt8pgkhS/47sY1Udo4JUtDDpef
 eziT8y/afO/2l/8YmLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2MSBTYWx0ZWRfXwG95GziyqphC
 0jAB2m2SxaHseACJXWEhtECMS58mKjO3S1asb9zr5OE7QDAuZjB9dAjIdoABciw+qhP33thicba
 NzBTNg8Mi9UOT+ejOqOGsVAZ16qWbX4=
X-Proofpoint-GUID: OQxd8jKp7siARk0Xh6E5Bf_CbDmA3TIf
X-Proofpoint-ORIG-GUID: OQxd8jKp7siARk0Xh6E5Bf_CbDmA3TIf
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4c9e45 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vL0Q6q4W2X9FnyRf_zQA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070061

When validating a capture format, check_format() compares the requested
pixel format against inst->fw_caps[BIT_DEPTH]. However, the bit depth
capability is not available at this stage and it contains the default
value of BIT_DEPTH_8. The actual bit depth is updated later after the
firmware reports stream capabilities through read_input_subcr_params().
Because of this, a valid QC10C format request is rejected during the
initial format negotiation. The driver then falls back to the default
capture format (NV12) and stores it as capture format.

Later, when the firmware reports that the stream is 10-bit, the driver
sees NV12 as the selected capture format and switches to the default
10-bit format (P010). As a result, the original QC10C format requested
by userspace is lost and QC10C decoding cannot work correctly.

The bit depth information is not reliable during the initial format
setup, so it should not be used to validate capture formats. Remove
the bit-depth checks from check_format() and only verify that the
requested pixel format is supported. This allows the format requested
by userspace is handled correctly.

Fixes: 20c3ef4c7cae ("media: qcom: iris: vdec: update find_format to handle 8bit and 10bit formats")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vdec.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 9e228b70420e..7f89e745a4b1 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -95,16 +95,6 @@ static bool check_format(struct iris_inst *inst, u32 pixfmt, u32 type)
 	if (i == size)
 		return false;
 
-	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
-		if (iris_fmt_is_8bit(pixfmt) &&
-		    inst->fw_caps[BIT_DEPTH].value == BIT_DEPTH_10)
-			return false;
-
-		if (iris_fmt_is_10bit(pixfmt) &&
-		    inst->fw_caps[BIT_DEPTH].value != BIT_DEPTH_10)
-			return false;
-	}
-
 	return true;
 }
 

-- 
2.34.1

