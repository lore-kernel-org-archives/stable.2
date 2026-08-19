Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E03CB553
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118921; cv=none; b=qMt9b/P2wyrdo3V6CHFCBkwH739Ce69t6/LlFJUZp5enJ4m5KSoXNrkw/PQIcH8OyAyxHMK/S+ECHe+dtN8ljCxD1ioMNLItjytg0viwvXpZf1lwXIFyGCeFPz4+KxfMW+MbiL4zTYGC9vlb6nKkzNTEvdeMPkJcRVJpQ6RRScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118921; c=relaxed/simple;
	bh=4lK40MW0JiXwPPgcQnZ5wVP6Rxt3lQ0MuyCt16SHCd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tzazsZQmCijUbkguDlUm6QiGXA4cUNAlO49Eo4EBRM96ew1zBhKNodG6CnwiSNE6Ib4YXAgNUg6rciOuJdYocT9r2Qj4PTjxO7/EdYEi/lNXRjhDBi73KIx51hY4iSpDReHQR+UKkl1z30Dy60yn/ZE3WeKgNlabPJoRlVQ5YHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbrssA6d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1pVqEUI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbrssA6d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1pVqEUI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J5I39r3518397
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I3WQSoCY2DEuANPwbFKOxi
	ctvfg0JzZbSPwoXKFjaM0=; b=ZbrssA6dq2EelnkZdBQJrHPBe5BMAkAn8SSasd
	ABOc4hmpcI4DD8Y61CCidCyOjfJ6DRXZOoCrVCduEz3FQ1S1Y+lYqtg70089bhz2
	Gu034LzGRfIPpV6bAlvny/ObDTgOulBpsTviArT87jmSOrq6vmvustSXzBrgKCa2
	SSBzl9QOejXtySIfSdRISMNoVPHoGWBgfUo9DVIiGIv3DL/HVn2MYBe4FRY14Vxy
	EiJyND/jZVwerQh3vY/YA+27VbPdidiJBnhWXHL/y+hzzDAIWBHOrWsMUS0jiLxd
	XG/6nQ6ctx2puMW3s7WaZA8ABqRlPjru1/ST2u6dPMVKEJfA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfk9k54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:55:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so7373451cf.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787118919; x=1787723719; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I3WQSoCY2DEuANPwbFKOxictvfg0JzZbSPwoXKFjaM0=;
        b=f1pVqEUIsNDRTxOzCp+OrHGxtR7q37PL13iXtZ20fZcU/NxZGzEfXl449+eJ8i8nXf
         zSzGXHYK9t7iNKpQ6N2/MAYpVOD7VBAaJri5uZvp8pUXFqr3/bG+MZ41zc21C3EWgkDy
         SjjwZ9xCZSlqMnduyDtS0HJS1ffwmWNA278r3b5wRVG8DGKF1CBjJUBxxXwVjy158Gt2
         LcpZ81jQ4vHnAn/QSRM9+KIf90tlcaapX0e11GsYcAWFS4I2SQtTFGwHmgg6rfy1yJ78
         3YFeSESKEJc9sitYZHbK5Zn8YLk276F+VG+op51m8odUoKTNyBZTeJI662hCrjfBgyt6
         Kz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787118919; x=1787723719;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I3WQSoCY2DEuANPwbFKOxictvfg0JzZbSPwoXKFjaM0=;
        b=jHOxEykDlzacP6O7XE64g8Y0nvbIN/4NyE4izfIk0rE5YWnSyTJBBrvo5ufZtTuQNT
         34HRRj59QglJnu74e5Zvx3nm3Gj9Di77thMtWecK2RNmjpnfJYQYQSoTJtVPzk9L6p4x
         9KLBlyH1EoA2gXO/SevHzR/vaB96nqh0OP5CXLka1hYiH1gd83tCJ4LbUSpqDgECu6SK
         rQRgc0XcpbU6YC9HUvLUNzCoBzHcd+wTFSDYIe93gKLcpf/9c3KNXl5Wb0d8Z2xAudfY
         UiVz/VG1HLBY5ZpQBctJBDDcOqB/qRwSCxYdkbSVL9NmztSWVVD6Uxg7n2dO2CZ5jaMs
         8Cjw==
