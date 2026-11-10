Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322980;
	b=WvHZiJmnFaT9OWBCIgfVwzBiMtRL74kxKUeBxwx5nVeJwIlc8ZBT2FyW+x5+ZJlnl4t8
	 EQeKuVC3rIzasU7reoUdU2gqZJsLxWR8W6DDWPw4YmKuC2dIoBNzjtLrRL8ycAPAdM4SO
	 twAmX6XhYPWRBF62xqaLszf68MpYgTl+tHQFSNCwDqXQFnzXA1rCA/mLBbJ5xl0a97dtE
	 Qkm+8NHCHGYHIeYmxJN7z4JdduPIAcy7ANsERxkwpJj1+WI6PoYnwQ3BObo3Nye3DP+oH
	 Znir1CPpTE2YmZhTbVKGvuvt+C2a4MKCkiwMSFAQ11lSxMvxkiobAKX5X+TcUlpk/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q67Hxg+0MYife6GtZIdwoZarR9f9DxzBGDp5ujmu0vc=;
	b=FBmItMRvYIz3brn6OgahEi/EUGHoSfUJEeQUsmB9mieT3v6KoJA50GjLz87LsePW+NdT
	 v0ciNgR+VawTbsxe1Zkb9r740mh9aj7G05Ogl4kIZY+nglzNUWxhpRQ7vLj4+9bbKjb1T
	 KQ3AKW/hYSEGokdyZInaQ7ZDlEQNOYvhgqm+cCJaQ/1gD90TJ3lnShr8D15WpNA22qAz6
	 vToQgnxJZoLW6R8poLqBoehdwoR8HpWW0hxqQ9rDkSxnLDfcVrmfwULJefjpZFzNt6MZO
	 PDDywsuycN7LuOqTw7e7VrVMmF104CjvTf8PVdko4gLbOev9WSTWFQM7lhK6DwGrG5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1Fnf0wM;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF6606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0BF6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1Fnf0wM
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e96502e447so17566515ad.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794322979; x=1794927779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q67Hxg+0MYife6GtZIdwoZarR9f9DxzBGDp5ujmu0vc=;
        b=h1Fnf0wMNRbWnbB6jZGwEwGodBchnjkok98JgdLi+EkdpSYbn4x0Vyzjl//fmrqfUT
         JPHUQv0ombEfOtPoz49uAozdoZeNJNUn8ELEstiT1kmHu8eWhDh4SS2BFXaqBLHtqC1F
         ws7yhN5JNShhW04yKjp/CFQcFaENKBOPx3NVt9aGEhvQGZKH5t6l3l/QscAzzWHmol6W
         5U7iHFYtcB6+Yb0Arvz+2zWM6/v+d3Bcaa+4VpV10MYcQLtwM9aLIyvWEh6NZwuJheNr
         eicvEroNSJ8nl/dVvTxaqglFvnIqAgGAeyOtYvGm+OIqZC0oHm01Gduff6uKT/WKud2a
         D2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322979; x=1794927779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q67Hxg+0MYife6GtZIdwoZarR9f9DxzBGDp5ujmu0vc=;
        b=XQmI3XLsy7UVJouA1ZVwM3ixZr0SG7ymUcu3ANOq3CC8bCTp6OHG6dYyo2BkSJ9SpE
         ZaPvFo629yrd9/JOrEzHMy/nIf4zHIEi9l4r7NM3vTg1/sQAUK4FjZtMLQcIAlSmE9CL
         yw9Gk9qtulYKcOBzpLHrvNgmLXU8BVzlh3tVhWZg4CnNjtNWMbYOYhxHnQiC4V5Lykv8
         EbGCzfVuhrgDfjRx/58ddFdUktCv1ncSNtwukIgZqNOTXfXoz1H6FPp4MoICix/E5gk9
         no009XiuQr70lvixl2O1nUqkwGNwK5z+vKB6pHxDnoI7xCFAHgVaR+16RHN0+EIuHczD
         pmAg==
X-Forwarded-Encrypted: i=1; AL+hErE9fQngkdIkQhHTCGKPpflncmMT+AnGn3JvatnADGpPPnJDp8rDnMi9aMVMEuRRDhPf5JEzaVo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sGM//4bgARcHeLhvcXyTIxqArLYZ9NqkpiTHd3+/T2yE7kvIf
	Cy6NwA8NRAr4q9vmuHqrPGL3N4EgR4lVcQQNock/0Nuf0T1ZL8hYstlf
X-Gm-Gg: AYBFou16PYtZUvclDHq3A/TrHEXzUWi6g1+zZBpLf1oMob3EpPK551kQwmKulcHIu5i
	ybH/beZnAcITF6PWH6MGkh9MAxdmeDkY2OrpPznSdxUK2YzuUYwG4DflIKMfQfAfbv1L0l8UVHF
	4jMyxInlQGvk2NLOBlL9ASmVowVkx2wFJuDXcDI+7bQrG4tiRInvxTOD8zQyqsdGehIA3IT7NaH
	gPCAZshn4hw609pznLQUu6EuoI/LtW7ekDqokXdKOh0/5r2X9ebwFu1CEyrkVVxrNkdgQkJtmyG
	+SpwyQSvln+nYAo8oJw8bxFBLZFbPFnuUJ/tXlEX6alD+K0Dn896rBFVLy0OZS6MaFAFJqiL6Zr
	2qqTzE/0BqvY4VK6II0bzdP8xGkxDDy/WMjeoyYxmydfhw6jAxcNh1zHGFo1F5vb5Wvoc3575KK
	jQcpLZPJ/XYKl9tqtzzZkr1LySscUgfQkx1NpwpvAaVhPOezlzNE+xvywxHiw1yOMu0/5ImHn4U
	Kub97psZNlfXPIIerGACjWVlC4f5PgAvoR4KfzV7cgQ2ZG1tR+ASF325aKaECI9mvbvv4Ux8eRN
	JowUyi0pDs/FApZnkQAfsJqf1OOYgYomLFFwSBWYVqv7A3fK4EFS
