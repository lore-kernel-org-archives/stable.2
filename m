Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012754;
	b=m1BowvYpU3c05q19YcRxNmUNIlK18OYbnH9QwOZiSwjWp6skbNbVDhe0bjAQx8r5veCd
	 oqeTMQdFtahoGAYYtbWRKC8ig1IeM5xkVy3V1/ZyX4K7C5aD1EamZd/rwAmFTt/mMMQAk
	 t0vHOkYPwvChcyNe31tkxsKxy7GyQbBEubZTN3XvedXCyt6v/y+dZ9KRAVMH3Q4EIE4RH
	 d37XOH2qiNw/C63CvAMYMBsPYHaZDxIM4aA8gXK1IuBrJEOvBjQGai6KseQdFc3PEGjlg
	 E6T2cPcxYTG6JWx/FXVbPWCSjAf4hbIUl8JCJULefAjO+HSKTPwz52WwqfojsTX58Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012754;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=H03LtthrYuvQYEIExuKoEMuRfJGODgdYm1JqGCaaY9I=;
	b=4L1XyxgHsWgN1PZi+GxI6lJV5+u8uMfR55jz9WwEtUAl2WMZ10WUkkos+DcoakrOL7ux
	 +ipleLMqXJ7ymBVRsRcC79mArATPZQ3zhvXojSY92ACPfLzulQerosgkq5OvgPS/w6AUZ
	 A54fx1gmIlo5pMXZP/CNZb9a7CpxkHeLeNfIfEpu4PLNAo8/6Za7eQIKQdTsUhxUpqO8f
	 dF8khKdfJ66kUTthrBiLY/kURHEEocxMgSWvdrhzPBMPL5qvuncP/fvqbeRYLpFT+xr5E
	 6saj+vggVQHapPMlc3m+7cUlvAS0+XIUQr6atExZNgsRjw3iC8FBjNb+cdoWPw/M0BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m5K1dgwZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dFN5Q8OW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A9606A323
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5A9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m5K1dgwZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dFN5Q8OW
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtM4q2009906
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H03LtthrYuvQYEIExuKoEM
	uRfJGODgdYm1JqGCaaY9I=; b=m5K1dgwZNC6iU3IFYZ5WdeNoW8rNHuLWSwhcWZ
	rSCeFyFxSjeeH1gPldlweDyxyRGpmKJDL9vJhXX9lAv1wCFPbV5NpXbQdLO20GBe
	/O654at7nTK+SU3aWbWJ5nh3/EbPW8R277bc539TsusgQb8o1mGfpmhWL8T9K0T1
	SAE5d+K3pWyK3TGFhVu8IzLuM0Hz885ZTR+tX52OeLivyjzMltsWmpcC/LUt+pLR
	S0gllNjZRAuwaUcr7v5+WRj7CT0WXWWlBnvWAAht8puplKNPt6PX1qrAMBb+tbiG
	HfsAOCwfgFk4BK8PydXJ7DrxWZcIPbw5ne3UmSFNgPGviFhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27x23b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:05:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e869e00005so46115535ad.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793012752; x=1793617552; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H03LtthrYuvQYEIExuKoEMuRfJGODgdYm1JqGCaaY9I=;
        b=dFN5Q8OWp1JP8luSEXYGhHuC6PWRO2/4OADzo0RlA8rb6NsZYO/MzaiGTtmn8Pjqe+
         HfSJ6eHuCwWKoeKzNY1qpeLq5tKBOwx3U7KsA87UkWL8g9YuKYR9DfXfZIET3VCiJDqz
         LTZmpHW6HPSpCrrVP1CApS7+mM5M2sLblw4Q9463gTD2tNkZx5dt9GvcZeJZcLagLZM7
         IUCYGXefG9LBODeLQ5E0a5/4NtY8+hv1GXyZpezobzXn7lCK1xa2TLupbjjUgnWaT7Zv
         ykGWUTVpCGrhWl3GnkHePc0cwBv33L+8oZdnmwe6CKOiR0YZzA7eS15aIoz0BY295Nwh
         KQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012752; x=1793617552;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H03LtthrYuvQYEIExuKoEMuRfJGODgdYm1JqGCaaY9I=;
        b=UTcgXpiQu7Dnz4G1nsjIKSwhzec7ghgRfeG0ZRuAXFlNFSAwh6I3UDtYZNwoajv0Qk
         7XQbq4MGElicLJDPYdA+fD26zL+CHDWv+rcWSmI3U2u9CQFIGQ/+hNUpDRGfZyEYJNyw
         1D09ntLSiDBA81LfeZJZpukF/LQFHc8eaj6uNZcUyMIfp5gGUapasEt+seHROGN6U094
         xo2OL6n4+tjdsnSE5WcArqiQSdJdjwmxXkevJ8JPqK/M//NltvW44R/s6OUOMROQ40A2
         C43adU1mqHVBDxuPq/gGgJFded2sH9fIbL6eqGK/s6iSiqaYd9vZYKUgwq5TYyXdCpfN
         +cew==
