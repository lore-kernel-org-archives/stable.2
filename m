Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793594817;
	b=j8npdhAHgVsj31Up8nckUujya1L2qOl1jl+RXR2NGRaz3MFWd31vJEJ+xjPCug0bZO54
	 LiyAFwwI9W+q7ewaiRNudqpAxPPlG3hsyOvKKl6DzVBLTUW7fMc+h8xVFqVWX3v7yXFu1
	 Z+Updgqv/puHXl5PUKa6G9MlSwnNSesH66up30PEpsjuFR4oF0sm8kzW009ZRzL3f1+bs
	 vKDOTz6VZsF7qAXGcKzpePAAT5+whFFncYQMkjIBGbv5z12wXY/YBL9IJY8s8zCHW80dj
	 KoalUGPZ+vpOINJNrMHg41BuswRNo0oQQZSrlfYiEr7s9CTJbtdCK90hYG1cNTckyNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793594817;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pRumD9wLinzEvAPlvHgnbog+/WM1mG1VlBridWjM71Y=;
	b=WS4yiDDdIl6MvtpiVU2qadTMduMLhTWAHhXFx84084MiVmKEDTtwASL8K1kFV27sEszW
	 xG2uqASxBt+zZmZDyOSiJSq6arDsAofC/Ru40eeqikEgQKpZ9QPcJETP549x7TNRgArF2
	 DhJXIsO6Lfa1I7Iwzo5NXnlfVD4gskPy4Z3xiDT3bPxsrbzXsm/o4quveBMVBmUrUhbx2
	 6WjNhEcHtXVQvJNzAlxneuiEU0ZbdmGA47CkFKyCeiMnWI3CbsA+GGcWtXrQQrPoWzX5L
	 qBenSZf43VulvfR9gaCYpnONCoDrzL2z75XYTCZeLpiWsHQ2bSVobz7P8FyWvtcydyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ou5yWqPu;
	arc=none smtp.remote-ip=91.218.175.77
Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD17606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 04:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD17606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ou5yWqPu
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pRumD9wLinzEvAPlvHgnbog+/WM1mG1VlBridWjM71Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793594814; v=1; x=1794199614;
 b=ou5yWqPuqDPK9MoS2gwOxtV0nJaHNjRepasuddqg99TIMooIrdJvtjgGZKpTZcF/gB3K4dzf
 F83dASp54zTsXmk8of1QtTgg8faFGLmsE3OBvH51el7fLTUHVJbVcULFotuBADSOIQMJ/xS1kDf
 fz+DlXYolSLhCfSHBhCNDdtk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eb600a511e081679;
	Mon, 02 Nov 2026 04:46:53 +0000
X-Mizu-Trace-ID: eb600a511e081679
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 14/47] mm/huge_memory: fix zapping migration entries for device-private THPs
Date: Mon,  2 Nov 2026 12:46:43 +0800
Message-ID: <20261102044643.33636-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-14-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-14-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:39:43AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>A PMD migration entry can refer to a device-private folio.
>zap_huge_pmd_folio() checks the folio type instead of the entry type,
>so it treats such a migration entry as a device-private entry.
>
>Installing the migration entry already removed the reverse mapping and
>dropped the mapping reference. Zapping it must not repeat those
>operations. Concurrent MADV_DONTNEED during migration back to system
>memory can trigger this.
>
>Check the PMD entry type using pmd_is_device_private_entry().
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
