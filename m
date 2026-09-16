Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC444230264;
	Wed, 16 Sep 2026 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520428; cv=none; b=phns2rXU0yXYOwOJZCfxCDMCcCaamLDiHSjqUKdvoW2yrwK87t8OFykrdJQw3rZmnJ8bjhN0v7xkTu+3ctd5dtMQJSMsfraNWawebsyuYd40d4DI+54lm4JAxOdyeaFyWuvw1YUZmi7V9xGPuyzd5EU2zrQYMDCR4Ki9isMOq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520428; c=relaxed/simple;
	bh=k/7puuUru16qVhSGVDLooY+p6f1D1Heqog80nM6aDg4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JjEGdZEIrzDad4iAAenm/UR2guhTSmsBMetq4jehg43HBdiKi9xzIMDv9iB1zv1zsEo8gPSBehwUsYd86uGXz+5sJYDp8KeYpHmlDloKDDtu4Lrow2Dppgx+5SvqoOIl0LKvRDmshKr7RKA9VP0bpC3Z8yx6nq0FZWChuy7PfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfoVmfjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfoVmfjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D791F000FF;
	Wed, 16 Sep 2026 01:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789520426;
	bh=Dl6Ge9u0ZGmbWXWUnq2+azgJvFm1GB4DXmzKWhSXkn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VfoVmfjgL0amKdAmou6qwXpzwz5uXCLD6oZ7t0V3Ws57jkzqEWJFixEyyafTix99U
	 ByJzg+Zng6ZY221YBQ0m7OP5IjKmXVU6Lnmy+0sAWNbmEXia/nukC6FYDcaUyyWVQz
	 RghSEVzNXecXAAvpS90rIdH1Pv8Cyy3i6RSCpq5Q0hzpmE5Frwhw8sTDXI6+iQaxI6
	 LsoRZqaGqNgCfHBWkLV3a40vzKOup/MkF9Gu1obeT/aVM2vnloPUBIMNbD90M3NX+m
	 rHQXOnZRzNFuxmiK3tQQgDzVW1hhB3ziCSz7hrjTLDHscKJ2/B31AsHYKxXq+dR3S0
	 H6yua2dEdceTA==
Subject:
 Re: [PATCH net] nfc: hci: add bounds checking in nfc_hci_create_pipe()
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dan.carpenter@linaro.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 01:00:25 +0000
Message-ID: <178952042575.22033.9676833200303972344@kernel.org>
In-Reply-To: <20260912115720.530715-1-liuc63@xiaopeng.com>
References: <20260912115720.530715-1-liuc63@xiaopeng.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

- [High] The patch validates the pipe id inside nfc_hci_create_pipe()
  only, but the out-of-bounds store the commit message names as the…

Pre-existing issues:
- [High] Incomplete fix for the same bug class: the ST NFC drivers still
  index hdev->pipes[NFC_HCI_MAX_PIPES] (128 entries) with a raw…
- [Medium] hdev->pipes[] and hdev->gate2pipe[] are mutated from two
  contexts with no lock in common.

--

nfc: hci: add bounds checking in nfc_hci_create_pipe()

This adds a length check on the ADM_CREATE_PIPE response before casting it
to struct hci_create_pipe_resp, and rejects pipe ids at or above
NFC_HCI_MAX_PIPES in nfc_hci_create_pipe().  The result code is set so the
caller does not treat a rejected pipe as success.

