Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB73B05A5
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207546; cv=none; b=e9AnAgKE4c8ZuQTd4Kg7V1fiPsNelQ7yqmdSIwLF6On4ZlyfRPl1OOUP+3h2irx2eeTzo09YwvfaAGRsvVnToSkYvMyeXFLN/6pdyqg5FZh+rLtVIUxO764dZqLbK2kO88iTBMsE9J6pAoazRUl52P0HtTgTWchqkkNUKfxh0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207546; c=relaxed/simple;
	bh=7xhhEFhc5FWmoihtNUDA25SO/91fb9nkW+B+vD2NgtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bH3v+duz2TYcFba1Qqp/rvpS0y2nzOL8E+eVF0qVF9c5olI2aqP2lvYIIReSyiDsDHNXp1z9/eqVzPStCXpV19sBGhRLKkW4CvDxWdl5IrAQgnxfc+49vsn06AEcbE5SAqvaXyP0yzHUQ7zPb83L4554CBCNKD227/ZZ1JCsWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H3/k3i5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aExotiJA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H3/k3i5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aExotiJA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H30cgN3780570
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u02s+P4ghOqE3a7TA/QqWu
	rrs+yx0It5QXRpILne/H8=; b=H3/k3i5Dxk2csuDZKNrdZv1eK5DHAZsBS0LAeN
	NtHWYq7vOqYYfG7qkInCu6cL9m0jUZFCowProXkeuWdz8vRRRLxOqVOiJ0iuxGlO
	Q9U3J4a7KVgVu7z5dJyUjkolTLMMiSHMFm6GoD04Mb+u0Kmp9uGlcqUBi3/tuCAU
	adk6JWlWsL19X821YD/XBxTVAepnxwD4kDnmV2my11f17hDmpTVuzQHjdr61OQ6p
	QU3qJ5LpZfaJ8N+9pOD29UUV8aJg9/DoV1g0ZwweHPI1+RdEOYc0z3ahSfrSbfoc
	CAmoYOCPi43uxnl+T0bVg9eNWpH4Y4wQGUJLckkkl5V4F1pw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0bgg2qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:25:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so2891377eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 20:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792207543; x=1792812343; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u02s+P4ghOqE3a7TA/QqWurrs+yx0It5QXRpILne/H8=;
        b=aExotiJALFDY3Kj6ECIEeQOzUQROdhOXEqOVpG9qpgQbEY7HwWWty4ty1bZNECQQm7
         BnQ+TI6Q6TxnGcjAiURGFZJUZALrCHVBSin1fV+aHSsxxRyZR//mMHytnWMhqe6qgnVr
         3/qJ+lf//XIgBaB7/xl3IBnVIZfL13t0ttaFoGoaVfs1gC1iP/PHRdajG2mTwY+/AnBN
         ATp1J9tcNk9UaRxOC6fcgTmyJHBf977Sq0psVyqJP+9mImhJD7kVhgeV15GCItoQbnWz
         s2qo4SkJH1jqL4SqVe8apHyWxFLoAJvfEq4eV/ccPO9Z2MlWUWgBlGpidB/qzY4NWcVK
         0eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792207543; x=1792812343;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u02s+P4ghOqE3a7TA/QqWurrs+yx0It5QXRpILne/H8=;
        b=c6BIsco0ZiFBCwze5caOELeIySrebBGe2CvLIgOjrwtj8v4pwynPJY4PvLjAFKPN6Q
         RSmTdlS2DZdtl1mXNEFHjYWcGXyY9RSfw/L7P77If/7TzJ62Bix7HkK82tdt63yvuGUQ
         /KV/4uYtu9aBXlSboDUjMaGzKuWgRk5yWtOKoX5A7EgHmJ8tYfs7wau1L9snWAQ85od5
         M0f2asKxN+Mr5dq9MURq2X0JaALrPO/mtAZa9uU287rWr+VjRaM3MTHSdQJMoZlhlSoW
         k9Fm96+6GFAQWq2y/KV4MxGgqDFqK8dTlKhXQ44rgXzEC1cp6gZ2Rvsjgx/6E1qN9zEC
         sISA==
X-Forwarded-Encrypted: i=1; AKwUvBxYidl7NpZERwZYi8LIFpValNJ7BKt+u25vxCCc+0uoK9Rk4jIQ6z1TycRj+d655HYFM2uGC5g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLo2xfRR6gqBfXYqQAH9v07pu7nm9XF/G3S6K/uuf0cF5p6UGDo
	lPJC9Yk7VEQA20WswucYqjN0TUAUhZ3a56d++OfdiH7RdOLYfwngT/J7hOp/f6ycM8siTUvscNc
	O9J1qHkC0IMFmYfT0gB850U6hPC05lF5OihhTFd2acKVsjwCcMiN0kg/79wQ=
X-Gm-Gg: AYBFou1ZhDOhQF7tGnkykCb0K5A6Hnf/kj9H17FZIBgcW577dg/VqRb63GUID9ZOhHk
	OoRd6pTJvyVpw3cAXZZpRxNwVA/aJmfOogt/3PuavH28Z8P+dE9tID3t7giRiW4+9aaiRr4WO4I
	fApj/3fZwIRAms9PpV0BGQ/BA1UtPyN0G7fG9lnG+oZyxvNV27nfaN1KiyddXPp0ld6bOiayEFg
	Rjw5gJcTdk5SPDsH/t8hH9au6XSOdglVwFpwCoYT6nqhy4LC62eZWSJ3UJnp2fQ3tKsHE0Q50Th
	pxbF4iqp1NtW/JgZVJ2CZ/4wM1ISX3n9rg/8QNrIgIoqAkchwCU5YSQF9gHHiEVKi5BUEbiCaxO
	gfRJqfO3tp2mO4mmjopK2cJGSZfLodINsxA==
