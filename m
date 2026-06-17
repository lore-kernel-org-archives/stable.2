Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECF40D597
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717937; cv=none; b=uB5b4wuvup3VamgBPValeF6V0T9urMQLfJwMwwi5vduMHmAAmeC0N7RImlh+YUTWl5sKr8YPbC6WmPDGAL7Q7qw8D9A2dDHbx/H279eRW0ln2YenKh0uBBup50E27Gzr0Vi4flJ0hpWSv4c0GQXHcIH5esIZFc/Cp1VlUvfyQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717937; c=relaxed/simple;
	bh=zBII009NXCK6txLdpkC8tQvBqYvLEm8yfzpj5ca3VaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YbYc866uEMFIOllqyTQ/vRQuxXSOY/YEWB7brpnGhEOyRwlPvaOZq3+j6ImWLA5b+Opn7dB0PPNAFmXDaKRbwwPLrXqmluxs9t8YJVoZyqZ+qDNRwyWNcG73pRhd1iTviDG9M7fB8kL1SAF50i5p8U4Fiqo3LvZBTp3cxyjpeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lTluNpmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bXjgBEwE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lTluNpmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bXjgBEwE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFoUOh2731330
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CjI6CtgCxWDvc4aY1Dbfru
	ezal0p/zh3tfHibXZjGT8=; b=lTluNpmGJG0/6lUWJYVREF3aLSDSTJzf+Scbzi
	QT4/CmgvAS5w6eJnA4ChsZ+xoyOKV1fPRaMpAyZAq15YT4tkIu1PHo07MJqsE0W6
	qFdEnggvcJjqMJwRDtQXzNl2XbtrmBAGLcv/dQJvL/rjvC3a22Eayk3x8SlffceP
	tz02gjh2K9aE9Gt0nNs/LNLnMOsOsSXlt73nsPs1S+ciPfcojQR5sWWBGsGx26VZ
	fAzw9Fg8QVW0LhrbDVpSbJFHKQ83BV3Cfm7A+70ZBsl1DsjlE/Kp/SJNXstHEmhV
	nRFFRrOLryUGNyBGZ8G9gLJkYPITqtoz7Q05SBRIzJJO1K/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2c8tby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:38:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf11699875so122075ad.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781717934; x=1782322734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjI6CtgCxWDvc4aY1Dbfruezal0p/zh3tfHibXZjGT8=;
        b=bXjgBEwEMAw+AnJsKIGJUbgbjKjXb8ptuIfRqzBQgfMWEXuWRoGM+Ivz3jUTkP2aDl
         pTG/eG9uSh2ebPoEU7iSGO+f+XxEFFG/Qu0DHzgwj6Spn0hkcz0NoEw02v1S/rm3PfJD
         F7TCXSjD1ii0zsRYfzDMibwF7CFOsqhPBlrpOPTrsaDg05nc8hl6Vb3mdVmg1FDVUqgr
         fLuwPS0YT26SxedlX7vHqpIic/9F6AnYwHlN5+kIcKsm3R8dKTjUZk20ksgBuNI+ojm5
         xU5SF76LZ5eqTY6mPiJxiPa0U9svspmrywCtgjVuPNtCG2kyYrIz6o3qyXs3eFRiwIMZ
         chAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717934; x=1782322734;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjI6CtgCxWDvc4aY1Dbfruezal0p/zh3tfHibXZjGT8=;
        b=W0VCJJDTtJciqnoZj9sa/ogRD4lRC9JqUBB6NwGG7xRksbM/a9hqUURYqfL4AzW22B
         6OyEHkQJF/FJxbcxPdO1WXcvHU0fjWU4af5St9X4IIEyDK7IiIr/l0/1MqKKaeASFInY
         vFmfW05UFSa0GGOBIeqk5kageqymHPNeE0q9uy55zENH9nkAkE05oH0U/WYPBieuCOaN
         GahkaWfnIQYFVfa5QAJwAsHwMmnVd03C2UmugTpyfk27iFZpjMmmrADszVk5wZFdr7hj
         YSVSW8CpFm2mkF8kZDm699JO8d9y33Al9GPTpv9MCqH4eXc/BVqnRJX4HrdIlT3fysln
         gW/w==
