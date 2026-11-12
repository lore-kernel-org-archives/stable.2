Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469991;
	b=HeCSyATCCKPAmf49pt0n4dUzs4ftLWt75QRmLgAxXLo/q2Wt4854jXvyjrGlRBWFOmS8
	 uddFwV8G8+dZ0a56v5q8GKeO/RvUHZxJpESrRgiPCvqu01oBB3cduGX4ZcR6AaB/0PaLD
	 3KcY5pDGTYPylA+N0uxrjvSfGnKi5uNnNYwzqu29Uy+edMoA7ChBgGWEK83rYS9ROD4yP
	 kifFaKs2us0rJ1i/XzeniFmRNXc2KA/2pJlsCWGJSN3VUfKYSBkTdgJyUF7/twjswEwq0
	 voupg6vpNwvD2n722GC1EKFr+NJ3Kxfkat9EhQMS3e0umAEM34DxQqsSd3PdqeIKHxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469991;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0unfv0KMYJXaahpkJei6eupejSm6FcA6NRlrbk9HZWU=;
	b=diKNpXQ+hdhVnUCrc8J8T1rm/08BHWT6r/vASKH1iZP+QVLqre6eeAhDM4xUb3qvVx2Z
	 hw1U0eJIiCK52ZygQKkNpESEqeup+Gj6E+RUD/59Lo4fsVDBo0CKn7new3lJfQa1olHHv
	 HQut+0WxjRoXL+oTY/DRecp7adYLYCuBbCH9vw7aMA9So2fWEqsCEX79jvg1YoTxyYk6V
	 H6+yKxwAVYyjQfheSdjbFPJPGrErutMqpigHI4CtWc6b8UHlPYQUo/y6dq/Is6CeAQ8MD
	 bfUvFfu/10xKmJAbNOtgc16ABSP79eXfTi50Fb8ioyMjOAyvFANxS1kLSWL38bWDXKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KecnwKw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFE60A261B;
	Thu, 12 Nov 2026 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KecnwKw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB67E1F00A05;
	Thu, 12 Nov 2026 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794469991;
	bh=0unfv0KMYJXaahpkJei6eupejSm6FcA6NRlrbk9HZWU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KecnwKw/f9irB6CzUQqSyyR+cBttP2b5M1Pc37vdz51g5wWCyMBsV7YecyBe7fzNA
	 qoAOFd1OJGg7rrBsWfIANO3JxaKUOjAT1OxkObuN+WbB2bZf1d42ZiwQYUdhD9dSJt
	 gvzFjEqQZ7BK8P6bzYVrQdTSsJYdEpGvD49a2U7g3qxWcl6n6J7iqwU4HDda5VPRFl
	 YkfxojjTuF0lcFLX6icuqC0wEYVfxRDH+n0cXJPXN/Mb7B20gnz0z5l744oMybdjWM
	 l4fHTFo0w18hvWslSvFh6WMEI5nRP+DoH5yKGsbUuhmp8W1NbAVwpOHEYrMKIIH4qy
	 qz5V3XJuxBb8g==
Subject: Re: [PATCH 2/5] 9p: ignore a zero-copy reply that arrives after a
 fatal signal
From: netdev-bot+sashiko@kernel.org
To: lian@is.s.u-tokyo.ac.jp
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux_oss@crudebyte.com, horms@kernel.org, viro@zeniv.linux.org.uk,
 tomasbortoli@gmail.com, chirantan@chromium.org, groug@kaod.org,
 aneesh.kumar@linux.vnet.ibm.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shina@is.s.u-tokyo.ac.jp,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 07:53:09 +0000
Message-ID: <179446998948.2199510.3182298225630042557@kernel.org>
In-Reply-To: <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] p9_client_zc_rpc() (net/9p/client.c) no longer runs `if
  (READ_ONCE(req->status) == REQ_STATUS_RCVD) err = 0;` after the flush.

