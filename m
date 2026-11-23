Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450011;
	b=OaEM3LWPt7lAq0vQ/RQVAd0urNSbTWDOohz+V/hNzisKI8ldGhjNpYQjFjfNpr38Lvmt
	 o8uOtpaoy9x6iv1Ryvbk6gQkDeMPBCAFuA23VPEeadmuc+soM/PbndknsnFaCfK8PKFlq
	 29wIGou9PgibS7/VDtCyW5Ig9dvZtWWKGnD6lSrX70TJvTsG3veHnTlUtlew7kwy71e7S
	 JBIlWr6J/GfxYOiS6ZVHELOEaDblahoZ0smETlookikNkn6JV+N4X1CdzRmYYZOZB/yPN
	 DsIq9B3GowgDllsxl1B9AdZO23JEZJwgqdeweWReLehuXXmGCMutgTNNfSNZT5z/e7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GzTD9WH9/UERM7DubWsp4AE37bmITVN0W6tIx9FHUTE=;
	b=0l5uOYEatiyqsLyoHcrTw8DEYZ21UvRUgtnYatZuyps3cEltmSZUYAZEPRiZtvWoF2pY
	 8si0zdikAv1UFPUe4Wd4kv+ADAp0Jh8ne6ipLrmnXATmsUjLlKdL05dTVzVcfkRCwnvxU
	 SAqJ009NFghJpY9zxct87JNbkt2IHTJo19VC4oJ9Bfy4TgNnaKDDU+2ecmbU1/TNYGh5d
	 SN1YqdVQ539lr6BFJ28zxvNh/H71NWstreu92An2/rLGTob6e8G75kkVdRsy/vwxhv0Gy
	 pEIECGaTJ733GsU9lNeY+hKgNRqd5bOCH2rZKx9BPEv0EGl81iFwyx99+bs+6hopoYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gu/9OOJc";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E7606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gu/9OOJc
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so2174893f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795450010; x=1796054810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzTD9WH9/UERM7DubWsp4AE37bmITVN0W6tIx9FHUTE=;
        b=gu/9OOJchsNnRNlV3NFQ8M+VWDynXxt0MDE3ACvNV105QrCtPT1CbLfssYATpGWWlW
         5of0Ha43hC51xyJsCv5Fq11olSn1zuYmUOK3gua5Q3yA7mahJOFLZl9NePUp/vH2Y3Xd
         CO62CDZY1HinDeGPm4B303xP0f1QOxIQDfuz41SqPfvcPx6zcds4m/7XvhSKXf/aQZkV
         3XHsKyjLGoU4IL+VX5z5GDdvtkL/ckhSK1CagEetXUYtQVvFOXYlDT1+g/OA1fzTADRi
         hIwhh5GqRjIfWqPKwjJ6HFM5+yLT52IpqwNzoa6TuYeXVguo+ROdv8N1YANli8E/Ucdj
         QE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450010; x=1796054810;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GzTD9WH9/UERM7DubWsp4AE37bmITVN0W6tIx9FHUTE=;
        b=iLiXNvNSf95M6PPi9tytjSyCzmEseLbvxiXCiQh7rkuQ0MPauy+0dIpWx72A+Rb23p
         eWJ/hBPqdxemFSKMl0eRHPOycbeMNpr6FxCw4L+daEBlaVQuSSvG4es9huCzjpsgYOsr
         lfU3rvZIbKgVx3PTjBaNtgMK2anVneVVZFQPIKwb7ryMQore70ZNRIIFx6YW1gZuDTIA
         NACeuBrndkM4sFHTFOs53PHdrd9OugXQE2zh+He3x9wkDLKoFFef4vFqg13kJg/H71KA
         kGYLNuw4auwSLiDgx+87JxWc2H7/IccRsCDGlY1+W9Vb3Yrra1vpQtr4lhN3ley8QnES
         +o4A==
X-Forwarded-Encrypted: i=1; AL+hErEv7uknDelprvFJyOn2hUMyCTuo522PSAXlUbKh8G0AF06GMbC7tdpfKpMOCdNiwY9CKFCZiks=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YK+Qv+GWc16o5bsppZdkrWmwKdoC9mMptcqm5ASHogc6WzMO0
	swQhsaXgCjE/x/8V4kIjg/kukrdMouv9peARf2MFVhCR8VocjcedvplQ5iT59Z126nw=
