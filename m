Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9B35E1AF
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846851; cv=none; b=TuO05mtes3YHxcDAQiO6gysTe1Kv9pWyIHkoL+ksXlD2SxIo586l0dA10dBJg/hBetbM54Qi0XngNQdYJ4NYxjcZAfV5dN9spxhU/BfC3pxmmJiUwIqoj0VSZFhbqBKhujjuZtYqWw/atT2QrYFLaXcK86h7hKcl55ys4Ck6k2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846851; c=relaxed/simple;
	bh=kvr//RO1+94f8bpmb+20wXDaW09Z+NiH2uehCjGUhDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QLlWA9Lz24RZ6xtmTzlQOlP7D5neALen9X3PWJucf9Kqe9VcOSKKDvNBEmeqLt93YrAP/oKg/lFPfyoN7hEoszTPGc08PHSJ0a6FKXR+bz8MNEjcux81Gmu7aTi/5LpbynkA0EPZf8osNcSc0goXjgTf+gHsFXef8S1Gn8ZLmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s595twiY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s595twiY"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca80d708489so661359a12.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785846849; x=1786451649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xCTaBVYWLAjiEa/d2L34wF4TLmueINxEUGTIIchbj0=;
        b=s595twiY8t5Kq5KfJHDcTAswYosvSK5i/hQvKn4x+VCrWjNwLZX5lUYnMx8YQSahIt
         Cl5jz7cp2sBdPEFc2F3sjQKcaEcWY2yNBwGzdnqibatKlXXUhzpPYe0ppsQwGOR9FPpQ
         CazrONF1wDB12vqgXbsF7d+soXMYb4xcTclndifScFYq+hPqW2NqbR7jjDrNJSrCWFo0
         MuLt14zcBXJbUcpds0+/DTSQR9MjGDGFbSAWWPocxjxFfZBjNK08eVbXivtPmFo6tVYP
         gJZceC4f9yuEqw9DLz6lyq9yMfOxTRllhtPQQH3OjTJTQVXOdYp+N7Rp5V5Ih1qV3Gg6
         8x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846849; x=1786451649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xCTaBVYWLAjiEa/d2L34wF4TLmueINxEUGTIIchbj0=;
        b=sD6ViO917m95JYpKQG3J/2oFcki62ZKn7rYJThGIQmE0FK1aun5JmF1APxYT6NyHjZ
         nkK3u8bhBKmjPCHxsWfMW5ES3wtq5xWLytwmpf8YsmHFQMEFi/I9cxn2jTAwXHJPnSWZ
         VO4Mv+oZdnPzU2p0F6S9vSjAYF7ziEhNn+kH+p21QO1yrUecFusmv8nuDEQ+THEUv1yB
         IZZ53qK3Z8NSIoPRvjBtrrZWWmpTjJgXgTBKZ4VOrukG8BrgG3YSYL3FspuQzSuqNOe4
         pD+Ad9RKCN/g/3egjJGc2lSCyGqQccY+xcLXdtSmVCQhTXb1majR3tiDzJ1y08vBGJGh
         qnkw==
X-Forwarded-Encrypted: i=1; AHgh+RqNzyoPVTbsU0TzTNraXC65C3KpSz3X5Q6s5T8Qtj27GZRnuOnPyALuuSptF6E9BNv4rEbogw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kD0+itsrxAkmxzsLgTkfk9pDYC8Cef/2ZZq01u3KR2TbAkFA
	n+BLPzmH+fWlfCiCSMpjfqaLo4vKm0NZPHiG0dFzvcYFfAJ/RY5vslFD
