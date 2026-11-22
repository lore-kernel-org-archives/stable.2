Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352730;
	b=rlMvOYbzBthVaLqtZTZ+vwURkIyJR6p4d6dd5rtImXb20FwhsM5/yHHDWBH7yy9rppg3
	 /j+hO+E3o22TnNyrnRuAp4z/memMmGU2osJbYqKNWNjC8O/WiJMaUjp9eGZE6A+a9f0sY
	 wbmMnYR0ymtIouKOVeT7S3a++iQ/Ris3tx8oWTCTKGLv1CKosgce4zg8TUoosPsZK/Uli
	 LiFCtrIu1ZIpO0IbEt65pI+GNmVcq+5/WiQd48/fXOKJpyHX+jehcXQqVB/gViegeFhDN
	 GRKXWZLYuYA4tr2K/0zg6i1BdMjnheMT+pEWmxXzTOHHD7FfxaHkjpVGWIKBz0n2fUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352730;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=b6PVnTE0M7Rh2hdTNJ7SbK1PMjuoDJ6oiq+le4j0zbc=;
	b=CjNVzFJCyFzjtm9I6sE5fLPpFSqIYV4LQkUx3tt7u/2eSr61MDRZ0N/YUBrXwOR39W99
	 Opz1kNGYLB5a+1aQWsOC8LQD3ANr5x/Azkm74W4WcqFnAR4yEOSLvD7B6Uc1AI2PYKZqD
	 zpRYSFDKw3neIM7EvtECpAyVXHCsYjWjqBE7e034gzLTxLHg+X5Az/PzWPan8jrBX7evo
	 tVDISYE+0RVN/dcnww91i0CZCvWDb1CQdKxbApTmHw2sCKZMKZhm4vkNteEZf28O+dwqN
	 KiSC5do8zy9Ns5iwKPrqG38OTMeZwVOajfHghMpazUu6lHZyZ0wXtBztutexaChUjAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izEUfaD9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58D606A32A;
	Sun, 22 Nov 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izEUfaD9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9A51F000C4;
	Sun, 22 Nov 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795352729;
	bh=b6PVnTE0M7Rh2hdTNJ7SbK1PMjuoDJ6oiq+le4j0zbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=izEUfaD9S8T8IM4KEiX4NyC44h436/g9piz005mAV9X6Z9ttz92UD109bJPbWG3xZ
	 G/2MNInD5bt/TddXLTobKJesHXKtZjZB7/fp5B5N0083SmHiu8zBcP++vuvxJzELQa
	 rBH9Uw0gXQB+XQCymLNkHfHmcdNh3IUiZx1+OBCJlqle3KZv3JPuPVKA0IDQmBnIpt
	 Ou2d4QtkZgYzMYK7xFESRWJH6HzlmRwX5z2Iau7vlghDJAGii8Q0RFhpitGGE6wO1k
	 vG2F0MSt0kY/HG4qJtwQchT3uN5kuZtrF+j/P1R3FY6gmdxAjmhcgbGDNep3I8xRyz
	 ckw0/EyH6rzrQ==
Message-ID: <8e4ac3be-8d0e-4846-9577-6c968ceab776@kernel.org>
Date: Sun, 22 Nov 2026 14:05:22 +0100
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
Subject: Re: [PATCH net 3/4] net: skbuff: limit folio refcount when splicing
 pages into skbs
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20261118-skb_refcount_overflow-v1-3-5551b4954c3f@kernel.org>
 <179533917877.3135.7884614269284288545@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <179533917877.3135.7884614269284288545@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

> 
> [Severity: High]
> Does this cover all of the in-kernel MSG_SPLICE_PAGES users that the commit
> message is aimed at? Both kTLS sendmsg paths handle MSG_SPLICE_PAGES without
> ever calling skb_append_pagefrags(). They still take an unchecked reference
> on every spliced page.
> 
> For software kTLS the path is
> tls_sw_sendmsg_locked()->tls_sw_sendmsg_splice()->sk_msg_page_add():

I had the following as part of the -mm submission [1] linked in the cover that
carried these things:

"
Net paths that take page refs that I don't touch because the references
are either bounded or the paths are not relevant in practice:

 - skb_split(): can add one reference per split, but each split
   allocates a new skb that is charged to the socket, and the references
   go away once the data was acked. Reworking that to be able to fail
   requires more plumbing.
 - IP-TFS reassembly: needs one new inner skb per additional reference.
 - io_uring zerocopy send (managed frag references): each zerocopy piece
   is charged at least 4 KiB of TCP memory, so not relevant in practice.
 - kTLS software splicing: only transfers references from the pipe, so
   not a problem.
 - AF_XDP zerocopy TX, nfsd splice reads, sockmap / sk_msg, espintcp:
   bounded, or require privileges / special setups, so not a problem in
   practice.
 - Driver-specific paths (e.g., kTLS device offload): require special
   hardware, didn't look into these.
 - page_pool and net_iov frags: not pagecache pages, so not a problem.
