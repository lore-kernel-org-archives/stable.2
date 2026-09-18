Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD683FCB3A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724634; cv=none; b=HhDjvc2p5xq1gbEz5+6V44gy3CfkdfvwLXjfvW0V0yg86pfrVu8cSkZJX+dcWhk4Xd1VC9N380VuDXYZw4VrK4VzbMLEj7ti160r0hM/SNCrB6z5a3IfCkAXub0I4sZF7oM1xt3UYBbrX88z9/CG00MJKfV2muMsjSy7eS9W9cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724634; c=relaxed/simple;
	bh=s9zWQnwHnFjpb0+5LmKM+DkIMX4D3BjEPUIaaNXu8W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy8LMgHIfC6WDN9EglkxH1IJSDIMhsfUf7CWj5hhB/6X/c/8aq3iG6VTPvnFJ9psm4j189n/U6ovjv/DnuapTeuGdyG2TTgyADz/ZUy19wWh8IBcpB+yc/QH2IUxsY/Hh5f3d/GRECv7h0C7wIPuIolezJdkB8qXefhviHHBI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPZIvbFG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPZIvbFG"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-868b2e5be4eso280948b3a.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789724632; x=1790329432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9eX6V1EBWdnRQJdTioqe1+wqEm5ZtsQzbhT+yssTo9o=;
        b=SPZIvbFG+m7FX/HJcFGioQ+RpaXdql6i4JHWeTsghZ6yz4FTES6JlyI3mgErKS6pV7
         BK2pmLqBHDwr/OV698XJ/wTQacQ9IhNPMEzhR5l48vbOLmThLzZJGOCmaSfBpt0kUSUA
         PQTf/fEX5j3YUw7WgjyGs7tia3xSThDWTw+LyvutclOAkJKXGNx6dM2b5EfbFOj+cFG5
         jgBVGTb27lDvu47ShOaxeLZl9EaipEY2hVfyoC7uLc7JcHK5IgH7QVmo38tNcerMOsON
         WwirM2sn0dZ6r6T3YC9ZSPWOmWZXE0H+RY5XzMbJKEZfrBtesRWp6E7Nw8jZ7t/0EpMj
         L02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789724632; x=1790329432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9eX6V1EBWdnRQJdTioqe1+wqEm5ZtsQzbhT+yssTo9o=;
        b=CH3jO5wNKbd+CiKcCXdSw41EKujO+a+rt9iepB2FNThpL4ETeGIgf+fdfknrCfmvDU
         fzXgT0QobC7kVfpltShiGzEBgiNz51i1+dcsEpM4pxdZooddkdqH2gCD4HixJSJ2/Ysu
         t5PsxVhseAYqWydQyw3s1kiSJuIBVqJ7QHNcI5HK6FW00yFJsHFI0SyT8Tqu2QuViHDC
         GUKwotIVFVTZ3HJP4e78ArD3CG3gbztKAtRBJLxXZpAVSnueQCQQL/h4VqI9xCbQPFwy
         2RCVx36ZMbCDodwpNsddBNufU/GTdwVtzyIOMa0Ud482BEpmHiYG/U75YtkR9b/l/aIV
         eTTA==
X-Forwarded-Encrypted: i=1; AKwUvBxW+9JQnCKODy4EFxkgx4gv8dWFLkRmXWx/ix0/6d+jheVKryDWpExyf1JBZOUeEMJMT9xoy7g=@vger.kernel.org
X-Gm-Message-State: AFuF++mfvZeJfvggcXhWJRUOhqr1qM6YGgXf7Myd0f+93VIvlnQo5zkk
	5TE6cBMwpxXEHlC9ZSq7MzUk83V71wO/Mr1QVkr3DEx0N2Iqbzy1ESol