X-Received: by 2002:a17:903:2a87:b0:2e9:8202:509c with SMTP id d9443c01a7336-2edb8f92d42mr26427195ad.7.1794322979043;
        Tue, 10 Nov 2026 07:02:59 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d9ba8esm10233085ad.44.2026.11.10.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:02:58 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
Date: Wed, 11 Nov 2026 00:02:46 +0900
Message-ID: <20261110150250.71520-1-ekffu200098@gmail.com>
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

inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.

But inval_wq_set() can be called at boot or module load before
fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
warns and the work never starts.

So defer scheduling the work until fuse_dentry_tree_init() sets it up.

Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
QEMU based test result
- booted with "fuse.inval_wq=5"

1) AS-IS (before fix)
[    0.011073] Kernel command line: rootwait root=/dev/vda console=tty1 console=ttyS0 nokaslr  fuse.inval_wq=5
[    0.011114] ------------[ cut here ]------------
[    0.011115] WARNING: kernel/workqueue.c:2704 at __queue_delayed_work+0x11a/0x140, CPU#0: swapper/0
[    0.011124] Modules linked in:
[    0.011128] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.4.0-rc1-00010-gab9787d7e66a #1 PREEMPT(undef) 
[    0.011130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[    0.011131] RIP: 0010:__queue_delayed_work+0x11a/0x140
[    0.011133] Code: c4 08 48 89 df 5b e9 85 28 0a 00 90 0f 0b 90 4c 8b 42 08 48 8d 42 08 49 39 c0 0f 84 1c ff ff ff 90 0f 0b 90 e9 13 ff ff ff 90 <0f> 0b 90 e9 ec fe ff ff bff
[    0.011134] RSP: 0000:ffffffff82e03e00 EFLAGS: 00010003 ORIG_RAX: 0000000000000000
[    0.011135] RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000001388
[    0.011136] RDX: ffffffff83a3f320 RSI: 0000000000000000 RDI: 0000000000000040
[    0.011136] RBP: 0000000000000000 R08: 0000000000000082 R09: 0000000000000001
[    0.011136] R10: 000000000000000a R11: 000000000000000a R12: ffffffff82c09fd0
[    0.011137] R13: ffff88807ffcfb89 R14: 0000000000000000 R15: 0000000000001388
[    0.011140] FS:  0000000000000000(0000) GS:ffff8880fa26e000(0000) knlGS:0000000000000000
[    0.011141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.011141] CR2: ffff888003a67000 CR3: 0000000002e30000 CR4: 00000000000000b0
[    0.011142] Call Trace:
[    0.011143]  <TASK>
[    0.011143]  queue_delayed_work_on+0x6a/0x80
[    0.011145]  inval_wq_set+0xc4/0xe0
[    0.011149]  parse_args+0x299/0x3c0
[    0.011151]  ? __pfx_unknown_bootoption+0x10/0x10
[    0.011154]  start_kernel+0x3b8/0x7c0
[    0.011156]  ? __pfx_unknown_bootoption+0x10/0x10
[    0.011157]  x86_64_start_reservations+0x24/0x30
[    0.011160]  x86_64_start_kernel+0xd1/0xe0
[    0.011162]  common_startup_64+0x13e/0x158
[    0.011165]  </TASK>
[    0.011166] ---[ end trace 0000000000000000 ]---
[    0.011173] ------------[ cut here ]------------

2) TO-BE (after fix)
- no error while booting, and also fuse_dentry_tree_work works well.

---
 fs/fuse/dir.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index da23ccd8685c..6965a77a871f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
 /* Minimum invalidation work queue frequency */
 #define FUSE_DENTRY_INVAL_FREQ_MIN 5
 
+static bool inval_wq_ready;
 unsigned __read_mostly inval_wq;
 static int inval_wq_set(const char *val, const struct kernel_param *kp)
 {
@@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
 
 	*((unsigned int *)kp->arg) = num;
 
+	/* Defer the work until fuse_dentry_tree_init() sets it up. */
+	if (!inval_wq_ready)
+		return 0;
+
 	if (num && !old)
 		schedule_delayed_work(&dentry_tree_work,
 				      secs_to_jiffies(num));
@@ -224,6 +229,11 @@ void fuse_dentry_tree_init(void)
 		dentry_hash[i].tree = RB_ROOT;
 	}
 	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
+	inval_wq_ready = true;
+
+	if (inval_wq)
+		schedule_delayed_work(&dentry_tree_work,
+				      secs_to_jiffies(inval_wq));
 }
 
 void fuse_dentry_tree_cleanup(void)

base-commit: ab9787d7e66ac7e6e94fc975b37c5b56fff98ca9
-- 
2.53.0

