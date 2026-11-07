Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045977;
	b=K7rJgTs5vkkxe1/09erhn69eLHnu7IcQl0r6O2CCpFOVmYmBo64v9SIVsVcYCWce7zrZ
	 YUuN5EZSHLvmBWQsPz2RZvtOEb2pgwrvssRMpfsiQexGNMvS+tUfTbo0o8ZeSjFwEod0R
	 bPnQUVqY47w+EQLnh450Ji3FV4fI35JbYk3MB0de3dwplyctq6GUpc0xD/3QimMZQfYA+
	 LwzxhtNMATK8pwj9fT2z/XFtgIysnwrq8UGtGLyfD10TgQOmZdWDPgpPEZxsGdc9QV1E0
	 g77m2np5CyztIywYUArYFR2M2fAW39n80GB0Pe/JW7r7FV8Wcy3NfVkL34Yv3jjlhtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045977;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9skw1KgF5oLmU0qqrfQHRDq+Yv5s7SpwazCH0x9kr20=;
	b=vTQqCtD4+nOYDfvGeurph9IM+BMuFDmKElWIQXmRj6J7o/irx41/8+tW8ZWis2ePandQ
	 zsugheRltzCEwMrAgMRro51DPgUUUWbxUPmqHT4KpECrU4zDaiguqJB02Dd2EZms4TxZu
	 +Hn07q5vK2so4PGgyiHNkp/ufdnbemqFyAxL8/cZWO+Zt2mubkU6doKW4epfmcSMfYbhP
	 7wLYFPVIuSMkO4TL68z8V6PAYDd4pyxb7oq/2S9nCawoH2Rty96czan0LqRjSaF3Vh9nX
	 6Q/Y55OUXFBcojXP5xqZM4auPAX1xDzkNSp3NkJwR0zvxcyByIXBLktId10/ayOTWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5yrIHwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF89606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5yrIHwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FA41F0089F;
	Sat,  7 Nov 2026 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045976;
	bh=9skw1KgF5oLmU0qqrfQHRDq+Yv5s7SpwazCH0x9kr20=;
	h=From:To:Cc:Subject:Date;
	b=P5yrIHwZCUEN5hvUn+IgOHvyG1ZvxkORECsvqd9NE1cVPTrLCRvuiF/mZn9OJeVfN
	 u71ee6/RTXNQdSbpd3f+jODKu9MEHIcW/AaMx28lT6Su/+iCvXSvHi/lxK/YEvrAAP
	 dvU9w0ntm1jKSQQCE5QG3IK4l8kLZ1bF9inOfqLE59J5yW2baLYSqptOlf/p945BIp
	 f4SHDkO05JMCmQ61GTMeepkZUMXmdRX1bcEy1n3Getz5JEUEic+AeL/wIH/uw4GjxH
	 z7Hv+SpQ7hwyXWaYILpFulGeLf8X4bxXDefjR36m5+KvV+QFguVea8eTW1vePWML4i
	 8gwtNKAQBwRqA==
From: Sasha Levin <sashal@kernel.org>
To: masaparov@coreweave.com,
	rppt@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] kho: do not reserve scratch memory in the kdump kernel" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:15 -0500
Message-ID: <20261107050615-failed-6.18-48be325089e1@kernel.org>
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
git cherry-pick -x 48be325089e15077411785d0c41ddb9071a61081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050615-failed-6.18-48be325089e1@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 48be325089e15077411785d0c41ddb9071a61081 Mon Sep 17 00:00:00 2001
From: Maxi Saparov <masaparov@coreweave.com>
Date: Tue, 11 Aug 2026 12:18:57 -0400
Subject: [PATCH] kho: do not reserve scratch memory in the kdump kernel

If a kernel with CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y (or kho=on)
does not receive a handover FDT, it reserves KHO scratch memory in
kho_reserve_scratch().

The kdump kernel always takes this path. Since commit a6715d7ec472
("kho: skip KHO for crash kernel"), the kernel does not add KHO
metadata to the crash kimage. As a result, the kdump kernel never
receives a handover FDT and always reserves scratch memory.

The kdump kernel boots in the small crashkernel= memory reservation.
On our x86 hosts, the kernel and initramfs make approximately 176 MB
of early reservations. The scratch areas then use approximately
650 MB more of the crashkernel memory. When a large early allocation
fails, the kdump kernel panics:

  bio: can't create integrity buf pool

A kdump kernel has nothing to hand over: its only task is to dump the
memory of the old kernel and reboot. Fix is to disable KHO at the top of
kho_memory_init() so that the kdump kernel does not reserve scratch
memory.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Maxi Saparov <masaparov@coreweave.com>
Link: https://patch.msgid.link/20260811161857.3096-1-maxi.saparov@gmail.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7c4d86daf86d5..3c87c2a3d6f09 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -12,6 +12,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
@@ -1939,6 +1940,12 @@ void __init kho_memory_init_early(void)
 
 void __init kho_memory_init(void)
 {
+	if (is_kdump_kernel()) {
+		kho_enable = false;
+		pr_info("disabled in the kdump kernel\n");
+		return;
+	}
+
 	if (kho_in.scratch_phys)
 		kho_mem_retrieve();
 	else
-- 
2.53.0




