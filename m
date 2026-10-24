Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792837860;
	b=xl9Cmhx2sJUGQUI3vf4aupMiNESpMw5fMNCQtX2GU+x1lWj9+SvI5HidZ/FWr/hux72E
	 XK+MMpM797OQdWAkXHueYgcauf2e68q86E3XWoG3YXhX57iwyMQzmIZE/3r1Diwid7Yyv
	 z+6np3S1krae5c6iiT2UkatwwFoksGaydyqJDgIAFDuHeRE+QASr19tcM1iLzoYWiJp1e
	 iDizXPww+q5DQduqTroIWzC2h4FJOMNkUNF4Dqlg+s9eXH0mpFbXRaVdS+h1sjK192L5P
	 jGQsEam27Ay8arcPfW9czddYgvKutgoWsJYm5TXS9uQd9qcqOy7YRp8RCTvZmY7kxgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792837860;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=;
	b=Ge9fZ+CGD7vDgUaSGqzgTcDksHsvNXkN8K1kVZIkN2z8Jpl0Q1Czv6bUfCyaR5iDcdSn
	 s4TIs4yPPz0knfvmucaohhtAoaGSZPaKWxPFyt/3r45bZGJpjt4T0uVb8aZZPScbnKn+U
	 UX00L31sZjqDxNF4H3DYQjg8g8qAfPkYh/YlOSHqH7lPSsdem6x3cLRgCtYhcTg3/6SXL
	 mmJrNCsbVgixbZCh4CD6+mA4mPzGsC8kmR5BIobEdFMxPeOMRBPh4Te5HqMTmx3mJQSh8
	 yiKSYqe5+7sZw6TWMpiRdRpL1CfrVKoSCsCY6DauTGrim/h+kI8gsARfjKUNK/GJe7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="b2IO1Ip/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TIo1fOAL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41080606A326
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41080606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b2IO1Ip/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TIo1fOAL
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O8o12n2217127
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=; b=b2IO1Ip/yTuqxOc/
	k6PpGXfC6zyRvx5EAyZ5wfOcuXSB0OL9ZRCWv4KSH1Q9T1T0v5sndAde6mK2JY92
	S1qjSt+rew3pujqHIk3uGOLZPf/ai/CvqjI7zCiY1SV7mL8GhnRq5zVkdODHZPev
	EuiB39D/gwfZ2uXHY2+TfN6f6Hckolh7eHaZwlCM4i6osDHM4aQKvKD9GFlLDMbz
	kD4QkMHTKcREEjRlni8N+mRneBwyuPnW902OJTK241hXZsbDczKgY9DR37MdeakS
	uPN3qkx2KinvbOXpRUpxrE/FGcp7TFuFc4Tt9N6/KlAJMA+4rJ4Y4gocRaX0FycR
	lVkhAQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgs1py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:30:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2602276eec.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792837858; x=1793442658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=;
        b=TIo1fOALGSvK1fVscOt9IWluD2DRQoh7NIcmxK/UXnbrKmk6doo8EoIVOgDSTTl6bx
         /v/CV9qizw7QTkqaoc4pUJfYDBIfKr4BcQGxRUWpVlZ/+vzy+6+X5ltR/ZqeoZKsrv1u
         Z1yooRQofAngabBWmYfWxvmA9Ctz14G4ePs5NKbduElScr2jnJz2Oz8cKuhTG8e9GpCN
         NtDo7e4qjKXLVjLsPVY6leP7EYDKR38teP33GrvGCgFTOfhdCfl10blwEkx+tItz4ODV
         kjVhfFpXR1ag+1HIEgtYPm/97Tv5r9xWb6A5OStlVVRItWZ/LBcYwaUx/nKk/+gpTorz
         YIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792837858; x=1793442658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=;
        b=ajHRoVM3X3zo1HVuA+qAn6ojrgYoK5K7IBBRJobYWoCVLIAnxy7l2KRp9zn43vOgQS
         RsxCYU1mKm+6rCvqKubuPae2sY7JUhVCSbpgJV9BC4oElivQ8sHY4po6cdZxTo795AZi
         ncBFNsj+nFKyokPLRGQFp8SXpKsQmAWdgeXDLTpfgWBr3/m3TEXYQ3040AKGpOdThin3
         NEAn65qBUpfCKSHW57mZ/T511f8ARcxEsMPvbXVvx+SkzCL/I7C8rD557XdmR+4c/7Dy
         NyqmiYtwg0r0/WSCgbhcV1T/jACaKEMnKvSo6T0ab61oiWimH9qOzVm9893t5XE4QSrS
         dCEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFcKugyL69j78G9XBrgG3dWdvhsvSgIL6415h4yva7dZF36jdhzIqw0N6GAYRMjvj7/y2gisQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKU6mXWz7vobazQwVNMrCxB4Il5+QqnAexe+zLN0/5Nb2tI+70x
	rqiv4UJHQyox/up/z1kLk7/Z74SFwtGhX77uCHuynrXqXzggBlaGwVtxIxvnYrcwUU+JuKQxYQC
	DYOQdcO3vCQcvk0UibbMw0ArtlGAS8lBXooYOpwp/Cyj9eku5vi8qLAqOjpvo4vwwpa4=