X-Forwarded-Encrypted: i=1; AKwUvBz2LNEDs2paYhbgbS63m6qNX2VMAIf6z9USnQ0Ovb0Me1iF0ADIsm4aoE4xoajmYM7G9j6s3Lo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEDJsZzkicOuGwmCvpRw2GQd+dfGN4cAxJaeO7FHzlVyI2xxPP
	WaoPX0LvCCMjxkUeOEeRW4OpJenoFWCeAl4ARvim12wj/T72dj2Aw/OX6W7qi4U1lIYAzsNRnbs
	WY5198KG/WsZpG1QJG+KSxjQtY2IWxfpzZePEBoHiZodNJmu+nLJKlmyLOXk=
X-Gm-Gg: AYBFou15SEh/xrV6djfP2zZM/HhZGg5q9iKOQ9/LiutduUADYxYyc7H5EypDID3oh2F
	TfM+ggZx5huk/h42/cGMUV8Mvr7aSn2OM0OldB4k1zEZLF4cO/uWVxNMWuhh3nxlkfvs0CFAbyK
	ix4NRLr4OtYqyj1nzAedwhvUpQvdNpxXmu0nH6nqCxqvXI+FPi0Sny0+5pzjZ6Ts9PrACZLr4C5
	fFrFWBfptbtDaIorhkgVIvoztS0UbWnT44s3Dnl44uZcVOPUQ0daVZ0Nga3MWtkJeVMvTGdfwC9
	xMuppEI41AX9jvVFYky5AcCP2aJU2N9YUHNi9HVaL9FLu4hqrpfgDH+jzQ2cGbiHXcJyMgL4CeJ
	qEE2NOqmXjXDklbe76tJHWh/JBrBJLIarl6Hk
X-Received: by 2002:a17:90b:57e5:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3adeaae625fmr5524056a91.26.1793012751864;
        Mon, 26 Oct 2026 04:05:51 -0700 (PDT)
X-Received: by 2002:a17:90b:57e5:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3adeaae625fmr5524019a91.26.1793012751284;
        Mon, 26 Oct 2026 04:05:51 -0700 (PDT)
Received: from hu-anupvish-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb18sm7976870a91.15.2026.10.26.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:05:50 -0700 (PDT)
From: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:35:45 +0530
Subject: [PATCH] mailbox: Serialize mbox_free_channel() to prevent double
 shutdown
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
Message-Id: <20261026-b4-mbox_free_channel_lock_upstream-v1-1-62d4133162f7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAk032oC/yWNQQqDMBBFryKzbqDGKqFXKSUkcdJOq4nMaBHEu
 ze2i7948HlvA0EmFLhWGzB+SCinAvWpgvB06YGK+sKgz7qry5S/qNHn1UZGtMcl4WCHHN52mWR
 mdKOKXneNM8a0jYMimhgjrb/I7f5nWfwLw3yYYd+/fmsu7IYAAAA=
X-Change-ID: 20261026-b4-mbox_free_channel_lock_upstream-fb263a88853a
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
        stable@vger.kernel.org,
        Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793012749; l=2826;
 i=anup.vishwakarma@oss.qualcomm.com; s=20260805; h=from:subject:message-id;
 bh=N6iLv5ioOcGCrG5uTp6jAUZ2/PfYhEy9kgM6g2iLAzQ=;
 b=d0XndujQ4iB76kElatBt0aLsNdF5SPjMOWHy68PnhlsJZp1f44ma/I4OtAHNyzZe0TyDV0WuJ
 zxxu0r5PI4CD3J8mLcA1+6mT7jqByZr1BpdZXkL9I+V3lyKySEElUoa
