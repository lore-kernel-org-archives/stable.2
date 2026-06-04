Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78D40B6FC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571595; cv=none; b=SLwiPREL8+bZV6CIZAdRu4mVYP4TbYYLlxB/p3riFJ5nT1nDH+kMmRrdqUcVYMs7tLljbQr/mCFibue7pUTqRjEKHQo3vkch+/U0i5/qik2nr985dE2O79+mWcAIB6DJwyKHYWTzSyJCB1rj8fPRZ/8T/6pg2XUSBdVA5DgH9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571595; c=relaxed/simple;
	bh=Z2xSEZ28ShpzpmW2+vB5Gfh/RanMELiUmmVTw232Y8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdWFi77pBDo+XtoYI80FoZnn9XVdzUa7kJRLZGe/gyaMWVtY6aVu46Mcdui/EQqZNMajnE3deXJhMe73M3A1KjX2UUMc6+AV1L4fKDued3WXZlaNEMDS/r9zuhRAaZAlqC7GVbvf2kRedUrNTSc6zqpYA1ISV/UyCpnmrZ+G4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fduozU+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fduozU+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E21F00893;
	Thu,  4 Jun 2026 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780571594;
	bh=Us1Fbpbdus84BcYaPgI7jLYVned3A5mxQc2I32XFOZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fduozU+yw4SQb1ObXJUNRc4jOxNydpmr/hWsvxI8VCGqoBOU0HF2zsdFeBw7wm2Vw
	 nEfqSM8KUdeKfl6fZw7dHlQbp/eWQy8ZbAdj3BIGXJpsgdJYPG15XfXAWvNMow0HMB
	 xBFYE693UlGUqRZ0LYjKcyFkN+KR9Grgz2/JCaxKLJQKOt+vapyLZUQrbYS8shNTYe
	 BHmq8SxV54WKDtBh/ezYm6m30lJdUwJZ0nFpkBq7FpI4KZdtYNmUakKCOujErI1rmj
	 M1tRpTut+H5elq3nryuLvIeGKznbCJYwFjBia5Wnaa54K26QWh4JBKZhLLXkMJY5oj
	 P9/ezxun9UJMg==
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
Subject: [PATCH 6.18.y] memfd: deny writeable mappings when implying SEAL_WRITE
Date: Thu,  4 Jun 2026 07:13:11 -0400
Message-ID: <20260604111311.3206451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060407-bust-ashes-06a9@gregkh>
References: <2026060407-bust-ashes-06a9@gregkh>
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
index a405eaa451ee8b..f7ba1e9dea49a0 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -284,6 +284,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
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
@@ -296,12 +302,6 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
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

