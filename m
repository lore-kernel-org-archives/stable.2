Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8737F735
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694605; cv=none; b=QQIX2lzl2LWY9MpaHusjUX/StwjpEYxzeooojxIMWF7OwkdMcwRC6hUiI0Kj6UNeWxSskSGCZfzn5twl5/0+n0jMSH85iPjWtr678uqydHTcQTJKCK7BLAwsWcMpSFTpye3YRbUaF2Vmm+x2n8UmJTCtKSLn9TMTo+JdL9/YL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694605; c=relaxed/simple;
	bh=52B24ThLasG7ILH6XLGWVM5QvgN0HgqHdtoVZWaDgGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GDPRpsKt3byvV6M1ENf0cjnGfQU09KJMJy1Rz8zu45R837Cz5wzooyGA/43e+L7guEMv734ix9zvdqvvtgxPqVXDV2WnHkwMCDnupTDkCgsvI6TRXvtv3r5AWmy73UJsgpZaKGcvcoz1HulGyooA89oHEb+iQHl+t0vw9I3iyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MA39vTZI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iuoLjRlw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MA39vTZI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iuoLjRlw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UZ1d2217816
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QZ2mTLAzuiOBLJIxRAjahN
	Qc8qbCeWGYALyMP2niXB0=; b=MA39vTZIq1wL6cmf3l3Vx2BsImGl+anCypF+Vz
	SEVpuUtgSoxlwqlSDbXDrVWge/zZeCp3Q/KfllwmJ7QyUcXziVLsMom45Ktech6j
	JJmr9DFhncXtwgjtz+jrXWdrBNy4nR9H0kMg6x+qBLvJxMyvP22q8mi7PPMeLlX1
	KO7ArEbch2fgCFJ+NvbozKJv+9rd0+rKPkljBUmTLiiR6O3OaQaH8Kk2TQxIbhD0
	zAIxwqPfWtYzK6JEioy5uvJlpuK12/Maz7HOx6qCk3NI65+wwzBIUhAv+fuMH2yZ
	YxzWDhL+DGJPslkEvtzo7Bt27tIjL2X9Q7G7LmSYJTij+l3Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueeraukr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:10:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304b8d0ee63so8601847eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781694602; x=1782299402; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ2mTLAzuiOBLJIxRAjahNQc8qbCeWGYALyMP2niXB0=;
        b=iuoLjRlwxBUsb3+WbuIkXPEc/J36Z6BJ//JOZ832FgKis47/dQqiQISCWu3V5hN+X4
         uqz5tqa0OzkWvkxmNX8xkxsgdiH96F8dtUinwyJTZZgmXILGyw19FhO8Wi42fMq6mQhj
         Y7V3lDCzk2pcV8nXst/53qEHpaVvYSVqyIkCVbvoLT2YwdbkzKSeGrqP7LBf+/lj4MBp
         ZSeo5VWtInsWUFtte3mZ7E25wpuLAbx56XxfQ2Ifgpc6qUsbUXeL3SYOeU3+G/qlbMCr
         OuOTPIVkznII0aBfNOl3ekEUJy5rq1Cn+7kP2yCmRjWSo+A3ROU1/tlV0v02iZ1ZqR4G
         JyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694602; x=1782299402;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ2mTLAzuiOBLJIxRAjahNQc8qbCeWGYALyMP2niXB0=;
        b=sj8oD2ehVg5oJj9cnv2owQe2JLe0CTb7AybO4f0LGjqk2M7iIvW5+9ZvX2skDjRkSx
         V4fWK1XzZvd6xHWqhU+9BeIj7vvF0avuVD32EruuPpRYU3AwYplGN3+ltCunrTqSNezk
         18GIUTrR5b5liRoaMf/oyEdmePLoGyn8OkwBTitGS3PSDj/gUSLMzSINJq2gpV488M3X
         b5rqFRsjvKIifdJj9+f94OTkA5kJdfdNmaNkUpCrFv50h67DToQU/uWqLzBY+eRdMdSD
         k6CUBp9OJ80O0l2fXOR8KvMcybwb1lnA0Q88OWMLgubVibHZC6I7Ss2wCQSsOyeUbTUV
         TBVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VK6PujErTaf7RMTpRPce8Q1+S2ExlXKnlAMDaL9AaiU7KUrvbrHyaczSJ5p0fIdzTmmue11c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFiLqDIGWRiYSq56pjCD7eGPlb/B6ZH1bd0/D3aM4juYmTywg
	gAGwl2zgjMFPkPjvaST9EDDKsweaZIW9Lwx22MsT+cIUu9Y6eQFISjxqRWJuHkV3mXbjegtvf2x
	BeKAOECP9NhQFf282TgD90FSAD5dsZaZRYkQ0y20e4Z1mMgUKYUc79spm4gc=
