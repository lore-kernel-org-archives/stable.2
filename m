Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371384;
	b=wOk86jqoof25dPzfYXlBVKPs6yuYMkDusl64kShVd+WqTxNmhUmvt4Blf7BD/CSc6Qlp
	 ukO3sjF44yW29I/mLU2rQswvGfAVqQkzWPE1Js2z47vth/VB6qmSJbfIo+21JzixY+1ip
	 YnPjnRp5+zAs2E1Sn+BkPIrlpqg32QPAAnUval+ouuuCzTR0SIjRk1ogQQvaBIyKO0fCL
	 vFOAu6gg/LJ69560ppwcViARLyXcxsPgUNJ9svZG3wVRWcu10tA40/mRm5DtEkC2h6RaJ
	 aG/o6eGcqVRe7lhj5Ydd/cxsf9xQFLo2YjFxxBsvfaFJJdwLE0I80GUVSTYj4G+87rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TtQPujh2Z6EFGDVb1MA2CbjYL8flrdHZZ0jYfe7yfAM=;
	b=MDscAJT+xDUx/9ZSu9B8qy6wr1trC/zVQMwcWOopLEObyNpL2+b2RNuW6CW+p4ZQUU2q
	 z/EAcyDY2qzofRp/EhN3QBAMFch2XgQSQ6HaGmH1RbUOgK45FFEm4NQdmMWJ6xcy6op5I
	 amgZ6iiYSMZFGiJbYc6GyqXMVU4dk4Lpc3RvFDthxwXXxKC00oUs8afFsHFCyLR32Aywx
	 zPbv2ot6PzSgYna4nLUVL0T37CG+SAMG/eR57GDkYxuBaBUJAJF1v9kK/hJG/rrA370Ic
	 VAVwzCjL+Ywl/AKfBmiH2YRBmKO4vNgid9GSqx4uUbQa5iBmsb2Uod10TA4GWaho5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=b3yCYVHw;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E508606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E508606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=b3yCYVHw
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e47347279so518617f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371383; x=1793976183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TtQPujh2Z6EFGDVb1MA2CbjYL8flrdHZZ0jYfe7yfAM=;
        b=b3yCYVHww6aVOhtkhv4R20TxL29S4DnDcUaX1jN/gpnLkIb15PNR9gMfAy4bEByaFq
         ZmJXreAJHeX4clIgPRD4SoDZhPFEjeIQ0zviTUDss8uPkyq/ZPX/CnV0QtoSDEnmysvq
         WM9yD2FbziXF4NgvK71CHJp6/46gj6hDRwuAk1vSGFbpI/2mlJ5JzytwkOUoEkn86g6W
         FJ95PqEskE8GCJqMbtRzItQSckOZAwkG6kTRYRSsb6QqzrPilbqr9zNB0xm9O3luApyC
         UV0fIO66u3Y+OooJ+Y1ks+8s8sihlqeAsFd0bi5Ohn5HGTurFIxezD0ZjFF5hAgj3IMy
         uPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371383; x=1793976183;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TtQPujh2Z6EFGDVb1MA2CbjYL8flrdHZZ0jYfe7yfAM=;
        b=rTSjKL3nxdJR8ImDynAcUEsO9q7LZzgZCpQ1zgtUvjIdQGHv6ZWnAGPx8lGf3M/lNJ
         JncfmNRu7EZl0oT4QGeptOG6CABrRzL7ULyo4y0KYJz4M9oceSGXcV5gT45w7olOKAa2
         43h0QofRTyqCpX0HvHFurWPSATlR3vGeWttiO4qV8uBTLQBQ7QWaldJKuHLOde5a0c0o
         Iv4sW6yilkFbRr15if9vGYeuJ/hfM3XP9l+vuvqGDqyHn6QvckriMEiFHpbrl//V+Jwt
         DxGnFwhVKwYJGrEd9Ns+kzRfEs6NvckfbMqmWdc6e7tCxNWcvzz3UQQm9ZhFso+Xi9kn
         M7MA==
X-Forwarded-Encrypted: i=1; AKwUvBzUd1hUfMk9PMKN1tcGu1sP9ga9oB2zs96SGEjtdZ5n7PnDpDBOyqcIx0Sjsfq88hMvmBXFhh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkjVgdd5vlF5uEfC2NBwcVifl0ch7mjftjufBEPWeKzhazL9+3
	69kRrhzZXUhnQR3emWvGhOF5sCUsMRpjsjwP73ZM/GSjzpKpESs4wTmPa791P6CfdV8=
