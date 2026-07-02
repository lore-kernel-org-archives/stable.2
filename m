Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA24A3405
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000547; cv=none; b=joLvkKTTemhHdTH61DSFWpSiRyWtZS0f6EChxw8Y1Or3kPgYMIImAo9ClCvc74RrF8zmlToEKco1CJvDnCw0Wyp5uj5TA29vrvw2123UtFye30oQNAMQ/gexbSoS4Y5bXng4FfY6RDDLhmc4ipK2RLSJRG5GjvIboGWUo3KtsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000547; c=relaxed/simple;
	bh=asbmvTQbQA883AJ2fERlceVLlMbEY9nQnvuuiAFmc50=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=laUQCGLQNmUXEGloN460WXRLd4eOfX0dt9wZfFd3v4uLNLlcb7lyoS3aT/pNGA2+7BTQ9Yc7VEqn78Iev7+CjzLQJp/d8Rl0QrVGKjx3NDcRoNCiZzKpziojxF3ZfEST4gJY7yiVE5VM21VI41LJojSmHegD1EY+kAhZK2+xZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5Bm2TCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5Bm2TCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC72F1F00A3A;
	Thu,  2 Jul 2026 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000546;
	bh=KA4OqGyh0oyI5jetT1EQe+mc2sMV3bnIRNeXSDnCBo8=;
	h=Subject:To:Cc:From:Date;
	b=J5Bm2TCyrSH69sSCpz1JWwJghOVhFzJrjD4BZh8/lPsJNqe0hm8KVHopqvDtA28OT
	 EIJuTIpxy0X4cSeS3F+EIj3K2iztbxX217iUdmJ2BUPQ3IjfWzU0Uu5fr06bJHdr7j
	 m343xx7lnx94+YAntJONT/IJYUXQJ6B/4K3Xqtj8=
Subject: FAILED: patch "[PATCH] NFSv4/flexfiles: reject zero filehandle version count" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,anna.schumaker@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:55:44 +0200
Message-ID: <2026070244-oversweet-untaxed-e3da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070244-oversweet-untaxed-e3da@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 13 May 2026 12:26:56 -0400
Subject: [PATCH] NFSv4/flexfiles: reject zero filehandle version count

ff_layout_alloc_lseg() decodes the filehandle-version array count
from the flexfiles layout body. The value is used as the count for
kzalloc_objs(), and the current code only rejects NULL.

A zero count yields ZERO_SIZE_PTR, which can be stored in
dss_info->fh_versions even though later flexfiles paths assume that at
least one filehandle version exists.

Reject fh_count == 0 before the allocation, matching the existing zero
version_count validation in the flexfiles GETDEVICEINFO parser.

A QEMU/KASAN run with a malformed flexfiles layout hit:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:ff_layout_encode_ff_layoutupdate.isra.0+0x15f/0x750
  ff_layout_encode_layoutreturn+0x683/0x970
  nfs4_xdr_enc_layoutreturn+0x278/0x3a0
  Kernel panic - not syncing: Fatal exception

The patched kernel rejects the malformed layout without KASAN/oops/panic,
and a valid fh_count=1 regression still opens, reads, and unmounts cleanly.

Cc: stable@vger.kernel.org
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 6a84d85e0651..99caa8d28c25 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -551,6 +551,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			if (!p)
 				goto out_err_free;
 			fh_count = be32_to_cpup(p);
+			if (fh_count == 0) {
+				rc = -EINVAL;
+				goto out_err_free;
+			}
 
 			dss_info->fh_versions =
 			    kzalloc_objs(struct nfs_fh, fh_count, gfp_flags);

