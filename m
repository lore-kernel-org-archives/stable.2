Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E70427A04
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950411; cv=none; b=fVKOdB9PnsCwuvF+l/gBUif+prkOTAxlG+CICvweUNWrsQ2st14CAnMBd9JGctw/0l7Meglio9/ge41eg7/bOL/G1wnVj+ecRdwttNPK2OJpKnSUoHR9mwLZokralPpa4nwQanjhFR22JpAyBPUPbVk/MEMstR7b6V0t6i/w0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950411; c=relaxed/simple;
	bh=cBgTs0FLeXDcznInLL67hO/38tyI5oRDOtB8iRbUm8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IVOmlpOHqXsi1/8yn6rT/hbpaE7mvSSHFnSOXFkanpYTI11irwpviE0CHvQiQZozVaETrQAgvPQubOGdbXUscG4jYY9MiPDAvgKfuE/cL4jHYo0Gc14dbnnz6nLVCGlrIUR17IlyZNbdbVN9U4zwGtyUzeib5PmIKbqlfpq0nzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLURIQrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLURIQrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3641F000E9;
	Mon, 13 Jul 2026 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950410;
	bh=YzNmIlcZq2dyX8CF4ZPCUCNpCSyaCJNxFFxvxDG+vio=;
	h=Subject:To:Cc:From:Date;
	b=eLURIQrbK+yUNeU5Mqs/+x3nZvTcMGK79ysC/MR8iDZODcONdpi0SeHXuIIKhwWtj
	 rgfs5zdSP3Rvs2KSErwdoVTJKA1dtOrf7cEBVN2nVUWS6g7YFwP02wnSrNVo0sJnUg
	 j7PdGjHDFd9mG0zSR5Mln4AyNaiayZbpR3bAtSoQ=
Subject: FAILED: patch "[PATCH] mm: swap_cgroup: fix NULL deref in lookup_swap_cgroup_id on" failed to apply to 6.12-stable tree
To: jose.fernandez@linux.dev,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,hannes@cmpxchg.org,hughd@google.com,mhocko@kernel.org,muchun.song@linux.dev,roman.gushchin@linux.dev,ryncsn@gmail.com,shakeel.butt@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:43:02 +0200
Message-ID: <2026071302-lethargy-obedient-3108@gregkh>
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
git cherry-pick -x 63b02a9409cb5180398491b093e48bcb5315f5fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071302-lethargy-obedient-3108@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63b02a9409cb5180398491b093e48bcb5315f5fb Mon Sep 17 00:00:00 2001
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Mon, 4 May 2026 12:55:17 +0000
Subject: [PATCH] mm: swap_cgroup: fix NULL deref in lookup_swap_cgroup_id on
 swapless host

lookup_swap_cgroup_id() passes swap_cgroup_ctrl[type].map to
__swap_cgroup_id_lookup() without checking that the type was ever
registered via swap_cgroup_swapon().  On a swapless host every ctrl->map
is NULL, so __swap_cgroup_id_lookup() dereferences NULL + a scaled
swp_offset().

Since commit bea67dcc5eea ("mm: attempt to batch free swap entries for
zap_pte_range()"), zap_pte_range() -> swap_pte_batch() calls
lookup_swap_cgroup_id() on any non-present, non-none PTE that decodes as a
real swap entry, without first validating it against swap_info[].  A
single PTE corrupted into a type-0 swap entry takes the host down at
process exit.

We hit this in production on a swapless 6.12.58 host: ~1s of
"get_swap_device: Bad swap file entry 3f800204222bb" (do_swap_page() being
correctly defensive about the same entry) followed by

  BUG: unable to handle page fault for address: 000003f800204220
  RIP: 0010:lookup_swap_cgroup_id+0x2b/0x60
  Call Trace:
   swap_pte_batch+0xbf/0x230
   zap_pte_range+0x4c8/0x780
   unmap_page_range+0x190/0x3e0
   exit_mmap+0xd9/0x3c0
   do_exit+0x20c/0x4b0

syzbot has reported the identical stack.

The source of the PTE corruption is a separate bug; this change makes the
teardown path as robust as the fault path already is.  Every other caller
of lookup_swap_cgroup_id() is downstream of a get_swap_device() that has
already validated the entry, so the new branch is cold.

Link: https://lore.kernel.org/20260504-swap-cgroup-fix-7-0-v1-1-f53ff41ee553@linux.dev
Fixes: bea67dcc5eea ("mm: attempt to batch free swap entries for zap_pte_range()")
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Reported-by: syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/69859728.050a0220.3b3015.0033.GAE@google.com
Assisted-by: Claude:unspecified
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index de779fed8c21..95c38e54dd58 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -124,6 +124,8 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 		return 0;
 
 	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	if (unlikely(!ctrl->map))
+		return 0;
 	return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
 }
 

