Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160555;
	b=ZQG3zZp3Tih9ABRrOF3dRxzGijskG+Ywb3SaRzcgfCOZyHfj2PWRA08DCeuzHXqLaXlR
	 w9ZF90ngBQVt/WKzUJDIlnosl4JJ9idOEsUtmEAUHkXYi2kYbp+flrZ/YV1dxBjV8L7YS
	 MuK0h9J5rslL1Bu1tksiCVhs8h1gbZJG9EsZ+jolgE6vtv622OFJiMHYiUghd49STLOCN
	 f2XhCE+ZfOiRBp3am3Ofcbi9qr51UVF0Wya/x41tKtk6Cmusr0Nk6MXe8fNhX3JudUQIN
	 fz72/qcTsDWC28HcCAyszuMMB8Ef4M/1UfCqK3Mnlzr3mmrWjllcCZh0G+To2iDRRgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160555;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OJHdZlygRN2jDx54/MBmSPXGD8ZnLG5eY4JP1FvaSw0=;
	b=rUqgUQXrtlQd/WJASgAypKYG8vxFt5yQQWiGDHUKvCkLYfWtaCUlnQ19LboJs2Vz1guf
	 jezNZxghg9SG/5WmQ72c9TAhCTOvDqijmml2JsTtEWAs0LjnQcid3hH4d970XUZUIw8dR
	 PxEahMdLUDUyLcLHiwKy1Ql67jpyfuP0bdIOcNX02dpEeSsRoMuZUGlIlXfku0uD8F8XJ
	 YjhrGm+ShhWrciqwG2XAdBP+X1eG5LB9s6L2bPE7BGSOMEfFM47372cceaFqQQ3tTHP4i
	 jdenYdKmYShbB+ehmiVAl72f1YWUYff/ecEogP8V/pZPefcyWWHcxqpvwTRb4Bew8bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MbwfR187;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bl91ntfK;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4D606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F4D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MbwfR187;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bl91ntfK
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fr732695564
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OJHdZlygRN2jDx54/MBmSP
	XGD8ZnLG5eY4JP1FvaSw0=; b=MbwfR187Xs+UqJQh7lNr77GGIly3dgs9Inn6zI
	C/4ML5e7MFvx+dvrRc+n45AsZQppXi8aiF/2xmyJe/XQZyMDHGryi0cayyh23lZ7
	uXoJQ2uhiWLggNiBHn4FjgQaJIkVXMv8fE3mwghidtmQYmsuXvxcSmdyxm0X8H8d
	OQIH5d+pSmmBbfPua6GhKOAlJjuO/cTBmYHLbn7RD8UvtVfRpJiorDj7W8awDWDj
	tzG8C4HBSFRelV52G+i4J/hZoESPj6NkN/KTmzUsjqPTIjea/TRUVZEQLXRY/xmk
	SeVURYiAzYmz2jc4uPin+ZoTN6mzEu5inM9gyLhM2a/TP9EA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au2h7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:42:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ee04c49451so8835805ad.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795160552; x=1795765352; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OJHdZlygRN2jDx54/MBmSPXGD8ZnLG5eY4JP1FvaSw0=;
        b=bl91ntfKzNi7h/F1f/YBTWmiT38fkBb/EFhv3JjJWt6dnN/8FePdbCIfdVDhFc2Xwf
         IDFJJhVuehaWbrHP1ZaEQdLd31Ke4xE7FOWBXVNrKBn+u4zhICgNEN6Om1Y+sAg2WJ+i
         mrRjiSKVmQVT48eW4a7hvNe+8Pm/uyg9+ARLJHNFoXBiep8njJm3m5/IZfwpmWqsnH9K
         09iRrhZQdrFDLjQGlL43PPY8Vr5exLbKSGQPW5gXjbeucPq+gcqdSvWFEUrR6UmbnN2u
         KmxuPLXevxiMyUZHEfTKTfSgEu/1PDdeHIu8aAvH1jM60V16NTw/hWRa5f5mMbAolZ8R
         Xpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160552; x=1795765352;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OJHdZlygRN2jDx54/MBmSPXGD8ZnLG5eY4JP1FvaSw0=;
        b=kEDvOQmOWnY6Bdy3GvpShOc9HUPTY/UbFV6G3RoUwC94PwWqYM7goJ+GUGfJZ08Ukv
         mH5LSJppm3hJf2nL6zvRMpn6ZG1lL58dU4RqkXVKzjDkYksSPrTkhi9Ewzy5ZN6VZMyu
         aoQ1BVyLVlOsNrl7pGLTSVNxD32x9cQpMCMezAoRisx/rfvZ4iuiOSwVvj61mMW8kD/o
         k6rnfggM5u+asqen631NwjHtaGRugVtITAoa3Z5GtoX4HmjrVLKZ/b4L1GQ8sjO9Jmg4
         S9hYSatbirVuXRWsSWhj+DdfS/sQ6Wtly5H3WL5ikDeieD13yJGI52o1rUZgKeXuiu7K
         m7ug==
