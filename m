Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF899499F25
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478826; cv=none; b=iEUXCDcUVBxyQLNVaEiW/dR6aJhI0s/xKnRE5oX9+xGOhiKtkO4ErseHlC3gtnCPKunJKq23luBYkD3veHD8kxuVPvHBjw3/xG/FcmTf9cqP3iNfeJnX3aGvj7oiVnIoYG432dGj32TpxmMuphpK/khUV2sn7y5as20FJs/5rt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478826; c=relaxed/simple;
	bh=XMZcz6kYBdTUSQPlM1s/g5+gV03lvS/f/BpAkn8eNuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YV+n8CbriEJpvMbq+PjSxj6XVJNVY7T8quZImIruIAl8NRe5LwcBAS9K/punZE6J0e4AKG916xDe+z4PQ/tl6dm1Ddl33zzsS3WZtkkIgdE85nK8DINwd+TKTZvCGQQqum28muxrq9jLcyozn9oeTvHV5vAfn1Vm8BhaEPOnS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuC/zuaB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L9EqlGsd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuC/zuaB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L9EqlGsd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD4sFS523343
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbqlJQjQyZug5ULzZ6y7JKD7Ojfb/phQ4FDoOtOPOVs=; b=FuC/zuaBUxqxNEe2
	qH5/epyShHcCw1cchQDsHN1wiKCMlgk0NU6hwCQWJIJrknym89MmBUggFQo/FF2A
	qWF9kNstIb7t0OgUOqMzez26mOrD5QOUzMjTybblCQSGXS5SL8wTlPpThQbkk1zo
	/0AJ/ypH/tMncHakRUBBRssr6XlouefATcBULaaTKxkTcCnrU9kqpsKTulisBI9o
	Z3zc3q1vdGdl9T6tX3x5npDa7MWGD3vx3llrvqw/ii14KoHvBgXwg4ZUlW0zWldM
	4NfLraK7+9MxB6BoeRP15tlTubLnhmn6Alx7Itwa1Snr/n6OlD+8oZ9d5rPLvbVB
	+mRd5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc050q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:27:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f925ba4eso845794185a.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478823; x=1790083623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbqlJQjQyZug5ULzZ6y7JKD7Ojfb/phQ4FDoOtOPOVs=;
        b=L9EqlGsdUqO4MtB6qKvGjWO1XBv9s41n+BxPHK59d/VwiMueofyndYFvsGIUqHIJqg
         e5Lqwus3Re4vfFif7QiMj/dh6uJ9A537Se4N38tqQJ9YdMeIUacQxzlYl1OTjPv1iRce
         jR6lP3BzCNU5TZOgIXY1+qR5mi2s/1H9SR0/ebcgOKE3furUtcXCwVSYBIxS6cdYdSlO
         nWypjqJAkUbVSFSnLOiG7FC3bMdvgTPUljJv+JhuyZjG0+gDouQHR7pfvsR1D2jk3nbM
         2jp2ChE0Tzh+6COgHtVXFcK768QTK5V5vF7nZ9IF8Zykw/VqfhM1A8BNAXXjVTqkGpn8
         63Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478823; x=1790083623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbqlJQjQyZug5ULzZ6y7JKD7Ojfb/phQ4FDoOtOPOVs=;
        b=GXYIZdsMCbPj2GCinWKenxhNz/1rCidEYitwGLTv3VToq7+IBNFabVeWO3d+KSYC3t
         1JlOEW9op56ngcF4qBhBNTEl6CEikySBM6ePpPCME/QMRtuLBHFNSKYql68pshV1VxLO
         rLPz0eTgx6Vielg/EQyvol0EyJifRylAdgx62vdiFvw8wpnV6rd0PXTxNj5lMpGEAqUO
         tPhqO2cWSFxFQBoJNbL8UZ4WRWgUZJrlFvxjo0YVUU9Zh3TKvmx1BQayYoHH//Amt0vW
         tiEimEpR15j35OnAoUiyhZD6vgm6N4d1mWNdQvXg1ZluoLYKIX/YvbHh9SXjzw+HB4GE
         yQDg==
X-Forwarded-Encrypted: i=1; AKwUvBzGSlEMAc7BtbcOS87oeV4Y7rge1T5iqwa+FTw/hqonUNx9YKOdbgdi82RIjPlOvLhufVsdUPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kcbkf7NGN5Vwn6WOsXXkmr/ye8QdKyG+7m8Aiz8vuZWsjhVmeM
	gx2wxQXY5e1JGP0wixMMeMLcwE2QFkNlhhFdm4TjT9WhDEd3Lz3kfABbeqP6kQxzCageXpGZg+e
	Lg41zWMsZ1wqru/uTe6q8mqYrJRqgUZei5etFBrrxaKk5blS+Jr/DDlO/BFs=
