Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6B38D;
	Sat,  1 Aug 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785587139; cv=none; b=RvNmq8+bqLQHykbta3p7g/W4l8aGr3h6zolgGHY71IJUyuCzInpqEGh4tY9Y93wYX0CL1Dy2iqDGgxvGGm9k1FuWjy8Vl8MQGafrNG0QJljWWPNdYh6es42x910UVRXtyG7BN0PhLU13ztn/M0L79cZsO5E7dWZoaOgsVRiZfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785587139; c=relaxed/simple;
	bh=Ga+ZWuTCZpnEl5RqwuNDpP/3yRfPfxMKs2jTzArs5Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv5nwBENJKJnRHyWaE6vNVYarKegiJW3VDVJCy4ffd8Jel4MYGWHH9e5EQmR8bQZPq84WuOuUqu61yYfxnuTbu2Hw2CriIvrkxcZ/z8g/qNZH26wMI9Ndb9iFGO3/QBo4iEQZBMaMf1f5cT/k1TW07y6Hqd9TQp3mcj1tk9VrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grZG658/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grZG658/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1291F00AC4;
	Sat,  1 Aug 2026 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785587138;
	bh=PD2Ei2+8ZcRVLYaWR53BggaFC4sYxGX7KYSUUWTxUwY=;
	h=From:To:Cc:Subject:Date;
	b=grZG658/Jsc0+VSH9kZVTG/rifLiIzTDCAM6GXUdikVf+U91KKt8zBWiG1SZaspJT
	 rQ5e3K5kOj2T8PMJbEaW1Ym/LYsdrW2/TMtyuFPDKCjJawxwEnb5pISycvHb7m8KEY
	 nAWff0bRo+H6a7W6/rNr3fTl5pqEwW2+Lur4osJWFPRz4uYtX4Wv7LmMc1qfeTlnf9
	 /Mb2JO67/jtHUikhKxDcjjFDKwLM4Pod4S4rLXL069dCMXLCQzLY+tKLlXdcLcIGuc
	 CoApczKR8kMa1XgVyQRC/ypbjpUJhnf6PA/YwOGeTJ3vpXr7ihyE0XY1k1GJ6Ydfzm
	 2LnFsaq0rKDnQ==
From: Harry Yoo <harry@kernel.org>
To: Danielle Costantino <dcostantino@meta.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [7.1.y 0/3] mm/slab: fix unbounded recursion in free path with memalloc profiling 
Date: Sat,  1 Aug 2026 12:25:30 +0000
Message-ID: <20260801122533.319272-1-harry@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Harry Yoo" <harry@kernel.org>

This is backport of "mm/slab: fix unbounded recursion in free path with
memalloc profiling" series [1] for 7.1.

The last patch has a slight functional difference compared to mainline
due to lack of SLAB_ALLOC_* flags. I described those subtlties in the
backporting notes in detail.

[1] https://lore.kernel.org/all/20260713-kmalloc-no-objext-v3-0-47c7bd138de7@kernel.org

Harry Yoo (Oracle) (3):
  mm/slab: decouple SLAB_NO_SHEAVES from SLAB_NO_OBJ_EXT
  lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
  mm/slab: prevent unbounded recursion in free path with new kmalloc
    type

 include/linux/alloc_tag.h |  3 ++
 include/linux/slab.h      | 19 +++++++-
 lib/alloc_tag.c           |  9 ++++
 mm/slab.h                 | 28 ++++++++++-
 mm/slab_common.c          | 13 ++++++
 mm/slub.c                 | 97 +++++++++++++++------------------------
 6 files changed, 104 insertions(+), 65 deletions(-)

-- 
2.53.0

