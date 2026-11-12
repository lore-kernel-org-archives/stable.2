Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469989;
	b=0/Ec/ygH1XLA4ico6XZmHhJa6+VFPdFzKsYpspCgygl57wQj+ht47+hFhQ4qW6R8P7xp
	 OmWRQAcjWhMPGonNNVtC+k6aKZi97ucZ0W/9AlRAk6Sdl45OFsWWW+3ixuaiyx2J6BR+4
	 8weE2NrM9DpW9MWRGKTuLrqummOhOO9ll8HTICb1MuczvMhBy23w1LkCJJRtXUs1lWiAE
	 HwhNIrZwkzA/Z6XeVfkEvhWE36G2hqPWIx5dWNa/3brKvDfL1Sk9o6O7alPhTIkqgXcHB
	 P0PylKYn9jXOGTu6OG8NAvM/XdiMM4cXzo8cgvtu2nYXyzAo+49g34ikfbxdY98W7Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469989;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kUvWL3Dc/xCMK7UgSfWYY6w0DOd38KkDU0iyRvpQV4I=;
	b=izwliCIkNt/tRadghyvYG6p5XBuBoB11E8Dbxel3wXBdZnoxiGLlJpkHzUviLvCj94GP
	 vm3bbNaL87COBWxBONxTrvEweoLDVMNcq6HliPtCP7GuqKiroXSsFfCc6I3/fn5eVgh9n
	 LVkqQzDMFl6YOx7j0bJZ9YV3hjzIIHDOIMTW+XUvVmTIXbTafUpaD9svTqwcKk8FBQcVg
	 T5lQVYG105QwYs3eljfyqBJUlzQ2UZbvYXQUvKPwWqYaAoPzdee6IGahbKN4u9yvQxrEL
	 nqWJRO9IrN6pf7THLyW63FOGJCLe4HzvbQA9Dw9IWDHxzdU66wiM0a/xfAo9VwI8ytw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWn9LN8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB64606A884;
	Thu, 12 Nov 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWn9LN8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1311F00A06;
	Thu, 12 Nov 2026 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794469989;
	bh=kUvWL3Dc/xCMK7UgSfWYY6w0DOd38KkDU0iyRvpQV4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aWn9LN8MWh913RlwjA17H1ftSjSxW47O7GOln4Bks4GfPv0JpNUGTmzf7IiDJAMWg
	 draWg1gmh9nSjbhpiCxn26Ev1W7yngYlMn7dN0ybBbFoHrySTwpPxdbgr5BLA2LhfI
	 8d4eKdhU5E/jRyBJLfYvoovn1QagYUEGoNYyL8yYvCr/4DN9lMEdRf3I0B/tgsdh1g
	 TxxDPr8EiIFchYJ1TJa8PB05CTgPS41O2eW4qj6MST0nKD0mGkJrjoJELGYaqLC3r7
	 +jBGB1CbHJK0pDFQVHmFndv56nD7ifUcnXa2BYMiYq3kUSCsNHOFwSTW9VSz278MFy
	 KFsJ7/fc+YOkQ==
Subject:
 Re: [PATCH 1/5] 9p/virtio: clamp the reply size of a zero-copy request
From: netdev-bot+sashiko@kernel.org
To: lian@is.s.u-tokyo.ac.jp
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux_oss@crudebyte.com, horms@kernel.org, viro@zeniv.linux.org.uk,
 tomasbortoli@gmail.com, chirantan@chromium.org, groug@kaod.org,
 aneesh.kumar@linux.vnet.ibm.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shina@is.s.u-tokyo.ac.jp,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 07:53:07 +0000
Message-ID: <179446998758.2199510.14994914047354508278@kernel.org>
In-Reply-To: <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The clamp added to p9_virtio_zc_request()
  (net/9p/trans_virtio.c) is `req->rc.size = umin(req->rc.size,…

--

9p/virtio: clamp the reply size of a zero-copy request

This commit clamps req->rc.size in p9_virtio_zc_request() to the total
size of the buffers posted to the device (in_hdr_len + inlen). The clamp
happens before handle_rerror() runs. The aim is to stop oversized error
replies to zero-copy requests from being parsed past the posted buffers.

Closes: https://lore.kernel.org/all/20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn/

> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 9fa63e3ebf673..53046668c16b1 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -537,10 +537,14 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	 * threads - echoes to wmb() in the callback
>  	 */
>  	smp_rmb();
> -	// RERROR needs reply (== error string) in static data
> -	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
> -	    unlikely(req->rc.sdata[4] == P9_RERROR))
> -		handle_rerror(req, in_hdr_len, offs, in_pages);
> +	if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
> +		// The device may report more than the buffers we posted
> +		req->rc.size = umin(req->rc.size, in_hdr_len + inlen);
> +
> +		// RERROR needs reply (== error string) in static data
> +		if (unlikely(req->rc.sdata[4] == P9_RERROR))
> +			handle_rerror(req, in_hdr_len, offs, in_pages);
> +	}

[Severity: High]
Can an oversized P9_RLERROR reply to a zero-copy TREAD still make
p9_check_errors() read past the end of rc.sdata?

For a zero-copy TREAD, p9_client_read_once() passes in_hdr_len = 11 and
inlen = rsize, which can be up to msize - 24. So the new bound can be
much larger than rc.capacity. rc.sdata is a P9_ZC_HDR_SZ (4096) byte
allocation, and only its first 11 bytes are posted to the device.

The only truncation to the rc.sdata size is in handle_rerror():

    if (unlikely(req->rc.size > P9_ZC_HDR_SZ))
        req->rc.size = P9_ZC_HDR_SZ;

That runs only when sdata[4] == P9_RERROR. p9_check_errors() skips its
capacity check for zc replies, and it handles both error types:

    if (req->rc.size > req->rc.capacity && !req->rc.zc) {
    ...
    if (type != P9_RERROR && type != P9_RLERROR)
        return 0;

On a non-.L client, both types are parsed with "s?d". The client can be
non-.L because of the mount option. It can also be non-.L because the
device answers RVERSION with "9P2000" or "9P2000.u", which
p9_client_version() accepts.

Here is the case. The device answers a zero-copy TREAD with an 11-byte
header that has type P9_RLERROR and size = 11 + inlen, plus a large
string length, and it reports used len = 11 + inlen. Then:

    p9_virtio_zc_request()
        rc.size stays 11 + inlen, handle_rerror() is skipped
    p9_check_errors()
        p9pdu_readf(&req->rc, ..., "s?d", &ename, &ecode)
            pdu_read()
                len = min(pdu->size - pdu->offset, size);
                memcpy(data, &pdu->sdata[pdu->offset], len);

pdu_read() is bounded by pdu->size, not pdu->capacity. Could that read
tens of KiB past the 4096-byte rc.sdata object?

With legacy 9P2000, the string then goes to p9_errstr2errno(), which
calls pr_err() for unknown error strings. Would that put adjacent slab
contents into the kernel log?

The commit message says the patch prevents p9_check_errors() from
parsing "the error string of an oversized error reply past the end of
rc.sdata". This case still seems reachable after the patch.

Clamping rc.size to rc.capacity for every zc reply would break
successful reads. p9_client_read_once() bounds the received count by
rc.size via "D". Would it work better to give P9_RLERROR the same
truncation and copy that P9_RERROR gets in handle_rerror()? Another
option is to bound the error-string parse in p9_check_errors() by
rc.capacity for zc replies.

>  
>  	/*
>  	 * Non kernel buffers are pinned, unpin them

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109105251.2545764-1-lian%40is.s.u-tokyo.ac.jp
