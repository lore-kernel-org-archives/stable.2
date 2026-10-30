Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391601;
	b=43f+MuH31KSsKTkfmgZdhNon0MRQTLbrNWv6C7oQHCtY453cuWdVIQLTUvPakA6xtMl+
	 agPAMTVurginquS93eRQqwKfEXdW56pPfgQDQl4ghjShdoV/1VLCBYtYf2K8yScTNjaLT
	 1DYs3G+eSr/Xo/oFh40z/7ePWS4/OFipmC60/jdH5Pg4P8SSdANaG1TqZfUZNlYKv7ubQ
	 d+04ZSG8eUw3oTZTntWCUXlUZht7lHis4FMsO2GtKs2ahFf6SnH6Va/PqzQEWrmMMKdhA
	 MF2khLZTPMu7zz5ElQnxwyXfBBOKH9WAShDOoSW7Ao1xdUrIBCzZrdmfTk1WD7wKGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391601;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0ro4w2I12dfEEJweknOcVbqt7J3mhia59vFYHx7Lnrg=;
	b=0PewbuXEQr2uC15fZORA5J/OfDofTP0xeeNh8ZX5wIUfquY0rIZvM7R22CnYwii3pQ/z
	 mRmdMAqCGzdzG8SDobSseGx/gkw9B2aJ7ykPd/YrAwLHpx1/eD4xdVoYB0IZrntEc8g5N
	 X+2ZZoaxTkMJ4Z9Mw3vtF/Ye3atAvVLz+hosJbLeT76Ow4Ob5CQHiHveEn2x6Sq3Q6jdI
	 76fjwNHOksxUN6zCC7GKumjayvhuddtP5FDW89nVV/0RgY0CqEYKzMuo29EGhA5PPicls
	 WbuX5U/00p50Y6NYpIeGWmgsT1NOwTNDRsF+2Lj9ya7Q3Ppxnzaax1DeXSTIofCEpIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XEHnNNLi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ffG+Qajb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B1606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C24B1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XEHnNNLi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ffG+Qajb
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIhUFN941878
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ro4w2I12dfEEJweknOcVbqt7J3mhia59vFYHx7Lnrg=; b=XEHnNNLiribYBojf
	rMyutTB8EFM96PKO2WMpzEMS96jggqPIRgn9nTNXJy/NlRYToVSMI9374QFm3Nhk
	lZ22b7cDlXiKWsi9v/KjMv6Hb+4t/uT+B+jdlWiaNY0vERznA7pdvNZkTe9McR1e
	cJvLIGR0PTE4o4HUjzbSPVWzZ6F+u8w/NAL5EX0DJ6VgXDpuLiNOHWC60PbsUOYz
	lB47WItYAKpJGJq/tykKrTqqRUWxdfBNUQiJv6ix/81OdmivwzAqm8SHaUiO7XOb
	MsiCLi1MOWnxKdxWTy7EnAOAG+x1xvkeODr86la2YQOOGgPmJgOoUP4gHIkq6ZhC
	nBpEnw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0s389a2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-351788121cfso4981643eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793391599; x=1793996399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ro4w2I12dfEEJweknOcVbqt7J3mhia59vFYHx7Lnrg=;
        b=ffG+QajbvDDawrR7GcXGZ9KAaNvFa6bkKwzbxQQ5k24ktEY9RjRsdZfALIHpdz9iWy
         XCAx1GqChn7ZrGhcxpRNTYMjkP6Fb7+FekqtQQJMk3AFhNI0cBIknyNhaLqXuxopHJRi
         +tgy9kvr0krLeZ4W7SNQ+jDpjzgu14q2rjSU1JgBpTV6e5I4SwU51nB9+mcnF5hfQa9i
         ezwhYGKaegUqQk4VzvRCgeT7Kgrtt1nJCWLx5VjiOMc+VI81MBKsthck+dP6vi5/dAdm
         Y3F2nCde6bAvinRkXSyIsFx+moJ3eXu6oytS50Hz0dhA95qahMVzXpFJ9/m8fBcT2OTO
         sT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391599; x=1793996399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ro4w2I12dfEEJweknOcVbqt7J3mhia59vFYHx7Lnrg=;
        b=TjgCBAcIw1AEDuALVGwOPOUw7zDrRx8XFvD7gyMB612SIpliaQ7Eq3C7D0EN11zok9
         MYmBu/ToytXqTFcQf9IAPgoXCrjnc+mt8FjNEPBxN3v5LzsvXmdU0rFvOsmLqfCeRUOM
         n76tozJshn4AAZaMGF+ugPdjZHMeCtzhhV0ADHVqgvuO6SEKrTI0esqL8r6PGqWkq1rx
         4Pj7ubSIHo/bIY8w8VpS6vMtHI8Jtqc51W857tjjv6ggzXQe+nNdNY7/x6T2DLP5OjDh
         /ZY+aE0AvwkbiKhn4N+PMOhV/kD7P8+StNFoJ5KkXwkCl2QoJAjs6BKOOd7r9yEDBQ7c
         dBQw==
X-Forwarded-Encrypted: i=1; AKwUvBxXZ3nqW1LYUq1pYI6T9rr18NKXk0Dh6UxZS0AqCB8V0yzgLgi7+pfOHdPcWyXcE8Mc8WqFOAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaq853E/xEe6h4nOhSDeEuneEOvlumg+JnsdzOmWye+uJrSYBr
	ZYXiHtw0gjvQerFyGUpiZ8TYpD8paSKI1v4teyUJ6rU5llGbnocJT9oB/u99JhqlTEd5sqz8HNn
	DxVb4pc1QkAfJZ2YOIcm7pVoZa/LzkV4LtridQ2h+TGt/teHBzAFhJc/sERU=
