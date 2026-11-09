Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244596;
	b=lb98sujgbdAMI12GKqs1RjEKYpXqT7me0GJs+msjf8E711gCS52jdY6eu7KzzNr4fVN3
	 qAPz/i2Q5qH601O8gV+bS+gblY9IW+wRIDbcMmsR8WeQOvZA/iNfk0c9JPmZn+OHgJu9r
	 h5do6IrJJ7pNFGfrQUP8p5AORt7lNsjYtarM8mWyxpzuaspe3QjT5oGry52N0QrDhpA6s
	 pcG026SkiWcS18EQU2ZvU1Yu4E0ZsVu0bwAO0qsSiMSreirLs4wKVEKQBJckrlX7IhH4y
	 N7EHUNHiyNxoHcZPYyFmnzIOOSbUN3dTkkkacBhXylatjtQARDpZiL9d6xaPlGEZsaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244596;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=j6CW/1Tx0ekOFiRNdAR2OG0dMWkU4FJDAABQ/X0bHfs=;
	b=zNeRClS+NuDllY3lWhtV8dWsNDBwZoruMQjnD5CfFngDCV3W0hdE5ML4pKjpMgA9ZEFf
	 iQlESD/yGI0l2Rj2YinymXuGu5yozCwozk5+RUvlpAy/+bo7lBTKUQPP659csxDYgwfR0
	 TTZKEL8XlRc8WxkmoDenEVHG4SsPfjvODIS+DqJpjU5q5BQSETkPoGCfu4r3BCh5KR4yD
	 r//cHbSb5UsmZxIxYINTROTHKk9GnJhs9z5SQukguA+JUnu5u416RGhkjqJN/bxZVeszb
	 Yj6iKASHlrEroDUuntI6gxkhZnUpFTIHDly+iUS6JN8iZnpWx/1YPTCIcRwXUJJ3QJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5mnmvZ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A995606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5mnmvZ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A851F0089F;
	Mon,  9 Nov 2026 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244596;
	bh=j6CW/1Tx0ekOFiRNdAR2OG0dMWkU4FJDAABQ/X0bHfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S5mnmvZ36QyMB3PKa1QOlaF8M6++BvEsviRir2wFFKZKhIGSfG7yw7wclXGxpDxxw
	 EwNnTsa+biPnrA+66hoZnjS4wLEuYUh00iHBBHNmfL8Iv3m8wJJpuTLunscdf9mwSz
	 iaiLjdRDkJas6Kb/uPRQXfibPZdu54Ivi7gdAhSxbViqX8bx8Na8CcbnurDXpPdCIY
	 PHU04Qlq+IZSg2X2ag7KYYtpZWZZHFi5s6Ti9nb4+Iq4qLhfNf7TreGsfQ9LgyzfUv
	 OERYrXHNd3uGl5kmdSnF6gdsFppUEr+eNJW5EEY8A66kbWUJirlf+YY0uL+KKXbea+
	 o3ZQg3L8tBDgw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id ED8A21980052;
	Mon,  9 Nov 2026 12:16:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 12:16:33 -0500
X-ME-Sender: <xms:7v_xalaHW1t7fI0I_R3gU1CMnkRqpNp-XA0_0Fg4v6R8ft-Wq42eyw>
    <xme:7v_xauuH0RV3MQ4Pb7C71_fo3nIvY8TKk73odKl0VDOnY6aGOxhGfw_G6R7EFVftK
    PP7mjWjYSR9xtZ3dITdTypD8rckq-CevRhw78qxqEzbznFyCDKKkmQ>
X-ME-Received: <xmr:7v_xampey70JtFaVA0GRMnJ_YQpvE6-UFpEySSD0K4td5NanbeGCdOUx6SQ>
X-ME-Proxy-Cause: dmFkZTERlrsw/TgcMaQYagBEnXGdzeOR8l8ctOzfJRMC5gmxQrqcjviMIQVm5fCxzjFNKI
    IeEbuGRKdFHZmLlvXbmrb9fzt7wQqlOtts94l4qY4D2oFWPXKUHMZO0fRI3X08tvy9QJCn
    A02mYLG5Juy4RlqXdNpii+MXz8cX4yViexmP+/uUYcJ6+OgX4AckbkH8/NNN1SUFpaFgZD
    n2e4j0GcraBJvUYshJyxQ7o0JndZ7qx7mMNaDnlKl5yzwxdTV0LKgn7Ck/ar5g7k/NnUdD
    MQoixdGSru5Lk8amtpUzoV+E0VbdBuHQaAAffX2SmgNaVbFEpdrDauAk7bC3vfXTmEtfBI
    Z73zrmDnsjHnFh3mBSDLndWiNeFU7k8H2Yaa0bbgNOzke45sxWlCdMDpPVJGhsVs2o3nmm
    to4vqIxSuhz5nFQjAHiMRyRiVURSlMkn626DYbwDbLkPF3YJ0yGUiVkZZY7eXn+zv/VvZ/
    v2z2cyJz8Kwk7XMhHpy+sRocofQ+UeNlH8ITiGkKN+VwZ08StrSHm1SiWOYvd7W1laHE46
    lfRCr97z5nT70hUbQyd7NJTgfMpvQk2YnsBB7GYEoEPSKa/7QGHKzdfXTX60zC58DCBbio
    kBeIOZFZ8Q8sdt8ykdj871CNWYVTKNOGXfcpp0XJASlbd0nOwFqrpV/YFP6Q
X-ME-Proxy: <xmx:7v_xagmFT_VPHYNx8UGLXIzR-urF8KP1t2JDhY7f4OriXzqjVBNSjw>
    <xmx:7v_xauTXPvS4e2WvouH9HmJdc4zo-6wYkBs5v3Fd4uebeTeLHRPMKQ>
    <xmx:7v_xahR0uGKU3D4qmpVO7TuCxu9ooZh7OLQ9UBn4yl0t8vNU81R8mw>
    <xmx:7v_xan56uCWHbpPe3MBvfmUB_jdX1viF3Wqyw4QjjNSZZa_xaiNR-w>
    <xmx:7v_xanRDMpyKfqo0Gor9YLT1IUstCHJMDkz5hOoLDO4n7m0QQ0WqGX-c>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 12:16:29 -0500 (EST)
Date: Mon, 9 Nov 2026 17:16:28 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: don't allocate a page table under RCU in
 do_set_pmd()
Message-ID: <avH_38C4vO6BDywb@thinkstation>
References: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
 <20261106-khugepaged_set_pmd-v2-2-d2457b5e377a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-khugepaged_set_pmd-v2-2-d2457b5e377a@kernel.org>

On Fri, Nov 06, 2026 at 01:36:13PM +0100, David Hildenbrand (Arm) wrote:
> do_fault_around() skips PTE table preallocation when the PMD already points
> to a PTE table. A concurrent collapse can then retract that table and
> clear the PMD before filemap_map_pages() locks the new PMD-sized folio.
> 
> filemap_map_pmd() can then call do_set_pmd() with an empty PMD and no
> preallocated table. On PowerPC hash MMU, do_set_pmd() then tries
> allocating a PTE table to deposit. But filemap_map_pmd() calls
> do_set_pmd() under RCU, so allocating from that context is not good.
> 
> This race became possible when retract_page_tables() stopped taking the
> mmap and VMA locks. Previously, those locks excluded retraction while
> the fault was in progress.
> 
> Add a may_alloc argument to do_set_pmd() and pass false from
> filemap_map_pmd(), so we can fail with VM_FAULT_FALLBACK instead of
> trying to allocate.
> 
> This issue should be fairly hard to hit in practice.
> 
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
