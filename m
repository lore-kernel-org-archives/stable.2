Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3583C1400;
	Mon, 31 Aug 2026 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215252; cv=none; b=j9vuI5OsHpMG7+rOJqKnj5/H9Xb3n46XSJY5nFcPWS6Pk+TfdB6do8tbbG6IPT9QyrG46VQSvCdcSV8KgD4ToXn/Bj5ziplzzj+jAkPpzM3rerCw++v5wqwZrIFbANqiytPQhMHFOz6wlh8sMlSpAJWFZhfPw0lwy8HDirebYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215252; c=relaxed/simple;
	bh=MYdsOPQZaf6xP3shEtg9KmWsK5fn4asUx4V42RC2Sx4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dgfG2JKpm47WGdEpNoKtClU0Rwwtp8Aq3K06Gg5XUTLH7eGe+1GBpt/HEMdBMQhMM7sY1oxW1WtWZJZIKVJk5NEIiooBo9XUQstvJNxKT7J6QkurdfsKTRdslSgCsYQrfr8OA1vTahs+mUiPEH3l/UXhjnSAAtg9WgJo/tbrPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDKjCOdY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6xDe9d24; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDKjCOdY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6xDe9d24"
Date: Mon, 31 Aug 2026 22:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788215249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkoliE/WxNt8z9bhJr6FMQ6JRQsV/8wnmlWbgQ98i/g=;
	b=bDKjCOdYfvjwsOUo+D7icwXK6eHaTJ02u7IIF7xgUxuVamCFFzHikmwlIGenpX2wev5V4w
	vlDnSayoZRwr6wxaOCDEie6HtIcDQie0aD1B0M+AoNCgE0pvCrRdUhtHPhNgzFwphaYfXt
	2Xz4mBKEZ5dpRuTTcSErc1WFN8lbGSLL6RyPe52QpawzwgbLGtcX5bDxJu+X/xqf4aQe+S
	ohCng5kGI7HKM6nSMyCpE8wyW7f3p9xiFgtiMmPySC6pPGqf6T1RE+Nj2gFWrpEEUt7n62
	GU0+RCCb1GPZkKrayOZ+IxzZ0vo2qjG4tdRoIriUoDR3ZfPmYAFkI6SZzWwBBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788215249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkoliE/WxNt8z9bhJr6FMQ6JRQsV/8wnmlWbgQ98i/g=;
	b=6xDe9d24b/IIX2QKgB2MadmwjVOMHTrsVX45s4JUe1g8K+dJNeatk+AGGRmqnQQHTh7Z8J
	TGmnLoOeIBN3U7AQ==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on collapse
 to avoid UAF
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Will Deacon <will@kernel.org>,
 David Carlier <devnexen@gmail.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     be4f4ab413d15e2b44f6bcda3b607eb707a7712e
Gitweb:        https://git.kernel.org/tip/be4f4ab413d15e2b44f6bcda3b607eb707a=
7712e
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:24 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 31 Aug 2026 15:14:58 -07:00

x86/mm/pat: Acquire init_mm write lock on collapse to avoid UAF

x86 implements page attribute modification using its Change Page
Attributes (CPA) mechanism.

This tracks properties of ranges such as cache mode through x86 page
attributes, and as part of that logic manipulates kernel page tables.

Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
fragmentation") ranges of kernel page table entries can be collapsed into
huge page table entries as part of this logic.

As part of this collapse, it frees the page tables which the collapsed
entries previously pointed to, and it does so without any relevant locks
being held to preclude concurrent kernel page table walkers.

The only way this code can be reached is if CPA_COLLAPSE is specified, and
this is only set in set_memory_rox() via:

set_memory_rox()
-> change_page_attr_set_clr()
-> cpa_flush()
-> cpa_collapse_large_pages()

Notable users of this are execmem and bpf when manipulating executable
mappings.

However, this is problematic for ptdump as it walks ranges it does not own
and thus runs the risk of a use-after-free on page tables freed underneath
it.

In addition, concurrent CPA collapse operations are possible which can also
cause races.

Resolve the issue by acquiring the mmap write lock on init_mm across the
whole operation.

It is safe to acquire a sleeping lock as all the callers invoke
set_memory_rox() from process context and in any case,
change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
mutex, disallowing atomic context here.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation=
")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Will Deacon <will@kernel.org>
Reviewed-by: David Carlier <devnexen@gmail.com>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org
---
 include/linux/mmap_lock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index bec0eab..b8a13b8 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -630,6 +630,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
 	     mmap_read_lock(_T), mmap_read_unlock(_T))
 DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
+DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
+	     mmap_write_lock(_T), mmap_write_unlock(_T))
=20
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