X-Gm-Gg: AYBFou1Oi7cMrsd/vwueUpqf/0fwx8GQZGykiQD/o9R/m1AsJ+vgltwgHZnj7FQlF9+
	hznEhy3fh1anpSTY7y0tRYbwmTXVfRvCPyCHYz51wsBCWY2/v6pejpnyrjaRPxRFwZdRlsM0OxQ
	qev6qfSzKATCLreanuTcPPzYN6waco0cd0uFkSQk/1oT+Bq4zc6jATkxTH/OyaVHT70MZcFYrQY
	NF626V78Yasv7scrxa/zE2pQjhJN5R9xVrJTQPFMuWqHKE8yqRcS0EWTPThK5gS4wGfLkeCD4ly
	j7PiPXeDCU0m5Ebfq5EX2GTIEwrIWAJ9QLyXuoC8vi8U/60ouJNr5PKehAw5wt4+ee/ZxnBqIhI
	ntsXMDmx9aGCt9+Qj6OtY+ofhMkuPxQZoVgB9
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a29bbcd86mr982049385a.46.1789478822890;
        Tue, 15 Sep 2026 06:27:02 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a29bbcd86mr982044885a.46.1789478822427;
        Tue, 15 Sep 2026 06:27:02 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm1248906185a.37.2026.09.15.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:27:02 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 18:56:28 +0530
Subject: [PATCH v2 2/2] tty: serial: qcom_geni_serial: Keep console RX
 functional after deep idle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-correct-icc-bandwidth-vote-constants-v2-2-f78eb611204e@oss.qualcomm.com>
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789478807; l=1650;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=XMZcz6kYBdTUSQPlM1s/g5+gV03lvS/f/BpAkn8eNuA=;
 b=nOXSuI/UktldwjJpel37rGs1AWfUJDxcbpM3fdZBFC5keaZcGMeKYtaK3LOJa/rHbkvaviqxI
 Lt894M0YUpnCrdi054NmypRms2gV2khkH87fVp87rBot6XTAaGyEhGr
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX57wlQmhKn1Zt
 bgfR+AAM5k68aNerzQQCGYuT9j9U0xGRf7rv+gVMowh5Z21G9HzR0sre3hbYrRMGNL43H7zWkYH
 r9FdjCJpTTv0SlgaKasjbeloiXDBmkU=
X-Proofpoint-GUID: gqcc7Vym6rTEXMFX0N42gTF_YFtMZYgD
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa947a7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZOf5TxNYE7tYtAAs_IYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: gqcc7Vym6rTEXMFX0N42gTF_YFtMZYgD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfXze9avXARwZM7
 K4+mxymIYU5sAenWOH6W7Mi5C9mNyiwAhUEn+o8QFgC5Hf9l4WQa/naX3MqchUzv+Ek/ArGdvfr
 A2iQr5ZXwOVXAY8eHR+ghOjsJkaYU3dWdPqznbJS8nuEKf2n+RpQAP76TRTBpBDcOyw4y135+XY
 APWUknOMSq/jpkcSkMZDFL6kSnXfW1zRhYrG/kJFp3Nhsrx16UR3cgQAV3qxMgvIeLTPzjoA0Kj
 xQvoO46KYrXrziUi2RuNhT/Sj+eSeB4mVOQwbFQR5/1X477BiWO1HTh9odcQ2H9AfJCSLJR8ELV
 me1cXtLTAdMBs3F7eRVvZuFtuWsLKNYzHgvY38/dctsodcIcVylTqePpqyeGjZkZlfMb2cC1a7o
 RVledMrhWKwGyPtXHlT5diGNP/CQB2M8CozkP8eWlWZh8LsyjjzcjaBJwuXKwitfcaZT4cXX0Eo
 jkb6P1yGmuDdM7l01qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150195

At baud rates up to 115200, the serial console uses only a 1 kBps keepalive
vote for the GENI_TO_CORE ("qup-core") ICC path. This vote keeps the path
active but does not request a QUP Core 2X clock rate.

When the CPU enters a deeper idle state, the missing Core clock vote can
leave the console RX path unresponsive.

Use the 19.2 MHz Core 2X vote at low baud rates, while retaining the 50 MHz
vote at higher baud rates, so that console RX remains functional after deep
idle transitions.

Fixes: 7cf563b2c846 ("tty: serial: qcom_geni_serial: Add interconnect support")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..f7e81b652255 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1482,9 +1482,8 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
 	 * only.
 	 */
-	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
-						: GENI_DEFAULT_BW;
-	port->se.icc_paths[GENI_TO_CORE].avg_bw = avg_bw_core;
+	avg_bw_core = baud > 115200 ? CORE_2X_50_MHZ : CORE_2X_19_2_MHZ;
+	port->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(avg_bw_core);
 	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
 	geni_icc_set_bw(&port->se);
 

-- 
2.34.1

