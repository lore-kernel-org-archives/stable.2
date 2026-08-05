Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B843635D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929797; cv=none; b=Jk69HfCdFnX3P7l28k7ucoz1/39zlndBQp3oxcnJ76K/NjQloUDuLGIsRYFcLPjW2laeF0bFCIPTkh7xtYhFeONTy75lLloONRb5z7//kc44il2yi83d5I92RXRtL/xKYu4FCV9WeMHKeJ1TFnzuHp8YAf9XzEB/3zpWiBwEDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929797; c=relaxed/simple;
	bh=TRhnes44rTq4exuustG+ckCkpoReQnzpCpY4mKkhDLw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jTxpkTm03WObC7w29gsRL7vXWSepMWwgIQAw4q/jijxFv2u8fKv4LrrXUzW3saFCfI9QTJItBnuKTs88/qpF6e9wgv3S2pCx26ivB8hOnGnJ8+01qW7PmhFsXiNJn9TTpOILuiCD5utbsIR+b0MJL/HPwH7QLJbM25wzbx+asew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/jjGr3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/jjGr3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B9B1F000E9;
	Wed,  5 Aug 2026 11:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929794;
	bh=PCcYmPMKDKBE4fRm8jkiYf4qQ3hk/BZIXGHp2B3f4Bc=;
	h=Subject:To:Cc:From:Date;
	b=w/jjGr3e0+bf2kU2+LHHPUfrjT1/W+v6uqN+59PU0TphSyygERRP/1of7ckCWb/kO
	 T17BEpBwbw7P+XJHmS8rOBJs1Z8NTNjRgnwPu4zjjyRFp4fYEqfcPRMUO/DZoGph8k
	 rRXuAZI3x4MxAuhlgCZpzCIwPACzVP/6B7/9GRDE=
Subject: FAILED: patch "[PATCH] selftests/mm: fix potential wild pointer access of getline" failed to apply to 6.1-stable tree
To: christian.gellermann@codasip.com,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:36:17 +0200
Message-ID: <2026080517-taking-drinkable-08cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1d75a4ce04095afdb63d8e540092ff8151dacf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080517-taking-drinkable-08cb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f1d75a4ce04095afdb63d8e540092ff8151dacf Mon Sep 17 00:00:00 2001
From: Chris Gellermann <christian.gellermann@codasip.com>
Date: Wed, 22 Jul 2026 15:02:46 +0200
Subject: [PATCH] selftests/mm: fix potential wild pointer access of getline
 due to missing init

This is another occurrence of using getline where the code assumes that
getline allocates memory to store the line, but the pointer passed to it
is uninitialized and potentially a non-null pointer.  This violates the
Open Group Spec[1] and caused a segfault in a similar situation in
selftest/clone3/clone3_set_tid.  Fix it by initializing the line pointer
to NULL.

The issue has been found by simply grepping through the selftest code
after running into the issue in clone3_set_tid.  Whether it segfaults in
its current state is unknown to me.  But it's good to be addressed due to
defensive reasons.

Link: https://lore.kernel.org/20260722130246.2135563-3-christian.gellermann@codasip.com
Link: https://pubs.opengroup.org/onlinepubs/9799919799/functions/getline.html [1]
Fixes: 26b4224d9961 ("selftests: expanding more mlock selftest")
Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 9d349c151360..16294bc7dae6 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -84,7 +84,7 @@ int get_proc_locked_vm_size(void)
 int get_proc_page_size(unsigned long addr)
 {
 	FILE *smaps;
-	char *line;
+	char *line = NULL;
 	unsigned long mmupage_size = 0;
 	size_t size;
 

