Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680874;
	b=Ar3d3zdMe+4cijigGxZTMEEwIRp8kW5CDrx0/dhqC/vuXZn2J1jFZr1pSigyjUwlfE17
	 A/3osgA462AFpaMDUYUeMI6DTvvTLt0Cx4PLSTTVd5/nVyrk7Kq4mtCytoMiR7tBXeWyo
	 C2rEjLDw8yRDQXcyj+/c4Fao2KaTi445umkiaQPn5SSCMjXfjcnUK5RskoDI5ghRpG5ds
	 8PZBw3TcRLobybhj4I+3ePOE/9GSlqFmMDcpZ1YWINSIsNexvr5KBNXiMlWFhxrqJbsOD
	 aoQekARmGnhiuSbwFfX5lxfxAYFuxt6H2HtcFia3ZDhG2RJpipIQI/SCYL4msll9nlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680874;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=LeyVFsqCqVWi/yTiZu/t1rp7LlLuz+7A3YoONaVMHFI=;
	b=JHzNNp93fSw7faYTh9CJv/vAc1PqJugT4TxurWt03DRKM0QMG99fCy0YhxrcgvYet2eh
	 2UdQOL/+waBXxnfjLttXNvs5MfBvtb2mkJxkXwwvZRErJ8EWgdsOpDtJyNHxIJjnnoaaq
	 L21dQIkX871IrL1rnkFdBswnKEFpk5ZaPeaJrme2sjEk8jd7xRlbAnZtOr0PNqoh17d+0
	 BrxZM0Avz2sEP6yttp0BEVGpEk+QdiPRK7gQyOjskTyRHoXjtL6eFD+2WclLgOfh4JFBK
	 eHjIXAdIEQIXnYn019yyrr1AbXbA6RTjvLLkixfl/OJfcD6lzYcckJmFitNekQs17GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="FNu/nGsG";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U1e6LBUz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F86606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FNu/nGsG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U1e6LBUz
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEFXci3771501
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LeyVFsqCqVWi/yTiZu/t1r
	p7LlLuz+7A3YoONaVMHFI=; b=FNu/nGsGUGijxpOunvpAFg313nntuufV14mIIT
	limhirkmXmrBmRiwMvw88X0yLt8F3mvnvnMn7CGMJIS+DqODnB4qclY7195jk+Nd
	pX2tCdXY9juGiSVl9+xBVskQIpSN3mF0GCoHK3lhc1S/1gwlf10hpmcJXAA7KWjK
	kpcVpTskb1YQ9gzGVFlCRERPzQ69inOCwCpzrjTGZ5HxPF0zxyon0x69U0Wx6UnF
	5FkR0UAgWNCVxTdyeqvuuRl3ItquW0v6dNmHjNsBv5uo0cxj9OyF6ozYDeWf2fBd
	D2mJrINo9nwDH7SaTv+YThP1Jtm57LzImeRMatAIFS/A8aEA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bvah4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:54:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so4418212eec.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792680872; x=1793285672; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LeyVFsqCqVWi/yTiZu/t1rp7LlLuz+7A3YoONaVMHFI=;
        b=U1e6LBUz0vYNgvi01E3wOd3GQxVmW806KeGOQroELH4ui18WSPYG7mUwlluqia4lgg
         INPszpMI9kYMXordzyfQ17RjY4Ra4UNHynAa2BTfsHt20YqcEpKF3rM5xiE2sVvptCGD
         MGsGH7jrTijmXV1tUVfnDdv2/5w7SfxeWUt70nAro724BdH5BnYkN07XH/4zuJdySpPE
         B9QxHo9qa2clAU0Fm2I96HLOwHDllsSeGVxxus6RJog+GVOcucZedokFYP4M47ewymfW
         AYe9V5l81xg1Pcc42XLWWA59+Ijj/d2v1Wxwu3gYuiehfoqAbqdT2JKKAs459XQLXBwc
         OyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680872; x=1793285672;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LeyVFsqCqVWi/yTiZu/t1rp7LlLuz+7A3YoONaVMHFI=;
        b=FvftElLIlyhbr+EogaXqogPOlAgcsOjnMaXYqez4VJQGfiRDCAWPWiCwyL8FEwY+Rb
         e/b71cMjTa+pY06WKPAI9BYMT9N4wrzGoLfgZhLTfTbf9OXxKw6SXNoiWzA7rB87nnZX
         +IXSppSs1F1b3OPdFbwwgWzJhbZbasWN9HYjNpqdilWuUDRaxJgrVsSLadVR0p555QOz
         dxqrEY/fBd4fJzANgk7lQgkq700RSKBrxDbcwr8PH1kLBZCIwn+klajpDiA8SSQidBfR
         z2T1kEp1J9y82xIte1rn+bhFY+kZJiBu/0hjkrGHObUQVlDNmIhIV5/vyXfhdzvoz/4A
         m9qA==
