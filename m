Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532994;
	b=PcbyH8PMIhApNAIFXukgGASQJWJu22H0wajZHwWvBRcZV2l0PbjABBV1O3lLdlyF2w6e
	 AFelq8zwe49kSmVFOun7KTinZS6i7l+LrpaN0VfLGskFBYy2wmjuL3T0+HFLxRAOJNAVw
	 AkkdoCmDE414avgQExsi9b6jYEFTXldgOJDdY28N8xqxBQ4l814aq5A37pjZjArhxkllY
	 KMbrhNgGWb1IJzAGH1lGXvNj0Tb0aJmkfizivZ6VOl2XRjkbfG3+JfTHMjkroPkllFs9x
	 F0wU0/iWjkeSZuXWXdp2F6WdtDcDghswQCK4kW/rtWQ4iya1R8OI5eskdRmcPMRdKUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ltje1PxN2LUu36ZkokgAeEFOAIlFGlh5Y1J+Su66Zwk=;
	b=JdAnuSTSybjZXUEWLGCM9uL2yYa4advqHj3JFhibmLqfKfAqPXh3xq7J4e8rZOYAaywT
	 0gY2l7oMOYlYagtOkMvl2+aDDmwcnjfHNbqH/C97KIGoowEBf7LssskoQg7PwWyW/hogX
	 AxveEJ5425m14xHDCAmfuHXd8qsotbyV1RwQ1dIRZib+Q//63xZBuvEhl/cyLn+Bs6WLj
	 xCZnK3unCv+w5Y7p6Q0D4vRYvn9Mil19EFA1wqF6FZ5Zof6GTlcejDtMJCHV0R9QZ/auU
	 r/AYQAR1TWGus9G+evSjOAyz+oOxxopNnh35GgjJwYtimRs1pCOjAUgTJmb1ZSEFq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVTEy8xX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B4606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVTEy8xX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D331E1F000C4;
	Fri, 13 Nov 2026 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532993;
	bh=Ltje1PxN2LUu36ZkokgAeEFOAIlFGlh5Y1J+Su66Zwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVTEy8xX5OnE9jI7Rw4u+GhFXs+aId8ObgCRuZ74gyONtHiC4SKgRMsswdUgByl+k
	 r63jTF/1KkJwnofO0zBVtoslzF+PTG5iWJ2xF0o6lDaTMDnBWfTdJqD5g5gcZgKQs5
	 vWJxLWNaKFs03wSKGMnXw+jV8MtkZtcclJT38Etzp+4ZMdax4lb8CnGYDV6whTxG4H
	 LLQviLh75S3J1xtP+WnAjfvh/62YU/N7z1FyjHETkrnPThsC7+DuLPTI9K57wKflcw
	 OQDfK1AmFFI7sBbT665Dt8f9ir5Von2CXEU/KrOnAKBixvTs/k43qSfvomnN6Nfmev
	 OIfE9BntaqMDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hugetlbfs: enforce F_SEAL_EXEC in setattr
Date: Thu, 12 Nov 2026 20:23:11 -0500
Message-ID: <20261113012239.608219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200651-failed-6.12-b7f570e7cea7@kernel.org>
References: <20261109200651-failed-6.12-b7f570e7cea7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

[ Upstream commit b7f570e7cea761ec7eb4a3a9557a3a082d14e88c ]

F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
not check it. As a result, fchmod() can change the execute bits of a
sealed hugetlbfs memfd.

Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
to execute bits when F_SEAL_EXEC is set.

This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
fchmod() incorrectly succeeded after applying F_SEAL_EXEC.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
Acked-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
[ david: use common helper; fixup Fixes:; check only regular files ]
Acked-by: Oscar Salvador <osalvador@suse.de>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-5-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced the unavailable memfd_check_seals_mode() helper call with its equivalent inline check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1a12932b58806..2856c3bbc38d4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -932,6 +932,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	if (S_ISREG(inode->i_mode) && (ia_valid & ATTR_MODE)) {
+		if ((info->seals & F_SEAL_EXEC) &&
+		    ((inode->i_mode ^ attr->ia_mode) & 0111))
+			return -EPERM;
+	}
+
 	if (ia_valid & ATTR_SIZE) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
-- 
2.53.0

