Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997933803D2
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561574; cv=none; b=YpM89QhHu1J2laqWueXMUVSYkkVIP6Q9cnHcjW/1RQzPNYpsalpPsdb/R7jCiZO3FOuiZpOF+55B80FQFHyhbsW/AQINh1L3RfATOtGdfNa/0iHi0f12rFjskLDRJVDzHy/I6WQ7tFqIdXnzxCnZ2wj11HGlFqnqU4MJ85aHSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561574; c=relaxed/simple;
	bh=lYI+60DjsCryHFjfmv8QOPm5PkZzdWSkrqCq8Nqid+8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=plcO7AdjC7Dr4PRcLIn38c38cC7rIkH9IpPggaltdhvHU1tfLGpjZ5TU27YfkiBRqCE7VJ1aIueiywu/IWT1fhY+kuZl36BgOY4Pb1vl4P0pNGQNdUliOJpMllpt71lKmGlSLlsZW5yzt4fbRdHJzmOaOpezSv2xI7GO1AE1SdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vQig4RNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vQig4RNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA98E1F00893;
	Thu,  4 Jun 2026 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780561573;
	bh=e/0zbUE118y6P4iFpln0cQ6u4kNt5gkemX7Ze1dAFxM=;
	h=Subject:To:Cc:From:Date;
	b=vQig4RNmG/U+5dKo7v0AGhDMNuNO+ddj2Z9w6GpT6/cFOTVmeAmOEBxPsJl6mSmNz
	 XD9UM3Jeo/6ND8FsuX8APWt0lFbpNQ1w7aOdD2pdWb8HWfh/zSZWRjOW6eKBSqIeDr
	 qNmOCflPHlOdIwaNJvvr7QP/mM95va2DxX24MzmY=
Subject: FAILED: patch "[PATCH] memfd: deny writeable mappings when implying SEAL_WRITE" failed to apply to 6.12-stable tree
To: pratyush@kernel.org,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,david@kernel.org,gthelen@google.com,hughd@google.com,jackmanb@google.com,jeffxu@google.com,kees@kernel.org,pasha.tatashin@soleen.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:25:08 +0200
Message-ID: <2026060408-corrosive-dental-a22b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3b041514cb6eae45869b020f743c14d983363222
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060408-corrosive-dental-a22b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 

