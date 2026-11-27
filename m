Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795797174;
	b=YCyxrZXo97AbOS7BSU8MVaOQaraseWXkmtHqCBIvBM8abk6QB0az5fE4OA1r195g2KcT
	 nJhVO1w+oP4LO7V+N3zfQcyEMT7nqFOvEJd3VZpw02uHKwYRDZ/5+wbwdTeE/xMsxkpEH
	 2n4WMQUScP8VRdPnSXANzMkSEkliQqyqzmYkZkCYajNAEmlCGog4i9KCjlHbLZ1K0Ypar
	 hjTas4dwlLt1v1LdID6RgHmOkJ4xVT0jRpt5yu9yIgM6zVvt1VUTGf+67T40GaFZjkLpF
	 brnr+pFuIgSudsXVNYkncPwSfw1qdJoDU23V1eXQ45AaKw00EaPhmu+yXLeLzPvFz1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Mailer:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
	b=im7ZI6yRAinpd98VkjxBCuFjNA6CgQPGwvlQloP65u41iiTw09NBvJlgANw/XLIY81va
	 OaPYlNc10bKfUxpl0Unm1VJlqu1DWO/dNhKktRlDvpGOt15DTnVBTrcRFUKPPSiygE4MU
	 8rWbLwpUTga+0Ju1O8m3wbzGpf3uZbnw/5PK0C6fPnTA+TF4DhYeF4m1+OElaEBpEar/n
	 pgr1Bgh2YGYVGA1jlGwdyAkzli5MKMLP4zT4zCA+uY9NYcf+xE867smnXGN5OLIwTgGmn
	 6VTqqV5wyo2VWv9UpI6fN4IBvizPssKYLbSQ9h88NFGPpyWq1OGuE9z3RVKR7ocXrhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=echophase.com;
	spf=pass smtp.mailfrom=echophase.com;
	dkim=pass header.d=echophase.com header.i=@echophase.com header.a=rsa-sha256 header.s=google header.b=nU7VRCMg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C0606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4C0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=echophase.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=echophase.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=echophase.com header.i=@echophase.com header.a=rsa-sha256 header.s=google header.b=nU7VRCMg
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b4d5e645d1so51780357b3.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795797173; cv=none;
        d=google.com; s=arc-20260327;
        b=knWDhsJ6/xe8D6qtejYZG8TtV3zvLsSt/hfeKNyW4Kj74vRo9HxhK1RkBz3fxJVKz2
         WdBlq2DcLsNbxRnBHsZdgbdea7bYUTkSruLXTNZ3LuXRHrg7OFFDRamn4oKpji68YeVP
         ClF9fSf3cfEODRigV4eJo6Luthse8sIClfaeAAS68tLqvBuRx2ttTWmwX6ztNVhdaueI
         JFf1qx9c/Pl+xE2gFiD9ln6pnZlKhpNIT/oEAymF51dXyHXJAO4FRFHrBFyib/th9PR1
         wDJqTuqamXgwk9U3PONZ23V9TmUbokAxq/jMJnfds+ZFxJf0B78lg7ONvadejqAt0kib
         aABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
        fh=iR85HXAEVQsZ1DNxvQE6s7TMRAy0VT1WogqbVtdTnQQ=;
        b=Vi/pIzC4ujQbD5gCh72wf+h/PzwzXNWLzeTCCKucEdsdXVbfC+/1Djcjj0ARDDs4NX
         9IoNurSP12zhtJmf8WyW/Ng0sZL0PtmUXbhJ+EzXsJ3/fgGdMepyibOhGYn/cx5ZDRLx
         tnK+w++1W9JtafCOVAR5+6J4XeARMLhvhIMiuSugJBeffPfO9pn8vVXmHXWcXR5rE36G
         phqsuLd8S20CfaQ3oeq++2z1q+C5lv9Q8mrQJcTfmY0wwqvbzOMe69XIu8iMfa5kH3Ap
         I7SNSCH/YtZSQpDi6gffk7Dse01JejVLSBfIxuAet0NxeD0drywQHCo3C/C8ADWEFiQ9
         l+ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=echophase.com; s=google; t=1795797173; x=1796401973; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
        b=nU7VRCMg6S/PeSbcDbddxdWo5UV71g1l2fPnpOLkBeJHmI9vd/VtSayPDD4kRpRLyL
         n30mU1diRB602R5GjrBWEK11PMzWVwFPDFMdbfX3zOVnhtYiJhipK271461Ahnt7Yu2j
         EBBIpeZK7iLzsCFsZHOZlYSjWk0KxQurIsoodiKn0DPM9Rb4dMKDzmAZgiyzStC8x9Jl
         Pjn8YwTY8PxnTUoiD6d0Mr8jKHAg+Ht5fddR715CorMfa7728u5pwAqNMOIF6baQVaSl
         2tzK1TW/qAVbfSOPjzZlRV6Cf66oqXNcO0DyT1D9Y1IsW77fm9WP6bqRC+Nc6zBybrXO
         p7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797173; x=1796401973;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
        b=SjE+vBqFGFE2dEOSWik3Rn3VBrfxFpnJbxxOE87W3ERiBAGnw94KhU7U6ea/lrjVaq
         xHMyJAxAC/cbpuHVSC0dGYmABusEZTJ5WlM7GzI5/bai7FYpWSj5dTB0SXt3G+T/33YX
         kJCtImeXPPmb9reYjw2o7BwmO9M5xvF4+pkY2YRU7jibu8jNNTO7/uhv7aXYf6LSMbdR
         dv8T17U2A54E6oS07cCC0QtGyKhz0olmQ/5+ewSAAnVlkYeD9Ate+Tc81qpHiT0Xnkzi
         LhMvebuTHLqq/cd4N2gZxWVe3n/sKnZryuT6s8Z1ZIWQDd3fNW/idzud6876Z7CKYdAM
         i0Aw==