X-Gm-Gg: AYBFou0mGHife7fqhEAXweezku7EyhDPiBQsP6VQhAUbfkV8TrRR2x4cN5v9avjgJUZ
	rH+sbYTSYjBjdtywk21xfdYQ3iAxbM2SOU6uByjK2jUQxl6AaWt1YYPiSR1Av17+Q+9oR5jJUV4
	ZFUAjHEUKr+cCisDwQ69iktgBM/QyXB/xGdY4/idSejzKzkXueHrvceHCPNjAeG0irHFrCxs/Nf
	5tasL4G1gS2H7dLayCXcMLK/QfOG7V3Qz4lQlREnuF9KA4oZOdeZQ+GAW0coIz5ZLq6RD7o6U/5
	VNYo7eI7nVykJSPLqCYh83lBCylHOx9oAPKv32fVbvit+F3CQUmZT601leL24JYUhSnJjqMl3Bz
	rOjWQjy/oLflZr0eKhS0Q5BCNRmOxVBZEopaLdLbHrC5pRw2KWso+HfZrAmEIxbQ8/gCKivzLpe
	13EYGDng==
X-Received: by 2002:a05:693c:4144:10b0:35d:4185:5395 with SMTP id 5a478bee46e88-36a423a205fmr5724086eec.16.1793391599157;
        Fri, 30 Oct 2026 13:19:59 -0700 (PDT)
X-Received: by 2002:a05:693c:4144:10b0:35d:4185:5395 with SMTP id 5a478bee46e88-36a423a205fmr5724029eec.16.1793391598552;
        Fri, 30 Oct 2026 13:19:58 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm9300197eec.0.2026.10.30.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:19:58 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 01:49:10 +0530
Subject: [PATCH 2/3] media: iris: Skip redundant HFI_PROP_TIER updates
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
Message-Id: <20261031-fix_dec_seek-v1-2-cfedf0c267ee@oss.qualcomm.com>
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
In-Reply-To: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793391582; l=1653;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=Fs8gGyy1BbD06vtwlN2GhfJTzyeqxPW+qZIMwCmZHYE=;
 b=n7tOrzm5p7DVClpQrshqWegTukL0PD/boqowsTA9qtKnrF0uCA3VMjiX7SRmhfJ3Dshm0WGG8
 saP89Hzn4TOBEPD2bHaI7bJhfjIQ9E9u8ZF9DJufX5VTEP306eWovys
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfXwIRaVdX+2Tu1
 sRkO3ly6QFZqR787TQd8aGObtXJo6yTSgxNCG2D0nqOGu1FRHRAKTAYIO4h6wU7ZaEsJOqbs5ir
 +63lPsKBqByiSWlEz5yftqTVuApmdVeKYWOmJCrYFmZkn2T5wlgenSLyV2NUBgsiNvWZKeIlnkX
 KgRyau2QsVRf67sJ/bI+oLiHBpM0LV5ujPQpzIbrE2j69Qw/e9+gJ4xWidBwlWiVunpLQzJVuXw
 LETXMBxtt328n2gE+qjvzPzxPzSk3RATbn+EUURqwyuE0GNuSouqer4YUntCqE3tKbhRt0RxqjL
 Mms5GgCen1muWvvhBXpByWRtHmXna+Eb5SiXr52YpIHadADtadNZ8MeqXSOmkiienXxlbI+hIHZ
 Js0O5nCPvzfThn/CLguIvMUHx541n5LWUTJXdlCJ3JDiTTNIVYrm8YZXJswyBX/MsCaKi2cQ6D5
 c9FFUWMk3Fw9kwRsrSg==
X-Proofpoint-GUID: rfn5wxwbSyFaYkvDZkoe-Vn9lNfC2wti
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX7UlxcP7k2jij
 WHVvO0iB9JIIrgPUEClhUOlmB5z06f/jG6oUSdigau45zZ47ktgXdf5EZUhV4f7c3JGbLRw/yH9
 xaEDRCCnxvzmIUsZf/Op96s1yzyb5+Y=
X-Proofpoint-ORIG-GUID: rfn5wxwbSyFaYkvDZkoe-Vn9lNfC2wti
X-Authority-Analysis: v=2.4 cv=XMul2ghE c=1 sm=1 tr=0 ts=6ae4fbef cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8r_SgFHEyvr_bYIatxkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300081

HFI_PROP_TIER is already programmed by iris_hfi_gen2_set_tier(), which
selects TIER or TIER_AV1 based on the active codec. The TIER and TIER_AV1
caps also define a .set callback. As a result, iris_set_properties()
programs HFI_PROP_TIER again through the generic cap path.

The generic property loop sets TIER first and TIER_AV1 last. For non AV1
codecs, the TIER_AV1 property is programmed after the correct tier value
and overrides it. Remove the .set callbacks from both caps. This ensures
HFI_PROP_TIER is programmed only once with the value for the active codec.

Fixes: 2af481a459a4 ("media: iris: Define AV1-specific platform capabilities and properties")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2.c
index 79bbd06ef8d2..6888aecec902 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2.c
@@ -997,7 +997,6 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 		.value = V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
 		.hfi_id = HFI_PROP_TIER,
 		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
 	},
 	{
 		.cap_id = TIER_AV1,
@@ -1007,7 +1006,6 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 		.value = 0,
 		.hfi_id = HFI_PROP_TIER,
 		.flags = CAP_FLAG_INPUT_PORT,
-		.set = iris_set_u32,
 	},
 	{
 		.cap_id = DRAP,

-- 
2.34.1

