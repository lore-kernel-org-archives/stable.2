Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D11DE894
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236284; cv=none; b=bUpG2RCiIcX7aY7tUXRQHctgLZB7KnPT2uuhtsb4yxw60qKEBqc0yhTR3rD1HXnJlhkPKc62HoFaBU+I+kI+iHvrXBSYtZVvmZ2KcNVPXw1SwG32unn1f1Xe7qBrt+jo5VDnWmpw/9rmFSV9NF4YCi77o8kAB8H+g2pNn4NKnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236284; c=relaxed/simple;
	bh=ciwHRYjQuEd3C8uscy3buW66CO8Rv1fx4UFqivYmwyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=au27El/jTyreJbaYwE8ETO7mzGMVDLJvf7YtpR8IuNXXwUj8PJPBTZdwB3k051nzeNLssRgWwHNgkannD+5+M9pd3bsf1FIEZcYvp6lkP9tGTGjz6RgqwpIpax39A5WPoYW8K33i4LJWLBKTnv+coPb5zDSn0rV9Ryg/NWyJDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKos8eij; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LZOx5xVV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKos8eij";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZOx5xVV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7rcu2444662
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MW9JEteA9muiYxcGdyLndH
	i/JmVW1xLrRy/23aBzD8U=; b=KKos8eijqIXxBxTIYFTSnmdxG1kjcUaMvdAMmU
	MM0HKQlHmhgfDPKPYHSkscuGiCuQuwbpv9Qmvw7omEZoH4tXKEQDiKi0VMMe6uUm
	TWtAfUIRkwL+FMqNS4g0syvf8JfUIMP+tXOxBmH+8ySS3bIFCfSJCnDOZbYjwNWE
	pBic1/QCDw+1q/KcdtPEIaRDas/9wIx5ZDTykHBi704uNUn7CNetnH/5Zs7W0cVA
	w/ZIeR6DEnT9VwX+7wxHx2hh+wbmMXOVUHaUZdZ6PFBXbTn+0WeEVwlGPUf5Fo8o
	sKyMc+xKxofXgijPFQSLpoLhJCFXdozXojNdb19IUyfDBJnA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x05sfj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:31:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e63df032bso114161585a.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787236277; x=1787841077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MW9JEteA9muiYxcGdyLndHi/JmVW1xLrRy/23aBzD8U=;
        b=LZOx5xVVGAjm1z+p5PqqNMzqTJtn8Q4w2UnB92zZVlaDDA5NV6vaBdURMCSsuMtcVR
         j290+piZ/w7V2eODNNTGpwxeRG93wD7MYihekGCwfFNtEC1Vuvz++UQVZmqhmeMVFnaf
         +GsxuwqhRwccsZ4dh0I7T/XVY10EsLwdRgf54zvSLfv0Id/0uvLX6IQuuto/X+RcIOWp
         V9lrEEmVFEufk/O6Q19LVxHcB1lo7sOLJoqolgVmDiwzLp3aOK2S4q/eUZkrWAFVgUNO
         R4A5ZzcVVAjZu369mNVrWu3F9ip/6HwJ66IGnlnvHw7lrttbpvoVy5TABdCZ5GSFQ5+n
         ZEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236277; x=1787841077;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MW9JEteA9muiYxcGdyLndHi/JmVW1xLrRy/23aBzD8U=;
        b=nbNg5vijwe+S7djznI0Vf+FxkqKbcv4F7Cd4UZE0oplsF//4/vdQwkOqGWyUGA2wme
         PqoCXY9VO7WrL66CX/RdcMCZBVdlZTYz+yPUc3KdPFIY8JyhhUuBJY63DlLP/Mc0LfQF
         lVpmSod8uVBUyaHYFLaCyQvD6vVbfUpDv+W9E0+GFCoOfJpVgWjKzBS3LYkWiEiwfR6w
         kRj7FQual3VnGz/bFaM+UZzJh7BSBKDwG1eTxIJ0XeHjGbL/f0NieGav3f/DvrgtBi+g
         /TP/imMyjCGuG1T44gdpjg430+AcHJgHW4cJvP1RhhrFGZokv/nKPpv+ogQ3R0tzSqNV
         ycNg==
X-Forwarded-Encrypted: i=1; AHgh+RpVUX5rTyp4GSnfslBHL8ALPCqjvIFFVjCJdhjPcIpIJpsWO4ecmdIqtjZqxOy4TqhMasBzIYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1R/I3pDjE39QXGE+pLlwv+9pTrxxkcIGxopvjGoq9XNbk5csH
	cAwlBKkYdIzb+ck/+CeY1DOvVodPmdAAUxsslW7O85mO7qvhIrcZnlu5WqjSmlrxrkaCBwBgG+d
	NksMNK3ghV76SPjQqlV53WXUKK+F1798LW0i4XovdslpOtIrZWFipMUzs4X8=
X-Gm-Gg: AR+sD12CfZYCmu0o2/QJw8+ah5vnXBLJ+4AnmQNFIQ+0ZyzvolsVbboCGi7Qmmijy/j
	2UnOHzjVg1yNvRbv+vc8hTmvxwvEebKpXpq3zv2Y9sNl5IJmFHHRqIc/FP5opYQQEmJt5nuIrIm
	O/zYrQxwXMZWA376fn7lHMJsTFn60PRYdVR9JjVxW8SJpQMULVwp57XJ78O/dmNV1HtpRID0wSL
	ZWbbUM3rke6TJmY40/TUci2lD0U0phB9aheauPv1b1FTHhgerd/Ph/sTiTw0GTOkwJTvFRLO//I
	y0/as8RPQnkw/GVZwMVgKF9x6uyE80pydv1XQ43TL2QYXfO3yefcN5w4OTu7e3LQnSB9rlh2n7k
	gYhpyje2Exg0IzHvzuvQudH4iTB/0mRYnjBaz
