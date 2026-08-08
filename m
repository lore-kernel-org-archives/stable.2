Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC04392829
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187564; cv=none; b=jTf0EUVT3flkwDWtgtgpNMr/KZOhiHuvFW+j9l9KqrghpKNG+hKE1sJxc0LGs3jsTDu1YSUI2worMSnhDl57UsTRc1FlJLXzOUM7aMQ8SdYbr3P4ip0si6GySCQaif+ORhpWgnjrdQ4DqPiAGkiSkNVU3O/N7iYoXW5z5ac+f+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187564; c=relaxed/simple;
	bh=UicqrhoENM+47wchf7LFuvjXdp6IwiaBt2Hiv18cFx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAV/LHyMj8UzOc35kQanOhZmMfUxZH/7CWVi48JrILrvef4Xi6PgsrBpuO2dEMHzNRKNEj1kCiu88lmctyQPX0qg3ZXJuU8659YM1zS1rpGzxSBU9F74h4S7znagY4oItUDOXIPdbJB/yU5te3mHxPxtK6EyKBR2HsTtmc/VV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1M87heQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1M87heQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F2C1F000E9;
	Sat,  8 Aug 2026 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187562;
	bh=JlYhBFaU6QTPyRgb0kf4vDiJZ/CXkCVX49vjwBsHEZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1M87heQ/v1XQx4VuRJBxq3yIZx4n11pRjXlRdLWiD98vWgmUKm8whuH/5rZapadE
	 6bvkKuNj0XUdBq0sN8bakeyHMIsVtXklv4cCj4VQAgx+qm0tQYLS6gJysMhVsZAHGA
	 7YKtVMt2OFk15EW5ZieoDVEI7szN5oxzI/tlj3mI27vTZEMacu12stS3rW2iKyvU40
	 OqeL6w6uPMr0oAVkAkqiXiTNmYZKOlo3l884dt6Q0b3FPTbQjnj4Ns3L/FcWyAa0I0
	 vTRDcdGL3mmLz9DySwGFNip3k5UE9wff91Is4LVhTxu5KY4UM6p8MLrYN9IaZK/EGD
	 +LN5tUobyTfKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] libceph: add doutc and *_client debug macros support
Date: Sat,  8 Aug 2026 07:12:37 -0400
Message-ID: <20260808111240.93994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072911-tipoff-trilogy-a6d0@gregkh>
References: <2026072911-tipoff-trilogy-a6d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 5c5f0d2b5f92c47baf82b9b211e27edd7d195158 ]

This will help print the fsid and client's global_id in debug logs,
and also print the function names.

[ idryomov: %lld -> %llu, leading space for doutc(), don't include
  __func__ in pr_*() variants ]

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 50958bb928ba ("ceph: fix hanging __ceph_get_caps() with stale mds_wanted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ceph/ceph_debug.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index d5a5da838cafa..11a92a946016e 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -19,12 +19,25 @@
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
+#  define doutc(client, fmt, ...)					\
+	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,			\
+		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
+		 kbasename(__FILE__), __LINE__,				\
+		 &client->fsid, client->monc.auth->global_id,		\
+		 ##__VA_ARGS__)
 # else
 /* faux printk call just to see any compiler warnings. */
 #  define dout(fmt, ...)	do {				\
 		if (0)						\
 			printk(KERN_DEBUG fmt, ##__VA_ARGS__);	\
 	} while (0)
+#  define doutc(client, fmt, ...)	do {			\
+		if (0)						\
+			printk(KERN_DEBUG "[%pU %llu] " fmt,	\
+			&client->fsid,				\
+			client->monc.auth->global_id,		\
+			##__VA_ARGS__);				\
+		} while (0)
 # endif
 
 #else
@@ -33,7 +46,32 @@
  * or, just wrap pr_debug
  */
 # define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
+# define doutc(client, fmt, ...)					\
+	pr_debug(" [%pU %llu] %s: " fmt, &client->fsid,			\
+		 client->monc.auth->global_id, __func__, ##__VA_ARGS__)
 
 #endif
 
+#define pr_notice_client(client, fmt, ...)				\
+	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
+		  client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_info_client(client, fmt, ...)				\
+	pr_info("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_client(client, fmt, ...)				\
+	pr_warn("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_once_client(client, fmt, ...)				\
+	pr_warn_once("[%pU %llu]: " fmt, &client->fsid,			\
+		     client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_client(client, fmt, ...)					\
+	pr_err("[%pU %llu]: " fmt, &client->fsid,			\
+	       client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_ratelimited_client(client, fmt, ...)			\
+	pr_warn_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			    client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_ratelimited_client(client, fmt, ...)			\
+	pr_err_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			   client->monc.auth->global_id, ##__VA_ARGS__)
+
 #endif
-- 
2.53.0