X-Received: by 2002:a05:7300:d10:b0:35a:84cc:d941 with SMTP id 5a478bee46e88-361a341c8e6mr3151664eec.37.1792207543143;
        Fri, 16 Oct 2026 20:25:43 -0700 (PDT)
X-Received: by 2002:a05:7300:d10:b0:35a:84cc:d941 with SMTP id 5a478bee46e88-361a341c8e6mr3151628eec.37.1792207542597;
        Fri, 16 Oct 2026 20:25:42 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm19471422eec.24.2026.10.16.20.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:25:41 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 08:55:04 +0530
Subject: [PATCH] media: iris: Fix out-of-bounds read in timestamp metadata
 fallback
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-fix-oob-tss-v1-1-fb86f4cabf65@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI/q0moC/yXM0QpAQBCF4VfRXJvaWUV5FblgdzAurHaQkne3u
 Pw6nf8C5SisUGcXRD5EJSwJlGfgpm4ZGcUngzW2JEMFDnJiCD1uqlj5gipfknWDgfRYI6f5qzX
 tb937md32JuC+H7iOGupvAAAA
X-Change-ID: 20261013-fix-oob-tss-7d317d612cf0
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792207538; l=1952;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=7xhhEFhc5FWmoihtNUDA25SO/91fb9nkW+B+vD2NgtU=;
 b=LawpIaPxZ27QVFYN1j/PsdMUYUkUeHcxEYZbhURka8kqTxRctzFKAWtptPpfe4EX8OKt5hOXs
 ET0PEj6Z96bBvC4eXFG2cwmtERy0NzJyjlMDG/9euQp9JG5mBlGyiGT
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAxMiBTYWx0ZWRfXw6QXibVyGNAA
 fBIYPHPcuv559+ymPJGTjNXQ0Fs06TlIsjuvB3ExzIYrWiFAmRydA84WVa/P00hNDSLJ02ZW/tB
 rc6tLuj6nuA0LFK0QK/rftvpj7q8cvw=
X-Authority-Analysis: v=2.4 cv=FayiV5+6 c=1 sm=1 tr=0 ts=6ad2eab8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wraWorUZ4TRzSvnLzhcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAxMiBTYWx0ZWRfX563sdil6NUB7
 +EE9j/9w90qvrBYpv/gPjmRLoj5u2yYs4Xntx+qoFfQ0GStf/jVjrT0E9wx4T/wXJZBqpqvHaV5
 05Y5TXFb/eb9zmbGVDEC6bhT8wPcDSqV5XS4cXj4NutDFHEs+pboNxFRvmSWHUmFC+FVvx6kPqV
 8qeHoI5AdfMjKp8Rikq531g395UKz1XKMa1RFhrSaLDdT7+svxFmIhXaVEHjDCn/sYxhj8Q43Cd
 +N6UsDTiY1uitv/pjkk1DMybtFHEbj9zYNckHUnAACqBIj8ZdZ93Ydf4J1GQXXFoLoHFnDw7AAd
 tnup+7OIImfLM5fYCiEuOllPmvd/Cl7UyIyvf49QiSsfxFoL5wKTJ++dexV4AhAeaJHbLQA1D/B
 hl3ZubGXaO3552LaSStL5zCJCWclCXnAJy0bNwpCEHc6V87pOfcywgJGzHFcka5xg8WMSaTnF74
 2VbNEvCns9jhl3/eWVQ==
X-Proofpoint-ORIG-GUID: y4IY4at8UJyTq6z38I22GK2DqTuftggn
X-Proofpoint-GUID: y4IY4at8UJyTq6z38I22GK2DqTuftggn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170012

inst->tss[] has VIDEO_MAX_FRAME (32) entries, so valid indexes are 0
through 31. iris_set_ts_metadata() writes at metadata_idx and then
increments it. After the 32nd input buffer, metadata_idx is 32 until
the next input buffer is queued.

If iris_get_ts_metadata() finds no matching timestamp in that window,
its fallback reads inst->tss[32], one entry past the end of the array.
UBSAN (Undefined Behavior Sanity Checker) reports this as an
array-index-out-of-bounds error.

Use the last written entry, metadata_idx - 1, in the fallback instead.
Fall back to slot 0 if nothing has been written yet. Even if stream off
and stream on happen multiple times on the same session, the fallback
always uses the latest metadata received.

Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index eb8de60c1177f..31cba99a665c1 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -865,9 +865,11 @@ static void iris_get_ts_metadata(struct iris_inst *inst, u64 timestamp_ns,
 		return;
 	}
 
+	i = inst->metadata_idx ? inst->metadata_idx - 1 : 0;
+
 	vbuf->flags &= ~mask;
-	vbuf->flags |= inst->tss[inst->metadata_idx].flags;
-	vbuf->timecode = inst->tss[inst->metadata_idx].tc;
+	vbuf->flags |= inst->tss[i].flags;
+	vbuf->timecode = inst->tss[i].tc;
 }
 
 int iris_vb2_buffer_done(struct iris_inst *inst, struct iris_buffer *buf)

---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261013-fix-oob-tss-7d317d612cf0

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

