Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394248;
	b=eGQ8DRS/UehMU3OshKlv9DoNwLxtobyN8CDBWglkRTf7JGk4+vQ13n8pN+wCwOAIlVA7
	 JVE0KCkJWFFjt2cZwVqcn9XEk2+eIf0MQR+FM6KSBF7Lfs7/ql49NZNRcCWvRbnwN/Yy9
	 62i1iZwmmgOxmuA3a8TfvAykdljdMjfbtPr0TLUlNS8UMLDAiSt1UWBQc0KqK9vqVzYRX
	 Pb2WZhtrjm41ZukhtHcCPZG2LHMH1+QFQpWC1oBnU271JFrYPVSKMsw6OSdWony89ujDc
	 JGNBPUQDQqs/Yc5ZBxwP93kRmrZPojE66UxwLcTmIFwIuCSn/HcTWaX7AoA4O1NZE+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394248;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j/Qyg1UyMf8yIhlGF9VG32ssBLq84ZvPcoVqm2IS3x8=;
	b=AgUJwsAOO8lbzUnf08tFpd+GPFvYJNGle0klkdXa6/FUGLFQgy6XmaBtaNfZyZR6Ob8d
	 HqaVx+nAi1oftN62RYHf4m0w7EegDXfxIaNuIW5MvxkX/4zxJztrkM0RxvnYllaZYKYbT
	 RlTFVhD7rQyVWBbx8fVA8pL1V9HD1TMr0bSwmdTy5zQo4dS27kC3XLHEgkGMFy9vD8PfS
	 J0rzRZwzKUXfWovUgLquQAfxGKfbOqz33nFAaOFKB8mmJiHFWHZLU6/FGCbSPQZoeIyhk
	 A0rHSvuvDMNKPEyRCrzDMolgffOURvg7Hoh0TyYunOmFD3zGMWy9y20hkIGa5tn3wpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ORypB0v0;
	arc=none smtp.remote-ip=95.215.58.71
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F5606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D5F5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ORypB0v0
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UfTczrnCMjiFHwHorGJcb8GhQ4eklNGiv8MK9V3Ny84=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794394245; v=1; x=1794999045;
 b=ORypB0v001MkwS8fumOipnttyLz+lRBx00dG86O5RCypz+ePzNLYrRRg6VHpu7RCavrAh5kG
 e+CQjUt7KFxO8Vm8qI+Coe9MtUkedf513wHWQzyrYJmqsiX/gZYbW/0MQQrWYBoqjQHfOq/q9XF
 LejYt9rK4T+zqhLRaps6Bhsc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4dd8d3a39f7a78f4;
	Wed, 11 Nov 2026 10:50:45 +0000
X-Mizu-Trace-ID: 4dd8d3a39f7a78f4
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
Subject: [PATCH 6.1.y 0/3] mm/ksm: fix userfaultfd protection on 6.1
Date: Wed, 11 Nov 2026 18:50:31 +0800
Message-ID: <20261111105034.51632-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109201707-failed-6.1-990d6c2194a9@kernel.org>
References: <20261109201707-failed-6.1-990d6c2194a9@kernel.org>
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

