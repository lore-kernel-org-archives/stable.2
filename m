Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D12AEE1;
	Sat, 26 Sep 2026 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790420045; cv=none; b=ZZ5dYbW6V7f5LgM7Q5TWoV0ZJRwp5vCLnvFLPvUE793GdTAwZIDx6JzKaB/MTS2U0tdMwm3pqUcgPSsdPI3parIv78QMhS+0j4g5ZFEp6t06DE3JqPO9AXsUc6couqkOD7yStMBfK43JKYhM5nDhyFENCmJF92zrx6F26xGDCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790420045; c=relaxed/simple;
	bh=E8qseG3lAh2Gqznur1fW5a/Q4FQBN75qcS8bPYI94iQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXsaewltEEB75zOHJqODiBx5LAyHG8/JEr9MPoequ27eMieeO0tgKfELrAL9+qygS5nRve0o2RLDQwS2/7lpCiRwb15E0lr4UMk2FV8lWM3jhfes/APRwPHxhP91275Ry2vLb4H/4dPUpBO0gr69fAm5Xlj/TuaitAz6GAgujmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h//5IdTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h//5IdTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E7E1F000FF;
	Sat, 26 Sep 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790420043;
	bh=MEUsGDPZJ1etI6bT5VFrdoyo40LYh6UcgGZhMJWLshk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h//5IdTRClvnADITeggLeepX6FWpE6vTlokvRi4v4s18EVrn6XWy/zlW2KkGFv+pX
	 qf5mqtW5ylGpRsjaDKIzCBCzlsmYnv2uPu7yDyEdbbC0m71FVpLfao0CxGxNh+kORD
	 wz2fCMHwUaTE9n1T5MP+Buel2TFPbELHqsCYxFQYW5BfRxJgTzu+lrjs7IGlDkA3jE
	 b2jaDBS2OX0AswZaeUNRbGmdcJP+pPZCnRy8TUoBIQ5fu5Q4O6H5A0RNsNkpl2dRiE
	 67jHWIfYC1KJSX710BlGlNlaEyAuW9pAiHpX/VHDCI8PLnFZ9/8l/QUJyX/+9weZsk
	 qnWhlPTyusrPA==
Subject:
 Re: [PATCH v2] nfc: nci: ignore unexpected CORE_RESET_NTF and CORE_RESET_RSP
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: horms@kernel.org, david@ixit.cz, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 26 Sep 2026 10:54:01 +0000
Message-ID: <179042004198.2160803.79590143461584366@kernel.org>
In-Reply-To: <20260922102144.39689-1-ndaugoing@gmail.com>
References: <20260922102144.39689-1-ndaugoing@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The NCI_RESET_PENDING gate is evaluated in workqueue context
  (nci_rx_work() -> nci_rsp_packet()/nci_ntf_packet(),…
- [Low] The patch adds contradictory reset-trigger semantics in two
  artifacts of the same commit: include/net/nfc/nci.h:143-146 defines…

--

nfc: nci: ignore unexpected CORE_RESET_NTF and CORE_RESET_RSP

This adds an NCI_RESET_PENDING flag which is set when CORE_RESET_CMD is
sent and cleared when the request finishes, and gates the core layer
handling of CORE_RESET_RSP and CORE_RESET_NTF on that flag.  The intent is
that an unsolicited or delayed reset packet no longer completes an
unrelated in-flight request nor overwrites ndev->nci_ver and the
manufacturer fields.

A couple of questions below.

> diff --git a/include/net/nfc/nci.h b/include/net/nfc/nci.h
> index 09efcaed7c3f6..2ac45adba0886 100644
> --- a/include/net/nfc/nci.h
> +++ b/include/net/nfc/nci.h
> @@ -140,6 +140,11 @@
>  #define NCI_RESET_TYPE_KEEP_CONFIG				0x00
>  #define NCI_RESET_TYPE_RESET_CONFIG				0x01
>  
> +/* NCI Reset Triggers */
> +#define NCI_RESET_TRIGGER_ERROR					0x00
> +#define NCI_RESET_TRIGGER_POWER_ON				0x01
> +#define NCI_RESET_TRIGGER_RESET_CMD				0x02
> +

[Severity: Low]
Do these new definitions agree with the comment added in
nci_core_reset_ntf_packet() in the same patch?

Here 0x00 is named NCI_RESET_TRIGGER_ERROR and 0x02 is named
NCI_RESET_TRIGGER_RESET_CMD, but the new comment in ntf.c says:

	 * revision-dependent (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both
	 * are let through to the reset-pending gate below instead.

The in-tree selftest tools/testing/selftests/nci/nci_dev.c uses 0x02 as
the first payload byte of its CORE_RESET_NTF, which matches
NCI_RESET_TRIGGER_RESET_CMD but not the 0x00 claim.

Also, only NCI_RESET_TRIGGER_POWER_ON is used anywhere;
NCI_RESET_TRIGGER_ERROR and NCI_RESET_TRIGGER_RESET_CMD have no
references under net/nfc or drivers/nfc.  Should the unused ones be
dropped, or should the code actually test for
NCI_RESET_TRIGGER_RESET_CMD?

Following from that, if a notification with reset_trigger == 0x00 arrives
while NCI_RESET_PENDING is set, the handler treats it as a successful
command-triggered reset:

	ndev->nci_ver = ntf->nci_ver;
	...
	nci_req_complete(ndev, NCI_STATUS_OK);

Is reporting NCI_STATUS_OK correct for a trigger the header names ERROR?

[ ... ]

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 5f46c4b5720f6..5a90591cd9af7 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
>  	}
>  
>  	ndev->req_status = ndev->req_result = 0;
> +	clear_bit(NCI_RESET_PENDING, &ndev->flags);
>  
>  	return rc;
>  }
> @@ -163,6 +164,8 @@ static void nci_reset_req(struct nci_dev *ndev, const void *opt)
>  {
>  	struct nci_core_reset_cmd cmd;
>  
> +	set_bit(NCI_RESET_PENDING, &ndev->flags);
> +
>  	cmd.reset_type = NCI_RESET_TYPE_RESET_CONFIG;
>  	nci_send_cmd(ndev, NCI_OP_CORE_RESET_CMD, 1, &cmd);
>  }

