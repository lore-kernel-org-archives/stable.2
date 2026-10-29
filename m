Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248053;
	b=PBPnbHka70V9pDIScYco/8ThkDUu2AABOag2+0CSDLmme4WZkJ/9kHgQu3Xs48hZ87pU
	 qVzBieAP4Z/q1hP53kH97Xm3c4m8Srkdg15uFzuLeBI9UkY26A9ybSmSplXHtO/IC89l4
	 cX4T5SVFSa9Sj2A4We7jD7ztrDidbF2F5rDWXeoxiC4qQwlJei3slNRrRd4MDdG6HgrXW
	 u3daVo/lfAqBq2lGjm3KTWPhNK/JrprpP55rbQCbxz9IUWK+H4g2YZRyGb+COqbZjtqhJ
	 k5NdfRgKeNdlz5BepHkLVdUccfGouJjxZ698NADVt4XIiYgECvGkQ4Bbz2dvLVgit8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RKqYqsjIxSLlGzKhZXBBrOPGFw2mBf2DyMFxJyqEHDQ=;
	b=IFj5Do1EGIxHwOliM1saZO6OkVOyHvQUvTZb+KVkMm7zw9gxnsj6+Hpi7R/5jl6e0Jrx
	 hvuC+14ictenIxlC8r8AJS2afMxb20JGC+/9hBECCuMWD/s+jXfo55y75ORBpPmZOKdMj
	 5uUMADj31fSD86bXI2+gGnGshlc2TcZvxhHpa515Ho14Bs5SNOhxOQtQaviBod9uJZ8Sx
	 TfefqFQxRcUTthZRKSuJFuFmmlMGmMbkhVJ5IaPFC6xugJe/Nv47TK8lmNvBcBHQWa5Jj
	 Ab/YQHsZ93BD2kJoBetSv3ZbiWjtL4Nk0wj10Hf7GuOk44cqjxZjPc6pNm9K4JY2hPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRFi4lNE;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F6606A338
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D4F6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRFi4lNE
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso738651a91.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793248052; x=1793852852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RKqYqsjIxSLlGzKhZXBBrOPGFw2mBf2DyMFxJyqEHDQ=;
        b=VRFi4lNEZxpTwtXgGUaYz3Fj+Cz2g4mBhs+TyEgTHiMPyiMjODXTteMaFr8NkgxOVv
         xIjjYQ3OkoA2O+FFQsz9h/jC/zrWzaS0H6J5LT3z0AkOdeVa1rbEGsO9ORvkQqeye6QX
         JvRg9TuTP9Wj4Q8BBcXHNWMGHJ5+p9Xbxo6MtgF/0WuDC7n8ATqlxZWM7H9R7GesXW0V
         Hknahd/sPkNtuMWkfIdY8+XN/Gs94i7xXvsCmap6PSbT7XMvlVrKQugMeBPKCstbOSyc
         Hs0wUMdcZ4KqI5/augboVK1ddAEIFV9hJiZvOh7ej56uyAnjV2P0coXe38K8iq7Pusp6
         DWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793248052; x=1793852852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RKqYqsjIxSLlGzKhZXBBrOPGFw2mBf2DyMFxJyqEHDQ=;
        b=RTs+dl8Fl3fumQLPyU7fcSCIahNa8BYS4BnxukdKkgDRbqbkj0VTjlVMFf5Wk+xCC5
         TlK3vWzyO7PZ1eCm0tlzH5hnI/9RKUzFnzxo17CNG8KFw5Y2vowcM+1qnOjyi+eUxq0l
         lmRF4JpR16DOe7+EbF8rte5um0TdohClhAi82UnPyUkNcX7WgQnO3rMVocJnMtESBFhv
         fOwTD/sGuHKcp9uiMlmOzz/DKmefn0lD4zZC7MnlI+suL1QMe1cxphzxHPkq2SBzuCq8
         LW/uXOsx+ojEV9+JPxGQ3G+E57NK58ywUDW4wkJMCPY5MD2ffRF3o4cMBanHIewCfqSv
         zAvg==