X-Gm-Gg: AfdE7cnInxX+DHz4mTGjANshVMK+TYqZAlhX8diJ3HZDtvI4f7cn/dW+kiIVqWhjA3P
	4ReUho06hME9eZ1hCXL0NzfxygFBdNGX25SRBl0cFsHxpBFwukQqBpm7tg3XcnWEyrumYuuOJn2
	eyoZHoYvVMMuhR642VDeX7uYCbwd+9mxQFXdSB/5fhPXAbbZjal7XQ7s6U7IJrdeOSrShNRelbJ
	8M7iUJGj0oH1zgJnhbAI1TCYXVffF6p31Jx0lsEIBTxHqGl/bn/Su44sUjtkX9w48YazyB2TQ14
	ddzZ9Pz/BGz/49qvIc+d9IcXCGJivfHt/V9xkCV6j97B2QQlCIGfIohIRGA8Fl4ls1uqkGIVMa3
	EVDCO3PJ3onvnzqQPJgycUVYVWnSXu0L+GAqAiZA+lXtlnDyuB5qdoiRJWMo=
X-Received: by 2002:a05:693c:20d2:20b0:30b:e525:4702 with SMTP id 5a478bee46e88-30be52548e7mr127250eec.12.1781694601911;
        Wed, 17 Jun 2026 04:10:01 -0700 (PDT)
X-Received: by 2002:a05:693c:20d2:20b0:30b:e525:4702 with SMTP id 5a478bee46e88-30be52548e7mr127243eec.12.1781694601350;
        Wed, 17 Jun 2026 04:10:01 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bd01b768bsm2426972eec.13.2026.06.17.04.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:10:00 -0700 (PDT)
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 04:09:50 -0700
Subject: [PATCH v2] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH2AMmoC/4WNQQqDMBBFryKzbiQTRG1XvUdxEcdYU9TYTBSLe
 PdGe4BuPjz4/78N2HhrGG7JBt4slq0bI6hLAtTp8WmEbSKDkiqXOaJoNQc/kSAKq6De6HGeRN0
 2Smpd1KWWEKeTN61dz9tH9WOe65ehcHwdjc5ycP5zehc8en8UCwoUqpTXIssyxJzujjl9z7onN
 wxpDKj2ff8C5msettEAAAA=
X-Change-ID: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
To: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eddie Lin <eddie.lin@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNSBTYWx0ZWRfXyyP7s+RUYXMl
 +q66VHJIlylPfPbo/ji4klqq6JVqPvV43/s/woHb4MIWsGOcERizCuND5S6AVoYkrC/0+Zr0DkR
 vJ0efKEm4bh2Bx6e4cF3DQu2NL6O2KA=
X-Proofpoint-GUID: WbezBmazsP51jGVtUROo8NsxbJruG91s
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a32808a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Rsn1OCey0fvCUy5VNe4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNSBTYWx0ZWRfX0vzFgC7LhTsE
 1kq4eSTpV7EC4hBC0xDBGfKQw5juzSh5FmvnTPTNnNVZLBCoQxF2lKTfeSi+uy7CPaxW6B98tu+
 0+TBdYeHLAJyiQv/2x7TocTszl56/TS5+f5LmaPsQLTJ/9lkggCWSIVlrC5LnpLLIZlVKgZKuCV
 wwKO8LIRwrul/ySYrsu/v5ClZsGK1Kn6K3UfhA0+SS6bOzI9t4FRroMYgX2tfwOwSVMZe82ENkb
 nOpNR1Mz4afcQelJe1rZGxs/tduQFPB/pbQt6wT1ajWO/N3ik6vyrjT64N5ZbEeAiiFR3xNSoKA
 A/4uWBrsLe2RRTVQrb3WzerCg5y6HyYGwo1dftkdO4ZjCpehJVrPTWyGHJKOVlKaI7TfKhDn8GL
 4RQimfGh4iFDf9V+PtL/Tyag9VLumVHDpXh29+8Z4YuGtY8UwNkxUfgl3FRR5Yr2vcu/tcfIy+Y
 baYzOE+gP7X/BfXFHhw==
X-Proofpoint-ORIG-GUID: WbezBmazsP51jGVtUROo8NsxbJruG91s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170105

The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
---
This patch fixes a memory leak in the FastRPC driver by destroying the
IDR associated with the channel context during cleanup.
---
Changes in v2:
- Added Fixes tag.
- Added Cc: stable@vger.kernel.org.
- Removed duplicate description from cover letter.
- Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..7727850e9240 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
 

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0

Best regards,
--  
Eddie Lin <eddie.lin@oss.qualcomm.com>

