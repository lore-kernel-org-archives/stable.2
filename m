Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434410;
	b=PTiKdwYLfjy6+3xiBaBzlB7OsvDSB2aSe8nbaUiZCVcbF3a7CNaBhZ8xDwk1Oe1ofpOQ
	 5pdyWOUjEC+vlronF9ENmrJz4UeXSBNhO6hwlIbQotAL3Sy0iouzYjCDDPiwoZfZHq0Fb
	 +oGmxzKlioY68TimGerBoNyrz8UGyA/t+Zg+R0VGjiy8bajEhbrAzZtpWBSez5YKzOTOg
	 cYPzniGNLi7RDWPFViqXFkXmHZgVtgc5MqPWCPKJkokN4ezfgWqdPXTEEaUVwC0m10a0R
	 uxtobjEJFFaztArdMvVx4ireFGZt7WUxCBmwpGd5AGqZoEmIV14b8DgveSlHjQ2a4pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434410;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0OVdX8T4PZFsw4ZwfqMzWpXCj72B541hV845/DfqAEM=;
	b=3r6nVgJY6GCx6gNK93sPSv49DWcBguMKiye5j3dhdEUn5ZNJ+YLuYoj1WMNKsNt0fdwL
	 bBFFa25VqYwaUKhsO/doVCmCmCriCSBLO7fLBZxza9eBmHQYEH4Q2WNaFmj6mRLBzIFSn
	 cmPUCTnmbu6OIigsQxjH3MDIXjV/aFMgVBp8T83NRcRskBkJSg9D/jvjvD5NXFdPgfF1X
	 7/GVEFnBW9i+xcBNLFWCtUh1TOiZihL/Qdb6MTtD0mNucNRPnCn3I+VmsBXdojK9PxxjW
	 7OAKJZKlyD5lZ2ZE8mIIBb5XcJYMshOxF6qsuPogyfAYDOdJZHdJWMYIsgN4Q/HW0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFzOCWMK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9B60A2634;
	Wed, 11 Nov 2026 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFzOCWMK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4881F00A05;
	Wed, 11 Nov 2026 22:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434409;
	bh=0OVdX8T4PZFsw4ZwfqMzWpXCj72B541hV845/DfqAEM=;
	h=From:Subject:Date:To:Cc;
	b=OFzOCWMKtLuxtENYeZ7QoRpXvdv8f9TcbIZTC0tztvZy3Zr9poC6dnlnbqhO7GyPP
	 C2T60v2kuEnzg0/1Wqy7Z//u8yowRRmO3jp0NVzHv9tTgcjn4C0PS3dCSTriPX7COE
	 A1O5F20dGpWSv4yJSILFo4OEam9B5HjeEmNgXFA43VAQWXX+BnKuqmlNTW98pXIpdT
	 0LtsqjcUSAKeWDgGElsVwNVo0ZYssvYq+1SndIjOYu6FAlCnyMbDgxtPnZNTXuSXFm
	 Y8QE+HYVnHGAOCwmkIckeqyhAcJz3y/R30bdIaY9NbxCTW32+VI1SRdQ/PzOLFql9e
	 Du8DxugwdrnAw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/3] mm: fix PTE table overruns with folded PMDs
Date: Wed, 11 Nov 2026 22:59:58 +0100
Message-Id: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAF7l9GoC/yXMSwqDMBSF4a3IHRuoEix1K0VCHiftFZuGJIog7
 r1pe2bf4PwHZSRGprE5KGHjzO9Q0bUN2acODwh21dRf+qGrE7FAFW0WKLvoV4RTCE4MN2Os9lJ
 6XKl+Y4Ln/de9T3/n1cyw5Ruj8/wA3sDMhHkAAAA=
X-Change-ID: 20261111-pte_table_clamped_end-69bbcaf44fe7
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, 
 Barry Song <baohua@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=david@kernel.org;
 h=from:subject:message-id; bh=4doLGZ+k/LEIRTS620iPxby3DjELTASeXofs3KT3y4U=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+PE2xFPCOMDjgLCXKLXR4H0+eto568Ya7O21jGWMKt
 nKe8wnpKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCKHRRn+110rN70bEOEktOiD
 pdS2dSl2P1PfuVZvdSs42HRw0RXrW4wMS30PaU8v2JMx54+sQaPMd7f8nn0SDFWCqqYOoUKKQXt
 4AA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Fix 3 pmd_addr_end() abusers that can result in PTE table overruns with
folded PMDs. Let's factor out a helper from a place where we
recently stumbled over something related, and use it to fix these 3
cases.

I'd call these more urgent because they can corrupt memory, although
folded PMDs are uncommon.

I'm planning on picking all 3 up.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (3):
      mm/userfaultfd: fix PTE table overruns in UFFDIO_MOVE
      mm/rmap: fix PTE table overruns during batched unmap
      mm/rmap: fix PTE table overruns during batched reference checks

 include/linux/pgtable.h | 24 ++++++++++++++++++++++++
 mm/memory.c             |  7 +------
 mm/rmap.c               |  4 ++--
 mm/userfaultfd.c        |  4 ++--
 4 files changed, 29 insertions(+), 10 deletions(-)

---

base-commit: d369ba5a46c65c54b94c94713ca1fb4ad6a87ebf

change-id: 20261111-pte_table_clamped_end-69bbcaf44fe7

--

Cheers,

David

