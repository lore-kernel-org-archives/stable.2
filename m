Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297422;
	b=fkWF63RwihspLJ42DGjd8aisYrWPYA8f92mWezm2VwcGFhJwU2dklu4QSgYSwkI7c0Ay
	 VYH1qHcr3CtoJH0CqBay/Y5StYNTuRH7P82h5rB2hpRSA4cZtGGpE+V1xsY96nKrBcI4m
	 EwnpAbhKe+FAuHO2rw2gn6aaP6cwV3FtMME0DnB/e0njxzBsUWIWV9jN96rsebOqBsV1Y
	 PT96qB7sj2lX55h38DOLEwMC2rMiLv3YBWYxNMMGLvZZwJu1v3yhcpJL9u95Qc/BX07Z4
	 Gl6/7W4fYnvHqzzgCesGqo3YVT0q9POG8IpWsNrlyvgGTGbUmOOha5l99wS7QdkL3Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EGTY/uQ+UTmLe+oR99zarlRNM/ZZQqy4vu68uMqnYps=;
	b=Syckc+x28jnX9/XL33KNbDCppJ7kmEWLUU7Mgu2dXQwQEPQApDYVCBqtx1CfSl4vxwon
	 r1jMzZGMNPifrUnzwz22TJlqsJDTPUkajqA1nI/oChLkZM2VnVk4dFP4+TrAmg8fDGJFJ
	 8+QSAJYOfEA2eg0UyNuQfygqkV/UTtrJHhzkIg6NppdOUcBQB3Yhspi6DnZDxt032O/Kv
	 tll9AZr/5tQNgqDwMTEBpFsSSpDM+9T3qtw/UOWfWMFEymS2tP/+5GxXqjv9ruA1HEZCf
	 ereLXVJJT0i5gl0MkVer0x9WzPOmYwW6cD+2clgKt3IsWa3tkpOwcioW6DIWogpht3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HEyzv5yK;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4223606AB75
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4223606AB75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HEyzv5yK
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f20c3aaa5so223184785a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793297421; x=1793902221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGTY/uQ+UTmLe+oR99zarlRNM/ZZQqy4vu68uMqnYps=;
        b=HEyzv5yKUc+ILSupxzbFPXWI0K0JGjBSo21KDgxT33fJKSQHZCPzVyYksLSTP81YHL
         7sdyBlhCkN0yNt+7zRGjklaq7bn8Hmca4w+ynjGlnG051d7a7YqkX222TPb80hTI6gNT
         Nx6Miy9BMFxw1b/yOEII62+mlbPE9uuz9cBo+79MNeOkG/duCE80Ztxcw341G5k1muBm
         8Z4lM5L7HVtf8vP6QqvCKhk7NeuH+Cs0aIFOyyk+OnwqpUW/2HFzgNg/9fbzpRjz6NUT
         uplwc+8OwTTyYLHUOWxlFjWwlDIkvjNvfsykkyNf1tUIvBWncMVRT7qIYlVzWagew2xl
         dx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297421; x=1793902221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGTY/uQ+UTmLe+oR99zarlRNM/ZZQqy4vu68uMqnYps=;
        b=0p/MGcBZ6w1V/PkjApSNO1HF5roo8RaK+HEZ6lgK6nBC6lTDp+WfgO7g9UFInI9LH6
         rf1cyfBhnn1Cf9fMXYdIfSpwwhMc95u6F3FG9ahyDbqeGGFI2c02bCQ2BG4bF6x6l8oI
         7XkBev66bYs9VRKBch0fs7QKc3tQTsZZGtyXSvwfTnvspi+9iRd1nptkkW0xG1s0ZybD
         WowzbtqdQBb0CzYB0ykR7VhSQzth2Pk0jg64lrjGQQyHZyLj9WbljR3Y8k1JloNd9csq
         S52Ag5HT1Y2fGXzLdxAOPBfMj7oONauD+2AHFhNDRh9iWsGS561w2rwgsPf6AoGEioR3
         kuVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzREAXC/EfPa3//Wd/uOA+fM/ZO+lAlsnj+gnsZ/x8p2O2ATR9vSIwPmmZFOAMj/FQ5LQBcjmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLijm0pOgOUckgejssIv8b/StUQhi2B0aOSb4gz4TMU/F3JzCrC
	W46uxLFbXhvidU9hawxlix15U/8E4qg3ePlxpD/jHIyA6Kz2ah/K4kmg
X-Gm-Gg: AYBFou345GdhYyZHtigWW+PKcqcJvzloEjDxIE1AbN4JuSez7ZBuJRZ7vWAC9VO/M2M
	0wH7B0oxl1dbio8h/MTGZklH/flepwtMeQS1Y8xn4sQ6TxcabFqWjKXk7KVv8u6phzfgTjCY7hf
	ynrhUAhClACzVZ//272onUKIcPLkG7WFLBwResFp5gqDRTeo+pDQwRcFeBkuMoCXFqBXvQlscpW
	L2AuM3zonZw2/bhUvg/HoPkFoZ1Lw5koO4w9lR5fNYxw1b6wwsJ9dGm5MjLIzhzNfKKhA7TihXt
	8IfcIGlWPvDokUYQJBKjTjFFKR/yMOI9iYBc9q8Bv8IWZJxMDW70q1FqAOIjgLorYJpar9O1s7o
	FaQJBHG8tbt46VCUmYwylJOumBwv0Ag5M6twmQRpb2NPCGNmPqhqg/EJuNnWvSqo3sJUt/ZfdNg
	CPt+qMkkt1c9dp0t0s+LAgRcuxTGtfz+TpS9DOwXuL7L4SAjb+jxIAyV5oMM6027OmwrnCOoCPn
	VYq9O2wi+WQq4Yibhisy1eAZAl+iXdcDD8+16Kiabrsp3PwDo5DueG2dqWBzU9TukaIu8YrzlFQ
	i2DpSB4WA4+Fa8u2NrSeTmqj8U2qUB6cWO52zYnUO3cCaRkkHvwF6irWvdg=
