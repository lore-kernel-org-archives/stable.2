Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507015;
	b=rX/XsblCRnxMogRyk2X5vjpGR+kRHB1DPf4DTPTYGBpfbs6W8cVi8W56c75FbcczCHsa
	 jynx1X/gR4X5U6PMnozEvMNM0xHMoOJdJQ6VfNg8nI2qKf5f+904wIf5p/pSGst6RHw5U
	 9kTqnGxs2sNPLfq8yJiAav60I5n+MsfibOFcxcrv8urALlmi3N9qZnxGmIS2z4RReGjIk
	 oB1IykS3luFRc2i197BuAzTmAuHI63rU9Ze2EuSiwxhUweI5PoW4j+vMuohWqxbVc+9X4
	 A6Vsj+mZ91CkRmP4atnwFoBCdS3yzjYFRT9jrcyzCsUnkbrr/DlcrkpfI7VSsXPQBMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507015;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dkoXTcH1JAkjWwF6GsRFSEWSiFpC/R5+hZya15+v0Xk=;
	b=ar0NGpDtI8paq6jJQWb5s8xlq98imvo8cCikX4sorFzxXKyzFrvuXuDJ3mmR/FuHGQMa
	 IH3qBQXxl9xv7gA7R3GJ1Dr4YxVf3isdcPuEy9lsMMwE+LLBvQlwazcwfiWnCzPTYu3hd
	 pCvhZO8z/CRZffQ42N4SXFIGxL1cgs2pFOk0jVGxo5LEY6rrk2gzrqiiEoOt8d00Wv+qI
	 3m28wPlsXDe4KPKN7cDlq3q49HagmbFPI8S/9J20LVw13UkvdbkXDiRgMs8LIXVyLqvgn
	 Hhf6FpI+muNK/OGEQWs9pJUJFSpvjFA+CjCmWeYvVL6Xii6BQa5u4p9VYFi1DrPkyxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LokYdQRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A04606A31E;
	Tue, 24 Nov 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LokYdQRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CE1F00AD4;
	Tue, 24 Nov 2026 07:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795507015;
	bh=dkoXTcH1JAkjWwF6GsRFSEWSiFpC/R5+hZya15+v0Xk=;
	h=From:Subject:Date:To:Cc;
	b=LokYdQRVeQL9w6siU2QHUOrjlKa5qeLIcwIEfHkEm+Tl+QY5A4isUBqDEYeIIfOyC
	 ynhYHavHuIYoffgRdyycob+JZxqt+i00MMasjRp5lMD9ht6rgwKeJyquDmBA0gxK3S
	 9kaEEbWJO+qg/z/yXyZ5zbAOL8SpEC6Z7FJ/0r7iTN+fqPeT79oLQM9WJokQjNlI+i
	 uP3WtnCDJtbNl53jH6gOFtq5ZXmOM75M7O4IPXoc8G6HL5STelDA2GMFpyfUN5StgL
	 jY2syRPmIPrQP3j2FlGHbKzubbD/RxWmkn0vJBhnPsUPx2IilBguxapmgjTnza5FjF
	 Xaef3I//eHBng==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 0/2] mm: fix deadlock on the folio lock when migrating
 and splitting folios
Date: Tue, 24 Nov 2026 08:56:42 +0100
Message-Id: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3WNywqDMBAAfyXs2RSzVbGe+h9FJCarbn2kJFZax
 H8vWnrscWCYWSGQZwpQiBU8LRzYTVAIjASYTk8tSbZQCMAYM6VQyZFbr2eqPJlB81hZ0nZwppd
 JQpgTYlZfLEQCHp4afh3pW/nl8KzvZOa9txsdh9n59/Fe1O79Nvh/sygZy/xs0kzlaR039bUnP
 9Fwcr6Fctu2D3h3uTLTAAAA
X-Change-ID: 20261121-migrate_reclaim_deadlock-44e28e226b9d
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2518; i=david@kernel.org;
 h=from:subject:message-id; bh=MPoyzCuILfG9ldGlrGnz5jnvIuovqvdkY8Yn+Us+N4c=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJZnW2/Rk+Z+sbf8+7ydXGvhUScHu97E99oXHHLs/TcD
 NGNSp68HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykfgYjwxaG2IO7A3fOM3Wc
 uapiI7vcmYVyJ//zZKX+3Mn+Rt6h7RzDf+fuf46KJ19db9M/0bm+4IsspyxHUV0S13x5cZXW7uk
 17AA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Whenever we allocate memory with __GFP_FS while holding folio locks, we
can deadlock on the folio lock when triggering direct reclaim or
compaction.

For example, evicting inodes with a populated page cache takes folio
locks, and if we happen to need one of the folio locks we already hold,
we'll deadlock.

FUSE makes this example easier to trigger, because it evicts inodes on
the last reference. A similar deadlock with FUSE was recently fixed in
FUSE [1].

Let's handle folio splitting by simply running in NOFS context. We only
perform small allocations, so it doesn't really make a difference.
Interestingly, this also fixes one of a handful of possible memcg v1
deadlocks.

For page migration, change the code to allocate destination folios
without holding folio locks, which is in any case the right thing to do
to reduce folio lock holding times.

Some of this might also be fixable using Jan's work on deferred inode
reclaim [2]. However, that is not stable material, and not allocating
folios while holding other folio locks is an improvement on its own.

Unprivileged users can trigger this deadlock with FUSE and
mbind()/migrate_pages(); however, it requires multiple NUMA nodes and
quite some luck.

I reproduced the original deadlocks with FUSE and made sure they can no
longer be triggered with these fixes. Further, I ran the usual migration
and folio splitting selftests.

[1] https://lore.kernel.org/all/20250925224404.2058035-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/all/20261009133253.20102-1-jack@suse.cz/

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Adjust cover letter (incl. subject), the patch descriptions and code
  comments: allocating with __GFP_FS while holding folio locks can
  deadlock also through compaction, independent of inode references
- Collect tags
- Link to v1: https://patch.msgid.link/20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org

---
David Hildenbrand (Arm) (2):
      mm/huge_memory: use NOFS when allocating while splitting folios
      mm/migrate: allocate destination folios before locking a batch

 mm/huge_memory.c |  10 +++++
 mm/migrate.c     | 133 +++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 106 insertions(+), 37 deletions(-)
---
base-commit: eb01811cc3713af1f78dfe18fa89c5270ebfc767
change-id: 20261121-migrate_reclaim_deadlock-44e28e226b9d

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

