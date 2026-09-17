Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481B5519B8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656166; cv=none; b=bDXnPRYgZ9v9FIgHLiyHV9+x7kVgGp7ciF8JrNeCRH010R4YX8lnCW8/5wTd9CYuxkNF2epsq7xMj9jXPC5a2mxyo+GKKCRwsPOaFYFDokaQ6AJOBNct5OwjecLpH7+fXcK2WruGty/fbpRWXvpIKxcXXE6v2yiZlkNg1UeffBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656166; c=relaxed/simple;
	bh=kw4TipmbKGg8CFX/QSiBbtXEfjEf0OiG5AFkDXCIye0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoKXTCN5VjRCk53yZOTY2XxPvvEvbrA7SiXue+E1Iey2alAwIGhewrW/eMFM4E4BTdmgyUZbA0N3TkgDNOqy9ny+gNyyz1q50hps72kWN7TFn4p4NeRQoryBiSQNVTi1gf4+eexEE//BzH+NystT/jKIYbDnnETCujZCZoLixZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJP29yOK; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJP29yOK"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80a4e050a12so639521a34.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656136; x=1790260936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLiAuQyw2H6SVXJcusiyWm3lbA7Z/rT3zG0bbVq+oY8=;
        b=iJP29yOKsag5ZMS/VtzRGF+y8gZdaGMk1pcIv3lM2jLydpxBZ1BdHKr7z081KyMhMW
         HVgVPkeY21v0SYJPofM/LNMgYvbHbgcYl5c4UGJ6la90AiW4vB38gwc/av3OucVz2zIR
         vN1NYGhaM/W9amuzKd0kJGTSZORbukRQMfW+K7AMpqTntGZCu+kHJiSc+lhBPI+Vyn0W
         mBHNOC74GbrX4VY3HISngKzWvtMApX9w7GjJdzQyQZXq/z73aoJc2DhY3Aj3zVs724zJ
         +5wFgrk9NbzkeyKeYK+mJTw5h8yXCsIsm49B6ptX6LREOKsGElU5H1kWAGD/RtEuOwi2
         uVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656136; x=1790260936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLiAuQyw2H6SVXJcusiyWm3lbA7Z/rT3zG0bbVq+oY8=;
        b=D/MgLKnAaJbiiz3o1qznfCuLOndUxVnhxYGHGm9dxd3Gjx2gQ1t9KfGQqa3iyjTWYU
         hb8toGkxrqGvAi9Jh8yUHF8GY+b+csFbPHmm6AQYJv8+ASoduMfSao3tR5BV0K/JSt81
         fSNNY3rE/na4Cjhzp1YC804ZQVAwQY2CgWprF7rcmBHxCjlhw5ISYXOk4/ZL8Rsey61A
         iDRR/xZJl/sCwty7z639RJHOobX3TtNy/j3JJixm8D8fHM/L0dYCxWQFnkZc6tG9bRc4
         ibaM0r1ElWMY4yd2Z7O8rjUTEWS/EFdP9YNVgN05UpIs/Jz8oWaAQxt7YXDNr3YKRZqE
         R+sg==
X-Forwarded-Encrypted: i=1; AKwUvBxPV/6JzTud2sC1ObTIExK7CZy+yVpFbkiIBOS+4du3x56oQUpt6jrvZS3xK255oRjyh+8rETc=@vger.kernel.org
X-Gm-Message-State: AFuF++mzggCCeDXwQ2RcTCGu8bkbHlvXXKSatM+H3RhOgxBBUfWvJhMa
	VcRMyE4GMLlfW4bRuksopE4mwdQqVMEkspI+wBlSkJJypS1YvzCyBnl+
X-Gm-Gg: AYBFou2b/QaqnbPDgA7dP0J5SNc9sqhdlls4x14D4q2AG5nihRymU+1eZjhQFbUJS/Y
	XRB/4O/6Wy07ETi+28gx/oBvnnZQvJNcfOv1tBNJmas4lh2fM9a6QlD0bS2od1jtPRKrA/BGtgG
	1Unk9z3mVl56hrwwjYbR4Vv6Qru975qQX7HSn0bxHVlxvZVF9QLBruPYOreZXVlAa0mwjauLt2q
	S3bNEVkFjhByGDnLvjes4A/u9Oamn4EgOlmrDlzpTtlTo8a6lxHRJtWX7/UCjuc86OlHUM/ZE12
	FYtbvJjPBLd4lohcc9fsYWFl407TDFjQHiAna906RoXuh0F7OJfUw3kSeNj7THSlaC1qhPlW6wf
	JWs0O1dt5PSpwYmrSDHPYnmba893eteqEkU/KSZh7Br4xSaJWkeIROvgpl5cboGDRYp1qItst9R
	+j7oiwVAMa/c9Lig+Up4KSmTjUJowNswe/eztimnn891zbvYWvJjR63QlAMGWzQW7+4CNyNzIR
X-Received: by 2002:a05:6830:6b09:b0:7fa:ac4f:77d with SMTP id 46e09a7af769-80b2f9e3449mr6878507a34.28.1789656135911;
        Thu, 17 Sep 2026 07:42:15 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c4619a868sm3092468a34.8.2026.09.17.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:42:15 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>,
	syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
Subject: [PATCH] kobject: fix uevent socket use-after-free on net namespace delete
Date: Thu, 17 Sep 2026 20:12:06 +0530
Message-ID: <20260917144206.85836-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 lib/kobject_uevent.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..ecba33abb6b1 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -411,9 +411,15 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 						    devpath);
 	else {
 		const struct net *net = container_of(ns, struct net, ns);
+		struct uevent_sock *ue_sk;
 
-		ret = uevent_net_broadcast_tagged(net->uevent_sock->sk, env,
-						  action_string, devpath);
+		mutex_lock(&uevent_sock_mutex);
+		ue_sk = net->uevent_sock;
+		if (ue_sk && ue_sk->sk)
+			ret = uevent_net_broadcast_tagged(ue_sk->sk, env,
+							  action_string,
+							  devpath);
+		mutex_unlock(&uevent_sock_mutex);
 	}
 #endif
 
@@ -804,13 +810,17 @@ static int uevent_net_init(struct net *net)
 
 static void uevent_net_exit(struct net *net)
 {
-	struct uevent_sock *ue_sk = net->uevent_sock;
+	struct uevent_sock *ue_sk;
 
-	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
-		mutex_lock(&uevent_sock_mutex);
+	mutex_lock(&uevent_sock_mutex);
+	ue_sk = net->uevent_sock;
+	net->uevent_sock = NULL;
+	if (ue_sk && sock_net(ue_sk->sk)->user_ns == &init_user_ns)
 		list_del(&ue_sk->list);
-		mutex_unlock(&uevent_sock_mutex);
-	}
+	mutex_unlock(&uevent_sock_mutex);
+
+	if (!ue_sk)
+		return;
 
 	netlink_kernel_release(ue_sk->sk);
 	kfree(ue_sk);
-- 
2.55.0

