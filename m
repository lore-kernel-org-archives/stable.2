Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531863;
	b=tgNI+/Hqxz3c7qZrTb9fsxDoHJ1l9VSE+NmaGzmiy/CR65nISvh5CfTg7s8KEFCeI5eL
	 K9JefL24lRO66/JHykgJrRG/KK8km/zHad83UG3gyGQIKB9g/i9cedtOlb7z0D4sEOW+2
	 jSf1Fyz1ViDze30hBrkCc2xOZF6HG8/hD3BFhbHa29SDsJfz8bKNlA0RSiB2zSvAMxy+j
	 30PhSVxA2R4ODaM38Wghxv6fB3CljYvjfq4RznSuORdQJpNL3mf0OgtsW2MHxSiqA19dG
	 j0ez/ivkYvIVbkQ2VppolCLOOLJ85LPwe897Vk8W3RhVNeF4fqAUFhP0+Z88YODpNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EzSbKHIfiuDyzzhjztGjoup8Np++1GDicA+Z5sKxAhw=;
	b=JYjfzJyGuASihq3txISbgIlhNdlKaRvaUWYfXnqMsVHHrsxJDshWPPNjtid+jCzDMwJi
	 nGzPoU8h0T7rT3ypI170sMvMx/8WtTww2pDA4nIL/uF7I/1fqL8pYzGLLj3Nn2Z+RXiEH
	 gQgWKneVexjM8PQzNRYKc5+upxg+8F7idFIGzVkNfsvgmECuxaNAV3BxsyIJ/3xSoH7Ze
	 MGo9sxLQD5tnhqDVIuqMrJiziu+UjyM8512XC8ReE+wOnI1xW7cjlaRvIe8M2qIsmBgvD
	 DemiALGZNWmLjvxVP1KjiAXa04A89MC18eyOnBgrr3BHmWPGwL2tg/nZP/7rtyCYqBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miPL3QVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80517606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miPL3QVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1323B1F000C4;
	Fri, 13 Nov 2026 01:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531863;
	bh=EzSbKHIfiuDyzzhjztGjoup8Np++1GDicA+Z5sKxAhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=miPL3QVq2C/6zIqvnFlXClRU+NNIgwmIEZK5WbwkheSk79TqC8mJ5Sdx6IofeUBr9
	 T+qqigKu9NUe9Fv9VuEKxm8QwdOCSvTvkEBnPAUZrWkDU8ANrkYYwJsHe794WPCJdH
	 fTPGgHFA28x4vuYfbLacFsJZYQ/ah2tmodDlPwhRAiJ/UoKbJPduV6BdbEQcnQZyOr
	 QHv5C8pg+Y6kpYskY4NFNR3qmHA9/f61II1C4rhEkccWW94CRQMnVIT1jrE/xt53m9
	 V/zKejnA6Mpgg5rn4B+HB/hQIE0jyBUw3X/YnhBhOc5tZNEQA+5j9teaQ5RpyQRlaH
	 qLPLVlyTImLww==
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
Subject: [PATCH 7.3.y] hugetlbfs: enforce F_SEAL_EXEC in setattr
Date: Thu, 12 Nov 2026 20:04:20 -0500
Message-ID: <20261113010253.435316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200122-failed-7.3-b7f570e7cea7@kernel.org>
References: <20261109200122-failed-7.3-b7f570e7cea7@kernel.org>
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
[ sashal: Replaced the unavailable memfd_check_seals_mode() helper with an equivalent inline check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7611a8470ea26..2eca1855e0973 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -841,6 +841,11 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	if (S_ISREG(inode->i_mode) && (ia_valid & ATTR_MODE) &&
+	    (info->seals & F_SEAL_EXEC) &&
+	    ((inode->i_mode ^ attr->ia_mode) & 0111))
+		return -EPERM;
+
 	trace_hugetlbfs_setattr(inode, dentry, attr);
 
 	if (ia_valid & ATTR_SIZE) {
-- 
2.53.0

