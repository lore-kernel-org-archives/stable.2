Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990779;
	b=sNTZ/rta7g2ZohrdRme0dMgwhQzmr4T4VnfiNfnAiAG/LE3LCNjZ/vGm532m/zvG8PX3
	 ZtQxBUQ7VVE8A4/rWgEsfsENifS3IZ2JtTy/MLJAQS2s4q5oNNgGWU65qMjTZoQqPWhLs
	 26L4BpOz24tI7XkwPQ3rtPeqsZwFa9raDMJDSzAuWPzjY6ce8C2YK1h07264ck4QPTE26
	 ZKgvVF3pSfXBQTOBSL/mzWfN0uhmWPdS2pOR7TOHbS2C4pq0oTuSdjTa6mhxHqtyMtlEe
	 DsB9V6q3/b4wmBlmoZrs2A1y0QXQ2Fr/XVzogRMeCvHDkuw13siChAOowKJyL/a5gwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990779;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Qek8ua6eHIWYT1YV4GUxD472coOCwQ3P3ofziBmkSG8=;
	b=39RBHPOnvcxuXgdIqcsO6lIGN0ib8G2TpBq96BktLCwJqsihBW46Nwq+T/MX0QIu71rn
	 xTyxyM4yn/byjVV+Oc2vPfrb+0yDM86BO7A99esGkS8Co4usP3p8EMorBIht9TswkLGc2
	 bTCetYUpE+2AkjAzVtOqS0QElLiHLrWiNL5lcgcUi7M/eI4O8FlQhGMNWNQ9l5xcLVWk9
	 ie6wtg/KZxbCqEbGR7lIyibzICWv2RHOkcvuHHnk0afK/MwqUcvbbjTn7ug9IxzmtGWli
	 m3RG4HB1b1Us/sJ0tMG6QE1UapChfNcESKmoei1xdBcKNiXsn9mr8fuWpWHw5RExocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPcmpMZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBA606A330;
	Wed, 18 Nov 2026 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPcmpMZh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EC71F000C4;
	Wed, 18 Nov 2026 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990779;
	bh=Qek8ua6eHIWYT1YV4GUxD472coOCwQ3P3ofziBmkSG8=;
	h=From:Subject:Date:To:Cc;
	b=TPcmpMZhO0E9IMO+M/7wTgzTQ2TyFstj/Hj+fNtnOMRKBWcJqzyi8s7x04ufgxJFd
	 OtJYU6U5t2nZD0FUmpj7zSf+U5NT7MGA7XRcJ2sHhi+NfxDnqkY6SqqKAlE7eVnB+I
	 NT7J20qxcy9ZmkJujA0x2lYF5Bb6x9nDx90TumXAKYz6Pil0r/Ayu2gt469KNWCZvV
	 RvORY4Hd8pvhYKUMCk70Xr/Aco2Xd/rZLIcbM0gYpzGLMOvJb0HF5TNPfopYUPDLbc
	 9RTa5Rkw3PUs62EGj5NCmLRSKJilXTpOF7mgOtEE1b7sRACFc59b3lJgr0BMbDyNfT
	 nJG2hK9WFR+/w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH net 0/4] net: skbuff: limit pagecache folio refcount
Date: Wed, 18 Nov 2026 09:32:37 +0100
Message-Id: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAKVi/WoC/yWMUQ6CMBAFr0L2myYtIkSvQgyB8pBF05puQRLC3
 a36OS9vZidBYAhds50CVhb2LoHJM7JT5+5QPCSmQheVMaZW8ujbgNH6xcXWrwjj079Vfe60PpU
 oqwsoua904e3Xbcgh0u0/ytLPsPFbpOP4AB4RvCt+AAAA
