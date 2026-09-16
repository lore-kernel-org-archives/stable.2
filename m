Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089E4AA3F0;
	Wed, 16 Sep 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561197; cv=none; b=pLfbE/ypkBYJFf+2FCh6ZPzApasL97Jld4npEBe4FlyRgNBO+ZasI6YzxtBTlc96m9eghYifyQGKLbvZ19Nj9M5ir9JmE+NzQsGuCXJ3whFfvcwbgFcuj0racZqzdMAuTbpaO6z/ozpiIR2J7FvkUm+N4/evJbY+OuKAqN6K5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561197; c=relaxed/simple;
	bh=rnkWkSOEu7YXaz7bpizKDX9Y58WOLxZiZmQZMSzqt1c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3hLaaV4KYj9K9/c4RwCGXH2lcsz0F0AxYZeDyJfXUQwZP5nM8A5JaN6d454xnEfjt5SrxP2bmfB22QKgFrGCKvcb6QegpTiAeER7UAePIcBOeQvXbzj3uFcbsibYZ+ptcTI9/+JKX/geOwqi5TRWgRCq1k5oxZhUq+Y8hl3iQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx0ry42Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx0ry42Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBA81F000FF;
	Wed, 16 Sep 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561194;
	bh=i5UdL6gTnkMUO+rABahMdauOleoqJl+s4nvjjESyqSs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xx0ry42ZegUssp8mWeCJo0cT+U0+FNS98OWVDmRFUx6Oj7HllrNGUdmQ85Bex+iGk
	 OAGw21aUFpqnKyRcqCBmMXKR8w0lX5EVymEaJjnz79Kryo8jZ8d2AQw3e23JoaT06f
	 o+KV5KWD6D1FSSPjchfTUyYpiN8pD6QkGK4IJrPmpMLWQwnAS82gbCOOykyO+vIJOf
	 nKUVXJy9UtZ2w3gXaib9tDr8t+10WZ+iYYAmhDVWwl6L75NXnXjcU4LHhaEJ8HJaST
	 b4qdnM4FNPIr4hnOUfzMY7yha/zk4hSbpF3wmMCOiCKgRpjOHbItK3KyifW0VJlu50
	 2WcQPak1Yor/Q==
Subject:
 Re: [PATCH net 1/2] nfc: digital: reserve proper headroom for chaining_skb
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: david@ixit.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, davem@davemloft.net, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 12:19:53 +0000
Message-ID: <178956119313.22033.11501666376962461022@kernel.org>
In-Reply-To: <20260912131852.1651462-2-liuc63@xiaopeng.com>
References: <20260912131852.1651462-2-liuc63@xiaopeng.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 1 · Low: 0

- [High] State confusion between the RX reassembly buffer and the TX
  chaining buffer (`ddev->chaining_skb`) is left unfixed, and the patch…
- [High] The patch adds `ddev->tx_tailroom` to the gather buffer but does
  not protect that reserve from being consumed by gathered payload, so…
- [Medium] The commit message presents "Once the chained payload is fully
  gathered, it is passed to digital_tg_send_dep_res() or…

--

nfc: digital: reserve proper headroom for chaining_skb

The patch replaces the nfc_alloc_recv_skb() allocation of ddev->chaining_skb
in digital_recv_dep_data_gather() with digital_skb_alloc(), and passes
ddev->tx_headroom / ddev->tx_tailroom to the skb_copy_expand() call in the
same function, so the reassembly buffer carries the headroom and tailroom
the DEP send path expects.

A few questions about the change and the commit message below.

>     digital_recv_dep_data_gather() allocates chaining_skb with
>     nfc_alloc_recv_skb(), which only reserves 1 byte of headroom.
>     Once the chained payload is fully gathered, it is passed to
>     digital_tg_send_dep_res() or digital_in_send_dep_req(), both of
>     which push a 3-byte DEP header plus up to 2 bytes of SoD, needing
>     at least 5 bytes of headroom.

[Severity: Medium]
The message describes "Once the chained payload is fully gathered, it is
passed to digital_tg_send_dep_res() or digital_in_send_dep_req()" as the
intended design.  Is that transition actually intended?

ddev->chaining_skb serves two different purposes: the receive reassembly
buffer filled by digital_recv_dep_data_gather(), and the pending transmit
data set by digital_send_dep_data_prep().  The ACK branches consume whatever
is in the field as transmit data.

In target mode digital_tg_recv_dep_req() does:

	/* Keep on sending chained PDU */
	if (!ddev->chaining_skb ||
	    DIGITAL_NFC_DEP_PFB_PNI(pfb) !=
			ddev->curr_nfc_dep_pni) {
		rc = -EIO;
		goto exit;
	}
	...
	rc = digital_tg_send_dep_res(ddev, ddev->chaining_skb);

With ddev->tx_headroom = tx_headroom + DIGITAL_MAX_HEADER_LEN from
nfc_digital_allocate_device(), the skb_push() in digital_tg_send_dep_res()
no longer panics, so this branch now completes: the gathered payload is sent
back to the peer as a DEP_RES, nfc_tm_data_received() is never reached for
it, and ddev->curr_nfc_dep_pni advances on that transmission.

