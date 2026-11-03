Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719797;
	b=pPNhqZKD8674O3M5xdc8+TSRlqfJvHso6wbR19gLqJRfIh7kRIV9O3GvJDAJek7ETG3Q
	 Z0cK3kBeDfe7BykOoyWcYa6cCm7eWAwi+J50Rt1NXLQITt3uMt7kLjo39RR9+pP+gMpoc
	 u9KWC89f2jAxzO+7Ns1RxLLZ7e8TteYxgmxqmopde4zF9OyVxC8JTrPDvzOjqp6Rl7xd6
	 qWnj8CZMBmOBfcb00c6sjjnzftHVjSX8r11CllqO50Zi66gjGojfvqlS5d6Mak9SFuPQ8
	 YUHlQeebeD1wnPilZfMwcSL6PRZsx0S+y7F9AaUHWn47BBxhSbqt61Lpu4BU99nA6qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
	b=OVef8pc/XlPwf5IPfUFN6u+I0KWlc9UgQwg4px8xh4hxMPuP8hbOUJBI8WogdJKv3pRz
	 4ZUN9OZXZF61yNFi0no8pRK/JUvqMJiGTd+FSKyw4EYT0/cTo67ljH1T+/97NLFW2VldF
	 1GnFFnVMedpRiKQeKeScyGdTN91m/J4MNYp76UugHvPyntYBG8tjtwmtDM67O2d+qf0Sa
	 MgVNgwLenUK5r4O0Dotbx52TEwbyyN8mnYYMt+j5AmR3EC1w56IaxPsGYadP87HOR5f92
	 x6Mqc9UK2b3fap0h1RYaC+d7Se+UrDUpHZpxEc8XPzE6MO+Pd4ZNETgHLyp3wFW6QgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaEb7tp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SZcZZQVf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B8606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40B8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaEb7tp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SZcZZQVf
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9sjT2119594
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 15:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RzAwmn1KqONWs6eIlRenG+
	fOoEFpFouVi0Vep/WmIJw=; b=OiaEb7tpyJlOXnQBKO5HXYHqU2QXQBLRj5DN2s
	J9m43VarO96/fhzBkqOF99pH/jp7CWtEd/7gB5g1obL/Bic81XJYCHaohzZ9l0xA
	L+lHtvzwMr0+EZwyBMpRGgDIamcU52pS6xKLVo3lnjqY/CW7vfFF70dfPu663YXp
	nY084CVXXX7M9tr1eG+Gk3Tld4uOjtgbHBopSwWz5AZc5phqE6SM5BQbwlZG3sXK
	wSM+nWcVUYuiimzvXkGUneVvCBHfi8DB1N11earN6dSoaSAKuDC8svxOHbUS+GIA
	Ic/5z2TXwadvdM0rxALUyXhXU2bc3F9NRqopaWEGqbBOcIRQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2brca3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 15:29:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-351788121cfso2264843eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793719795; x=1794324595; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
        b=SZcZZQVf1F3wcM84lqUno+8GmJB1IwwE0GUaV9fx8dTjxP4oC0u89xFF5m+RRyRQ8r
         Zv7ZY6N7HYwHcbXC9U94WsvgaJyJfPzRw27NisHqZyo33dJTpP8gVV+ddCaCq9tRsHF7
         ZbAXttlozttfc3IsbsLwYNTcAPbFhypeKVDM6Cmav7OaAFT0EzRx7d1YFYXy+yDBpOwm
         Dl3iJHtGClkwjPlxpNQX38sHkLALovubhy5038cm9dEwJj0WVdmCvjZi2M2DZL9ydqUx
         TRYvRS20EPgg8/2k4f9FCZtbbJ+eAfcpXbKxrElIM9PSEgje+BHUyU+ujxCe/lYeWqN8
         fT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719796; x=1794324596;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
        b=pkSkFDg0HTn8COMUf/qINaDJJoS3M8ANfh/txu25dm12Qie1LuASC05mOK9z/UNRz7
         09XKYvmKFPAqYhMtpiQqN5t2n1OYybDIDlTqJCAcQAUsGkjN8RjVhGMefayu13NE4WIm
         4Lz46WWC7yGvj+dI8Co+WDJ7dzkK/RRsTMDfNfXX408Gf+Pi3ZWEa6KWj2utxw1AZnKW
         dcttenFhC6Pk1VwiKUE33dRNmdrSwldQx5K3F8ZEi914tRMpwzG7I6E0XKIbkPDWNVGh
         ifOtF/jrM7mKsBjOBznHTn/vdqT8wfJF9DzLUoIx3YW5/K/Sqw/pBIfRXlFMv9765wUb
         E/2A==
X-Forwarded-Encrypted: i=1; AKwUvBy0A3eWQi8CfWhhViZvroSg3XXRS6cvvTcJLKkwbnZxQC1l6eQnKcwO5Lmtvr3CAJnNnDykOuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pw9zKUc9dDgkzMU3kCOMTLq1z7h5CwwrRGjbSGR9ErenSVO+2
	HxQWEomHgxk3rz5BXb///RHVAz1LhJT8DuCyXYjzdBr0T19Q/4deIPHiF50qt9UBBFr3ET2cZDx
	4gHkb4rV3Yoqzv0uUFXgIFfzLscEq9alAV4mn4dAM7k3Y1ZD/F4S+MVMciV0=