X-Forwarded-Encrypted: i=1; AL+hErFJ7WP0sjkdumZNPUaP/kK+V9zn1Qbxd5zE1Hi+Qc3kEsQejepUslML5r5gj+Vp+oIsp1TUENs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+x+65rqFgpwY2y0sH5on68U7BzKRAbiBMP/+2PChIf4NZqGcKb
	zoFeeSGZYj43AxBX/tp0OWvCjrmv+Qf1yPxlo91OEuISVP/w/Rzh7QrA9dJurWZNn4gtxlCbgX4
	xcALLl8mR9miVMSDatO62KaLdyBrPRpSwQPug8XhLcND8gvwuxh/sQW/Ihnk=
X-Gm-Gg: AZFdTZfSqfShCpRide/1jxbUcQeafBnbrEAwpDAe9yEyKegKa1UexAR3yvXjYRzfX0T
	xcnhCF/mLIaVdflqTuoJKK0t40q2Bv95vMF7PdqPriX6gr0yvP1yXcNCgHGexQ85WEVmW3K+k1x
	cmDJh+kx0Q2GzPusjDCWYxzKPZOmW04ocGWQobzxqo0jOvxRw08ZvAhWR03n7XTw6f83qSLe61Z
	ysGyD3RQc2ozZM1QmHe/geB9PJlqV91/G7UqmtM/g0YAsqCtpHPlIUENjw09wyUxb9ga29roOG3
	u6COuu9WYOA/4uKT+zadk4lYKlLr/5FwKyKAh+tUOvJHgELfOaZAgrh94jJfThP5Z8pTA1xoep6
	vrfStxtV+DYw/iWmXJRXO38H4mNLHhUHgUIvfHeUvSFtNUpNdQjIiwc3Dr/i26rHxY0qN02xxYc
	LIt1ojItw=
X-Received: by 2002:a17:90b:2fd0:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3b41cb235aemr2152834a91.58.1795160551847;
        Thu, 19 Nov 2026 23:42:31 -0800 (PST)
X-Received: by 2002:a17:90b:2fd0:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3b41cb235aemr2152802a91.58.1795160551239;
        Thu, 19 Nov 2026 23:42:31 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4323bda5esm119935a91.3.2026.11.19.23.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:42:30 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v3 0/3] media: qcom: iris: Fix IRQ synchronization during
 power-off
Date: Fri, 20 Nov 2026 13:12:03 +0530
Message-Id: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMv5/2oC/3WNyw6CMBBFf4V0bUlb3q78D+OihanU8JAOEAnh3
 20xxo3MYpKbuXPOShCsASTnYCUWZoOm71yITgEpa9ndgZrKZSKYSDljMdXmRSuDUjXuZAeKUkO
 zUJ4ooTMucsYUcc9PC665g6+3T8ZJPaAcPc03aoNjb5fdPHPf+0qyI8nMKaNxksWpLmQhKrj0i
 OEwyabs2zZ0i3jXLH40N4c04Wg58EineSlAF39o27a9AafnJREjAQAA
