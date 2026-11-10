Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319904;
	b=5qwdGN4FUHM0viJ68AcISI0xrXHnmkjCVAy/ikJqiflKaQ3XVvYinKrC23rtuBkI7gR5
	 MbOz/XeMO/N4gEQKfYQ9THGAf/PHq0/2p99ltEQCz1esxjnTVQakACkyZ8+DKdIFUekwU
	 PO2mo7AppbFR1dJSoyZ40ogPvFYM0QXfBFz4+d7O77rl+wMR1liQgH6jpfSnu27EPeUu3
	 IFg+0gVSLlNY1aHWe73b2QJRqI2md1aywA/5pg2jt4cUk3x7mDy/lFM1QhSpmPN9s95yI
	 /jSulIAvn0oJ5bxf4Q13XFyENzheT0XqOiELRnWtTnxjS4Iy60tPQvM0TyVZzJscYDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319904;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=;
	b=kLjylvNhwsOvJ4xXAzfs4QMd2EE+UdLtVYIhafDbMxsL4qQT6PKbYln0kL4NdCZzy4VG
	 zNoIViUR3eOmDSE1adin63jItxjahJnptkKudHX+a+Wsnr+LZ12irSJcz+z1JIcwxF2AW
	 pp5VLftDc2mo+XHueI+3P8f2zrz0DcFWD+2Rw1K0ZO7ZgQfvj28mYqxTZ8NX7t+lg+utI
	 QNQllGlce7EwcEmpNqwm90Sqz8vXcevitlUt/m38lWS83ohVtDYr+jTZ7m1rKCmVLyQ3u
	 Ep252tCvGFC01wskhVb+tLNTJCyec7hXazyUz6YYHKpxc9YOrTi9bF90ktbFbFpnC8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eC580CI+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BbqCjKeG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C74606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C74606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eC580CI+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BbqCjKeG
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAS0x2688392
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=; b=eC580CI+EfReaL+K
	QVb4jwWd8G+tjsJNPYyO/K1YKgPfdaAd+mUba9LUy0qDatR7/JERJ+CpZKHuT6le
	D3S1QRhu6C9rubOoVWoQpySfKI/KPzkJoxzpDBlDDhyYgZ+V9/0XmIvYn1tpKk5h
	YKAZs1HAB3Niyac1D9d4D0Dc3MLifS1ASJq7XzvCb9t6yBDBPb5I29TElU0nWsqI
	JylwUMG0RCoUgxTOCRRKbbvpERLmhT63ixMGF6PDCeJHcxLSD9mhT2ZNOL7ygZ+R
	n+eI3g5RA+rCzxXPtZWxehp+5SCVCxqTdzClXXKIlwGtiK8WknnDrTTelv5egwTa
	XJwLzQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp28v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37628596fc9so379010eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319902; x=1794924702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=;
        b=BbqCjKeGZ0pcVXJesBI1xFCKKjx8KFD9GzDZCet8pr4ZlrJ4QOVtYzpxDXVG1c09DN
         qltIxG//z6Ck+cmlMGZxWC7eJfHkjlTfFnqRWYcOeD4ADk5oYCWYu9U0IvrU2a6xESae
         JFZ+/wDS6ojSqq292YlYXdHNVRRINiw6QAWajsnhekl/QnfOv/MJrPcyXuEc5KsXb2I3
         7js0oJYj+znh3fGlpB5gUTUg/AE61UoipdqLYD7NTVu1Fyqs+VofLiobhA0C7I+Md7V4
         DQMFh1x5e/ZmRBtAFgG8k0O6jneK/71CEkCLr3SMYbrxX2NRszE3L9Fxw+jQDRXSH4Cw
         RFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319902; x=1794924702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0gDbpRYwXjrOiNSKkytD4TVz1o4q/cXx/36JYdIpmc=;
        b=BYKLj8VymENrAeiu0yZ7k2aD7FftBg7bZAJwuZV1R1QcP5uXqUbWfPWZD99bRl4Qbs
         JiA6nxHDpOKEPChjw649pH40oe1Ux7dS68kpN3O6x9xsnIe4lnAMeQ+LzWQPqQhYtCr6
         gnxJwfbJxVq6MSEg0UjCQltp/4mHAttqpiY4+0Km3wENjP33EiUzeSb6Hc6ZUpIXOJi7
         JUvn/UmPic8eC3YiSbs5MxwycTpxwT7WmM06Ciyolsp9umSsQ0hVil5BERt1LdXQXUD8
         vvwLylAMOBQbVXdbswP3aMAaHLercZUbnQSoEUdUtbThiNmYS76bdntQVlMtUCMXOnOr
         NPiw==
X-Forwarded-Encrypted: i=1; AL+hErF+Y3SykQvuzbkFfxtLHJaMMDqPNNGakZ7IgKMCezkOZd0Xkyb5+llMbNqobozFR/0de3uvpiw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j6evS+Qzr2C8MyXtl6JBdGRLpUvGqtCzYcZAUqJUriys1OuX7
	Rat0G5Wa5evjKIwrkZhkyIBvRfE+no3WOPtCsfS/E/DHN034fno20swWNynTvHNy1TBSKRZpZ0E
	qISpPSZOFST96MLyIDwaJo+vDON6dYaoGziZmJr5aXwoU8Q+ss1aTauLcnWI=
