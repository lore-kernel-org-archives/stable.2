Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F381BD9C9;
	Thu, 11 Jun 2026 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194674; cv=none; b=uzjB9UM4DHuCvdycq7ExcLYrwR1Kd2XhuLclRK4MRU7BsrZQ5BHpMVoAg5avpAkQfcyBU38Wi2MK6Wf+6KWHIWMfn9NqDMx+3ZSAOp9uwceUUSY8VNjI09Zw38QGrJrpZeSP0jlC4FGSn3S2LTr8kKPaDT3LtM8JwxCho7h+G7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194674; c=relaxed/simple;
	bh=9H4V2pExes05I7O70GtQWQ5UQXp8LoyP47luW0j1+eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6IVZgdMi6EWqB4ES6TrqSsd5ajfgNdbXLgDw42WMJDLGcOgqQ0y1VrrixEGDnb/7ofJATM/PrFyZ5t7B+naE0+9e+jHmwennTOKcA2O5lP0S8spcwB37QNdEo8azE8JXddL1QUAL3k38L2H5bB8T+hAOGu76uT1kuEOAIdowY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACX99qj3ypqGsIZEw--.1776S2;
	Fri, 12 Jun 2026 00:17:41 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path
Date: Fri, 12 Jun 2026 00:17:38 +0800
Message-ID: <20260611161738.97043-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX99qj3ypqGsIZEw--.1776S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF47Cr1fCw17Ww48Cry8Xwb_yoWkKrc_Kr
	1rXF93Jw15Cw42vw4UA3yjvryYgr4qgFW8Cw4UKFZxCa98Ar15A3yDZrn0kF4kZFsxu3WU
	Crs5u3sFvw17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoPA2oqzjQvPwABsr

In do_cpu_nanosleep(), posix_cpu_timer_create() takes a pid reference
via get_pid() and stores it in timer.it.cpu.pid. If the subsequent
posix_cpu_timer_set() call fails, the function returns immediately
without calling posix_cpu_timer_del() to release the pid reference,
causing a leak.

Fix it by calling posix_cpu_timer_del() before the unlock-and-return
on the error path, consistent with the other exit paths in the same
function.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 kernel/time/posix-cpu-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0de2bb7cbec0..6f3ddb2b1f46 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1504,6 +1504,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		spin_lock_irq(&timer.it_lock);
 		error = posix_cpu_timer_set(&timer, flags, &it, NULL);
 		if (error) {
+			posix_cpu_timer_del(&timer);
 			spin_unlock_irq(&timer.it_lock);
 			return error;
 		}
-- 
2.50.1 (Apple Git-155)

