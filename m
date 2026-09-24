Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E43E3D8E;
	Thu, 24 Sep 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242774; cv=none; b=VT6pgRA33jf99URuOP1TBuVxG4y+koluCg+5V65wb6aKyQPgvsH7Ck0dG1IkSmbq+XApqelxNoTs4EZ926U/dqqFGkUQMFPaJ0raBK3by5vPlHL7WbZAQHcIR3Mf0/hQeiho4DdeYEtJkKRdvPWBzjhHNu6bQ+MfUL8XWtNi8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242774; c=relaxed/simple;
	bh=SxIubjMEJ1ZWoLyXydl7AnmLMt8JeoYebiSBqX4AUy8=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XkW+RbWMP62YdBMTL9271sKb5dLXx8OF9snaDNpws8k444VHyNdkOYri5SSUMuHw+Jmbq7uPHdb54rJczxiyXDcnOjezaER18z7lhfNBQK3GI4BOWBJbJUgu2q0XMiXxRNGsK1wugguvTzVZ46C37UT8Yxtypf/L1q++I4yCY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=qApJgsyo; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="qApJgsyo"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5d8kD4069879;
	Thu, 24 Sep 2026 10:39:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=C
	9afxz53kWiwqHYs7N+ZuK5JTDadYoL3iKBYCmYEbIc=; b=qApJgsyoatCIRzxqd
	YIps+WHdstifUPsDoh3tm/HNG+QIv1+MdddsyqtvfrWhLKqWNLHpmfCEjyaGlHdC
	9Z+UE15OHYGefJMvkmecPWq1d6RZkCiifDLSZ+lhkXb3uRabuq99l+YrqpkWmOrZ
	+zMQOYpORN/pVE/WJ7sKuSxc1cumpEW3LJzX94W2rMjKkfkfcopNOzm/hkj3dGsh
	64bDcByv+UIouw1pyy8HV3tdueFhAhy+aruNmGZzQH/56+tNGdCNU/hMAjOtx7qt
	G0Fns5yWQBNpRO3VIKceGV7YuoxdkURbav+CSoH/FfARJLNTCLqmV0HDLDxL/b4u
	8RpBg==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gsjftmemp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:39:07 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.122) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 10:39:03 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti
	<luigi.santivetti@imgtec.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Brajesh Gupta <brajesh.gupta@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
References: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
Subject: Re: [PATCH v4 0/2] Fixes for map() path
Message-ID: <179024274386.675834.13293711717587004152.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:09:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Authority-Analysis: v=2.4 cv=GPKdgeNK c=1 sm=1 tr=0 ts=6ab4efbb cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ofw6MtmsdEsA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=cuzUy9uT74GBDvu7PNYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfXxo6SSKBpRLYK
 q/gJ/1Wh/s3yvkIzNECEzQrsqgaOoWMvwovMuh/rEJNwSm4Ts0yhVuk0fiOHScoFdyaBb3YD71h
 kZ1HMNAJQmW/w90/qMZI1waiQMKB8UQDAFZ1QkDjkAGuRpH9SVBUe+nq07z4VKklOWu4JSXX+kE
 sL7c0ZBlPcN/y36vYFiYaDlwxRmDM9DR/v3F3twwGZ75G/TnzRPqNBlWyW0w7bCiGUWvubDUkZN
 nGsbhXLiIPrtsfgS5hrT0mv4MPe/3Iw5kEFSaJmdhatRJC0yIFbFqNHLl/kWs+iAwE4OdOPzi8+
 5RwxKS5lRV6WBtbeKf+qLgt/4H+b5/64gHNJ+JGzUXkrt3ydBIthIB3UhnIEQ/tuss6YOeMgEbx
 6O26x6AoJBWzVvXygkb5khApLimtPmNz2t/IGc48zx1jpWqszvqNbng1B3RiMLOXfP9JWhNHQev
 2RazLgQffviMXqOTCng==
X-Proofpoint-ORIG-GUID: g52YinomhWfTFxcA5z9naO1TH8p1Zz4e
X-Proofpoint-GUID: g52YinomhWfTFxcA5z9naO1TH8p1Zz4e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfX52QxbV+EFxuE
 Zpzw7zSxICAul7BnAxXWnf6rQg9xFlQOB6Cn9dH6bYDH486cV7g+AzEwksmqlIFhW7HAVm+oBk+
 uyA9Et/qPzswnZnxwqcLaPM1eWvTa2g=

On Tue, 22 Sep 2026 09:56:54 +0530, Brajesh Gupta wrote:
> Two changes in map() path fix a kernel crash and a map failure.
> 
> Patch 0 fixes error path handling which triggers a kernel crash.
> 
> Patch 1 fixes prealloc page table memory requirement for a mapping
> which led to map failure due to running out of page table space.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/2] drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      commit: 7b824c293a6b56de8285a97984c507cba56bc4c4
[2/2] drm/imagination: Fix page count for page table for map() interface
      commit: 0a8224058a5835297dcf4a46bbcd16f77a9fe424

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>


