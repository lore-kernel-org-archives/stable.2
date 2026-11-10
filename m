Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273457;
	b=sHwRCiovtqFl6Dh4vJxYkgNzIFKRojy3RmY3+N9I4MeFLmXYUqpC1d7Q9lGMt7YAqUIh
	 1m8ZkrczcAx6bwkLhbyZ2MHzrT8PcrZrlKRj3TdtyBEUDFxSTXKIZCeaXZS6WI2ieO/1m
	 BS8GALJPSaJcodvWhSBhthVGdEd966ciX7wNf/tzevu14oIwg9uGvKEdUtxMbWaVkLtX9
	 5CZ3/5+JeKzr8s5BG+r++iYDY4tgWmOgOIBcd0RIVBOMXs9YW4yxzNmL/1U0mzwDO7gYj
	 2CwCh9oaFTNU7J/kZdmJsReKXR8wQPOEsucjC2np45DtEcFdp12NQ/ECSUjZtr3gZkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6KznJvakP7S92XxuQHV+w/6J/jYRVbCuS4h8KOxYPZE=;
	b=FWhSdtQPUe4b3k97BoYVT8RaPJIy5zATMATjuUS/lvaqj13Fq+kVm2pkarxoKjieSgc7
	 utmQ80C0IjiUK0rsc7SKQPRIdSA+V5rVUfWjK+MD5qH6khwa/J7+Wd58wmmYnuWcS4zUO
	 bNUKA8tQbV8XCZ/eoCKUnjwvkeYT+BDAjTUiLQ5GRcwykrbhDwIIe0hSP/L2cW2aAu0FS
	 DYDnCS6XPM2GII4t4nr4ixA58BKP4gAg7+9R+0JJOvUpgoikKCNZEZMWHyeur+lvrZ+Gr
	 B8HiNvAC7mYInUJH+fuCKMCWwBBUxTR6zZDhMfoatSY2AIXWhOY48jz1qgLaFHMCDkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNWrKmXF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64780606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNWrKmXF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696051F0089F;
	Tue, 10 Nov 2026 01:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273457;
	bh=6KznJvakP7S92XxuQHV+w/6J/jYRVbCuS4h8KOxYPZE=;
	h=From:To:Cc:Subject:Date;
	b=mNWrKmXFUR6em9v1cSUwOzfmanx2vdTrGvlCXrMTCceWxMCYms8NgcViIJYabvvdM
	 y4HE8ji3C+TvRxaICReIRv2henzN91Kk8V9XeIvSet8n6PBjx7f4HSoMYb0Y7/DP5o
	 nBfjKMylWUw6FuYhDe6TESAo+8PfCHNBQ+0ucPzo1Z1ZRsyaJ4M4Q6+iWTgSMRZEkS
	 snWi+x7LVSiKfTrx+PxjEvSs6yx1jTWTZC3A8sUQErQEnO7vzBJ5MTvMtTWkn+aXR3
	 VPeVZ9/+XVjnSf52j044PSwxuAjNbthEi2taG1SbPfvCtNsJc/7Pdl6UaZpLNOZU8Z
	 +0FoXkICHnPQA==
From: Sasha Levin <sashal@kernel.org>
To: namjain@linux.microsoft.com,
	bp@alien8.de,
	tglx@kernel.org,
	vdso@mailbox.org,
	hargar@linux.microsoft.com,
	decui@microsoft.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] x86/init: Initialize wall clock in get_rtc_noop()" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:17:35 -0500
Message-ID: <20261109201735-failed-6.1-7d5af1f256fd@kernel.org>
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
git cherry-pick -x 7d5af1f256fdecff6a7986bbc9146b69cb355bb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201735-failed-6.1-7d5af1f256fd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




