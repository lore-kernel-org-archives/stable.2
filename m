Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A74219F2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135129; cv=none; b=DEyVgoJ7kjoQVwRzWY9hR7kkJff0cNIN146WURLvB4wey8KKEaF23AZmCpbGpFlPNMSMjuzDNiYTD9qhk3lptO06IHqW7mutP5GBYBicr0D5FYPoGNs3xM+4YB5e4Q/D4Ojl2b2J9DbjPpdnC+ywHMiclq/4qiDlOVrWowmC8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135129; c=relaxed/simple;
	bh=6EH9Q+NY8085/trt7WRYQhIUKmAyNfguuH/JmIdbxLM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qvdPnuYVeXXU7TXah7WigcQJ3A3Zvi/GBD1Nr+/o9cNbETLawiGKzjfNqFe5CcurtmKJhTU5/3bFpDLtlKyjkweaPLRWztgCVRJGMA/CZnp07KYl91S2oBfZbgmZPuKkp9xEMHJXX8hsCuknc2toRyS3uJS56Ivuhg3ClVwPVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWur2hR/; arc=none smtp.client-ip=91.218.175.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWur2hR/"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6EH9Q+NY8085/trt7WRYQhIUKmAyNfguuH/JmIdbxLM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792135119; v=1; x=1792739919;
 b=FWur2hR/Sys1Ij2jDNya4lxwxZ1f1O9AxnsY8LPGpQVE8/op5gein9OQzniCYz+dC79eBW+L
 QpmBSECh8CbYjG8MOSezh8rmET8Zu37vgS3qrLllzK5xya/XkZrb7MK7HTXiZEhZmB4YSnmy5Fd
 0Avx6K3H8UJ8p8Kp201mtP2k=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 986970ad1353ee4d;
	Fri, 16 Oct 2026 07:18:39 +0000
X-Mizu-Trace-ID: 986970ad1353ee4d
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 03/10] mm/hugetlb: fix use-after-free in
 hugetlb_mfill_atomic_pte()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261015-urgent_fixes-v1-3-42796911043b@kernel.org>
Date: Fri, 16 Oct 2026 15:18:21 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Adam Litke <agl@us.ibm.com>,
 Mel Gorman <mel@csn.ul.ie>,
 Rik van Riel <riel@surriel.com>,
 Peter Xu <peterx@redhat.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <921D5002-91A9-4FA1-83DD-A7D2D061628C@linux.dev>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-3-42796911043b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> Let's fix another instance where we use a folio after dropping the =
PTL,
> where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
> making us trigger a use-after-free on the folio.
>=20
> Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during =
migration")
> Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support =
for shared mappings")
> Cc: stable@vger.kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

