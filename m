Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585268;
	b=xGWzqFbecs8gp/2pQym23MU+OiIp+zrmaQ3dEHV6IsodanUrz8GAWRB9JyrrvD8440wm
	 urWFshRB3GRUylaNjuQEXpCXyX1NpE6s8J9L2g3u7Rh9eOrSL7AF0h1Yilh5kY8xPGFA7
	 HjvaobKde6GiEP3hSlBx52LLvF26SUk+pLmRI52FFQLU2bgqvp83roNFx1wiLMvbs5Zv2
	 COd37u5QiPTCD5GYayvj7zKtnCOYhSQjJht278lQzLbwItLmzch4Csc+Yz845zYO0Hvqb
	 L0iX3PpAylCuuh/p+o62lKlcX8onN1v+vPH5kHIUPVTo5LNqtwPggxTzsPykiRLd+tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585268;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R8SgQ6hwW9qOw09sW8J5tLP1YofqQz2au4lfK+740o4=;
	b=HHjmeRCOod8R/REO+/yycxt23rpMd7U/ue9m4W0dMvGLm2yXc5OtaV/8a0MevhUw75kL
	 TU7iWMpH+mRFEJXwXhdew4NrABP5/HpLBSKZdiM6NzGJuLih5DyT5Tghk0JMK70nk9inJ
	 /Tf0wUzzeHgE/WbqIYKCM1Kpe/V699zftpw4suAzu2U2tLbza1NT4cBjhmxFTnTS7rSXD
	 aN65IDQFf/W/+XmYNOOvOF/t3HfzLcjht9QVvqH52AvkW9GlTXe52pig/cOl7Sbyx8mMO
	 N4UA7Q6hWp11OQ2unGN9W6kos5liqiybB5tuu0QWP4oz01g266B5NCDpNrwue5zxvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dg4Wu+oM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="A/4Rn6+B";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC77606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC77606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dg4Wu+oM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A/4Rn6+B
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2B6Kw2625895
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R8SgQ6hwW9qOw09sW8J5tLP1YofqQz2au4lfK+740o4=; b=Dg4Wu+oM8DDozcut
	Wbt6+cx5bw+Lol7rvkP8MKVII+Hfb/eQ9rRXm1nTKF9EHdJESskdnDCR4Gv2dPal
	vpqLMU20u39AoTTRCw084x2P0xhHx1bKCFL5eFupIUOC50Fdv9EaID6aXkNBWJPI
	VpfV6hbzn8MrxOgJb6iNB0jmBFQKSC93Ue5gS5H0zlyMs3IwyrkeNlUCl2Fik/j1
	UB1QtrIh/0nbgPxBbozL5fZdhSZFgcS8W7IqjRM3ieItP95Z7Gwb40jJCdM78JC1
	E+FjUZEkqlB2qz5qHyuzqXXhyGA6OtSKTjW1BMJuJ7fSvpxfMOvni50WCSeUwg4Z
	vdhDHA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc293d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:41:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3fd219d07so4329990a91.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795585265; x=1796190065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R8SgQ6hwW9qOw09sW8J5tLP1YofqQz2au4lfK+740o4=;
        b=A/4Rn6+BksppQG50CyP4+NLIMZaMftMf5HlUjB2Zg+t3GyYHjJqhuKn8HuXIs3m1sB
         tb/els/jOOeVh+DkpYn52ItEzms+/fXw4nGk/4iZLMfQit7gG3sB3aKBzlKNpyybM1Ds
         0eZWDU3zRqUz2jBEQ6wzsBbvKxeCZructF2RFzycoYAM+tEKUWFjWjinnSFUY+z01MRK
         GjTbxfvwSODy8iCLWtwFo0AZLxHnubPZUitKf1d3+xR8XD0GgtGx/xAxqO7C74RJ7i5q
         w1e1re0PQB9514xSpfVtYlAdxF2CIiH46Tn8/0jRRn0pUAXdJ3Bobr07deAznU8wPCTL
         3rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585265; x=1796190065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8SgQ6hwW9qOw09sW8J5tLP1YofqQz2au4lfK+740o4=;
        b=c2CH0Xv4vM7dyAQJ4VTMbE+CzjZi3DFLg17YaV9ebFQXDwlFo8myTbfbrN5IHwclg3
         wjidXAaxBHW+WV+uFrejvPDljI+4twP0wNQNT0Muc4gFZ+f/Hgf3rvM44EkirWFe1w3n
         yUPBjcAkntli4RjHjnxAo8iv0eogGvYxWVcsQYYizgc+gYVDEQNiHOVsX5m4eLCWeTN5
         ptXMRtz81UKNmI4VYFXFgb8srSNTW3eugZD0HJso7iw/H0yTniMkzMnVS5LxfAjY/Hof
         lqfBtwlODBcKxnGcQiJuR1ObzrrX6EfCq4iu2z9cA0L0QQIlpBqS6jiS+Ox4B2MrPUUx
         nnxA==