X-Forwarded-Encrypted: i=1; AL+hErGIwvhbJLAoXyP8KPRDuUvv/uL+CsN2xUqu2cW2kyHccAEA8ZLmq5GqIfx8c77iqmyTrB2DF8E=@vger.kernel.org
X-Gm-Message-State: APuU4Z90LVYJo1iDm+nhXWgKkVRPQWn8P3maiBNnf0RJ1nX48OhF6FkJ
	eST9mAgjZivwIAMgctaiCTD7FujNEDxcBTc07na5WkyDGiJ6R3x9uagi6EzXxv0RmGZNm6aRUH7
	Iv3Ov/n+hHtoUxfJABiGY8d+aUr6Q1ruQI7e4+EB3Vg==
X-Gm-Gg: AZFdTZeLt+UCEsLDNL2RUE1BlsOcFblCJiAR6ySXi/5MpN9rxjFM9yyd+VAhnCcxBjS
	PQDAHMpk3Q7w+GUQpekx55qIBEAjZ/Q3MIea+kMxDerwOGg5N+XND/jX4zx9y5bEpCoFvodj2Nk
	vpDQ+akyjWQHTHygkjmV8Krduiegt07i/KC0rveE9pojKCV+F7cr0QJOet6BjdXhbY8oeR+nN+5
	rjyOLum3tX0cXgB5ExzkA5plHkhKPms8fyDndg9hEnezLqjh4H0txgSW1SELBWZyXJqaTg74cBa
	auGZgMGse9uxdByJm/Sr9OFAq7DkkyaoMNYBm/k/mGa7+6dTm+9i70hf2TwON7V0WHOp2sVxoos
	fR0MTtgwclN9KD+eFjVU5rECxnw3cYzAHxAZH3wpxdRLQmE1xrKt1CzHOKTCM7FR8W1P/ng==
