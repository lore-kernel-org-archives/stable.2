Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533197;
	b=LtjJqVEQz1V/jZBotFzWJiy1d8+rzy4KcKUPV6/m4DCwK2Ca15VRO4Ys2lGkmn+Zo0Q1
	 4cbzgiWPsxkrSu2lJRNaRyPOnMK7C7UzvpNokcnH/xLxmFJxoJ+uWMgtFVMrgYYUEkeGm
	 3gEcDtsRQZ8d444Q5GDjNGQefur4vb6iSxcxoP/RmSApOFxP5lqVuI/+Q9+cJKpzJdwx7
	 Sjwlg0FVcBJjeeQtYnX+xW0cipx9ReKP48cgqSi2sN3lnAyQizkUqnVayITiAKY984y+W
	 tZ7WUsyu8DNf/CHKDgvv+Q0YxF7JM1EoM412J1AJ1/oIIr8lYJ2YTCTscYHM4rapQRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y+X5BpCWx3kknI458MdwY2ZzCgXl8CI8ltS+EyaaS2k=;
	b=rPWU2MPvLEzSMsbjpPP5YrRusB4vrk1A3+mPZsDx0jZGOcnAjraU3jaQFFZGLf6MnJ3H
	 ++HuMHbU0byY0tznwVihdAQRewupPMI8JpgD3UkJykqfYiunTgDQTkF6e30bwDwUKvepP
	 1B2I3OQi3+rQ1t3ke+bsytPjdinXMehN//EsXlOIJrVQxMZFDpOrd3XW9+zeHSCDHYQZC
	 5Qfax+UdOMC2rLMRCNOSgPjskjoiW7TH7QcMTXuH60wuQDMsmlNJvZ/gNsCqYSg3VcexV
	 bUWvhFPMfQvp0i5rkLL/oo8kXsKE+6JroTAnfKx/LieAyYJGYHvlN3YTjIkZ0BNJveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6AG9nvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F0606A884
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6AG9nvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406B1F000C4;
	Fri, 13 Nov 2026 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533197;
	bh=Y+X5BpCWx3kknI458MdwY2ZzCgXl8CI8ltS+EyaaS2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6AG9nvJgvA9TQ8Gi/3h4RzDbVPD9jX+3lVSH4wft4iNGBE0o/pTPrsk210x9ZYF3
	 O9SX+olTLSUwtVgMfh9LsyzVFOk3Xg27yb6TryQ0I4+m/BankRff/imNHwILnsMzSQ
	 jRKNrw5tAlUghIY0EFe+WTDPeQ7K47d4wowfuSEPtvvP0KffuSNqltnM6tGVbtc+jF
	 U4a2gOyP6G/vkc8oTiMMlmiEeEHRShIx0wUYRDg7zLfrVJg5oNhRILp6SlWTwSwxvG
	 sKrGASQQ/hXXfUDLEqmUg9xyxOyhCTjoa/in64UvHBG93NGxkEA1bo4K5RnHlgnBXn
	 q38lNoJPza2SA==
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
Subject: [PATCH 6.6.y] hugetlbfs: enforce F_SEAL_EXEC in setattr
Date: Thu, 12 Nov 2026 20:26:34 -0500
Message-ID: <20261113012559.641134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201111-failed-6.6-b7f570e7cea7@kernel.org>
References: <20261109201111-failed-6.6-b7f570e7cea7@kernel.org>
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
[ sashal: replaced memfd_check_seals_mode() with an inline F_SEAL_EXEC and execute-bit check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9bc9f04e4b7a6..96ba81081ed42 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -964,6 +964,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
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

