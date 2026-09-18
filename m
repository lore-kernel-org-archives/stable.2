Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DA2836A6;
	Fri, 18 Sep 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735117; cv=none; b=kw6tpJt2TPjpQlVM1fzzZcQiq6MqynF674xh/EzYfNUlS2rDAN0PRJ79ujxRMj8CE1zqHN5NonUQ4tKABh4SFdkyCTxYyYXym2jNIHVmqsLTxDx0IarTDjBgAXXyYVDit6HwJLXixZNbW5Iaudwg47bsyQ6Jdz7k3pClBZc4QrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735117; c=relaxed/simple;
	bh=iYeutQZD6Gk9hpc7D02W+Xmug8i3J61E0WyDI1nrRPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPOecKqFw8VGgRcHDefxejLaEqkfj/8lSNYcnMl2ykbM0zqzb9t1FG02I2FHOf/5ckZrbbCUmAcSELWZhxZrRtcm6JufvEE+Da0y7dzrv9ovhAkK7Hyl6OVMI6HVyjvNWvstgvEer2tRaF+9y0y6FtlAWwCkO8LINe4n+P/WVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgkelU60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgkelU60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DA21F000FF;
	Fri, 18 Sep 2026 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735116;
	bh=DGlZyW22wJe57M3Ug03904sWsQaDF2JZcMWEjWw8WtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dgkelU60004YG6IzlKdKWEjY1QsNBsqRM6/g+hO9vX0nM3L8IHILae7SY0OXlV2iB
	 6sPwDa/5KLa5BRCwtAxjBROwyXokuCoAQN7ga7RD7IxXj0lOjG6LddIFY22diqYZ5Z
	 Q5HhjC/lQa8GJwhnpfU78+ryylXNMNoQh6xum0f5syysExvbIsUjqCNBX4fCvIJLLX
	 Uvusf5RavxZp90klCjUzKkyu0We8Q95OuUy4GR/dNROzuG5Yg6Y0xHFSnLOiDHJah0
	 4Gn0206KZ0KCKk0f8l+5BZLhBuhLDbRivBUKC1Ne+CHiRUJczBgBIb6ONsLJc10be3
	 Bqn1q6jDh5oag==
Date: Fri, 18 Sep 2026 13:38:28 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: liuc63@xiaopeng.com, david@ixit.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dan.carpenter@linaro.org, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: hci: add bounds checking in
 nfc_hci_create_pipe()
Message-ID: <20260918123828.GI51261@horms.kernel.org>
References: <20260912115720.530715-1-liuc63@xiaopeng.com>
 <178952042575.22033.9676833200303972344@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178952042575.22033.9676833200303972344@kernel.org>

On Wed, Sep 16, 2026 at 01:00:25AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:

Hi Liu,

There is an expectation that AI-generated reviews forwarded to
the netdev ML are responded to. That can take a variety of forms
including an email response that agrees with or refutes the review,
or an updated version of the patch with an appropriate changelog.

The expectation is the patch author or submitter handles this.
But in order to move things along, in this case I've taken a look over it.

