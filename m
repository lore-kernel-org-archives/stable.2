Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6E3AFCEA
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066028; cv=none; b=ErWgLJJi95vYqL4O9UYUrSrQb5DyeSUjrVeyY3zRoKH35afsXyawVvTtcyiNHtpVT4UvtUiKThKMPDBtXXb5Zam9j2w23XwbuBs8fGJuT+Tzw7HKgrjn/RFVhPV2yQvsIwQpN1H0kB9X2dFurDDPIdViVqPEgfD5mYEiUabJDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066028; c=relaxed/simple;
	bh=BDCAaJxNI+HrEq8+mCVHNGHhTKhpwQNJqRNDDn8+2/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlxQMT+TqWuBZnNOdw7CmglyXbNiHHvfB2G9EXEPxER/zXxAXgh+6GC62QsGY66+VHDbvR+eRth8mjVu4J+BGoOfivV6+KFk51Vht9NfUmEqaVbYm0zAjbz9j/9v8ATWMZFliB8BGGhkJ4ZUuXL0qc/dWnPCdPexjOGsu8gElLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kwP+UVpd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kq2I5e5Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwP+UVpd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kq2I5e5Q"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE0d0u1426965
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Z7ik/kAelRbRi99H/Uj58M
	Egrp2Vk8BawC9o/O+u/7I=; b=kwP+UVpdZDIWQnl7PlC0FovV260AbllXgSrMOG
	GkBiCbdhzbyDnfSaCkOSnxhc/JP02V3ZXJrNxIr5x7U7bbTll4GbNNMc+s/+TRr/
	fpSpaQqjNGBBjUnYGoVPFT0Z1BXv3QjHm7cPbV9Z0kH2+SdUoiCvCdxuCB5PEZNK
	y/PqtCs4f9YMOtEAbsuS6mYIsq29ZuWx/VH5HDNkJOj3zpQw211NExh4TETBGWD0
	EKOSXEFmls5SJj2V7MB3/W9FEPc/kAcGiCthu3RIVwFSAJ37XfHQnr1aKVSBnfOG
	D3PjxBtvleenJ32rfu4SFuHltM2gmWdLs49Qykk3dNZBkFOw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb199dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:13:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0f45415cfso285776d6.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787066025; x=1787670825; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z7ik/kAelRbRi99H/Uj58MEgrp2Vk8BawC9o/O+u/7I=;
        b=Kq2I5e5Q8O5MQKJ4QV2tgI5kfy7byPPio7UdcVn3ndHKIMuQF1pbtpn8/VhIMAMG7J
         SIcH7EXzyy/k9vY9h/3Qj7N5BwQcX5YFo2KKB7PGiY4M25/kIENw9j6FMCFgQNIbDylt
         iM+oIrUpGIPqILOCCKiyjwhk7uUNOfs387Mgwjq07dlspW7pQBuXtPW15m/iaF8qDTJY
         +NysXwyob3a3bUCOIVDhQHsxwXb23ektHJgec9P6h423gu+0yXqSk6N6hH8IOP709XXN
         4c6q14/auEhDWDX3y3j27vM8PKI/nhzftoT1Znfpsv4hPoYNt3RCFSnJ2TNlwZz6hRau
         Itzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066025; x=1787670825;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z7ik/kAelRbRi99H/Uj58MEgrp2Vk8BawC9o/O+u/7I=;
        b=UB8LXaecml+WcgC4Ou1atPNoerACCFc6ogKBhRiQca8aJPD3rCxyWKgt5oBXv0a70l
         uneH3UOmRW6pmpQuo/w5B6fqeYo1F10jkV9O7L3aTEnTWr6xyDpcpva4aRZvL9J6SOjh
         ToE/8QG63q/kaMGuC/uc76JVwC0pd1r+XI9Vjy/NOlbqcKDDuCijMXl1Rjn4XZUv/vHJ
         Oy+OLAdS6FYkdv62J7LI+5N73bDAyCJu5eNwrNEL6B9/0/3I5okMLRBNORIuYfAHQkj3
         gaZKBwdTcz5WsfG5y5ITkNhwL17VW8cO5fVUZWXW/8NZKLISjs5wMoGJ8PkUTbK+ngXz
         liPg==
X-Forwarded-Encrypted: i=1; AHgh+RohuXl3XGPcOMa9Wme4bxRLrAin4K7WPYx0wC+AEdHw7LAkN5lPeqfWXkcAjY+ULhHqexkAmRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVQOOhX+bx2nBvUsW1zGxrpvt6TqRhws4Owp13h3SQSE9wF4z
	PnlgAmQwCEzf1i/6FWOea/U3JqAuR+0JPJ9BTdRvtUUtcEWJg3UpkYyEJ7Z342z+G0PCK/WpFCO
	I3ryFOhHGhxvTBe7sS6IbG8fOIEJLbL5/T/gOv1iHjlXW2YnM04Jybo6xf0s=
X-Gm-Gg: AR+sD11diHqC5Va842ZmUVOwlTXJfTopQrB05JYtQZaRVB3q4m02RK4Mdk7QydE5vYS
	NLA/VxZbSids8/lPtEHx/QYTIdofW9urZBxq9rdatFMNf9Ie0SqTiah9sVrmpXa7xoFfr3z/Hfq
	8wuocoiw7cAIwc5UrnSIlSuRI7r0AB7vsWzAwUkWGegshQsjPgiS2ZFGgbUwMDWFoKjMYJBJT9z
	fjIZREHGijg+VGOGKe0IcxMrT3RDcoL38YDfvbEWbkgz6otuKXxU0ZOiWnjGzXnsduVsTwqSLCX
	bV6jcDoUSjCkcscS0QxHmlZx46EwVveM32GZLVOM91xFfW1AKAgBHjmXR1+3YiTLC8OW3I14Y7G
	y2NSb3/fMtfT8e6PmpofeUJu1+NaC/BwULw==
