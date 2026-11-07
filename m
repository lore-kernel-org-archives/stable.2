Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048903;
	b=WyFoSg6OIhTL0Y56Gkoxj4I4iDC1focwsiie30qLPHgwTFAszRlKLJMgC5hWqepF6R32
	 ZmXIl/7B5IdbmMairHo6MA8XljbCuFq6AZWuR0vVQlrBnXMWaZRA8ue1iLtawsQd1sUfF
	 q01Qb3EFujKls0fJgKIGtUE4O4c8HYh25+sUq7xiUCteK56OaTumJcOWrtpnNpTg4Sd9B
	 8eGdN6rl40va70byjMhF/4N1zExaH4L5vGCPV1kiK5TRuVJxkA0V1SOHUajUKvrCvUnLx
	 lRVtSk6keS03aEHiK4HuBoO+NqPePyrAROKbT8g2hsrJTZhQlDSO9fWS5EWrJi/T5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048903;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9ZlyMMJbKPCE96tHU9arN5fO+cAfLr4BQ9AG6Mjfqxw=;
	b=ANfxwVGRaLdxNWhkxo76lEsxfXUbjTh9Kbc2IBnerdp08dpJ7r/bbJawLUbN1doBQx0l
	 g98pikcu6GCXe/F4ODJaA0VVdxZkMigngYzBwZagNELBpD11bfXJ0T6cO8RSQj6YtT6e/
	 YGTA9SndN31iqBMdZxRpvWtCohOrS4PylMlvHEp8a09qoFmYLhOWWFYo8Wk9QfTcsGAm1
	 A1Z6iPV6mjNS2UO2/LkS/RgsF1YnTiQ/xTlyADSbzh2uhNN9slPp2dqlyDOWj6MvV72Oh
	 eajB241LK13kuErGtaJY6BVZHKEVarfkyzBaPttVjPaqCRgjWK4tiU5wAPJCvELtQ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uu/ruqqw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F75606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uu/ruqqw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56BE1F008A1;
	Sat,  7 Nov 2026 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048903;
	bh=9ZlyMMJbKPCE96tHU9arN5fO+cAfLr4BQ9AG6Mjfqxw=;
	h=From:To:Cc:Subject:Date;
	b=Uu/ruqqwKztXsv6WcaFJWHLNTSwLWzyBTiaOvBymej5FaO4sR8CVuLnhcBzK1C/TP
	 FQL0BSGcvfSwrN7qIDbogf8ytEkZ8z4IvKiHpInadQVzBdUUziGdB6oU8nDZN/fNdN
	 Zs4iNezGSeGHZY19asQPmd5ooFyh9QW67Ug6En0UhHmGe7/EPlQhMiI2UA1tYN4lLT
	 ORqip4KtSkAsGHfPm6jGudD8rkJxexn9XdhKxbpNCJJGKpDGpzzZ9aU6383AJEaswH
	 +SrNnn8aetAD7q+pfBTtWGmeCE7acilUyUx8fvyYp5zNPfKbzPZN3M8sLpJY3MPTzM
	 GN38bousPibzw==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Accept NULL clock_getres() output in stubs" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:01 -0500
Message-ID: <20261107055501-failed-6.1-5b819071e434@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5b819071e4346256c4edbae5cc2095dff25694fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055501-failed-6.1-5b819071e434@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