X-Gm-Gg: AYBFou2uspz0sN/MsvRO7gb2q0wEO5/mBtWRae80CjaP23DK7rJksrSGZ5ZesEHyXgC
	AX9N3WB4zGfcP885iLg6EqAoQw1/Iy2nEi6dPPPZX3SLsLainBuR+YUHA0+NED1wNZzSlRGdLKy
	GE9kaCkPAGEXhRMn6gNL5Xm7OFFB7vr9choQA+NIT5r8lsHzPgaO82NfnptQTh7cqdj0puc8AdV
	UyrbR2l/wk/lHsuE0IqVZovsK873DbzOudWehoDEjc/40k1yuw+a7rciyYJ+nwxfyunvX4Yy81H
	+cKABN/mPGh+Y3xnj7uP7PCnIGoyZnQ+TlfroNOeKQjfUM2G4z/00PztZHA8NhQThy1kbUnS405
	mhKmRXztKVZYG0DfPd2zX/O0=
X-Received: by 2002:a05:7022:1508:b0:17f:7280:134e with SMTP id a92af1059eb24-19937025bfamr2402480c88.32.1792837857567;
        Sat, 24 Oct 2026 03:30:57 -0700 (PDT)
X-Received: by 2002:a05:7022:1508:b0:17f:7280:134e with SMTP id a92af1059eb24-19937025bfamr2402436c88.32.1792837856936;
        Sat, 24 Oct 2026 03:30:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:30:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:11 +0530
Subject: [PATCH 5/8] drm/msm: Fix sched_prio inversion within a ring
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
Message-Id: <20261024-assorted-fixes-oct-v1-5-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=3775;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=/p/xExe2wnQ1Pu4lNe12i74ui9lWBHsGWXEq9LYZN/g=;
 b=hgIcpVXBteagZ4vvfmPlFpmSXbnrYhFRwM5DvkNGy7xtffRy5qpGkfxqu0prTpDW2AkWa6/pD
 Um0wfeBa7bkBJzLTWIS/wYiSFGTxf/POcyBWIkaof79aeSxwPpLDfov
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX3zhOOKORFZ8C
 kqulhyml2AW0mHw3kSY1vu1mMlaZLngiW1fJW9jAcrEh2lxaf83iIr/qrZLf9yBVIa6UbOJyP+z
 E5OZQDWGEcQ3SZePWXaspEpNFR+cxhs=
X-Proofpoint-GUID: FVvTgEtqh3S_TjxDuYcq_9wGEP4TtvW2
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adc88e2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=F1ZHhNDtVFIJyJQHAloA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX2q7vTdnpMkWi
 /ugXEb3sXJC3P+SOFhPfs3YaA3qw42h/mCaob4n7jbhsEsOUZ1SOMJKUske0aYCq1oT0yUyOkpa
 eNrUkRvNHZW4umlpmsluBL37YY4GQAyHt4hNyAxU8sWuEPepxweKe+6Je7tik9HI5CXmPBeoMbs
 q0otmHh7c1wl1ZWsZ27qpIB8NPkJn6WrUx91UXvOcuVLLuqECa4tNGYxIcHiPOhXCVbi+G/4n5B
 1e8WxWY1EtOsHNQb+unYtC3XlnFDsl1O3LGIVsELDfEwb+wEtPOWgHqBmQw3XjJcz1h6HBGl6cX
 Rp/Yay3hKMi8fQ/dkEJo6qjvZ3ykPUACVpyj+RKs/4aIoB46NKDN6BWmCan62BTfE46mpHbi8R1
 N34T/XSvYo3dAtIdFvJ7+TKjWvhPmasGQgWID82Kv1RHR3qgyZMCJ7GdrLBUPvotu1IjuXNLOjk
 +Vl1ijvCO2+uRZUFKVg==
