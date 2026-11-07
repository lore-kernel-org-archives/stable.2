Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048804;
	b=laX18S264FIzs7v9p8ZUEBqaBLgJEImmNxR9zxd5UAEApfUc6RstsjOKr0E+fc7z+Dq5
	 dcVEbjhRfgE9RJ2xvvY66w1hZgghelvHKrTNCpqO43IhIzBn1wWdHk3++qR/ga0YQ+FrE
	 lsDFkzde4bTIRsT9GBcXAsEn/w508UK3ZPNQosp8gR4nD43W8aK2lmh2qOjBdh78HkXC9
	 jFzG5oh2BC2bhU8f6TzmGr5ZK5Q7rSXVZBlfomjt2tUARxr+geGMvUHCK3+n4FnDgHC7u
	 rUG+6530+rx/cz88LslWWfcPNeg9GcK2eowpKPV0atAc36kwEtGJFGV+8dqTzFawjtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048804;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fZRwlVvUDprelfdK26dGMwLyf5YOLisWL8viX27aI9w=;
	b=ScfZ4c7ElF70sYlVACrMWY+kirSac5aJ47OeVSoNtXq19ev3+G8gudSdMS77EDbLGs0O
	 Bz71aMGBvq0MThWKdj97yCwKdWqPWxbM+yEpei82i4YL5SombbZBXKCpGwrTWWSnt/3mL
	 U4Qixf/iRXTyUVd2TemH+iKvFq2lX0trFODfgtQ70/eHAdXkdJRv90izZC8y+j1cqPj2n
	 9DTzIaBjzyUAgCEXBRsSvaBfoskobEf7lr1vus8YXBikTgaoyUf+xnSTasvqC3XTHppnX
	 f7glAPCaG9UZO5TT4fw9Hj8YE3XDq8T5i1N+EAdKgQJRbs50KAgaKHpOHzgU9rENGmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RndxuMVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A89606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RndxuMVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEF21F008A2;
	Sat,  7 Nov 2026 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048803;
	bh=fZRwlVvUDprelfdK26dGMwLyf5YOLisWL8viX27aI9w=;
	h=From:To:Cc:Subject:Date;
	b=RndxuMVM6Os4LOB/Fqi3JTan3TUVeHk5DJwmq0RnsXbUWMxu+z5DohdMc2LCkFgkg
	 JDc8N1kb6Z379qMsfR2Nt5B5X9JXJTyhWPCJrIykkgoLTESJk/WKq1i9UWghWhzrEC
	 k+eGsTPgrnt5PAcARN9R5EXHfenLw4xv87lmwbmJ927Ot/DetR2p8WG01aVMieUP2r
	 N/WnbA649PkJssPTAEUK4Xpg8SYw340LdR36KreiAnuCA6h7G7rpCLREMkMlvTIMKD
	 nc7ZE7r72yEV/uCIDDNHvT55xkAppxk4uwXR9FCE2pDIPRKUlyNps532Swq6rsqU8K
	 jSrlON54iyZ3A==
From: Sasha Levin <sashal@kernel.org>
To: zhangguopeng@kylinos.cn,
	longman@redhat.com,
	tj@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cgroup/cpuset: Fix task checking when enabling a partition" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:21 -0500
Message-ID: <20261107055321-failed-6.1-f5b5cf2be574@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5b5cf2be574df6f25cbf1b000960340bff9a0bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055321-failed-6.1-f5b5cf2be574@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f5b5cf2be574df6f25cbf1b000960340bff9a0bb Mon Sep 17 00:00:00 2001
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
Date: Tue, 20 Oct 2026 21:36:15 +0800
Subject: [PATCH] cgroup/cpuset: Fix task checking when enabling a partition

Creating a child partition can fail when tasks are present in its
descendants, even though the parent has no tasks of its own.

On a cgroup v2 system with CPUs 0-7 online:

    cd /sys/fs/cgroup
    echo +cpuset > cgroup.subtree_control
    mkdir A
    echo 1-2 > A/cpuset.cpus
    echo root > A/cpuset.cpus.partition
    echo +cpuset > A/cgroup.subtree_control
    mkdir A/B
    echo 1-2 > A/B/cpuset.cpus
    echo +cpuset > A/B/cgroup.subtree_control
    mkdir A/B/C
    echo 1-2 > A/B/C/cpuset.cpus
    echo $$ > A/B/C/cgroup.procs
    echo root > A/B/cpuset.cpus.partition
    cat A/B/cpuset.cpus.partition
    root invalid (Parent unable to distribute cpu downstream)
    cat A/cpuset.cpus.effective
    1-2

B should be a valid root, leaving A with an empty effective CPU list.
The task in C belongs to B's partition and does not need CPUs in A.

partition_is_populated() is called with B as excluded_child, but
continue only skips B in the pre-order walk. The walk still visits C
and finds the task there, so A is considered populated.

Fix this by skipping the whole excluded subtree with
css_rightmost_descendant(), as is already done for valid child
partitions. Also add a test case to test_cpuset_prs.sh with a task in
a grandchild cpuset.

Fixes: b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cpuset.c                            | 4 ++--
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 585a982249ad9..71644482faa7f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -478,10 +478,10 @@ static inline bool partition_is_populated(struct cpuset *cs,
 
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
-		if (cp == cs || cp == excluded_child)
+		if (cp == cs)
 			continue;
 
-		if (is_partition_valid(cp)) {
+		if (cp == excluded_child || is_partition_valid(cp)) {
 			pos_css = css_rightmost_descendant(pos_css);
 			continue;
 		}
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index d04aad697b96f..9978c560b3986 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -452,6 +452,9 @@ TEST_MATRIX=(
 	# Enabling partition with child cpusets is allowed
 	"   C0-1    C1      .    C2-3    P1      .      .      .     0 A1:0-1|A2:1 A1:P1"
 
+	# Tasks below a new partition belong to it, not to its parent.
+	" C1-2:P1 C1-2 C1-2:T    .      .      P1     .      .     0 A1:|A2:1-2|A3:1-2 A1:P1|A2:P1"
+
 	# A partition root with non-partition root parent is invalid| but it
 	# can be made valid if its parent becomes a partition root too.
 	"   C0-1    C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
-- 
2.53.0




