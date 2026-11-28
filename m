Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875220;
	b=D7YyUApjgDi7ZqXJWY1Uod/aDqDvD8O7ZpbIFrb99sRnGHPSjooT7d45dWSzBczBArYh
	 weevEe2ZIvDcfEOjKi0Lj7Ooz4suuux+Vo5iqTN5yQG66VcNGjLzxzTmi0WuGVhQ/oeN+
	 sgL0sAtv6uGhA0B13ogPDvadSy4wplcdljaFtXFa1be9DhfuhiWIa+zvRe3R2UlbrM3Gt
	 LyyInZZYM1pFTLnBNOf+ZgR8Ao/6B+8B/PKLm63vYFdHHmBSfVK1yyJV1HdOLDzmrVoVR
	 SpqfA+MCRexXAuQ+NUm/hV67HbzfCBFCDS5vlqpb/N7QmlyKB9nfDVmTbM5EC2+Er4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875220;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MfbJlqAYuqKvbh4oLT4dnNJ370gx6Q2LecWWnOcU8gg=;
	b=gckBJ1FYYqq3E6Zvh6Ui8j5FMd+3kMdFN21U58Kgmn9EdQuU9V6M4LQnQN402tiejWoB
	 kqS+amaAU9W5IrPgGvBPJVJ162UvJIncNDZhfz+pLDv8YX3J3xFLgJe1TrWUgOTOg7I0r
	 rvnTNHFg+ZNtoXbTJOgVzNt6CTZlJkhX6WFnDVmpsgJ6Rmjv8i+A/gFIhoLsH0HkZGIH6
	 Rd0t8htpFrZl6+v7H3N1Ht7wPwTs+mejupIokTVkqLesg4v4bd9AySJB4QJ90AyC0i89o
	 hGVM9rdJnje9mxPVpCHA9VhcaLeD99hbiP1F/OQsBpRIyLLIOcrbhip9hN9h7hS7mcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO5zEZ+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703A606A32A;
	Sat, 28 Nov 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO5zEZ+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE8E1F000C1;
	Sat, 28 Nov 2026 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875220;
	bh=MfbJlqAYuqKvbh4oLT4dnNJ370gx6Q2LecWWnOcU8gg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YO5zEZ+1c4/CzlC5UYJ3zk0w3xEVn0YJRu3Ejo+G8fZ0dMyTZe1DUVfu2JvYRUN5M
	 yLngGxUdpqt7mJVQKJrMtHielcP1OmIzbgrsj4A1tFS+afi82LeY+wTtzlxBm0XVwA
	 rr41oq+6eXjDDfuThgkPaoY9mtOA0ZqBKIicp9lzvb3+nX8yt6aAWfSIoT/Ez0bBlf
	 ih8dBPlBueCBB6IqRWy9GwCxVN3ig2gmwy9lDncxaOTC8Ww1OV0WoWcuFqtnb69T+W
	 UW/H9oqc/iD6Ddt7kRbrGNHrv5Q7gWVx+NKlmWdoFqR6efhIU1jP4MsAi7jLrRSiTD
	 2P3VGOkIFtaLg==
Subject: Re: [PATCH v5 3/5] nfc: digital: complete DEP data exchange on
 terminal errors
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 28 Nov 2026 14:13:39 +0000
Message-ID: <179587521936.3135.8436597074279524607@kernel.org>
In-Reply-To: <20261127134029.1813-4-luob87709@gmail.com>
References: <20261127134029.1813-4-luob87709@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 (1) · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message calls the removed `if (rc)
  kfree_skb(resp);` in digital_in_recv_dep_res() "redundant".
- [Medium] The commit message says that after the change "data_exch->cb()
  is always invoked" for DEP data exchanges.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the ACK-
  PDU branch of digital_in_recv_dep_res() can be reached while RX…

--

nfc: digital: complete DEP data exchange on terminal errors

This patch changes the terminal error branches in digital_in_recv_dep_res()
to jump to the exit label instead of the error label, so data_exch->cb() is
called. It also removes the trailing kfree_skb(resp) on error, because the
callback now owns any non-NULL resp.

> diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
> index 968547c306a5d..cd6eff01235f8 100644
> --- a/net/nfc/digital_dep.c
> +++ b/net/nfc/digital_dep.c
> @@ -703,7 +703,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
>
>  			rc = digital_in_send_nack(ddev, data_exch);
>  			if (rc)
> -				goto error;
> +				goto exit;
>
>  			return;
>  		} else if ((rc == -ETIMEDOUT) &&

[Severity: Medium]
The commit message says errors are routed "so data_exch->cb() is always
invoked". Does that still hold after a retry like this one has been queued?

All of these go through digital_in_send_cmd() -> digital_send_cmd():

  digital_in_send_nack()
  digital_in_send_atn()
  digital_in_send_rtox()
  digital_in_send_saved_skb()
  digital_in_send_ack()
  digital_in_send_dep_req()

digital_send_cmd() only queues the command and returns 0, so this path
returns and waits for the next response.

If the driver's send fails later, digital_wq_cmd() drops the command
without calling cmd->cmd_cb:

net/nfc/digital_core.c:digital_wq_cmd() {
    ...
	pr_err("in_send_command returned err %d\n", rc);

	mutex_lock(&ddev->cmd_lock);
	list_del(&cmd->queue);
	mutex_unlock(&ddev->cmd_lock);

	kfree_skb(cmd->req);
	kfree(cmd->mdaa_params);
	kfree(cmd);
    ...
}

digital_unregister_device(), by contrast, does notify the issuer:

	if (cmd->cmd_cb)
		cmd->cmd_cb(ddev, cmd->cb_context, ERR_PTR(-ENODEV));

In that case digital_in_recv_dep_res() never runs again for the exchange.
data_exch is leaked and data_exch->cb() is never called.

For rawsock, this looks like the same hang the commit message describes.
The sock_hold() taken in rawsock_tx_work() is never dropped, and
tx_work_scheduled stays set.

This needs an in_send_cmd() failure from the driver. Examples are trf7970a
returning -EIO, -EBUSY or -ECANCELED, or a port100 USB submit failure.

Is a matching change needed in digital_wq_cmd(), calling cmd->cmd_cb with
ERR_PTR(rc), to close this completely? If not, could the commit message
be narrowed?

[ ... ]

> @@ -847,7 +847,7 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
>  					     ddev->chaining_skb,
>  					     ddev->data_exch);
>  		if (rc)
> -			goto error;
> +			goto exit;
>
>  		goto free_resp;
>