X-Change-ID: 20261117-skb_refcount_overflow-75a0034e469e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Rik van Riel <riel@surriel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3989; i=david@kernel.org;
 h=from:subject:message-id; bh=HZyNAn6wVm0K2Mhg0A9sA6QcH+I9r4/teclsbJx4eJw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+Jm3wWrFjxcEbfiITHJoX5ZVsj1s48ZxM8vs3nhO3P
 P3qzcPd3FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEDrAy/A/tvLe6MnPBnjM7
 w+77vZ+zOHT5ro8vY/eGNgr+ZdSaNLOIkeHCd+fXxWxWZx84sjmvaObkq/uwybXEPFZlsv8CU4k
 3u7kB
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

these four patches were hidden in the MM series "mm: limit pagecache folio
refcount" [1], initially as RFC, then as regular patches after review.

I'm resending them separately now to catch the networking maintainers'
attention ;)

The MM prerequisites are now in Linus' tree, on which this series is
based. It includes c6c9a4c1c9a16 ("mm: limit pagecache folio refcount when
splicing into pipes"), which adds the refcount limit checks to
try_get_page().

These remaining fixes should go through the net tree, ideally soon to
address the remaining known cases where networking can overflow the
folio refcount by taking unbounded references.

More details in [1], but in essence:

There are ways to overflow the folio refcount and cause trouble either
by letting it go negative or letting it go all the way back to 0.

This is particularly easy with large pagecache folios, where page table
mappings can "easily" create many references. The MM changes limit
references from page tables, GUP and pipes, and leave some headroom for
races, other bounded refcount users etc.

However, skbs can easily multiply folio references, so any such skb path
that can take unbounded folio references must also obey the new limits: we
must use try_get_page() to obtain an additional folio reference and handle
failures accordingly.

Patch #1 introduces skb_frag_try_ref() and skb_frags_try_ref() and uses
them when copying skb frag references. Patch #2 covers rearranging
frags. Patches #3 and #4 cover splicing pages into skbs and splicing data
from sockets into pipes.

We use existing failure paths where possible. Socket splicing returns
the bytes already spliced, or -EFAULT if no data could be spliced because
try_get_page() failed.

skb_split() is left alone: each additional reference requires another
socket-charged skb, and making skb_split() fail requires more churn.
The handling of page_pool and net_iov references is kept unchanged.

The original refcount overflow problem was reported by Anthropic; we
knew that it was possible in theory, but didn't expect to have easy ways
to trigger it. After fixing the splice issue, I used AI to identify
other unbounded folio refcount users, and it flagged various skb-related
paths. I made it actually reproduce unbounded references. These patches
address the paths that were actually reproduced.

When testing the original series, I ran tests before and after applying
the changes, using a kernel with reduced folio refcount limits. These
tests focused on exercising the new error paths and checking that the
refcount limits were respected.

These tests covered AF_PACKET, nft dup, NFQUEUE, software GSO
segmentation, TCP receive coalescing with dropped ACKs, and socket
splicing.

I also ran the following networking selftests successfully:

 - net:tls
 - net:udp_splice_checksum
 - net:udpgso.sh
 - net:msg_zerocopy.sh

If there are any further tests I can run, please let me know; help with
testing would be appreciated as well, as I only have access to limited
hardware and have limited net experience in general.

[1] https://lore.kernel.org/linux-mm/20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org/

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (4):
      net: skbuff: limit folio refcount when copying skb frag references
      net: skbuff: limit folio refcount when rearranging skb frags
      net: skbuff: limit folio refcount when splicing pages into skbs
      net: skbuff: limit folio refcount when splicing from sockets

 include/linux/skbuff_ref.h |  53 ++++++++++++++
 net/core/skbuff.c          | 169 ++++++++++++++++++++++++++++-----------------
 net/ipv4/tcp_output.c      |   8 ++-
 3 files changed, 162 insertions(+), 68 deletions(-)

---

base-commit: 63fdb511c27afcebce797e3db580b3534ddfa639

change-id: 20261117-skb_refcount_overflow-75a0034e469e

--

Cheers,

David

