Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047962;
	b=ubCMb2xcNOpy+KRBiNUzzCCQloHTgnYRz1tHzMFrvi2RiukD2Etr199uwS3bcIfPhYPl
	 QeJZqCG1kepJVckVZM8G1HNvm8bDIMvQlUEbDH2QuliqHPCg/wg0mqGSmHuAapW2dwzYN
	 iZlGVqcU4pWBi6fGWbhyfm4qV09m+bIyECsGVTPGcgggIEK1jdz+O3qn0X59BNLx4GvNz
	 nuFwS7GYwGwyza99KFEk+5CBlBECb/8mKYfzGdD82lSNix34VxizQN9YTdVVl4ZqkFuJP
	 3B+xeP25K4AdISEC5wq8UKEPxjspkG65eW6rxq6zdn2ROM9oSGf85+WOqS4WVoMOtIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BbREymfa25Ua4MLq6EE2owKIAGl/2nEdAx8cf7Gxi34=;
	b=N/PnTGbzeUp8Yz/25tef0mZANbhC01H/6BH51cNPivojIgvHEXuw63OOVwTRAEKAtk4q
	 697qEXtIKSnagDr5KygECtLjfbSp+jSSMWp9rMHNK7i3zk/t3B67OIfOBTnOCmyAHv9Dn
	 QRHPl4AejvGXD/ER1tyQ4WuK9gM4IaX8WwrUwkf6qk+engGQOzkMBHGOHcc6D/jIlS8ji
	 V9HGMugdiqIGrx3lAt1FIDGYK5r/Izb8HMBiT91FdjOLNEioB+7Mi36YShzlhVrg3dgxN
	 lBMmPObOWm8NG2HvaQNJ0z3KJQZno89WRDjw7GjdCKgV4Ipfs54+D/B3hhef/poHIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1BGBn7q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1BGBn7q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADB41F0089F;
	Sat,  7 Nov 2026 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047961;
	bh=BbREymfa25Ua4MLq6EE2owKIAGl/2nEdAx8cf7Gxi34=;
	h=From:To:Cc:Subject:Date;
	b=M1BGBn7qBpWadT9heSTFYLktg6DJtXHJ0wajyzpsmkwyvkJ2Zt+igm7Hm4SeoN0BC
	 GyKDHzE6V5lhXW7ThGs1sFu8zIKIKtFkQQnHhvQFEYHh9uAjvdaZdZdhwzGQKyTZ12
	 Dnb4iqsKsGVSz1l4/pLE702iywHRn3CgC65pFbv5U7A/NueV13YfCwr2Xgy/dC4ZtO
	 3M2gmrXOp7Zoiz1guKpdMTomiYuBvkQS9K5y6w1goraMPgIq026uxZjy/vgYE8eOpU
	 aOAMN8gMZD/8WYch6m6cfiGOxpg8Sd/AAJ5ce2aSVDlepgiHvbiImYR7Lu+Nrzexfq
	 PC9yeMrVLdRcQ==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Accept NULL clock_getres() output in stubs" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:20 -0500
Message-ID: <20261107053920-failed-6.6-5b819071e434@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5b819071e4346256c4edbae5cc2095dff25694fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053920-failed-6.6-5b819071e434@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