"

I think I tried getting it reproduced with kTLS, but due to lack of HW I was
only able to test the software path.

The hw path can be tackled separately, if that is really a problem (again, no HW
to test).

[1]
https://lore.kernel.org/linux-mm/20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org/


> 
> include/linux/skmsg.h:sk_msg_page_add() {
>     ...
> 	get_page(page);
> 	sge = sk_msg_elem(msg, msg->sg.end);
> 	sg_set_page(sge, page, len, offset);
>     ...
> }
> 
> The only check in tls_sw_sendmsg_splice() is this one, and it does not look
> at the refcount limit:
> 
> 		if (WARN_ON_ONCE(!sendpage_ok(page))) {
> 
> For device offload kTLS the path is tls_push_data()->tls_append_frag():
> 
> net/tls/tls_device.c:tls_append_frag() {
>     ...
> 		++record->num_frags;
> 		get_page(pfrag->page);
>     ...
> }
> 
> These references stay in offload_ctx->records_list until
> tls_tcp_clean_acked() runs, so they last until the peer ACKs.
> 
> The sunrpc example from the commit message appears to take this route.
> svc_tcp_sendmsg() sets MSG_SPLICE_PAGES and calls sock_sendmsg(). On
> XPT_TLS_SESSION transports, set up by
> svc_tcp_handshake()->tls_server_hello_x509(), that socket is a kTLS socket.
> So nfsd pagecache pages would reach sk_msg_page_add() or tls_append_frag()
> and never skb_append_pagefrags().
> 
> No later patch in the series touches net/tls/ or include/linux/skmsg.h,
> including "net: skbuff: limit folio refcount when splicing from sockets".
> 
> Should the spliced-page references in sk_msg_page_add() and
> tls_append_frag() also go through try_get_page()?
> 
> [Severity: Medium]
> Can this new -EFAULT cause nfsd connections to be torn down over and over?
> 
> nfsd threads are kthreads, and folio_ref_count_over_limit_slowpath()
> refuses them at FOLIO_REF_COUNT_LIMIT, with no admin headroom:
> 
> 	/* Background threads must not consume admin reserves. */
> 	if (current->flags & PF_KTHREAD)
> 		goto over_limit;
> 
> On the read side the limit is checked only once, when
> filemap_splice_read()->splice_folio_into_pipe() calls folio_get_checked().
> After that, nfsd_splice_actor()->svc_rqst_replace_page() takes an unchecked
> get_page() for rq_respages, and the pipe reference is dropped. With this
> patch, sending the reply needs a second, checked reference per page here.
> 
> Let k be roughly the number of pages from the folio in the reply. Suppose a
> local user holds the folio refcount between FOLIO_REF_COUNT_LIMIT - k and
> FOLIO_REF_COUNT_LIMIT. The read stage succeeds and fills the refcount up to
> the limit. The send then fails:
> 
> skb_append_pagefrags()
>   try_get_page() fails, returns -EFAULT
> skb_splice_from_iter()
>   iov_iter_revert(), returns -EFAULT or a short count
> tcp_sendmsg_locked()
>   returns a short count
> svc_tcp_sendto()
> 	if (sent < 0 || sent != (xdr->len + sizeof(marker)))
> 		goto out_close;
>     ...
> 	svc_xprt_deferred_close(xprt);
> 
> This closes the connection together with every other RPC in flight on it.
> The client reconnects and retransmits the same READ. Nothing clears the
> condition, so the cycle repeats for as long as the refcount stays in that
> window.
> 
> Mappings are checked against the same limit. An unprivileged user can
> therefore put the count in that window by mapping until refused and then
> unmapping a few pages.
> 
> Before this patch the send succeeded. At or above FOLIO_REF_COUNT_LIMIT, the
> pipe-stage check makes nfsd return an NFS read error rather than close the
> connection.
> 
> The commit message says:
> 
>     The only caller, skb_splice_from_iter(), handles that.
> 
> For sunrpc, though, the error ends in connection teardown, and nothing falls
> back to copying the data into frags. Would a copy fallback be better here,
> or is the teardown intended?

I don't think so. If someone pushed a folio refcount to its limit we should just
fail instead of trying to keep it somehow working slower. (Linus had the same
thought about failing splice instead of falling back to a copy)

-- 
Cheers,

David