> diff --git a/net/nfc/hci/command.c b/net/nfc/hci/command.c
> index af6bacb3ba986..9c8bcb98b9677 100644
> --- a/net/nfc/hci/command.c
> +++ b/net/nfc/hci/command.c
> @@ -225,10 +225,19 @@ static u8 nfc_hci_create_pipe(struct nfc_hci_dev *hdev, u8 dest_host,
>  	if (*result < 0)
>  		return NFC_HCI_INVALID_PIPE;
>  
> +	if (skb->len < sizeof(*resp)) {
> +		kfree_skb(skb);
> +		*result = -EPROTO;
> +		return NFC_HCI_INVALID_PIPE;
> +	}
>  	resp = (struct hci_create_pipe_resp *)skb->data;
>  	pipe = resp->pipe;
>  	kfree_skb(skb);
>  
> +	if (pipe >= NFC_HCI_MAX_PIPES) {
> +		*result = -EINVAL;
> +		return NFC_HCI_INVALID_PIPE;
> +	}

[Severity: High]

Does this placement actually cover the store named in the commit message?
The changelog says:

  "A response carrying a pipe id above 127 makes the caller,
   nfc_hci_connect_gate(), write past the end of hdev->pipes[]."

But nfc_hci_connect_gate() also receives a pipe id directly as an argument,
and in that case nfc_hci_create_pipe() is never called:

net/nfc/hci/command.c:nfc_hci_connect_gate() {
	if (pipe == NFC_HCI_DO_NOT_CREATE_PIPE)
		return 0;
	...
	if (pipe != NFC_HCI_INVALID_PIPE)
		goto open_pipe;
	...
open_pipe:
	r = nfc_hci_open_pipe(hdev, pipe);
	...
	hdev->pipes[pipe].gate = dest_gate;
	hdev->pipes[pipe].dest_host = dest_host;
	hdev->gate2pipe[dest_gate] = pipe;
}

Only 0x81 (NFC_HCI_DO_NOT_CREATE_PIPE) returns early and 0x80
(NFC_HCI_INVALID_PIPE) falls into the create path, so any value in
0x82..0xff takes the goto open_pipe branch and, once the controller ACKs
ANY_OPEN_PIPE, writes two bytes at offset 2 * pipe in the 256-byte
hdev->pipes[] array.

Can that argument hold an out-of-range value?  The ST driver stores the raw
controller byte into init_data:

drivers/nfc/st21nfca/core.c:st21nfca_hci_load_session() {
	...
	hdev->init_data.gates[j].pipe = pipe_info[2];
	...
}

hdev->init_data is assigned once in nfc_hci_allocate_device() and is never
re-initialized, and the session-id-mismatch branch of
hci_dev_session_init() calls nfc_hci_disconnect_all_gates() (which resets
gate2pipe[], removing the -EADDRINUSE early return) before replaying those
ids:

net/nfc/hci/core.c:hci_dev_session_init() {
	...
	r = nfc_hci_disconnect_all_gates(hdev);
	if (r < 0)
		goto exit;

	r = hci_dev_connect_gates(hdev, hdev->init_data.gate_count,
				  hdev->init_data.gates);
	...
}

net/nfc/hci/core.c:hci_dev_connect_gates() {
	...
	r = nfc_hci_connect_gate(hdev, NFC_HCI_HOST_CONTROLLER_ID,
				 gates->gate, gates->pipe);
	...
}

Would it be better to validate at the write site in nfc_hci_connect_gate(),
or in a single helper used by both paths, so the out-of-bounds store the
changelog describes is actually closed?

[Severity: High]

This isn't a bug introduced by this patch, but the same two defect classes
still exist in the ST NFC drivers, which index the same 128-entry
hdev->pipes[] array with a raw controller byte.

In st21nfca_hci_load_session(), the index comes straight from the
ST21NFCA_DM_GETINFO pipe list:

drivers/nfc/st21nfca/core.c:st21nfca_hci_load_session() {
	...
		pipe_info[2] = skb_pipe_list->data[i];
	...
		hdev->pipes[pipe_info[2]].gate = st21nfca_gates[j].gate;
		hdev->pipes[pipe_info[2]].dest_host = info->src_host_id;
	...
}

struct nfc_hci_pipe is two bytes, so an index of 128..255 stores at byte
offset 256..510 in a 256-byte array, first overwriting the sw_/hw_ version
fields and the async_cb / async_cb_context function pointers of the
kzalloc()'d struct nfc_hci_dev and then running past the allocation.
st_nci_hci_load_session() has the identical pattern writing
ndev->hci_dev->pipes[pipe_info[2]].

The missing length check is there too.  Both drivers cast the DM_GETINFO
response to a five-byte struct and read all five fields without requiring
skb_pipe_info->len >= sizeof(*info):

drivers/nfc/st21nfca/core.c:st21nfca_hci_load_session() {
	...
	info = (struct st21nfca_pipe_info *) skb_pipe_info->data;
	...
}

drivers/nfc/st-nci/se.c:st_nci_hci_load_session() {
	...
	dm_pipe_info = (struct st_nci_pipe_info *) skb_pipe_info->data;
	...
}

Since this series is fixing exactly these two problems for the
ADM_CREATE_PIPE response, would it make sense to cover the load_session
paths as well?

[Severity: Medium]

This is a pre-existing issue and not something this patch changes, but
hdev->pipes[] and hdev->gate2pipe[] are updated from two contexts with no
lock in common, which is worth noting since the newly validated pipe id
feeds one of them.

The command path writes them from process context after
nfc_hci_execute_cmd() has already dropped msg_tx_mutex:

net/nfc/hci/command.c:nfc_hci_connect_gate() {
	...
	hdev->pipes[pipe].gate = dest_gate;
	hdev->pipes[pipe].dest_host = dest_host;
	hdev->gate2pipe[dest_gate] = pipe;
	...
}

The notification path writes and clears the same entries from the
nfc_hci_msg_rx_work work item without taking any lock:

net/nfc/hci/core.c:nfc_hci_cmd_received() {
	...
		hdev->gate2pipe[create_info->dest_gate] = create_info->pipe;
		hdev->pipes[create_info->pipe].gate = create_info->dest_gate;
		hdev->pipes[create_info->pipe].dest_host = create_info->src_host;
	...
}

With an empty lockset intersection, can a controller-driven
ADM_NOTIFY_PIPE_DELETED or ADM_NOTIFY_ALL_PIPE_CLEARED interleave with the
three-field update above and leave gate2pipe[] pointing at an entry marked
NFC_HCI_INVALID_GATE, or a live pipes[] entry with no gate mapping?  Later
dispatch reads gate = hdev->pipes[pipe].gate in nfc_hci_event_received(),
so the effect would be mis-routed or dropped events and leaked pipe state
rather than memory corruption, since both writers do bound their indices.

>  	pr_debug("pipe created=%d\n", pipe);
>  
>  	return pipe;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912115720.530715-1-liuc63%40xiaopeng.com