X-Forwarded-Encrypted: i=1; AFNElJ/FM0+ET6eWg2m9h/bvWf45eKu9yI8gmXBEYhldV8967ebb9am2JYJjXL6LKJ/rWQZpmN2oRB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMSWohSoaJaa0M20U7y+9Rzhy2v3XfBQ5+EQ0S+DeqvUEWG44
	Ms3us+/kKLRWoi9ZeouGmSb1HwWrW40m34fMmGsDsAIqkCpdxS55EAFsE4haTRxBHgSymz5wXh9
	oENaqcHjrOhJ4/SroFL95iaIYs858jHnhqtmYD9Mbc9+s6Zl8UHxC+OB9wArJR0LCw64=
X-Gm-Gg: AfdE7cmBn5p6USme3dpxWG1UOgONwCYQas4D+RgVjiMxEBKVD9LbX/KaB4gKNodBcy5
	QYWHSxZPvGi+0YZPKMpco7MxGBknhuh4vUdHIOEAX7gp8VGZh+wwHYWRZLzzcYCHg9Ovex8R/Y7
	VpjPYsENbWfBxZMDkcbVGvr1SeInezInN+Gg32swh8EXNQRD7t+YzYDNcw+YVuYKBAhAmbFv1eK
	EaniaMdh0u9T4otRPBziwNPzTKrMsK71kLO+ojjNFfq1pLXHQD32tH0TZJplK/sFcL96w1jxzQx
	D1eIqPr4l5IA3uLEZUFR7cjCbHfC3s1IgjZgHAUzUpxl6pyZzgGXM5/nu08KSJ7Obay7C24CrVk
	H3Ne5mJAlwgdkKyvvfqM3LIwhMw60LemVvS0n5PJsC44u7+M6vN5y8w+BgFwTDg3JJqdc6o+U4s
	XyZ76ERY4aqkoQjJlYd/wMWZjE8JOGQcOr00xKEuNeoPobfQ==
X-Received: by 2002:a17:903:3806:b0:2c6:b3dc:b838 with SMTP id d9443c01a7336-2c6de6673edmr3240115ad.18.1781717934393;
        Wed, 17 Jun 2026 10:38:54 -0700 (PDT)
X-Received: by 2002:a17:903:3806:b0:2c6:b3dc:b838 with SMTP id d9443c01a7336-2c6de6673edmr3239865ad.18.1781717933924;
        Wed, 17 Jun 2026 10:38:53 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433369c8asm173973215ad.73.2026.06.17.10.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:38:53 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH v4 0/3] Add support for the REFGEN in the IPQ9650 SoC
Date: Wed, 17 Jun 2026 23:08:42 +0530
Message-Id: <20260617-ipq9650_refgen-v4-0-c505ea6c6661@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLbMmoC/3XOwQ6CMAwG4FcxOzuzFTadJ9/DGDNGJzMCyoBoC
 O/uJhciemnyN+3XDsRj49CT/WogDfbOu7oKIV2viCl0dUHq8pAJMJBMAKPu/lBSsHOD9oIV5Up
 mYsvyXWYYCUv30HfPD3g8Tdl32RVNG5U4UTjf1s3rc7HncW7CJYNvvOeUUSEQtNXCWpkeau83j
 07fTF2Wm1BIvNHDTOF8oUBQciW14rnIlMI/SjJXxEJJ4i82+BISCcr8UMZxfAMMYN2XUQEAAA=
 =