X-Gm-Message-State: AOJu0Yx0HlsKM/gVg8TxElvprNngiql+B02uLVPvTiX7A34/gstTqOSq
	/PDC/akoU2p9FoyhPRQ23THk83mqRRMUtHKaLVIHqRs/nJdPbn5RtZVpw3xN1HUF9TeDmwiupVo
	aSVpYCWihU28t2EtDn9bZQs2wO1DWd9oIkKQSWFDGopck4mpzkJP7bgji9xM=
X-Gm-Gg: AR+sD10uQF2JcPDGh6V72yau4yfh2gYjiG9FF2BtxPWJviKFlp/nLuYTBNSZelmft9e
	5ZshlCVBci2H5fzoGEiKeobpc2bNktYOSbMh3LeNTERaPLskPVBBTJGtODLf0a0HgnThMMZxVHT
	L3teAdjrv5hM4Mo948VKKHqJAvpNN1oQeqS796jNxhNMSNKDHBeiFEoUGqgr/TXuKgO/CNJWMZ0
	60UqkXRQNX1uFKEuEqGSwiN1vbsj42hxX1G2FDuhiovdlaTiN4fLnTiGxPH2N/VqxQq6vxOLGzM
	FBF/+M4prisdlg68e2I1Y7PeLqokkhGxGklwORaoHCuHP8qZv9nUcgglUg3UlaAst03oIF93/Qv
	ZpMuQOHus
X-Received: by 2002:a05:622a:389:b0:528:f72:a986 with SMTP id d75a77b69052e-52dd6091f49mr19290531cf.44.1787118918521;
        Tue, 18 Aug 2026 22:55:18 -0700 (PDT)
X-Received: by 2002:a05:622a:389:b0:528:f72:a986 with SMTP id d75a77b69052e-52dd6091f49mr19290211cf.44.1787118917975;
        Tue, 18 Aug 2026 22:55:17 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c46f2sm3831162f8f.29.2026.08.18.22.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 22:55:16 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 08:55:08 +0300
Subject: [PATCH] Revert "pmdomain: qcom: rpmhpd: Add missing MXC and MMCX
 power domains for Eliza"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pmdomain-revert-adding-mxc-mmcx-on-eliza-v1-1-0608e7900b9a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADtFhWoC/yXNQQrCMBCF4auUWTuQBFutVxEXaTKtI2ZSkiqhp
 Xc36vKDx/82yJSYMlyaDRK9OXOUCn1owN2tTITsq8Eo06mz7nEOPgbLgnVNaUHrPcuEoTgMwRW
 MgvTk1WJ3PHnTtroflYOamxONXH5X19vf+TU8yC3fPuz7BxexphmMAAAA
X-Change-ID: 20260819-pmdomain-revert-adding-mxc-mmcx-on-eliza-647d25519f0c
To: Ulf Hansson <ulfh@kernel.org>
Cc: stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=4lK40MW0JiXwPPgcQnZ5wVP6Rxt3lQ0MuyCt16SHCd4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqhUVClHbXfiUVvResDSUZ0veKIjI8MtA2ka1aX
 pBGQHwDGpyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaoVFQgAKCRAbX0TJAJUV
 VtP4D/4vyRFW/ZdT/4cZg0uR/hdXDHFJu6AaLoe2oezopDD3P/SCBOy0SRkJiZJQ3XbJ1p3W1D1
 c0W8kIpNftMPsbGS1ZFbcWHugqg0J4Con8b9u9PbSlxhW8tz83JX4A4vDG2RYkGOMpW/HLEsB49
 l/KGHbb7M9jdgdlVsudDRIvnXD5z3a+adlbboag7D0MmEybDwJZKN9OH7PlY9NZ9XpVxdNscO1z
 QdKJuYDZsbsvmEXAPxUHTYtPJuV9C+LT+S4aeL9qjZBTyT0BnGdP0ED6rFuSKQQBBtBMG+ggMIz
 6LzsG+cKrSX9EsRfeAsAfLsjfiKci/Wi14uQ8O65cSu27HoTbGlDTQt8XxAPpMkNPJHzxlROVV8
 +CRzJawEd82EoitG5Qeb0LpymweseN5XUFc2YHvWe9CsIuv51/zKwzqvTiKaRMUqGdqbhEV9VOr
 0yOu5DF+AqG4WzysBcPbctujIx300dplWvsF6YD8+HqCkFBkzmtyqZ2y5zhEurAmSa+PEFXtvGi
 TNS3sqTmYtXA537eHce8gb9+Fmyaj7pqbu/SKZp1tNPOJKS5P82u2o/qVa5hFCOgjFBcmy0kPmd
 7WlM2WMn4huTK8R9EdngN5L3HjcRJhSwDd/w2k03xShqC59BZhoniGn9h7v6tERpG+WEvC3mv/k
 n1rlZYKmTyBbUVw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: rNE4BANs8ANR-O3c8axg7lJNly7RgQlm
