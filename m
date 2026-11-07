Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050936;
	b=mHMamtWAyQLeA8RG7vttteZNUuLWZvrD9PbwTnYW8bdC5lunn2DiuS6d9c8sWRzA+lK/
	 uovTqnF7bwTcPJzOLaR0x710XXpvmHFrMQDXJ9i6OQQ7CPuFHqSVKxsca56TTnmho+IFc
	 1sG82UVyW57ChifK2sUJMFcdulceahCavfsm1wp/SoaE3LU/j4urTVSCRy7tdqKGM2iOa
	 MxKM6y06vVFcSa2JHSnCVWNe2tB41G+eU6RwqYtVjrnMZ0wiSrEq6ncOr+3RoVexDDkpd
	 mokGJrj85wHeDol5TW3jYnL5vNhh43E7Xc8D2jKHB51eUJNXS5/9jMwaqKEPl2sCaQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=80IRSIZxiM5SiB1daAwBXu2APmFytFUplREAupxNgfA=;
	b=ITnAVvrWqUZjgUtJu/X8XTkBuvkwDVltLiGx1mWVE4j5tFFUDRxRoYOWah9HGBqGdQsy
	 TjKmGjfE3DiwxeOLg7tSVS17ZEgE/qzXqLJWvslmMv99FFcuR6ltgZxz4+5OTyPdUAjJp
	 kvklg5DGby1hlQT7ithj6gPMPWABSaY4NbWNOejtsDW/2OscBcAV+uXbUkOTiFhtTAxHo
	 meekhcczu3X5glR7lkh6QSAm9BUxsaOzt/uzeyRNnZPR4M6S5hLIk519xVbKCGTqMpnXS
	 RvrOepYeBqYJBcTDNhRMU/sZT2yPiRX4NPShTsnIkou3oSRZKYC+/4TmUuzmGKpTKNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsIFsEPK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C0606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsIFsEPK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735F1F0089F;
	Sat,  7 Nov 2026 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050935;
	bh=80IRSIZxiM5SiB1daAwBXu2APmFytFUplREAupxNgfA=;
	h=From:To:Cc:Subject:Date;
	b=jsIFsEPKlDkISBYd+q2xeU3EnipBEnD0DnG7qXfzY7kZxmQ5kO8NQjMPDDDByitlU
	 u2P9C/gv68ua2tN+k9OmdD3HvjP8SJGCYTgnNsbWXPKsWF7zUi9iLTyAuW+U7W6cEQ
	 w2e4254EXY7toHgyOuYrqrXl1aZONVszDAc4sSCH8zooZfC6MgTrSWYk1F887zl24r
	 MOLtMeAFoIpdYcX749HFIoP5iI4aALJ31BrpxEolvp8nqzkTOFg58hakabCXB2RSHO
	 bdqtqqH5zCpcAEL6HTzhrOI1nAUjZaFAPg4qAGZ+1CXda9lTZdKfeLGdLO1Y3R2a1v
	 ZqcK/eqbuRBMA==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Accept NULL clock_getres() output in stubs" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:54 -0500
Message-ID: <20261107062853-failed-5.10-5b819071e434@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5b819071e4346256c4edbae5cc2095dff25694fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062853-failed-5.10-5b819071e434@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




