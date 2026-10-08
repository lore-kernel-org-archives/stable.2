Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1223C37A3
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453424; cv=none; b=CcpOQ+pZVMME4w7Hlifm0SBJlhI42cIIWiOc4vP7lyjhyXNyO5GFCAQAdtNRi8BU2RykFanqtg1MofU55ugFh2JBUGnXG6yNx+I50sFExpq18hSS8F+V/oUNFnKtD171PRX6pYnsuPLDEWD+fIbHlVZDAyhtnJGpjXGZLoGobGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453424; c=relaxed/simple;
	bh=TBHsL/PgZQi8hSWleQHtPkNoXkclLQYAF6s/1H4mQsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1+ODglKttrmqmNMNbuBZ3nj2ZUhSTNfitHCeHlgh0PRvC3jbfE1+38eP1d9roxVElXzRKEsHoFzArZw69JPK2VA1SP3u0RIdbc6/DfyW93Ow+6odxlI2ldicST0tlI3y5I5SJGNLAWWjLROrUcsriQJFIRA5+PKqrg1lHaAVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efG8/Zev; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efG8/Zev"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48af27fe287so2073781f8f.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453421; x=1792058221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gQ+MBIlSY5Fb8vVvV13aAvMv4bN9+NGoqvZSi+JVr+c=;
        b=efG8/Zevxr+c/gYVg+cS/oN1EZa2cnSDRIqo9lNJJRiNszG3jUchmqACD/mcizu5q5
         wMlBnc9AmLoT+xyay3fJ2r39+oJ9fJqSAvsZHx2z+P2wG16Ujal1g4p85zZxAkZk9PaV
         e2NOVmDidu4uk21QggTWc6XBXtuRxv0XaoweAqc1M+QRuYNGvn5q+sTnhTqg5BXSm9mN
         WtG3Jp+8aoa5P5php9Pp/DU18oebkg489m20vw3PGqUVeboKJVG2m83dv8IA8hIydfXT
         aRZNN66xlqzIJwmtD7HywzEBVRimzjgP15SOxtOjkFwWQR/dvQzMWvVY2ONeMckGtnRO
         ndUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453421; x=1792058221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQ+MBIlSY5Fb8vVvV13aAvMv4bN9+NGoqvZSi+JVr+c=;
        b=YieqzqBouPymC/eIOfhTwsVRVlvd/k8uyW4Vs92BGXkZqrRFhP7bGEx1Yn1RFaxTkc
         Bfce/t85FEAQhvt1stRaBqqfJcWPWCVDpaRewRWscn4gKzWV87zNWp2JHpXOPZjqmD+k
         AnWgrIZgKhvCQhgaWTSCd1fh1XpFpK2aL79mGiZHmGOSb7qeyGuD31ndKpABpVAewo4y
         AYzRKMY2XnWa0PJ7gpBGdjdPvFQLef9BXtYzZ029KIEuBNAQCD5JfZObea6Zqh7Mk1lA
         4PTaOqQjnVt3UNoae9yP7kaHwR1Fx3j1x+VvCt+6KAL/6gZtmYcbI8w4d7eb0PgsCCdy
         CylQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgU4j65fnjq9GcDAZZq9ekBfNrkRss4IHjom2zLdNME1D3e2PS/TXSDS4WuxUbYPNbv0LhVnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6Pi3F8zl5kTsTlfoK3mfetOL0MIsvHLgrkLqymDvlizGZueam
	EYM3Lywe7JzLqo0plP8Jffl03zEQY7js6RyOA62d+v7R/9SWLGNSSlUu
X-Gm-Gg: AYBFou0x4XEJdKw/Uyj2ccyHlvzaz359PAtf8iaurVTp+YtOLLqk9DWLmp7DlFX9RXy
	ubBj9bm9j9Aj+R+d6xxm9wcOJ0VKZpLGxm9DTSPGUeyuQEk8Nw7zoaVfGjaY0HAloTmCqelr3pn
	8OXHBVW2NFW/AmLov3+U+I+qwjGNIxl95quKQVbWb/iAttqid9VYQpaMH9tXDUgXtZPr2Fcw6UR
	QxCBBEL+HK2hO9F1p5RnkNH9tDgd7ZAVbQGNAnNzYXIn4/Lh8XGYFqhF2s9avxnQq2oh5lhletW
	hSuvDB+8BLWuv9vRcr1yLeSnXl9KwTTkw62jDuYfiT8LBUF7rwMBUv8gyUulvTUeh8CrMsPzyb4
	qe1KLg/xrG5FONyXledJz0OU6Dn2PhkPardDZrW2yfgeIrGfPIPd0d3Fa6XBPEaQrA54+HAGKBJ
	2qqLZeUgMGA9+uqx4Xtu6y7xhd8UmDhsqRgzjn+XT7U2C2JMZxz+i2uSqPeVKgJCQSuwSZUwQaV
	/ujeSmef5rJvCyUYgFtxlDUOJ4c1nITtiNWNs35nbPZxfs=
