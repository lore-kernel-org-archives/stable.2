Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4765361656
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783619; cv=none; b=ZQYLLeBrGeBZQUsx3mfhufD8JfTSiLnUkGOFUo6RMjKIARoMZi8wl+lrx4Q+ctIdnOE8MqTjDqVLX90zkoDRr3hLzV5EJ15MIqSgxXdaF6Oi5ASY2FZFtjQeRq90b+NkV4YJF8nCEFVJm5G9Jf24isJrU9zOXsRqIz7WOzGKqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783619; c=relaxed/simple;
	bh=lqX3NFVJb1A4/zvjomlEJ+gLbOtrMdo0bbyB4Eoxjd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOVGBHqeI8vqPGMOJQiV08qFDpjAtNdewdq44l1bp129AJi/UiaI3KhbbTe1LCVviOyTy2oG/iKigGZfj/XwjjVR2sogI7piV071/ZYY123dkC0mPGJYpcADHhUFikPk3Xe9iztzcRwf0OUnf9JJ3rsFaMyMCERXC+Snmg8yL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULsNAUsc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULsNAUsc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ced3386430so18974495ad.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786783618; x=1787388418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q35baY3576CpJCsemdJuaEMGFcmNQl1jwCggun4sD5Q=;
        b=ULsNAUsc0CMKaatwkE4HmBtndUjqMJSvDfWfWpMU4zHqIvPGpe5dVqrA1xA3cKIBXL
         YqU1+OMzS/5P/tgeaqv2e7wJjQ7tBX0NK7gxussfmViP/zomSxISScQoAUZu0F5rTMGD
         v3eVrhifa4WMXz60Okdd8SI0pQOgOuHeJQr/RwPOQjzYRQhgCZmZCAHLGOiYCmbzywea
         jYZJQ/IBLnqGx9o0pqbbY3AuW8WH4mJnBG6bUHEq5dR5WKGGpxPpi5Yl813CJJDDfQBT
         ftq7KXVaN3ss2808Vjy4r3urUNg/eLFO7V/GTfmE6fG1w0ps04ttLcP0TCzRZ17F1QKF
         Yowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786783618; x=1787388418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q35baY3576CpJCsemdJuaEMGFcmNQl1jwCggun4sD5Q=;
        b=r0JRkzcyzcMNITrNSt5np3eNSobRz8Xy+wvQfQ6xY0FEDskHhKgShzoQ3+51zEi6b+
         FMjhrIEb4p3n3jQKqujQUQ3XMtBNWz44vx++Y9IZQChWID7HTGS72QqzpBcBiZj0S9/n
         4vvBAlUJ6DQfwrdF23lUDiAW0IHfKwHyZ+HKhWyf/eYh+G4aLA9FCg2GqnauGdcihrsf
         P29XfK1zNWYjLm4Y4Q2rzjguWFMKdw9ssXmyc3M2vWTxYBoPkAfn75aShaFYXml9i6nU
         Viv7YKU+hoNOFor2HL7myQ/dmFr79ET+lq5hqUJQbP+ofbyh06IHb/u4+tF/7ONPjWbm
         ADqA==
X-Forwarded-Encrypted: i=1; AHgh+RpWjIyIfFxFUBKLL1KcBncgc0pmPpWGT4tAbZAUm1j1dQXJZbIKozCB4MXiBqRZUcworqqfkto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3u1YUiqHXppSlqG1JnUBATTZDvJm8ebPzGZez3Ro8TnmVSUD
	IyhfWPTJC7hDgRRU3iJN9oaDVDpfGEkXprpnH3Jaq36XvHS9X8sX3EYqqmjG94UG
