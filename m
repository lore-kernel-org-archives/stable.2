Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2A78F3A;
	Wed, 30 Sep 2026 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752204; cv=none; b=MonIngzqY5UrhBrXXBwWhwLoYC4FIgCKiz1MrwLqAxRia6EXQuVX4u5iwt2hXngav9ZmPRzfb4LbsUeR9R3+O8je5VdURWhAz3De1pPqN4uCX93R5+Xpvx85moLjDuMySz1YzZ1cvj2PIQGRsS5LPY6nsDdW2BJ/cIwdojaBReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752204; c=relaxed/simple;
	bh=MDPDxXr/HwSX2pavh2LwYaCQfmqbvXG0OAX42Imozoc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Gcmg1GgCBZFMBbqWZ52gltxe++ZmoYsBV2N4OlDPzcTXzQLevaP4sSw3h9hPPjudXouc0SseaZeMQk+1JBV15ZMpg99SOFUeNRyiG2AMcJKP7UZszQ5uPOmmD/KmerxtP1vhcNJXUhbA0IWC0leODSaSiyjKfGUJvz3l+1Y02cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=DzfevVMI; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="DzfevVMI"
Received: from smtpclient.apple (unknown [124.126.139.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f9bbcb4a;
	Wed, 30 Sep 2026 15:09:55 +0800 (GMT+08:00)
From: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: [PATCH] ceph: fail readdir when the MDS reply carries no dirfrag
Message-Id: <912FC30C-9C0A-4D68-A49C-A13CE6C9DE8E@stu.pku.edu.cn>
Date: Wed, 30 Sep 2026 15:09:45 +0800
Cc: ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 "Yan, Zheng" <zheng.z.yan@intel.com>,
 Sage Weil <sage@inktank.com>
To: Ilya Dryomov <idryomov@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-HM-Tid: 0aa0f12603cc03a1kunma877d13626e267
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGklJVkJLQk5KQ08ZSElKT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VSklNVUpIQlVDTVlXWRYaDxIVHRRZQVlPS0hVSktISk
	5MTlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=DzfevVMIlYUbfrU6/K6EgwiBU51vM473Pg3KLCxnO8SjA6hjUOh6vxOO8JqB0fXfWryr1pIZlzB0JlDFy5Q9fM5fhjExM2k1tBuJQgnDaybPet8oPglv1bNeOg8l0J7o8ZZw3gJ3xmLCu8lGjWoA9+tZ6QwEbCXxYA6XqWXgzJ0=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=AkwvRPb3tHKPXkrgdAG82shJ9QGp21uHFh511UI8vbc=;
	h=date:mime-version:subject:message-id:from;

A ceph mount oopses in ceph_readdir() when the MDS answers a READDIR
request with a reply whose extra blob is empty.  parse_reply_info()
skips reply blobs whose length is zero, so parse_reply_info_readdir()
never runs, r_reply_info.dir_dir stays NULL, and the reply still
parses as successful.  ceph_mdsc_do_request() returns 0 and
ceph_readdir() then reads rinfo->dir_dir->frag with no NULL check:

	/* extra */
	ceph_decode_32_safe(&p, end, len, bad);
	if (len > 0) {
		...
		err =3D parse_reply_info_extra(&p, p + len, req, =
features, s);
		...
	}

The oops on v7.3.0-rc4-00537-ga3ff15db6820, one getdents64(2) on the
mount root after an ms_mode=3Dlegacy mount, trimmed:

BUG: KASAN: null-ptr-deref in range =
[0x0000000000000000-0x0000000000000007]
Oops: general protection fault, probably for non-canonical address =
0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 266 Comm: ls Tainted: G                 N  =
7.3.0-rc4-00537-ga3ff15db6820 #1 PREEMPT(lazy)
RIP: 0010:ceph_readdir+0xbff/0x3ea0
Call Trace:
 <TASK>
 ? __pfx_ceph_readdir+0x10/0x10
 wrap_directory_iterator+0xa2/0xe0
 iterate_dir+0x1da/0x5d0
 __x64_sys_getdents64+0x13b/0x2a0
 do_syscall_64+0xdd/0x4a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

The unconditional frag read came in with 81c6aea5275ea ("ceph: handle
frag mismatch between readdir request and reply"), so the bug is old.

Treat a reply with no dirfrag as a protocol violation: warn once,
drop the request and return -EIO, the same way ceph_readdir() already
handles the two malformed-reply cases later in the function.

Tested on v7.3.0-rc4-00537-ga3ff15db6820 (KASAN).  Unpatched, the
getdents64(2) above takes the machine down (oops=3Dpanic) on the first
READDIR reply.  With the patch it warns once and getdents64(2)
returns -EIO, no oops, no hang.  A conformant reply for an empty
directory =E2=80=94 dirfrag present, zero entries, =
FRAG_END|FRAG_COMPLETE =E2=80=94
still lists "." and ".." and returns EOF on both kernels, so normal
readdir behavior is unchanged.  The oops is still present in
v7.3-rc5 (72d3fcf802c45).

Fixes: 81c6aea5275ea ("ceph: handle frag mismatch between readdir =
request and reply")
Cc: stable@vger.kernel.org
Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
---
 fs/ceph/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 2e5c0ccb1b346..d7d48d3c3baf0 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -466,6 +466,10 @@ static int ceph_readdir(struct file *file, struct =
dir_context *ctx)
 		      (int)req->r_reply_info.hash_order);
=20
 		rinfo =3D &req->r_reply_info;
+		if (WARN_ON_ONCE(!rinfo->dir_dir)) {
+			ceph_mdsc_put_request(req);
+			return -EIO;
+		}
 		if (le32_to_cpu(rinfo->dir_dir->frag) !=3D frag) {
 			frag =3D le32_to_cpu(rinfo->dir_dir->frag);
 			if (!rinfo->hash_order) {
--=20
2.43.0

