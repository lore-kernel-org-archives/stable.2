Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07B3B1ED1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577334; cv=none; b=tIE97zSGXKn/HsDpaL9bayyJBZEYn1COeOU7vKwbztAz4KYqykMg3QcY0RvudNclWBpMURvmoQac19DL/h/6jpo7jG47UnATNVql5/y0F9r6jROq78taA/ojusSsjmYNFYo0EicLzUF1xlb+WztoKc7pikO1jmPpbFeUwCbSF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577334; c=relaxed/simple;
	bh=uO0k0JDPcW1bj/8aYR4s10TJAsQS+ZMbayqWn+/yN3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/1koAjfmlJg1NUt5mfS1SB2KxYVEVBGiJhMTA63crA3+zQoepUFNIq8lxIigcZTK3kr9v3TMyLQvTO3Tr8t3cVyr0wa8iokrWTRTj3hBaBTureBFYsVyB9qo4OF03JHjlbTVUkXO9wEdrvpFqkfLkY1j8PETn+oRC+I9AMX0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8PEjDKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8PEjDKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C327E1F000FF;
	Wed, 16 Sep 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577327;
	bh=mUsKvSvsNUrhPbfJ0Py5CFoCyNLtjVGlCayCXLvaB3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8PEjDKbzSVZSyBM/Fltwa23FdrDy7wYZQvtUt3hEMR3qDcumRksbGCygUnpQrW+J
	 Kczd1ODnDqRbtAAsQa4jxYfDI/CI4E+6O2ITZ5rJJ7HI3t/9hl78h1+ysF/ClRRmMA
	 GQKW1io5bqE7mPDaFnNIskKmeLKlBFDQ8+CojlrTiAWKCOwOXkKDe8aUa0D/dWEPzb
	 sgJmjLdKA/8JmemnH1lzSanUoGLamQGUby+RE1XwObGerzdr3oswgTDVfuCQzW2uTV
	 wCTB0S/o2oGc+mPPdX5o1TE0Pgl7bYimPkRKusWOmRtEFxk3sqGRBtXLtogTqtuToN
	 uXQeFIqDDMuCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Borislav Betkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Juegren Gross <jgross@suse.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mm: clarify lazy_mmu sleeping constraints
Date: Wed, 16 Sep 2026 12:48:40 -0400
Message-ID: <20260916164843.541311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091654-satiable-demanding-819a@gregkh>
References: <2026091654-satiable-demanding-819a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit f2be745071ffd6793c032ca8443348c3ce0e3e18 ]

The lazy MMU mode documentation makes clear that an implementation should
not assume that preemption is disabled or any lock is held upon entry to
the mode; however it says nothing about what code using the lazy MMU
interface should expect.

In practice sleeping is forbidden (for generic code) while the lazy MMU
mode is active: say it explicitly.

Link: https://lkml.kernel.org/r/20251215150323.2218608-6-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Juegren Gross <jgross@suse.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5a88f78df753 ("reboot: fix cad_pid use-after-free race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pgtable.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 78a518129e8f0..a78dd60716c0c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -197,11 +197,15 @@ static inline int pmd_young(pmd_t pmd)
  * up to date.
  *
  * In the general case, no lock is guaranteed to be held between entry and exit
- * of the lazy mode. So the implementation must assume preemption may be enabled
- * and cpu migration is possible; it must take steps to be robust against this.
- * (In practice, for user PTE updates, the appropriate page table lock(s) are
- * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
- * and the mode cannot be used in interrupt context.
+ * of the lazy mode. (In practice, for user PTE updates, the appropriate page
+ * table lock(s) are held, but for kernel PTE updates, no lock is held).
+ * The implementation must therefore assume preemption may be enabled upon
+ * entry to the mode and cpu migration is possible; it must take steps to be
+ * robust against this. An implementation may handle this by disabling
+ * preemption, as a consequence generic code may not sleep while the lazy MMU
+ * mode is active.
+ *
+ * Nesting is not permitted and the mode cannot be used in interrupt context.
  */
 #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 #define arch_enter_lazy_mmu_mode()	do {} while (0)
-- 
2.53.0

