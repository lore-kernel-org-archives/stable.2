Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76B3CB2DA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929805; cv=none; b=LOhZGWZuN+djqDnipTXAutXM97LiVbOuFi1/wGYD1yP55mYCl+Biiajd97poMa1l4G4w0t6v/8q3luZO4+cDhp9YcedEkOZux/Xf4R6Ggg/OSfBn3u34mpVFAUGql9kX8AauRYSsmkcnK5gnzIvrXXtKzTqZpeWeb7HoZlrfrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929805; c=relaxed/simple;
	bh=WI5tzRd1XyMaagR7tocAHj4rV5JjfCzYdMxATUH+Hr4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lM99ia/dDkWdNVM6GOB1DaOajXg2v/LZCHQLjn86rbkE/xsHFbPTOy/SaS96N58D8crA+gjVStU/8NbKnfE6H8grt0e0gkDUYjFx6eD2jRlsm5yiABviU0Qkrz6U6iHXqvLbwuwPyQnJ4fzkwMaFFnsP5vcI2qxiKXVnUMYvKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rC3J7RnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rC3J7RnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9771F00A3D;
	Wed,  5 Aug 2026 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929803;
	bh=2/zD0kfIdh7gcDH0e6LJzGNVowzwgA9C21MTvOXLOCk=;
	h=Subject:To:Cc:From:Date;
	b=rC3J7RnUIUQARsVLehuy7zCCB8awustntalCKBQpgg69UQvZYZLxAQMqmlGAYBo/I
	 HOqUllVwfl/dFiyO6I1ST+6JiGScohNI/ISJm0NGnM7BMcNsuFXKtmNsn4zqiOnYT3
	 sRsp4rODwVrGDzV8Wbh8Oims4N4qSyZ8Ko1b4ZVk=
Subject: FAILED: patch "[PATCH] selftests/mm: fix potential wild pointer access of getline" failed to apply to 5.10-stable tree
To: christian.gellermann@codasip.com,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:36:18 +0200
Message-ID: <2026080518-ocean-frosty-530a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1d75a4ce04095afdb63d8e540092ff8151dacf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080518-ocean-frosty-530a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