X-Gm-Gg: AR+sD11c5FiehpAV6tVytrfhrh/joa61eKmcP8a132xzseORfZcjZVfbFns7qRaVTqk
	IvunXMv9pHsXQ2UgCEEbM6sngX64i9ugAJzyAyrUDHH3pYlxwgwX8eBys7cC7MlNi9z5le5LUOR
	uXlfbIozDVAuLv3IJv7cyOf4q8VMgcLlE91Vve4R009DMQGVHNRLwFw4ebhqp2+iITmf7IDuTDG
	h6Y/7DXeoeD9tzMLpFzqa/gabv/lMHODyp/NUT1qlihBzXzxCk3c5VOvxB9DDopYNwg8q5hkgGk
	JX6W7BmRX1+DMc79rmMfVGcVlwj0deoNuV0j20LC2aR0ZeWqofKcHZM53XR9LHFNH4wls8HS6d0
	ilgO0exVZDjiuaDf9eOVoL9AKL4k8nvKx4EZz3bhJdB6YSnmi5cOs8UKjKMpUN6OAQFyQw17VEf
	VnmYaxcUwMZ/fC7NRH9XJfkhAGbmQ6Anv76YDAduuRp2o2RKoZYdA0Mzm3FbLlw0ZkbhMcBoYy2
	Gj225gxa9vzo66/ADeL+nrHsELtTTaaPUAZZLcSGlZ/NEbsWLsTNazevU04
X-Received: by 2002:a17:902:ce8a:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d3b04a8c75mr139852085ad.0.1786783617926;
        Sat, 15 Aug 2026 01:46:57 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:959f:bb81:fb2:a537])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae753ae0sm18121205ad.8.2026.08.15.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 01:46:55 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: use RCU iterator to dump route exceptions
Date: Sat, 15 Aug 2026 17:46:51 +0900
Message-ID: <20260815084651.69477-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt6_nh_dump_exceptions() uses hlist_for_each_entry() to iterate over
RCU-protected exception lists. The caller holds rcu_read_lock(), but does
not hold rt6_exception_lock, so rt6_insert_exception() can concurrently
add an entry with hlist_add_head_rcu().

KCSAN reports this race (irrelevant details omitted):

  ==================================================================
  BUG: KCSAN: data-race in rt6_insert_exception / rt6_nh_dump_exceptions

  write (marked) to 0xffff8a7c44c59620 of 8 bytes by interrupt on cpu 5:
    rt6_insert_exception+0x3bb/0x760
    __ip6_rt_update_pmtu+0x4fe/0x750
    ip6_sk_update_pmtu+0x19a/0x3b0
    udpv6_err+0x3ff/0x800
    icmpv6_notify+0x1e1/0x440
    icmpv6_rcv+0x8c0/0xab0
    ip6_protocol_deliver_rcu+0x616/0x840
    ip6_input_finish+0xb9/0x160
    ...
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

  read to 0xffff8a7c44c59620 of 8 bytes by task 549 on cpu 14:
    rt6_nh_dump_exceptions+0xb3/0x260
    rt6_dump_route+0x53e/0x5f0
    fib6_dump_node+0x6d/0xf0
    fib6_walk_continue+0x290/0x2d0
    fib6_dump_table+0x28d/0x360
    inet6_dump_fib+0x37d/0x620
    rtnl_dumpit+0x7b/0xd0
    netlink_dump+0x3ae/0x7e0
    ...
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

  4 locks held by dumper/549:
    ...
    #1: (rcu_read_lock){....}-{1:3}, at: inet6_dump_fib+0x88/0x620
    #2: (&tb->tb6_lock){+.-.}-{3:3}, at: fib6_dump_table+0x1e9/0x360
    #3: (rcu_read_lock){....}-{1:3}, at: rt6_dump_route+0x483/0x5f0

  value changed: 0xffff8a7c44e05700 -> 0xffff8a7c45d60100

  Reported by Kernel Concurrency Sanitizer on:
  CPU: 14 UID: 0 PID: 549 Comm: dumper Not tainted
  7.2.0-rc7-virtme #38 PREEMPT(lazy)
  ...

Use hlist_for_each_entry_rcu() to safely iterate over the exception list.

Fixes: 1e47b4837f3b ("ipv6: Dump route exceptions if requested")
Cc: stable@vger.kernel.org
Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 16dfac54a259..526535387512 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6046,7 +6046,7 @@ static int rt6_nh_dump_exceptions(struct fib6_nh *nh, void *arg)
 		return 0;
 
 	for (i = 0; i < FIB6_EXCEPTION_BUCKET_SIZE; i++) {
-		hlist_for_each_entry(rt6_ex, &bucket->chain, hlist) {
+		hlist_for_each_entry_rcu(rt6_ex, &bucket->chain, hlist) {
 			if (w->skip) {
 				w->skip--;
 				continue;
-- 
2.43.0

