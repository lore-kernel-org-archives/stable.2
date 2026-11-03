Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702465;
	b=38vkBaJ0tHQhOKCXjY5P3iEeyQwr2fnj85xmQ5iLpsdDCPa5w8WGnk0YkPZq1+QYZ3QN
	 /GtF0RcSbn4MbIbsLdjKjuWdk+6tnz+cErT5XQc1T/ITBkhW6HK65DhDEFki6Bfxp3Tyw
	 0LDINObm7GQ0OZV/UHN2RH624wzjfasKUfMSGwlfF9nEZ3vLOIHtKSSkDoSgkkL9nuKdO
	 Uz+osxEsWcV+9ChJtnYWrtJxx+fAzTFHdy1zBl7qav8zfz240CPN/XNu8WnuuOHdpYciF
	 2PgYnF9qr/wj+dAeR0wL2gGnxIz0kRVitTp5aPvgMk7u0ihsBuuzVF/W8cLOvl+n5+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702465;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jL9WHcxy2VQxd8cS6X0s7ZZ7+2kPJVDRsNqBp9O7BIs=;
	b=e16itorG1QMO/jdZX0Aw017LetwYn71ZK7HpqMEMO2Q8oZAY25jggAcVLP3SKxjma46E
	 JefcunRBm/QwdNdrdGC6L9XBXtcE463GD8Jk+rv3vL1dzB0ybcQJuPog5ewZz7UJrb4q2
	 ZIp1d5zDSYxhsRE4+ezTgNtdrs66oXJl+WAm7mDnMcAZRAFmGtBtPV4krHfc8lM6LO8sp
	 8TiGOpvT4QDxjJ3iafkYTb5pFwYZc5XWA1fnA1qcZNH90u2MR8YvrNr5s9bw2HSnCT6H2
	 7ZMR3q4K4zQfrIk7QdRXE2aPfBVGWF+kO2eqPmR513Je/GqxWLWTWusm7dbRObT+mBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zux8ku5h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71C6078F29;
	Tue,  3 Nov 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zux8ku5h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371451F000C1;
	Tue,  3 Nov 2026 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702464;
	bh=jL9WHcxy2VQxd8cS6X0s7ZZ7+2kPJVDRsNqBp9O7BIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zux8ku5hBjQhAiFVn+cFYWM7FazkEFoNqwKZOiwSznmCLp5A/5Wa3up985tco3mii
	 ZeIADUsSAfe9Q7p5Zu+820EcpS+sxJdtMKt6K+qvsCWM66Ll6MHpvQSfxifUIctfRx
	 /1t+hSqXdkBeLzmq40BAYgPEIF9X3iqoz+SfZbBACI8tJxiK/WSBUKfPdKr+DBBiRO
	 vklNuNF2El6HXSZZ7lbhZKbIsf840bAhDcSUz1z34O8+PJgj46TO710GBfTZ7BapDH
	 PFBBKRKWNZzFsKkVzh+awXCmtFpxBMUi9QKCQOLFHjJi7aZVk36ALUlqk2E8bmBAeu
	 ZlQXNkxWnejJg==
Date: Tue, 3 Nov 2026 11:41:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath6kl: free the ath6kl core on USB disconnect
Message-ID: <20261103-cunning-walrus-of-chaos-dbd611@quoll>
References: <20261103102901.1340914-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103102901.1340914-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:29:01 +0000, Wentao Liang wrote:
> ath6kl_usb_probe() creates the core with ath6kl_core_create(), which
> allocates the wiphy and the per-station aggregation state in
> ath6kl_cfg80211_create(). These are released by ath6kl_core_destroy()
> only. ath6kl_usb_device_detached() calls ath6kl_core_cleanup() and then
> frees the HIF private data with ath6kl_usb_destroy(), so the allocation
> made at probe time is never released when the USB device is detached.
> 
> The SDIO counterpart, ath6kl_sdio_remove(), already calls
> ath6kl_core_destroy() right after ath6kl_core_cleanup(). Do the same in
> the USB detach path.
> 
> Fixes: 241b128b6b69 ("ath6kl: add back beginnings of USB support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




