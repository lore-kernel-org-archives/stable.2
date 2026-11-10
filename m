Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351597;
	b=Xq+KDUUgglNQ+vbX5xsnbku61+ebnYDK0iAP2tZYmCJUYTwCLeuc38r1IGYlB6O72MQW
	 fAhyff8QCf5sE1isPJ81PFB4rE85Sz/j0qQ9Iv9UYOWSq+0I9zbC91x38vo/emnrM3L9j
	 ka5L4V+va8jj1gvvKSTMFihCuacsL3WRgIlzT/fASaV57wAkbvE0qnYS0h9MQF7bmcGho
	 yJPe0exdnPeYfibMMBjjOLuqfFBmLgeOQUA/Yshs0yq3excaCirHOTlyy/CWIFnbUJsYQ
	 crXNfl6AQeVrKQOIyy3894yPmDELJMYVmRM8KJIjQG0CbQLQVqpIHuDVgz70PEpUqTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bFIpRPx2YZGBGUB7lpvwu3PR8rwLsePjl+Y2HF5Tgp0=;
	b=1nI8L8ZDGkJZplxn/XW6Evxo/zh9dhNj4iBINi7uhtZE7uxtYj6VHbMRY227UBLQopxr
	 vA+Qqrv3Kx/rysxpuwoe3MAfliXIlLQ+qKMwn1RbYV3rSp5I6GX8LJeEbemvWxEFsGOd4
	 iajoVk4pIvoWZqAgDZ+Skbr00pUABxkVdanSuRNORHAvRrIS1oY4lfpbjpBi0rHV2bDVU
	 O3zvOHg+Of8GnKKA0DkstmKADy+2K5AlJ1nHbIGt9En4gwieFYWQFuW6hhyZnVoYCZqxy
	 yndND+UVWxKErLIT0TnO99MyY0U8xTxuIhLcOwopzfXkkLHxjMO+G+xtxmc6loPnrEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs3ewZ+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs3ewZ+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A531F0093C;
	Tue, 10 Nov 2026 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351597;
	bh=bFIpRPx2YZGBGUB7lpvwu3PR8rwLsePjl+Y2HF5Tgp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bs3ewZ+vb2gZEPEjHAIm0RHvIO0b+25N6FAerZ+uSAT8FNsK1SYgBEOPezjGJC/3r
	 6ECvdB/VJfoiVRg6mpycstloZ36ATKXG2yUhhZPwX7g7IAER6aLa0PY80lsnTkFYXj
	 8CwJBlR/w6fqxlyCxZoeRduvrtsyJsrPwIO3qYhZQk70hxwxW6fWVM9phpAWcfJ+1p
	 htjMXu2ztl4HXJEsvkt1GyyyzrxTlCVA2hq3+rlIZ1XYv+QGX9dTiluQ6kbH+r++mh
	 NkPr7ptH9DdvNB28zoF9/KLpjj9oe2F6OK4K3mUSmD81wS7fsSb+Lo4rM3z0p/l7Ij
	 SYY5DDEepeVcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiang Mei <xmei5@asu.edu>,
	co+ecaada42f806f629@bugs.sh,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ceph: fix integer overflow in the snap trace bounds check
Date: Tue, 10 Nov 2026 17:59:55 -0500
Message-ID: <20261110225923.4141850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061207-failed-5.15-b3bf89767e3c@kernel.org>
References: <20261107061207-failed-5.15-b3bf89767e3c@kernel.org>
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

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit b3bf89767e3ca9506f1c7167cac97c41ec254d42 ]

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
[ sashal: Adjusted snaps_len declaration placement to account for missing client and ret declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/snap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 74a1fc919c6be..ce1f489e00e84 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -710,6 +710,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	struct ceph_snap_realm *realm;
 	struct ceph_snap_realm *first_realm = NULL;
 	struct ceph_snap_realm *realm_to_rebuild = NULL;
+	size_t snaps_len;
 	int rebuild_snapcs;
 	int err = -ENOMEM;
 	LIST_HEAD(dirty_realms);
@@ -723,8 +724,10 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
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