X-Change-ID: 20260520-ipq9650_refgen-196b570d8bc0
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2OSBTYWx0ZWRfXzSiDN5KIGRhi
 27ITZHNnXLN54tPaoFIlo+bUVpSMoLNLA1olk2Bl8IIo6WF2VHN+iuTaJDNBCc1hFMdaMYePtbZ
 XWWn7cJdAiCAP+vbAzlNSb0sN6n4cFxeW0k3gTkY/EHODWB7XPbjQqAJGnKlIvshwJdjHkskTZ/
 JGd3J4SUu3TKm3j2PpwOl81K1WKzo+J0wkxhCOxOXZ2OY20JzV4Ecc6BZls/1EjZqJkkD8kvT7i
 xvnumBPx2FuBME+Y8qx/+iJ1ulTlaizY/T5yPn/GQCNK1PJkadeUPq42ffEGz6KmK5gk2/fpg/U
 tk0gZwABlsD4VMMgOK1cSKbBpZmIym1/Ad08W2Gnsh+V09cztKAPhaAROK+77k3V+WhFjswNeVY
 YzxF3lRRKo74oL+zy/YikgPfFZ2WC26uvo/Y8M0HdMnBEFSGVXQxurwm97rDGTsc37tvC8TI3Uv
 bmzUH9kNttWpSHIkehw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2OSBTYWx0ZWRfX2k/TNjFZoamH
 5/LXDJOhRDU7OiTM6h4wcFyPuy0i0abS4w0dNkv+DfvnOqQ/Yo9E5mb0i1fNr836tpI6njJbYeB
 G0D8ZJLzc79Q0R+MwSJ4ZhTpw6gKrSk=
X-Proofpoint-GUID: B-1oPyHUi9XtpWuNDiFukQfLPSFPyhyG
X-Proofpoint-ORIG-GUID: B-1oPyHUi9XtpWuNDiFukQfLPSFPyhyG
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a32dbaf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=jDu6XcLu4sYahdmiP6UA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170169

IPQ9650 SoC has 2 REFGEN blocks providing the reference current to
the PCIe and USB, UNIPHY PHYs. For the other SoCs, clocks for this block
is enabled on power up but that's not the case for IPQ9650 and we have
to explicitly enable those clocks.

Document the same and add support for it.

Correct the regulator type to REGULATOR_CURRENT, as the REFGEN block
supplies the reference current to PHYs in the SoC, per the REFGEN IP
team, aligning it with the hardware behavior.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v4:
- reverted back to the logic for is_enabled() as in V1.
- Added the get_status() to report the regulator status to user space
- Dropped the Dmitry's R-b tag due to above changes
- Picked up the R-b tag for binding patch
- Link to v3: https://patch.msgid.link/20260615-ipq9650_refgen-v3-0-5f611623629c@oss.qualcomm.com

Changes in v3:
- Pick up the R-b tags
- Use the lower case hex number in patch 2
- Document the IPQ9650 compatible as separate one not as a fallback and
  move the allOf block after the 'required:' section
- Link to v2: https://patch.msgid.link/20260611-ipq9650_refgen-v2-0-d96a91d5b99e@oss.qualcomm.com

Changes in v2:
- New patch 1/3 - change the regulator type to align with HW behavior
- Add the constraints for clock and clock-names property in the binding
- Read the REFGEN_STATUS register to find out the regulator is enabled
- Dropped the unused slab.h
- Link to v1: https://patch.msgid.link/20260602-ipq9650_refgen-v1-0-55e2afa5ff64@oss.qualcomm.com

To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Kathiravan Thirumoorthy (3):
      regulator: qcom-refgen: correct the regulator type to CURRENT
      regulator: dt-bindings: qcom,sdm845-refgen-regulator: Document IPQ9650
      regulator: qcom-refgen: add support for the IPQ9650 SoC

 .../regulator/qcom,sdm845-refgen-regulator.yaml    |  31 +++++-
 drivers/regulator/qcom-refgen-regulator.c          | 113 +++++++++++++++++++--
 2 files changed, 135 insertions(+), 9 deletions(-)
---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260520-ipq9650_refgen-196b570d8bc0

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

