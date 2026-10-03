Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BF3AB27B
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071086; cv=none; b=CGxXOmzss/jPstLHQL73DpehCMmxZDoTDqUteEqXiAqRzEfsr4XofLP4MwRuUFtXaDUNEB5Z5Dx3EW6Of3U6D3q6w936gQ5c/6O6z59dvX+XTtSshVnpif0uQUA1XIWk0Mt2+CZVZMtHcN3tR1KOklAHidMbs8C3ckMaQgVE+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071086; c=relaxed/simple;
	bh=l0uxk2qhQcKWpSkfl4d3IjS9jtbU7Q8p+LiqY2qT7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbJdfOI6DFM3SFWA3btjNxdSK+sB6rK5WNL6nDzXACT0dMU97vumZ0imRxDtJcY0h+/liGOVcTlxSU5C2u05XSp4JQZuBXBIHxUfSe+W0JxgIB2OyFYqeRlofWSJ7K3FxGDyJgasCeYnz1GntYHZMNEcyCuNK6F2MhYnG/nda2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqY0cPqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqY0cPqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBCE1F0089B;
	Sat,  3 Oct 2026 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791071085;
	bh=SNGGDKtMqKaZQ789e8Ty+diO14wxLGtAQY4nx6pEKhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqY0cPqq21VLuOZz4T1CUS+bqdZ1GLc0Wso8JCSl8Yuv01jeeJzuKBscA6bYyIxQh
	 zeZFNe8Z2/qg3alb63e938072I3dQVMgMqivYqp79R6WSQVp/qQhdORh0IH77f5ZvB
	 nsmR+BgbZ39xazoO24hn5GPEAIkwButFEyuQddUVLhd5uJgveKE3UIXft3NZVXYQyI
	 zHNa4mk4xpc/E6TsBvFI5bn+vz93WjRzwlGCHFCthZC3IDrVzuT0OVXY+CFJqbi1lc
	 TbMbqEwMlVDupTZziWUXg0mE5EVUkSHjqZo2tFeuWrPx0lI6zpTevhJB3oHiclqLUG
	 t/uobS0iDhPUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] kprobes: Skip disarmed probes when checking optkprobe overlap
Date: Sat,  3 Oct 2026 19:44:19 -0400
Message-ID: <20261003234356.710783-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003234356.710783-1-sashal@kernel.org>
References: <2026100344-anchor-outpost-f7ad@gregkh>
 <20261003234356.710783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Hwang <leon.hwang@linux.dev>

[ Upstream commit 7a39c732a22ec4a369af9e19fbe3d666ec83eec4 ]

On x86, an optkprobe at A replaces five bytes with a jump. If a disabled
probe B is at A+2, get_optimized_kprobe() stops at B when arming a new
probe C at A+4. It leaves A optimized:

              A    A+1  A+2  A+3  A+4
  A's jump  | e9 | d0 | d1 | d2 | d3 |
  after C   | e9 | d0 | d1 | d2 | cc |

The INT3 for C overwrites the last byte of A's jump displacement, so
execution can jump to the wrong address. B can have prepared optinsns
while disarmed, but has no jump to unoptimize.

Continue past disarmed and unprepared probes to find the active optimized
probe before arming a probe in its jump.

Link: https://lore.kernel.org/all/20260930053618.104498-1-leon.hwang@linux.dev/

Fixes: afd66255b9a4 ("kprobes: Introduce kprobes jump optimization")
Cc: stable@vger.kernel.org
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5b52dc2a34145..65ccc9cf40f9c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -485,14 +485,16 @@ static int kprobe_queued(struct kprobe *p)
 static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 {
 	int i;
-	struct kprobe *p = NULL;
+	struct kprobe *p;
 	struct optimized_kprobe *op;
 
 	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++) {
 		p = get_kprobe(addr - i);
+		/* A disabled probe can have prepared, but inactive, optinsns. */
+		if (!p || !kprobe_optready(p) || kprobe_disarmed(p))
+			continue;
 
-	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (arch_within_optimized_kprobe(op, addr))
 			return p;
-- 
2.53.0

