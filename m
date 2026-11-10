Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274037;
	b=sQgFy0hgS54fjAuE2KpEFudi0yOXtEGSLJuk4dTAbi/cYlZWcHBMW1mDK+axrZ1+YIgI
	 0vCkV5VAz2QJdZrFBO55K/VpdGgt0+Xfb8a57eghn785ak9FaNJ1LnW0K6gIkcHySkjFv
	 V1afYBB4RJ04CTJlksLQ+L2KrzMhANK6+X+QQJrXK59sJQuP8N5EUhcX4W8oJdGtG8p/r
	 OX2NF3pOD32gOkJEvVWlo2/+d3y5pLcsAJUm+5shpNWy4h75IaJjijmowReYfPezP2Wjn
	 VzPHa4v2PDFizvtvNbfEL2CB6iZgw/izrrCjouzCTkQm/Dcmz8lgmzeNG7bpKwE+8bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yLurggnjcKT46vHBwGyu4zeuN40bts1EDHVYkSzvJK4=;
	b=mg2cLtS/pU5y4vYigwEDGjXyHor/pBa7upnr3iGHrpxWZMNgipB1sdGumsjaGdOWT+Ke
	 wcCmT7DxbWXA918FhH2XhGFAaQ6G5D9cZ37rA3m4n4eZVUPazNR1gQY86DfLmZmNf8+ck
	 dDtxk/4ojXHNDPoMQR3DxPfELURp7+otz5K8SFWJzQ1oEMtv2Vvl9f7QqRqUmCm+zxj0G
	 dONLzVQ/J3XntSfPeB02Qn8QfglgVMi0n8rqgA3l3KbA0Y8Le1AoZYYCU7pezz7lTC0BK
	 g3AUTsjEFxN0cJxx+lkbXvaXKYgIcMFzUbh56RN0nNV8Rk90oYyCHpy2HDw450EyuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fv+MDnEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fv+MDnEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243D1F0089F;
	Tue, 10 Nov 2026 01:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274036;
	bh=yLurggnjcKT46vHBwGyu4zeuN40bts1EDHVYkSzvJK4=;
	h=From:To:Cc:Subject:Date;
	b=fv+MDnEyx1WRM1AHV26oe0/yNzxvRt6cGYdGW0xUUlJyFPpOzyPDZ3nQCluLGpwGg
	 +XfhpUCfma0z6K8wgnncvRhJ/AuvJDJO3Ojt3USrGsgSPFnJykvzfUCDBIGNZx0am1
	 wXGKaCSMrdJuJZMIkWH44K3BsSYF2yXhvnJcQDM/F4ZLMtZ7UMRcdJPrc+Nstnv78n
	 33TZ0sNG8Ws3kKXADdUQ2ifv+2u5IYudn7nsQLYoLzLOXyvQNXDZzNRTO3PycbLhtZ
	 IgslJYW+2KZqE9glk2yF4iC0PTwTINi//84kKucyF5gERGETvmac3ioAk/kL1pN8HL
	 VYbVxQsw6I7Qw==
From: Sasha Levin <sashal@kernel.org>
To: namjain@linux.microsoft.com,
	bp@alien8.de,
	tglx@kernel.org,
	vdso@mailbox.org,
	hargar@linux.microsoft.com,
	decui@microsoft.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/init: Initialize wall clock in get_rtc_noop()" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:14 -0500
Message-ID: <20261109202714-failed-5.10-7d5af1f256fd@kernel.org>
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
git cherry-pick -x 7d5af1f256fdecff6a7986bbc9146b69cb355bb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202714-failed-5.10-7d5af1f256fd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7d5af1f256fdecff6a7986bbc9146b69cb355bb5 Mon Sep 17 00:00:00 2001
From: Naman Jain <namjain@linux.microsoft.com>
Date: Mon, 31 Aug 2026 08:25:28 +0000
Subject: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()

get_rtc_noop() is used when an RTC is unavailable, but leaves its output
argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
timekeeping_init() may therefore receive a nonzero invalid persistent
clock value and warn:

  "Persistent clock returned invalid value"

Initialize the output to zero, the documented representation of an
unsupported persistent clock.

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260831082528.1623843-1-namjain@linux.microsoft.com
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 252c5827d0634..3b9b41820c84c 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -37,7 +37,7 @@ static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
 int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-void get_rtc_noop(struct timespec64 *now) { }
+void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.53.0




