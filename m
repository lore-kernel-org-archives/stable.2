Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EBA42A791
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992688; cv=none; b=DWUquRW5ZqZOVvhjYNuG9EBopsXITRL4w7qgqKV2uWRfx7lqwzePeEEsLmvHSucIRBjqmetlaeRzfSNg2jLYlmqmvh95+v9n33hI3bo9iusvaEhCuZR3bxK/fszw/+30FEJEUgDrA4sHJ9sCvnizGf4bPo8Qs+1z60l+OsQgVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992688; c=relaxed/simple;
	bh=JE/4MrGBkc1/iw8fWWnoJx79DYlxdndviPXed+c/nrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ip1pP3oqptvxCIvcv/sveiH9RkSDJOhBC+NBzcA67DHy3LXkFrrHaIUMHGAFIbKU7d2EAnC5j263IWfheo9R8SRHDCXiM8pQ1wuVYHoT1F2jkmCN9pR32y1WTE2sm/kuyjmc4sKuEXSJ4l26lWjP5F0tklnnGfGGEX0TjUB745U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKDIP5Iz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKDIP5Iz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b42be8feso17645075ad.2
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782992684; x=1783597484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZhAVIeup1F6va9atDAIUYP9BVzqJtMjdTx7Wa+aOzI=;
        b=jKDIP5IzqcQKfytCyrMoV9gaGAwdHxX2IvwWIwcXM3UPAxMJgUntXZSr5td0Kxr4KO
         hKGkUskwrVUcLcK89FAVtlEdwCOJPmz3gQC+g4MBgRQ58a4KECF8jiwO+nfgURJw+2Ds
         ZDbH2U99uyo1ppppXAhRRmW9UpZnWyc08C+pfrj8WL7Oo5Jep5ooLi2q1G8xDfHAxK+r
         R21qKpegzK3AvZxBzhmNMZ2Iu4Ekka+5gt+s3VHco9yl/SfXuDQ09X0l5L9O0qoS1uDb
         QqSMK4jjyCE1I6JBJrTh764t0ia5jD10TpVOBPPl4m4YoERfhhjnrZ+S5dC27RFtVbu/
         wVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992684; x=1783597484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZhAVIeup1F6va9atDAIUYP9BVzqJtMjdTx7Wa+aOzI=;
        b=kUxYP2OsEbmnaP9rxvQoFwU0ZUHfVf0Mnj8Vn17cg+GztwGCWtijT9fK+bpz+1lTCR
         o9tEZxuMMWF/BDYizPx4hDD9QLsMqgtjqy8KFLNF4HmSdX/FqbFxc5dFDVX8r59p6r+W
         AtP2ZqNNjhoeG1vj9Qqta0McrkUDMyhCkWjymk+MOu9bH8h33OpzFDw92YWedGSfeKXI
         CF4jX+lSbCXKpOj52OcOK0pzHAtnx3QTCtXo98A4pND0pP5xp85HpASHMG4xZnoEDpV7
         iRNuYCHCwBUUsXXHpyYiLPKicIeYMj3ATt8SpzKChlsJsz20bD/IbCvrxERuZQZwZiO9
         Ll5w==
X-Gm-Message-State: AOJu0YxL4XwxWUs/GQXX1qQPZVJrbSoMtOr1jBpKu7oUpOwXJediarTF
	b7OgpB3D1aMxTTZoRJSlYdPOtQsJ3nF13Qlnc1OTB2hmjxzoOuFtRSAvJ3Cigw==
X-Gm-Gg: AfdE7cl1ef6fEJ5c+BhHUgg908lEd4pZJ8W7pqcoWSRHjT6vOZbR9sJ+N05v3dA4x0m
	KCBlfxDFKdKIVch37CsCaUDDfdLGRpiuh8847S0YlBguzKsE8XL5QarZsCkIkqqip71SKZvINCJ
	GDtYOOgKPytATFROLNC2ZOuSV3ySFsHItDfsD/W615hlThXuuv79uxkvs3IEE7FyhmZqSSu30ZQ
	6SlcPAOKaE8qdJCJLOoFgfSPQJKwvOeO0xhfOqFhjX82am7WzSyhOcvXoj3PiO1W38rha3oZ3Xv
	Ijbvv1wAYpY43Zmje+L5qfns2BQFIbcnsEP+hKVqAft/MYmTy0ws9yAIDjxMrf5HGRqfT5RgD+y
	NluRnJU7jBpICzP09AuLmhCZT9tBI5XAzn8/O39+ZRil/b/RESVBqCmBy+Z7HaiuJ22PRRQhewL
	Zpk6w+G77OZmirtM2vzoJ4wClD/CA1Z2zSosvbAA==
