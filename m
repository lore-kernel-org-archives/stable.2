Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391591;
	b=xPR5cao/gTMsEvTS44x8POfhoACO8WwMYhE8IQgTW6MpSTyFgFiPJ3kxqVGxqe+dmavs
	 C+cDVP1t8uyo7Cmbj8FQEGru2SrU3XpS1Z2+/dnVWuqo0EGhhRsHbu3zCunn2atuoXMHs
	 gGlG8IA8bku8/SWBvXn2/RKT4xwUwWGcokatMMhQW4xy9LPvu65fBB6wm+JXDRpRVVMLz
	 0qmIC2NCzxGPIHjKV3KExcTH3Ivt3mD5Rc+zvadPAKBLocVwzOiKbsssCQwnQLuOvlHna
	 166UWtEy4/IrCE9s8X9N7bvve+1cXVPdD3n4w9rgQFol7lyLuS9W5jRnsnDAH/M7qmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391591;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2kPCKs/RDRmqxYkAxTLufSJm8JbuEsv1KYBJrRSxuuM=;
	b=AHAcoSfLX8UB5IcmxoExSUYUpi/8VMpprahtn9OauRr/5GOdLQ2sNcgGrSptkHbDF087
	 wFG4sLzvolrbqkTCwuZqR21ON3nTe3IvCXBsIRc2ll1ahyoEH0ZjLCNU/KSsOZ+tCKm6p
	 8UczNzWA5GG7jDce5dEaAkVaj3D48/m/tfWBSMXZWyWM0uB3gEJRhswDO6dgvALmNZBQj
	 37uSsUJ6qx4S+miTxpQR6Nrkab17Dr3t20T414KCXCU70+OCNgeD7ZO+uNFPwyslxGzck
	 kqHq/5liAdYTPXl61ZtX1vuSEeJwEzO9MRak/0ABk0j9kxkoIBW7OtqZotnYmI9AFFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Phw7tl0q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hkAnpcqH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B617606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B617606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Phw7tl0q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hkAnpcqH
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIhx0Q4119656
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2kPCKs/RDRmqxYkAxTLufS
	Jm8JbuEsv1KYBJrRSxuuM=; b=Phw7tl0qbHAoMn2kPxpTmKvydreYwgw3+m+fcZ
	ybZV3NGFNM9zmBMopNsSXRGLe3Cn+E/dSouR8S6FL69jUMi8eEk5lR0fw8xdU3V0
	ZA7tGEwTqqlR1HwVQgHX6pS+KV8jZREu/1g6TJ3PNFgayjgyeNyaKmniomr7ztlO
	LoncEcUGJhygPoLnAP9kBJ4KAn0bCx6qoYPMXHGXP9wrMSyY8yqsy+hKFOKKUzHB
	n9A0aO6+I1YYw2VITCfi+sSKqFkIitV9vqos3VvmrF3FH3X9qE24XBkeQ1GRSKwP
	5VkhEqrOu9WliLE3eRGC2TP/Y/h5+8Q5syJ9B3Xvc468uA/Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0sb88w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:19:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3698bd5392cso945609eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793391588; x=1793996388; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2kPCKs/RDRmqxYkAxTLufSJm8JbuEsv1KYBJrRSxuuM=;
        b=hkAnpcqHxLgx/ra7LAJkcBfPoKPLcCyr1BQhHGfG0rmkEtSu/WQxii3o9xI6bj5J9P
         BZTOEB9uidKcdmnqiHxiRNjhMUnhZebgwOKO0A4xISkgIQMiKL9d237M94PHsO3vwR4P
         T9hJWlU3D+5LxwzEW63dSv09hOUsKKxjKYscS66A+BMmMIZq8QwvxP/bTGR/XFv+9fXQ
         +rMBxHtAQOTFHTAsfO2+8+cSs1j7APo6Fwu6tZIVU3BjKG+SQnH7QAqzDu3pCJ7JRLm/
         Y7BR4Bo4SCK1Czi5VMUhMGvGqrx4iNo52UlWIETjo/B0c75oWUwQYfI5At/wFLHwT2g5
         N9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793391588; x=1793996388;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2kPCKs/RDRmqxYkAxTLufSJm8JbuEsv1KYBJrRSxuuM=;
        b=iDA8gs83j8IED6rz1OYf6vdm2Rz0LKxDFHq4kuI/n8ev3/QhEv3gQQR/bU8rLqCZCe
         5aPwEOe7dx23HmC5cFFldxawL+MiekOgXLgt0SiXYIPO8jk8uRr5P8HsssLe/jhwPo/0
         Ml0SwnJRO2WDOQTiKfhVoQcjaYGocw7Pl54gR/NfbF78pgKZ26PgQc+DZGDz01duKl5F
         /oeDW6asz/877UH73GE1iQt/0AEZHRkwDQ4LKKweMtfKxMPppYAucNxnoLm4Fu7MKSun
         t7HXpHvnUJmp+97cooe2RO4eWGxLtT1IjYMM0CdOyBI12nSUeYyTncHJjEL0vtl2U9hL
         DFrg==
X-Forwarded-Encrypted: i=1; AKwUvBzhw7zjRXEkWefdhkjVh/1RqlZRWcx6EsRLTjESgUy7/rbWdc1zGO1aVCl1wTGOtrNkZylTZOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvEC5ybgW6r6YpFufoVo4XqF8RDUPCMw1McVy11svXAYZFbY+2
	Bue4BsQneKY/tgeMUEqiWwXIeNCBtitOjoIcKYdkdVG+2u5grzq/O5c7v+0CBTNZkPK2OoS8pX/
	eDAaOBAU/LN52RQursat7lWDa9fHmronHa251yxy9Af4xWzI6Qkw2TD8pN9s=