X-Gm-Gg: AR+sD13qaO1x03yDI6PTGSoqPPpNStR99iBZEQOYZpaDdWNW7Zt1IDiK/aGbGsp34nh
	N4djHtudazF8rC6C8NfsrjUedZ3DLBEPR9Hi8RSCgTn3ecY4x8HJgrOybYJ2/i0lPpMnJcbrKG0
	dCipFYR1a8hDoO/KE7sf53kuhEgcD4e6x2e34G7RbcvH1s8x0JTKwC8Jwr8yqlInAYdY4xrQBVg
	Yt6YVC8gOf8gbHCV5NYDh3wOJV7x0jyTjwm92KwkGg5k2Jaf/qaGt1ynTDjZcAYUt2b3GwjqCdn
	MYG1BjNzt2Yb33GZWhYuBpUusZp9kHz+Xj4UoAGI5+OQxzSQofYFXU4P5O7DAFvGFWs2RTqjnTk
	74oQurDdQJpuKPtNbPN4jcFKKESseMXb5xvYaJDeChn/xrT6ZEC8BM+GR6YvNykMeeLhvgLZtQd
	rM6BYXzI0m6rpF+hzcq0W2QnkaskS4Qfm/XDhG7GaDNBtKXPVdA6hckLkfIZmg/iPd7EJhv0f6/
	xX1CI/vmbvC2zJ2X0lze4oLSFs6EB88kCr9yhjQPejDx1A=
X-Received: by 2002:a05:6a20:6f8e:b0:3bf:b9de:8557 with SMTP id adf61e73a8af0-3cb6c7e2e59mr3418106637.9.1785846848938;
        Tue, 04 Aug 2026 05:34:08 -0700 (PDT)
Received: from chcpu15.cse.ust.hk (191host116.mobilenet.cse.ust.hk. [143.89.191.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963ddb8sm5062408a12.3.2026.08.04.05.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:34:08 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH net] afs: Clear stale peer app data after address list changes
Date: Tue,  4 Aug 2026 20:33:30 +0800
Message-Id: <20260804123330.2214405-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

afs_fs_probe_fileserver() fetches the current endpoint state under
server->fs_lock, but leaves old_alist as NULL.  Consequently,
afs_set_peer_appdata() treats every address list replacement as initial
setup and only binds the new peers; it never unbinds peers removed from
the old list.

An address refresh can therefore proceed as follows.  CPU 0 replaces
server S's list and drops Pold without clearing Pold->app_data.  The
server destroyer then clears only S's current peers and lets S reach its
RCU callback.  After the callback frees S, CPU 1 handles a callback
through an RxRPC connection that still pins Pold, reads Pold->app_data,
and calls afs_use_server() on the freed object.

KASAN reported:

  BUG: KASAN: slab-use-after-free in afs_find_server+0x3c/0xa0
  Read of size 4 at addr ffff8881013e1af0 by task krxrpcio/7001/74
  Call Trace:
   afs_find_server+0x3c/0xa0
   afs_rx_new_call+0x15c/0x390
   rxrpc_new_incoming_call+0x97c/0x1730
   rxrpc_input_packet.constprop.0+0xd03/0xec0
   rxrpc_io_thread+0x967/0x1640
  Allocated by task 93:
   afs_lookup_server+0x1a7/0x14c0
   afs_alloc_server_list+0x43f/0xb60
   afs_create_volume+0x923/0x1490
   afs_get_tree+0x1c6/0x10a0
  Freed by task 0:
   kfree+0x131/0x3c0
   rcu_core+0x50a/0x1850
  Last potentially related work creation:
   __call_rcu_common.constprop.0+0x71/0xa10
   afs_put_server+0x213/0x2b0

Preserve old->addresses for the peer app-data update so that removed
peers are cleared before the endpoint state is replaced.  Also advance
both cursors when the old and new lists share a peer; activating the
old/new comparison without this would otherwise loop forever on the
shared entry.

Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
 fs/afs/addr_list.c | 5 ++++-
 fs/afs/fs_probe.c  | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 63bf096b721a..73195d76b481 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -394,8 +394,11 @@ void afs_set_peer_appdata(struct afs_server *server,
 		struct rxrpc_peer *pn = new_alist->addrs[n].peer;
 		struct rxrpc_peer *po = old_alist->addrs[o].peer;
 
-		if (pn == po)
+		if (pn == po) {
+			n++;
+			o++;
 			continue;
+		}
 		if (pn < po) {
 			rxrpc_kernel_set_peer_data(pn, data);
 			n++;
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index a91ad1938d07..8c62334dbfe7 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -258,6 +258,7 @@ int afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 					lockdep_is_held(&server->fs_lock));
 	if (old) {
 		estate->responsive_set = old->responsive_set;
+		old_alist = old->addresses;
 		if (!new_alist)
 			new_alist = old->addresses;
 	}
-- 
2.43.0

