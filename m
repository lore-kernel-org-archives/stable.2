Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663172;
	b=Paq3l1vzjQw+rpJ01nG6+41ELsYSEA3SuvZ1oe0g1MocrvyIA2UUTA4WBmDUJeRPkpoI
	 U9gFvVStan27T0v7SpMeKIRmG1Yn4Js51y+twZYjKZOK5GAVol+YYLGaZklUA+Gylt8e1
	 2Im52P6IUV6oN7CtylxaDIDhRZoi16BzDI8zhMwUE4vUF8Q88rnxRLUBRS48ePAa5+Cgv
	 T3mCH3LvowgKYZx0YitQtpOf5cgZkT63Q0CNMAEv6xmV002XWbJfX5EiMTQWp57f1WxVx
	 04R90WjCUlsqtxFA2t4lM50keeHiGdWfKOm264jZj8RgdSAV2UjU00BwnlEm60vhU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Yxjtd7ITOpLnK9Ydn1+OyRmk1OKK1ic8RSl9/4faQ90=;
	b=2ycMPQWmX1ECThXhTXfpen5BZ0lj92E4lE+dF/TVau2q3oWxxUQMoBAbOxpsKP75F1k/
	 QzO1QoBfBEdwDZOTozfEsRli7RhEuEnccDPMOZDfC8JOPoOH19YebAobPtuj2429vY3Ka
	 17A4TyxiYcXXuLghOZ5sJzjiLibHE0B2mBOSGXOUQPx3FA7vg9COTqUunLXMRJhLMBr4P
	 /wTEF9FU/REL+iKLLdqnAe70uJ8KoH5wTSNMSZpsIso0SBnF4XNzeokSOZbCXqPrVvaPH
	 Cx38h+JDB4iHqCt8XdxFmw+wI2nXJlT8ZsDgJ9VTB6nnXr6thFH6PYMpTB1XUrOFzQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dw9Bf5zb;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F075606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F075606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dw9Bf5zb
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c719669a8so38095906d6.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793663171; x=1794267971; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yxjtd7ITOpLnK9Ydn1+OyRmk1OKK1ic8RSl9/4faQ90=;
        b=dw9Bf5zbhT/LHv6N3Cd5UfDiunAomnWIeLawFdYik5WT8A6FwNdzwtTOtVx2aladgZ
         WqQpE59DeYdWo/EC0avTvxKUq9ObfVzyOTdZQAqJAUaxE3gj/Ot3PatFxcSF3V+FcvuU
         ZaV4GzJMayMYqr5WFL+77ONgLPxgnVprotpy1CUmowkaZRWYp/U53sJrP7ymwtspbpvt
         VCTrFnPSgV0J9qhEu1SOugDEY3nCAV500XKalXopTIoukfW7Y0XzXdi/eT665mDrKegC
         Sy3NzbHDqhhTuwZDsmZ8rJlNqxUXddnh4TcW5+E36WOaTyXLlVDm3CuT71hd1vpgczIj
         q6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663171; x=1794267971;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yxjtd7ITOpLnK9Ydn1+OyRmk1OKK1ic8RSl9/4faQ90=;
        b=cFYAB1XH5otZovqH0yLTEw5X/U/lys2gmHl8v+N1dceD1ZErMsc6AwHYBOfZPWeSCo
         PiYPtsLTIVnr5UO7+GcMyauLQijZSmgjFDTcdmtlZ7CvZGiD3vMn8iOx1WOq03KqQXtk
         67foHa2a3JQGLGCvbQBBCWgUsC4bVWPPjKOfwBSAbbEOYF/8CVpsnBEhZljUbehs9jx9
         /hajoE0jg2gnrucyut955FaqBNKPerJYLuxMnVMg8nyYkhHhBKcGEQG5uaq9IqCiMLHN
         luaj5wLnm0lHq+QCi8edRzdWJk7Nnlb67+Uiq2sWYaMMPzfi+2YCRJ2rWoR3SB5bVcCI
         fcvw==
X-Forwarded-Encrypted: i=1; AKwUvBz8Pu91GCqAlfKS3VSSEtB2hYItZQw5phUEAyWA70ok0oWDXQErA+V1dLEbSyG4Nmre4amg8Lk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2eHi6xHUgsylCWgBF7qSsT+ACfIPTacOLsmipasd3EuRCt29S
	aIabhOSfTQEM2WC2iVWY10QWFWGrN4OfLyked9PUobFm/kzVwRhR92u7xcf6MeR4kmCs7v/gIG/
	IW39mqHI=
