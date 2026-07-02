Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEE248F57
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958945; cv=none; b=jH9xB0ysMcjloHlonLCZItxV7S1ihAy2s4gNGad2k6lngkOR6ISWKikrRrpT8FV7Dk2Yl6MpMG72w/Pcz5PLnB3zGu5iR9eSGLri5K8N4YtygXPpWKEtX1DfxZIBEl6+nB/ChBOntA4xnSUZaNlxbG7zJ1HAvkh4RfW184sw+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958945; c=relaxed/simple;
	bh=Xcx6CVbzOR65UAneR1Q9ElsyhMM8u/rDhorB1CejVBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bXjuXHSP109m+VRySlUg36PvUYUcQTM5fBl7uYWp7H6BV+S3TTIYaxLGFGzB3v0Pn6SNWKxMQtmTYsS+KijboAg2D/zQiGZhAjul6ZCggQwqvjRSp2Eg32Gp+zgqyMCIR9GBDxRk/7rbyvtXYd2xk/hQte7Q4xIofWQvt0uctDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OFfJ0o1f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bSj7TslH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OFfJ0o1f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bSj7TslH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KXe03029119
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 02:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WuJiALMC/BGgUNf5qTrrae
	7IiC6Qqo1y/5Q35LNS3FM=; b=OFfJ0o1fNPdox08dfjsyHo7ZgIA2iIMIX3hTR/
	t1xpdTN8Z0FD3Tm5caJs+CRwmmsgUbuHgecd2WMA4YqAHpLiDsYqqtIBvCUgwmoc
	CByM1he21y8/0IZZ9DhLZjaelZS9TUWkbrViTqKExJ3YuNLOroj/ls2a7DEiGUG8
	S5dVViHPYAjlw7BYuoYJM4U03Njd7w/1ig65s8eYCQlflDGOcUw/j7940sDa17k2
	QXg04zAulHAwn4cR65qYi6d1S9CHyW7uXh0AjFcavGaejGp1jwsjOnUY/8Ei3YUq
	qIqy4ZzK4CjGX5NOOU2KQAr93Lj+DOH3G4iEDHCG9HjNMI8Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0tmkte-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 02:22:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c987913b08so16821435ad.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 19:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782958942; x=1783563742; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuJiALMC/BGgUNf5qTrrae7IiC6Qqo1y/5Q35LNS3FM=;
        b=bSj7TslHMz27TBiirfXbPb6509OUBOsTolkNJElcFZNLNDu1zE76tvjON7p5/ZWFw3
         USeT0k/KGE24t85/7EY3O1o+Ntes3mDFSfu9yMsm68YXhOkOR0mUrmO/iFAMz3UdLCef
         IVPmm9OGlNyFm3CO0176Xgwv387mXhk5+rz4xcMUwq260bV3SLCFFL6+rwStNAidDqJZ
         v4U3Non8liN8mkeK/y8QcIghLbJoXyfaml4v3h/WWuVoBeBv2oQn9O0M4IEgxgPZepPh
         A0V2kn2dK9RvZ0UlAUg6Vzq4wvqSQ/v1S7zrg3kPoY0XPM82G/FEJDT1hjl3iCUONwMk
         ViqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958942; x=1783563742;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuJiALMC/BGgUNf5qTrrae7IiC6Qqo1y/5Q35LNS3FM=;
        b=pZBKkRU1QhtMWhS7ttwMzcsFUgj2TjaEN9PahdWSmg50QM+sZBAtT79gBHHfmEJ8fV
         uUm96GnLahieR3lrMlOb/H8xpvWfK56ank589dq9bt/hojiBVMraGi8H8I/DIcK7ITE8
         YGzLLgM/wEPgVPnXU5qRq6JhHKpb6hlZWRD20/PmQELy3R9DM8ZWfNehxUHaiOkjXt/n
         qXPGZv9n+l5a/dsEQXkQ4lP+6Zl6EUZl8PnU5CvadxgyDgBvcn3NZumqL7X/70GBYsJ3
         yEoow7VTWbjUmuNAMFBZwlKIW6ysv/AhbenvLPI3Ija/H7C6PN0Ahfd5oyV9KxD6xTh/
         2JlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqu6Ve1fIRDKCYCgtOAGXD0K//IA+nYjRNRKmBDAK1Rg+3yfC5YZ752v5C9+dlMYReSEUXxmA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZ1S1+2Qyaz7SuE7puFJUdlgA42FqSJzy6PW8VbaC1jvaD9OC
	SNyGzx0waj2UrEM3CNnpjhfyyXLrx+hA2fAO6zD+DAx0tb85REgA2HYHouvbEe02+agka+An367
	e0B1GJhadUH+iTY6Dh20m4H3Kk1vCQQgLAbZTQCiBRlKtXA9Lj5kPlQkDnixKEqFgvGvX/g==
