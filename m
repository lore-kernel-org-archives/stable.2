Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187947F2E6;
	Wed,  3 Jun 2026 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491921; cv=none; b=qTDbz+BbM1yEHcD9Wpp5szq8Vo1EOAS6dz47je+X1XPgtRTtZXQUzUoKfjI6tj4z2+583ZJJZdtoi547Qe+pH1TRrA11sEBXKi9qSXFR6pfkE+JL/UTqMO4D6BjDuu1z0qkhTlmkS5/zzPp7lu7S2mgndxIbQxzCOPEf/3PRy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491921; c=relaxed/simple;
	bh=4KDNC+n7Zn9Ap+bf3UhGe7DONQsTBW8GrIAi5N4qrR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Un0PnwQ5SxOSYv+ikkOIjPArWJrbDCEPN4ezdwoy8beEHnGEEKl/uq+jXnfdHIlcSiGZtGQ7aeNIleiz2GV675ZMrJWP+jCF3rgWRbhY9lBHBHwkHUA8k3eTDqKHX8ndAkVuAviaHYhD/dvtV14/5QKjNpysiIm5BvMmM2iGMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NoguVVMF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NoguVVMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=bLLBHy12NTJHyuPLkj8zZD9oFwdYVG8GLqwIPAHIL+M=;
	b=NoguVVMFrLYHHWSXCA9/8JuSbWcp/nOaP0/r2kz45BxyER6D1c3ROt9C8lmKnK
	msn8ZA8/BHr0NDKyvUc8GVCzLsvQQJBuQ4bnjqHmx1qGPXz0YBMnuIe5zxTPBr6/
	lzcUi0wCvZ0bHpoAA35sog2nc4IA8ETqGhsi4WFddJyDw=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnoqAAJiBqWd71BA--.49866S4;
	Wed, 03 Jun 2026 21:03:15 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Paul Webb <paul.x.webb@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Betkov <bp@alien8.de>,
	guoweikang <guoweikang.kernel@gmail.com>,
	Henry Willard <henry.willard@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Jonathan McDowell <noodles@fb.com>,
	Mike Rapoport <rppt@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Yifei Liu <yifei.l.liu@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y 3/3] x86/kexec: add a sanity check on previous kernel's ima kexec buffer
Date: Wed,  3 Jun 2026 21:02:39 +0800
Message-ID: <20260603130239.81400-3-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603130239.81400-1-jetlan9@163.com>
References: <20260603130239.81400-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnoqAAJiBqWd71BA--.49866S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUAF18tF1rZF4UXw4Dtwb_yoW5Gw47p3
	9I9r48GrnrJ3WxGw18CryUuas8ZaykWF1UWF4Dur93Ar15tr17XrsYvF1xZF42vFWrKFyr
	J3Wjgw1Fg3yUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziyrWrUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxBMw+GogJhNt6QAA3k

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit c5489d04337b47e93c0623e8145fcba3f5739efd ]

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>", the physical range that contains the carried
over IMA measurement list may fall outside the truncated RAM leading to a
kernel panic.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

Other architectures already validate the range with page_is_ram(), as done
in commit cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds") do a similar check on x86.

Without carrying the measurement list across kexec, the attestation
would fail.

Link: https://lkml.kernel.org/r/20251231061609.907170-4-harshit.m.mogalapalli@oracle.com
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
Reported-by: Paul Webb <paul.x.webb@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: guoweikang <guoweikang.kernel@gmail.com>
Cc: Henry Willard <henry.willard@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yifei Liu <yifei.l.liu@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index eb129277dcdd..df74f865c9f1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -372,9 +372,15 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
+	int ret;
+
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
+	ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
+	if (ret)
+		return ret;
+
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 
-- 
2.43.0

