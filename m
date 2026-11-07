Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047892;
	b=XbJBx/QW9pKZoJtbswiksq6SC7Zm3ec1foG6BP+mlKWXIJbSLir4GgdyG+ghKhqMvJK3
	 GnihWNNvC0xzZMukbz/Us7b4/BTK7ow3XKcYLZDqA2aF1LslYNX3Xdn1DS2LiVhh7JQz0
	 iiTBe3rUfqtTrU9rQw5hkA2IGU66NvfdRVNDqRfaSgWTHl345fk7Ib13YslZV52B+Vg3M
	 y5h7NNPHIF+ZoDhF8SlBkZ8Ks9ubLY7UNFaGESO4mNKaq7ADAMkRgLFs1TEbpmR9dW0qj
	 xEBHPTf8m0Xu8WyQTvai9Tyowe8ENTwKK9AievUjhr/eLG7pQbXHv6Ufk9XjE+Svk1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UaacOSM5fnieK6hQgxowWzdtAK+8YcI/0fpM/VKfg9I=;
	b=dSBMedB6jhK+Z1qrC1tfjqVrdWROnemUNT6pwlZ0HsnbLC9qm36wCfVQO8B3M5RB2qBq
	 0MDuWTASOv5QtTNjdizwaJGWSqVo1NDt/VCe17a2+WKCo8cZm5hltK0BjeCQUsQ029dwg
	 BCvTS7SO/v7r+WfKqTf2SCPClX6HJGvpRqnqWKh7ZPraPBNPFBWUjLERW87r31l5EBbP0
	 c95NDfkcdkn0zVH2WP/YHrm2wwezNa9HsTFEqtW8EXszQ6yTEFKq2ZydjNFZHx++uPyDG
	 qJUTjQgr7fQgzhUqlCgdrN+dSZNEMZNjYI23lv/LVCRZ3w+63xScJteqwYW/3uVP28A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB3zX4+a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB3zX4+a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D731F0089F;
	Sat,  7 Nov 2026 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047891;
	bh=UaacOSM5fnieK6hQgxowWzdtAK+8YcI/0fpM/VKfg9I=;
	h=From:To:Cc:Subject:Date;
	b=BB3zX4+aJs4snmOmPP/S+ijLOIXY7ezyTgNeK3NbZ95vMNhThTPgpeo/Z4kNhXoX8
	 S0Kr1nr5hGh9jSnnMhW0DT62hsU/ITxIIczGLo9yevxfTcxXIiTff7CbyTeNjjFLft
	 lhSJTQ/sp8tJD46wg0uY+ts54+9RKK6tVbo/3aCYXoTZfAOB8iE+gbwbQQZNzmW0XA
	 EUg4LJwoq/Of3u4EKTKDZbLz6O0ppMzRBza87pFWj3weNM4wlKekwmb6bPwg3oQaDm
	 ZfIuI26IiliEr143/9tjjmBVSVe9UG1OQDIj4CSztvXdGCCmCMH1G9xIfd838V6ikC
	 Z3uwzdZH5PW8Q==
From: Sasha Levin <sashal@kernel.org>
To: zhangguopeng@kylinos.cn,
	longman@redhat.com,
	tj@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cgroup/cpuset: Fix task checking when enabling a partition" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:10 -0500
Message-ID: <20261107053810-failed-6.6-f5b5cf2be574@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f5b5cf2be574df6f25cbf1b000960340bff9a0bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053810-failed-6.6-f5b5cf2be574@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