X-Gm-Gg: AfdE7ckXeVT6JzJAqgpvSs7R/GZEnoa09iChy8U/2FqyBc4Vgj8n/9Uh3ce62KrP8iH
	rnZ3F0ytxwDWvViWhK9T1QPZQ/NQ1GbxUwvPYbuRQXNEuwV14hucGbC+rKSNG2jUUgjeH2D8HgW
	G0G4wZMN7f2eifbxdfFHwA7dg68P89IEY0/oRva9i1qDI8PwBylH4PjulhH1ru+3Zhv/kk+uCC1
	UTVnHjDfvYnH8gqfOixslZLvZhkhOeMLlsAtOl24kpVRDErGeD8AFmbbbC9jihtJXXoPQtlA1Ss
	gQIK/gbnChsYGzZpsNp+mWQeh6atKfQKwx2rjv7q47ZUBv7OhLc5/D1rJdCzghXepErNNLJtNs0
	v2gu73Ett+z2Vxkq/h3Ekur3izk4WoZIZ3iKa5zR3/pFhWlgxS0NybbzpS8E=
X-Received: by 2002:a17:903:3883:b0:2c9:97a7:b1ec with SMTP id d9443c01a7336-2ca7e9348f2mr45316025ad.43.1782958942326;
        Wed, 01 Jul 2026 19:22:22 -0700 (PDT)
X-Received: by 2002:a17:903:3883:b0:2c9:97a7:b1ec with SMTP id d9443c01a7336-2ca7e9348f2mr45315615ad.43.1782958941741;
        Wed, 01 Jul 2026 19:22:21 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm3279918c88.6.2026.07.01.19.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 19:22:20 -0700 (PDT)
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 19:21:59 -0700
Subject: [PATCH v3] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEbLRWoC/4WNQQ6CMBBFr0K6tqRTCaAr72FclGGQGqTYFoIh3
 N0WNy40biZ5yZ/3FubIanLsmCzM0qSdNn2A/S5h2Kr+SlzXgZkUMhc5AG+U83ZAjuhnjh2pfhx
 41dRSKFVUpRIsvA6WGj1v2vPlzW6sboQ+uuKi1c4b+9y6E8Tdn8QEHLgsxaHIsgwgx5NxLn2Mq
 kNzv6fhsFia5Ker+OGSwVVRWaCQAJCpL651XV+IpGprHQEAAA==
X-Change-ID: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
To: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eddie Lin <eddie.lin@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: JAb_jK0i8Evq-iiMHpuGi4wyPGXnDv9c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyMSBTYWx0ZWRfXw1NequTXJdtB
 RevedLIpYTdd8O4k7oVWLLSpdDYn5Ti7epmbmrlUEJ6qDLApBvS6uD88FxVxAhZ+QtafBqq/53N
 usDtGIBMBsgsCm6iaGYIwAQdK3gZ/Po=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyMSBTYWx0ZWRfX4k0oz/1xgs3c
 Yjatsd41/evrptCZHNfgQjkdtqAEU8D1ho0LggQTPAKsH/fkuEu+8JqZ847cwX0z0d324PWjWwy
 pO8eB0nh6H+ke/JRXNy6qFn/khWdtUTCsHr20Rov7u9FwcICuKOAgsQd9tJzfbYoLmADN44jWmV
 57E29DHLZXrIml9jBDrd+CqqFDNjIwl973uz1sFGLHpVDZXjpE9Gjm2Kg5SouCvKnstb55APrD4
 bfBBZyfjNy4LIrp+0Zmtcqq7EFQuvI1agXLWqrGY2ebw5o9vyJuWfwaDQddj+J3/TTWEdy1Yk96
 KvK2lWQ/XqTB+lwH1tv56jxxpPlL+vg6IEBVW7YBQEpztVIn4vF5HqlKCMo7LQjeP2hFOhyDXnZ
 knvag4t4OVynzhT6/kEgDxJWsYIpvl7WaInclSpwJcKskbrhKSSBHeGaNdlz3bPK3K8s01Pt7TI
 KIxCNtoEen/UBjT8XxA==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a45cb5f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Rsn1OCey0fvCUy5VNe4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: JAb_jK0i8Evq-iiMHpuGi4wyPGXnDv9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020021

The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
---
Changes in v3:
- Remove duplicate description from cover letter.
- Link to v2: https://patch.msgid.link/20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com

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

