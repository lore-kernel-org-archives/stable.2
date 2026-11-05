Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894552;
	b=P7DfLh5EsVDpMqTuG3bGL6g/CceSznHP6rOvbjtNuhHV1GZxqjAagtvH1oaxmpSDx0Th
	 1tvObpBpsh3Btocl2OkkbOCUMj+CEu55Z9QG7PZyFqKe2mOaXs3LE4mNRy99RuMUiCZwY
	 YL8VySQR5+izszumnjpxodmgEsDIfHvG+inFlvKnheRdA1sN5a7NX7eccd0lXRI5kxvAV
	 2nDoM83s/7guQgpkPlun2Wl2LTWwB2hKMugxX4Il+Zfs/Ad2YOKqea3W3vqFmj2cx6RnE
	 0wm4vHK0jAwlqDZ+BpPKkCIpQlAMQn4G7Bw3dHSVN5LxNdaMYeRQUf9ggB3fcvB3YfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lEpyyp3Nh2lMfQuU5TyDvWhNl/GQMG+KamM310H/GGU=;
	b=rgLzPGr+xM5uZEhOjA0K7mqTxXnlG6kyHxQTwBDAPB8QRGIwBfq4AnDLr/mHtp0Tcb1/
	 HRMfBPls+CIn82QoJPAcJKU2o1VhgQg5pkglLkPq7y9AyYkXu/0Hye++P65VKDHNAibEu
	 KtZ/IOmdYAnYxkfXZyXN8vWPVZQIRkL4Q5TWLTiAVLGqNj15YQAasprDVPxxUS5+XwMyr
	 fAWWAoo4vW592q2T0FT1FDpdS73RWTLqIcXlQNqW4RwSCB8vyMYNXxDbd6fwhIWiT4BoC
	 7Sc9vsUxwIMmXEu84HG5pDXNglJ1LWD9nNUKADA/JdqlNPzGYTXhyYpnN35kpjKNYQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gH7Sh0gR;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EF6070795
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE9EF6070795
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gH7Sh0gR
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a3c08d6928so3035227c88.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793894551; x=1794499351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEpyyp3Nh2lMfQuU5TyDvWhNl/GQMG+KamM310H/GGU=;
        b=gH7Sh0gRaGfLw8Ky8OZtzEnWNrQJsN4tGHcUt4pViK15ULx+i4cv66rQ/bPaNwjRmC
         HjTin+z/heJEuVMWK5BIX/gxkiSDxLQ02Ub2+/467o6vWA1mQT4TmZqG9FS1BFmNb3/y
         hqvT3TXxHB4KcXf5IZ6KN3/DmWIiDVjelt1uUZdriViKVQjbTWjKeyAjkTCusy1QpW1Z
         1yLwliRZPJQTywXXWdlaa6DP+Rw+pUVL0vpHRGNW2SVZpKNUxLdGOqQODzReOmRAb1y+
         x3p+1w0FixdLzi/htremDyYbPYtlNTBAk1SDiW8uquW2/Ar8a2PzfahXxKNukHKqqG+P
         VDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894551; x=1794499351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEpyyp3Nh2lMfQuU5TyDvWhNl/GQMG+KamM310H/GGU=;
        b=ilAmDGyw6z0Yj2P7ywFj6OHNLZMg/KXyfWlboPPSAxwOtqocOC1hzER2bWuAzShczh
         r8DJ8xXe3BgKq/ryAklQEP5W/xPz4JdFhxtMFgKjGMnNRCyTzGXzw1mbbYOeAIes9cKB
         IEQlmrLAHumhFOz4XQnxaBlfCNBVbt61YPCZ37KnAxLH+Ti34muUK9JeeaMk3FqijAs8
         Et2TY0YWK17iW/XmjhQN4ov2tP0w0LNMoRhWkEwxNcVPpbhO0/46YQxHYXi3fn1jRvwL
         SST70DDMSFp7cd+FCybY5ntMdCZ5A9TNr0ctUnf9EbhybvQZPm8FFgrNQi82fiKlc7Vr
         2YJA==