X-Received: by 2002:a05:620a:280d:b0:930:9fdd:f4e2 with SMTP id af79cd13be357-936d234d502mr3306596385a.28.1787066025152;
        Tue, 18 Aug 2026 08:13:45 -0700 (PDT)
X-Received: by 2002:a05:620a:280d:b0:930:9fdd:f4e2 with SMTP id af79cd13be357-936d234d502mr3306583285a.28.1787066024420;
        Tue, 18 Aug 2026 08:13:44 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3158asm13111105f8f.7.2026.08.18.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:13:43 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: [PATCH v2 0/2] media: qcom: Fix iova allocation from restrict
 region
Date: Tue, 18 Aug 2026 20:43:21 +0530
Message-Id: <20260818-reserve_iova_in_driver-v2-0-5005a1154408@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJF2hGoC/4WNUQ6CMBBEr2L225J2DVj98h6GEFoWWSNUW2g0h
 Ltb8AD+TPKSeTMzBPJMAc67GTxFDuyGBLjfge3q4UaCm8SAEgupFQpPyYhUsYt1xUPVeI7khc5
 zc9DaGoMnSPLTU8vvbfha/jhM5k52XNfWRsdhdP6zPUe19v6eRCWkoKbAVkuFx9xeXAjZa6of1
 vV9lgLKZVm+pyDDjNUAAAA=
X-Change-ID: 20260812-reserve_iova_in_driver-855b388cbb29
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787066016; l=3643;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=BDCAaJxNI+HrEq8+mCVHNGHhTKhpwQNJqRNDDn8+2/w=;
 b=LcEp8pUwyylE1YqEh2P4jPhTRMUD/sgucEVBKIasdQcdi+ozP5vZylHHflebHI9UgzojTXzfl
 ZsBBaFkum1UAY2/KcFyeqazHmz2NlFU7W+7lUoLKKsDM+2n7mhdByox
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMiBTYWx0ZWRfXxyHKY16Lp+BW
 SLgnKcKkjBwCnGOa2/kq8JfwOVMD/HiBuSURiam+f7LRjBT3S2YrH4eMbSbonCSKfbUOOtjtHRS
 m1D6U+5Q0vJb1Ue1OHMUbP52ZWcSTFH+E8+WiHusZ/erhOVZWwIw8pPWODsHIrgdAhIOt2cXpTg
 Mw2G/jN4hj3GuEkK1kO2aph+0EqMtADpzTdZZvy4630eOpTVXStDAxoCVhvUoGWyUhSJstbTwjR
 qKEp3HM95NuQGzHHGYhU3sKpKMP2Lau83Hh2YbQZUR7OxwyvdXNJ4qJqP2CGg/Q8yOOjiJfo+KQ
 3Tf3rXNDwFr0gayYl0ws+N/QA9zD8H5Z9t4y6dziOBFHXyg+9YQDJ5zh9+qHtlVU12eum4pmjmg
 3TxDNwe3VtOwBoCUdfNFKsoBjfmcC4cHgZFrvW9xQOXTbd4OA7jiFnJwmQEXTz4kLO5T0q7h0Pi
 /OfvvFO63SNk52cabNQ==
X-Proofpoint-GUID: DKFDMwdtYsLW9r_Cd3XfGXKhyPdaYBUD
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a8476aa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8
 a=KKAkSRfTAAAA:8 a=2MsHHeORzfZbqahp5AwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Vxmtnl_E_bksehYqCbjh:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DKFDMwdtYsLW9r_Cd3XfGXKhyPdaYBUD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMiBTYWx0ZWRfXyY4+x2CyfLyj
 Xf4xugLwvjHk8Qr2IwfSagf1W3gb+xU9KJySFyOvuGgvhilQ24miYoQbhxbcVw7kEhVKlC7c0an
 Ufu9opIIamw/f45R/rsspw8Qen+GGiw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180112

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream
in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots.
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
already posted here:
https://lore.kernel.org/all/20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com

Those changes involve DT binding and DT node changes, and discussion is
still ongoing on how to handle those for stable and for the upcoming
sub-node design, with no conclusion reached yet. Thereby a critical reset
issue is still open.

This is an alternate solution to fix the unhandled SMMU page fault
by restricting the IOVA range in the video driver, which also makes it
easier and faster to land on mainline and stable kernels.

Currently sub-nodes are not yet present, and only a single device is
available, so the restriction is applied to both non-pixel and pixel
stream IDs. This makes the solution unoptimal while fixing the issue
considering all scenarios.
Once sub-nodes for non-pixel, pixel, and secure streams become available,
the restriction can be made stream specific.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
Changes in v2:
- Used the devm_kcalloc instead kcalloc (Bryan)
- Set bus_dma_limit instead of dma_coherent mask (Bryan)
- Added check for address and size once the IOVA is allocated (Bryan)
- Updated the commit description (Bryan)
- Link to v1: https://patch.msgid.link/20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com

To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Bryan O'Donoghue <bod@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Stefan Schmidt <stefan.schmidt@linaro.org>
To: Hans Verkuil <hverkuil@kernel.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Vishnu Reddy (2):
      media: iris: Fix iova allocation from restrict region
      media: venus: Fix iova allocation from restrict region

 drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
 drivers/media/platform/qcom/iris/iris_probe.c | 62 ++++++++++++++++++++++++-
 drivers/media/platform/qcom/venus/core.c      | 66 +++++++++++++++++++++++++--
 drivers/media/platform/qcom/venus/core.h      |  5 ++
 4 files changed, 135 insertions(+), 4 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260812-reserve_iova_in_driver-855b388cbb29

Best regards,
--  
Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

