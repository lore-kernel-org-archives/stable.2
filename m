Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6048094F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581267; cv=none; b=hMCuEDXysxgUYQdhZwjx3vXzGSpowDRqeKtZPATEanWzkh8p65jWXYCo8mqrU4G/bGV9/SAMM3ImDGeA3oULv6Ecfd56cAgKnk+XSurPoVWeP6xSKmopI+ZcngkpE9eyx7+sV7eQ447IzP4/Gi7KlVsiHknag7BpbxFPh4Kf0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581267; c=relaxed/simple;
	bh=gSmL1UXJitQibvJcke07CR8QBmZAbsH9TotC7Lb5Yu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciRU2+p2jhu65JFoNaubVjKq9d9oHFP7gHwh732O6MuDyBbPPD4OSSZVbaj0+6r408q3538HX7+s65fjrnCarc0KIVkoWdnmQNzjO2aqZWxqFuLEtosUy4oFisWYpNKQ0rmmdubd8AYUpaBQFsxHBw0iMWyhUSnSrm+tvBpnlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VniemlLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VniemlLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293241F00898;
	Thu,  4 Jun 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581266;
	bh=XoEY0a0uiFh0ZSeA/ePqNgP7579Ltu+ExJDtymwgzrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VniemlLuqC7N41GK+Cs0sbZd3SErKfbLma6fE0OdFZH2LKoIFXnPZ8Y7+JlLtdgmz
	 1ZGF4FLchNM9rDYtcnerGmASHNxV+DYMa8UgqmvIOGefqeQYv1QT7kfV7x4qarH8yc
	 NvuE2Uc197cPLWpTjf13g/FPbL49U42OvH/c/0ONj451W2DMeJGDSj4sjwUzy4nUMc
	 VJmqWv/hYjkkwd4bsaSfUkyCjLNSIdVYj5pWa2Avsd8lqHY6aF6uzVrP22YwK/nt7U
	 HxXl01uXD22lSSAxmY/QnKCH6TE23D1XRHmXP1VYuD5LvmwlD7RAIW0mY7qlnR948u
	 dDjbYli5Uf9+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Pratyush Yadav (Google)" <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jeff Xu <jeffxu@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Brendan Jackman <jackmanb@google.com>,
	Greg Thelen <gthelen@google.com>,
	Hugh Dickins <hughd@google.com>,
	Kees Cook <kees@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] memfd: deny writeable mappings when implying SEAL_WRITE
Date: Thu,  4 Jun 2026 09:54:21 -0400
Message-ID: <20260604135421.3490773-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604135421.3490773-1-sashal@kernel.org>
References: <2026060408-corrosive-dental-a22b@gregkh>
 <20260604135421.3490773-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

[ Upstream commit 3b041514cb6eae45869b020f743c14d983363222 ]

When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X.  But the
implied seal is set after the check that makes sure the memfd can not have
any writable mappings.  This means one can use SEAL_EXEC to apply
SEAL_WRITE while having writeable mappings.

This breaks the contract that SEAL_WRITE provides and can be used by an
attacker to pass a memfd that appears to be write sealed but can still be
modified arbitrarily.

Fix this by adding the implied seals before the call for
mapping_deny_writable() is done.

Link: https://lore.kernel.org/20260505133922.797635-1-pratyush@kernel.org
Fixes: c4f75bc8bd6b ("mm/memfd: add write seals when apply SEAL_EXEC to executable memfd")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Jeff Xu <jeffxu@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 5c575d3e6fa6cd..3e5a014fdacc05 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -273,6 +273,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		goto unlock;
 	}
 
+	/*
+	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	if ((seals & F_SEAL_WRITE) && !(*file_seals & F_SEAL_WRITE)) {
 		error = mapping_deny_writable(file->f_mapping);
 		if (error)
@@ -285,12 +291,6 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
-	/*
-	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
-	 */
-	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
-		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
-
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.53.0

