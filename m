Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE124AF674;
	Wed, 16 Sep 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561197; cv=none; b=efp4qDUW0P8ixgXtLJF5h0c8kJCaqt/if5ABG1sNcv2Jm16Ks/5MiCvQNcK5ab3pqsZj61KDcS6x8QkidFvRo3YRfoDNU4sNT6KMJDLK8g+dRxREhLEcsEFwQoKQ9YG2Yl+kfpPkfRJBUoSpprcsGYC6TVXONW2jMD+/C6/UgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561197; c=relaxed/simple;
	bh=2izfVgtzlzg97zqeAqiXFaNuBVhvDeqLBqMYQULzLJQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNeLYNMaAHwnuZ72PhReKQPlf5IB3c7Zd2YL0iaJ0EOcs839XaLAd4b7MzIHJs9zl0miHwbowxi4+rLGEGMRV+WBAXgyYPe6M2eBbW0ZHTXgDURvNJ2EUTU899YVjrA3TfxtAaAp6jqp9euNFHLXPpp8FPfbpOdB+yjD9EUtSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCWcdO+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCWcdO+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF671F00893;
	Wed, 16 Sep 2026 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561195;
	bh=uHjetJHb8nBe4Db+3GYbjIv0ItLXqe8QTau6gX4C8Hc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QCWcdO+bHysQA4ijRu1Vhw8Yrcy6Qjs8Q06CRZx5j1ovO385hF/R7CrO7LiZPLFid
	 E3pygoWIzOii0ugLwsdxk+K2Artp/jgg3DciyYHGrOlZhgU8nu1as/LvoHoSe0UgEQ
	 ggjIyNyJOx373fkUxRxM8S8wuwh6874bxYfBmdiY9TfOlwmzGyD2lZStjQ5/5BeG93
	 wt72i1++QG/rl0EXUelfz8apxJBoKAXuFKIwxOpj7WrqdAJ7RnC/yJw+NhOTycD6uI
	 pkJylfhV2rSWcj/UQVfMdvTbAgtWD1ynZ1ufXFQZizcsRuGrcYEjzGqY2n79ntJ6Xv
	 mNKJKYby68SXQ==
Subject: Re: [PATCH net 2/2] nfc: digital: check resp length in
 digital_tg_send_atr_res_complete()
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: david@ixit.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, davem@davemloft.net, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 12:19:54 +0000
Message-ID: <178956119445.22033.18320417961342899452@kernel.org>
In-Reply-To: <20260912131852.1651462-3-liuc63@xiaopeng.com>
References: <20260912131852.1651462-3-liuc63@xiaopeng.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

- [Medium] The commit message's justification ("The downstream handlers
  (digital_tg_recv_psl_req, digital_tg_recv_dep_req) each have their own…

Pre-existing issues:
- [Medium] Sibling instance of the same unchecked-length read remains in
  the same file: digital_in_recv_dep_res() reads resp->data[0] as the…
- [Medium] Frame-format disagreement kept (and re-written) by the patch:
  digital_tg_send_atr_res_complete() derives the SoD presence from the…

--

nfc: digital: check resp length in digital_tg_send_atr_res_complete()

This adds a resp->len check to digital_tg_send_atr_res_complete() before
reading resp->data[0] and resp->data[offset], and frees the skb and
restarts polling when the frame is too short.

A few questions below.

> nfc: digital: check resp length in digital_tg_send_atr_res_complete()
>
>     The downstream handlers (digital_tg_recv_psl_req, digital_tg_recv_dep_req)
>     each have their own length checks, so the consequence is a misdirected
>     dispatch on stale data rather than memory corruption.

[Severity: Medium]
Is this statement accurate for digital_tg_recv_dep_req()?  That handler
validates only resp->len >= sizeof(struct digital_dep_req_res), i.e. 3
bytes (dir, cmd, pfb), and then reads byte 3 before any further length
test:

