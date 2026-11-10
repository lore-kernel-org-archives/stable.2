Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304701;
	b=xWNCw1BZdNCOneyz0P6k7t94MQi0qaJo7G8idbOhUXUilP9YxVXDOLsHT/KSr+vhy2Ly
	 os3Lggkaie9nxfDr4ygtPqljlsabHO6YU8N2eqp0MCh3TGNhtHOqbX0LpaTN186PEvO4S
	 U2Le1DSgP/mc+oShZ/JZgFzHSbz+rin4+zg/emct9bJUhweVq8uw5LWSpZU5dW+T09aEE
	 eGeyMW4VE43bYG2KhrJ2BBxVNjf0m7us9zg0apKSa18Aurw5Qr/pGCpc5k8cHxRpuqBrP
	 Ko8wtnZnwsJybVgN1ilMKg/hbUpOW2IAkllfWhIEprL/kzVTC/wsZKTtJ2PjNJoPjmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304701;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=;
	b=xGiDUcWkNh61L/XqtLqknytglGJKMevhGgPFr2OnGN6sFeZmh2eHctvYxUkF/Ucm4qqY
	 sShxYT/4U7IUJtkV0Zw+UHjF+xy4yGXwISWpVBDz7T4HSnCXE8QbFmrR9YUjw6VE/Xt2U
	 mGwWzPLue1gS/bTq4grEo/h7ut1EWBt2QycPs2qRUxZ2DtimplPNVQC1VKXVTsQNbI28/
	 VjFUbnO9hfQB4i/OCbclg7hUhRf2IHL1Ck7qcRwXJTXRA9G8SyPTbVvYut5Gv2NOwYdlN
	 YWfSaM5i7/AzrLuPmnhKlmOkhtvEJteF9+6h/nI7KrkKjTsM0XXQ4aeWxxv6vFK2C0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BJ+9Xxz8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KnUfnFC7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C65606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C65606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BJ+9Xxz8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KnUfnFC7
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7lDd73392609
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=; b=BJ+9Xxz8F01ulYxz
	Q82Rgc1TLeuaSLBIHQQNL/D4L4QXiskoc2JiS3ZpiI7i4/VN16CqbRxEkZpkcgm8
	Vl1q34xADLUNWgC0zXE/5Qn+Fa8WM073mrE7ACJumvVjiH/MQ3x42jMjC7m9oCJ1
	24VyP9xr4D4AfFk7yb3jUQSzh9PaVfYsoJbrgTDJuhgsMhnBveHyqqpN1D8POIBc
	JGhsOll/gl/GqHW8L7DZUOxrsy0YfrhClZIu03g5H3wX6cM52siIhQSBOmsr7CMd
	jMKYWLLFTj/5Ucm6PyqMqXodNu2smj/yHoCAR/XUFUGln3PbFAgGeaUDT+WifZDp
	kPRs8Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg2wk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:19 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso2577631c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794304699; x=1794909499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=;
        b=KnUfnFC74KNQ+wedcS1wV9av7KBnjR006xkYv7PfmG7v69mUsdekqgJE0tuywt1PMA
         jVPWHUD7RClDzZtBAxRJ2xFZqdp6GmoYP6BiHq5/YrNvjyFEMLJsvRAEPqca4p1Iq0Kd
         rhwGJCDrEdF/lnbEFwRY7QF5mpZ85SPrYlYE65/9lA5/pDgttodiMa2tnu5KdqSFe6u2
         dTJKGvff46rFW+DhO5FD9B8skwSVDx3DpQxV0/r2PUWllha3ub93ilTXnXhPRWOf+iFe
         pNChOlnfslfMvbOyr6qeSgx5yL4QykP28O00k8gDFQMeEXpbGDqp7ekJp4GqoVMsvPM8
         suxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304699; x=1794909499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqy6zyuLBCwAdtPhdOZplOyEgkf/hkcPoJxQXGo40zA=;
        b=WXkzkaaWxTq+W/p7ghQqgPrx+qrhWq3XmYpCbiSRhhg4O86LMxmYZlfXM4+wl93thI
         4HQXEPjoscPoKa+bdQks1u1mxPWP7PlK0IFVQfShaOXEXOl9w6wo20vf1rPEN3xedd5b
         wsjK3rS8U9huhQbdpu+AQ0wPeV1jb/TCOdFx1nKZPHiPudE2mXsyAHeODRJ0EqMvoLr9
         ckiZeWXmeSqO5A/NXawkaAcEvfvCohlhTpUoAJCvUD08p5+ASKGVSgi/FWa6hrEjWeig
         HRdrbBskwQLmt3X9CGnP4sPpmxL1GQxSTmSFdFMo1wysq5tMs4PMRpfK2Z6hck/8ls+C
         6LWA==
X-Forwarded-Encrypted: i=1; AL+hErH/p5apS+wT3LeTy0HYK8VuYUfoscd2/2GGLR1v66uo8pcH4a0w8iZZ45aNDrOdoOp88VirSV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3lrltAZdpJ+ixgwmffME/QSLSqciI82PO8/eb2WoM5DS6mOH/
	sTrWDxfTdQyLS5JixtcjoZN8YcUsFJiHiYRkO5cQR6oO5kr4UcolBqmPLfX1gyRJitjDJA13Nny
	BxweZeNFz+lV9mqUehPWUXtWOV6utjjlfO/kFtsyYx89tKzsUaW06erBLruU=