X-Gm-Gg: AYBFou08vejjK5A+4MJ0j0URFkXo36QuJ7IZgqDbJc9prJRJas3tqeYPS0B2e5slZos
	bSeuwjDOExPVrifd8gMIKTAKBCNlgnMVfvZkVRrQK50iqrajD4PqxaaK29ArBNLak+jqAzHylqP
	aoCY7li4XY28WWshtv0gYEDwQ7a2WGoKs/VgHjh0MS0FUYCxgMxMVewKafpGfqzSgpLE/1Wrik/
	1fo1ugsiWr77NlJiAd1V3NydhxXdrkhFQ7aSDr/Bh3OlIetFx6yc6CABb/VSkRzdehVUJ2wRq2u
	jBdsTXlAgin2aRxbYyN06aJMfhEdtR02V+ZQteMjt4CtWT2dAzNlvFcdLEadUUWF4DiHdG7j7W4
	Ccq86rVfWUs+rtYPLarys0moNmY5S2c0XNObKFAEfKspr+e+3vYOkm4v2G8LLpp3mgzzKBwK6QO
	It5AUmJA==
X-Received: by 2002:a05:7300:26a8:b0:361:2a55:b94e with SMTP id 5a478bee46e88-36a30032646mr9314838eec.15.1793391588358;
        Fri, 30 Oct 2026 13:19:48 -0700 (PDT)
X-Received: by 2002:a05:7300:26a8:b0:361:2a55:b94e with SMTP id 5a478bee46e88-36a30032646mr9314808eec.15.1793391587769;
        Fri, 30 Oct 2026 13:19:47 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm9300197eec.0.2026.10.30.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:19:47 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH 0/3] media: iris: Fix issues exposed during decoder seek
Date: Sat, 31 Oct 2026 01:49:08 +0530
Message-Id: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIALz75GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA2ND3bTMiviU1OT44tTUbF2jtERLI1Mz4yQTS1MloJaColSgPNi46Fg
 Iv7g0KSs1uQRkhlJtLQDdVyLWcAAAAA==
X-Change-ID: 20261031-fix_dec_seek-2fa92563b495
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793391582; l=1148;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=aBpCigvip3vzlaPahoVHpAyPFq0Wo97KNuqvQOgjQfk=;
 b=WAWWtyA7FK3dH+XMZfC4EzKghm7UFBxlf22+Btw+plZW7u+k8PJUulRWyGCo6s2xX4m3Dic2j
 BzCSCVu7mB6Dz9sgXn5B9YyIHZBBkcf9CBiVVM6qIbz5nnYdpfgqd3L
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: MIls3rPbxt96tNa1CSQ7McwCnl0z2NWC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MCBTYWx0ZWRfX9+7Ga9hlN7Y9
 Ppx5YxTnfnMK8jiSzmTDLWK9copyMYfh7HOuzth3wkmB1N0wTs46XulQ04wtO+xtlD9eviqpIhc
 GWJxEDc28ULsYXOaWftUTraaJZ3xmEY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MCBTYWx0ZWRfX5NbeWAuCWSUb
 fLq9ZMmlWqwqXHDwsCIqi3W7RrC8+l9UTVrqj2yQ7CnTv+79Up56R7HCkTSGx1UCSJOvqFxwowW
 DmB2HifZhKI09Xcd1DEjThe+N5NAxMMsWPcwOfuv1E2ryTBp8KP3riY0R390dGShH8SUcDRFIPf
 pGDWs55UQ16rL8xWPHpS2stFXKXPgovSxvcwvO5p41DZgSsVAK+PGLupE6v1bXv4SQKOIH9C2n5
 NVRVFOmA8pgjPO2JWTZvPFY5GlY0/xNwqD0IZHo5czUgO4Vhy/8AcG33RTtSaGR3KemHVxW9H4t
 xLiTDmZHx81dRAlnn+FOOxB048t8kcCeeFZIP4dV420IHV5hLwrsiYRdPzDiTiZvQdwxU99XG1G
 pnJHbdDwpSQ7U2jgqa8KsIJeg/JCp7pLDhpteoipwEJAylwkkZud4sUNRpciFG9PK+r1eVxEpx1
 akrFei3tulq/JWFt6Rg==
X-Authority-Analysis: v=2.4 cv=JNKuIMKb c=1 sm=1 tr=0 ts=6ae4fbe5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dW6R3hR6YbmKee4CdVsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: MIls3rPbxt96tNa1CSQ7McwCnl0z2NWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300080

Several issues were identified while investigating decoder seek
failures.

A seek could trigger redundant port settings change events, incorrect
buffer requirements for VP9 streams, and codec configuration being
overwritten. Together these issues resulted in spurious resolution
change notifications, firmware buffer count errors, and seek failures.

This series fixes the issues observed during decoder seek operations.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Vishnu Reddy (3):
      media: iris: Skip redundant decoder input config params
      media: iris: Skip redundant HFI_PROP_TIER updates
      media: iris: Use firmware reported count for output buffers

 drivers/media/platform/qcom/iris/iris_hfi_gen2.c         |  2 --
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c |  5 +++++
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c       | 10 ++--------
 3 files changed, 7 insertions(+), 10 deletions(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261031-fix_dec_seek-2fa92563b495

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