X-Gm-Gg: AYBFou3qpmP0SuJ/W+LhqQN3vPyD3AIRBqiP91etWZ/2CX+KVypKrVsutVb6t08Jzvb
	56EN9QSgmsMo9ghtThq5VfBadvmR32l2LTDrpDUa+5ZiqVz5Opt9IJ2g4ocD9bVquacI8RTbMJq
	mrvHOPd7fUpBV28x/BdZ3THPDg+9tdo4q0839Lglvsg07XGy9hEb+HEtQOpu+GKr3LitnYXdi3Z
	M2A0YUj/AcuNijk8yM+KIEUyiqpc2zbicUDfDJ0RoH7f7JhnMx+nC4WxssYfDFWaHYfn1llTZvs
	gCRbytzUrGrICBrhqrVoMxJpIJ666GcUvG1AM++9dZXuyNnRSp+UbV9oPURNdtpeRixEhzBkh+f
	3ti0lEESNpppV/s79tiLc+bB74slPtPngMcz96SJRZVJpNOxKK83UMDuqD2TT8c43WYH37Pa3ZX
	MEFE5488l5DEmkc/eAJ284G4vf9QGRMRO6Q/pQzcK65FIeX6cw4wirsJmLu6nP3969NIiRN/nGh
	kv4sz1IZ7O9XUTS+XmO21tLQA27elSw7uxoQCv0NPn7hb0W4nATnDtK5cennkemhe+OQgxjM20g
	6sruR8r2Fz7v6d2qfqMRI69RiXwMAbxo0iadv+v4xfrAXlM=
X-Received: by 2002:a05:6214:4307:b0:914:563a:b3eb with SMTP id 6a1803df08f44-91ca4b5533amr194096836d6.40.1793663170876;
        Mon, 02 Nov 2026 15:46:10 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f47fd3sm103691496d6.23.2026.11.02.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:46:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 0/5] mm/mremap: fix accounting on a partial move
Date: Mon, 02 Nov 2026 23:45:56 +0000
Message-Id: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIALUg6WoC/32Oyw7CIBBFf6Vh7SjQ2lRX/ofpgsdoMRYIYFPT9
 N+FunPh8ty5c3IXEjEYjORcLSTgZKJxNgPfVUQNwt4RjM5MOOUtozUF2cAYcBQefECI/mkSsFr
 U+tjoVktN8me+3My8Wa/9l+NLPlCloioNKSKCDMKqoUSyOWzJr7lUBxOTC+9t4cSK8v+YiQEFx
 Tp+6hgTqOkludkoL6wWe+VG0q/r+gHq6uC++AAAAA==
X-Change-ID: 20261030-b4-mremap-pre-split-13a3d54d6dbd
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-mm@kvack.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793663165; l=2985;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=s4CWcZfvWLhqRxz92PYtTT9U/uiHoblpa21cuiD6XnE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJxPBVQz5GtEQyqH/3DXA/aj1WpmI7A15MOw43zYXcMCJk6SacRHt0ffoxLibgv7WpryUzXoMb3
 FOgnWJ8r6og0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com/

v1->v2:
- Dropped "mm/mremap: split first so a failed split is reported".  Every failure
  now left an unwanted split, for a benefit that only a doomed process would see
  (Lorenzo, Jose).  This is also why the series has a new subject.
- Patch 4: added vma_range_set_account() and used it on the success path too,
  shortened the comment, spelled the flag VMA_ACCOUNT_BIT in the subject and
  message (Lorenzo).
- Patch 1: dropped the comment above split_source_stays() (Lorenzo).
- Picked up the tags on patches 1, 2, 3 and 5.

--- Original email (v1) ---

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
Changes in v2:
- Link to v1: https://patch.msgid.link/20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com

---
Josef Bacik (5):
      mm/mremap: fix hugetlb reservation leak on partial move
      selftests/mm: test a partial mremap() of hugetlb memory
      mm/mremap: reaccount on unmap failure only if accounted
      mm/mremap: restore VMA_ACCOUNT_BIT if the unmap fails
      selftests/mm: test mremap() with an old size of 0

 mm/mremap.c                                 | 69 ++++++++++++++++-------------
 tools/testing/selftests/mm/hugetlb-mremap.c | 52 +++++++++++++++++++++-
 tools/testing/selftests/mm/mremap_test.c    | 52 +++++++++++++++++++++-
 3 files changed, 139 insertions(+), 34 deletions(-)
---
base-commit: a792d9193312d7cd897391d99e4a57b25772c099
change-id: 20261030-b4-mremap-pre-split-13a3d54d6dbd