X-Gm-Gg: AYBFou2LSUsBBq5U+mJRYW2y1geJMlQknzZGCe9f6TNhtYIlqA3T8SygjvVSwCgHn2I
	XOLwmgZJHASQu46ERHGMSwXxWTyVHCeUmAAQGd4wNyBFUXuu7W+8xEJhL57mTi4eWi7ep5X8LGH
	9N1vpB9nMV8560qQc0UneaSWpCcz/k9KpI7w6/Tt8Gayn8S5HHwB6NIN3V5C7RX9cSqY1yoF2sx
	ItsImTOHbAoisyDuQRi4/4CJsneT3FZEQEnPCCm2+OBD98o3CChFjzttBJMn3AU5KO0BwFtBQj9
	7OrHLIKmkt7eTdVWMeW7jeafn5fOivgac/J53dlNdXfPjkNJU89HFMYnUN05R7TT74hQg9gfXSi
	7te+gWffrzzp9NwFw/yoE2ImDHojq/48Mdz17KupsFer/eYuYy7hJY9SbGiSOjmtXdOkjGvU+ZB
	jXWv6EHg==
X-Received: by 2002:a05:7022:b90c:b0:14a:8df8:56c5 with SMTP id a92af1059eb24-1b3b607b487mr2969496c88.26.1794304698393;
        Tue, 10 Nov 2026 01:58:18 -0800 (PST)
X-Received: by 2002:a05:7022:b90c:b0:14a:8df8:56c5 with SMTP id a92af1059eb24-1b3b607b487mr2969461c88.26.1794304697646;
        Tue, 10 Nov 2026 01:58:17 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm7333141c88.7.2026.11.10.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:58:17 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:27:13 +0530
Subject: [PATCH v2 1/3] media: iris: Skip redundant decoder input config
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
Message-Id: <20261110-fix_dec_seek-v2-1-210d8c4fc31b@oss.qualcomm.com>
References: <20261110-fix_dec_seek-v2-0-210d8c4fc31b@oss.qualcomm.com>
In-Reply-To: <20261110-fix_dec_seek-v2-0-210d8c4fc31b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794304687; l=2308;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=J+3ZsNvdFp2OxHwNoqL05vud6cfNJiFhDK7G5hBgPFY=;
 b=lzO9FTQ3kd/3K/7lj8dJx/QiPKGwZwGTzVEkzT6ce9a77Yptt95uDUNwrV9TjLHmHQ2lk7HyF
 IYO9duH/L20AtQPaMOTJv1qn2rXYQhYcz0L1XVAs/hXh/jhNj31BeQZ
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX7tj5kLlim1+g
 39wNUPJciG7e3GRIEcciyydGTm3MUvBy5+ZOCQltkg0IWg6+6I+QkSU9sfWfiD9BvuGElEv2UWo
 WCihoQ5/s5ggly0xZn4300AlLK3d+WNOFbUm9vstgW3Ra5il69UGpaffobSCtWuN+9pR1c8W7bF
 2/YcdFhOExNVJHwq/jwVHGpbP2sh+PuEWmn6nUMQSB46MSk5h4B4xWP85GU1SRJ/OJBmzsStEWS
 /i7YlSaiIB/GxDpz9WcRcDIT5BkLjS4xKNLKgHzYU+mEgipk81L7St4IPTtHLX85hHvdSEje68L
 d3pEbKDYnsO6UbOGQVr+0X6n90b/Gknq8j8hz7F3mXINGonqgjSUZnnGa2R1du0wnt1s8dOR/nP
 /Inl+pVAwjePWPrc3nIjvkVngMQte2Gv8qpzXuwMfi5Qzq66bpCEyAXp6gpwTLIUaRVFNdwsHQU
 IILGsXELcz97T75zbFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX46byTzuVJrZX
 UfEQvdwyhhe7RWCrTjfzCQ+WnGtgu6pvRn6Ib57ZEAdoxjlXBbSC64Ezbcs98q0ZS4AdxGQBkdc
 bGUoZyeFZkEFC8k860EBWl/yHu8pGMQ=
X-Proofpoint-GUID: Q_9BVOuLYs2PoqxfMcU2ZwXU01Z4i-eU
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2eabb cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cPfzbt1C_6B9HWAkqhEA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: Q_9BVOuLYs2PoqxfMcU2ZwXU01Z4i-eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100039

The decoder input configuration parameters are sent to the firmware every
time the output plane is streamed on. This includes streamon after a seek.
Resending these parameters generates a port settings change (PSC) event
even when the input configuration has not changed. The client then
receives a redundant resolution change notification on every seek. A seek
hang was observed when redundant PSC events were generated for the same
configuration.

Skip sending decoder input configuration parameters once the input port
properties have been programmed. Reuse the existing ipsc_properties_set
state which tracks whether the input port subscription and properties have
been configured. This prevents redundant PSC events during seek operations
and avoids unnecessary resolution change notifications to the client.

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

