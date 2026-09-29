Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB3538D68
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694945; cv=none; b=IkoqFxzvWgu4yaoLD2FbMPldlBrnx59fb8uVNZh3vCzrh6QaPEh9iefrjyJZ2TeDbQSFANdwpZSj69hi4vRpGZ6pXdECDDq1QBw6QtH2cL9wQ4MWiR5BhOEsHD16RreCJN1Zz/7VdApVGv5wnf+ODbectQbpoTPllGGNVREvyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694945; c=relaxed/simple;
	bh=iDpSU4N9Jkz70BMZX8Db0H0eCyH9ABzbwrgGTdD+8TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1ijNKAJJXn15L1gq1U1GVHw5EfzxId7eZQY9Yy5ibBUj6nmGEFaJ5gmybRaG8Fw4u6/78mMKnzNSI3OpTOSiENL8Tq4uQwnHMM7+o/tI/VYzJ+IWo1CkP/GfKOg/ylzPKxstFOgmmlRbiQplPlfcti3fncPwcLFoznWWlbvtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtTlMLuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtTlMLuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFAB1F00898;
	Tue, 29 Sep 2026 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694933;
	bh=RBqP66rvWg0O07ZXWcLmqToINysgy3f3YPe3NfCKBcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WtTlMLuGvu10AXf8bBlwkei4WDM1Z/gA0AqfggT3uPBowJXwUH3G9ZN58chku01lX
	 J51Pn8vmcCqxQQGLZveIaPBPCXYypnk8buyZHeU0qT2JpaoU5hPeSB3Ek5nzq6hWLv
	 E1mOB3AxLJJCCdX4qiVKUpJuoQphSv9Q7Ld+ozZ5cifLDKe/2E70uA5S5++q72IRyW
	 Np+tV4J3ViiIf/s1GYZnqUkOJjf1J2RZ0H8QmRMOROjVSJvuAt6y5viXEOScmO3vFI
	 nT1ozzZ5mnyWuYG9GyK+lklvU7MmE5AALS02Wd7C80YyKpK3oTF4F79QLmWrrBcjlK
	 AJOa0JtxyH99Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
Date: Tue, 29 Sep 2026 11:15:31 -0400
Message-ID: <20260929151531.3865696-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092956-elite-error-10d8@gregkh>
References: <2026092956-elite-error-10d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit a997baa61179b450bd55c4810c7ccfed3b753a54 ]

amdgpu_acpi_enumerate_xcc() looks up each XCC ACPI device with
acpi_dev_get_first_match_dev(), which takes a reference to the device.
The reference is dropped with acpi_dev_put() after the XCC info is
initialized, but if the kzalloc_obj() allocation of the XCC info fails
the function returns -ENOMEM without releasing the reference, leaking
the last reference to the ACPI device.

Drop the ACPI device reference on the allocation failure path before
returning.

Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9211ef48b31ec66999cf55e04d0cbc60cd855fd5)
Cc: stable@vger.kernel.org
[ adapted the hunk to the existing kzalloc() failure block with braces and DRM_ERROR() logging. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 67db986eda3f6..36f429e7f2027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1118,6 +1118,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
 				   GFP_KERNEL);
 		if (!xcc_info) {
 			DRM_ERROR("Failed to allocate memory for xcc info\n");
+			acpi_dev_put(acpi_dev);
 			return -ENOMEM;
 		}
 
-- 
2.53.0

