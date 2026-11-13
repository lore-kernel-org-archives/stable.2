Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598474;
	b=amIRHwT5xq5bkk7CEjuTF6TQbgSf1uP+zS8UX0JGqzz3AeeG4VtiXnUnn4Jwzldec95t
	 kVJBTMQu33DmNLj0uSAK8m06QzzOoUkZBUgThYor7qQHHLF+fy9qkB2EH3nUR8/GR5ufW
	 WofAbO/D3Rsb5L/Y49q0B2CIi5I27YtdaaDLc5RlQssRsI7e28fhLVauaySItHOneqktW
	 1X1ZankEdd8J3zU+NnkooAmyP3cm7CfVJ/H+zt40XQewilOLMco/AOaj2a2FYIWDudxLm
	 G6ZepiAe8p3pPi3xcLfSUIz0Hpwx6wUfkXDu/LzVTBR4xIH4kpaqHbRTVcNGpphYERg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ybZial6OH2fIDR+0PMVbHbS6Ebe3KSMC4eGg+MKp4LU=;
	b=1McGMHKslu44P1MFNuQzFJ2k2wUZKisow/F0sltXAb7vEsapbFlAJ36CzlqhkHRdImtd
	 S1ilT+nhVa+HOjAPMrMt5eCQZFq3odUOzGR0LqBhFeUK2fHx2YRLCgeKUzBZUGHy8WP1d
	 FmoMftDPwG2ODJ08qvx+GvXxzPSrTYJmwGrcOJbimZ+PZ9UaLPzz++e59mhAW4oJFld3O
	 OeYw3Zk1WZuZiMnFUCSVSsSYkWMib6MRjfz73jvNnfuPRYXXAjOGy8vvOo+ypS+ogCt8A
	 bRZ6PNrt3M76jJeTufJxwHU/VmT3D2VhoLoZk26Ls4UW052DcmyyjRgpAeKRbxpaBiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4BVVXAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CE606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4BVVXAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F91F000C5;
	Fri, 13 Nov 2026 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598474;
	bh=ybZial6OH2fIDR+0PMVbHbS6Ebe3KSMC4eGg+MKp4LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4BVVXARj/+FKoTiLDSz2DAhF5GxbHlaesiCJUHn2V6DjlGAWDNA5g2VmU2t3GiXO
	 rxjCRuw3y6BJAGN6zt5rgDQfms6vcRlCmvqMSVBqQExX7tkZgCWVP14kp+u7ed3xJF
	 uiytjRiWZXVLX/EQf1mEdg0kBr7g1FNIQmikoddXqhj4J5mrSfs0EVNgZCH61nRAQP
	 vD+uhQpJ1hJlDDKSH6AxchTaSDVpeljbYvpgUUFjWNmkTOQVb4bALgCggtXdl7c6tA
	 aZnURumlp3qANSUGnqlX+D49b9Ufl4K7PWparkTohOBYKMRocd5EUGZC0tdjrImpXD
	 REKAUHInFsV9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Kelley Nielsen <kelleynnn@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm: make swapoff interruptible when unusing mms/shmem
Date: Fri, 13 Nov 2026 14:34:31 -0500
Message-ID: <20261113192840.2281715-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202201-failed-5.15-740128dd1a3f@kernel.org>
References: <20261109202201-failed-5.15-740128dd1a3f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Down <chris@chrisdown.name>

[ Upstream commit 740128dd1a3f2bd81a80314d079b6b03c39ba3af ]

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
[ sashal: adjusted context for pagevec and frontswap accounting while using the existing retval return path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c    | 4 ++++
 mm/swapfile.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index cc5b08d9802cf..04363ece9ecf6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1285,6 +1285,10 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type,
 			}
 		}
 
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 		start = indices[pvec.nr - 1];
 	} while (true);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 04f10e9c36c54..b8dcfdad0e7c7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2039,6 +2039,8 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	pmd = pmd_offset(pud, addr);
 	do {
 		cond_resched();
+		if (signal_pending(current))
+			return -ERESTARTSYS;
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
@@ -2275,7 +2277,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	if (READ_ONCE(si->inuse_pages)) {
 		if (!signal_pending(current))
 			goto retry;
-		retval = -EINTR;
+		retval = -ERESTARTSYS;
 	}
 out:
 	return (retval == FRONTSWAP_PAGES_UNUSED) ? 0 : retval;
-- 
2.53.0

