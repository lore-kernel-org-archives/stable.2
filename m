Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339180;
	b=cjl2NZt7MnHZVzClBj/zZqFBFAtx3kSqsk5lbtC3UCKrJBIeWcvl4JfU4YSVPKqjjLzf
	 VD0Z0CnbPT0JoxNkbnC8YL0MWQjR8dvfm+y2KKTNn++5TIBwIVC5tP0WAzIrvN4sl5cHQ
	 C5McSEIoSrkPBws8TKIQLefExGvzBXx6NLeyZaJMuKuOw31nBAkP4MgxKBvqEHcWJbygX
	 U+FK/gYTMh3iup2fn3zXqn8DEGCZAAxGL0WgN63OCOEsefWoMfU9AmY6wtw+HVmkty3jz
	 n9gSoITR6QFMqhSCo+VpejgPmyp9WWSEzN+XD/TIFhhy/rqbFKEqIoqG+4KZNnwrL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339180;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1XyftV8GVsZDOcq2i3DlqyLQd8hIM8BmGNI2WNlBAD0=;
	b=KXN7A9xl/R+CpNuAVRZs5EGKHMxzLxuIKOUvi43VBF7fmqcs5kg7wbdeKBxlLnl1rhDX
	 N5Wcjkwk6a1/uMU7dx8Ksqx6duiwbSIiMHS4iaGxdJCU7hHVQTc7vZ1DRVBvK7Q29FRlH
	 vXrymzqCOnRzBLA8LdDciPjX4ARmmV7bCbba+2DPVofKiIC4/GopxkrqEe3jvaMG2sd8E
	 tGIkQaIDbgI0wZfbKSiSZjBjSKJWZbXrt7hMANbPPr8FJWqkE7cJ7ynx4M9oGk8p+ZJMv
	 2tgX5BsiUMWKiEwjbj5M+PrmKNeXTbHbtxYhL34KPbkNcAOn42VEBhhHzGjOhJlp0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Arb4mkNQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2B606A336;
	Sun, 22 Nov 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Arb4mkNQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DC41F000C0;
	Sun, 22 Nov 2026 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795339180;
	bh=1XyftV8GVsZDOcq2i3DlqyLQd8hIM8BmGNI2WNlBAD0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Arb4mkNQaABokJfYXMRZnv2NqMcuJKpcQBj6I/4FGp27aVCu0NZSNC0R4vWvcgtxS
	 yc3rvMtUORDGJhG7CWNWLPhUuWuULrlkESeOGkHqg5nC1dTLzB618EqkzC818N9xST
	 cS423e5R7/apM9xz5/i39cVPfPoGBDWTkAlcGpPB/uWQ0la4eaF3+WMdl7FO4/wHIQ
	 zuPAzWslFOsZb3mZApQjof+vIhnjInvSkYtm1bLlQFMG3O8Co7XYo5PdvGpOPcerAF
	 0TiBtrOA+SJr8UKGGfuV/FR10MjHn5OxYNUBkzZbA/UzleKV4z5DRzHaSwO2qjAoOJ
	 m7QYTWqBSaHsw==
Subject: Re: [PATCH net 3/4] net: skbuff: limit folio refcount when splicing
 pages into skbs
From: netdev-bot+sashiko@kernel.org
To: david@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 kas@kernel.org, songliubraving@fb.com, hannes@cmpxchg.org, riel@surriel.com,
 willy@infradead.org, ncardwell@google.com, kuniyu@google.com,
 pfalcato@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Date: Sun, 22 Nov 2026 09:19:38 +0000
Message-ID: <179533917877.3135.7884614269284288545@kernel.org>
In-Reply-To: <20261118-skb_refcount_overflow-v1-3-5551b4954c3f@kernel.org>
References: <20261118-skb_refcount_overflow-v1-3-5551b4954c3f@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the kTLS MSG_SPLICE_PAGES paths unchecked.
- [Medium] The new -EFAULT from skb_append_pagefrags() can turn a
  refcount near the limit into a persistent loop of NFS connection…

--

net: skbuff: limit folio refcount when splicing pages into skbs

