Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213469;
	b=JQjky22ZdAdF/rC7r1JJB3nFkq2gzx/F8ZNMIzXWXVTfgjAxlmpGUurkIUidaTnox3yA
	 LudwXe1KgbO/S9LjbFnsMNNSRxfvXZAlI9gu1aWr7RZs9Wskk2Lb6XySn9KUXr2K8Phq+
	 7kPMZA5A2umBGGigQWpLuoDbWaekPBM5w9nE8JXSvbfJqvVtBRYFT7SZPxefztT4c66Nt
	 hjEOTYZNx3usjBVSRU4fCRUbh62W3kbvB1hjFx9Q3PpIkXDypfd01bOskGxBsDuAEGKWJ
	 Zjr1u7WdAoL9Ww9i+weDLJn7Vgm1O62Ft36G/+wCPyFyk04M3jc91hiXaIOnsHDLMLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213469;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=dRuXH3K4raORCYDOps4g90T3CU/4U56U23hpPhW6zb0=;
	b=2dQ4E67QBV6k3owVfxptIKQdYaKQYfhtqPMqWAx17swsCCsOu43JPjJaXTVFuoCcar+Q
	 2f0AcfXncWMDj8Bkr5J18Ha+Tkgudms/sTxig3AS9xB/DCdujXQI9+CqeaemEcKCtuuh0
	 MoSf3Gv1a07aI3UVlSeUK/Ucm8JTH9liplePZFRfopyCmTp7DtxZVdpjsI4QR05SGoTye
	 ZIsqdfPUWdcfZyM0YtrIXotNrzug4jOyFmiMTol4iShQ803KMdM60685h5bpPL/bXE9T7
	 O8Lm4ovbW0zFdakwXSziPnMMbbgkqojQ8RbEl0FRwPxT3WlU1jM2QXIjW+BE7Q/uXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=P7XIz1xN;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A7606A69F;
	Fri, 20 Nov 2026 22:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC6A7606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=P7XIz1xN
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jWVHl6JqjzMlv2;
	Fri, 20 Nov 2026 23:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795213459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRuXH3K4raORCYDOps4g90T3CU/4U56U23hpPhW6zb0=;
	b=P7XIz1xNFfya/FfHwaYBCynvnKYz10jJgYtD7a82heM+AA1ldYeTr4SZtUSIRKgaQDMZ8T
	CpJYddAA56HsFWQ3iWfYj7MLLOHmprX221P2FA+dXteHubsKNKyGSuNRPgRFsXfbEgcrQR
	4t/Ssk3rre1JtNPhDn2KnILCmtvKk8XTsjfVEVCvaJAHSjyOSIIRomNmj+ERqEJIz3fzpx
	bNnFkm/Zstd0wRThI5Q5edDzqvM6Wk0Y1Uq9tmdj0IZJcFZ7VF0WIjHWGd4kykyFQR5sRT
	fY3yXSu24JogXt/4uNiGMAkfAnmyOamG7oL2s2MDY+eo18LfUPa9RhZo9ahpzw==
Date: Fri, 20 Nov 2026 23:24:12 +0100
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] cpupower: fix use-after-free and stale limits in
 frequency-set
Message-ID: <awDIjMRecHWBrNpj@lukas-arch>
References: <20261118-cpupower-freq-set-use-after-free-v3-1-3e021315b579@mailbox.org>
 <69cde473-bd68-4bf5-be03-c68f411ec116@linuxfoundation.org>
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
In-Reply-To: <69cde473-bd68-4bf5-be03-c68f411ec116@linuxfoundation.org>
X-MBO-RS-ID: 98b4f4b7f6d48da217b
X-MBO-RS-META: 1ndghwwepg6y9fhuheif5izz7ayn4xyh

On Fri, Nov 20, 2026 at 01:41:52PM -0700, Shuah Khan wrote:
> > -static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> > +static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
> 
> Why do you need the above change?
>

It is only a cleanup as the function no longer modifies new_pol.
Removed in V4.

Thanks
Lukas
