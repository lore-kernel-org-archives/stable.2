Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598770;
	b=ZL9gwSBCILzydLti+IuNNBfY6AQeZopqCY5BpaxpQ0YTnOHmKrwnNR8XpwbeMGv9eKAR
	 5NqP9lvkfv/Ad8K+2nnjOn1JFfsYCCPMzylz4nsJkDqkarKgo2rXN1x03dUiJ8SmblRVH
	 a4o4+/nbFzpnz/Crwddi3DRnpud3xpyl+fU+Q/XnTKcgvOcova1hYmUM+ZjhfDMpVlJSy
	 OxwM8IQXdu64fI3CD8kENLHtIFCxwHNUeK8o+Ox5ISnunOvydfDfIBxLAMQcVq1SwBsOM
	 Ezk9octU3SypPuO737cMK/qsituQNXmvC2cVY0bOVk9IhCV0UlFSlpxjcx3OXSqG73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598770;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OozzF5AdedkUULnaKEzqOKguJ7nV/xtJq71eCQ2uOvk=;
	b=EXNM74+cfCijGd5qbdoK9/8TnWO6CFPUlhFgfNNUcfhNYQYyXw+iItvEtvsTVIA1Ut2o
	 Z2dy5CebB/uD+vsZ1Fm2y6Up0+XCMW4krqrQnzxNm/f77iMgPz1PJs0Ua8kF+mK5e0KCt
	 sRadJ2lUr8VPeEVQkfAOy2zDC9i5WtpSOcv1KLRqF8mpgn1+9ceO1Y++jzZBV8nFB9s9B
	 HXqroxc0cWUvQc8xV91nmC9vwoD72mO3crpRrDaTXGBhncdzrOEDGieaW/lxhXRZlLMYV
	 IlUJJN6LCXvGYGYlEC9j0NOCFaEb01W2zUR9w9I4LKzGUw018zVL4lUPpmha8N/S9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Za+48md7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B601606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Za+48md7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCF21F000C6;
	Wed, 25 Nov 2026 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598770;
	bh=OozzF5AdedkUULnaKEzqOKguJ7nV/xtJq71eCQ2uOvk=;
	h=Subject:To:Cc:From:Date;
	b=Za+48md70J5zhr40K1KE6hpOyHphK/VJRQHXJZFIx6b66gHk/hlu4FxLe+g2t3whX
	 LNMsIPe7lpXi41p10oTjm9d1sdolIRSHRKJpkkQrL1ZBfzZ7VRBkIGSJfgtBdY8pOz
	 m7SNfpH6kd/aKaVq6cLnetcpD5Cx7JG8ZeLjDLfg=
Subject: FAILED: patch "[PATCH] cgroup/cpuset: Correctly set isolated_cpus when switching" failed to apply to 6.18-stable tree
To: longman@redhat.com,ridong.chen@linux.dev,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:18:32 +0100
Message-ID: <2026112532-pellet-unvocal-7a50@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 56681bc448a80bb2473026b41c44c133766bc38d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112532-pellet-unvocal-7a50@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56681bc448a80bb2473026b41c44c133766bc38d Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Mon, 9 Nov 2026 21:24:00 -0500
Subject: [PATCH] cgroup/cpuset: Correctly set isolated_cpus when switching
 partition state

When update_prstate() is called to switch the partition state from
root to isolated or vice versa, the whole effective_xcpus is passed to
isolated_cpus_update(). However, if there are child partitions present,
some of the effective_xcpus are dedicated to those child partitions
and their partition states will remain the same or get invalidated in
the case of child root partition with isolated parent in the latter
update_cpumasks_hier() call. In the latter case, their exclusive CPUs
will be returned to their parent.

Therefore isolated_cpus may be set incorrectly with child partitions
underneath. Fix that by excluding their exclusive CPUs in computing
the correct cpumask of exclusive CPUs used by that partition alone.

Add new test cases into test_cpuset_prs.sh to test for such cases.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Tested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 87600628e080..06ceeb0ac8c0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3073,12 +3073,32 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 						  cs->effective_xcpus, NULL))
 			err = PERR_HKEEPING;
 		else if (parent_prs == PRS_ISOLATED)
-			err = PERR_ISOPARENT;
+			err = PERR_ISOPARENT;	/* old_prs should be isolated */
 
-		if (!err)
-			isolcpus_updated = true;
-		else
+		if (err) {
 			disable_partition = true;
+		} else {
+			struct cgroup_subsys_state *css;
+			struct cpuset *child;
+
+			/*
+			 * Need to scan child partitions, if present, and
+			 * exclude their effective_xcpus from cs. In the case
+			 * of switching to isolated partition with child root
+			 * partitions, those child partitions will be
+			 * invalidated in update_cpumasks_hier().
+			 */
+			isolcpus_updated = true;
+			cpumask_copy(tmpmask.new_cpus, cs->effective_xcpus);
+			rcu_read_lock();
+			cpuset_for_each_child(child, css, cs) {
+				if (!is_partition_valid(child))
+					continue;
+				cpumask_andnot(tmpmask.new_cpus, tmpmask.new_cpus,
+					       child->effective_xcpus);
+			}
+			rcu_read_unlock();
+		}
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -3112,7 +3132,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
 	else if (isolcpus_updated)
-		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
+		isolated_cpus_update(old_prs, new_prs, tmpmask.new_cpus);
 	spin_unlock_irq(&callback_lock);
 
 	/* Force update if partition is disabled & update effective_xcpus */
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 2d4744f2d6ac..1e9e6b4c6f7b 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -556,6 +556,13 @@ TEST_MATRIX=(
 	" C2-6:X2-5:P1 CX3-6:P2 \
 	                    .      .   T:X4-6    .      .      .     0 A1:4-6|A2:4-6 A1:P1|A2:P-2 ."
 
+	# Switch PRS state (root <=> isolated) will properly update cpuset.cpus.isolated
+	# even if child partitions are present.
+	" C1-6:P1 C3-6:P1 C5-6:P2  .       .    P2      .      .     0 A1:1-2|A2:3-4|A3:5-6 \
+								       A1:P1|A2:P2|A3:P2 3-6"
+	" C1-6:P1 C3-6:P2 C5-6:P2  .       .    P1      .      .     0 A1:1-2|A2:3-4|A3:5-6 \
+								       A1:P1|A2:P1|A3:P2 5-6"
+
 	#
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------

