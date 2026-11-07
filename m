Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050939;
	b=IXm3JwhqiJ00aiAgqijlmprPU4mFn9QFWzpuiFx/CKUdEMTAaceuzmi5rSkjOwgju76C
	 gDwEpqHzkRGmvHdrbZ0eBRO9W8NRPDPFsEiepqeyJwhyp2mTxdxGBm0eGvnyHu6zqj7JW
	 F9qgHFAe+A/B9lvzyqzHXE0ZdUn4yuS5/CXMZiBfdXJvK+BEtfKCQCGli17QrdIW1r3JH
	 PZhmjYK7qCaZWyxEivflONvO84SFdIQSMfTDbX84tcwHZTyTG8DbOqzckv892TIeuKI2q
	 ye0XLX6YA484V3uOWZhapOR16zIDIN4JVFnlE9ig3ug9TPUtWGQknSwNrrK9wsli90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VHtqd+PyfPYCm9fzK97RB4QueeNQsTAdNqAUOb1zQAM=;
	b=X+jiLmFGSV/QRtd/5eyzBD2IwCgqprXNh7bUX96XGjYwcemlv93i/zyKazjLDi8jh6iH
	 yXAzVrX00zVmMvJEVyqHpJoGeSZQu+5gZ81T/DFkMmCT4Kf4yPKkKDF0xIJlaSqDvwUyF
	 bj3gYhXws8P/jCZFGrnTTPTYZDmPsDBbAyP4m9wL0O7qC8730lnF6cBfRYiXZEJdBx8Sz
	 /zUIQL0/WozNeYba6hM9BTulhq5v6mUbq/aJwSVA24HtWtSOrYjnthn64zO09+FsXyfO5
	 oOV+I4PZ2eNLsoOujZvexMhDZEpQTWWvZZeN66J0mWNJm+zwYXIShcssinPCJoLFohg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G410Dtb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9C606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G410Dtb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DF31F0089F;
	Sat,  7 Nov 2026 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050939;
	bh=VHtqd+PyfPYCm9fzK97RB4QueeNQsTAdNqAUOb1zQAM=;
	h=From:To:Cc:Subject:Date;
	b=G410Dtb4CR6iNcCLuoRP1uB8xm+KwYzCRbEXgpxoO/mic6ggPU6qP3B+DkUYZTkBj
	 gLKur51d7vb0TnT5AvvBvV5Ok6V9Ax6MqoYXl90+4bq0iD0C/MxO0CbTJwnJmYqd5q
	 cfG2S9HiePKtjy51pT8XSP5MhNf1HmoV5uwSIiI3TCu7JENytbaT6ao8uUhIjJNZoK
	 EvNbpz9ZvrsQlX2HDuTbpWaMiF0ZSWmXV+vc47NROmwVUS+0sfbNwGK6DeTV7f5tPC
	 vz1sXTopn55MJ2K4xm8rZHQUE7jglwkIw56hz5/5d5+OM9yZmoEY+FtwlcNjcEcxbO
	 VtIZWrc7jZa0Q==
From: Sasha Levin <sashal@kernel.org>
To: peng_wang@linux.alibaba.com,
	frederic@kernel.org,
	herongguang@linux.alibaba.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tick/nohz: Reevaluate the tick for kicks flushed outside hardirq" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:57 -0500
Message-ID: <20261107062856-failed-5.10-e389ae428847@kernel.org>
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
git cherry-pick -x e389ae428847a2e6a3b698b5967df68ccf90361c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062856-failed-5.10-e389ae428847@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e389ae428847a2e6a3b698b5967df68ccf90361c Mon Sep 17 00:00:00 2001
From: Peng Wang <peng_wang@linux.alibaba.com>
Date: Fri, 23 Oct 2026 22:51:00 +0800
Subject: [PATCH] tick/nohz: Reevaluate the tick for kicks flushed outside
 hardirq

The nohz full kick relies on interrupt exit to reevaluate the
tick. However, a remote kick can also be flushed from task context without
an interrupt exit guaranteed to follow. If a tick dependency is set or an
earlier timer is queued after the idle-exit reevaluation, the required tick
update can be delayed until another interrupt.

Reevaluate the tick directly from the callback outside hardirq context.
Keep the existing interrupt exit handling for hardirq callbacks. The
offline flush remains harmless because tick_sched_timer_dying() has already
cleared TS_FLAG_NOHZ.

Fixes: 4b44a21dd640 ("irq_work, smp: Allow irq_work on call_single_queue")
Fixes: a5183862e76f ("tick/nohz: Conditionally restart tick on idle exit")
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: He Rongguang <herongguang@linux.alibaba.com>
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261023145101.8217-1-peng_wang@linux.alibaba.com
---
 kernel/time/tick-sched.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6c3fea3867139..baa3ac9b48f88 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -400,9 +400,21 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
 	return true;
 }
 
+static void tick_nohz_full_update_tick(struct tick_sched *ts);
+
 static void nohz_full_kick_func(struct irq_work *work)
 {
-	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (WARN_ON_ONCE(!tick_nohz_full_cpu(smp_processor_id())))
+		return;
+
+	/* Task-context flushes may not be followed by an IRQ exit. */
+	if (!in_hardirq()) {
+		if (WARN_ON_ONCE(tick_sched_flag_test(ts, TS_FLAG_INIDLE)))
+			return;
+		tick_nohz_full_update_tick(ts);
+	}
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
-- 
2.53.0




