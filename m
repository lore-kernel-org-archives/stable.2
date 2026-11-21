Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269423;
	b=hQ2fM6x+OjF0wrSbV8noRUr8j9WTBr4lakjKmHMyZREUplrACW9vSW5qF3M4TFkJ3PFM
	 Cp/DEBdtNWDq+cfe7cglaS8ZFrF//HaIDE5Luiz8/X5RDa7YOYjE7zMB3YvJX6vBmT+y+
	 fqnxabgH11iYXv53Y3irmUmE+qCsJqM1Z1rXo0PJGjWEB15HRb9e+V934LQGa54n302jl
	 mKktsldZr1bCd+qv+hSkqJRPt9ANnAklmHx0UXj/3YWBarCsSm07Ubc49Oc2uHlkg09Yp
	 H5xF2lRD+AwznwWKZkvGxEvKF8cezBkxDAZSoapQV3VTOEiPBgrqwtncRDrMPInaqeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269423;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8fbi8SKYEmimWwzcAJCb/Iw8VERRi9h+ewVDVx62V7k=;
	b=hEh8X8K70S25quZTtaeLgzYXbh7ZuPtXq5k6MvSmQfdg9e/rxQRfGUL71RVvG38aGTcE
	 NIcdjJtkjT5xo5qM13GR3pDbyeC+6FdGWtz88MLVFZBfpzqYl0/K+0euvAKeQ83oWE4sP
	 QIjxNDgeSLX4oI27A/h2dPVqNQUMt/Em3WPdl66wpuaQFHJcy0uEDbZNx1lG2eb+amRL0
	 LazVIj4KWENH5DHKlcP0vE/1qe8R03isEtXuxvZF3OptrPWM79NtREnrUiIEFmww7eDOo
	 0p2sfKl8kV/HkBkkApHOynNeK6TY8HLCHki6/vtuCXMhY/ZYWBdlzaZ/1IELuGrEU4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=drJRkBJz;
	arc=none smtp.remote-ip=91.218.175.202
Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA8606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6DA8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=drJRkBJz
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NmCQl4nB3mRaHwm/PSfYdzE7Clk6o/3ZS2Gtsu3olLA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795269419; v=1; x=1795874219;
 b=drJRkBJzDKGuLccQ7Xm5/fq1JbuX3lE1BWj4G+Ac6+XhRs4foeHhRc6wgayUn4rt4fhUb8av
 MjEYk4c/Iy3vzLx2q4p2Ph3PBjFZkTt8nG7eGUp8XE0zBkCJUQo5jc0MO5dVoE/CQl0XF6zetf3
 QhxEc5J/qBw8GnMt3N/ceAS4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7a4d5ced90134022;
	Sat, 21 Nov 2026 13:56:59 +0000
X-Mizu-Trace-ID: 7a4d5ced90134022
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Brian Geffon <bgeffon@google.com>,
	Denis Plotnikov <dplotnikov@virtuozzo.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Martin Cracauer <cracauer@cons.org>,
	Marty McFadden <mcfadden8@llnl.gov>,
	Maya Gokhale <gokhale2@llnl.gov>,
	Pavel Emelyanov <xemul@openvz.org>,
	Rik van Riel <riel@surriel.com>,
	Shaohua Li <shli@fb.com>,
	James Houghton <jthoughton@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	SJ Park <sj@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 6.1.y v2 0/3] mm/ksm: fix userfaultfd protection on 6.1
Date: Sat, 21 Nov 2026 21:56:50 +0800
Message-ID: <20261121135653.3466-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261111105034.51632-1-lance.yang@linux.dev>
References: <20261111105034.51632-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sasha,

Could we take David's two KSM patches first for 6.1.y? Both cherry-pick
cleanly. 6.1 already has FAULT_FLAG_UNSHARE, but KSM still breaks COW with
a fake write fault.

Patch 2 needs patch 1, and patch 3 needs both.

Thanks,
Lance

v1 -> v2:
 - Rebase onto the stable queue and move the uffd-wp check below
   the soft-dirty block (per Sasha).
 - https://lore.kernel.org/r/20261111105034.51632-1-lance.yang@linux.dev/

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Xu Xin <xu.xin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Martin Cracauer <cracauer@cons.org>
Cc: Marty McFadden <mcfadden8@llnl.gov>
Cc: Maya Gokhale <gokhale2@llnl.gov>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shaohua Li <shli@fb.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: SJ Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: David Hildenbrand <david@kernel.org>

David Hildenbrand (2):
  mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
  mm/ksm: fix KSM COW breaking with userfaultfd-wp via
    FAULT_FLAG_UNSHARE

Lance Yang (1):
  mm/ksm: fix userfaultfd protection during merge and unmerge

 mm/ksm.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

-- 
2.49.0

