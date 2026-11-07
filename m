Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050948;
	b=YMYQPosthUhhUErMHWNqCZPqPvNVpwyikd+l4/jVRmb6Unq8jE6uWmhVvkGfCx/Hjs4/
	 5/3XYDcnJcb2YN040B6Lsn37GHt8xMbEOYcRJKhDd/mx5CTQaxC12MVNgKD+PI7+DaxgM
	 AJ7i65gQamQdVBPQmyqOWwTe1yScZR2TuonsAsEF10paIwft0bhM5Z/o3Cd9cbqXPiD2B
	 NoDOrzRpoKdzoCL2KAsa1q7nv6TZe5ktw5SF6z/oqwwnl6uFfCGdtESw8B58UyyoaXE6d
	 BVUJd/TSteMjiodznkyJug4YXpxMIpoqXV4z05HINyu7fucNSRgkpE8/GpPG+rs0zVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LPCQuNQtkvuPcT3kT7vqEzG8o7EI5UF6IZsSGOLJtOw=;
	b=eIis2J54I+f9JHheAGZD3blRCh8wopNbk5LDMxhN94YGiE56SVnwJFGrJgyngMXoJfXp
	 PpSC1I0PEFZXDqUs8CC9wHy5thJll0zTcyhSua/PbW5kDIOZTL9d3X/oBbu7YVtVMebeE
	 vDXCuBw745YowQuHkNW5pZgJdDcM6KW1CKvIMBKmb+ntfNpGiUPihD7nBezxxMTRXC8OX
	 KeDctvrq+kFgAipum23b6RUrTpxtt+IIO30BqT71dJw9VjOcESaR8S1Kp5Js3iWMW+u1K
	 Ufb5o0EehYZpOpTkPI7ezp7Pfgy8cU1itmTuzj5UyuDPxkP20/UkXXSPqGsuhy+mlNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3Yrk285;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D710606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3Yrk285
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3051F0089F;
	Sat,  7 Nov 2026 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050948;
	bh=LPCQuNQtkvuPcT3kT7vqEzG8o7EI5UF6IZsSGOLJtOw=;
	h=From:To:Cc:Subject:Date;
	b=N3Yrk285qu2DYXkh/+zW5ULqvHD/sq+8CekOkFJXQmJE64lLL0ToAtMKki32uzCZs
	 TtCtOPINhpcHNPStK09rUORWNqGkDDb0Xa5rArkhACBeru7GYrgTayZhtLib3Lc9vA
	 6DSq5Ia/jRfyLK6NOZMVzMxa6jbrmJEeztiG2XJVuJy5uTJGPfpJT5Xtk1DERyL0mI
	 prRFyYk1v2/4kmahVFhfEwfklraP5UMPTtJx+RHuPa9snH2x0QzXL14fbCcBHOuQYZ
	 EWThqInaRIwAakVECqOUIl06ughiXCROtkuWr85NPk2v1309rKGY8CFwvOdYqoyQin
	 rheTE1OjD1z9A==
From: Sasha Levin <sashal@kernel.org>
To: xmei5@asu.edu,
	co+ecaada42f806f629@bugs.sh,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: fix integer overflow in the snap trace bounds check" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:06 -0500
Message-ID: <20261107062906-failed-5.10-b3bf89767e3c@kernel.org>
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
git cherry-pick -x b3bf89767e3ca9506f1c7167cac97c41ec254d42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062906-failed-5.10-b3bf89767e3c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b3bf89767e3ca9506f1c7167cac97c41ec254d42 Mon Sep 17 00:00:00 2001
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 15 Sep 2026 14:40:27 -0700
Subject: [PATCH] ceph: fix integer overflow in the snap trace bounds check

ceph_update_snap_trace() bounds the two encoded snapid arrays that follow a
struct ceph_mds_snap_realm with sizeof(u64) * (num_snaps +
num_prior_parent_snaps).  Both counts come straight off the wire as __le32,
so the addition is evaluated in unsigned int and wraps before sizeof(u64)
promotes it to size_t: an MDS sending num_snaps = 1 and
num_prior_parent_snaps = 0xffffffff makes the sum zero and the check
degenerates to ceph_decode_need(&p, e, 0, bad), which always passes.
dup_array() then reads num_snaps * 8 bytes past the end of the message
front, which ceph_msg_new2() allocates at exactly front_len bytes.  An
unsolicited CEPH_MSG_CLIENT_SNAP reaches this from a malicious or
compromised MDS with no client-side action, as do the snaptraces carried in
an MDS reply and in a cap import.

Compute the length with size_add()/size_mul() so it saturates at SIZE_MAX
instead of wrapping, in the style fs/ceph/mdsmap.c already uses for
num_export_targets.

  BUG: KASAN: slab-out-of-bounds in dup_array (include/linux/unaligned.h:28 fs/ceph/snap.c:500)
  Read of size 8 at addr ffff8880102a16c8 by task kworker/1:2/129
  Workqueue: ceph-msgr ceph_con_workfn
  Call Trace:
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   dup_array (include/linux/unaligned.h:28 fs/ceph/snap.c:500)
   ceph_update_snap_trace (fs/ceph/snap.c:836)
   ceph_handle_snap (fs/ceph/snap.c:1155)
   mds_dispatch (fs/ceph/mds_client.c:7234)
   ceph_con_process_message (net/ceph/messenger.c:1424)
   ceph_con_v1_try_read (net/ceph/messenger_v1.c:1430)
   ceph_con_workfn (net/ceph/messenger.c:1576)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  ...
  The buggy address is located 0 bytes to the right of
   allocated 72-byte region [ffff8880102a1680, ffff8880102a16c8)

Cc: stable@vger.kernel.org
Fixes: 963b61eb041e ("ceph: snapshot management")
Reported-by: co+ecaada42f806f629@bugs.sh
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/snap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 498ffc1a91cb8..5c1540d95b8c3 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -788,6 +788,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	struct ceph_snap_realm *first_realm = NULL;
 	struct ceph_snap_realm *realm_to_rebuild = NULL;
 	struct ceph_client *client = mdsc->fsc->client;
+	size_t snaps_len;
 	int rebuild_snapcs;
 	int err = -ENOMEM;
 	int ret;
@@ -802,8 +803,10 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	ceph_decode_need(&p, e, sizeof(*ri), bad);
 	ri = p;
 	p += sizeof(*ri);
-	ceph_decode_need(&p, e, sizeof(u64)*(le32_to_cpu(ri->num_snaps) +
-			    le32_to_cpu(ri->num_prior_parent_snaps)), bad);
+	snaps_len = size_mul(size_add(le32_to_cpu(ri->num_snaps),
+				      le32_to_cpu(ri->num_prior_parent_snaps)),
+			     sizeof(u64));
+	ceph_decode_need(&p, e, snaps_len, bad);
 	snaps = p;
 	p += sizeof(u64) * le32_to_cpu(ri->num_snaps);
 	prior_parent_snaps = p;
-- 
2.53.0