X-Proofpoint-ORIG-GUID: rNE4BANs8ANR-O3c8axg7lJNly7RgQlm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA0MiBTYWx0ZWRfX66405VXYgUgA
 VUugBO32KcfUuUVhxkjvDS9loxRetWBy4gQnZXAbqnlDaPIQCJ0IF0YoFuMQecuBprthYbnknj7
 CQ5bjUGmXftGIJYKQUoLrCdBnA9tN2u2c/GL5PlV9tSp9Kc2GsK1G/4RIGj5FovVFw50le+h/uf
 n4+ID9ixQxoxIb6lBkUFydY19RwopSwSmBnKJXovS1WwbEGNvRxcfl+fDYlLPbfmKULC6Nq4ESB
 Uj1cT7bze0sJNyIPjaj0aYXO8e3uQfrx8QzGZuNWJgFGpsOYz0/SsTk26snAtKFiiKIMA1oROf4
 rFf+13LFPMQ4+84OPnoOCiE2MboCo4DcI+jZg9cQveog3GMxA8AG455EmNYD8LZC8u+IK55ooQP
 9U/4M728yqoZy492i2jwomr1MI44bhwmtIlpDdgoIndnbK3QfceEluqSDZXErDe4//zIl4/SvJr
 PhPQ61uRzHOR+CV70nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA0MiBTYWx0ZWRfXxh19KS6kkYM4
 9P6rFP36Vr2NdjrH4DjxXwfKdMjAuHpxvJfMt3Vg5FugVgkPbgtX6GUwhJpE59Begfljcb/wKkC
 YIrShx6+mU3bH2SKQfXmD33KnQ8rAq8=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a854547 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1b-Pq1L26K3AAw2ysIMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190042

This reverts commit b48a0a0a76ccecec60f0568e2af4d89994b08bec, which
wrongfully added the MXC and MMCX power domains on Eliza.

Even though they are indeed available in cmd-db, which has been the source
of information for adding these two, at hardware level they are not
actually wired up. Therefore they need to be dropped.

Fixes: b48a0a0a76cc ("pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power domains for Eliza")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 96e4bd2f5a14..90743275942d 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -241,13 +241,9 @@ static struct rpmhpd *eliza_rpmhpds[] = {
 	[RPMHPD_GFX] = &gfx,
 	[RPMHPD_LCX] = &lcx,
 	[RPMHPD_LMX] = &lmx,
-	[RPMHPD_MMCX] = &mmcx,
-	[RPMHPD_MMCX_AO] = &mmcx_ao,
 	[RPMHPD_MSS] = &mss,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
-	[RPMHPD_MXC] = &mxc,
-	[RPMHPD_MXC_AO] = &mxc_ao,
 	[RPMHPD_NSP] = &nsp,
 };
 

---
base-commit: 5453bc3279e9f8578ac3e534d476240e40c879e1
change-id: 20260819-pmdomain-revert-adding-mxc-mmcx-on-eliza-647d25519f0c

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

