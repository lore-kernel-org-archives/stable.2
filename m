Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794969134;
	b=357lp8HXa4Bq9yAMCc6ussvvHNkCOef1nbr8qoj6JE/S+hB3sBzM7GA40JJVlwKM5uGu
	 88097oY4q3C0/TDpns46qZPUbS3rrGaI3/GPZ4mmBdztZbFqfhD4SbaYdRg6RZj3FF/Tf
	 H9NalibagMA2NfNA1lWqD/SbK3/oCw9UaBXX/1WEpwNDE3gI8b05Ejpw+Ffup0ec7tOSl
	 Tpq/CH9DAH2uJ1sEegMwIqhGXPyk9ywgI/sHE31JaVkwQdzT9Rh2w1+XNWHL9OUfBSaCi
	 EJGvos/kcZOLE0Y72qLZk4nt0PUQ504oLCiKX6z87Vbc00MzCo8XpNTsXmESRb5ydHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969134;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g8HIvnqqvGqRI0REomTZZBB1KyLjsxfTvtaiObTtY0o=;
	b=cPmNV4kwJfq+YynInDa+JYOWe/8eSxaeSfJT9Zq81QiUhvSe5kF+IlJFlPgyhGc+ujdv
	 TCUaZjAqNW0E3Lv4m/2/K3MrP3LcZ62gOAOJUU4R+IpZrsIDIn+jmofuNqjWrfEJ0Lgw+
	 O3T4ZzsneJwYO1NC3bRCnAb8ov+BAB4cYYXOFUxj3kC8c55/ND0pNxBs+ai1ddJ+PxwTU
	 Rtpmaqb5GhPumi/XolCCS9kl7suiQX9DKeOhJDD7wc9zStGYR+WzP+4TywiDGUmeRGFGx
	 ybQL1YJqp3xwK/DbW3Fozf43VQusli+nKEEmVTqeCl5ZOK83OzV/IsIKG/07fJZy0nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYWNqaoT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303A606A325;
	Wed, 18 Nov 2026 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYWNqaoT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794969133;
	b=PgdDmhcu7yv0d+zWQgAKG+SY/0byijFs7m0C2UBu5YNmkxqtsqxqb5ydSI/72lK/9GdD
	 cHLZ/jFQboO5irkJZemnH/Bh3+r8dkzkNx3DDNmMCLi1oq4cdN2hZE4nTjOF5UzmkQ3pe
	 v2jakp6s7rtBzD2w2wKtXYSnbQIDtUsbkpNAPMUsF9Z1zSOvkhH0NFQ05NcNip2Xh3wW2
	 geZu46sCNQw327EV+FIAHxzLGJvGGHm9gDubKxt1Er0qYa9dJjbmoyo0axCQ9gIk+4F2u
	 rXDEd9UXBNKGVHcsxGNyjsHKuiJQswSK1Fm+ubTFPnPUYnp2wQGd9cnKirEjLQSDEsg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794969133;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g8HIvnqqvGqRI0REomTZZBB1KyLjsxfTvtaiObTtY0o=;
	b=l20cCV6WN6lGPVayBZGI+vc78bVPibwzzdgnK2ArGQI6A1u+wjGeuSqtSaYHoUQknUmy
	 Ozn1b2pObMrTpNWe1ND6YLUr9p4/FMSxqLs8OxDn7UV0ciarESazq0V/K7KokqvZcQ76U
	 7kSC8jLhUJ7KMxVYSfdAPJxpuXFaIVL4Xi7KQCat0xrW/C/v/i01FzMcT6oxqt8aGp0Cx
	 8Sp50+uXScsBaxO2cozRNDw/NujM7DJ+9Tppbb5H14X0xy6urdzRtb9xD75NZ8BO1I4QN
	 9aa75UXX+ZQTwJaZPXIWzu5isLZPj3iVDmGzmhW419iswuYT1rUIHEcpABVAGL19sYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 370381F000C5;
	Wed, 18 Nov 2026 02:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969133;
	bh=g8HIvnqqvGqRI0REomTZZBB1KyLjsxfTvtaiObTtY0o=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=AYWNqaoTUpFohkx9Vy8klujvR3usQqbmB7e0XT0tmcomnoCfDcA6e01O1RJbIOI2H
	 Z+uQN28OcJW6IRqN3rGl4t0OjyZyVuqFFfCeRqo0/2890yKrgpp/tVXIcD5RrTqcOT
	 c/tBEmJIIzlNzzAo8jLTpKd6vAUT1aI/JDPPWv1MI9mBUohV9oku2t3M5Q3IuwvmJW
	 hAc0ARQfwVyjB3wkbME3SUPDeKQxmTKHm/xm3DIKS6Ts7IRJ5h4y4rqz4PY1Ko59qt
	 5Sp7Y4Mvj4ZbKl7sSc/Pj1UabPRDeWxIfG1liRLQiYnSqnSgwhOhYq7ozPvie7RYHf
	 PDk227aefbDvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8AEA54ABA8;
	Wed, 18 Nov 2026 02:32:12 +0000 (UTC)
From: Zi-Hao Huang via B4 Relay <devnull+zi-hao.huang.mediatek.com@kernel.org>
Date: Wed, 18 Nov 2026 10:31:42 +0800
Subject: [PATCH v2] block: fix PF_BLOCK_TS/current->plug ordering in
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
Message-Id: <20261118-blk-plug-fix-v2-1-4acbeec5d512@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAA0O/WoC/3WMyw6CMBAAf4Xs2TXdNSLx5H8YDi0ssOGZFomG9
 N+t3D3OJDM7BPEqAe7ZDl42DTpPCfiUQdXZqRXUOjGw4ZyIGN3Q4zK8Wmz0jY3JC2eYL64wkJL
 FS9LH7lkm7jSss/8c941+9s9oIyS8NZZtznR1Rf0YpVa7Sn+u5hHKGOMXW3GED6sAAAA=
X-Change-ID: 20261112-blk-plug-fix-f068b0223b80
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chao Yu <chao@kernel.org>, stable@vger.kernel.org, 
 Zi-Hao Huang <zi-hao.huang@mediatek.com>, 
 Sandeep Dhavale <dhavale@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794969131; l=2708;
 i=zi-hao.huang@mediatek.com; s=20261112; h=from:subject:message-id;
 bh=yzVnLTZw+V0byMgdM9XGWdyVxiHY2j5nto3cl5zYTUw=;
 b=YreCA/+/lxEewEeUdbmQqFTXZK9vYT/ZIJn38ItYb2h92mIT9j114TDFWBTozc6GL+lHZXlrX
 496eudRghoJCRE0IrwkTnO0nnGdLBh5hc83YVTYF2yVzBYdKYnAh0Mm
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

Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after task switch")
Cc: stable@vger.kernel.org
Signed-off-by: Zi-Hao Huang <zi-hao.huang@mediatek.com>
Reviewed-by: Sandeep Dhavale <dhavale@google.com>
---
Changes in v2:
- Point the Fixes tag at fad156c2af22, which dropped the NULL check and
  made the preemption race possible, and drop the stable version
  (Sandeep)
- Collect Reviewed-by
- Link to v1: https://lore.kernel.org/r/20261112-blk-plug-fix-v1-1-7fa2a6215b8d@mediatek.com
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


