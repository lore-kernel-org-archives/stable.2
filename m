Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F14A3F1B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550663; cv=none; b=HWRC2NJsloNtUMp1hBvO6KdqC23yetndbNw8SsjV+vN5IjsvLhJ/Qv8Aki1wBMSj0pEiTgFh+aUHzUVMzODJLHuTbukckV9rdTc5PrEjwHIrJFEolA/ixyNEEsMQ5lN9DLIpEfiB03RYSIxOxRCQHCGvLpM7ANjC63NQjJmHzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550663; c=relaxed/simple;
	bh=gQuku9UwxdQ8uwGWQ6hfMCF9AGQyHLTbWdLm2HnUWm4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cjFewU+yXsGDlP80M6ewsIT7hVN6dgKEK6vkynQFoSmf9PdqPWefAtibf5JyqPjIionpQGeezrhPLtz7yYA+MDtmjy+6mQdM5P2gcS5rpbe+ffh2oM3c1k5rKG/fe606hTqNWPNneYfvvoY2N/bqAD5X4yf/gAAetd2e7znJFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8Z1VZau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8Z1VZau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B781F000FF;
	Wed, 16 Sep 2026 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550659;
	bh=iWsYqBCiTSlY7JIsOZeo1GobiWnEFHrdJpnoNfWoWqM=;
	h=Subject:To:Cc:From:Date;
	b=A8Z1VZaur+eQSZIOKM6Zt63iwUp/coH1TBLtGLE/nhzo0cUlCwG9j4+d7Y8gC2sq0
	 tRLyUBH3QBM0vwbY7sH6nagrEcW6YH2y7tgaj44M7COy/qqs9iAYKudTxKplT6WV6E
	 +gdTS2MD7o5YLnbp6GIOTVs/0lV1Utph/3p6vUNQ=
Subject: FAILED: patch "[PATCH] riscv: hwprobe: initialize pair->value in hwprobe_one_pair()" failed to apply to 6.18-stable tree
To: tchiu@tenstorrent.com,jtaubepe@redhat.com,pjw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:20:13 +0100
Message-ID: <2026091613-hardiness-identify-3dc6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d0fc6fab20460add1f27402cd8b945d094a56b21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091613-hardiness-identify-3dc6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0fc6fab20460add1f27402cd8b945d094a56b21 Mon Sep 17 00:00:00 2001
From: Andy Chiu <tchiu@tenstorrent.com>
Date: Mon, 31 Aug 2026 19:11:23 -0600
Subject: [PATCH] riscv: hwprobe: initialize pair->value in hwprobe_one_pair()

The vendor-extension handlers reached from hwprobe_one_pair()
(hwprobe_isa_vendor_ext_thead_0() and friends) only OR the present bits
into pair->value via VENDOR_EXTENSION_SUPPORTED() and clear their own
missing bits; they assume the caller has already zeroed pair->value.

That holds for hwprobe_get_values() (it zeroes each pair) and
hwprobe_get_cpus() (it re-initializes its scratch pair per key), but not
for complete_hwprobe_vdso_data(), which reuses a single pair across all
keys without re-zeroing. A vendor key therefore inherits stale bits from
the previously probed key, and the wrong value is cached in the vDSO
all_cpu_hwprobe_values[] and handed to userspace on the fast patih.

Zero pair->value once at the top of hwprobe_one_pair() so every handler
starts from a clean value regardless of the caller, and drop the now
redundant zeroing in the *_BLOCK_SIZE cases. hwprobe_isa_ext0() keeps its
own zeroing because hwprobe_ext0_has() calls it directly, bypassing
hwprobe_one_pair().

Fixes: a5ea53da65c5 ("riscv: hwprobe: Add thead vendor extension probing")
Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>
Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
Link: https://patch.msgid.link/20260725001614.2578617-2-tchiu@tenstorrent.com
Cc: stable@vger.kernel.org
Signed-off-by: Paul Walmsley <pjw@kernel.org>

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bd6ca7d769da..7818e1d32622 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -297,6 +297,8 @@ static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
 {
+	pair->value = 0;
+
 	switch (pair->key) {
 	case RISCV_HWPROBE_KEY_MVENDORID:
 	case RISCV_HWPROBE_KEY_MARCHID:
@@ -331,17 +333,14 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		break;
 
 	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
-		pair->value = 0;
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
 			pair->value = riscv_cboz_block_size;
 		break;
 	case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
-		pair->value = 0;
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
 			pair->value = riscv_cbom_block_size;
 		break;
 	case RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE:
-		pair->value = 0;
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOP))
 			pair->value = riscv_cbop_block_size;
 		break;

