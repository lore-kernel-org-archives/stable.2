Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FA38DC70
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711748; cv=none; b=C/Vi2Wg2Cbpq/LojZYL8Jc9NUcLdazXnF+8JX3Grqen9xAFyAsvRFHxhn2oYkeeVC4UAySPKCUEQbPU+oupWCw3M4aCsIUkkWqr3dWzLfn1b5Jy2pW4q5lpztFDN3cBX64B4vgGGE5L0/y9WYu2rr70tKX60anJEHFnwM+UGjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711748; c=relaxed/simple;
	bh=9MMcQqbCyatW417RSOpUlF7r32cLepJryAxtTXy4U5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdpZ2eM5jAwJ8bK6+h1mNOdAKdZlFdZmvdUCqtBh6N2P3TOiGRc+TGxmn4UT73d28Lg5cMcPWBY/8xSa9Zzgsx69fYvJLkg/ZijEtSb1+lJH9Yrg/B8j4wVUvH51rP4uxXBOTMDznjwCOMcInmsCCPI8BEj6Butnfo2Rs/2E+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNsVGr6i; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNsVGr6i"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso162291a12.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789711746; x=1790316546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ORxTFOuB2ucPeCFRcbiCodxruveHPk2zly7F4fcoL7c=;
        b=hNsVGr6iJ211g6Yz3v/3Zd7/ujiIO8X2ip21ScNXz4JddZbrde7ZAQZvYPCEPBqFdr
         AiDDbQ8XmLwFhLsncw+VdihGHcaDVNFKZJcTKHCX28zkzbPZFja5f7OuhE7Mx2fUOAvF
         PyX1OhbmHAZ+t5O6T6XLmotE0vOMPYuESg43+IrIGQek8UlF5ODfX3NVYNUhovU0AtM+
         mvBPCcXVdCDLS3doBHU2rGBkE3IhJ8vzQhjX7HFJoWNf20G/hRLueRfiLSr313o+h1uQ
         uLbZLW9vDYVeb+NHlZqR4FqoR2xkXg/3MUIYtq/A4qf/WS5LUDqx4VeFQbedOCT72gkl
         vqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789711746; x=1790316546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ORxTFOuB2ucPeCFRcbiCodxruveHPk2zly7F4fcoL7c=;
        b=gymaaNfHnb9HxnywPLP2gHdPNqle3ckFQY5GGJ804l84zymEGCbBpJ2VRp38WdZOF2
         CVZSRegpxFaRixMsI3NHsx3qcKzI0fL8Sp4u0SVJNUP7j/fQQAb4FfbMgV7Gfs2oCS7P
         IW0Rj1iZM3jz7HD676i8b4l4qK4kuHVBB/1cG8GLqxcgusy6fJI9iMrhll+x0PKNUo/8
         JuF+94SZsuT/4LrrA95xtTM+WRZXAB8hCxfwL30VxXsrgeLl9Krnwezowf+7YYmb5dA0
         cWLT8wvQNlwwkQ9IHuIy5+U1IIE32Ghi7mRbyxw4Iaw87puv2XnYw69KGNipUAhFW4F0
         xNLw==
X-Forwarded-Encrypted: i=1; AKwUvByjcuez3rSJZ9MoJUklNt6hHaZMlMY30Nnp6F3wxAVdH3JAzlZbKAOIkwfo3Dd5UgVoF/KsMv0=@vger.kernel.org
X-Gm-Message-State: AFuF++lFiKJJsYefxuGJSy5pcY6ODWgHXAcQTBbvsqUGoPPaxiKFCLUQ
	e8ybGrN08n2LyIi2tJAZCRKtq8rp3gMjsYEGlTw4FwGR5RCfSV/Zhlkp
X-Gm-Gg: AYBFou2JgvMdJ4p8WYsyS/9vuGsfa4JQR7ezVjqBtl8z6N4uKTWkUCfZXMbzEncDMAu
	fXTKdVHlc2d3D9oHsHGcnByLIsDEhPVEXR/wFXWCQ03LflHU0GTB/mbX/ZpYqpW+oB8plSl4tBt
	k3TIrWGrAioXziZ70JqnARb4LCr0aeV8SH2/zpxym257j8GBxcly2gagYv+6oO/b9Xywto2QdeO
	yMdSHezQv/jzbGeTvoB93MYHZ8AAQ0Q8NY/eboZMLT0fLhOg/v61unHmy/l/wkg8fWJBYbbhwNv
	hs/+eg05TnpR/2c4g3t2Tp8T+z/+lcZkBHQ+L00fJXb8IaYgh9qnnNX/aUXjsG2U/ZLfYxZmC8n
	9/d91ifRN4/Alq9TmRKIEb1VITQe50x/76K0G6HqJL/5QlETw6XLGEmPe9CFhHGDFJDLnkJ6lQM
	qKWExz//W9ceFcWX5g2UqV6nAREABKY0kmINtX4jfewz+LrA1qzdMvoQApUYo8AJkTdzS2EyQo
X-Received: by 2002:a17:90b:4d8b:b0:39b:92bb:9ef0 with SMTP id 98e67ed59e1d1-39e54e7899dmr3123205a91.20.1789711746550;
        Thu, 17 Sep 2026 23:09:06 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm7695043a91.14.2026.09.17.23.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 23:09:06 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH v3] kobject: fix uevent socket use-after-free on net namespace delete
Date: Fri, 18 Sep 2026 11:38:26 +0530
Message-ID: <20260918060826.8434-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026091732-armored-lilac-fec9@gregkh>
References: <2026091732-armored-lilac-fec9@gregkh>
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

This patch attempts the fix of taking a lock around both the send path
and the free path, and clear the pointer before freeing so nobody uses
it after free.

Reported-by: syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=4393dfdddf166f2de2b0
Tested-by: syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
Tested-by: Adarsh Das <adarshdas950@gmail.com>
Assisted-by: LLM
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 lib/kobject_uevent.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..cb674c2c3432 100644
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
 
@@ -804,14 +810,19 @@ static int uevent_net_init(struct net *net)
 
 static void uevent_net_exit(struct net *net)
 {
-	struct uevent_sock *ue_sk = net->uevent_sock;
+	struct uevent_sock *ue_sk;
 
-	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
-		mutex_lock(&uevent_sock_mutex);
-		list_del(&ue_sk->list);
-		mutex_unlock(&uevent_sock_mutex);
+	{
+		guard(mutex)(&uevent_sock_mutex);
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