X-Gm-Gg: AYBFou1VdaDK847rk25rgGrNntWBgVqQsadq9O6UcFhSdP1URBfQOOfbMoT4VzJD+qm
	q3f3Avlb5FQjGbkheXeQcLx8OV2PYDTrrttxkF6RqsUvBreZVA/PCENpepmR5zWXY5LhEaBeBDP
	hYz0bQYgeSApU4VCFOozbbLx6TrkK+qNi01V20heBSfKzLs1ZCdjkch+RRfm40847eE1N8jxXG4
	SU4HknIpNDAAAsq6aab0FOiNTiG6p+a+SAd4sCfEBISWSiiUPZlw31nMtpr75qj/PhzSA5XCyde
	JZbqTeSyEZV1vJOOVLmPQ5N+hEyh9AtgEVOA3tcaiQ9vL0aDSqTHRIXLvurLgpH//XEiQoTC/6g
	GIQlC32laYqc1nPneH3LBxpA1Cvr+5iEzTdMtveKXl8nMQ1W77I4+CJyXejjNJg1x+4blojU1Th
	WQutyKFrY=
X-Received: by 2002:a05:7301:1a0d:b0:369:fbc1:89c2 with SMTP id 5a478bee46e88-3751e6ad1e0mr3517218eec.8.1794319902029;
        Tue, 10 Nov 2026 06:11:42 -0800 (PST)
X-Received: by 2002:a05:7301:1a0d:b0:369:fbc1:89c2 with SMTP id 5a478bee46e88-3751e6ad1e0mr3517175eec.8.1794319901113;
        Tue, 10 Nov 2026 06:11:41 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm8059128eec.27.2026.11.10.06.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:11:40 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 19:39:49 +0530
Subject: [PATCH v2 1/5] media: iris: Fix runtime PM reference imbalance on
 failed resume
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
Message-Id: <20261110-iris-handle-unbind-v2-1-86d5f6f1dea8@oss.qualcomm.com>
References: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
In-Reply-To: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794319890; l=1181;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=uA1DrNWOT1xdT5YBsROagD86Vd8Mo/RENc8c8k3PgK4=;
 b=FyWfMZv+1k1zNofMJ+HLQJe8BENlNDsQx5dvjhx7AKhywMc470zwo5xpeS3NsG7ngqswsEnVF
 PajrSZ6M4LyB/ckJfR0fAbrL4ygIeerwh4Q9w0BOIlywc3c6B/5lBSz
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: nQv1OxcOIKScduxf7-A0n84imWHCErBC
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af3261f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ohPow3cFOKvdjjdYMLAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfXyQkpPNW7O+pL
 Dvpy1ersJB1H6i5kslA1PNpFCtZAIYwSnHLMfAbOnYy3VTgfascxTb2RB5pV5rSoUx8WhmhZ9ym
 7fUAz0taOtvhy5DAOx1B0qJVbo3DZIm16ZTgGOy1kOEy6si9fLBeajs3AU3sRJ3Uk10F2+A5fpv
 ETJ+O7gow/Z6ZQTyJZyR9BS3uZdFUE6hf0q/yV9tChMfenPdmRdX1hH/HxXLwAmPdcUUoqZR5oq
 /fyzVPv1zp9Mi1oM1VwL7ptujd1A8czPq4j55Li66pGGx1YBG1oP8WxXTJ7i9XrtMUw/ZFMblQl
 WiZBe5rfEfLO3RNa2F+3djd/gpUt6+Wwrrjr4g+cz5/hQgaBDH/jwm0JmpGfHZPPwma/f7qC6Rl
 vX+HXKG0+3ydKO5W20C2vif9k4Ke1oknwLDEFUAdgCCVhhsP+x7ktpqNJfTAhqw4IMe9nMX2Br5
 QjzYEYCvk0LlfeTw/1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX2/jXGhQd+TGN
 GgiQ096K3LmF43JAeDCIKnMz1OdByQiqVscC/tV9p7QN74zs16oItvvORTKQQoGqy4N16QANYh0
 E7a+dSllctiWdWN00Lr0Iles8D8/Qvk=
X-Proofpoint-GUID: nQv1OxcOIKScduxf7-A0n84imWHCErBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100056

pm_runtime_resume_and_get() drops its usage count when the resume
fails. iris_hfi_queue_cmd_write() dropped it a second time on that
path, resulting in a runtime PM usage count underflow warning:

  qcom-iris aa00000.video-codec: Runtime PM usage count underflow!

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index bf6db23b53e21..545bbe75e1740 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -132,7 +132,7 @@ int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt, u32 pkt_size)
 
 	ret = pm_runtime_resume_and_get(core->dev);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	mutex_lock(&core->lock);
 	ret = iris_hfi_queue_cmd_write_locked(core, pkt, pkt_size);

-- 
2.34.1