X-Forwarded-Encrypted: i=1; AL+hErHkkXH0va78VvqFH4EivyCleNq4KHxbBCe7RU2Bv5Lic6Qt0LuNITLuIKIUhu2iy2wRSBYOLtI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gLOix59LdTVB+C/Kp5JuN9PHBLL1k1WRUc4dwO8agpauI+Ysg
	HkJ7ePizFAiKwcXHMyx9Kvw9xl2NKYGcxhlVeGJVWQqASkxCZzvxSf/PHcHasw8DiQBsiP4KK4X
	iIfE1bC4vD767MdCqyhh94bvTaSz2ME83GJcRc1r9eVYU7GCBM6ESz/99auc=
X-Gm-Gg: AZFdTZddGaLXaWGm2IO+mI+voeDWc9c8wuILbdczTc6EfS+/F+ZrsrPpk3KHgnytdL9
	5zn3mQDMf/SAvVAMznV7JuvdMm+HFFdOTH5NHBA+0Pt8IuhPtiC7eWd//Wo8zdAhcjCcw/G3ka8
	WqQALPbdnGTDQbTmV+HwD606Gidi6J64uKy4D1SXB4eaJL6x9yGspkUuKlOZ83rCMCeljMfDW4A
	Q7WMuvThylD68OM4r3c/G/fBJeDn2PmSZSDNPwfPkw/CZ0CrDZdBqaCapdu2dafKBpasYon6fm1
	BOH4muEg6lWwhqp/PM62gQWonhrtf6UiT28jiVkzsjSyeWy54vHxNKfQ2Jx8RjDE/08hsr45QK5
	FbJSbrufiM9ZoLqTpjZKhWOP2sewiKYkRpPYKKRkUmr1LMpO8Ik/kYPvwlA4A0zQ/leIg+qmzbd
	wyzTOL5Jg=
X-Received: by 2002:a17:90b:2e4b:b0:3b4:e3e:647 with SMTP id 98e67ed59e1d1-3b41c55f771mr15874071a91.0.1795585264716;
        Tue, 24 Nov 2026 21:41:04 -0800 (PST)
X-Received: by 2002:a17:90b:2e4b:b0:3b4:e3e:647 with SMTP id 98e67ed59e1d1-3b41c55f771mr15874061a91.0.1795585264213;
        Tue, 24 Nov 2026 21:41:04 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm28897957a91.7.2026.11.24.21.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:41:03 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:10:23 +0530
