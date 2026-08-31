Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584838DC6A;
	Mon, 31 Aug 2026 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143472; cv=none; b=HFQiSOLSSdeIZeRKNdG2nVaBeufmJCazSw1R9fC5G8eJlusq4mFl5lsOQI72pw3/S/CvBAnIl6tJ1XNlVxvnf80zr+zi4UwscdUPdP+pfmcg9h23DkT5w1WK3ti7MI46k5rzTdorsRijrrG4CMfH+Im4KTkRGx6bPLYMxUtie1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143472; c=relaxed/simple;
	bh=w9HtCmiY6VEjqhvnXK6eBD05O2YjfAyOYrOPzuqcOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeFQGHFL3hpuLtkHdSAQEuRVGtu4fRNyHsKxuJMLG3dWJ6XJPV+KvV2gmYUB3Uw8DhhLa++WP4tjtKiN33dJ2TGkHB5veiJk3O0v07mJsZAhv6iNcSn2ULbLkzs16LDYXas7VTpUAJZ8DcsIr/VvF1jzzH9Z+aVWMu/UMe+aQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gclhgpfa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gclhgpfa"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADFA840E01E1;
	Mon, 31 Aug 2026 02:30:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g1YAMQaTwk60; Mon, 31 Aug 2026 02:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788143432; bh=sGvDGEXU4iWL0YQGVszjqNOIK9nuaBETAl8XhCG12to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gclhgpfa/d9kHJ94FA8T1196P852K5gwW2xZ8ln8VRT49JdPkZy/ToD19tbdhggig
	 DbAOdOtdRo1SrW6ctj4s2hS631fevjD/tdGaBBQ741XLFD0dA2kQp6AZoL8bjbXV7l
	 DQ+KLnolBHcXqd6IbfNUf+/JPeCvdCEMvpxhIhXbPg5NSji0luYtRyOFf30d9ghjT9
	 lBKabSyg4ismRljQi8LkeeA9M1Hdx5DsgIhtTc/d2tJ+O0Qk2ZZ68dqVIC6YTLbj3l
	 pWrk/lFc9ZxCzkLiZ+6IOwBzMSVV+LEQveFVCsXspbouVzAPgQAfSaUA0ledgG2EAm
	 dEYcEVU9+OUIxZnNjEAE32IYo89P04vmvTirpuYQC1iI96zlkc2v3MJWeNFOCinHJn
	 KFvSaxcc1kZ/RUWMjevYBNx2IPEjkzlf1KzSFxIjnwaQ0ysjju7gV+6yFAdAyfoz24
	 aGXQLDivR3lBUUR093k18IGpOXbqvGsqV/GTgLUH9e4XBR2IR8Rs0aAX1BjutFQ9fO
	 +u2cnID1eTROF3q73UJF1htGYLMX/58zRNGQkGIjN9ovvwzW0zi2fKW4obY4DRztUq
	 m66n/aWfmwRLgF9FZ1gOXRFU04uOqSJ+gwb1jF1RjovCuF2Kuk2EKODTKeuYs1PfKj
	 4fOafyxRVnK2RKAe94Q/6tsM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F77B40E01B5;
	Mon, 31 Aug 2026 02:30:20 +0000 (UTC)
Date: Sun, 30 Aug 2026 19:30:16 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org,
	Penny Zheng <penny.zheng@amd.com>, stable@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/amd_node: Remove smn_exclusive
Message-ID: <20260831023016.GEapTnOHTbN8XZGe2j@fat_crate.local>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-3-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825214805.39148-3-jason.andryuk@amd.com>

On Tue, Aug 25, 2026 at 05:48:03PM -0400, Jason Andryuk wrote:
> -	root = amd_roots[node];
> -	if (!root)
> +	/*
> +	 * non-NULL amd_roots indicates pci_request_config_region_exclusive()
> +	 * succeeded and userspace cannot access the registers.
> +	 */
> +	if (!amd_roots)

So then this should be

	if (amd_roots)
		return err;

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