X-Received: by 2002:a05:6000:3106:b0:48b:fc4:e852 with SMTP id ffacd0b85a97d-48c72789260mr9641259f8f.29.1791453420953;
        Thu, 08 Oct 2026 02:57:00 -0700 (PDT)
Received: from MacBookAir.home.tenber.ge ([2a00:6020:a725:dc00:1436:879a:b37f:42c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1245bsm10222720f8f.26.2026.10.08.02.56.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 02:57:00 -0700 (PDT)
From: Jan-Gerd Tenberge <janten@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	yonghong.song@linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: Fix UAF when map user reference is revived
Date: Thu,  8 Oct 2026 11:56:56 +0200
Message-ID: <20261008095656.92793-1-janten@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_map_put_uref() invokes map_release_uref after usercnt reaches zero,
before bpf_map_put() drops the map reference. BPF_MAP_GET_FD_BY_ID can
find the map during that callback and raise usercnt again.

The sockmap and sockhash release callbacks unconditionally drop programs
without taking sockmap_mutex. A concurrent attach through the revived fd
can therefore publish a new program before the stale callback drops it.

For a bpf_link attachment, this leaves plink set while pprog is NULL, so
link release warns and leaves the attachment slot unusable. The callback
can also drop the program between sock_map_prog_update() and the later
bpf_prog_inc(). If the program fd is closed concurrently, this removes
the last reference and schedules an RCU free. The subsequent increment
then resurrects a zero reference and leaves link->prog pointing to memory
that will be freed. A KASAN reproducer triggers a slab-use-after-free when
reading information from that link.

Triggering the race requires CAP_SYS_ADMIN in the initial user namespace,
because reviving the map uses BPF_MAP_GET_FD_BY_ID. A deterministic KASAN
reproducer is available privately on request. It was used to verify the
UAF before this change and its absence afterwards.

Serialize the release callbacks with program updates using sockmap_mutex
and recheck usercnt under the mutex. If the map was revived, leave its
programs intact. Move the map user-reference put in link release outside
the mutex to avoid recursively taking sockmap_mutex when it drops the last
user reference.

Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Jan-Gerd Tenberge <janten@gmail.com>
---
 net/core/sock_map.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df84284328..32ccf4ca3c76 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -26,7 +26,8 @@ struct bpf_stab {
 
 /* This mutex is used to
  *  - protect race between prog/link attach/detach and link prog update, and
- *  - protect race between releasing and accessing map in bpf_link.
+ *  - protect race between releasing and accessing map in bpf_link, and
+ *  - protect race between map user-reference release and prog/link updates.
  * A single global mutex lock is used since it is expected contention is low.
  */
 static DEFINE_MUTEX(sockmap_mutex);
@@ -372,7 +373,10 @@ static void sock_map_free(struct bpf_map *map)
 
 static void sock_map_release_progs(struct bpf_map *map)
 {
-	psock_progs_drop(&container_of(map, struct bpf_stab, map)->progs);
+	mutex_lock(&sockmap_mutex);
+	if (!atomic64_read(&map->usercnt))
+		psock_progs_drop(&container_of(map, struct bpf_stab, map)->progs);
+	mutex_unlock(&sockmap_mutex);
 }
 
 static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
@@ -1226,7 +1230,10 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
 
 static void sock_hash_release_progs(struct bpf_map *map)
 {
-	psock_progs_drop(&container_of(map, struct bpf_shtab, map)->progs);
+	mutex_lock(&sockmap_mutex);
+	if (!atomic64_read(&map->usercnt))
+		psock_progs_drop(&container_of(map, struct bpf_shtab, map)->progs);
+	mutex_unlock(&sockmap_mutex);
 }
 
 BPF_CALL_4(bpf_sock_hash_update, struct bpf_sock_ops_kern *, sops,
@@ -1743,6 +1750,7 @@ struct sockmap_link {
 static void sock_map_link_release(struct bpf_link *link)
 {
 	struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
+	struct bpf_map *map = NULL;
 
 	mutex_lock(&sockmap_mutex);
 	if (!sockmap_link->map)
@@ -1751,10 +1759,12 @@ static void sock_map_link_release(struct bpf_link *link)
 	WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
 					  link->attach_type));
 
-	bpf_map_put_with_uref(sockmap_link->map);
+	map = sockmap_link->map;
 	sockmap_link->map = NULL;
 out:
 	mutex_unlock(&sockmap_mutex);
+	if (map)
+		bpf_map_put_with_uref(map);
 }
 
 static int sock_map_link_detach(struct bpf_link *link)

base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
-- 
2.52.0