X-Proofpoint-ORIG-GUID: FVvTgEtqh3S_TjxDuYcq_9wGEP4TtvW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Commit 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
reversed the values of each sched priority. But it didn't update
msm_gpu_convert_priority() to match the new order. This results in
incorrect sched priorities within a ring.

To fix this, remove the inversion logic and add an offset of
DRM_SCHED_PRIORITY_HIGH to keep the range within [HIGH..LOW], reserving
KERNEL for internal submissions.

Fixes: 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.h         | 24 ++++++++++--------------
 drivers/gpu/drm/msm/msm_submitqueue.c |  2 +-
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..bc5b31eb1eca 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -522,17 +522,18 @@ msm_context_is_vmbind(struct msm_context *ctx)
  * @sched_prio: [out] the gpu scheduler priority level which the userspace
  *              priority maps to
  *
- * With drm/scheduler providing it's own level of prioritization, our total
+ * With drm/scheduler providing its own level of prioritization, our total
  * number of available priority levels is (nr_rings * NR_SCHED_PRIORITIES).
- * Each ring is associated with it's own scheduler instance.  However, our
- * UABI is that lower numerical values are higher priority.  So mapping the
- * single userspace priority level into ring_nr and sched_prio takes some
- * care.  The userspace provided priority (when a submitqueue is created)
- * is mapped to ring nr and scheduler priority as such:
+ * Each ring is associated with its own scheduler instance.  Both the MSM
+ * UABI and drm/scheduler use lower-numeric = higher-priority, so the mapping
+ * from a single userspace priority level into ring_nr and sched_prio is:
  *
  *   ring_nr    = userspace_prio / NR_SCHED_PRIORITIES
- *   sched_prio = NR_SCHED_PRIORITIES -
- *                (userspace_prio % NR_SCHED_PRIORITIES) - 1
+ *   sched_prio = (userspace_prio % NR_SCHED_PRIORITIES) + DRM_SCHED_PRIORITY_HIGH
+ *
+ * The offset by DRM_SCHED_PRIORITY_HIGH keeps the range within [HIGH..LOW],
+ * intentionally excluding DRM_SCHED_PRIORITY_KERNEL which is reserved for
+ * kernel-internal submissions.
  *
  * This allows generations without preemption (nr_rings==1) to have some
  * amount of prioritization, and provides more priority levels for gens
@@ -547,16 +548,11 @@ static inline int msm_gpu_convert_priority(struct msm_gpu *gpu, int prio,
 
 	rn = div_u64_rem(prio, NR_SCHED_PRIORITIES, &sp);
 
-	/* invert sched priority to map to higher-numeric-is-higher-
-	 * priority convention
-	 */
-	sp = NR_SCHED_PRIORITIES - sp - 1;
-
 	if (rn >= gpu->nr_rings)
 		return -EINVAL;
 
 	*ring_nr = rn;
-	*sched_prio = sp;
+	*sched_prio = sp + DRM_SCHED_PRIORITY_HIGH;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index d307cdd17d90..8d550d281704 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -136,7 +136,7 @@ get_sched_entity(struct msm_context *ctx, struct msm_ringbuffer *ring,
 		 unsigned ring_nr, enum drm_sched_priority sched_prio)
 {
 	static DEFINE_MUTEX(entity_lock);
-	unsigned idx = (ring_nr * NR_SCHED_PRIORITIES) + sched_prio;
+	unsigned idx = (ring_nr * NR_SCHED_PRIORITIES) + (sched_prio - DRM_SCHED_PRIORITY_HIGH);
 
 	/* We should have already validated that the requested priority is
 	 * valid by the time we get here.

-- 
2.55.0

