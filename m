Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B8521222;
	Tue,  8 Sep 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907918; cv=none; b=Ro6mf/rssWYi13iikSk5lyY2lhWEke/UgBoFRlhSfHg4pfu/Mh5IlIOjNY+JTLCtD9sWjKtFM2m6xGuJrHXvxcPde8W7iwiHZLGrixXgXJdANOuuQYPDTOH3Ll9Gzv2YLSNPk8/wBGtUPiboIUrcHbsCvp2NmqGNgXamwNKb+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907918; c=relaxed/simple;
	bh=Dj18uk/WAQgrNQvlpVRfp0lX7lDCic8Jhocs+4B3i4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BgYpytjZnPNdTfz3BgNGkgiPtcKNQMiNx7dX4KJvHItCX3F0qoA7SQ6TRv4Hy330o8tXUl/LOYPUNnK2ZGqEMeaqQUVGnAgH8//MQS/hKiVc55TkrbDDMgYfCNUTASahMFNo5uyexGNi1ePYbBrMnuip5Vq+lQyZSA1zDDuCPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rry9zRkn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+0GtqTM7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rry9zRkn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+0GtqTM7"
Date: Tue, 08 Sep 2026 22:51:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788907914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcumQYZXUHYQ/TKHQvn3pmVI1OFRmBefd4ZMYu5krck=;
	b=rry9zRknNO/9LPjdeSXKrKRMVY09XI0T6M0ii3tSOjhAiVhkY/Uxq6T+au8UdHMv370VNx
	Y3SL50Jj+AsxdRXzA0V0L0Il2ZsWg6YtkGG0XghaOvol9zM29VYG7UftFOL/tYsjhSuawu
	2V6jFjbxobo2dlLIkh053jOFgkU5j6klMaK7SyviUs2Ady1jEQjKAobGwtXnJF7NWQfqfS
	YP9M5rXRM9+UoT12FmauIiydKz3CtvH8gi2MRxK53s5iHPD77cBo714/rpZ1UUaCGxpTRS
	o6IRIq8G32xRk4vhGhPhGJXmsrPUBG9UISDcQ/JMgorIqoY0BbaxrDDkPvmG/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788907914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcumQYZXUHYQ/TKHQvn3pmVI1OFRmBefd4ZMYu5krck=;
	b=+0GtqTM7pZx3sY7QXmwzpOpjGCye1lZUH50lG+ADdbKUeqo6TrkvLFFekkTQhg1QR05ePO
	OWoWJkTNHVOUx7CQ==
From: "tip-bot2 for Vernon Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mm: Fix user-space data loss with MADV_FREE and THP
Cc: Orson Peters <orsonpeters@gmail.com>,
 Vernon Yang <yanglincheng@kylinos.cn>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260903031608.1194238-1-vernon2gm@gmail.com>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178890791238.623050.12163349621605075539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     308e2bc308bcde06e56da6e9bf316b72217c3c24
Gitweb:        https://git.kernel.org/tip/308e2bc308bcde06e56da6e9bf316b72217=
c3c24
Author:        Vernon Yang <yanglincheng@kylinos.cn>
AuthorDate:    Thu, 03 Sep 2026 11:16:08 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Sep 2026 15:43:07 -07:00

x86/mm: Fix user-space data loss with MADV_FREE and THP

Some of users of Polars (a data analytics library) have lost production
data from this bug. They seem to have just the right combination of
huge pages, MADV_FREE and heavy reclaim pressure.

pmd_modify() masks the old value with (_HPAGE_CHG_MASK & ~_PAGE_DIRTY),
silently discarding the hardware dirty bit.  The subsequent
pmd_mksaveddirty() call is supposed to transfer _PAGE_DIRTY into
_PAGE_SAVED_DIRTY when write-protecting, but the dirty bit was already
stripped from the value, so there is nothing left to transfer.

Contrast with pte_modify(), which keeps _PAGE_DIRTY_BITS in its mask,
and pud_modify(), which keeps _HPAGE_CHG_MASK untouched: pmd_modify()
is the odd one out.  Any pmd_modify() on a writable, dirty PMD loses
the dirty state.

One visible consequence is data loss with MADV_FREE on PMD-mapped THP:

    memset(buf, 0x5A, size);          // PMD-mapped THP, PMD dirty
    madvise(buf, size, MADV_FREE);    // PMD cleaned but left writable,
                                      // folio marked lazyfree
    memset(buf, 0x5A, size);          // hardware sets _PAGE_DIRTY again
    mprotect(buf, size, PROT_READ);   // pmd_modify() drops the dirty bit
    mprotect(buf, size, PROT_READ|PROT_WRITE);
    // ... memory pressure ...

Reclaim (e.g. under memcg pressure) then finds the lazyfree folio with
no dirty bit set anywhere and frees it in
__discard_anon_folio_pmd_locked(), even though the data was rewritten
after MADV_FREE; subsequent reads fault in fresh zero pages.  NUMA
hinting alone can trigger the same loss, as do_huge_pmd_numa_page()
restores the PMD through pmd_modify() as well.

PMD-mapped file THPs are affected too: mprotect()/NUMA hinting dropping
the dirty bit means rewritten data is never written back.

Fix it by keeping _PAGE_DIRTY in the preserved mask, exactly like
pte_modify() and pud_modify() do.  The existing
pmd_mksaveddirty()/pmd_clear_saveddirty() pair then performs the
hardware-dirty <-> saved-dirty transition based on the write bit,
preserving the shadow-stack encoding rules.

Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=3DcNbNApCWqdthRj=
d76LThtSPg@mail.gmail.com/
Reported-by: Orson Peters <orsonpeters@gmail.com>
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260903031608.1194238-1-vernon2gm@gmail.com
---
 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d5f4917..d551120 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -806,7 +806,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newpro=
t)
 	pmdval_t val =3D pmd_val(pmd), oldval =3D val;
 	pmd_t pmd_result;
=20
-	val &=3D (_HPAGE_CHG_MASK & ~_PAGE_DIRTY);
+	val &=3D _HPAGE_CHG_MASK;
 	val |=3D check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
 	val =3D flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
=20