Subject: [PATCH v3 1/3] media: iris: Skip redundant decoder input config
 params
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
Message-Id: <20261125-fix_dec_seek-v3-1-66c9889def2a@oss.qualcomm.com>
References: <20261125-fix_dec_seek-v3-0-66c9889def2a@oss.qualcomm.com>
In-Reply-To: <20261125-fix_dec_seek-v3-0-66c9889def2a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795585253; l=2753;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HbJHii63vZuPsEL3D0WK9kORlLRtexqycHmObvJrerc=;
 b=VmTJ0C+QAsT40DxE6OqPP3TqMkhaaZQc4pYwL+tyLtGZX/Iw8wRFWnHMSseFNfK6bx7fuO9Ve
 dMGRdffwoYcCJREIirXL2Kq6MJfNTdBxi5uhhFDFGzqWR8EYQIiS3U7
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b0674f1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cPfzbt1C_6B9HWAkqhEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: QrXreuhiV5auP_3eZEevAqDNLd6Ob8Cg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyMiBTYWx0ZWRfX2hlsTD5mPvY+
 f4QXEKOikQAu9/j/wJbMuugz5fRdAAydOmRiigbJWFQPkd5W3dQ5rYKSwlDwyawg8E92+3RPaYI
 u/ziwIW8E/qVrGbXuhm4kwdnHPTuSCNQuxuoh02Sfg4/qlUPZwQxPN/ql+BBkOFpLAvqRBRaxgH
 hzE25pgE5piWOhoSK9axz+JQ7kjbPAp4LumojhYMQHK09+TN29W24T+X6yU2hCahCjXFObKxqjc
 A5IcLVC5hEAEUGrEa80NbD4tC3nfzXTmPfbr5FOYcH07cvvJ3ukvVnPYMBYtqD30C1d4X6vnqjv
 UCfzYxZ/zwfbDBmFswUzDb5SeMwAUmuLDJr3LFWqlnmuZbHls4Jtznc/zClKbUVyoWAjCilM8AR
 2lYfJSuU/KjorHV5bkRrRyajnXgk+ttNncSijYLlp/XTt1s/7Rwnjz6yj34N9GBumWaH/5BuHNf
 078H65ETnI0B8Iiladg==
X-Proofpoint-ORIG-GUID: QrXreuhiV5auP_3eZEevAqDNLd6Ob8Cg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyMiBTYWx0ZWRfX1eaZn5Oaw+cx
 nkT6Bt7TdjhdcBKKxHMWM0zUatjxyW6HSVkCwqYLO71F/y4MQ0FHUdd9l0a9eXHQE4J5N2k8oPf
 0uzy5l3ukSfICDehNF0WJWii4n8W7M8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250022

When a decoder session starts, the driver sends the input configuration
to the firmware on streamon of the output plane. This includes the
aligned frame size and the default property settings. The firmware
parses the frames and raises an input port settings change (IPSC) event
if the stream properties differ from the programmed values. The capture
port is not started at this stage. The driver forwards the event to the
client as V4L2_EVENT_SOURCE_CHANGE. When the client then streams on the
capture port, the driver resumes the input port, starts the capture port
and decoding begins.

On a seek, the client stops and restarts the output plane. The driver
sends the same aligned input configuration and the other input
properties again on the same session, and the firmware raises another
IPSC event. No PSC last flag is sent after this, as the stream
properties are the same as the ones already running. The client keeps
waiting for the last flag and hangs.

As per the firmware, the input configuration parameters must be set only
once per session, and not on every stop and start of the input port. Skip
sending the decoder input configuration once the input port properties
have been programmed, reusing the existing ipsc_properties_set state.

Fixes: 025398e9121c ("media: iris: subscribe parameters and properties to firmware for hfi_gen2")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 388a36ff2b07b..fac61ece177e9 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -668,6 +668,7 @@ static int iris_hfi_gen2_set_super_block(struct iris_inst *inst, u32 plane)
 static int iris_hfi_gen2_session_set_config_params(struct iris_inst *inst, u32 plane)
 {
 	const struct iris_firmware_data *fdata = inst->core->iris_firmware_data;
+	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
 	u32 config_params_size = 0, i, j;
 	const u32 *config_params = NULL;
 	int ret;
@@ -693,6 +694,10 @@ static int iris_hfi_gen2_session_set_config_params(struct iris_inst *inst, u32 p
 		{HFI_PROP_AV1_SUPER_BLOCK_ENABLED,    iris_hfi_gen2_set_super_block            },
 	};
 
+	if (inst->domain == DECODER && V4L2_TYPE_IS_OUTPUT(plane) &&
+	    inst_hfi_gen2->ipsc_properties_set)
+		return 0;
+
 	if (inst->domain == DECODER) {
 		if (V4L2_TYPE_IS_OUTPUT(plane)) {
 			if (inst->codec == V4L2_PIX_FMT_H264) {

-- 
2.34.1