X-Forwarded-Encrypted: i=1; AKwUvByvBznA3lyIY5l48VAt2+5j2U7VxAuZGoHqWjtGaE5d1nO6yz6AfUm2kMK9trSDXnwdteMKVEk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JniVK1KPl9kzSpWm5vXxlarQsXn9jn7hzNPwe/8/BcRpUUduF
	IhqQA5Ll3YeO3hlLNaZDI9DQWhAuLYZdG6Bkfo/rgtqv1QZb4TtvIiyG
X-Gm-Gg: AYBFou31/oLCymqhdD+5JVwbOWi+Nay+oV8ChizIYm1cXQ1QUyLLPNqvyqm56SPM6zG
	pS/+ZdOkAq/YjagFsGIpwoUqtOESIfvhZ38dRIPkxZKsxnn8tr+anO8cHM8ZEusnLBe4tMNHTmS
	OBO0sYujKIoAIZJFV43xsz4U307n6Iur8bR3W+2SSzhkKoX0w6/aLyr8SjkcGMAmHa8iXaLj86X
	zVGU5d+Ygq3CmNDbIaXaHoERAviCbx27zN13ePpXZwt3LGA7LcLV2NZtC0r4UFbeqBFf/vymroA
	DCdWr4lcqQ5tHg8PcWl70C/IKXiydr8MUQHFETDWWgJSGKML93BVF+0GAw5uFF45Bw4mQkE/We7
	KXhvswOePNKr43Nl68kceMLdmdT3BbZst5DEbJ8bW+yM/AW2tY6s8iPVlzVZctek8501APSCN7W
	5kPVQY52KCmHW3Wt9cGBNK7yjvuUU9h1YfeVMnduVIb9K+VZhOR2tNWLe3u4SaDaPn+yR5XEVun
	kK/m9AW3mZFdoceVYoOQ8iMb1+y6EJE09bP58KKBstC7wCbytCN/gydFjhfyCZim67DNBmc35CL
	SzGlXfag7JPGIJ7tNFZe+ZMIVEC5RO6fPIKGgeEo1AYkHzL0qoTY
X-Received: by 2002:a05:7023:904:b0:168:3243:c907 with SMTP id a92af1059eb24-1ad85de518fmr33710895c88.24.1793894550537;
        Thu, 05 Nov 2026 08:02:30 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm16414126c88.12.2026.11.05.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:02:30 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fault-inject: fix boot failure with fault injection boot parameters
