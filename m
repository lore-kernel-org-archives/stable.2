Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049917;
	b=U0ZLIga0ngzhTfP6F9bVFe7p7VqeQl9TAi7D3ub/lz5FYvgS9Fv5uLcIwTiLAeNqFw32
	 h9GzFF+44VV3PRzWObezg9ibI6K6opwpJC9hmTVVCWHmCMPWFmcS9JKNQ87LsLzIESRv3
	 pqO/NzEcnkHCVQkwlVsKkf74vs6wg2Mu8UZ3D24WsbS1FQ2HOdfCAAJFMKjDWPEILFEo5
	 VDfFLhLgSE9zH2gkzSdSaZIx5RpiPBRaJUHZTYRg4eZ4KGjYb+IOILx8wxttpgHZzF6KX
	 LnwiymoVAugztRmFzigXOO8yem4jWL4mYavk4Y9QFsjIQkSGrtxjfB/KPdmqFmctn3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049917;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DBd2ei7sMdEXMsSmlOPcjM64XOxarooUfWKp2OKeozA=;
	b=0j7YiNGa22dsqsssX/HLaPvkDDs6zjP5tfM4xui/j4c6VgjRxZyBgBL1HUSU3mgqPNZk
	 oGuXVa3y6HsOel/C9X19w/SGELRr7cGhQ+950RDkdqpGZzpl/a4lfNp7WOkI762F8WaUS
	 zcZ7Q1vLROQR3nUmnTSPllYOYBj7sDHklhBM8ybgBsG+grCUpr8aprLs/kj/EwRHwq8VW
	 GrBP3vgOeOZqQArtuwl3Z9N8PhuAqlAy8tb5iCwZRAnmwllHFPRQLaaWfgKcNrae4MQRo
	 rH5o8ceMfnxS1KFOsxnpt5tINWdjaoFfiQw9KzNBHSqytJyWfMBKDvyGMC49Ib+nRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUboDuvu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48719606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUboDuvu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AF21F0089F;
	Sat,  7 Nov 2026 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049916;
	bh=DBd2ei7sMdEXMsSmlOPcjM64XOxarooUfWKp2OKeozA=;
	h=From:To:Cc:Subject:Date;
	b=MUboDuvuOmR2OwIBHOiCNH/bY7Z2Dz5UmjIz7AQxsRtC9xCBdIoa035Whc1/MpxHF
	 ffQIcSoYql75GIp2NjrRmW5seKVv1DV/h2ADFNu7WLn6Fj3RqtVmBmd2HSKqttOSjg
	 RAIQcvs5M2pRs+oRO16DLhpMqM703kOSfrr+nDzKeL4r8BvWXqBUDL7EDz85iBn8WV
	 rhCi0MtUEcz4j3szGgZfXsBmThb/YMNgjvYMyOx2iJW54iO4I9kJjEig46KTTBgDre
	 h5mXzHE5oR/gRNdsu17/SkR+7UvavYpZS4C13c8SmN4INTvOzFov7OKuz8iQ3oDSgw
	 iByQATulBATcg==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Accept NULL clock_getres() output in stubs" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:55 -0500
Message-ID: <20261107061155-failed-5.15-5b819071e434@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5b819071e4346256c4edbae5cc2095dff25694fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061155-failed-5.15-5b819071e434@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5b819071e4346256c4edbae5cc2095dff25694fc Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 20 Oct 2026 16:11:21 +0000
Subject: [PATCH] posix-timers: Accept NULL clock_getres() output in stubs

With CONFIG_POSIX_TIMERS disabled, clock_getres() returns -EFAULT for a
supported clock when the result pointer is NULL. POSIX permits a NULL
result pointer to suppress returning the clock resolution.

Only copy the result when a destination is provided, in both the native
and time32 stubs. This matches the full POSIX timer implementation and
preserves clock ID validation.

Fixes: baa73d9e478f ("posix-timers: Make them configurable")
Fixes: d822cdcce43f ("posix-timers: Move compat versions of clock_gettime/settime/getres")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020161121.85042-1-dennylin0707@gmail.com
---
 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 9b6fcb8d85e78..5a27335a917ec 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -83,7 +83,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -166,7 +166,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
-- 
2.53.0