The patch changes skb_append_pagefrags() to take its page reference with
try_get_page() instead of get_page(). If the folio refcount limit has been
reached it returns -EFAULT, so in-kernel MSG_SPLICE_PAGES users such as
sunrpc can no longer push pagecache folios past the limit.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bed1c8c4c6b99..c937d74eed6ac 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4714,8 +4714,13 @@ int skb_append_pagefrags(struct sk_buff *skb, struct page *page,
>  	if (skb_can_coalesce(skb, i, page, offset)) {
>  		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], size);
>  	} else if (i < max_frags) {
> +		/*
> +		 * Don't use -EMSGSIZE, as callers would just retry with a new
> +		 * skb.
> +		 */
> +		if (!try_get_page(page))
> +			return -EFAULT;

[Severity: High]
Does this cover all of the in-kernel MSG_SPLICE_PAGES users that the commit
message is aimed at? Both kTLS sendmsg paths handle MSG_SPLICE_PAGES without
ever calling skb_append_pagefrags(). They still take an unchecked reference
on every spliced page.

For software kTLS the path is
tls_sw_sendmsg_locked()->tls_sw_sendmsg_splice()->sk_msg_page_add():

include/linux/skmsg.h:sk_msg_page_add() {
    ...
	get_page(page);
	sge = sk_msg_elem(msg, msg->sg.end);
	sg_set_page(sge, page, len, offset);
    ...
}

The only check in tls_sw_sendmsg_splice() is this one, and it does not look
at the refcount limit:

		if (WARN_ON_ONCE(!sendpage_ok(page))) {

For device offload kTLS the path is tls_push_data()->tls_append_frag():

net/tls/tls_device.c:tls_append_frag() {
    ...
		++record->num_frags;
		get_page(pfrag->page);
    ...
}

These references stay in offload_ctx->records_list until
tls_tcp_clean_acked() runs, so they last until the peer ACKs.

The sunrpc example from the commit message appears to take this route.
svc_tcp_sendmsg() sets MSG_SPLICE_PAGES and calls sock_sendmsg(). On
XPT_TLS_SESSION transports, set up by
svc_tcp_handshake()->tls_server_hello_x509(), that socket is a kTLS socket.
So nfsd pagecache pages would reach sk_msg_page_add() or tls_append_frag()
and never skb_append_pagefrags().

No later patch in the series touches net/tls/ or include/linux/skmsg.h,
including "net: skbuff: limit folio refcount when splicing from sockets".

Should the spliced-page references in sk_msg_page_add() and
tls_append_frag() also go through try_get_page()?

[Severity: Medium]
Can this new -EFAULT cause nfsd connections to be torn down over and over?

nfsd threads are kthreads, and folio_ref_count_over_limit_slowpath()
refuses them at FOLIO_REF_COUNT_LIMIT, with no admin headroom:

	/* Background threads must not consume admin reserves. */
	if (current->flags & PF_KTHREAD)
		goto over_limit;

On the read side the limit is checked only once, when
filemap_splice_read()->splice_folio_into_pipe() calls folio_get_checked().
After that, nfsd_splice_actor()->svc_rqst_replace_page() takes an unchecked
get_page() for rq_respages, and the pipe reference is dropped. With this
patch, sending the reply needs a second, checked reference per page here.

Let k be roughly the number of pages from the folio in the reply. Suppose a
local user holds the folio refcount between FOLIO_REF_COUNT_LIMIT - k and
FOLIO_REF_COUNT_LIMIT. The read stage succeeds and fills the refcount up to
the limit. The send then fails:

skb_append_pagefrags()
  try_get_page() fails, returns -EFAULT
skb_splice_from_iter()
  iov_iter_revert(), returns -EFAULT or a short count
tcp_sendmsg_locked()
  returns a short count
svc_tcp_sendto()
	if (sent < 0 || sent != (xdr->len + sizeof(marker)))
		goto out_close;
    ...
	svc_xprt_deferred_close(xprt);

This closes the connection together with every other RPC in flight on it.
The client reconnects and retransmits the same READ. Nothing clears the
condition, so the cycle repeats for as long as the refcount stays in that
window.

Mappings are checked against the same limit. An unprivileged user can
therefore put the count in that window by mapping until refused and then
unmapping a few pages.

Before this patch the send succeeded. At or above FOLIO_REF_COUNT_LIMIT, the
pipe-stage check makes nfsd return an NFS read error rather than close the
connection.

The commit message says:

    The only caller, skb_splice_from_iter(), handles that.

For sunrpc, though, the error ends in connection teardown, and nothing falls
back to copying the data into frags. Would a copy fallback be better here,
or is the teardown intended?

>  		skb_zcopy_downgrade_managed(skb);
> -		get_page(page);
>  		skb_fill_page_desc_noacc(skb, i, page, offset, size);
>  	} else {
>  		return -EMSGSIZE;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118-skb_refcount_overflow-v1-0-5551b4954c3f%40kernel.org
