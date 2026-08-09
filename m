Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB41EE7C6;
	Sun,  9 Aug 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302299; cv=none; b=MU8RUeTCJjo7wr/7l/ZLLDZyB8aZ2WIBXhUT4Z/i/7CxCLR5zSXTu+OjEky8N5KImQdWPXrmur8WvImhV3gIRgYN0oedPIuNhcql0itsUFERlxh0EeTBtb302ajIsIFJYBMtfxjiHcyWuAdZOYwIuy6SZlYcb8Y1A0Mpsj62A7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302299; c=relaxed/simple;
	bh=RO/3foGp57kquvm5Lm2vr3q/dhEfuVMnOjDS3lVqlSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aLI+Jhg/wjnrN9SBks9Nji/8Bqsr/jb+5G6ErZ6Y7AXelQcDNxCbya8cNOYnNC3oY1FOswavtK9kWltdsKJa0FZL6cSOSZfSL83PaY1pT0lqdt3P5OMvZCFVqKIMt7vv3b+SBRaRODokgRHsdomdngCkifOxSZjkv3KkEc/ESJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=EsW1belf; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="EsW1belf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FggU2exK523dQ8wGDBzT0Sk2IeDvCQF8caJHLooR/V8=; b=EsW1belfIra5T+4/v2CHYqh1aQ
	ziQ+uM/+mIpyCQSevIW52kubbRZon2nmFEMvUBJ4yBK4W5kG3+GYRRXeKLCE3R3CEk1Dq62b/G6Hk
	br8/90BCmYErnYsdxE5S3bo0AAx0/vB9joqk06q7DBveIki4Sj4blbYW8fAQjImlF1Qz18L/OGJs4
	f1Qu9CpRD7ZiqnwEQAZ8EnWJsvoqohbIp+wmst76nsaPPgl6IO1GqwTXIdn5SKo9T85xykm4NhCMI
	HLg6vbYKhfZsj5XeOZllSh8xnwPIaVxYOLUDysVl42nTTXjPBkOSg28Z1/acUGWOwWNPPi1ZK01tH
	xm0ald7g==;
Received: from [151.115.150.205] (port=53232 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wt8p9-0000000D7ck-1iZE;
	Sun, 09 Aug 2026 21:04:43 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] timers/itimer: zero-init old itimerval before copy to userspace
Date: Sun,  9 Aug 2026 19:04:16 +0000
Message-ID: <20260809190428.1523014-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On native sparc64, struct __kernel_old_timeval contains a four-byte hole
after tv_usec because tv_sec is 64-bit while __kernel_suseconds_t is 32-bit.
put_itimerval() fills only the named fields in a stack-allocated
__kernel_old_itimerval and copies the entire object to userspace, so
getitimer() can expose the two padding holes.

Zero-initialize the aggregate before assigning the fields so implicit
padding is deterministic before it crosses the user/kernel boundary.

Cc: stable@vger.kernel.org

Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/time/itimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 7c6110e964e7..03a32dffc56c 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -100,7 +100,7 @@ static int do_getitimer(int which, struct itimerspec64 *value)
 static int put_itimerval(struct __kernel_old_itimerval __user *o,
 			 const struct itimerspec64 *i)
 {
-	struct __kernel_old_itimerval v;
+	struct __kernel_old_itimerval v = {};
 
 	v.it_interval.tv_sec = i->it_interval.tv_sec;
 	v.it_interval.tv_usec = i->it_interval.tv_nsec / NSEC_PER_USEC;
-- 
2.47.3