Could the message mention this behaviour change and the dual use of
chaining_skb?  As written, a reviewer or stable backporter would read it as
making the chaining path correct rather than removing one crash symptom.

> diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
> index 3982fa084737f..6d8e662a3819a 100644
> --- a/net/nfc/digital_dep.c
> +++ b/net/nfc/digital_dep.c
> @@ -240,8 +240,8 @@ digital_recv_dep_data_gather(struct nfc_digital_dev *ddev, u8 pfb,
>  
>  	if (DIGITAL_NFC_DEP_MI_BIT_SET(pfb) && (!ddev->chaining_skb)) {
>  		ddev->chaining_skb =
> -			nfc_alloc_recv_skb(8 * ddev->local_payload_max,
> -					   GFP_KERNEL);
> +			digital_skb_alloc(ddev,
> +					  8 * ddev->local_payload_max);

[Severity: High]
This makes the receive gather buffer send-capable.  Does that turn the
initiator-mode ACK path from an immediate skb_under_panic() into a NULL
pointer dereference?

digital_recv_dep_data_gather() leaves the reassembly buffer in
ddev->chaining_skb and returns NULL while the MI bit is set.  If the peer
then sends an ACK PDU with a matching PNI, digital_in_recv_dep_res() runs:

	rc = digital_in_send_dep_req(ddev, NULL,
				     ddev->chaining_skb,
				     ddev->data_exch);

ddev->data_exch is written only in digital_send_dep_data_prep():

		ddev->chaining_skb = skb;
		ddev->data_exch = data_exch;

and it is never reset to NULL.  ddev itself is zero allocated in
nfc_digital_allocate_device():

	ddev = kzalloc_obj(*ddev);

So if no transmit chaining ever happened on this link, is NULL passed down
as the completion argument, and does the next digital_in_recv_dep_res()
then dereference it at exit:

	data_exch->cb(data_exch->cb_context, resp, rc);

If a previous chained exchange did run, the error: label already did
kfree(data_exch), so can the same path be a use-after-free instead?

Separately, that ACK branch ends in goto free_resp without freeing the
valid per-exchange data_exch that came in as arg.  Does this leak the
digital_data_exch allocation?

Would separating the receive-gather state from the transmit-chaining state,
or rejecting an ACK PDU whose chaining_skb came from the gather path, be a
better fix than enlarging the buffer?

>  		if (!ddev->chaining_skb) {
>  			rc = -ENOMEM;
>  			goto error;
> @@ -251,9 +251,9 @@ digital_recv_dep_data_gather(struct nfc_digital_dev *ddev, u8 pfb,
>  	if (ddev->chaining_skb) {
>  		if (resp->len > skb_tailroom(ddev->chaining_skb)) {
>  			new_skb = skb_copy_expand(ddev->chaining_skb,
> -						  skb_headroom(
> -							  ddev->chaining_skb),
> -						  8 * ddev->local_payload_max,
> +						  ddev->tx_headroom,
> +						  8 * ddev->local_payload_max +
> +							  ddev->tx_tailroom,
>  						  GFP_KERNEL);

[Severity: High]
The tailroom reserve is added to the allocation, but is anything keeping the
gathered payload out of it?  The append guard is:

	if (resp->len > skb_tailroom(ddev->chaining_skb)) {

skb_tailroom() returns the whole end - tail region, which now includes the
ddev->tx_tailroom bytes this hunk reserves.  The fragment length is chosen
by the peer and only upper-bounded by the resp->len > ddev->local_payload_max
check in digital_tg_recv_dep_req(), so a peer sending MI fragments of one
payload byte each always satisfies 1 <= tailroom, and skb_put_data()
decrements the tailroom down to exactly 0 without ever taking the
skb_copy_expand() branch.

After that, an ACK PDU with a matching PNI reaches
digital_tg_send_dep_res(ddev, ddev->chaining_skb), which appends the DID
byte to the caller-supplied skb before digital_send_dep_data_prep() can copy
into a fresh buffer:

	if (ddev->did) {
		dep_res->pfb |= DIGITAL_NFC_DEP_PFB_DID_BIT;

		skb_put_data(skb, &ddev->did, sizeof(ddev->did));
	}

ddev->did is remote controlled (ddev->did = atr_req->did in
digital_tg_recv_atr_req(), values 1..14 accepted).  With tailroom at 0, does
this skb_put() run past skb->end into skb_over_panic() and BUG()?  The
gathered length is at least 8 * local_payload_max, which exceeds
remote_payload_max, so the copy into a fresh skb in
digital_send_dep_data_prep() always happens after the DID append.

Would comparing against skb_tailroom() minus ddev->tx_tailroom (plus the DID
byte), or bounding the total gathered length, keep the reserve intact?

One more accounting question on the same reserve.
nfc_digital_allocate_device() sets:

	ddev->tx_tailroom = tx_tailroom + DIGITAL_CRC_LEN;

That adds only the two CRC bytes on top of the driver request, while the
send path can append the DID byte plus CRC, i.e. three bytes.  Is the
reserve one byte short even when it is not consumed by payload?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912131852.1651462-1-liuc63%40xiaopeng.com