[Severity: Critical]
This isn't a bug introduced by this patch, but this branch is being
touched. Can a remote target reach this ACK PDU branch while RX chaining
is in progress, rather than TX chaining?

The only guard before the digital_in_send_dep_req() call is:

		if (!ddev->chaining_skb) {
			PROTOCOL_ERR("14.12.4.3");
			rc = -EIO;
			goto exit;
		}

This accepts any chaining buffer. During RX reassembly,
digital_recv_dep_data_gather() stores the receive buffer in the same
field:

	if (DIGITAL_NFC_DEP_MI_BIT_SET(pfb) && (!ddev->chaining_skb)) {
		ddev->chaining_skb =
			nfc_alloc_recv_skb(8 * ddev->local_payload_max,
					   GFP_KERNEL);

nfc_alloc_recv_skb() reserves only 1 byte of headroom, and
skb_copy_expand() keeps it:

	total_size = size + 1;
	skb = alloc_skb(total_size, gfp);

	if (skb)
		skb_reserve(skb, 1);

A target could do the following:

  1) Reply to a DEP_REQ with an I-PDU that has MI set and the correct PNI.
     The initiator allocates the RX chaining skb and sends an ACK
     carrying curr_nfc_dep_pni.
  2) Reply with a DEP_RES ACK PDU using that PNI.

All the checks pass, and digital_in_send_dep_req() then runs this on the
RX buffer:

	skb_push(skb, sizeof(struct digital_dep_req_res));

Would this push 3 bytes into 1 byte of headroom and hit
skb_under_panic() -> BUG()?

There is a second issue. ddev->data_exch is only written in
digital_send_dep_data_prep():

		ddev->chaining_skb = skb;
		ddev->data_exch = data_exch;

It is never cleared, including when the exit label does kfree(data_exch).
On this path it would be NULL or point to an earlier exchange that has
already been freed.

Even without the headroom problem, the queued command would carry a stale
or NULL cb_context. Wouldn't the next digital_in_recv_dep_res() then call
data_exch->cb() through freed memory or a NULL pointer, while the current
exchange's data_exch is orphaned?

> @@ -883,7 +883,6 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
>  exit:
>  	data_exch->cb(data_exch->cb_context, resp, rc);
>
> -error:
>  	kfree(data_exch);
>
>  	kfree_skb(ddev->chaining_skb);
> @@ -892,9 +891,6 @@ static void digital_in_recv_dep_res(struct nfc_digital_dev *ddev, void *arg,
>  	kfree_skb(ddev->saved_skb);
>  	ddev->saved_skb = NULL;
>
> -	if (rc)
> -		kfree_skb(resp);
> -
>  	return;
>
>  free_resp:

[Severity: Medium]
The commit message describes this as dropping "the redundant
kfree_skb(resp)". Is "redundant" accurate for the series as posted?

The earlier patch "net/nfc: fix skb ownership on data exchange errors"
changed rawsock_data_exchange_complete() and nfc_llcp_recv() to free a
non-NULL skb when err != 0:

net/nfc/rawsock.c:rawsock_data_exchange_complete() {
    ...
	if (err) {
		if (skb)
			kfree_skb(skb);
		goto error;
	}
    ...
}

That patch does not touch net/nfc/digital_dep.c. Neither does "nfc: pn533:
clear resp after queueing to avoid double free".

So at both of those intermediate commits, the existing goto exit paths
that carry a non-NULL resp with rc != 0 free resp twice. One malformed
DEP_RES frame is enough:

digital_in_recv_dep_res()
  digital_skb_pull_dep_sod() returns -EIO
  goto exit
  data_exch->cb(data_exch->cb_context, resp, -EIO)
    rawsock_data_exchange_complete()
      kfree_skb(skb)
  if (rc) kfree_skb(resp)    <- second free

The same applies to these paths:

  - the -EMSGSIZE check
  - the NAD bit check
  - the ACK PDU checks for the NACK bit, a PNI mismatch and a missing
    chaining_skb

The reverse case also breaks. If this patch is backported to stable
without the ownership patch, the callbacks there don't free on error.
Wouldn't resp then leak on every terminal error path, including the ones
that already went to exit before this patch?

Both patches carry Cc: stable, but this one only has Fixes: 7d0911c02fa2
and no dependency note.

Could this be squashed into the ownership patch? Alternatively, could the
commit message say that this removal is required by that patch, and note
the dependency for stable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127134029.1813-1-luob87709%40gmail.com
