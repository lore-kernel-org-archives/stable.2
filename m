Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274020;
	b=tamkepPFkv3cumvgbVJVel70Usq5AjEz4iSjf02Bhp3J12ObBmqZB1xZCCIVKf5/XFfg
	 6WejiOV+jo8aAQ/72W4uWG/5dmesTzAQzcch5J8N6Dwiv9WbiQEE3EComrlHsRfVDc9Vz
	 nh24Hwa4KUt1GG89J4zYNxFzpceYLMC6TyM/UwJEiG5MSOHeGOoaVF58xgKCYyQ9sJVBn
	 dei6IvPex9rZq+NSVLCopwAXoBb4/5g1t5iVPvPcNKnUPLB8iZHf8HiHOiZcm2ayflvd5
	 yyJ3C5TPytVIqa7nkqL1nXCc778pfmgogrQPxAuHxi4VWOGThMeFoaugPgBklkVb8dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vpqEs5lJNNb4VFk4zeEd/WlwKZveL+VADwHIfuvF+hU=;
	b=3BqqJ9yIjPC2xemjjuuhCSpJGQO3TEfabjvAfjdbPWxndQyMuIUdeVNsFCYYxnzEW9BF
	 NQXXMTKQAJb7sgWQ6H0Y36DcEmhZ56DS9vH8JaohyfezIUSbizg7wiPWKimpKtD5jkS/G
	 BiTzUBOo/8y1iShQmzI+YUS+Pn+FmDg18re7roqzXDCW12rWqxz8U2ibZQuq6OJWfvBBk
	 JGakbj73AK1rFUN5qzHcbv0lQqjMVDDYXmtt84rUUT28XHoNWNQn27jws+uk6gKTS19ji
	 cAcluRcbuMUh7V5xqxJrAEZiPNkNAvXmONokD2x9L8Zi8OW+FQDtABeRHgynunbq5zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Im8K3ycq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45A6071847
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Im8K3ycq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BE71F0089F;
	Tue, 10 Nov 2026 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274019;
	bh=vpqEs5lJNNb4VFk4zeEd/WlwKZveL+VADwHIfuvF+hU=;
	h=From:To:Cc:Subject:Date;
	b=Im8K3ycqv1fDWDxL4p8jaO+cdsY5PVPf1oLEoKE71J/7r+fyc3Pr9wlNr6ZvbBdgi
	 Y0PrEdXBcsEv4BJv4ZaoLEBmy+BdU6cjnsvEKDMPiKb+39olH/Qx6c34krjdGaZnl4
	 pjB3ibC+fhg0itDOXDyFmwcouP0S+ybWbc575nJb+yBDX1qTcJ5X58m5OiFDptv3Z7
	 /qNYyPjiNoiDpJRQmrpQY28/eTNc0W2mwcWKx1v0krF73NXVSxgP8HfOqQj9RAFrko
	 h+RimmGfJnU80VDCU25z3n7UJZq1A+n9tMxjbfFzJU+UuU6sqbutOBNkTlFi6N3Eoh
	 kWh5BKdIBgAkw==
From: Sasha Levin <sashal@kernel.org>
To: chris@chrisdown.name,
	akpm@linux-foundation.org,
	vineeth@bitbyteword.org,
	baolin.wang@linux.alibaba.com,
	kasong@tencent.com,
	hughd@google.com,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	huang.ying.caritas@gmail.com,
	kelleynnn@gmail.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: make swapoff interruptible when unusing mms/shmem" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:56 -0500
Message-ID: <20261109202656-failed-5.10-740128dd1a3f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 740128dd1a3f2bd81a80314d079b6b03c39ba3af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202656-failed-5.10-740128dd1a3f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 740128dd1a3f2bd81a80314d079b6b03c39ba3af Mon Sep 17 00:00:00 2001
From: Chris Down <chris@chrisdown.name>
Date: Mon, 26 Oct 2026 22:31:03 +0800
Subject: [PATCH] mm: make swapoff interruptible when unusing mms/shmem

try_to_unuse() only checks for a pending signal between mms, and
shmem_unuse() doesn't check at all.  That means that once swapoff gets to
a process or a shmem file with a lot swapped out, nothing can interrupt it
until every last page of it has been read back in.

Just as one example of where this can concretely show up, freezing tasks
for suspend or hibernation has to wait for swapoff to notice the freezer's
fake signal, and gives up after freeze_timeout_msecs (20 seconds by
default).

Here's a facetious example where one swaps out 2GiB of one process to a
swap file on ext4, starts swapoff, and half a second later tries to freeze
with pm_test=freezer.  Writing to /sys/power/state then fails with EBUSY
and this in dmesg:

    Freezing user space processes failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
    task:swapoff         state:D stack:0     pid:3175  tgid:3175  ppid:2955   task_flags:0x400100 flags:0x00000419
    Call trace:
     [...]
     io_schedule+0x44/0x70
     folio_wait_bit_common+0x1ec/0x3d0
     __folio_lock+0x24/0x40
     unuse_pte_range+0x2d0/0x348
     unuse_vma+0x158/0x248
     unuse_mm+0xfc/0x150
     try_to_unuse+0x104/0x3f8
     __do_sys_swapoff+0x220/0x5d8
     [...]

The same goes for anything else that wants swapoff to stop, like an admin
hitting ^C in a panic, of course.

Prior to commit b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
try_to_unuse() was driven by find_next_to_unuse() which checks for a
signal before every entry, so let's restore that behaviour.

Just as an example of the improvements, here's how long freezing takes
in the same test while swapoff is happening on my computer:

                      before                  after
    400MiB anon       8.925s                  0.028s
    400MiB shmem      1.639s                  0.003s
    2GiB anon         failed after 20.003s    0.011s

Link: https://lore.kernel.org/at9kJwdGkHPsWwgG@chrisdown.name
Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
Signed-off-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Barry Song <baohua@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>
Cc: Ying Huang <huang.ying.caritas@gmail.com>
Cc: Kelley Nielsen <kelleynnn@gmail.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: <stable@vger.kernel.org>
---
 mm/shmem.c    | 4 ++++
 mm/swapfile.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index af21a89abb0f6..3c0c7edd2020f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1742,6 +1742,10 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type)
 		if (ret < 0)
 			break;
 
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 		start = indices[folio_batch_count(&fbatch) - 1];
 	} while (true);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 254ce86fa923e..0f72a5b23a3a6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2689,6 +2689,8 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	pmd = pmd_offset(pud, addr);
 	do {
 		cond_resched();
+		if (signal_pending(current))
+			return -ERESTARTSYS;
 		next = pmd_addr_end(addr, end);
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
 		if (ret)
@@ -2922,7 +2924,7 @@ static int try_to_unuse(unsigned int type)
 	if (swap_usage_in_pages(si)) {
 		if (!signal_pending(current))
 			goto retry;
-		return -EINTR;
+		return -ERESTARTSYS;
 	}
 
 success:
-- 
2.53.0




