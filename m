Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046485;
	b=cEAeyOK0oWmMtChX3Szxw5WOykz7GoYh8EceZGxJOyh3cFufDfuuyV+W6//TH3TR1/M6
	 j+LroW1jjlQXOIF+dDd96ZWcxwk0x0S80KL9sCt/aDr+qtQlgg3trD1A8EtA+5qsbafnh
	 +N4S+oU68139OLSXF3DX5Po7ggjrKvziWIzrPY7WSHpc6DdbIpiDX3FISNYZkU1WOCmwe
	 ApLGeSt7qzVUblyfxxP48Jjd27G4xWiBkXGMwWLx36esXyza7JrIUTN9JZTtC/j353gEt
	 raKJmUDK99OG6/zj/R8WLFNOHGZLpg7OPrQxxPuu54TvXUyH2C8qY4jdU2RhBL8cqUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RX7mW50jKTwI2nNoo8HVhY+0MYrjQ5F9aqTK6H7/OYE=;
	b=uRtQeu6RIn9Y0J643RaJmmHEEe/6P9doc6XgD9uAGc80JcBmW9FedZwkJO4EjECBpefS
	 /TlhSkEQ4g00CcMe3CPaDijB88uwTFEj73iFjz1YukvwVA6TjxGZUEl8mvfy92c4VNfEe
	 kgkDIqkwsMj2yL+aM7cGZteWiBpxXi3Ms533NJrysUiG3kbo6bro6mV2n9DNDtVabe5B1
	 SVwO4xVbRulWgG12FM1NQKqbSZ7cSB7I2E7+OPJnMxvFBNhBpmuLHeNG4h7yn2nnxfFDh
	 ZPVbTrJaG9ThfB1NpkZtgNjQT5cn7FV55PmARRsjKQw5JwFFlau821HmVBYsn8mQpAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deWnD+zD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11ED606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deWnD+zD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3916D1F0089F;
	Sat,  7 Nov 2026 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046484;
	bh=RX7mW50jKTwI2nNoo8HVhY+0MYrjQ5F9aqTK6H7/OYE=;
	h=From:To:Cc:Subject:Date;
	b=deWnD+zDsW/tqv9AcEBy0NZLBWqB2/WFO/VhyXjapedwcrD0f8v1EJnAJyl5INw0j
	 BbLydoeqeWMazH7aT5n2/sOCWfRHaDXPP31OS0YWlJjByu9yqzGuAPnazyub2yL6NW
	 XzQU8NQ6k6lujV0UDzQ8rSKLoupfsLgL/r6e8M/RQrodASZsTHNKEbv9kvesZJOCTz
	 QfoHQvlOXQfdttT4EGXUw+EWsQrZHPaZe+nvqJSl+VFF9j3WE5TKFDGyaavYA1lRhZ
	 qZTmkB+evSvYlQyCeyqP2BAu8BBEIdRMuGhF1CjNeWjinUE6bjD/ATrtU5bVh9iLkr
	 dnPQaKdP2v3Jg==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Accept NULL clock_getres() output in stubs" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:43 -0500
Message-ID: <20261107051443-failed-6.18-5b819071e434@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5b819071e4346256c4edbae5cc2095dff25694fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051443-failed-6.18-5b819071e434@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