Date: Fri,  6 Nov 2026 01:01:58 +0900
Message-ID: <20261105160209.1504867-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit e9bc360b105c ("fault-inject: use prandom where
cryptographically secure randomness is not needed"), setup_fault_attr()
calls prandom_init_once(), which calls kmalloc() and schedule_work().

But setup_fault_attr() can be called from __setup handlers before slab
and workqueues are initialized, so any fault injection boot parameter
leads to boot failure.

So use DO_ONCE_LITE() instead.

Fixes: e9bc360b105c ("fault-inject: use prandom where cryptographically secure randomness is not needed")
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
QEMU-based test results
- build with gcc 16.2 + x86_64, booted with "failslab=1,0,-1,0"

1) AS-IS (before fix) 
[    0.090415] BUG: kernel NULL pointer dereference, address: 0000000000000018
[    0.091661] #PF: supervisor read access in kernel mode
[    0.092639] #PF: error_code(0x0000) - not-present page
[    0.093593] PGD 0 P4D 0 
[    0.094051] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.094800] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.3.0 #2 PREEMPT(undef) 
[    0.096178] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[    0.098046] RIP: 0010:__kmalloc_cache_noprof+0x142/0x370
[    0.099024] Code: ea c1 ea 08 41 89 d5 41 83 e5 01 8b 53 1c 0f 1f 44 00 00 45 84 ed 74 12 4d 85 d2 74 0d 4c 89 d7 31 f6 e8 e1 2d e1 00 49 89 c2 <44> 8b 43 18 48 8b 74 24 50 0f 1fb
[    0.102388] RSP: 0000:ffffffff82c03d50 EFLAGS: 00010046
[    0.103326] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.104604] RDX: 0000000000000001 RSI: 0000000000000020 RDI: 0000000000000000
[    0.105883] RBP: 0000000000000820 R08: ffff88807dda6c70 R09: 46ad46184e3f2c64
[    0.107194] R10: 0000000000000000 R11: 46ad46184e3f2c64 R12: 0000000000000030
[    0.108472] R13: 0000000000000001 R14: 0000000000000008 R15: ffff88807ffd3ab1
[    0.109832] FS:  0000000000000000(0000) GS:ffff8880fa4ac000(0000) knlGS:0000000000000000
[    0.111284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.112311] CR2: 0000000000000018 CR3: 0000000002c30000 CR4: 00000000000000b0
[    0.113616] Call Trace:
[    0.114059]  <TASK>
[    0.114462]  ? once_disable_jump+0x20/0x80
[    0.115202]  once_disable_jump+0x20/0x80
[    0.115905]  setup_fault_attr+0xe6/0xf0
[    0.116597]  unknown_bootoption+0x111/0x210
[    0.117352]  parse_args+0x14f/0x3c0
[    0.117983]  ? __pfx_unknown_bootoption+0x10/0x10
[    0.118839]  start_kernel+0x3b8/0x7c0
[    0.119539]  ? __pfx_unknown_bootoption+0x10/0x10
[    0.120435]  x86_64_start_reservations+0x24/0x30
[    0.121310]  x86_64_start_kernel+0xd1/0xe0
[    0.122278]  common_startup_64+0x13e/0x158
[    0.124133]  </TASK>
[    0.124756] Modules linked in:
[    0.125309] CR2: 0000000000000018
[    0.125905] ---[ end trace 0000000000000000 ]---
[    0.126741] RIP: 0010:__kmalloc_cache_noprof+0x142/0x370
[    0.127704] Code: ea c1 ea 08 41 89 d5 41 83 e5 01 8b 53 1c 0f 1f 44 00 00 45 84 ed 74 12 4d 85 d2 74 0d 4c 89 d7 31 f6 e8 e1 2d e1 00 49 89 c2 <44> 8b 43 18 48 8b 74 24 50 0f 1fb
[    0.131129] RSP: 0000:ffffffff82c03d50 EFLAGS: 00010046
[    0.132126] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.133483] RDX: 0000000000000001 RSI: 0000000000000020 RDI: 0000000000000000
[    0.134843] RBP: 0000000000000820 R08: ffff88807dda6c70 R09: 46ad46184e3f2c64
[    0.136206] R10: 0000000000000000 R11: 46ad46184e3f2c64 R12: 0000000000000030
[    0.137565] R13: 0000000000000001 R14: 0000000000000008 R15: ffff88807ffd3ab1
[    0.138928] FS:  0000000000000000(0000) GS:ffff8880fa4ac000(0000) knlGS:0000000000000000
[    0.142705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.143741] CR2: 0000000000000018 CR3: 0000000002c30000 CR4: 00000000000000b0
[    0.145037] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.146284] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---2) TO-BE (after fix)

2) TO-BE (after fix)
- boot succeeded

---
 lib/fault-inject.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 02916ef2761c..9182d457baf5 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/once_lite.h>
 #include <linux/prandom.h>
 #include <linux/debugfs.h>
 #include <linux/sched.h>
@@ -50,7 +51,12 @@ int setup_fault_attr(struct fault_attr *attr, char *str)
 		return 0;
 	}
 
-	prandom_init_once(&fault_rnd_state);
+	/*
+	 * __setup handlers run before slab and workqueues are initialized,
+	 * but prandom_init_once() calls kmalloc() and schedule_work(). So use
+	 * DO_ONCE_LITE() instead.
+	 */
+	DO_ONCE_LITE(prandom_seed_full_state, &fault_rnd_state);
 
 	attr->probability = probability;
 	attr->interval = interval;

base-commit: c2366a2edc886a5a02d2a43de8b1c6ec09bab840
-- 
2.53.0