X-Received: by 2002:a05:620a:6886:b0:93e:60e8:c9ad with SMTP id af79cd13be357-94421588089mr2508085a.12.1793297420516;
        Thu, 29 Oct 2026 11:10:20 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94421252364sm6295285a.28.2026.10.29.11.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:19 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nfsd: pin the module while a server exists
Date: Thu, 29 Oct 2026 14:10:05 -0400
Message-ID: <20261029181006.1305530-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026235626.649844-1-shuangpeng.kernel@gmail.com>
References: <20261026235626.649844-1-shuangpeng.kernel@gmail.com>
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
while a server exists (commit f49169c97fce ("NFSD: Remove
svc_serv_ops::svo_module") removed the per-thread reference).

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

Take a module reference in nfsd_create_serv() and drop it in
nfsd_destroy_serv(), so that "rmmod nfsd" fails with EBUSY while a
server exists, just as it does while the nfsd filesystem is mounted.

Use try_module_get() rather than __module_get(): a netlink command
runs without a reference on the nfsd module, and exit_nfsd() only
waits for it in genl_unregister_family(). A THREADS_SET or
LISTENER_SET request that is already running when "rmmod nfsd" starts
would otherwise still create a server after module unload has begun.
With try_module_get() that request fails with ENODEV instead.

Pinning the module also keeps the assumption behind the
__module_get() calls in fs/locks.c (via lm_mod_owner) and in
nfs_common/nfslocalio.c valid: they rely on an active server keeping
the module alive.

To reproduce: start the server with nfsdctl (or any other netlink
client) without mounting the nfsd filesystem, then run "rmmod nfsd".

Fixes: 924f4fb003ba ("NFSD: convert write_threads to netlink command")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes since v1:
- Pin the module while a server exists instead of shutting the server
  down in nfsd_net_exit(). As the sashiko review pointed out, shutting
  it down from exit_nfsd() still lets every __module_get(THIS_MODULE)
  taken during module exit (fs/locks.c via lm_mod_owner, nfslocalio)
  outlive free_module(). With the reference held, exit_nfsd() never
  runs while a server exists, so the laundry_wq / cld notifier ordering
  changes from v1 are not needed either.
- Take the reference with try_module_get(). A netlink command holds no
  reference on nfsd, so with __module_get() a LISTENER_SET/THREADS_SET
  that was already running when "rmmod nfsd" started could still bring
  up a server, and its threads then ran on the freed module text.
- Not changed: an exiting nfsd thread still executes a few instructions
  of module code after svc_stop_kthreads() has been woken up. That
  window exists on the umount path as well and is independent of this
  fix.

v1: https://lore.kernel.org/linux-nfs/20261026235626.649844-1-shuangpeng.kernel@gmail.com/

Tested on top of 7.3-rc7 with KASAN: with the server started over
netlink, "rmmod nfsd" now fails with EBUSY, also while a request is in
flight and with only a listener configured; after setting the thread
count to 0 the module unloads cleanly; starting and stopping the server
through the nfsd filesystem is unchanged. With a delay injected at the
top of nfsd_create_serv() to hold a netlink start open across "rmmod
nfsd", the start now fails with ENODEV and the module unloads cleanly
(with __module_get() the threads came up and oopsed in freed module
text).
 fs/nfsd/nfssvc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 067543da3ca0..6ae040c50987 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -579,6 +579,7 @@ void nfsd_destroy_serv(struct net *net)
 	svc_xprt_destroy_all(serv, net, true);
 	nfsd_shutdown_net(net);
 	svc_destroy(&serv);
+	module_put(THIS_MODULE);
 }
 
 void nfsd_reset_versions(struct nfsd_net *nn)
@@ -662,10 +663,18 @@ int nfsd_create_serv(struct net *net, bool no_rpcbind)
 	if (nn->nfsd_serv)
 		return 0;
 
+	/*
+	 * Keep the module loaded while the server exists, as a mounted
+	 * nfsd filesystem does. A netlink caller holds no module
+	 * reference, so this fails if module unload has already begun.
+	 */
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	error = percpu_ref_init(&nn->nfsd_net_ref, nfsd_net_free,
 				0, GFP_KERNEL);
 	if (error)
-		return error;
+		goto out_put;
 	init_completion(&nn->nfsd_net_free_done);
 	init_completion(&nn->nfsd_net_confirm_done);
 
@@ -677,7 +686,8 @@ int nfsd_create_serv(struct net *net, bool no_rpcbind)
 				 nn->max_blksize, nfsd);
 	if (serv == NULL) {
 		percpu_ref_exit(&nn->nfsd_net_ref);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto out_put;
 	}
 	serv->sv_tls = true;
 
@@ -688,7 +698,7 @@ int nfsd_create_serv(struct net *net, bool no_rpcbind)
 	if (error < 0) {
 		svc_destroy(&serv);
 		percpu_ref_exit(&nn->nfsd_net_ref);
-		return error;
+		goto out_put;
 	}
 	/*
 	 * Register before publishing nn->nfsd_serv.  Namespaces are only
@@ -704,6 +714,10 @@ int nfsd_create_serv(struct net *net, bool no_rpcbind)
 
 	nfsd_reset_write_verifier(nn);
 	return 0;
+
+out_put:
+	module_put(THIS_MODULE);
+	return error;
 }
 
 int nfsd_nrpools(struct net *net)
-- 
2.43.0

