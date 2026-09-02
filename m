Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128836C5A9;
	Wed,  2 Sep 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343005; cv=none; b=XaGpOIT0BL6LNjg7Qxlb0PEUV4FAJiJkGrrVb8N3hKF99cjyPXXUB2fM6fo5mYsnGDT+pjMLrpqlXLx25o67Zf9hwj3qRimOUxxvZdUMZkOMep3uQIHtIZGb7glri2ydRlGX13dNYfoHR4i3ePFfULpre5PQGckiciPscDuYAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343005; c=relaxed/simple;
	bh=rRVlffPWCp8oy8e7ZeFMFZuMEl/peuha+J3snN5N4AM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cqX45BEcNaHyI4H0vioS0TCKRnWfDECl7R9OKHe2VX8WZb2l2IDRcU6MLUznFOF4D5iXbRPOMGKQqg1HqzTyann+8M8alr4wFY+1BGEIDu8BgwGnS86MQbokuWpQLIcuXLXO4wPpwdFM79DKATgE6OjUUdzuwBH6AmcUXFCH3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=IAjeHwYk; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="IAjeHwYk"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829Mwqf2429190;
	Wed, 2 Sep 2026 10:56:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=WhjfUybk3x0zNRLJWyeyiWR
	yRkMJW/v48qX048VrncM=; b=IAjeHwYkmAcLRkZq0v1VQROIxLUwEQ4+KJRRClr
	NShj561rGqk/HMHihZb6gP3W14jvy3Xq1Lv5NyRszj+13N/TbgW84BQl9Now+AX2
	/QuKOqmnxCvC26hn+/ZS/HvxInYjw4X2hddyxZCqRN6QigGevy34c1MrWLRtrHgE
	dJle4B3ncmYYrmtH95ig/Um6PO7124ZbnJinBln44A0Tw6LuTOhM6+/TZFQyw+2F
	sCMaRAgeeLZrv208SXq2IH/KItsNbBTNg8Et/3qogls9Umybq0N5GUR3th/2xMA1
	CGDGtDuPYSRQoOkmpHa4tU6vBFKn7ahX4YNqEfFamX/3xKA==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gbqgvb7k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:56:12 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 10:56:09 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH 0/2] Fixes for map() path
Date: Wed, 2 Sep 2026 15:25:30 +0530
Message-ID: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLyl2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMj3dzc0vi0zApdY0sj48TkRDODNDMDJaDqgqJUoDDYpOjY2loA7vX
 o9lkAAAA=
To: Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti
	<luigi.santivetti@imgtec.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=891;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=rRVlffPWCp8oy8e7ZeFMFZuMEl/peuha+J3snN5N4AM=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBql/K4O9JJ2JB3Kajfb4WJTs5bnI4d3N2Ue9+Vj
 DkREQlqXQeJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCapfyuAAKCRDQJndZfgLx
 cK7TD/0TrrwYwqaH1nJJcVM8ZfA2wVEsVDA4C0BN/f+wxJ/aOcOkjYjqAtjRni7uN7FGDMYDe3R
 VK4bdOwlUTB6PV2nJhu493PF7rIv8sLhx+nLWmhEeoYRGAM7rarUb35cCGZiDPH9yGLnTwpdjq+
 pF5ztH+RY9ZuEqQAlJ9nQ+ZcfQUKcuuFuptwBKiXz1/mgRfEQZ/ebOPoRTEipFL31MeLa8BovZb
 3mOOfFtt1qqF7403T2hwcgPXyc7a9J2aAnW1VX8DHfWfFr97e4OpOPOTHxYBs82Mfz8Rm03oqdf
 HZc1zmThce2WXVHkNIfdWo4GOeWHCIFFNvJArRZbKAvHfZ8gewVObtdklBtpY7+S1/Np0YS4IQt
 NEtPmfxmAhB+Th/ssiMsvkY2qb1U51UZmG2cT4FbjOgXJ1v3di7sGdDHcu5sLHEcH6ZyTuAmqDs
 Ny5uqsGmEqOUoR1HmOHjJQkwv0iQ1FtihYi81f2g4GxtGAG1sRXw7rv1L+4/2pjNojPgvp0Y2H8
 HBdfCwqDWEzOKe23hKzw82ee3LYbkm614rfAmBfYEzGRrBXISV5/x/B7r9I1h0nM1T+AZiNuPeS
 2t/DrYmrsYC4zY/DX6reGbEi7yEPYrJu49xrGw2RlyMfk2IoWNo1CWS5fpzLAz8CFcyT2YdMQ9G
 SXWwulvSP4n4pxQ==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-GUID: 9ZrKL39fNYct_rhSlhk0m4D9KgzJuVwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4NyBTYWx0ZWRfX3tzGpd4Pz/K2
 uxTWxO0cEcnFg8h109JXkVFRutyUfVkOSON8iGU16pEtpeZ39Fb5592NH2xvCY4+YyCl2SAcF6P
 fdakXZREtZP0QvWJg3TWZhoELlWJbve6kAUpgIY6sztjzysps/AepuXR0VCYeWia0p/FR/aEQFB
 rna1JoT4Z+pGRtd2YWAZt0IjWNsyBH/wAPOxvJLsxNpn4+LnW5vWwERTwt6z4DIZxMM0Rli30+x
 aaVoig7aFxftkpgAtGnmGblGf1eLrEQshTGbRPEyuEn7RpB3ccW6784txvM6XKf5yg4rn0JnLom
 0Mqa2pF1kuLq9mKP5wOPSE7cM2pBsfwehJ9Fg49de0aTP/Hd8BT3+v751j25ea8xpJTGw9MnG1M
 gni3PIiYxqY+MjDgQ9gEi/ZqcXywcUr12FPFTzZshprqe+jc9iXToVccUVY0mx/VIpHk+gZm6pg
 L3ywGSwEfCp/tyhWaqA==
X-Proofpoint-ORIG-GUID: 9ZrKL39fNYct_rhSlhk0m4D9KgzJuVwO
X-Authority-Analysis: v=2.4 cv=OcCQnBTY c=1 sm=1 tr=0 ts=6a97f2bc cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=XMS0zKOm3FjkKrMNf74A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4NyBTYWx0ZWRfX1+6ReLTxrXae
 CgniENcJlqXa0lQSmoerNHGOmnTxoDlXJ69X4DsF1JjeLQWcIdzjHhCx+iyKkQDYkK0ftJi3Dez
 ICE+BUtoIHp2kFqwyXzyMITnGMljqfc=

Two changes in map() path fix a kernel crash and a map failure.

Patch 0 fixes error path handling which triggers a kernel crash.

Patch 1 fixes prealloc page table memory requirement for a mapping
which led to map failure due to running out of page table space.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

 drivers/gpu/drm/imagination/pvr_mmu.c | 19 ++++++++++++-------
 drivers/gpu/drm/imagination/pvr_mmu.h |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c  |  4 ++--
 3 files changed, 15 insertions(+), 10 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260902-mmu_fix-3923aca60f60

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