[Severity: Medium]
Is the flag enough to keep a late reset packet from completing a
different request?

NCI_RESET_PENDING is set and cleared here in process context under
req_lock, while the gate is evaluated from the rx workqueue
nci_rx_work() -> nci_rsp_packet()/nci_ntf_packet(), which never takes
req_lock.  So the gate test, the flag clear and nci_req_complete() are
three separate steps with respect to the request lifetime:

rx_wq
nci_core_reset_rsp_packet()
	if (!test_bit(NCI_RESET_PENDING, &ndev->flags))
		return;		/* passes, then gets preempted */

process context
__nci_request()
	rc = -ETIMEDOUT;
	ndev->req_status = ndev->req_result = 0;
	clear_bit(NCI_RESET_PENDING, &ndev->flags);

nci_open_device() then fails and drops req_lock.  Its failure path purges
cmd_q/rx_q/tx_q and calls ops->close(), but does not flush ndev->rx_wq,
so the handler above can still be mid-execution while a retry starts a
new request and sets req_status = NCI_REQ_PEND.  When the handler
resumes:

	clear_bit(NCI_RESET_PENDING, &ndev->flags);
	nci_req_complete(ndev, rsp->status);

and nci_req_complete() only checks req_status == NCI_REQ_PEND, with no
opcode or generation matching, so the new request (CORE_INIT, for
instance) is completed with NCI_STATUS_OK without any of its fields
being parsed.

The same window exists in nci_core_reset_ntf_packet() between the
successful test_and_clear_bit() and nci_req_complete(), so switching the
response handler to test_and_clear_bit() would not close it.  Would
evaluating the gate and calling nci_req_complete() under req_lock, or
matching the completion to the pending opcode, be a better fit than the
flag?

> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index f5c9a8ab7ec10..57f99bf46a221 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -36,7 +36,22 @@ static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
>  	if (skb->len < sizeof(struct nci_core_reset_ntf))
>  		return -EINVAL;
>  
> -	ntf = (struct nci_core_reset_ntf *)skb->data;
> +	ntf = (const struct nci_core_reset_ntf *)skb->data;
> +
> +	/*
> +	 * A power-on notification must not update core protocol state nor
> +	 * complete a pending request.  The CORE_RESET_CMD trigger value is
> +	 * revision-dependent (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both
> +	 * are let through to the reset-pending gate below instead.
> +	 * Return 0 so driver-specific notification hooks can still run.
> +	 */
> +	if (ntf->reset_trigger == NCI_RESET_TRIGGER_POWER_ON)
> +		return 0;
> +
> +	if (!test_and_clear_bit(NCI_RESET_PENDING, &ndev->flags)) {
> +		pr_warn_ratelimited("unexpected CORE_RESET_NTF\n");
> +		return 0;
> +	}
>  
>  	ndev->nci_ver = ntf->nci_ver;
>  	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index b0ab4f5acbce8..3a2491497e4b3 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -32,14 +32,26 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
>  
>  	pr_debug("status 0x%x\n", rsp->status);
>  
> +	/*
> +	 * If no reset request is pending, ignore unexpected responses to avoid
> +	 * prematurely completing an unrelated request.
> +	 */
> +	if (!test_bit(NCI_RESET_PENDING, &ndev->flags))
> +		return;
> +
> +	if (rsp->status != NCI_STATUS_OK) {
> +		clear_bit(NCI_RESET_PENDING, &ndev->flags);
> +		nci_req_complete(ndev, rsp->status);
> +		return;
> +	}
> +
>  	/* Handle NCI 1.x ver */
> -	if (skb->len != 1) {
> -		if (rsp->status == NCI_STATUS_OK) {
> -			ndev->nci_ver = rsp->nci_ver;
> -			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> -				 rsp->nci_ver, rsp->config_status);
> -		}
> +	if (skb->len >= sizeof(*rsp)) {
> +		ndev->nci_ver = rsp->nci_ver;
> +		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
> +			 rsp->nci_ver, rsp->config_status);
>  
> +		clear_bit(NCI_RESET_PENDING, &ndev->flags);
>  		nci_req_complete(ndev, rsp->status);
>  	}
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922102144.39689-1-ndaugoing%40gmail.com