X-Gm-Gg: AYBFou0djSoLnMkSCPd6LDrKGy0Otfbkz8/4UBntvXJRsIZHiko8kjme4cQeCYyHNMo
	P5BsYzmXYDew9LKQUcZPjLdvjs4cCbxk8m2PbaXeImipvuN12CqmyD3bJFUlWZkVXDYTecWQv0S
	qeK4DrBmeN3F+FzkEyAzL17nRsWNYf5p3QRUT9nUz08hnuM5tnxGz9/XwY1JH3iW9nlQojDy7oI
	s4u+2wEeDzFa3tCBPEjtX23cKc8VzhoTwVAQb04B6vBywtgE1ko2z+TrH/zlSOCXjZ4mNLaljyj
	ZscUZXj3FE6u65AXdcTfd1cABibGqlb2XkvJIezRe51re2p/S3YvqEEi3OIa3aBSYtzsZ6S6DIT
	2DzPPl97Pnlo2eqzUTYYGwc8cHRlG76BHCWHULcyoOUqxlKQJgMewOnYNGoYNVe9RcXU8BhXkVd
	5+Gh8gC2xNRbcaF+W1uM/uYGfmYNd+eDUpM7fOnrJZSva6/13o2CEtrtYpRNpOEvINilIesC9+
X-Received: by 2002:a05:6a20:3d82:b0:3d4:52bd:b89d with SMTP id adf61e73a8af0-3dd8c49e9d2mr4210526637.23.1789724632225;
        Fri, 18 Sep 2026 02:43:52 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50cb301sm647477a12.25.2026.09.18.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:43:51 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: gregkh@linuxfoundation.org
Cc: adarshdas950@gmail.com,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	stable@vger.kernel.org,
	syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com
Subject: [PATCH v4] kobject: fix uevent socket use-after-free on net namespace delete
Date: Fri, 18 Sep 2026 15:13:36 +0530
Message-ID: <20260918094336.6096-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026091807-coma-unraveled-a65f@gregkh>
References: <2026091807-coma-unraveled-a65f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a network namespace is deleted, we free its uevent socket. But
sometimes a device in that namespace is still being removed and tries to
send a uevent through that socket. The socket is already freed, so KASAN
reports a use-after-free.

Take a lock around both the send path and the free path, and clear the
pointer before freeing so nobody uses it after free.

Reported-and-tested-by: syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com
Tested-by: Adarsh Das <adarshdas950@gmail.com>
Assisted-by: LLM
Link: https://lore.kernel.org/all/20260917144206.85836-1-adarshdas950@gmail.com/
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
v4:
  - Use scoped_guard(mutex) instead of block in uevent_net_exit
v3:
  - Use guard(mutex) per review
v2:
  - Add Assisted-by and Tested-by tags per review

 lib/kobject_uevent.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..14e2e15d4ea7 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -13,6 +13,7 @@
  *	Greg Kroah-Hartman	<greg@kroah.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/kobject.h>
@@ -411,9 +412,14 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 						    devpath);
 	else {
 		const struct net *net = container_of(ns, struct net, ns);
-
-		ret = uevent_net_broadcast_tagged(net->uevent_sock->sk, env,
-						  action_string, devpath);
+		struct uevent_sock *ue_sk;
+
+		guard(mutex)(&uevent_sock_mutex);
+		ue_sk = net->uevent_sock;
+		if (ue_sk && ue_sk->sk)
+			ret = uevent_net_broadcast_tagged(ue_sk->sk, env,
+							  action_string,
+							  devpath);
 	}
 #endif
 
@@ -804,14 +810,18 @@ static int uevent_net_init(struct net *net)
 
 static void uevent_net_exit(struct net *net)
 {
-	struct uevent_sock *ue_sk = net->uevent_sock;
+	struct uevent_sock *ue_sk;
 
-	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
-		mutex_lock(&uevent_sock_mutex);
-		list_del(&ue_sk->list);
-		mutex_unlock(&uevent_sock_mutex);
+	scoped_guard(mutex, &uevent_sock_mutex) {
+		ue_sk = net->uevent_sock;
+		net->uevent_sock = NULL;
+		if (ue_sk && sock_net(ue_sk->sk)->user_ns == &init_user_ns)
+			list_del(&ue_sk->list);
 	}
 
+	if (!ue_sk)
+		return;
+
 	netlink_kernel_release(ue_sk->sk);
 	kfree(ue_sk);
 }
-- 
2.55.0