> 
> Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0
> 
> - [High] The patch validates the pipe id inside nfc_hci_create_pipe()
>   only, but the out-of-bounds store the commit message names as the…
> 
> Pre-existing issues:
> - [High] Incomplete fix for the same bug class: the ST NFC drivers still
>   index hdev->pipes[NFC_HCI_MAX_PIPES] (128 entries) with a raw…
> - [Medium] hdev->pipes[] and hdev->gate2pipe[] are mutated from two
>   contexts with no lock in common.
> 
> --
> 
> nfc: hci: add bounds checking in nfc_hci_create_pipe()
> 
> This adds a length check on the ADM_CREATE_PIPE response before casting it
> to struct hci_create_pipe_resp, and rejects pipe ids at or above
> NFC_HCI_MAX_PIPES in nfc_hci_create_pipe().  The result code is set so the
> caller does not treat a rejected pipe as success.
> 
> > diff --git a/net/nfc/hci/command.c b/net/nfc/hci/command.c
> > index af6bacb3ba986..9c8bcb98b9677 100644
> > --- a/net/nfc/hci/command.c
> > +++ b/net/nfc/hci/command.c
> > @@ -225,10 +225,19 @@ static u8 nfc_hci_create_pipe(struct nfc_hci_dev *hdev, u8 dest_host,
> >  	if (*result < 0)
> >  		return NFC_HCI_INVALID_PIPE;
> >  
> > +	if (skb->len < sizeof(*resp)) {
> > +		kfree_skb(skb);
> > +		*result = -EPROTO;
> > +		return NFC_HCI_INVALID_PIPE;
> > +	}
> >  	resp = (struct hci_create_pipe_resp *)skb->data;
> >  	pipe = resp->pipe;
> >  	kfree_skb(skb);
> >  
> > +	if (pipe >= NFC_HCI_MAX_PIPES) {
> > +		*result = -EINVAL;
> > +		return NFC_HCI_INVALID_PIPE;
> > +	}
> 
> [Severity: High]
> 
> Does this placement actually cover the store named in the commit message?
> The changelog says:
> 
>   "A response carrying a pipe id above 127 makes the caller,
>    nfc_hci_connect_gate(), write past the end of hdev->pipes[]."
> 
> But nfc_hci_connect_gate() also receives a pipe id directly as an argument,
> and in that case nfc_hci_create_pipe() is never called:
> 
> net/nfc/hci/command.c:nfc_hci_connect_gate() {
> 	if (pipe == NFC_HCI_DO_NOT_CREATE_PIPE)
> 		return 0;
> 	...
> 	if (pipe != NFC_HCI_INVALID_PIPE)
> 		goto open_pipe;
> 	...
> open_pipe:
> 	r = nfc_hci_open_pipe(hdev, pipe);
> 	...
> 	hdev->pipes[pipe].gate = dest_gate;
> 	hdev->pipes[pipe].dest_host = dest_host;
> 	hdev->gate2pipe[dest_gate] = pipe;
> }
> 
> Only 0x81 (NFC_HCI_DO_NOT_CREATE_PIPE) returns early and 0x80
> (NFC_HCI_INVALID_PIPE) falls into the create path, so any value in
> 0x82..0xff takes the goto open_pipe branch and, once the controller ACKs
> ANY_OPEN_PIPE, writes two bytes at offset 2 * pipe in the 256-byte
> hdev->pipes[] array.
> 
> Can that argument hold an out-of-range value?  The ST driver stores the raw
> controller byte into init_data:
> 
> drivers/nfc/st21nfca/core.c:st21nfca_hci_load_session() {
> 	...
> 	hdev->init_data.gates[j].pipe = pipe_info[2];
> 	...
> }
> 
> hdev->init_data is assigned once in nfc_hci_allocate_device() and is never
> re-initialized, and the session-id-mismatch branch of
> hci_dev_session_init() calls nfc_hci_disconnect_all_gates() (which resets
> gate2pipe[], removing the -EADDRINUSE early return) before replaying those
> ids:
> 
> net/nfc/hci/core.c:hci_dev_session_init() {
> 	...
> 	r = nfc_hci_disconnect_all_gates(hdev);
> 	if (r < 0)
> 		goto exit;
> 
> 	r = hci_dev_connect_gates(hdev, hdev->init_data.gate_count,
> 				  hdev->init_data.gates);
> 	...
> }
> 
> net/nfc/hci/core.c:hci_dev_connect_gates() {
> 	...
> 	r = nfc_hci_connect_gate(hdev, NFC_HCI_HOST_CONTROLLER_ID,
> 				 gates->gate, gates->pipe);
> 	...
> }
> 
> Would it be better to validate at the write site in nfc_hci_connect_gate(),
> or in a single helper used by both paths, so the out-of-bounds store the
> changelog describes is actually closed?

This does seem to be a valid concern and I suggest handling it by add
validation to nfc_hci_connect_gate() rather than nfc_hci_create_pipe().

> 
> [Severity: High]
> 
> This isn't a bug introduced by this patch, but the same two defect classes
> still exist in the ST NFC drivers, which index the same 128-entry
> hdev->pipes[] array with a raw controller byte.

I think that this is orthogonal to the purpose of this patch and
should be treated as a separate issue; I don't think it needs
to affect progress of this patch.

...

> [Severity: Medium]
> 
> This is a pre-existing issue and not something this patch changes, but
> hdev->pipes[] and hdev->gate2pipe[] are updated from two contexts with no
> lock in common, which is worth noting since the newly validated pipe id
> feeds one of them.

Ditto.

...

-- 
pw-bot: changes-requested
