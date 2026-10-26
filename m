Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059034;
	b=oNq3kaqE3aCHa7Yx2WSZ8ZaB4lVQN1nL2PS3IdaPG6iEky7prcdluCckR4MiX8rTzrAy
	 OnFb4EIdMZ3P4sw7BQb6gmRTmRfXPicv/UkZKvasuxKiTIPtZiZi42gj6JVR7Zw7djZM2
	 1lmjtc5MXLBndASsnQSUKqWLibx4WL8+4VycE/eCsbUh7uzh6AC3cVWtqrxDXXf6424aD
	 v1ZYz24H1wuUZNpX97uAY8G3tc+fU52STnJC3XjwklYHVjQsJ4xo0bBoYXBZ/E9RzAq6t
	 Mop3QFIwAKDqx8LEkDPKlQeLPTX2vNLze91F+TSQeAyAKVj786nFqQnWeTmriiEl3Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qDIKx2Op6aSLUbez/797DuVnzQCw0y2by19BWYigguE=;
	b=rYmCT3iz4+S9iCQ9t4Pp0j3FcS5zvA+7+HcSFBnejglE79mK+XMgtouOfAhS4wTDQa2D
	 4tbdOREXl2Hg+PjMG4JrX6Bqo5aBDo6JTW92p3G3xSE1tYpAPtPpt2IwxtP1YHZjdPHIT
	 OBJ62Qr2C89n9Fw1UwOB1kZjdvM0YEai1lNWJkztWq/GL7ft/xRfvQ0K64JGhF1f/GrMV
	 dlGtsH8NdZarUmKsXQ7ayBAZtjfkzUk2OYVIGR48VJx1DheCAP3L8vV2JGh/gYhxl68Bm
	 l67zF4it4y0PSTHWbeDtEk/qclY0L4icXZYjqrNODYqOO0QrI6aqMlEWtLYi36PNJEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iak8vfcQ;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F190606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F190606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Iak8vfcQ
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9178d514951so29824866d6.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793059033; x=1793663833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDIKx2Op6aSLUbez/797DuVnzQCw0y2by19BWYigguE=;
        b=Iak8vfcQjHrDPwgQ6ujDpPm2w85Fejjtj5b68bZf8Kj1152YR6lk8u/qfNFnfWa6aT
         r+KT97wPb8ErZD8+MYStSX8iWx4LCW6/GOfeSYoMfmKwaHjQGn2ZsFkzrRT6eQJITsxM
         I2wFhWIjq1sDrASOUfFNtqJ2ygtqju0UOC/O1xL9jSehAaSGhF/ZYlPIJHAJ0Qy7OFtO
         CNIM0kcfjWR1bozkvCAuFFVZbphBqYsgt6PtXAKune2U1c4VYL9b33DTFsYCgQWlHbpF
         ytPxeNguoQVhpDQa4DuXvUfLHku/wL2Q3yWLpz+44dbreFarrSkFZV58Ulj2jbKPaPkS
         TYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793059033; x=1793663833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDIKx2Op6aSLUbez/797DuVnzQCw0y2by19BWYigguE=;
        b=Q19WF3usTpvq3RX5FPK5RmePVMkzuJ17gpDTJOgnbKS/UUozaWuGJjWK5YIxJ/g2OQ
         VfBMwzhP6NXpIckdgFBfAmfpRPb60gUs8wQ8PKKBmP/GbP5iZ4+bgGjmAwm4NZgfqr+h
         iE2L0zOxSWJVN0zZkJ7iYBilLi6k4ExbrjKlvSMofY7xRmt4lNLrTdusXJ/MsDYBTuap
         DwZTxk2IbSf7mU2/DOkg8S06IJ6xVAmGlcUhLBW0Q4KDh7T6qMPwdR2iCdmm8jPRnCZy
         PfH1NZvZm8h9PddACZRyxHff/C8p4SRRDdI0BVpPKV6TumivnGrqIHa5av9GWB56DOOL
         qtJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqYH97RT+hEyqucLxGq5JDny2EXSrEZI8qXi35o6VQdODznciWIbYLsYpCBRACttWEX/i7PPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6DJPSZi+YfP1BX+G671bHqGR8XxJZwogjTGQpxzXSjB/PTEvw
	uvuuu/k+LHDZ/T+Zzc9BIMlmNN5cfyQ0ZMM6MY9uy772wWCfgOQ6KPGF