X-Received: by 2002:a17:903:1a27:b0:2c9:dc38:3ec7 with SMTP id d9443c01a7336-2ca7e7579cfmr63288875ad.29.1782992683240;
        Thu, 02 Jul 2026 04:44:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dadc8sm12332265ad.16.2026.07.02.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:44:42 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH 7.0.y 1/2] ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
Date: Thu,  2 Jul 2026 19:44:38 +0800
Message-Id: <20260702114439.1942588-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026051900-nanometer-dropkick-80d8@gregkh>
References: <2026051900-nanometer-dropkick-80d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

mem_check() in net/ipv6/ip6_flowlabel.c reads fl_size without
holding ip6_fl_lock. fl_intern() takes the lock immediately
afterwards. The two checks therefore race against concurrent
fl_intern, ip6_fl_gc and ip6_fl_purge writers, which makes the
mem_check budget check approximate.

Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
fl_intern() into its only caller ipv6_flowlabel_get(). The
mem_check() call now runs under the same critical section as the
fl_intern() insert, so the budget check is exact.

With all writers and the read of fl_size under ip6_fl_lock,
convert fl_size from atomic_t to plain int. The four sites that
update or read fl_size are fl_intern (insert path), ip6_fl_gc
(garbage collector, the !sched check and the per-entry decrement),
ip6_fl_purge (per-netns purge), and mem_check (budget check), and
all four now run under ip6_fl_lock.

This is a prerequisite for adding a per-netns budget alongside
fl_size. The follow-up patch adds netns_ipv6::flowlabel_count and
folds it into mem_check().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Link: https://patch.msgid.link/20260506082416.2259567-2-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7ce5556f255a680d80daa31b1cedecf7f89e2c22)
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_flowlabel.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f6ec..a8974643195a 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -40,7 +40,7 @@
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
-static atomic_t fl_size = ATOMIC_INIT(0);
+static int fl_size;
 static struct ip6_flowlabel __rcu *fl_ht[FL_HASH_MASK+1];
 
 static void ip6_fl_gc(struct timer_list *unused);
@@ -163,7 +163,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
 					fl_free(fl);
-					atomic_dec(&fl_size);
+					fl_size--;
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -172,7 +172,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 			flp = &fl->next;
 		}
 	}
-	if (!sched && atomic_read(&fl_size))
+	if (!sched && fl_size)
 		sched = now + FL_MAX_LINGER;
 	if (sched) {
 		mod_timer(&ip6_fl_gc_timer, sched);
@@ -196,7 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
 				fl_free(fl);
-				atomic_dec(&fl_size);
+				fl_size--;
 				continue;
 			}
 			flp = &fl->next;
@@ -210,10 +210,10 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 {
 	struct ip6_flowlabel *lfl;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
 	fl->label = label & IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock();
-	spin_lock_bh(&ip6_fl_lock);
 	if (label == 0) {
 		for (;;) {
 			fl->label = htonl(get_random_u32())&IPV6_FLOWLABEL_MASK;
@@ -235,8 +235,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 		lfl = __fl_lookup(net, fl->label);
 		if (lfl) {
 			atomic_inc(&lfl->users);
-			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock();
 			return lfl;
 		}
 	}
@@ -244,9 +242,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->lastuse = jiffies;
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
-	atomic_inc(&fl_size);
-	spin_unlock_bh(&ip6_fl_lock);
-	rcu_read_unlock();
+	fl_size++;
 	return NULL;
 }
 
@@ -464,10 +460,14 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
-	int room = FL_MAX_SIZE - atomic_read(&fl_size);
+	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
+	room = FL_MAX_SIZE - fl_size;
+
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
@@ -692,11 +692,19 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	if (!sfl1)
 		goto done;
 
+	rcu_read_lock();
+	spin_lock_bh(&ip6_fl_lock);
 	err = mem_check(sk);
+	if (err == 0)
+		fl1 = fl_intern(net, fl, freq->flr_label);
+	else
+		fl1 = NULL;
+	spin_unlock_bh(&ip6_fl_lock);
+	rcu_read_unlock();
+
 	if (err != 0)
 		goto done;
 
-	fl1 = fl_intern(net, fl, freq->flr_label);
 	if (fl1)
 		goto recheck;
 
-- 
2.34.1