--

9p: ignore a zero-copy reply that arrives after a fatal signal

This patch changes p9_client_zc_rpc() so that err stays -ERESTARTSYS
after a fatal signal ends the transport wait, even if the reply arrived
before the RFLUSH. It does this to avoid parsing an unbounded or
uninitialized RERROR string from a zero-copy TREAD or TREADDIR reply that
p9_virtio_zc_request() never post-processed.

> diff --git a/net/9p/client.c b/net/9p/client.c
> index e63e8c2a853df..66980ad52bca8 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -706,10 +706,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  
>  		if (c->trans_mod->cancel(c, req))
>  			p9_client_flush(c, req);
> -
> -		/* if we received the response anyway, don't signal error */
> -		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
> -			err = 0;
> +		/*
> +		 * err stays -ERESTARTSYS even if the reply has arrived, since
> +		 * the transport moves the error string of a zero-copy reply
> +		 * into rc only while it waits.
> +		 */
>  	}

[Severity: Medium]

This change applies to every zero-copy request type, not only TREAD and
TREADDIR. Does it also drop a completed zero-copy TWRITE?

On virtio, p9_client_write() and p9_client_write_subreq() both send
P9_TWRITE through p9_client_zc_rpc() when the write is over 1024 bytes:

net/9p/client.c:p9_client_write_subreq() {
    ...
	if (clnt->trans_mod->zc_request && len > 1024) {
		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &subreq->io_iter,
				       0, wreq->len, P9_ZC_HDR_SZ, "dqd",
				       fid->fid, start, len);
    ...
}

Here is the sequence. A fatal signal ends io_wait_event_killable() in
p9_virtio_zc_request(). The server then finishes the write and sends
RWRITE before it handles the TFLUSH. p9_client_flush() returns with
req->status == REQ_STATUS_RCVD.

Before this patch, err was reset to 0 at that point. Now the RWRITE is
dropped and the caller gets -ERESTARTSYS, even though the server state has
changed. Under 9P flush semantics, a reply that arrives before Rflush
should be honoured.

On the netfs path, v9fs_issue_write() then sees len == 0:

fs/9p/vfs_addr.c:v9fs_issue_write() {
    ...
	netfs_write_subrequest_terminated(subreq, len ?: err);
}

So it skips the i_size/remote_i_size update and does not set
NETFS_SREQ_MADE_PROGRESS. netfs_collect_write_results() then calls
mapping_set_error(wreq->mapping, front->error) with -ERESTARTSYS.

Could a later fsync() from another opener then report a writeback error
for data the server already has? In the same way, v9fs_xattr_set() via
p9_client_write() would report failure for an xattr value that was
written.

The new comment says the transport moves the error string into rc only
while it waits. For TWRITE, inlen is 0 and no reply pages are posted. Isn't
the whole reply, including any RERROR string, already in rc.sdata then?

The commit message says:

  "since p9_client_zc_rpc() already returns -ERESTARTSYS when the server
  cancels such a request."

A cancelled write leaves the server unchanged, but a completed write does
not, so this reasoning doesn't seem to cover TWRITE.

For TWRITE, the only late-reply risk seems to be an rc.size that was never
clamped, because p9_check_errors() skips its size check when rc.zc is set.
On the late REQ_STATUS_RCVD path, would checking rc.size against
rc.capacity (or the posted in_hdr_len + inlen) fix the KASAN report while
keeping a valid RWRITE?

Also, the later commit "9p: take the tag of a flushed request from the
request" in this series makes a zero-copy TWRITE actually send a TFLUSH and
wait for RFLUSH. That widens the window for an RWRITE to arrive first, and
p9_client_zc_rpc() at the end of the series still leaves err as
-ERESTARTSYS in this case.

>  recalc_sigpending:
>  	if (sigpending) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109105251.2545764-1-lian%40is.s.u-tokyo.ac.jp
