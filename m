Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727932;
	b=muUBquwHZiHqSxq1QJchGs1ddU4Q2mK7GAzSlPF8iahhAp5MpXJGj77192yatt/rEDiR
	 PYtvFSc5gTy4NK36EWZCRexoGncKXzPu7VQ/ZKzixueQdqAMzlZVXZCkb7oERSaPZa9y/
	 EisOIYiqtqmRVHscwMY+o1Ett/zO6eGlDxtcWUIgpdVaohNKeN7QSoLTt+Jo3erYRB2w1
	 ikl1wk7SNjTrEcwkUVHwjuD94ie0Koy4msKWQ9d0xJYtu6/B4CvqjQpP0+dy7F6hZTxTx
	 cXTz7bb1F0I4yutP9ww9szu1q4cNEiNq/9w8xEzrCsb3kLgDWruaVKfC5Bx2Mb62JUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727932;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=w4CqDwg7D7154OuRysg7R/98YqHxmOgh6GHFXhtckiw=;
	b=rZUEZPOawI/vwOAQZIsqRdc79Mk72uWji5q2CoCNvTuHjYYJVKSOWisthmD3deu6YUym
	 EuHPK5KnLRb2sCSROFBGMMSoppZ/ihD2Yt6Rdo5Ms0znnB/WYRQa2XYe1TuqoIaxY2gW2
	 p6/X0ymU4hY3iV7pnUushGemYejSPav7tXtmdnA91zfwauEXw+sfweN1QebSs4v1sLNVd
	 Mgf9ltlwGrwfDcy9zTrNcHIVniMqtBnqUiOU//NLxPNrkVMQtCYwgnwEnGVYUwI/j92e6
	 vb4VCqmxf97YRTjbRG2yHKQGbW/uoGsC82+QE1jMcGFsZzy+b4DZvkUtfC4MqbdjpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFshtLzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C8606A31C;
	Thu, 26 Nov 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFshtLzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08E21F000C1;
	Thu, 26 Nov 2026 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727932;
	bh=w4CqDwg7D7154OuRysg7R/98YqHxmOgh6GHFXhtckiw=;
	h=From:Subject:Date:To:Cc;
	b=eFshtLzJ/qZhIuDavJGMHhx0awqSSLOmqIK+rtEp3hFJGJsXGZp89mYuJ0A2oflwe
	 WPjABWLlBns1I6Gpe1W3XZGnCdq7jSWTGPUQyeOkVmmQRQy8IgxiawOkCmrG/1zgEO
	 eESU6WCiodorlDqXUIXFTOcA6BJ2tDqcXtW2yLhywgq0ZojA041FHtBYK2MknIb8MU
	 oJv4WcqlaWM1MpPY7fKv9kixGfxkcsNBzxM2tkOx+8ZvKYFk6ctt6Ocxu7uwKKFUZL
	 /UZgbnXSlWo4Nq25r/q2s7Gpew/DaW+ywHX7yhxv4/yrC2G+0LK2yGIXRSzA8sisTU
	 xuxNQUPxv3ikw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH net v2 0/4] net: skbuff: limit pagecache folio refcount
Date: Thu, 26 Nov 2026 22:18:36 +0100
Message-Id: <20261126-skb_refcount_overflow-v2-0-a6f600a5634a@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3WN0Q6CIBRAf4XdZ2mgoulT/9GcU7oo6aABUs357
 03rtdezs3NW8Og0eqjJCg6j9toaqEmaEJBjZwak+gY1gZSlBee8pH7qW4dK2sWE1kZ0arZPWoq
 OsSzHvKgQEgIPh0q/ju4VDAZovtAv/R1l2Iu7NmofrHsf98gP+Tc6/xlFThkVQvA+r0QuM3WZ0
 BmcT9YN0Gzb9gEfcs4u0gAAAA==
X-Change-ID: 20261117-skb_refcount_overflow-75a0034e469e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Rik van Riel <riel@surriel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5224; i=david@kernel.org;
 h=from:subject:message-id; bh=3E6okuV7gkYorzSuAVGWdCzZhWj30E+ec9fUig6K0PM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI5Fhn38llMXxfVz2q0s2jN+791KUdTQ3Se/9a7Xb/G8
 ay09bv8jlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACayTZCRYdfdXwv3Kr03PpUl
 v3XP76BOnjcqivlTt/s51jGtWzF3pxcjw3Kz/hluE1tXX7M+LxFt8GxbePipKOMJnzqUJmV9XX5
 3HwsA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

This is v2 of the remaining folio refcount overflow fixes that should go
through the net tree, ideally soon. They address the known cases where
networking can still overflow the folio refcount by taking unbounded
references.

The series is based on Linus' tree, which includes the MM prerequisite
c6c9a4c1c9a16 ("mm: limit pagecache folio refcount when splicing into
pipes") that adds the refcount limit checks to try_get_page().

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

Net paths that take folio references that I don't touch because the
references are either bounded or the paths are not relevant in practice:

 - skb_split(): each reference needs a new socket-charged skb.
 - IP-TFS reassembly: each reference needs a new inner skb.
 - io_uring zerocopy send: each piece is charged >= 4 KiB of TCP memory.
 - kTLS software splicing: only transfers references from the pipe.
 - kTLS device offload: pushing the record fails in skb_append_pagefrags()
   (patch #3), so a socket can exceed the limit by about one record.
 - AF_XDP zerocopy TX, nfsd splice reads, sockmap / sk_msg, espintcp:
   bounded, or require privileges / special setups.
 - Other driver-specific paths: not looked into for now, as I can neither
   test them nor see if they actually trigger unbounded references.
 - page_pool and net_iov frags: not pagecache pages.

The original refcount overflow problem was reported by Anthropic; we
knew that it was possible in theory, but didn't expect to have easy ways
to trigger it. After fixing the splice issue, I used AI to identify
other unbounded folio refcount users, and it flagged various skb-related
paths. I made it actually reproduce unbounded references. These patches
address the paths that were actually reproduced.

I ran tests before and after applying the changes, using a kernel with
reduced folio refcount limits. These tests focused on exercising the new
error paths and checking that the refcount limits were respected.

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
Changes in v2:
- "net: skbuff: limit folio refcount when copying skb frag references"
  - Fix skb_zerocopy() kernel-doc indentation
- "net: skbuff: limit folio refcount when splicing pages into skbs"
  - Mention nfsd connection teardown in the description
- "net: skbuff: limit folio refcount when splicing from sockets"
  - Propagate the error through an "err" pointer
  - Document the skb_splice_bits() return value
  - Update the description accordingly
  - Drop Pedro's Ack
- Extend the cover letter
- The GVE issue sashiko reported has already been fixed in commit
  3946899dbeac ("gve: fix RX page refcount overflow from INT_MAX
  pagecnt_bias").
- Link to v1: https://patch.msgid.link/20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org

---
David Hildenbrand (Arm) (4):
      net: skbuff: limit folio refcount when copying skb frag references
      net: skbuff: limit folio refcount when rearranging skb frags
      net: skbuff: limit folio refcount when splicing pages into skbs
      net: skbuff: limit folio refcount when splicing from sockets

 include/linux/skbuff_ref.h |  53 ++++++++++++++++++++
 net/core/skbuff.c          | 117 +++++++++++++++++++++++++++++----------------
 net/ipv4/tcp_output.c      |   8 ++--
 3 files changed, 134 insertions(+), 44 deletions(-)
---
base-commit: 63fdb511c27afcebce797e3db580b3534ddfa639
change-id: 20261117-skb_refcount_overflow-75a0034e469e

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

