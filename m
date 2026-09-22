Received: from 4.mo560.mail-out.ovh.net (4.mo560.mail-out.ovh.net [87.98.172.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD0526ABA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.172.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067430; cv=none; b=C2jmbTCtBPRg2KJ0ZwGQB2nKG/e1gs6mx16tr0CydvX/DUq1bIdXqywuEX93S+6Nvw3z+42yi3PUSBVooqZsFUQcg5tWZRyzOJRPHPtWDTKb4dOY4j1FbeLOdIdEsXoUoAUhF8d3pamob6HG09vDgLvBjpwCuX2lNejxm5uZHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067430; c=relaxed/simple;
	bh=vozS4Tn8G6O6ng5sDEwLGPHZJL36uoe21Z6znm0P5kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6JT6S+yLv2VYi+/kH91y2qm9fbkUSM4UT7c2RDNJyYwdA2xC3EHJS9nTvz6TlM8vBT4KjqCQCg1eTMmp4ODyHSQ6v5qB54jbwa8i/PGKLvuOk4dv/GNA4HRpBnV0dDyQXIa1sq5IycFdtc+TBw0id1JExzrj5AVeHVK+d3LrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quelquesmots.fr; spf=pass smtp.mailfrom=quelquesmots.fr; dkim=pass (2048-bit key) header.d=quelquesmots.fr header.i=@quelquesmots.fr header.b=E7JH3Jry; arc=none smtp.client-ip=87.98.172.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quelquesmots.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quelquesmots.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quelquesmots.fr header.i=@quelquesmots.fr header.b="E7JH3Jry"
Received: from director2.ghost.mail-out.ovh.net (unknown [10.110.43.183])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4hpv2M5tlczBKTy
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:50:51 +0000 (UTC)
Received: from ghost-submission-c7b579475-9ghvt (unknown [10.108.54.199])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8661CC04C9;
	Tue, 22 Sep 2026 08:50:49 +0000 (UTC)
Received: from quelquesmots.fr ([37.59.142.102])
	by ghost-submission-c7b579475-9ghvt with ESMTPSA
	id ko1GFWlBsmqwRQQA5nG6ng
	(envelope-from <l.wandrebeck@quelquesmots.fr>); Tue, 22 Sep 2026 08:50:49 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R00457fffa61-1c32-48c3-8fd4-5f58ed46588f,
                    635681CF4E92E4A6CAC13A4CB71CF26F70416E4A) smtp.auth=l.wandrebeck@quelquesmots.fr
X-OVh-ClientIp:109.190.254.62
From: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2] x86/mm: don't apply va_align to hugetlb mappings on AMD F15h
Date: Tue, 22 Sep 2026 10:50:32 +0200
Message-Id: <20260922085032.46144-1-l.wandrebeck@quelquesmots.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4713861437617077698
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGubFdNA5Mq04fBGK3gC9kqCB9FIck7QMQA+k7zsgkXFpQR6t03Yg6ArBdu2SLNHNSGg7Gp75cH+yqP1FxecSY0Z2atvMw97uOSYR21lGq+8FfOVS2tfEZH/tOdy1HKrEh0kcT4iwUdHWw2gGOQIpms4D3Loc/lrJKp9bcImETjs4ZXylOFjG0jV8OmMOoRhGyuzcFK0EDN2HewpJEdOUWuTA9li5UxHN1K9ye8Gb4k68i0joFn1hAmNYK6COPknkNquwiPR9HpfGJNyBEZ/K/YHzjNNMkaQNbcijFwXMMWpiQoQEHgJkjS24hIYFI1MYzIWHfP4xWDroyu4WkTVv9NuI9+/61rLp4ZnR5S0grpCGvg8swQirh5V1bPjnnKLiVsOOp6x/UdrNPiOxWx853FVL8IJiCNoauczf+VxnoWnKffBaMXYvprjyFtnDIsMQQlZsToEE7TO7wR8uXxLv4KjmHbMIpF6uJuS3r/Z9kTyX3BspAQReaduQbmcDU6mt3sw1snkWdcm+s9wvaNnpvRh7SljzDLSi5Ewia4TqWHFcXYHIbtRsqKa4s8wJnthF2wREZoNy4kAKx6OXrwNmIKY4cUwCC+5ZZpFqrqsQRg4oSdGDBr0ui2xqU3sLAIl35QiwzSkhwNYd8h1t9gfXmQ6NGOIWcSYK7DqYLSBwqJUQ
DKIM-Signature: a=rsa-sha256; bh=w7/Bt3TycCT1K1u24fOFFkzDbe41NlkwbsLDq3UP4wk=;
 c=relaxed/relaxed; d=quelquesmots.fr; h=From; s=ovhmo4049951-selector1;
 t=1790067051; v=1;
 b=E7JH3JryapxuyaFq5Ln44rkYkxGQdMMuSEdB8GxzzENa2NSD43RPdPGf36ANfoWfogTKMDLy
 r4fewj4/17TVT53s2XVBKl2jzbXH1VWWM5+ziPwZ5bj1PKXuQNDsIcKFEQ+bA/eZ8/LOZl9EVYv
 IIqIoRT9wRtNPm785B441TmX7yoRijcVzYhKbLcplKyZBXfRAyJxKm+6fwrXk5AVibjo3YrCTjh
 VXCmFx3WjkQVWfRS1l/9JpcVb60p52HRrXAJkifLyvcn+Jha/T4Kq5GuET8bVQVH0eCWiselvod
 3p8Ul/KV5zlV0Xuu4ACwH4pg/AZ0kPdLMyQeZXo4xtgfw==

