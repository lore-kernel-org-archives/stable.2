Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794449872;
	b=J2PNvmdBevTd+uIW/ddK1nGY994FA4AFI8oSjzKNH7m0niNXQH+evbyHDbEFjB2AhNy/
	 nw+DaUCWIpqjsXX8z8PoB9wlfKhUJq6tnd+0NK/MZXbyyzxnnaUNg5G+OzUy4AHfU2KAp
	 Z8LKEiu5QXFX/GEjlkCjIXzt0qMsqRkieqWCm8eGhXQOTTdt4wsOJByZoQE4urCKYOSwN
	 CM2p+bsBCZ2qKokRq8ojO9qq5TDTNoHTL2yVcSg3kiXR/tDHNSNLQjtKZKRUlv0UmZMqV
	 ZyUmWYgHh0RA4PxY67JNGfUAjPOQybn3oG1PMdUN+J59s6ccn6Jzym6DGyAsSkTrCiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449872;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=18c+l13wo1CDSqYQQfVUxqYZ3FBSaP7ISw6R2DTgxTM=;
	b=eHID6Irrbyio/Gl0K9P3165VieuO0ncLmlao+0UOuY3dlA6RdKzX1wzNSCxbdVSspXQg
	 9+9mP006PWKc4fp5GkviShTpwyv7lqCwLmks6tiX9B6lH0z1nxS1aKmLfkxESc3pJ/STq
	 KxV5Q8yzsJu5LQIUVGQFwr3n1UKPcaS2TShW2ep6TVPbRO5YypvTnGWTDbSrN50GKxdI0
	 EdNBBgVWvLHcMhc6IhNeheJuH86WeHY/Cs6ZZP1YrpWi8kwRwceiZYGtT4D0aJw6FHZh+
	 cwPreCVykaNLAJPHAFqxJuVsWkXt/i85J1y0BTN/19d2n1xI3PEYtH6USdB1TPUP1Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTJEkIcP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3468606A323;
	Thu, 12 Nov 2026 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTJEkIcP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794449872;
	b=VO8AbkDZD9xbYUtdDdbe5V64Q/mJQz32HD4bDWe/Hgy1OGkovRLDTSL8cU04HGtA7mki
	 KoOCA8HId7LH5xNgTZtkyQcHkau+g6UgoOX6UUjvjKa6Q6Nb8Ld+w8g5Wy2zvjI8QR/QV
	 LDskt8aQcF8XG3zla2P0lYRbu8zjbGhmlYsM1KsQ92VAxzND4Uoe0XJf9ULQFF40G6OMC
	 NEKfMjW+iLixh9kH2rF68yQmNueJovA8v30AwWwnU5//n4YfYYVNB/BT5sK+G21ZJUDQc
	 4N/4LZQMBFhQH0A+BQeYl/UOIUuQJGvr+3CTHo6qKiGuHRSFtMfQ5hMwniQwcjjvOag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794449872;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=18c+l13wo1CDSqYQQfVUxqYZ3FBSaP7ISw6R2DTgxTM=;
	b=ikxPWoY6yJkGEyaJ/eLjyjnFeX0c9V1Az6bXyPhmxHjaw0itknuGzjsUYJXaMZ4DNmxi
	 JX4MbImqhYS59i76QwadSjiweHVRK4lsb5mueA+Zm3z6/DOvdAYlAFsGXBeadOVyim705
	 mxtNfryP6qg6dKcTUexs40Uhtqogf9/WOmiA1cuPWRWDfhMDlyuZKL+xuM7KqACl3vTKL
	 WMWamgNbTwxa8+vwOL2wcA8PXiWBCmh9p0o4TfpalRH7OtXL3bEAtRIsBAgls6ommZKz4
	 Duq4qdWP+2G46dJgSts7Xsw1OsQf4v5Ef96qYcM2Iu3SV8HptqYyiLu4mdUqBGr0sXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 20EF71F00A10;
	Thu, 12 Nov 2026 02:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449872;
	bh=18c+l13wo1CDSqYQQfVUxqYZ3FBSaP7ISw6R2DTgxTM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=YTJEkIcPkbAqwEYUtMdd0la9sHj6frmrrgi8T9gaUflFiQalOmap1aRMxfDrTbVuA
	 TeXEi9KGXbxJqUlGSRYuTiNYd1AoxUKaBzl/hpsXE3HgH9iH8SV4wFw6Hg6NKSpNE+
	 WYSKCTLHaLiLI4WQXlOrvXi7UK82rNq2/zgaJyCJ5mGobfhVgqe+rM7BUwWBgn4HZ8
	 erTQ6Wq0HzpF+sDh2k9itQbuoGjpGbBVju4d0JYzp3YdRNYMqvPaN+ynY1U81kXBXI
	 d6o9H+sNFW3oJFsO7BbE0HG74R8x7tV/q8fOJEvv1sU5aYp+B+zU5RT9Zdtv9P55in
	 ZfDvhLDfQVx+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 776D3491D2;
	Thu, 12 Nov 2026 02:17:51 +0000 (UTC)