X-Received: by 2002:a05:690e:47c7:20b0:679:ad63:6752 with SMTP id
 956f58d0204a3-67df4485df0mr6760668d50.88.1795797172525; Fri, 27 Nov 2026
 08:32:52 -0800 (PST)
Received: from 1009040482268 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Nov 2026 08:32:51 -0800
From: Ramon Nogueira <ramon@echophase.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 27 Nov 2026 08:32:51 -0800
X-Gm-Features: Aa3M54rMQUzpO4yRAeN4raM6katXNjxW27MCpyzDDVBLsa2OU0HqYrWxnLZTdwk
Message-ID: <CAMM96J2Ma3gSwZAtF2S2XNWxP4wBtN5VxYRY_KQO3fqNGztrEA@mail.gmail.com>
Subject: [PATCH] fs/dax: do not replace existing shared DAX entry on read faults
To: Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Shiyang Ruan <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ramon Nogueira <ramon@echophase.com>
Content-Type: text/plain; charset="UTF-8"

Commit c6f0b395b211 ("fsdax,xfs: set the shared flag when file extent is
shared") replaced the write-only cow check in dax_insert_entry() with
shared = iter->iomap.flags & IOMAP_F_SHARED so that
dax_associate_entry() receives shared=true on read faults of shared
extents as well as CoW write faults.

However, unmap_mapping_pages() and XArray entry replacement were also
switched from cow to shared. As a result, whenever a filesystem sets
IOMAP_F_SHARED on DAX read faults (such as XFS on reflinked extents via
xfs_read_iomap_begin()), every read fault on an already-populated entry
zaps all mappings of this file for that range and replaces the XArray
entry with an identical one.

Two processes (or distinct VMAs) reading the same page of a reflinked
DAX file then ping-pong: each read fault unmaps the other VMA's PTE,
causing repeated page faults, XArray entry lock contention, and TLB
shootdowns. Furthermore, a PTE read fault hitting an existing shared PMD
entry unmaps and overwrites the PMD entry with a PTE-flagged entry.

Keep shared for dax_associate_entry(), and restore cow = write && shared
to gate unmap_mapping_pages(), entry replacement of existing real
entries, and PAGECACHE_TAG_TOWRITE. First read faults on empty or zero
entries still enter the insertion branch and pass shared=true to
dax_associate_entry(), while subsequent read faults leave the existing
PTE or PMD entry and other mappings intact.

Fixes: c6f0b395b211 ("fsdax,xfs: set the shared flag when file extent
is shared")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Ramon Nogueira <ramon@echophase.com>
---
 fs/dax.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9d161d7ef..de3931788 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1078,11 +1078,12 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,
 	bool write = iter->flags & IOMAP_WRITE;
 	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
 	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
+	bool cow = write && shared;

 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);

-	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
+	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -1094,7 +1095,7 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,

 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;

 		dax_disassociate_entry(entry, mapping, false);
@@ -1102,12 +1103,13 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,
 					vmf->address, shared);

 		/*
-		 * Only swap our new entry into the page cache if the current
-		 * entry is a zero page or an empty entry.  If a normal PTE or
-		 * PMD entry is already in the cache, we leave it alone.  This
-		 * means that if we are trying to insert a PTE and the
-		 * existing entry is a PMD, we will just leave the PMD in the
-		 * tree and dirty it if necessary.
+		 * Only swap our new entry into the page cache on a CoW write
+		 * fault, or if the current entry is a zero page or an empty
+		 * entry.  If a normal PTE or PMD entry is already in the cache
+		 * on a read fault, we leave it alone.  This means that if we
+		 * are trying to insert a PTE and the existing entry is a PMD,
+		 * we will just leave the PMD in the tree and dirty it if
+		 * necessary.
 		 */
 		old = dax_lock_entry(xas, new_entry);
 		WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
@@ -1120,7 +1122,7 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);

-	if (write && shared)
+	if (cow)
 		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);

 	xas_unlock_irq(xas);

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.54.0 (Apple Git-157)