X-Gm-Gg: AYBFou1ct6c+lGgWAPyPpE4hmAW1wavUQJ7U7YFSEAH3aMUkIhTnGQ02+wAUQDuaNid
	YqynA5OzldIHwAfTgj2qXnCN4gbdlUvrl1qr2Q9TMkmVe1IdfVtPcnYrVpPTKzSPThJfPaTV01J
	sFWClSiSRdppVmvzJCjvGn6tz8fg7N2coizgqvjAzYHTcjwncdaMx5esKH+QjrCiYeV5za0/9eO
	bSpwVExXKXruveBwLOlBOAklIgmQnVwR0ZvpdKZHAVQrnQPO6NxHcfaEwvPs+nTk869OpRY/5Wm
	GmuzktJSVMnwNdRUW1HnJLihe+FGdPnW04MjbyJfqgWKtTEfph8sQDjVogZK2BxcUZXcNmxLKEL
	HOM1M4bCdY1PAirvch+XUIIHabhIVBFhtGFiFzDXccqGV3/5fpbWI6XhaWqi6ObpWa96qo/MpFH
	5Y2us/uwZtuLRv7nI3/UxXKtnjLtC15FwdPqVAWc1QItvfJU4cOXgKIzNMo23JyfjB68CwCPcRL
	l8d8Nu07lXijxQiqvCwBY61oVkxmyePgCE30YAlM9ERFDXMLnEr8i/hMNRmWYVU+PWuqNeT6oEn
	+GbHHbCydXbOERnHEjzRAYzzKRClim4elI/jjVCvwiv+KQ==
X-Received: by 2002:a5d:5d13:0:b0:48e:103e:846f with SMTP id ffacd0b85a97d-48e6e2f91b5mr6296751f8f.9.1793371382383;
        Fri, 30 Oct 2026 07:43:02 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725a2sm3454862f8f.13.2026.10.30.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:43:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/6] mm/mremap: report a failed split before moving
 anything
Date: Fri, 30 Oct 2026 14:42:45 +0000
Message-Id: <20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOas5GoC/12MSQ7CMAxFr1J5jUXShC64CmKRwVAjGqK4RUhV7
 05SdizfH94KQoVJ4NytUOjNwq9UQR86CKNLd0KOlaFX/aCVUegtToUmlzEXQslPnlEbZ+LJxiH
 6CPVZmxt/duvl+mNZ/IPC3FRt4Z0Q+uJSGFvk7XFP/s2wbV+l5uH3ogAAAA==
X-Change-ID: 20261030-b4-mremap-pre-split-13a3d54d6dbd
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371378; l=2256;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=G/p9kYfhBVnc/GDhjsqodhiJwDhAqmNFszrnjyTOZ4s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOVY24ule8ljYjad9dt1Lw9nOAlvfltuTV+PDM67JYWqeppOo9Jmy+Kkc2B3S2JvFWR+cGruJ6p
 hK8DCrLOWkw0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

I went through the callers of __split_vma() to see who can't cope with
it failing, and mremap() is the bad one.  If you move part of a VMA we
don't split it until the very end, when we unmap the old range.  By then
the page tables have moved and there's nothing to go back to, so we fix
up the accounting and return success with the old range still mapped.

Lorenzo recently added a way to split ahead of the move for the mlock()
+ MREMAP_DONTUNMAP case.  This series uses that for every move that
unmaps its source, so a split that fails is reported before we've done
anything.

Doing that turned up a real bug in hugetlb.  We take the reservation map
away from the whole old VMA before the part that's moving is split off,
so the parts that stay never give their reservations back.  That fix is
the first patch so it can go to stable by itself, and the second patch
is a selftest for it.

The next two fix the accounting for when the unmap at the end does fail,
we either charged memory that was never accounted or lost track of the
charge for the whole VMA.  That gets a lot harder to hit with the last
patch but it's still possible.  There's also a test for an old size of
0, which nothing covered.

I tested this with the mm selftests and with a loop that fails each
allocation inside mremap() in turn and checks that we either moved or
didn't.  The numbers for moving part of a mapping don't change.  Thanks,

Josef

---
Josef Bacik (6):
      mm/mremap: fix hugetlb reservation leak on partial move
      selftests/mm: test a partial mremap() of hugetlb memory
      mm/mremap: reaccount on unmap failure only if accounted
      mm/mremap: restore VM_ACCOUNT if the unmap fails
      selftests/mm: test mremap() with an old size of 0
      mm/mremap: split first so a failed split is reported

 mm/mremap.c                                 | 55 +++++++++++++++++++++++------
 tools/testing/selftests/mm/hugetlb-mremap.c | 52 +++++++++++++++++++++++++--
 tools/testing/selftests/mm/mremap_test.c    | 52 ++++++++++++++++++++++++++-
 3 files changed, 145 insertions(+), 14 deletions(-)
---
base-commit: cd1d0b147afa81f80927f9711e53401703964217
change-id: 20261030-b4-mremap-pre-split-13a3d54d6dbd