X-Gm-Gg: AZFdTZdFbPndLISKiyma1mIhFWaEfV/33zLKdtSL0hmnfF583HWvYnlZ5BsjJ0BSbGs
	O/7Jlwqb5PAbypmQjSA3Ql02n1NffnvoMMxQ12snR1pW+dUC11XyN2OxXEyoth1kNJYYeSOXnVE
	S9jsztTwJ+pJjwIzocVUJ0K/nOHOmwMTt3dZ9rRcKb1n5W7d92qaIX3qVrBI6tWjLjhEMFumT61
	aPanmJA8c6oDGXe+Uv7MJL2bBmv4Ym0w1qVioVw8LhAZS5ixWbYAjPQ5JSirif5b4CJJUc6zbBh
	3ViyQnwPadQQu4GC5fnkxKrWd5isAJ8g4DQtiTcuqBLERe82J3Hfi8j+j7jEjqXbP1TvQDr77mD
	mhs6tg8PsuWq3yfdYzRh28pqwIyaL2NJNcyhTrj4W3cCjBaZhYiaHoWVDyDluRSBsAbcrsA2yg4
	6Kwgt8tuAUuDTh6dp+iQ2ZozhtSWQh6Kdq2W4qCxyeq0gQ6JwNTIe8/67UsyZRFmDovjFHGHxAf
	V8ox7roev6ta3LY4JpSR5pypQ7Z5nJeAPiOpAahurFhjZ8suUQ5Hl59ZH6gfMb7pntBbvDRgEih
	HvrYMalrYUgy2b7RjKjSdmllTw==
X-Received: by 2002:a05:6000:2c05:b0:4a7:ed95:7c9f with SMTP id ffacd0b85a97d-4abb19c16a4mr23817893f8f.22.1795450009406;
        Mon, 23 Nov 2026 08:06:49 -0800 (PST)
Received: from metepc ([46.197.185.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb42absm24580960f8f.1.2026.11.23.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:06:48 -0800 (PST)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: akpm@linux-foundation.org,
	edumazet@google.com,
	brauner@kernel.org,
	stable@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH v3] kobject: fix use-after-free in tagged uevent broadcast
Date: Mon, 23 Nov 2026 19:03:16 +0300
Message-ID: <20261123160615.1074229-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

kobject_uevent_net_broadcast() accesses net->uevent_sock->sk without
protection in the tagged (namespace-aware) path. During network namespace
teardown, uevent_net_exit() frees the uevent_sock while a concurrent
kobject_uevent_env() call can still reference it, causing a
use-after-free.

Extend uevent_sock_mutex to cover the tagged broadcast path and the
netlink receive path, serializing them with teardown: in
uevent_net_exit(), set net->uevent_sock to NULL under the mutex before
releasing the socket. In the tagged broadcast path and in
uevent_net_rcv_skb(), check for NULL under the same mutex before
accessing the socket.

Closes: https://syzkaller.appspot.com/bug?extid=7db35adbc02c5b86d4e0
Fixes: 5c0941c55e5f ("kobject: reduce uevent_sock_mutex scope")
Cc: stable@vger.kernel.org
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v3: Switch from explicit mutex_lock/unlock to guard(mutex) and
    scoped_guard(mutex, ...)

 lib/kobject_uevent.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..768540433c7f 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/cleanup.h>
 #include <linux/string.h>
 #include <linux/kobject.h>
 #include <linux/export.h>
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
+		if (ue_sk)
+			ret = uevent_net_broadcast_tagged(ue_sk->sk, env,
+							     action_string,
+							     devpath);
 	}
 #endif
 
@@ -743,6 +749,7 @@ static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
 static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
 			      struct netlink_ext_ack *extack)
 {
+	struct uevent_sock *ue_sk;
 	struct net *net;
 	int ret;
 
@@ -760,7 +767,12 @@ static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EPERM;
 	}
 
-	ret = uevent_net_broadcast(net->uevent_sock->sk, skb, extack);
+	guard(mutex)(&uevent_sock_mutex);
+	ue_sk = net->uevent_sock;
+	if (ue_sk)
+		ret = uevent_net_broadcast(ue_sk->sk, skb, extack);
+	else
+		ret = -ENODEV;
 
 	return ret;
 }
@@ -794,9 +806,8 @@ static int uevent_net_init(struct net *net)
 
 	/* Restrict uevents to initial user namespace. */
 	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
-		mutex_lock(&uevent_sock_mutex);
+		guard(mutex)(&uevent_sock_mutex);
 		list_add_tail(&ue_sk->list, &uevent_sock_list);
-		mutex_unlock(&uevent_sock_mutex);
 	}
 
 	return 0;
@@ -804,12 +815,13 @@ static int uevent_net_init(struct net *net)
 
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
+		if (sock_net(ue_sk->sk)->user_ns == &init_user_ns)
+			list_del(&ue_sk->list);
 	}
 
 	netlink_kernel_release(ue_sk->sk);
-- 
2.56.0

