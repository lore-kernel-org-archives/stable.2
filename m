Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D263BB115
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792303589; cv=none; b=quiRobxPdn1frbgknLYrWS3Zjy0GNmtb0k/3mdTP++TFHExShOtzt8L+zzPPUHnOM4f11elKOfC5beWcgFATI0Ssxylf5oS+b+WVStDLhvxg3lNsD/8QPRWC1uD15Oq3BoZa45+3EW9c6XQc64jkof9EATkJd0M8kD0dp0sF1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792303589; c=relaxed/simple;
	bh=E4jhTrD/yvx1o3PE+1enlxeStAvJ4cEvw0ge3yfhvfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmzhzyHwVR8MXE8Sg9wxtWwIHlXU/hQQ9qvJLW+wQ3gienBylXcrpnTrWLSLUzr8F0Q9B77a5oDWcE5qVhSUB0D06aq4VoatBHvx7Uqj83hgMQ5/DwGgCrf/qEHw5ZOoGqK3ypdXqCZZbd7McboSTo/hON7Io6UcxoEs8dvPNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2yw0M3D; arc=none smtp.client-ip=91.218.175.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2yw0M3D"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E4jhTrD/yvx1o3PE+1enlxeStAvJ4cEvw0ge3yfhvfY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792303585; v=1; x=1792908385;
 b=r2yw0M3DR0o5thzvP1Tg3WKI8ZBsbx7wKg4Zn/Bx2owQHrcPOL5dcAKrBlynblT5g/f6lhKf
 EpqxHd9ZLRMpHVzr9zTqBfe0XQJ/7QQG1aoPolOE+3tjVBQ8tNr/RAN9IRqFhd5ZVkobCF6LQOa
 eIaRpZ2Tu5YHWu3N8YvE+n3k=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 294eb343e70a89c9;
	Sun, 18 Oct 2026 06:06:24 +0000
X-Mizu-Trace-ID: 294eb343e70a89c9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mel@csn.ul.ie,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/vma: don't leak the commit charge on mmap failure
Date: Sun, 18 Oct 2026 14:06:19 +0800
Message-ID: <20261018060619.12762-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-1-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:07PM +0200, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>When an accountable mapping replaces existing mappings (MAP_FIXED),
>__mmap_setup() only charges the difference between the size of the new
>mapping and the VM_ACCOUNT pages it replaces. It then zeroes
>vms->nr_accounted so that unmapping the old VMAs does not return their
>charge, which now backs the new mapping.
>
>If the operation fails after that point, the error path returns
>map->charged, i.e. only the difference. By then vms_clean_up_area() has
>zapped the page tables and closed the old VMAs, so
>vms_abort_munmap_vmas() cannot reattach them. It leaves a gap and
>finishes the unmap with vms_complete_munmap_vmas(), which uncharges
>vms->nr_accounted == 0 pages. The old VMAs are gone, the new one was
>never created, and the charge of the old ones is never returned, not
>even when the process exits.
>
>No privilege is needed to hit this, only a file whose mmap hook fails,
>for example a socket (sock_no_mmap() returns -ENODEV):
>
>	p = mmap(NULL, len, PROT_READ | PROT_WRITE,
>		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>	mmap(p, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_FIXED,
>	     socket_fd, 0);
>
>Every iteration adds len to Committed_AS for good. With
>vm.overcommit_memory=2 this lets any user make all further accountable
>allocations in the system fail with -ENOMEM.
>
>Once the new mapping has taken over the charge of the mappings it
>replaces, it owns the charge for all of its pages. Record that in
>map->charged, so that the error path returns all of it.
>
>A failure in __mmap_setup() itself is not affected: it happens before
>the charge is taken over and the old VMAs are reattached with their
>charge intact.
>
>Original fix generated by an LLM and sent in private by Josef.
>
>Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: call variable "uncharged" and make it const, adjust/simplify comments ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
