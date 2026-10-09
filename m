Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E437267C
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537838; cv=none; b=q9DXlfY6v3FQj1BFxiAybepoxqaU1v3GKpp0xq3emXWVkrKV+qHzPI2Qp9DIvHU/B9yxtfPx/PTW7dw+3ionOjSnEIWFkOpWr2SoPvVvCWnU5bPVep9/LhXjM6UAzAHgnG1IaaAVp0upsAyDxqburDqaiLgefT71TcAfZt6i1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537838; c=relaxed/simple;
	bh=spHWg758MMa6cVLRm5D/eai/nTQN8STeDzA3Yqqr8xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ntpm1QnGjr8Vgg6BEFxxe3dJKRbfo8cq5P/6qzDmAhKYhEWIBZIxvKax1l+6FvazDMDkHm4WNl5aH7iXyX/anrUJllfmo5MyLcG9QSOYRmoRhMdVOLVS2UrWFuKBiXWYVCWhEYunWd8isJDhBkVdmQ1Heyskrbx+5CRTGkKbUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fel5Up0m; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fel5Up0m"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-824040a3379so2472889a34.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791537836; x=1792142636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WNJzvugKvA82beZN1tuIwkN3WC4xZ3L9Ut+DKu7+48=;
        b=fel5Up0mw3itnc8xKzRPSDWgFy7hzIVlyVVg36d514Ix/+f2zi/E3u0t1pXNZ40DEH
         GoW/GYNmwK3GMMi/ahG+ScaZ18awQGQgNJqPuX6qa4+JlzPxBhfTBo/50KlFD1pYxr4h
         dcFd7gVbKi4dwoi8s/Osmxof48+lhbsMLPZjOV3YO7hVh3G7v5qGdU336m2p71Wco36h
         FD/vmWudY/zmh6yAAwaRAj7afrKsIrIlYGhN57KR7fER6MiPjMsd5ThbYkkAdWtAfHCy
         kXwhbnd3FjjzQVzkb+dc1Zzn5X4ou9vJYr7oR7a4MvnqFxMV2g71EwkC+gUlXPLRpAUU
         GcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537836; x=1792142636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WNJzvugKvA82beZN1tuIwkN3WC4xZ3L9Ut+DKu7+48=;
        b=TvBfiuHccBbqee88JW/jK3dpAwk6Y+7Rwl5jz97qr3a61j/d4RT0taODAJGOgTUAfi
         GSjd9n4XEH51xgOHkPwjk9EMyblJ7TWP54ikLoNWcXjf03Y6Gu0258GUajmqCBb7AwO3
         TMdnbN+DsXWg9IA/533/ZTLkTDALpA67Ts63lNaQh9zLt/f2vIp71du9eo6yLvWmAYmN
         8jz7DRa0jDDtXlFcu/lqpm1+vxDgnKA4l2Rr2woaJ5eVD1rJofFsfF/OtseaQay+5LUt
         izHpQLqu+/zt7eq7j/lJVUTM2m/qV/BTsfk/Q8By/t+IM02Ssx6iC1PNOjluzGoK/Fw2
         vGEQ==
X-Forwarded-Encrypted: i=1; AKwUvByVBvRkyxZEPjfs/zKmK/8Z+dcMIKYe/IDaVM42fb3LMGpNXL6OA1ASlvf/L9vXbZAS5pBs3uc=@vger.kernel.org
X-Gm-Message-State: AFuF++kQEJg/TnOv7Eiw0/ud1lgIEQya275LMgeuL5fMnkh3MJBjqihD
	iN8vdJFW8JKBA9JwXE23qf/zd/yfZgCN/F8gujQEbK3j4qklXGT/vkcy
X-Gm-Gg: AYBFou1ezegJDMQgyvR/k+rSaVTXN4RmJLSz0G3bhE/OA76jnwhoi7btHYB4vOlBson
	CAcfsnEY2lPQ3z4GveOupt6i6JFJi+v2MdG5QBmpsrVsNaJJzCWFutoszYfGw8ii1hjiF9an1uI
	TFP7U4jYtWTLVbGym+eeNuXMQUgRzbtY5WXsIMHrnnwb92+kCNxbcMdrgbFluu0ulXFFxHHLGFw
	wy4PqJUhAi3qZXzJtesuT/6qDmD/+9pJIAQ8z+9l2BjdH0V+bbaLP7FgH6kXeIdR9ygklD0HZi1
	mHkL5JLA5YmMKC/FEJ6vU4XS2+N0EIEyRjKpdEHVWUtGPrs/z5Xweluo9gl/Np+C0OAnK4M2ggA
	nhphFqmngp6PsGYV9QOxUhAbQTx2BILqSCWzB7Z6H1vPsGMzpDYaje0bwDGALnkjQtYiIAkEYO1
	IQbxTsO6gPUyJL+YzzAx5PuQ8OMen3MoU9ScrvkOHsS+pFmVNzDAD5r5Gm1ZsZFA4HRtl/N4pkj
	T8t51sxD58RRx3zbF3kPyhUpcEisvvNzaUd
X-Received: by 2002:a05:6830:4c16:b0:7f4:eaa0:1d14 with SMTP id 46e09a7af769-8309610ba27mr974839a34.9.1791537835773;
        Fri, 09 Oct 2026 02:23:55 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076dc3sm1446136a34.14.2026.10.09.02.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:23:53 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfc: llcp: fix socket list self-loop and soft lockup on bound connect
Date: Fri,  9 Oct 2026 17:23:38 +0800
Message-ID: <20261009092338.3146149-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llcp_sock_connect() rejects LLCP_CONNECTED and LLCP_CONNECTING but
not LLCP_BOUND, so a bind() followed by connect() links the same
sk->sk_node into both local->sockets and local->connecting_sockets.
When the peer answers with CC, nfc_llcp_recv_cc() removes the node
from the connecting list and re-adds it to the sockets list, where the
stale bind-time linkage turns the node into a self-loop; every later
sk_for_each() over local->sockets then spins forever (soft lockup) and
the socket refcount leaks.

Reject connect() in LLCP_BOUND state like the CONNECTED/CONNECTING
cases (a bound socket must be closed or unbound before connecting to
another service).  Failing fast is also the only honest option: by the
time the error path could restore the binding, connect() had already
overwritten the bound service name and the unwind destroys the bound
session regardless.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: a69f32af86e3 ("NFC: Socket linked list")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/nfc/llcp_sock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde684..33afd85f931a1 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -714,6 +714,15 @@
 		ret = -EINPROGRESS;
 		goto error;
 	}
+	/* A bound socket is already linked into local->sockets; letting
+	 * it connect() would link the same sk->sk_node into
+	 * local->connecting_sockets too, and the CC handler's re-add turns
+	 * it into a self-loop.  Reject like CONNECTED/CONNECTING.
+	 */
+	if (sk->sk_state == LLCP_BOUND) {
+		ret = -EISCONN;
+		goto error;
+	}

 	dev = nfc_get_device(addr->dev_idx);
 	if (dev == NULL) {
--
2.43.7