X-Gm-Gg: AYBFou3ayrtybAVFUqdVw9mI854TgEXr44wMdn7aAUr3Hwbuc1WCXako/RTNuEgTfqD
	E3kovNsClP3/szA1nfsaa4GkzqTmVJi/JfpL8pjpk1kfNUh0sbh6opqH62APzWKr6BvoXdznbdb
	qUh4vm93clGnBj+IIBOHl2YKRrGtj5UtPP3C6zFpvmUFYdtuSLw5KLrHtVjFTpPDbtKCKkIsiXb
	oCNDP18M8a2PKIfP0AeMbk5bAghbE3Mdciu30Tk/SKYuKE/YkGIduudSzyjlA+QlcSibBNa+n/m
	zIhlNACkXZWLriferyuMT5gxDq+a9xNcbUyLFpIm4Z2MfFnMyxzuB3X3Ztvb7RysHJg47cu5RHg
	ltQW3VkFuDDZm8STfEMDJIRfw8HtFhxjwC+p2cvd7ANEsL9fexbEmDp7T08NfPxKCk0te4P62Lf
	4SQQpyUrny966TSVTdi9xXF3WQ9uSsVxsyU066zaWY/I/+H0PP830k/NunjJ2xIsuwZAlSMBuXG
	zyPuNFjByMveX/wuSh30TeLU2EvC66lRdNDqHb7ucVEF5iqtwRAQM/vcYWUCpRMmisiCQ16k7Y0
	CInxAusxcbc32oJ+EArgjqfzX2CDuks=
X-Received: by 2002:a05:620a:8702:20b0:940:f224:5a63 with SMTP id af79cd13be357-940f2245db0mr872745185a.64.1793059032925;
        Mon, 26 Oct 2026 16:57:12 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787f33sm823849485a.25.2026.10.26.16.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:57:11 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfsd: shut down running servers in nfsd_net_exit()
Date: Mon, 26 Oct 2026 19:56:26 -0400
Message-ID: <20261026235626.649844-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Since commit 924f4fb003ba ("NFSD: convert write_threads to netlink
command") the server can be started over netlink without mounting the
nfsd filesystem. But that mount was the only thing pinning the module
while threads run (commit f49169c97fce ("NFSD: Remove
svc_serv_ops::svo_module") removed the per-thread reference), and
nfsd_umount() is the only caller of nfsd_shutdown_threads().

So when the server has been started via netlink, a plain "rmmod nfsd"
succeeds while the threads are still running. exit_nfsd() then frees
struct nfsd_net in unregister_pernet_subsys(), destroys the DRC slab
and finally unmaps the module text underneath the running threads:

  BUG: KASAN: slab-use-after-free in nfsd_file_net_dispose (fs/nfsd/filecache.c:483) nfsd
  Read of size 8 at addr ffff888109fe92d0 by task nfsd/300
  Call Trace:
   nfsd_file_net_dispose (fs/nfsd/filecache.c:483) nfsd
   nfsd (fs/nfsd/nfssvc.c:957) nfsd
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
  Freed by task 311:
   kfree (mm/slub.c:6802)
   ops_undo_list (net/core/net_namespace.c:257)
   unregister_pernet_operations (net/core/net_namespace.c:1412)
   unregister_pernet_subsys (net/core/net_namespace.c:1459)
   cleanup_module nfsd
   __se_sys_delete_module (kernel/module/main.c:804)

followed by a general protection fault in nfsd_cache_lookup() as soon
as a thread allocates from the destroyed drc_slab.

Shut down a server that is still running for a net namespace in
nfsd_net_exit(), which is invoked for every net namespace when the
module is unloaded. nfsd_shutdown_threads() is a no-op when no server
exists, so nothing changes for the common case. As the laundromat
work is queued on laundry_wq until the server is shut down, destroy
that workqueue after unregister_pernet_subsys().

To reproduce: start the server with nfsdctl (or any other netlink
client) without mounting the nfsd filesystem, then run "rmmod nfsd".

Fixes: 924f4fb003ba ("NFSD: convert write_threads to netlink command")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Tested on top of 7.3-rc7 with KASAN and with PROVE_LOCKING: with the
server started over netlink and an NFSv3 request in flight, "rmmod nfsd"
now waits for the request to complete and unloads cleanly; starting and
stopping the server via netlink and via the nfsd filesystem still works.

An alternative would be to take a module reference while a server
exists so that rmmod fails with EBUSY, as it does while the nfsd
filesystem is mounted. Stopping the server in nfsd_net_exit() seemed
simpler and mirrors what nfsd_umount() does, but I am happy to rework
it if the other behaviour is preferred.
 fs/nfsd/nfsctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f32311f2d7cf..0a9679114b58 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -3113,6 +3113,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_shutdown_threads(net);
 	kfree_sensitive(nn->fh_key);
 	nfsd_net_cb_shutdown(nn);
 	nfsd_proc_stat_shutdown(net);
@@ -3200,9 +3201,9 @@ static void __exit exit_nfsd(void)
 	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
-	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
+	nfsd4_destroy_laundry_wq();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_exit_pnfs();
-- 
2.43.0

