Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A74A92DA;
	Wed,  2 Sep 2026 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374018; cv=none; b=IMoXsp41JM5czJGsiyyx0zBs8edft+rG2KuAKu3e87TG7gaWB3nNz2/FHkiXW1NqGX8IVT69jbFg/8oWxgFxajiSA2N54+4qLDC6xAttpVHkEXpiP7pRQnPONqlyk6w3I0xjeF0cVDSE99MBhw+f4F6sPHwRDmKQrEQTqYAteO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374018; c=relaxed/simple;
	bh=RKkQgOHo+dLzZmJ6Av0FQM4+QQz3oc3qFN9lWYfvnO8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oLb7dj3ohwbE1EbPRdNBazSmAwO1QeTc+oTa10I83pegucuVXh4fIW1NJmSh4jhEEIpA9eK4CQPlWwv8sUrN5lZJ7ON5HBa8s1NF5Yqyj0eW3Hq3rNqNtLtdSKw71xEobmippk9ZgoDig14PS52tC01Qn+daaghvAi9Dkr0UcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTAVWuLO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eP4eDBO2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTAVWuLO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eP4eDBO2"
Date: Wed, 02 Sep 2026 18:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788374013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQLGzQkEoZWuMbsf+Oip4T48GrQ/HEHvXCfFPsg6TQ=;
	b=kTAVWuLO5/qs7VDMs47U1FOHF0IAsGFnS8nFOBGYxcVoPvp3j6PtIwXprkZXaCbtj1u6ce
	6hbiTIDieTCMHpWUCorIksfwCUJe7oZXbKuOWrkfCPuphqKoGQFcuXBjXFrYL0wdF67Fkw
	ZZRBX1UCCsCwKayjks/S/OCsFh+L8vOlb6vUVsh9PEb2/WycADIuQgb74qTk2U1JO+zkVY
	sxPzeLl3cA2Ul4oxiRzwAhCjbF9vQU7IBU0KlaHc8iGw4rFdjKp5ReDfhInCfzKU1NAGVL
	WIJlhboijjKYViQShxxIXqcUaE+UYzCXMMRn19IIrWUMSKKSytxAAllJCfWyTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788374013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQLGzQkEoZWuMbsf+Oip4T48GrQ/HEHvXCfFPsg6TQ=;
	b=eP4eDBO2uJBRj+goJQfbbChMYfBPxVtOCE7B7oNIJKVjEJvCBKLo6aJoypyfOzR4FyDSto
	4IaaL0A/eWidObAA==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Fix effective RW computation in
 lookup_address_in_pgd_attr()
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Juergen Gross <jgross@suse.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, syzbot@syzkaller.appspotmail.com,
 Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     453e7859443446b837d905d6f2983a76c867247d
Gitweb:        https://git.kernel.org/tip/453e7859443446b837d905d6f2983a76c86=
7247d
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:28 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 01 Sep 2026 15:03:18 -07:00

x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()

lookup_address_in_pgd_attr() accumulates the effective NX and RW bits of
the walked page table levels so that verify_rwx() can detect mappings that
are both writable and executable.

The RW bits are folded into a bool with

	rw &=3D pXd_flags(*pXd) & _PAGE_RW;

but _PAGE_RW is 0x2. So consider the accumulation line:

        rw &=3D pXd_flags(*pXd) & _PAGE_RW;

where rw=3D0x1 and the right side evaluates down to 0x2. It'll end up doing:

        rw =3D 0x1 & 0x2

and rw always ends up 0.

This way rw becomes false at the first level walked, regardless of the
actual permissions, and verify_rwx() treats every mapping as non-writable
and never reports a W^X violation.

Add double negation to the right side to normalize the _PAGE_RW flag to
0 or 1.

Assisted-by: Copilot:claude-opus-4.8
Fixes: ceb647b4b529 ("x86/pat: Introduce lookup_address_in_pgd_attr()")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: syzbot@syzkaller.appspotmail.com
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org
---
 arch/x86/mm/pat/set_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 4652487..2266609 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -754,7 +754,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned lo=
ng address,
=20
 	*level =3D PG_LEVEL_512G;
 	*nx |=3D pgd_flags(*pgd) & _PAGE_NX;
-	*rw &=3D pgd_flags(*pgd) & _PAGE_RW;
+	*rw &=3D !!(pgd_flags(*pgd) & _PAGE_RW);
=20
 	p4d =3D p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
@@ -765,7 +765,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned lo=
ng address,
=20
 	*level =3D PG_LEVEL_1G;
 	*nx |=3D p4d_flags(*p4d) & _PAGE_NX;
-	*rw &=3D p4d_flags(*p4d) & _PAGE_RW;
+	*rw &=3D !!(p4d_flags(*p4d) & _PAGE_RW);
=20
 	pud =3D pud_offset(p4d, address);
 	if (pud_none(*pud))
@@ -776,7 +776,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned lo=
ng address,
=20
 	*level =3D PG_LEVEL_2M;
 	*nx |=3D pud_flags(*pud) & _PAGE_NX;
-	*rw &=3D pud_flags(*pud) & _PAGE_RW;
+	*rw &=3D !!(pud_flags(*pud) & _PAGE_RW);
=20
 	pmd =3D pmd_offset(pud, address);
 	if (pmd_none(*pmd))
@@ -787,7 +787,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned lo=
ng address,
=20
 	*level =3D PG_LEVEL_4K;
 	*nx |=3D pmd_flags(*pmd) & _PAGE_NX;
-	*rw &=3D pmd_flags(*pmd) & _PAGE_RW;
+	*rw &=3D !!(pmd_flags(*pmd) & _PAGE_RW);
=20
 	return pte_offset_kernel(pmd, address);
 }