X-Gm-Gg: AYBFou0NKRjGFelNit+W05x3OfyZ3kAxIiDfqL6bdm8fqsqPGd6xU7x4k/TAqFaRx9N
	inHrM+NHHdd8HMLlZzDA/ojI1FrpyrSe3X3kXjQF9PokAZxJwb9VeNu2OHO8/x4VQCRi8WBZFsQ
	krigzNg0ojTJlgWO7MV+L9aobJxbBtrUwIy9AFxQL9QrVujDgJm/zLg6iXpSwtrUlBUZsmay1kh
	NZH6u/8TP1+Be2swJALlzSvDWzHsa4hmGg+vVbaL6zs0M3Egu6tmyChjyzC/mWcuk34T7e+Bmr1
	KP5E/UrEV8crXZlhAO6DiV0SsNZaD/IkHQXq2D1mPOVbZc7181nEJ21Ur1PHfqdgMlnfcutY0xi
	FGRssZlnhlGH9pzeXvAvVrUHzf7cb1Njoz4/iPoEJIHM+fpXJG1Un0ubspYs1sH/gPus1kIDNDI
	MZje5YWsgQ
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr23680643eec.19.1793719795255;
        Tue, 03 Nov 2026 07:29:55 -0800 (PST)
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr23680576eec.19.1793719794488;
        Tue, 03 Nov 2026 07:29:54 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm59888302eec.1.2026.11.03.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:29:54 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v6 0/2] of_iommu: add support for "iommu-ranges"
Date: Tue, 03 Nov 2026 20:59:31 +0530
Message-Id: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIANv96WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNj3cSUlPjM/Nzc0vgikHSxrqmJZXKacVqSgYWZuRJQW0FRalpmBdj
 I6NjaWgCSac2bYgAAAA==
X-Change-ID: 20261103-add_iommu_ranges-549cf3fb0867
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793719787; l=1715;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=52kUfvJEjuAQ68NM7IfYjdmCWi0NnQFqIUoegHkYmd0=;
 b=DsGcdPC6bbyZcgbXI+x+d2nTQHP/P17/5VsA0eTxp/IopXFAyFXAhN7bSJu6be09Ke2TJ33KG
 Y8u+E7u3GIUD4nBNAz680SfcfPFwpr+6GDGk0YC9/7/b9OlbVEMWgCm
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX3fpK5hTNGla+
 sWB0pfPyErd8Gc3XCivt8lNYsUVtxyRqgOtT6lmMCFqFPU8fDjP9zQwpPqOPW4SyLUMFQ90GeFZ
 sOqR0n+njqbSuiJyVrG2aZKJrPYxqQg=
X-Authority-Analysis: v=2.4 cv=AKV9GsJK c=1 sm=1 tr=0 ts=6ae9fdf4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7TpIluchohn6vR-9VeIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 4PK7sDXR38RhHD2BJUpaEDu66BiusqTr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX2SeDYtqR66lT
 3z7OgFgDzVv6AMSh8J/91IYt2dtDgFaqra02+Id2HZ+4AAdXnPGxaMqDKygKjvyBcqYbErts7La
 wY2c8YcvPuwppRd1utUXJd0VC/hQGAsL8XjWmgq4IBvp9GOcmCgWp5hQSSfnaaasPyCEna8nazE
 qBij7wX1FH99OoQ3CH8rn9gFHtJR1PgQpGZb/B6g9zq+pU8Qvr+g97KePxQsON7e1fAaAFGYacn
 7qNcGwYCwvTBms2XE908f8MNdL3PhInBfPT/i4rPgRdiD6sxPqio1bDUqDZ2rEf74h/+R9Ql4g+
 gteWzoOEmYI5V6vgJo6FQssmHN1gyY5qB2GqEOPUXwX+jQMZU6fgGuB7P83GRavoyU+Vgf7uQ5G
 0XTBnWnV6WIDQjgggEkNbJnrnS/ebTE8LetuzS3eXf45DRCmmwgVRlSqQPQLpZRlYtBsR+fSMtg
 rEa+5ML82DuHMfhihjw==
X-Proofpoint-GUID: 4PK7sDXR38RhHD2BJUpaEDu66BiusqTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030061

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

The patch series is being posted as revision v6, since the patches 
were initially part of the media series [1]. The patches are moved out 
to get review comments from iommu reviewers, which was otherwise looking 
as a media seris. Happy to move this back to media series if anyone have 
any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v6:
- Addressed sashiko comments.
- Addressed comment from Bryan.
- Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

---
Vikash Garodia (2):
      iommu: use resource_size_t for reserved region length
      of: Add support for "iommu-ranges" on a device node

 drivers/iommu/amd/iommu.c    |   2 +-
 drivers/iommu/intel/iommu.c  |   2 +-
 drivers/iommu/iommu.c        |   2 +-
 drivers/iommu/of_iommu.c     | 138 +++++++++++++++++++++++++++++++++++++++----
 drivers/iommu/virtio-iommu.c |   2 +-
 drivers/of/address.c         |   2 +-
 include/linux/iommu.h        |   4 +-
 include/linux/of_address.h   |   2 +-
 8 files changed, 135 insertions(+), 19 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