X-Forwarded-Encrypted: i=1; AKwUvBwff6CLtHwYDXvEK06XD10zOiUgpTb7568gG6PU6GUZNvtPfe1lnsgSPNJYNFuVI0InakE2vRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJu3UM/oxqObZ4VcrTRfUgDItL4TV1AbaAddIwzZ+UR6QfWMUdH
	Iu48+6dIYvAiQZnZ/FJbESGWDajIDP3Gb9gsGXj74q/JqDfaFYy8AQIY
X-Gm-Gg: AYBFou2+cgCfKFwR+nPGZ8ntOsz1umWs2N6kw/ks91HVhZrCBBLq2Gb+tWCtAkWewXz
	MH3BqZ221xstV3JZvw/AOi/uaeFkKUtFq77yuQ1ME7fFZd53ZRJfWFw1bueXO3fBuOyFfjymjsF
	r4iDWFY8SxeCbWeI44kofZRgOn3RCIMYl9BIORb2yhZj5ew5RafzEo63ML5+R7+dtMF4FVKMafd
	JLTxLLbVjZIXtGIGpnf/S8EuUVme65HfavMaAuuRI6gw37uiq+jh+mBtgUfHH/5h0WWi37xzUo1
	rhXrwHFr8I1cZJz6szusESpjQ6ybXdg/6qnuITvasDfwYCC7YCPp0fudBpWQFzROY3c6C2g+KtK
	RxIgGjURSoxvjNXvy5E6dYJe+iX6qELxu1dgUPXg8aE4K2j3g94TwxC+vlp0wTNMoN8e8dHXZV/
	TO9Tz1xHvxGHXZ18uarwWBztdZZmO+C2o3s98W1qwLTvN/8wy2ZhM4KRoCJ44hDt1ZpzXFEMT0i
	VCogVfnjoeys2md46cdiZOAwMVnxvEPpHj2JQHh8j9h2vmzR3yOs5E1KFpTqzvkkPRq2qFCgMS5
	qe3hXyTkaDcetn2om4A58eMTAmkB67YjmlaCUbwzv/fXOBRUmSGQxFA=
X-Received: by 2002:a17:90b:54cd:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3ae580f1940mr3392128a91.25.1793248052271;
        Wed, 28 Oct 2026 21:27:32 -0700 (PDT)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e898317sm2010846a91.16.2026.10.28.21.27.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 21:27:31 -0700 (PDT)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	guoqing.jiang@linux.dev,
	gi-oh.kim@ionos.com,
	aleksei.marov@ionos.com,
	lgs201920130244@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] RDMA/rtrs-srv: Do not free the path on path file creation failure
Date: Thu, 29 Oct 2026 12:27:17 +0800
Message-ID: <20261029042719.75868-2-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029042719.75868-1-izaiahsun@gmail.com>
References: <20261029042719.75868-1-izaiahsun@gmail.com>
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

When rtrs_srv_create_path_files() fails after kobject_init_and_add() of
srv_path->kobj, its error path ends with kobject_put(&srv_path->kobj),
and the release, rtrs_srv_release(), frees srv_path.  The caller does
not expect that: process_info_req() goes on to free its tx IU through
srv_path->s.dev, and rtrs_srv_info_req_done() then closes the path,
whose close work tears down the connections, puts the session and
finally frees srv_path again in free_path().