X-Forwarded-Encrypted: i=1; AKwUvBwUhpL5gW2MV59aitI9+ziTxprEkV8nJNigPn8rmB1roScnxp+Rq+/DcYY+UkOyz7DqV+t/c+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHjVijxRFceZd7rHQPHFYRauiC+2SBfLQBolF0cntIHxBCR5Vy
	EwZnN7jh1PRjfLKxhLm7x/voHd7zRauc3g+F3AeX8PT34SDd4nrdDjZ/PvIo0hjUDlIMIpnt8h7
	ec7Z7xoY+EhoQ/kchqWp6AZXH+ABCihGAcovpZwqbn2Gku6ZgNXBjcu0PvT0=
X-Gm-Gg: AYBFou02ZtJvm33UWhV/bUlFdhSJ6uKB0q9AvMBZJxwwMg7Hw6GXr9ISzPuIGBPjwpl
	/VAJ/l8yRU1fdLfKP0rdLD45N1yBBoJdr+Wta9uIbgy0dQx144jZoFLeiYpJGMg0RZg9xeJkbUz
	gVkvqZk4ziho9JK1RK76YY3MB6MD5ZglLZxjyK2D6kd2X/fxXeBUto85u1L3Fgka7KyKe50xTUX
	rhYhsVOB6Qt/ooNW4eMBuEQ8s0uhmbWi3QpyNydNKpL0ihLRm8ewQwUFDpAC3HlcoaKHaXUl3hL
	IIKmKPTZ+paIf1l3KTx1UpuJIH0FHQw8E1eKNCnPINqTbD1X/920EXJkQvO/ZazdZhD/Hq9m5nP
	J0zYe+soRkaskcZWz+Mmezkl/nsZLQJMU86Y0
X-Received: by 2002:a05:7301:8615:b0:359:8492:20ff with SMTP id 5a478bee46e88-3674c43a7a8mr6978996eec.12.1792680871418;
        Thu, 22 Oct 2026 07:54:31 -0700 (PDT)
X-Received: by 2002:a05:7301:8615:b0:359:8492:20ff with SMTP id 5a478bee46e88-3674c43a7a8mr6978969eec.12.1792680870900;
        Thu, 22 Oct 2026 07:54:30 -0700 (PDT)
Received: from hu-anupvish-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm26250257eec.18.2026.10.22.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:54:30 -0700 (PDT)
From: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 20:24:25 +0530
Subject: [PATCH] remoteproc: qcom: pas: Release DTB firmware after load
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
Message-Id: <20261022-b4-qcom_pas_dtb_fw_release-v1-1-d92d84a05544@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKAj2moC/yXM0QqCMBQG4FeRc91gG1OoV4kY2/G3FqW2oyWI7
 +6qy+/mW0mQE4RO1UoZ7yRp6AvMoSK+hf4Kldpisto2RlurolMvHp5+DOLbKfru4zMeCAJ1rNk
 43biawVSCMaNLyy8/X/6WOd7B03ekbdsBhcScl34AAAA=