get_align_mask() returns huge_page_mask_align() for hugetlbfs, but
get_align_bits() adds va_align.bits regardless, so vm_unmapped_area()
returns an address off the huge page boundary and
__unmap_hugepage_range() hits BUG_ON(start & ~huge_page_mask(h)) at
teardown.

Pass the file to get_align_bits() and skip the randomisation for
hugetlbfs. Reproduced on Carrizo and FX-8370E, both hstates.

Fixes: 1317a5e7f7b1 ("arch/x86: teach arch_get_unmapped_area_vmflags to handle hugetlb mappings")
Cc: stable@vger.kernel.org # 6.13+
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
---
v2: put the hugetlb case in get_align_bits() instead of guarding both call
    sites, per Dave's suggestion to pass filp through. Masking rather than
    returning early cannot clear the bits: va_align.mask is an L1I way
    size, so it is a subset of huge_page_mask_align().

    Re-tested on Carrizo, both hstates.

    Link: https://lore.kernel.org/all/20260828135747.724789-1-l.wandrebeck@quelquesmots.fr/
 arch/x86/kernel/sys_x86_64.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6fa7f2d..4c078827f26a 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -50,9 +50,16 @@ static unsigned long get_align_mask(struct file *filp)
  * value before calling vm_unmapped_area() or ORed directly to the
  * address.
  */
-static unsigned long get_align_bits(void)
+static unsigned long get_align_bits(struct file *filp)
 {
-	return va_align.bits & get_align_mask(NULL);
+	/*
+	 * va_align.bits is smaller than the huge page size and will
+	 * lead to misaligned huge pages. Ignore it for huge mappings.
+	 */
+	if (is_file_hugepages(filp))
+		return 0;
+
+	return va_align.bits & get_align_mask(filp);
 }
 
 static int __init control_va_addr_alignment(char *str)
@@ -157,7 +164,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len,
 	}
 	if (filp) {
 		info.align_mask = get_align_mask(filp);
-		info.align_offset += get_align_bits();
+		info.align_offset += get_align_bits(filp);
 	}
 
 	return vm_unmapped_area(&info);
@@ -222,7 +229,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr0,
 
 	if (filp) {
 		info.align_mask = get_align_mask(filp);
-		info.align_offset += get_align_bits();
+		info.align_offset += get_align_bits(filp);
 	}
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