net/nfc/digital_dep.c:digital_tg_recv_dep_req() {
	...
	size = sizeof(struct digital_dep_req_res);
	dep_req = (struct digital_dep_req_res *)resp->data;

	if (resp->len < size || dep_req->dir != DIGITAL_NFC_DEP_FRAME_DIR_OUT ||
	    dep_req->cmd != DIGITAL_CMD_DEP_REQ) {
		rc = -EIO;
		goto exit;
	}

	pfb = dep_req->pfb;

	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
		if (ddev->did && (ddev->did == resp->data[3])) {
	...
}

The "if (size > resp->len)" test that would cover byte 3 runs only after
that comparison, so it does not guard the read.

The precondition is a nonzero ddev->did, which the remote peer sets in
digital_tg_recv_atr_req():

	ddev->did = atr_req->did;

so a peer that negotiates a DID and then sends a 3-byte DEP_REQ payload
with the DID bit set in PFB makes digital_tg_recv_dep_req() read
resp->data[3] one byte past resp->len.  Should the check also be extended
there, or should the changelog drop the claim that the downstream handlers
cover this?

> diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
> index 6d8e662a3819a..5093b7b817202 100644
> --- a/net/nfc/digital_dep.c
> +++ b/net/nfc/digital_dep.c
> @@ -1467,16 +1467,19 @@ static void digital_tg_recv_psl_req(struct nfc_digital_dev *ddev, void *arg,
>  static void digital_tg_send_atr_res_complete(struct nfc_digital_dev *ddev,
>  					     void *arg, struct sk_buff *resp)
>  {
> -	int offset;
> +	unsigned int offset;
>  
>  	if (IS_ERR(resp)) {
>  		digital_poll_next_tech(ddev);
>  		return;
>  	}
>  
> -	offset = 2;
> -	if (resp->data[0] == DIGITAL_NFC_DEP_NFCA_SOD_SB)
> -		offset++;
> +	if (!resp->len)
> +		goto bad_frame;
> +
> +	offset = (resp->data[0] == DIGITAL_NFC_DEP_NFCA_SOD_SB) ? 3 : 2;
> +	if (resp->len <= offset)
> +		goto bad_frame;

[Severity: Medium]
This isn't a bug introduced by this patch, since the byte-value heuristic
is only reformatted into a ternary here, but while this offset computation
is being rewritten, would it be better to derive the SoD presence from
ddev->curr_rf_tech the way the encoder/decoder pair does?

net/nfc/digital_dep.c:digital_skb_push_dep_sod() {
	if (ddev->curr_rf_tech == NFC_DIGITAL_RF_TECH_106A)
		*(u8 *)skb_push(skb, sizeof(u8)) = DIGITAL_NFC_DEP_NFCA_SOD_SB;
}

net/nfc/digital_dep.c:digital_skb_pull_dep_sod() {
	if (ddev->curr_rf_tech == NFC_DIGITAL_RF_TECH_106A)
		skb_pull(skb, sizeof(u8));
}

In 212F/424F target mode there is no SB byte, so data[0] is the LEN byte.
Can a LEN of 0xF0 (240, legal since local_payload_max is
DIGITAL_PAYLOAD_SIZE_MAX) make this pick offset 3 and read the PFB byte as
the command byte?

DIGITAL_CMD_PSL_REQ is 0x04 and DIGITAL_NFC_DEP_PFB_DID_BIT is also 0x04,
so a first DEP_REQ (I-PDU, PNI 0, DID in use) of exactly that size would
have PFB == 0x04 and be dispatched to digital_tg_recv_psl_req(), which
then drops it:

net/nfc/digital_dep.c:digital_tg_recv_psl_req() {
	if (resp->len != sizeof(struct digital_psl_req) ||
	...
		rc = -EIO;
		goto exit;
	}
}

Does that stall the DEP session, since the frame is freed with no reply?
The new bounds check is computed from the same offset, so it inherits the
disagreement.

>  
>  	ddev->atn_count = 0;
>  
> @@ -1484,6 +1487,12 @@ static void digital_tg_recv_psl_req(struct nfc_digital_dev *ddev, void *arg,
>  		digital_tg_recv_psl_req(ddev, arg, resp);
>  	else
>  		digital_tg_recv_dep_req(ddev, arg, resp);
> +
> +	return;
> +
> +bad_frame:
> +	kfree_skb(resp);
> +	digital_poll_next_tech(ddev);
>  }

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but there
is a sibling unchecked read of the same kind in the same file, in
digital_in_recv_dep_res().  Would it make sense to cover it in the same
series?

net/nfc/digital_dep.c:digital_in_recv_dep_res() {
	...
	if (size > resp->len) {
		rc = -EIO;
		goto error;
	}

	skb_pull(resp, size);
	...
	case DIGITAL_NFC_DEP_PFB_SUPERVISOR_PDU:
	...
		rtox = DIGITAL_NFC_DEP_RTOX_VALUE(resp->data[0]);
}

With a 3-byte DEP_RES payload (dir, cmd, pfb and no DID/NAD bit), size is
3, so both "resp->len < size" and "size > resp->len" pass, and the
skb_pull() leaves resp->len == 0.  The SUPERVISOR_PDU plus timeout-bit
branch then reads resp->data[0] one byte past resp->len and feeds the
masked value to digital_in_send_rtox() as a timeout.  Both ddev->atn_count
and ddev->nack_count are zeroed just above, so the branch is reachable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912131852.1651462-1-liuc63%40xiaopeng.com
