Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088770;
	b=kxrTuEDgDMWuaWYKnaOMefFDy5UCbOc/+e/aik7QrFewv2j5RiqZvbXGVE1wiGvJw4yS
	 nSfYQC6Zb8ST9EaU3leINNkIvxwPI0kdzl0OxuEZGJo+O7J+N7T3u8hh2IXsTGfRPHWxf
	 0QTumMreGtucfO/uaBwQ0X66aUJzI6OS/6wDR6eLEUxcyT6diOpZkAtF4Ngak39Nk8ZCb
	 4D99q6d8FK0SehNPy+KiUmW251mQKipZNYpfJLNKMP4PKjxNcSIih1SJwrDNY5/yyr0hy
	 DLQsAvDVPnaHk+alcGVeCBTshnUWDtetnhSkD3M7zt5aXASXmbtk2YpH/zKfqAfQzJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=;
	b=jANsn03YYVP09SOBKp8jle9lRuYhxG9MTmmBOr/xfmk0+tCB0BRxdP69LaQCtaEQoUN/
	 F4/XzYfjxG+geSShwR2ZTIq2pQjRMH5mVJ/ghF9lt9bKmhrIZwoe1YMAcgBcSnOzHFRRI
	 IrIko6Xa2NTKuB9GOg5HpclLvuy9F3lRBeHkfrgQ9/pi+v5fY9UI94iVilRp9Rmz6JTyf
	 +IC9h18MHGtwP7+KoL2ySHhHwoE2hcdjyk7A6WmzLX14Vj9RrkLPhiVxDCxqmvduEjez9
	 D4hMlYtyKKckJnrQUtR/cSaUNeu12sSt29YzD5TK/e0zWMd27tssPGd103XJgrLiMyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk2Wfyjq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AI2l5OzQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7D60A2602
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E7D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk2Wfyjq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AI2l5OzQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBjpvK1655023
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=; b=Qk2WfyjqOsdNzhvy
	JUjGzXrMV4EL89CcRva/75hT2gBy53M94wYUM7rHhZ3eBrgjmQlQr5BwtkwIlSbI
	z/JAcVGZNQgWTe4ZRg3hbXsrBhLWzAxaXRTXnESpvAQXeq7sfe+J5pQLMu+90hRh
	j9ok5yYH2OWHaOC8FGp37wo4CWmcNT01v73BCKXbOYniQbcPW/W3yMigODeUitf5
	yOLOFZgI8BscbVg1iNsdomdMihqi/zF7j+4tB9uUJ66RCamn4F/LaL3tdaKSQTFO
	YFCWKV74TgAxgV8KATWll+H1myxvX9GUd814A9THrPhC94j5uOBN1PN+SpA8eI76
	Q7rH8w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yghg8g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so2573528a91.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795088768; x=1795693568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=;
        b=AI2l5OzQsmStehqqf7FovbWLHt1lGdjFm1vkzqJRJdhh6uFcElkdkCoZq4V29CqPXG
         hw/HTmdx/WZVcqr95jI3nFjigjbZvEwYxVjUHUIrzgYdhYCaxjy4oiad5PaLYn6wd+Ud
         ZDahYoCBuu797nXhZw0GqO6c5jgAE9YYOzpJH9XO38Bw3fAh3H6xMedpC+hD6qnIRbi/
         Xio7YWZc5yrSoW6lLK/kmt+RLtf4KMY5WVIxvLgTyOuziAckFhFihn2Ja/34KerIg9ux
         O5XElY6Az9p7SZLJ7Lq+i/eb0QsmFz2JU07ucXumWL0MUp6V8zBs7Xy9ehS3EUCShC87
         GLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088768; x=1795693568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJi2Dix00w5C88YTCv3ugKsyJiJdnkq9AkYH94vYW1g=;
        b=ZKJP6WhrD5TUqxdYadPhtb0MkVa0ZGf6gI8cW+91oSF4DiG5HkAiZDRx9H/oU2UhzH
         MTjrNZuNPlvQbjgOCpeUNEG8y1x8S26QBLIq7dS9aNN0QmM/tJlvK8lyyB/hnWX/qw5Y
         KqizVcG2gVHN8+RSzj7Iox8zvonu9mCx6u8J9bZhpcnyI14JlbukBpUVNcGQmj8FgxsL
         uCS0Uur9heULKdRd3IHSbisozjA5spHuUujwjCwF4t+I/b+jYEQZR3OyucnHmmUQmisE
         HzsmNYU2elKEENG6vLX3JMXdmzmgJo35AIKdf8ZAVSTF8xhdNbt4SjAmk/MSetvp6sFI
         Ob9w==
X-Forwarded-Encrypted: i=1; AL+hErF/A/pZD9h88QIm3yfGTZOqY+V557pByA51TbeozLPasZ/vdV5w7XAv5z3NpfXq+s3C9KEZpmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+em8XwV7nd67Yt12NTfMZOt/9co8iPvJEEDGd69TgW+L7AVU/6
	Xtw3SCxPkwFMSORIg60hFDTJ5vEQFqiCi3+oYS9zStGIQnhSQiy1nn5SJNP58cmqZPBavsPJe7f
	dboJUrs2LXrqiySdk5eNNxttMeRmq3yw2k2YC4IL7AIdoSn2GOf3ze+xiAow=
