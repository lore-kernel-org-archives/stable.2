Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163F436BC6
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929809; cv=none; b=kmyJVPZOKh/3zxlw2UA/Bdjurwyb6pe388ah7tQNPLFv5NBfX8auIp/yhBSEcd01U9SBIL4qnUWwhMNV76C/BYCzokh0+Kwd9HtM5DtCvAvP0ZzMgvJsg9UfbguL7Ei1AjsyTYnrG3zNViyGK/vNVFa4ncoMcbcjy/9L4WNd4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929809; c=relaxed/simple;
	bh=mB9go2lTY9wGaCCvxwiElpQ/DO4FnUo5NtMMbvaUiKg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j8NhfChfR3AXlpzGOtkK6Hjf8DmxPgWcnaGIPBrJg0OADIoHUziwNUz+T7EYkVPjlmSYjk/RBNXUSj/wKNi1wK2U6ghd7FC03vxXo+BeOmBJ+cbw+65H30zItVXBILD8RYpjoxcgOdXsCRB4ssD1wQh7yE/SldaeBKGyrGuiKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFdEGPst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFdEGPst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A31F00ADF;
	Wed,  5 Aug 2026 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929806;
	bh=vLclRJy7aml+u+lWngH6S0jFcxVT8ZiJo4g+COxOg3I=;
	h=Subject:To:Cc:From:Date;
	b=ZFdEGPst7KLqyp8lOGM3QY2qvlOptUCMZcJx6TC6AwQQeaWbcO2+iTx6+j53uSPR2
	 HImtg0bf5jgStNM5Vgi81W8BJErt0SXqQCHzp3bP+Wey4BWHjqiV/cmDL4+mEEGPBc
	 WxxWUJ5lTQVJlN79zPh4j1Tv5BBFqRyRaLrN1qKc=
Subject: FAILED: patch "[PATCH] selftests/mm: fix potential wild pointer access of getline" failed to apply to 5.15-stable tree
To: christian.gellermann@codasip.com,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:36:18 +0200
Message-ID: <2026080518-nuptials-untaken-f165@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1d75a4ce04095afdb63d8e540092ff8151dacf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080518-nuptials-untaken-f165@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

