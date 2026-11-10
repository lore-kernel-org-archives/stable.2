Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273725;
	b=Ld5dW6ex6oCq8UdneGowLzPu9vw6bDmsCt/70JyrYc4IMAiL2ubVinQoJcjDeEEA5TRC
	 9bW+iPynN9k3q1QmQtgEtfap6NIJwgqMGaiNRBt/YDbSheQrnpJo1WNEl93RW6C7xTnil
	 vFPPiR0JBG3qdXmvfWqI4ds9zDEB/fvLaK5HK+KLlXczT5UJpXAP+JOzMbXTGalrhkeRq
	 xSDpAmKLPsq/2fqa7bWbk3vLoeKO+14T0F+I3tw5LwpNUBM8j52n5D9NZysFw01lmbwa+
	 zhBBwIQyErcvBiOExAmFUEkedX1v/Ae/5cFTmtj/mNzxDRHRHesZFis9clq8zEs/toQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273725;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gs6wl0CnX60cdyrT8g9LrT4dkUqOF5ZY3BlqQDWGGN8=;
	b=yJcDhHxX7pZbDi6CL98sgBEGH7EwOIBLPsd/v6BbNUsH+ix7Wt0qzq9lB2d3S2NMDa8U
	 b6X2xUXwSgjSb9lydJ07jmbvxkWGzvvR7XniIRO4ZFXYuo0WkCJBbkjuxjwqpy2aXSOSZ
	 v/CnJZWa4+p8DPFlBRWQvHbD4lI4dqDpB2d36rvXDJjz5w+EbtMIleKodB0KvNrioJJEm
	 hnT/qXHP6CoJTUyxO+6dROOpB9sugVdGdpBEz9DQnUOqgCdkYuqNZizjNOo5WlK5zC5b1
	 0O216jqiA93G5pO2swUYHGYbavSliktTHZ/EAOgkWeHiX6srvbIu/MTvCFr9VH/6ORg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGkVoy5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C660A382C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGkVoy5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AF61F008A2;
	Tue, 10 Nov 2026 01:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273724;
	bh=gs6wl0CnX60cdyrT8g9LrT4dkUqOF5ZY3BlqQDWGGN8=;
	h=From:To:Cc:Subject:Date;
	b=fGkVoy5gawyaO6fHI0U8JMpd3mBWf8PKaCvECtoXz3/s0m0TSnntDDOsH3qjr8Xc+
	 EfFDFs0FgsP3ByWbui43Shdjho/Pljr1FjL3TIV7tldNfU3eioDuRtJYn+DU/D7/dq
	 11RSfFa/s16lVvzzWjA6E6rchSNCnaD3u1wXKGECL32ZI4+U83CjrAxrRV4JdTysQs
	 pHdS1ZlE2q/w5ak4PQqZx4qfM3jzeBV9+CXUbGYms28m5+EhWHnnsfN+bQnFRphp1s
	 10djyl2T7/op1wq5mGHqXWoSag61rso3w2FgACACQrUlTN7Cklfk/baNU3yi831caQ
	 JG9MLLa3uo+hA==
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
Subject: FAILED: patch "[PATCH] mm: make swapoff interruptible when unusing mms/shmem" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:01 -0500
Message-ID: <20261109202201-failed-5.15-740128dd1a3f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 740128dd1a3f2bd81a80314d079b6b03c39ba3af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202201-failed-5.15-740128dd1a3f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




