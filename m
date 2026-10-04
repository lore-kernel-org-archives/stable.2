Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDF8834
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791072535; cv=none; b=g9BENq2bM9IZexozNmSJm79vkN93mLz/IIzqMT/02nTooaD6fOtr6VBMt4UZ+XYwlnVYgQAdCL40nIaNwpjekiPeJdu0aI/mZWfeBcpvAB3OWyQjKPB+L8IljGUc/F+zTlUAVDfHcC1ckd7Z5zsIer5l1UQfvBWonaJWRmmKOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791072535; c=relaxed/simple;
	bh=uH/OZDfXjfIQnq0CvQMrjL3yoDJGS78m9u+ojX3UuEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgMKF/fToqGuQxDrzX19V7nz9XJtx40bTOckdOPwjM2CAcGoma9IXaSe7HtG7NLCI7KLIOHVzRtiJ4Pc/tLjfP/YxOGs5VOe++Bw65kjGcIAftvWpsB/wQ2EN6hXfuYfAmZsg9P4Uwe2CgBuc75xrTQ/2p8SlGmfXIGRQZe87wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aucP4gAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aucP4gAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72C91F0089B;
	Sun,  4 Oct 2026 00:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791072534;
	bh=w3UpVB27Nc65FuI8QwOzKH93JAhubgQDP7zZYoP2f/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aucP4gAcJnwB+FYO7nrDdlAQzmzriLa43bzjVmZiZQzsKHF/ux29Wp8JBPxMoQTDM
	 WNCWW0xoQzZ1ip+wPNxQ8uCa8Yv+p/xfD3w/ATTmDOATi2VrD6fFCtR5TdHfqHLuib
	 QtO8FFRONhjWS0MZw1zowvUTu+bIzFaKWbwLpnH4QBMAFgCwrwXGyBq0SNvwNOz5dn
	 inALf5Srq0i7aDP67cKWlGbioAN56c9hic6iq1lCOzETz17hPmroPZAzdQWu2pfGvA
	 +Q4Neavb1hvfpITRSdqeWzRWMlRuU/XBB5PmxYFTJiBERPi1+Eeq2+yH+8+Hv0Spnf
	 s7IxZwsw17gLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] kprobes: Skip disarmed probes when checking optkprobe overlap
Date: Sat,  3 Oct 2026 20:08:37 -0400
Message-ID: <20261004000753.1184782-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100345-divorcee-other-8be6@gregkh>
References: <2026100345-divorcee-other-8be6@gregkh>
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
[ sashal: Adapted get_optimized_kprobe() to use unsigned long addresses with byte-wise scanning. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 46398072b5bea..4f2d0638644c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -481,14 +481,16 @@ static int kprobe_queued(struct kprobe *p)
 static struct kprobe *get_optimized_kprobe(unsigned long addr)
 {
 	int i;
-	struct kprobe *p = NULL;
+	struct kprobe *p;
 	struct optimized_kprobe *op;
 
 	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH; i++) {
 		p = get_kprobe((void *)(addr - i));
+		/* A disabled probe can have prepared, but inactive, optinsns. */
+		if (!p || !kprobe_optready(p) || kprobe_disarmed(p))
+			continue;
 
-	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (arch_within_optimized_kprobe(op, addr))
 			return p;
-- 
2.53.0