X-Developer-Key: i=anup.vishwakarma@oss.qualcomm.com; a=ed25519;
 pk=Y9ilCu91UQrzHOM14SG2IjnmQ1QSroH5uVeBSWEmEDM=
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adf3410 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xrh5H9Ivz0AkvaCVI7cA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 5uNPyUGTOLL-644IVPaTyM26gN-oA9M5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX0EQicghRfHnI
 CE8JG+38+z7O82QECpRLPVT7rQHtCCdL9/g+aLlxFZC1NIctlnivZr6aCvSlq2K/UuVtVfRAU0T
 1s6OpVR42KyG1duJagIp4Gum8mZ3PvQ=
X-Proofpoint-GUID: 5uNPyUGTOLL-644IVPaTyM26gN-oA9M5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfX3SOUZ8OMCgSi
 XbtCG5MsmTvIithy9QuNwL0bz6yv9s6Y2cMpbHTw6L+kuoqu6f6P/ghLIQZ6L2EV/eRmMl8jPaQ
 uPdnlwFryp0CVgoMO4WPuipdbR617OO+GAej4m4Jd9A4TWCJwPJsmyPgnLml/zJrU7DKTjttDA2
 foxn+hE8xb6ZE02LmMOnMszM7gH8CtRknIYGP/SfDyxWORzo8/DEW28/ps0TP4Tbd3sBECjEz6T
 F3IcvvSsw+TlOmJiaeUEh9MXuHZmk7eEgyzxVeLERcXbMCvPTl+H4zLBVF6pEAZ+3WbmaqEMtoQ
 wuNcc/ytldKPS+MPFjR5q4emsEBZ8py7RI9QbnF1TEaIvx6ly6Z4Y5qpUZEUAr2xHXU0gSPL8w4
 YP4yHaOPquJrNNewmEGXunmAN041KwfubpsRXtsMyk4zRACBi5ngeRWh1j6bavgQgI7/vGsocJj
 mQvfeIiuO3tK9bvMm9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260044

mbox_free_channel() checks chan->cl without holding con_mutex, while
mbox_controller_unregister() frees the same channels under it. A client
releasing its channel can therefore run concurrently with unregister.

During concurrent driver unbind both paths can observe a non-NULL
chan->cl for the same channel and both tear it down. This calls
ops->shutdown() twice: in arm_mhu_db.c, mhu_db_shutdown() frees
chan->con_priv and dereferences it without a NULL check, so the second
call panics. Both paths also reach mbox_clean_and_put_channel(), issuing
two module_put() for one try_module_get().

Fix by splitting mbox_free_channel() into a locked public wrapper and an
unlocked __mbox_free_channel() helper. mbox_controller_unregister()
already holds con_mutex and calls the helper directly. chan->lock can't
be used instead, as ops->shutdown() may sleep (free_irq() in arm_mhu.c).

Fixes: 2b6d83e2b8b7d ("mailbox: Introduce framework for mailbox")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
---
 drivers/mailbox/mailbox.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index efacd24a085d..2cc655dad9e2 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -504,12 +504,7 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
 
-/**
- * mbox_free_channel - The client relinquishes control of a mailbox
- *			channel by this call.
- * @chan: The mailbox channel to be freed.
- */
-void mbox_free_channel(struct mbox_chan *chan)
+static void __mbox_free_channel(struct mbox_chan *chan)
 {
 	if (!chan || !chan->cl)
 		return;
@@ -519,6 +514,17 @@ void mbox_free_channel(struct mbox_chan *chan)
 
 	mbox_clean_and_put_channel(chan);
 }
+
+/**
+ * mbox_free_channel - The client relinquishes control of a mailbox
+ *			channel by this call.
+ * @chan: The mailbox channel to be freed.
+ */
+void mbox_free_channel(struct mbox_chan *chan)
+{
+	guard(mutex)(&con_mutex);
+	__mbox_free_channel(chan);
+}
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
 static struct mbox_chan *fw_mbox_index_xlate(struct mbox_controller *mbox,
@@ -596,7 +602,7 @@ void mbox_controller_unregister(struct mbox_controller *mbox)
 		list_del(&mbox->node);
 
 		for (i = 0; i < mbox->num_chans; i++)
-			mbox_free_channel(&mbox->chans[i]);
+			__mbox_free_channel(&mbox->chans[i]);
 
 		if (mbox->txdone_poll)
 			hrtimer_cancel(&mbox->poll_hrt);

---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261026-b4-mbox_free_channel_lock_upstream-fb263a88853a

Best regards,
--  
Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>