X-Received: by 2002:a05:620a:268f:b0:92b:6e09:b0d9 with SMTP id af79cd13be357-9372858eaaemr724733685a.21.1787236276816;
        Thu, 20 Aug 2026 07:31:16 -0700 (PDT)
X-Received: by 2002:a05:620a:268f:b0:92b:6e09:b0d9 with SMTP id af79cd13be357-9372858eaaemr724696385a.21.1787236274752;
        Thu, 20 Aug 2026 07:31:14 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b145c9d7sm15226618f8f.15.2026.08.20.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:31:12 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Fix endian, overflow, and write-protection bugs in
 SE firmware loading
Date: Thu, 20 Aug 2026 20:00:57 +0530
Message-Id: <20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKIPh2oC/5WOwQ6CMBBEf8X07BLaKoIn/8NwKGUrNUB1W0BC+
 HcLfoGXSd5kdmYX5pEsenY9LIxwtN66PoI4HphuVP9AsHVkJlKRpTkvwNgPTGQDQnBAqGpwfTt
 Hm7pJEUI1GIMEstDqkssTSp6yWPYijJf70L38sR+qJ+qwtW+JxvrgaN4/GfmW+3t05MChwjw7S
 2GQC3Fz3ifvQbXadV0ShZXrun4BEAf7HPUAAAA=
X-Change-ID: 20260819-fix-write-to-read-only-firmware-buffer-39ca7834e310
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787236268; l=2071;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=ciwHRYjQuEd3C8uscy3buW66CO8Rv1fx4UFqivYmwyI=;
 b=vHO/Ikmrwnx0ik1NavaLPPk/gDouDK9U4oE/6qfPIHO0SYMl6+hsfmyO1tNxdwDl+zt+MjWGz
 C2591qjY6vIBHfJ6o1/K3HdoNlRNzME1YFBtQUB1lJ3+dDuEblIC25Y
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: uGt13bZq-Ha-66VWcz81XAe_5jodx9rh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX+47MsGjqX23j
 tfqIjjYKKPEMOpqStp3eq4ksRVpDGKF2fPsOSjc9Mz45CibGJxc1bvECTuj2pVf5/zcR4gM950O
 m0jgtpWfwX28qxVeP9pnxY9tnXTmbpEeVyA6dU39PJj+CXQBWjwQkPwwi5ClgG5bafUsOjcYlPa
 YWTFvGpKYnVE/Lpoc0TIu5Bb/Qx/ykkKw6omgC/j+Z/Qd4cWH2caB500YXbzqKkjPi3eHFoUKbp
 eSsKP6bnkNajjKGdTkEJMSAWqlxBgcQiw69SrnPcsf5NjwvFGOJbpJumHl0h8JhvhWmJuC1Uv++
 W6XXGfrzaPzazcdq2ZIuAc0DHykWDEzQ8pdjWcUMzZ5VX7HidNNm0cHZStbMk3k+qSkD32LIOtP
 FlJUE8AAdBAayoQfb8it6rP5ppjMsouK/WPoem0fWefPDrFqxkjyxWqBzDQnfQJ8GBVqSNtPHN5
 wlFyllV618Eyolm7T+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX91bpz250CxEj
 YVjoakqEMVa6vUg3mgfmpIQq5+yA1bfL8tiHB2rvCrCmIipFg6uQPxENHUaFyZhPgUVteuLmP04
 5se49QIhLdMG+jl1YnfE5yEXYMdOC2g=
X-Authority-Analysis: v=2.4 cv=VfPH+lp9 c=1 sm=1 tr=0 ts=6a870fb7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=XQMRRsFmXZ0RbJubXJcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: uGt13bZq-Ha-66VWcz81XAe_5jodx9rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200109

This series fixes four issues in geni_find_protocol_fw() and
geni_load_se_fw(), all introduced by commit d4bf06592ad6 ("soc: qcom:
geni-se: Add support to load QUP SE Firmware via Linux subsystem").

The most critical issue (patch 4/4) causes a level-3 permission fault
and crashes the kernel during QUP firmware load on CentOS; writing through
a non-const cast into a read-only firmware mapping is undefined behavior
regardless of whether the fault is raised.

The remaining three patches fix related issues that were uncovered while
addressing the above:

- The fw_end bounds check was computed from the unrounded fw_size,
  allowing an odd-word-count segment to pass validation but trigger an
  out-of-bounds read during the subsequent memcpy_toio() (patch 3/4).

- fw_size was stored as u16; incrementing 0xffff silently wraps to 0,
  bypassing the MAX_GENI_CFG_RAMn_CNT check and permitting an
  arbitrarily large copy into SE RAM (patch 2/4).

- serial_protocol is __le16 but was decoded with le32_to_cpu(), causing
  the protocol match to always fail on big-endian systems and preventing
  any firmware from loading (patch 1/4).

---
Changes in v2:
- Split into four atomic patches (one fix per commit) for easier review and bisection.
- Link to v1: https://patch.msgid.link/20260819-fix-write-to-read-only-firmware-buffer-v1-1-be86532fe122@oss.qualcomm.com

---
Viken Dadhaniya (4):
      soc: qcom: geni-se: Fix endian conversion for serial_protocol comparison
      soc: qcom: geni-se: Widen fw_size to u32 to prevent wrap-around
      soc: qcom: geni-se: Fix fw_end computed before round-up; propagate size to caller
      soc: qcom: geni-se: Fix write to read-only firmware buffer

 drivers/soc/qcom/qcom-geni-se.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260819-fix-write-to-read-only-firmware-buffer-39ca7834e310

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