X-Gm-Gg: AZFdTZepUVA+OYPKjMGGybfujgTI/2a25YBHhIjLOAXoCElCxdcq43NlSK2tvfQl3/Z
	hxSn2ssw6j63ff99aLaiZ5SSgHHAAgzK/m4I/haO6KsJ2TtyYspYyIZrzmuUJ04lzslctFGniRO
	GrRILRIqayjLYwi1MwWskXpxlCQZIVJxxD62VvLDfvgb14wANxRME//rfJpLT99eVba2iJzgo7U
	K/61ikr1V+ePZHHM9LCV2kBtT2Rz9hG7i4qSwOh3FPLldtd3bgPHI6BD0KSMk7NERTtvBoeJfv1
	Mcqtsf4TB2c8MT/iewjaOF1vC2I3pjeJMEQYrT0uoIjazXzROX1fDWnJlCRn6hkLiDzTzT3SAdx
	g+gZR3GrCCst4tHXctqskdkQ/JhiK9K4lUdf2gfG6/W9h+lEAADYf3WfIPwWPTJtBs0SGbz/uC+
	225IizDCU=
X-Received: by 2002:a17:90b:39ab:b0:3b4:625:3d2f with SMTP id 98e67ed59e1d1-3b4062542fcmr1235300a91.55.1795088768159;
        Thu, 19 Nov 2026 03:46:08 -0800 (PST)
X-Received: by 2002:a17:90b:39ab:b0:3b4:625:3d2f with SMTP id 98e67ed59e1d1-3b4062542fcmr1235274a91.55.1795088767648;
        Thu, 19 Nov 2026 03:46:07 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm2397030a91.15.2026.11.19.03.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:46:07 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 17:15:31 +0530
Subject: [PATCH v3 2/4] media: iris: Disable the system error work on
 removal
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
Message-Id: <20261119-iris-handle-unbind-v3-2-52d467a13907@oss.qualcomm.com>
References: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
In-Reply-To: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795088753; l=1393;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=mTtJUAW16Pa3NLyR5lT7gqKE4xsReqod6ALEVe9NOI8=;
 b=qzfbVbNGl926ns1jwU1eo1xUOzOesUEsM7o+cod4M4Q0qd3oUHRbO/obYdGhiGQv54XoopBD5
 5zc28B1tTIyDRgxNQSjQm8M9t1GmHC4teno/zUH2Gr7apB5AWqmwdpZ
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfX6EssKi6uJYpL
 /Sl8AcZwz3Eh9AMVImFrD+/b6beH7QbDKKm9VwtMe1bvDX29X/aPNb3wu/wrHc+eRGvAyRU5C+e
 N1vSi5QoAbWNwdGmZEG9liMQZJjURZ+SRPP2KlVal3Nxc4tFPs/KTk/avvTEjJJLcwCCGPbJLMJ
 SLwsmpugeaqVwUUxPwivc/Z+xehLxDe0qhtmr0S+pyTXNDTddMhtOYJc381Dg1DG9I8aLKrugoU
 31myEVz3AB5jVEPV9iDSoX7/LlNXZDFcVI37rwYEN1ED7zDS19CT/lbvDEYzDlEasdQ+fm//XXW
 bRZMLVUR2WBEbkY3XHd4dapWkyErkcr/kCmZortPLFu84VBbKvn8Ty/y1sYynARdTF3hsiYh/uJ
 IlHORDCgfJXotbvY3a0cZSOYKF8q5IROpldXvIyX/sEeMPq6OLz+igNXvEEAsClNH4Zas1SxwyX
 NmNH90kly7jEOf125/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfX3rk3y4BHU7BV
 fXItaj3RWeJxL57fYJcfN+urw5azsB67D44BA0Baw8vLF1EdQQ3VzhU7jMOql74nCS1o0dyaEx1
 BJN5CQcjIo1VOSRvQ6D8KCk+uhNmbCw=
X-Authority-Analysis: v=2.4 cv=Vvi2kO2n c=1 sm=1 tr=0 ts=6afee180 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bZa8m19-NPAJ73ByzVcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: ah3nFCQY-jIn7D7Dk94K5g6a58sVtJ2Q
X-Proofpoint-ORIG-GUID: ah3nFCQY-jIn7D7Dk94K5g6a58sVtJ2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190046

iris_remove() calls cancel_delayed_work_sync() to stop the system error
work. This cancels a pending work and waits for a running one. It does
not stop the work from being queued again afterwards.

A system error interrupt can still arrive after that call. The
interrupt handler queues the work again. The work then runs after the
removal and uses resources that are already freed.

Use disable_delayed_work_sync() instead. Once it returns no new work
can be queued. The work cannot run again during or after the removal.

Fixes: 452480931648 ("media: iris: cancel sys error work on driver removal")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 343e44c6b9c4..6f02bb629867 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -251,7 +251,7 @@ static void iris_remove(struct platform_device *pdev)
 	if (!core)
 		return;
 
-	cancel_delayed_work_sync(&core->sys_error_handler);
+	disable_delayed_work_sync(&core->sys_error_handler);
 
 	iris_core_deinit(core);
 

-- 
2.34.1

