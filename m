Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2C37DAA4
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561578; cv=none; b=MWPkSACO+FzrFfePBXeZJySafBrfzYgRtKWVqyR3mD97l7gPVCg+IWBPKrfS6P1/NPK5ur1NmIMSRByLPT4HzgSWMAh9sS8kC/aLoNQDLC5b/noz4DQq5cQ2H9mcehXlbrHy8PLdbW2Up9x8LeFCVrRaehcSRZzHUW5pdEGuuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561578; c=relaxed/simple;
	bh=3xMv78LAxPRQBwTxUb63fHuHDw2kahISTZ5GUdO+MGo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LBov1HBl6RjS29khB/PYIM8Bl5yt8L1+CZDX8lmjOq6lxE+fTa/PxhRXPn3SKsWW8ehN+g8xZF4hKlUyehhzIscEeqyrUVqFZJJgjsDVN6wZx12hseNE03q0wNm/To/u8CycrnkTATzk0JUlFXUOF+NwqwGyWPAXHs9Gt3/aTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COnqvPGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COnqvPGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C571F00893;
	Thu,  4 Jun 2026 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780561577;
	bh=/MQJ78ZHo4Z4zl+2aN8j8/EyHwC/VlG5J56U/gMgtl8=;
	h=Subject:To:Cc:From:Date;
	b=COnqvPGHe8vndXzm/S1xL+6kydr6VNLoGnju8q/4NdQhGDncnlZFc4qFqd5Q2Veql
	 bFflDerV8TYaY0q51H3joprG4Pp+fxWcLYPPMGzGtDg5UFzfLwuY1mutf7G6R3Q248
	 UCG9OY7iKFc6gnuX/SCL52y1FEl9J5eTYNErmTjo=
Subject: FAILED: patch "[PATCH] memfd: deny writeable mappings when implying SEAL_WRITE" failed to apply to 6.6-stable tree
To: pratyush@kernel.org,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@kernel.org,gthelen@google.com,hughd@google.com,jackmanb@google.com,jeffxu@google.com,kees@kernel.org,pasha.tatashin@soleen.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:25:09 +0200
Message-ID: <2026060409-tightness-iodize-c0fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3b041514cb6eae45869b020f743c14d983363222
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060409-tightness-iodize-c0fc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 