X-Change-ID: 20261022-b4-qcom_pas_dtb_fw_release-95c140645cec
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792680867; l=1584;
 i=anup.vishwakarma@oss.qualcomm.com; s=20260805; h=from:subject:message-id;
 bh=40dojUEYiTck5avIuh4BZLBGj7u3joSJCzFWspEillw=;
 b=HMYQhkmCsBufTsqpejcDU81i+XJ/9B031qiPCSbjZs8maM+zPlzrmJBFmkfKc+l0CN3jB4U1m
 iGFeS0C3y5/BwCarm9Ozo6DDo2U4cHbU3laE3PXpypjuIp5xiJveJQz
X-Developer-Key: i=anup.vishwakarma@oss.qualcomm.com; a=ed25519;
 pk=Y9ilCu91UQrzHOM14SG2IjnmQ1QSroH5uVeBSWEmEDM=
X-Proofpoint-GUID: soWpIpsLoLoRPCIt11PioMC4_c9U85EW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OSBTYWx0ZWRfX/Q5KrTvF7B+J
 B2GNQBGjmbpVrcxIoMI+UinUoPiV7ROcjaMXQTj8tTbRMjoK9aPKT2hcJ8VQaNdQOX9emcnn0Ve
 /MagF4OEEklTpGPYbanXwop5JaLkHg06nU90gew+RlH9kSR85mPoXtBIz+AOF8iUBsz04gXKouY
 tXFm2w9bVuL2YP/KJXJyfdMZZ3r2a1e4WRrEhX3kYDndBtp3pbVr+WJORhjgMVFd/Qhj+s4IsIr
 Q+GWBRDA/LsOkwG8O3ZCSFWPdztOit3oAFNQg8UpAyzg71ZnoEui2o2b98SPqxXVpQBaiiaz3RH
 JaW6KYjrfeR682ufeBTLoXDeC1SB6MDeDQRU2Yh6lM/IUGEUMLN0XscN5Ey/+gP0XzKYjTiLFsp
 1Dk60N4+sbvdPbWdsTrX8GuCfXV7HKcVk7XV4eTC7AI3DWjeO62PC5MfakOqTUJf+uqZVB9Jx3F
 i+3fQA5YqjdWeitn59A==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ada23a8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Y1IhKJFcC3I6eYhxwIsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OSBTYWx0ZWRfX9DcrZ6ZrOMep
 yeqobE5GBqdCEsZxcNIt8MZd+cVcCowzt2sw59+CIfCA3iqFQBKwsfRMoLvEIOt5Mx/DczRQwK7
 z15X128SWYLNpB8oTHTrwLsqFhDcwg0=
X-Proofpoint-ORIG-GUID: soWpIpsLoLoRPCIt11PioMC4_c9U85EW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220059

qcom_pas_load() releases the DTB firmware only when
qcom_mdt_pas_load() fails. On success the firmware is never released,
so the DTB image stays allocated, and each later load leaks another
struct firmware and an extra reference to the shared firmware buffer.

The firmware is not needed once qcom_mdt_pas_load() returns, since the
metadata and segments have already been copied. Release it right after
the call, on both paths, and clear the pointer.

Fixes: 29814986b82e ("remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 2e1e39826ffa..2ac21c502d35 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -279,9 +279,10 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 
 		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
 					pas->dtb_firmware_name, &pas->dtb_mem_reloc);
+		release_firmware(pas->dtb_firmware);
+		pas->dtb_firmware = NULL;
 		if (ret) {
 			qcom_pas_metadata_release(pas->dtb_pas_ctx);
-			release_firmware(pas->dtb_firmware);
 			return ret;
 		}
 	}

---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20261022-b4-qcom_pas_dtb_fw_release-95c140645cec

Best regards,
--  
Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>

