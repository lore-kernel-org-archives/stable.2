Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC83803D2
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561566; cv=none; b=W+Hwt/4XISRen/rBUd+vSuNospg3V19Hh0S9elComTwAQyxkmIZqxF/y5zopX+beOTjKvjl7ZAm33yYMRjsWbDjeVjmFYcGo7ox1XPorMCS/3O+FlX22zD4WRXfVmrEaqPOMwWtROitNH2f6b11ipPtczoTnIxFdugSeeH/5hFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561566; c=relaxed/simple;
	bh=kt0TAidJQkW+lDtQtfcduDffa6Qx39+5bIDrfWz6ksQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lr4xQaVCHXUDW7NUYYmwN/CLfAzal4YBb1BRtX7V9HuyML8Aw1SMt7eZdO9TxyfEu8A8oRJtJT+FlP1sh11WXL3+LPixEcEdCH5dZZckdmDo7oHVIqw7W3JD9BRoeWMI1F4wxXXuHIfV8xiDduorZeQhf01JkU91UHJXsk7HauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qs5k+CIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qs5k+CIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5D1F00893;
	Thu,  4 Jun 2026 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780561564;
	bh=Cmy/rz8BOfPbLmPUB+f3VT+zBL+x7XYRaDBhfdISZVs=;
	h=Subject:To:Cc:From:Date;
	b=qs5k+CIJo6yHAZKHqZ4hXKp5gpBe8/9FdaoTTNQ0uqcm0ggxA9fIwxeS7ZffwWXY2
	 BXAzxB1+c/TYEPQqlP3P6AB6rCwU1jFGt/z5fPEcDdUuF7S+GNy6EH93bZwYeMzNDP
	 xeRFrJCAXZCYn1/9zo3xnIPdQ6o+eKUlRmsdXBcQ=
Subject: FAILED: patch "[PATCH] memfd: deny writeable mappings when implying SEAL_WRITE" failed to apply to 6.18-stable tree
To: pratyush@kernel.org,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@kernel.org,gthelen@google.com,hughd@google.com,jackmanb@google.com,jeffxu@google.com,kees@kernel.org,pasha.tatashin@soleen.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:25:07 +0200
Message-ID: <2026060407-bust-ashes-06a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3b041514cb6eae45869b020f743c14d983363222
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060407-bust-ashes-06a9@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b041514cb6eae45869b020f743c14d983363222 Mon Sep 17 00:00:00 2001
From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
Date: Tue, 5 May 2026 15:39:20 +0200
Subject: [PATCH] memfd: deny writeable mappings when implying SEAL_WRITE

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

diff --git a/mm/memfd.c b/mm/memfd.c
index fb425f4e315f..abe13b291ddc 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -283,6 +283,12 @@ int memfd_add_seals(struct file *file, unsigned int seals)
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
@@ -295,12 +301,6 @@ int memfd_add_seals(struct file *file, unsigned int seals)
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
 

