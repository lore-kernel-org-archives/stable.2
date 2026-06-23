Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551C2E7386
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199586; cv=none; b=PbKvT5myuckKO3hA86DtrnfuFeyh+kZObmynKSDJZv8sXA+Ws/qOAMQNmbFSYFFB+7U2y6xRu5oYnkDVlifcgfFr3MnekFn2X3t13nYOsHOwx6/yGF/IHpuEVt2UjaNoTwdbneePPI9ZR61vUzE35O2ZIzE4nk07sONsBCOJF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199586; c=relaxed/simple;
	bh=zuaTe8OyzpGDUNIVA+uFcRVLeTjcxr1Tcp7dy1adM0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0GyhBEXFiI+u3HqUd+ttpnUTXV0bKbVvHAvE0b/73I3cZr/SAscS+OeOqHf0HJ1eQ74TEEdgva8Q0jMLIy7Y24I+GUOtovI+rztVsYDh55mZsdzr6ZowbkM/l/A3uaxdbaqXYNcGZYv5aNKbD3lZTZK5jKEiRBgc/gXXSveve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YKLqdtPH; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YKLqdtPH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782199573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuaTe8OyzpGDUNIVA+uFcRVLeTjcxr1Tcp7dy1adM0M=;
	b=YKLqdtPHjSJizQIA7e48JK4rzzGxmmisdccbx8Txgm2GmTU8coD3fqaGdlNXnMni10wVo/
	ylphzZuLXwiX1EBp+fRAv6OnJWkyIOZWZUcaSsNFiqXrqwIQlAeENgCEHjnRH7I2Vin4Vq
	FsrcJXZCg515Nt4n3IA7AqvpYLEE3WA=
From: Lance Yang <lance.yang@linux.dev>
To: ziy@nvidia.com
Cc: akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	baolin.wang@linux.alibaba.com,
	jiaqiyan@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH hotfix] mm/compaction: handle free_pages_prepare() properly in compaction_free()
Date: Tue, 23 Jun 2026 15:26:01 +0800
Message-Id: <20260623072601.78245-1-lance.yang@linux.dev>
In-Reply-To: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
References: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 22, 2026 at 11:30:42AM -0400, Zi Yan wrote:
>free_pages_prepare() can fail but compaction_free() does not handle the
>failure case. Failed pages should not be added back to cc->freepages for
>future use, since they can be either PageHWPoison or free_page_is_bad()
>and might cause data corruption.
>
>Fixes: 733aea0b3a7bb ("mm/compaction: add support for >0 order folio memory compaction.")
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Cc: stable@vger.kernel.org
>---

LGTM. Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