Commit 5b7437339011 ("RDMA/rtrs: Fix use-after-free in path file
creation cleanup") reordered the cleanup inside
rtrs_srv_create_path_files() so that the helper runs before the put, but
the final put still frees srv_path under the caller.  The same pattern
exists one level down: rtrs_srv_create_stats_files() puts
srv_path->stats->kobj_stats on failure, whose release frees
srv_path->stats, which free_path() frees again.

With one allocation failure injected into kobject_init_and_add() of the
path kobject (failslab restricted to rtrs_srv_create_path_files), KASAN
reports while a client connects:

  BUG: KASAN: slab-use-after-free in rtrs_srv_info_req_done+0xe43/0x1740
  Read of size 8 by task kworker/0:1H/84
  Call Trace:
   rtrs_srv_info_req_done
   __ib_process_cq
   ib_cq_poll_work
  Freed by task 84:
   kfree
   kobject_put
   rtrs_srv_create_path_files
   rtrs_srv_info_req_done

These paths run in the server's completion worker when a client sends
its info request, and are reached when allocating or creating the sysfs
entries for the new path fails.

Keep srv_path and its stats owned by the caller on failure: the error
paths only delete what they added, and free_path(), which runs in every
case, drops the kobjects that were initialized but never made it into
sysfs, so their releases free the structures; otherwise it frees them
as before.  This keeps the kobject names from leaking, which is what the
puts in the error paths were added for.

The problem was found with kbound, a static analysis prototype that
checks whether callers rely on an object after a callee returns a value
for which the callee may have released it, on v7.2.12; it is present in
the rdma for-next branch.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings.  Run-tested under KVM (KASAN, lockdep, kmemleak), failing the
path or the stats kobject allocation with failslab during a client's
connection: before this series KASAN reports use-after-free in
rtrs_srv_info_req_done() and rtrs_srv_close_work() and a general
protection fault follows; with this series nothing is reported, also
with CONFIG_DEBUG_KOBJECT_RELEASE.  Failures of the two
sysfs_create_group() calls were not injected.  With this patch alone,
the close work still uses the session freed as described in the next
patch.  Not tested on RDMA hardware.

Fixes: 424774c9f3fa ("RDMA/rtrs: Call kobject_put in the failure path")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 kbound
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 16 +++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 9dd9141c86a5..45ee07a98ca8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -238,25 +238,24 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_path *srv_path)
 				   &srv_path->kobj, "stats");
 	if (err) {
 		rtrs_err(s, "kobject_init_and_add(): %pe\n", ERR_PTR(err));
-		kobject_put(&srv_path->stats->kobj_stats);
 		return err;
 	}
 	err = sysfs_create_group(&srv_path->stats->kobj_stats,
 				 &rtrs_srv_stats_attr_group);
 	if (err) {
 		rtrs_err(s, "sysfs_create_group(): %pe\n", ERR_PTR(err));
-		goto err;
+		kobject_del(&srv_path->stats->kobj_stats);
+		return err;
 	}
 
 	return 0;
-
-err:
-	kobject_del(&srv_path->stats->kobj_stats);
-	kobject_put(&srv_path->stats->kobj_stats);
-
-	return err;
 }
 
+/*
+ * On failure, the caller still owns srv_path and frees it in free_path(),
+ * which also drops the kobjects initialized here.  Do not put them here:
+ * their releases free srv_path and srv_path->stats.
+ */
 int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 {
 	struct rtrs_srv_sess *srv = srv_path->srv;
@@ -296,7 +295,6 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 	kobject_del(&srv_path->kobj);
 destroy_root:
 	rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
-	kobject_put(&srv_path->kobj);
 
 	return err;
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 5314599d29fe..641a7bf5e02c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1584,11 +1584,23 @@ static void free_path(struct rtrs_srv_path *srv_path)
 	if (srv_path->kobj.state_in_sysfs) {
 		kobject_del(&srv_path->kobj);
 		kobject_put(&srv_path->kobj);
+		return;
+	}
+
+	/*
+	 * rtrs_srv_create_path_files() may have failed after initializing
+	 * these kobjects; then their releases free the structures.
+	 */
+	if (srv_path->stats->kobj_stats.state_initialized) {
+		kobject_put(&srv_path->stats->kobj_stats);
 	} else {
 		free_percpu(srv_path->stats->rdma_stats);
 		kfree(srv_path->stats);
-		kfree(srv_path);
 	}
+	if (srv_path->kobj.state_initialized)
+		kobject_put(&srv_path->kobj);
+	else
+		kfree(srv_path);
 }
 
 static void rtrs_srv_close_work(struct work_struct *work)

base-commit: c3e8e9451e6f1b69f685b75e0fbf14f3d0fb2539
-- 
2.53.0