X-Change-ID: 20261004-fix-disable-irq-safely-15b2f712800b
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160546; l=2288;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=FR20uXI73EXR2aj2lUtbieQR1WkGmhS+TQ8fKfJ+jvM=;
 b=dimX/6X39t1RoJs305qysFBRWDYMJTuJDt9vfj4mcymkOXlUgo7JIE8pyB94CHXt3SPskW0L0
 M5XmVOn19sMBOWlI2VUVgexF/AyqdpPNBDebeeae7+kN1+tIS232ej0
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMCBTYWx0ZWRfX1M+nqcMDFqsa
 mvutUnQrdA6rnXKx+SGVgC6gBZ0Myo1f7vMyPs1Xvyaxh8v8lEVSN0/622cV/0MB1p467VU16nh
 D0D+U+6Nb/bpNv+U6E8cV6WrHjXApUeenRcqEaM0V3kXX3SMGLolsBqbbihz/Ar8u0yu4r9uk6m
 d9BADiTWUkrX914CKi9hLgD9A6XPFXZvy65dI6cBvH+kbk7aBCRnPBOEGJ83uaMOOeeB1qNEZEZ
 i29XMO5CSUbVDCHtTeaVYhibn/xLJTFO48RUYe0JiaWFu4fxeUxeZc/el0H5bEIqu0q6YffINBM
 /1QuNYPcBPG65/XoG1DqfZk8EK5hQkflA4MUc+TBIczpQg5EvM0os6vPyyBYSePjhuIXrhmK99j
 mvIyaknQrABv00xs890Uv0dzFYOXb55Aznl02r4RKdPvsBDddb6cq0qUX5OOsNBDdQFOFXd4j+O
 zJDWEZAwlZc9CPNo4Qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMCBTYWx0ZWRfX/RIilb6vEqnW
 1DimhUe4Mcqr1j7DNhU1VLgdMjDY02829fC/0NGj85tV5Aq/HhLKlonyVV/jKhP3X9D+EIuTqXm
 TsqL8vfun2JDKTTkVOwLZNt2KlcaqcE=
X-Proofpoint-ORIG-GUID: pJh04uU81IcmCroJEvsjx8h3hNxC5WCd
X-Proofpoint-GUID: pJh04uU81IcmCroJEvsjx8h3hNxC5WCd
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6afff9e8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_RQlf2RcmuGO1PAenpAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200030

Commit b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during
power-off") changed the VPU power-off sequence to use disable_irq()
instead of disable_irq_nosync(). This was intended to stop a queued
threaded IRQ handler from accessing the hardware after power-off.

However, iris_vpu_power_off() is called with core->lock held, and the
threaded IRQ handler (iris_hfi_isr_handler()) takes this same lock. If
the handler is queued when power-off begins, disable_irq() blocks
waiting for the handler, while the handler blocks waiting for
core->lock. This results in a deadlock.

This series reverts the commit that introduced the deadlock and fixes
the IRQ handling around power-off. It keeps the IRQ disable depth
balanced across power-off and power-on, and makes sure a handler queued
around power-off does not access the registers of powered-off hardware.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v3:
- Used IRQF_ONESHOT and dropped the manual IRQ disable/enable (Bryan)
- Avoided the irq_disabling flag, waitqueue and unlock of core->lock during power-off
- Skipped the register access once the hardware is powered off
- Link to v2: https://patch.msgid.link/20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com

Changes in v2:
- Added new patch to handle the irq depth
- Link to v1: https://patch.msgid.link/20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com

---
Vishnu Reddy (3):
      Revert "media: qcom: iris: use disable_irq() during power-off"
      media: qcom: iris: Fix IRQ disable depth imbalance on watchdog interrupt
      media: qcom: iris: Skip register access in IRQ handler after power-off

 drivers/media/platform/qcom/iris/iris_core.h       |  4 ++++
 drivers/media/platform/qcom/iris/iris_hfi_common.c | 20 ++++++++++----------
 drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 -
 drivers/media/platform/qcom/iris/iris_probe.c      |  5 +++--
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  9 +++++++--
 5 files changed, 24 insertions(+), 15 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261004-fix-disable-irq-safely-15b2f712800b

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