From: Zi-Hao Huang via B4 Relay <devnull+zi-hao.huang.mediatek.com@kernel.org>
Date: Thu, 12 Nov 2026 10:16:45 +0800
Subject: [PATCH] block: fix PF_BLOCK_TS/current->plug ordering in
 blk_finish_plug()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-blk-plug-fix-v1-1-7fa2a6215b8d@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAIwh9WoC/x2MQQqAIBAAvyJ7bkE3COkr0SFrsyWpUIpA/HvSc
 QZmMiSOwgl6lSHyI0nOo4JpFMzbdHhGWSoDaeqMMYQu7HiF2+MqL666s04Ttc5qqMkVuep/N4y
 lfLI0MNNeAAAA
X-Change-ID: 20261112-blk-plug-fix-f068b0223b80
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Zi-Hao Huang <zi-hao.huang@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794449870; l=2373;
 i=zi-hao.huang@mediatek.com; s=20261112; h=from:subject:message-id;
 bh=DSlAJhYD9b51DNkmYc4nFsWMsjAUVzpJL8gmeV8NUTI=;
 b=m+EwD6l34QlcaXVjnEekIZcWqqZn31q4Zy44HLlVzHKLacaYxyRPGRbpj9clW1DitiCgSrHUr
 HC7yeFeW3cPCofwB22Q+zt77gqTdpjrtb7SB2b0MLxpB+9+y9xEctQk
X-Developer-Key: i=zi-hao.huang@mediatek.com; a=ed25519;
 pk=tbMIVegYSSBtz5MaQSUCX9RJO88MA/AI5cbmQKbaoIc=
X-Endpoint-Received: by B4 Relay for zi-hao.huang@mediatek.com/20261112
 with auth_id=1493
X-Original-From: Zi-Hao Huang <zi-hao.huang@mediatek.com>
Reply-To: zi-hao.huang@mediatek.com
Content-Transfer-Encoding: 7bit

From: Zi-Hao Huang <zi-hao.huang@mediatek.com>

blk_plug_invalidate_ts() runs on context switch and assumes that
PF_BLOCK_TS set implies current->plug != NULL. blk_finish_plug() breaks
this: it clears PF_BLOCK_TS in __blk_flush_plug() and then sets
current->plug = NULL, with plain accesses.

clang inlines __blk_flush_plug() and emits the store to current->plug
before the store that clears the flag (arm64, Android common kernel):

  ldr  w8, [x20, #0x44]     // w8 = current->flags
  str  xzr, [x20, #0xaa8]   // current->plug = NULL
  and  w8, w8, #0xdfffffff  // w8 &= ~PF_BLOCK_TS  <- preempted here
  str  w8, [x20, #0x44]     // current->flags = w8

If an interrupt hits there and preempts the task, the task is later
scheduled back in with PF_BLOCK_TS set and no plug, and
blk_plug_invalidate_ts() writes to NULL + 0x20 (plug->cur_ktime):

  Unable to handle kernel NULL pointer dereference at 0000000000000020
  pc : __schedule+0x108c
   preempt_schedule_irq+0x48/0xa8
   el1_interrupt+0x48/0x8c
   blk_finish_plug+0x6c/0x18c
   ext4_do_writepages+0xd3c/0xef8

The window is only a few instructions wide, so this is rare. It was hit
at cycle 127 of a warm reboot stress test.

Add a compiler barrier so the flag is cleared before the plug is
dropped. A compiler barrier is enough because the race is with
preemption of the same task on the same CPU. With the barrier, the same
build stores current->flags before current->plug.

Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>
---
 block/blk-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8836c7028568..ad2a8e4fe7a8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1299,6 +1299,12 @@ void blk_finish_plug(struct blk_plug *plug)
 {
 	if (plug == current->plug) {
 		__blk_flush_plug(plug, false);
+		/*
+		 * blk_plug_invalidate_ts() runs on context switch and expects a
+		 * plug whenever PF_BLOCK_TS is set, so clear the flag (done in
+		 * __blk_flush_plug()) before dropping the plug.
+		 */
+		barrier();
 		current->plug = NULL;
 	}
 }

---
base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
change-id: 20261112-blk-plug-fix-f068b0223b80

Best regards,
-- 
Zi-Hao Huang <zi-hao.huang@mediatek.com>


