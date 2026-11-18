Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022420;
	b=S3+kZxU9CD56jCUlEwjuVv9W8Wbs7c+tDKZYQNcfZp4AmF/lrrfC9PXEddKulL/7uBC0
	 sj9g1LalTufxCIA2JDokiSoFuhHC2dlDGp1tEtky6r30lz+o10ijCQPSYsgZft63cU9TM
	 ME95gpib+4gsar9URrrT0sUXXf+LkAfrcJUBOIlCYTIIQyW04QBSVgFQzAyQSCJTCgvKV
	 auGimu+7bQL14OoBxg7hIECNNGda6N3aLtBUP3HgQFrQqIinDWHkCPMsObhpbwGhHAYSw
	 yRUWO8YsxJaSACdv2oW5QCoUS9wVotE45sjcDLOxBv9VCdSVZIRWSj/jp2ijylRwikQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022420;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GNSgVc/BtfH4kx3pq6fmT3aOO7rA3luHHP210jnBneY=;
	b=ZmxXcZRsQ4uWZKWoZdVC2IrYeQrbpCScXne3OnAVsokEEQsqliSt84r3kvAzlXXwep8O
	 +oWDfABec0GxPEzrGlV+dRiYxa0rWSntpkdqvC8orjUgpYxKlJEHbB9LfV+wUSRXrOm1h
	 kflrg8fyw9vchI9GUqouP+hxWpostvigKbHGq1DrZdcPacCmKjVNQIrAtJc0CX6ht6jQ+
	 rokvNvxkc45cDj4qkN3044LHnhZtj12rUQACptMZw4D+5rV6u3QTKaaFCOpyIcVVAL7V5
	 O4qCDOK8/yu7cngG/hHM6Cg2YHEQGJSJRUH2o29d9siiBc41LdyLhDWh50Nq5kd10Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9SLqBRA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B3606A320;
	Wed, 18 Nov 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9SLqBRA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDA21F000C6;
	Wed, 18 Nov 2026 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022420;
	bh=GNSgVc/BtfH4kx3pq6fmT3aOO7rA3luHHP210jnBneY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A9SLqBRAcu+7ALHB9PkuS+vgG0JPFf/+lfVDdaL2rR+DW/XvEbpKH9dPaJ6day5iB
	 p/ggtp9MF36xjWUS+7vbt9eKGOenioorvyf62TcNxysVplfACSmyLI+lVC3OXLGUGC
	 yfcop1htUS+eIlodqqXjis9xgQNlaleumDUn0wKqvI5VNrcsl0EkL045+uHQ7tQh2C
	 Y7WY2I8LzSWXmwQ/qlgcq2gwwZJhxmkYf73pVtEbx1vgTuLxZF7npIVIDGvqsaVfNN
	 6qg+k2jTh5FHNJHvmMpZX9xrRBk3OX9f5MyT12x0/ArDCHSOcICT+QnzhpAUbh9H3a
	 IDIoqyeq383Mg==
Date: Wed, 18 Nov 2026 17:20:16 +0000
From: Lee Jones <lee@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linusw@kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, pavel@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: netxbig: Fix platform device reference leak on
 successful probe
Message-ID: <20261118172016.GE98456@joneslee-macbookpro.roam.internal>
References: <20260922160323.GB3438784@google.com>
 <20261107042737.708109-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107042737.708109-1-vulab@iscas.ac.cn>

On Sat, 07 Nov 2026, Wentao Liang wrote:

> of_find_device_by_node() returns the GPIO extension device with an
> elevated reference count.  The error paths release it through the
> put_device label, but the success path returns directly, so the
> reference is leaked whenever the LED driver probes successfully.
> 
> Release the reference right after its last use and remove the put_device
> label and the gotos leading to it.
> 
> Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
> Suggested-by: Lee Jones <lee@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
>  - Release the reference right after its last use and remove the put_device
>    label and the gotos, as suggested.
>  - Apologies for the very late reply. 
>  drivers/leds/leds-netxbig.c | 74 ++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 47 deletions(-)

Much nicer, thanks.

In future, please submit versions on their own.

Attaching them to previous submissions gets real confusing, real quick.

-- 
Lee Jones
