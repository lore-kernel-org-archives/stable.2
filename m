Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168037;
	b=VmVK3Wh5SRuREc1r4RUKgTCWvd35xHtnbryqWsCnh7gT1slLpQQSC9TpQyeIdj3YY83T
	 Wed1LVHJk+cYnuIaNah6zDR9w/2HWtm4XYin1Kp9gCUEqKPSatfAn+WkoQc0oYDFs/H+d
	 vAupBEnMYX+p0KN4lAHRS5GzkwrU/X93FKcOJUitAz6RsijBnRJ2Zy2c3UgJQXKkUfcvt
	 vK7hh8lYbI0i1tcAwjJ6UhBdZUBt7KnwUXabfz8OyZFVRrxI9blx6iNq7/3dFwtcMu6Ae
	 deJlb99AtVwdOkB7uBf91f6sqJB8ejW/fHyiw8bTsgIF7MypCMUDgSnMhEeBgj1WBiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168037;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9TK8Y60rG8NiKouFkfePiFMpKuLWEFIntD2PEI7ua3I=;
	b=1KrucGnPAnbXSnq1mwT/UK5ARf+PSZMN7iLIGSU2oQY7rzI4pMhZ/Xo300RQ7kPx/vps
	 j76BvPyh68gQR6iIteYobJIW0r1YhtsWuvv6gA6qqwHL+BE9iPXFfXW0aPAp33UAeRJ47
	 8jtQarMpxutQ7u9fUP6FkSVQWfnZ6jvdoDCyQYpmk8a2lPKR7vawTxhN0HdkbzdINbm12
	 VFYebZgkhFHYn0OpUKkYpbg7vY7iJO982yKGVgKTyuDije9xzMV58eSkLsBUH1VveTqpj
	 V9zvVkSHNdBrCq/w/8V/MdRL1XJBeWtR4FR8wbDy6eIrc46GBxD8n/V9zBkMhKujkeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne3oG4JV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77F60A2601;
	Fri, 20 Nov 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne3oG4JV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095541F000CA;
	Fri, 20 Nov 2026 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168037;
	bh=9TK8Y60rG8NiKouFkfePiFMpKuLWEFIntD2PEI7ua3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ne3oG4JVdPmgZgBSBUAKVcKzck0RKZwwGx1CgeztImWh8/N678rI4M0NcrTIpNV6o
	 944+Pkkq4H6UHhDVeZr77IYLqWP6xQZhRga2edYuWmlonTU0mzGsmtf29GtydGCs4y
	 VR0ibtZUjU227lmj9HELs0tDPCAeqC3veD4gBssY2SkRPOvKZBN9t5sM0eraTMdr73
	 aBxr/RSdBVRCKv9QmWl+Bd0Gg2bt9Wb8rSp5+s03Yg8O+bCO8GcA+QRPcwdK+QTiHI
	 45e6JAlDHwVlIaWRdEB5lmugYhKreo6eAhy+QNwR5MI4k+LHMisYaq9KlTvLQ3n/xl
	 FQ0KCjAjlurIg==
Message-ID: <73c18685-8115-4ee5-876d-a276902488aa@kernel.org>
Date: Fri, 20 Nov 2026 10:47:11 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: alloc: reject offline NUMA nodes in allocator
Content-Language: en-US
To: Franklin-Qi <yusq77@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-mm@kvack.org,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Harry Yoo <harry@kernel.org>,
 Georgios Androutsopoulos <georgeandrout13@gmail.com>,
 Vitaly Wool <vitaly.wool@konsulko.se>, stable@vger.kernel.org
References: <20261120021633.12274-1-yusq77@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261120021633.12274-1-yusq77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 03:16, Franklin-Qi wrote:
> NumaNode::new() only checks that the id is in [0, MAX_NUMNODES). Safe
> Allocator APIs can still forward an offline node into
> k[v]realloc_node_align(), which may dereference NODE_DATA(nid) == NULL
> and panic (GPF).
> 
> Reject offline nodes at the shared ReallocFunc boundary for nonzero
> allocations. Leave NUMA_NO_NODE and zero-sized free/realloc paths
> unchanged. A residual hotplug TOCTOU remains if a node goes offline
> after the check; this matches practical C usage for rejecting
> statically missing nodes from safe Rust.

IIRC we however don't remove node data on offline, so the NULL dereference
won't happen?

> Fixes: 7760b6421b6c ("rust: add support for NUMA ids in allocations")
> Cc: stable@vger.kernel.org
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1263
> 
> Signed-off-by: Franklin-Qi <yusq77@gmail.com>
> ---
>  rust/helpers/mm.c              |  6 ++++++
>  rust/kernel/alloc/allocator.rs | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> index b5540997b..b61e54e16 100644
> --- a/rust/helpers/mm.c
> +++ b/rust/helpers/mm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/mm.h>
> +#include <linux/nodemask.h>
>  #include <linux/sched/mm.h>
>  
>  __rust_helper void rust_helper_mmgrab(struct mm_struct *mm)
> @@ -38,6 +39,11 @@ __rust_helper void rust_helper_mmap_read_unlock(struct mm_struct *mm)
>  	mmap_read_unlock(mm);
>  }
>  
> +__rust_helper bool rust_helper_node_online(int nid)
> +{
> +	return node_online(nid);
> +}
> +
>  __rust_helper struct vm_area_struct *
>  rust_helper_vma_lookup(struct mm_struct *mm, unsigned long addr)
>  {
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index cd4203f27..15e17f598 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -101,6 +101,23 @@ unsafe fn call(
>          nid: NumaNode,
>      ) -> Result<NonNull<[u8]>, AllocError> {
>          let size = layout.size();
> +
> +        // `NumaNode::new` validates the ID range, not whether the node is online.
> +        // The C allocation paths require an online node for nonzero allocations.
> +        // Keep `NUMA_NO_NODE` and zero-sized deallocations unchanged.
> +        //
> +        // Residual TOCTOU remains if a node goes offline after this check and
> +        // before the allocator runs; that matches practical C usage for rejecting
> +        // statically missing/offline nodes from safe Rust.
> +        if size != 0 && nid != NumaNode::NO_NODE {
> +            // SAFETY: The helper only reads the kernel's online-node mask. `nid`
> +            // is either `NUMA_NO_NODE` (excluded above) or a value in
> +            // `[0, MAX_NUMNODES)` from `NumaNode::new`.
> +            if !unsafe { bindings::node_online(nid.0) } {
> +                return Err(AllocError);
> +            }
> +        }
> +
>          let ptr = match ptr {
>              Some(ptr) => {
>                  if old_layout.size() == 0 {
> @@ -116,6 +133,7 @@ unsafe fn call(
>          // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that
>          //   `ptr` is NULL or valid.
>          // - `ptr` is either NULL or valid by the safety requirements of this function.
> +        // - For nonzero allocations with a specific node, `nid` was checked online above.
>          //
>          // GUARANTEE:
>          // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.

