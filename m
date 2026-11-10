Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280171;
	b=VYdvIn7f7zjSAxRZipaODHxhkM0nbc0ssxXiRRohtTNgHHVxA3/GG0uNZHLDfuzvT+om
	 iLnnGBekJ5KAMBTo9/VKl3r7zgt8h5ikFYZgGcjl92cyE2bEBuXjQ2XICKEIl3CNDJM9X
	 /RtnsUFxLPMBZ/SByFWhmT6eKc4fOAUOHGsROOQCXVsdkR269h0U1Z0AyeIeBUzu93pQX
	 cLFQ+L5SuVq0J8MuuiYn4k7DVR99F/bdTH26vAzQPTTZxTsDwIrgoMa84n1deEFOHBLgb
	 QW1P0tudb2NBbAygYGEjJtEK1gkUQ32PFf+cqlVWu56A7AbWDqGsETgnqrp0FjcQX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280171;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2s7L5dC7pdRG3drthU9lV2XWPSNrHn42rVuk37wsybs=;
	b=Z4DrgTVYtCZZV5gT8dVbxIuvnVoifQaJio5ZcwT12+xVlu+E9TbDDGkcZt1qhSmmZqWF
	 hOCAKfCiLUQ6Gw+Pnon9Ei5grxp1yeU+M5Ki+m8L2rGIA3bW7c6v2gk9eZakTocaGB8v8
	 oQFqjUmMLNQDJLqO9pvcSZzMUM2lL52C+21Eh/t8IBMLzheaqmCaUSJb00KcTgdDh+wQL
	 QkJT4fBsD1oUdnDvgLpSis/m1tVaF7WSPAY5EkecBC2dBQzr72pkcNBa5mEjqQpSdPuuP
	 zDIbEgWNMLocyR2kcovRxeInEETEy4jyhQT9F9dZAr2TBRlCw8ksvJIXRaY+rKiGVcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOXTC6Eb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CA606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOXTC6Eb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961A41F008A1;
	Tue, 10 Nov 2026 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280171;
	bh=2s7L5dC7pdRG3drthU9lV2XWPSNrHn42rVuk37wsybs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oOXTC6EbPeCgTzOrKJtXDye5vZR6hwhBdcTOTwVsCxXj41x+SJJHiUKz3DJ2FvEYX
	 gEPprwyK4h+u2hq8FwM8Gd9QjS8Hd/efnfuoJvb8uOsqlzPX/qkrdEHgXChwXhHnAT
	 IReaBn7xZZVe7KvzEc5UrQcKQiob5t8p6EW78K+TO7WLAsUhbKqPn2GagC1w+Eu4he
	 cuRC7XzFGvFu8UmzKFVsk/I4UymhZwJ1PV3Eh0U0uDpqrfCfTdqKNRhM0G9pjnlgRz
	 09STMZw4pwEhV3YxZHcVj3vbw9rfU7zlDxgAgJrkoDevxiIJ0TsRQqsPCU7o+wMv30
	 5yWsDxwpn+6IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxi Saparov <masaparov@coreweave.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] kho: do not reserve scratch memory in the kdump kernel
Date: Mon,  9 Nov 2026 22:09:29 -0500
Message-ID: <20261110030911.4192329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050615-failed-6.18-48be325089e1@kernel.org>
References: <20261107050615-failed-6.18-48be325089e1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxi Saparov <masaparov@coreweave.com>

[ Upstream commit 48be325089e15077411785d0c41ddb9071a61081 ]

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
[ sashal: adjusted context to apply the unchanged additions to the handover implementation at its older source location ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_handover.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 9691f6bc2fba7..e503573e03190 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -10,6 +10,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/cma.h>
+#include <linux/crash_dump.h>
 #include <linux/count_zeros.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
@@ -1325,6 +1326,12 @@ void __init kho_memory_init(void)
 {
 	struct folio *folio;
 
+	if (is_kdump_kernel()) {
+		kho_enable = false;
+		pr_info("disabled in the kdump kernel\n");
+		return;
+	}
+
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
-- 
2.53.0

