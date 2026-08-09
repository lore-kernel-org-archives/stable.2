Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8033C1D6E
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268581; cv=none; b=KIO55gUDDe+HSMXQgin60Wa+L1fKcKaeHhAS59xF0VCsJbRXjOGceYVE+psgj6xSssdBEw3eslKXDNyxf5egJEsW0pa1AOnjnie4BY1kq3vC2BFjXG5VUAvqODHohcOxZGNEU341pdYaUk/N5HngMhHr0IpXRlHMGN7p2cJOLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268581; c=relaxed/simple;
	bh=YFtlLngdvCDKxznwW0KFwwqo5LsMIr5V1JdUsdpWzWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fl4H4HX3rHLboflv79KY6KknMDk+Pt1L/ZDpIt3UOqJiSgvQ78dFwGCAzMFPoM+tOY2VDAv6qUG/z2xMuRx6KnEkJpvuBJvEK65BUndQntn3CKSxWA1BFGn6/2RbogmhMJdJDiJXgvApVPY1vJsZ/OKWpI1XC56CmZNPQAjO2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb18o9tR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb18o9tR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so14118695ad.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268579; x=1786873379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5vhVP2gwsOdEitAqeBQ2V+u61oT/f5wQ296ftm0EiMs=;
        b=pb18o9tRybnkrPGAam/bPg6Z/2VTapgxIxyPUN+VKxNzFvlAAmzp0RtYNwFqajuL+b
         AMJ3cI1ruaWkw5gYMYJGMLGeGG38EBbNMnHQvMe0wnjrBRhlTOVPTbtzVAs2PQh70lR1
         s7DoXqbGannCnObLjsS9b/JySF0kkEjWrFIl+pGA+f0McenqTquGWs6PRWFchvP1xm1K
         jTYPKjYEWCcoGJy5UxmWfAqsIjvq8LJZtngQIPncTAp3s5OMaSIQLU1/zZ8DO23YtJ1o
         n2gv0G58YHUNwmW3VRZTlWo99kjSVsgJhg2RO+D9W1HljiReYU5jR7FdckpdrQbABaF/
         JyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268579; x=1786873379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5vhVP2gwsOdEitAqeBQ2V+u61oT/f5wQ296ftm0EiMs=;
        b=X66PejcEu4KiLTPaiW2+iL4e3IDtJTuppXGbpE86XfdrZ6yX+ZOK0xd1pGeycXBaJi
         62dIbocI+SYn+vambL4SymSp8We/KCqnO8ctdrtUv+R1Bc+1tGcIvLQYAggK4wU7mTHv
         DNnbY1OTrn/OmcgQS2QY5MJkgLB51RPBwQIstD7kgm6WXVK+pxQI0xfkvJ41+fiSOOLT
         AE8QP3a2MS/vxzOOVhr09543U5I4cCdjkAX6ZIykidM8jv0cjrRL8eWgny/sw/PBSlxZ
         4jj719rimysk0MkPKWk1GVWmCOaeiVDryfjtG5owtBPg09v18LjzCHn6F+ajr0rGSRKg
         NZzA==
X-Forwarded-Encrypted: i=1; AHgh+RrDiHIru35rXQg2tOUrfiua1ygOLiH+EpEjVR4YD5UXmfbOa6IeLcFNcXd8qq3HHb/gDzwNCBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37eAkxz7+rqqH9FYKlyQLqje1s3cXCVzFLTsjaaU6UixOI2eO
	u/UhS07Mo2mE1fgrNoM2m8vXwkr384NHkDRDHumJfL6zT71SJHTWtqqO
X-Gm-Gg: AR+sD12QchRxYdNTPeujEnRdK7YE1aNFtHLzMPRgv/3CFzBq+WCfRd4zV3BWDSZEJva
	GHH9p65PcUhO0KWsJmR7W+M7WbJSweq0QUItImMf/vh0QQTnOK1Qc0oBe5OWgKPJVlIEbuHclOP
	JEuFElL5zg4aamCORjzpA+yPJGT5tSgWHGZyh5Onfi34xA+eTSVbf6Gy+6jTAsCGWsAK9wNQFl9
	D8oVdLSfJJ94hy065WjXD4OjkAOgizQlPwX0NQGFUYCtZVSt4x4Q1cw+uqHPS4gKYEfOh7Ru7oP
	gU/lMSyBUz+pIqA3687AJBoU1ciVsQTFSWGTrYl6G5YXDNlEk7hUe9OrZVEyCGRumm/caa+u7Gt
	mPtgevErJy+NQagPRaNUQiZOAYkJEaA2AF+LJu5xqHE77s8VkATvaNBzXqV6nlJ8+eA9ul7/GvE
	UDYPlSPuDuJBol0jLtz52FIV3FDDW9qQMGTomjX9afQVn5YC2YsrZ1pZQOeHF0ATRXWqoUvxRiT
	YmmNqj/9kh9dg==
X-Received: by 2002:a05:6a21:6f17:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cbc0175426mr21235402637.9.1786268578350;
        Sun, 09 Aug 2026 02:42:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d60f4sm29364303eec.13.2026.08.09.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:42:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] l2tp: send netlink notifications in the tunnel's net namespace
Date: Sun,  9 Aug 2026 17:42:52 +0800
Message-Id: <20260809094252.2107242-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_tunnel_notify() and l2tp_session_notify() use
genlmsg_multicast_allns(), which delivers to listeners in every network
namespace. l2tp is per-namespace, and a tunnel records the namespace it
belongs to in tunnel->l2tp_net. Each event concerns one namespace, yet
every namespace is told about it. A tunnel event carries the tunnel and
peer tunnel ids, plus the socket's addresses with both ports for a UDP
tunnel. A session event carries the session and peer session ids, the
interface name, plus the L2TP cookies where those are set. A listener
needs no privilege for any of this, because l2tp_multicast_group[]
carries no flags and genl_bind() asks for no capability.

The fix is to send to the tunnel's namespace with
genlmsg_multicast_netns(). Commit 134e63756d5f ("genetlink: make netns
aware") added both helpers and drew the line between them. The netns
variant is for an object that lives in a namespace.

I found this by auditing the tree's six genlmsg_multicast_allns() call
sites for objects that live in a network namespace. Only the two l2tp
ones do.

I reproduced it on net at dd057113ac7b, in a virtual machine, with no
real hardware involved. A process in the initial namespace, running as
an ordinary user with an empty capability set, receives the create and
delete events of a tunnel. The tunnel was set up inside an unprivileged
user and network namespace. tools/testing/selftests/net/l2tp.sh passes
before and after.

On a container host, any local user and every other tenant can read a
tenant's tunnel parameters.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/l2tp/l2tp_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c14aab..c0c4d1ebc7a3e 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -116,7 +116,8 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0);
+		ret = genlmsg_multicast_netns(family, tunnel->l2tp_net, msg,
+					      0, 0, GFP_KERNEL);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -144,7 +145,9 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0);
+		ret = genlmsg_multicast_netns(family,
+					      session->tunnel->l2tp_net, msg,
+					      0, 0, GFP_KERNEL);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
