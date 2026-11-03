Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740212;
	b=ujSecf+7lRZlRnVMtZnPdtLhuG8qKRHbl7sQ/tbNdWGBDX4ne1NrF9qPQyrXjGbdFbgU
	 bq2F1dvigVE9fZ30lOQLz6LenKngzNSw2iWKvGDLmvBl3tMBCn6dj1XC1O1rPrINfkBq3
	 pyXjp4VPJnCGpk7DFFaaxdJ5Vckw+r3CQJLSuze4ioD2qYY7MA5vG8Lt+CzePAJk9Ld6I
	 71T13Gvc11/qHaGDAb0NbKSrSAzPPe+pJNgCb4+87Fux8Zmq2R6QtIscjq5PBAOH0QE2f
	 sLGc5mkX6N3Nr7YyUXAYdP4+6raSpwa7t3mgo5zhcs9Kvk2sy/n3BNNX3yRc0iII5nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740212;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lKbV+nr+kH/23yvxz16KNF4gOHYeLb3Gwlupd9/GXTI=;
	b=3jeSlsFfzPFHA5Mr0H/XIJeXijNCRQz5n4FfvgNfXQWvg0l3nNfX4QZSB9wvDCjQf2fa
	 4oX9w36PnF0k/0qhH3guq3tc+M/naWnJVnfi5mDWnpr6jP02i+PwOMOxoCq0AxyhXr6xa
	 Ql6neYsQfV94n1H/pRR+Qe2HNoJars55PJ13aRUprqn3pCQCdJwdQpWdf8WrWR8pPWz2I
	 l4r+pVrbU+n2IcUcgK02BT+EBauFypYSsE2dLlQn6ytvVAZpDIn65zmzRXAICYDX8ilxx
	 cG6cqdLdF7d6U8pE/ueMmd3TrTjXgNl6v6jAcW7uf1Qjc7gU9jDiIEMQZd6DxB/qVZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=he9AcpP2;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894E606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9894E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=he9AcpP2
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71B7340E029C;
	Tue,  3 Nov 2026 21:10:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pWRFgxtiEEBD; Tue,  3 Nov 2026 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793740198; bh=lKbV+nr+kH/23yvxz16KNF4gOHYeLb3Gwlupd9/GXTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=he9AcpP2zdopI0HDH9oY4BtaKDlXBKxj92sZEe6qWMNxgClMMqczbG/aH/eHtdFnC
	 NanecpHjzMp8bfpX22yTuOChhxY21p6179w0vYsbedt61Gcg/j0plB0sTC/X+C7AVq
	 WC8EXgglwKLkZoiiJwHjRxgw4G8hmgGDXcx3TRmNk2iKEQadnBQU+XuiLSVI1CBsYT
	 k0CwdQK9IePmUflqZgSXg4cy/xv2gLQznyYK7E9m7VwHyh5XTFVNBwuTzi0iMTX2H/
	 5isa6XmZU04GneYS7lyrlCUs81u9HtHRVZI8fVyuBJUtECHsoeKyhHJ4PfS6k1QEk4
	 6R91qPeyCQpt6e0avEL++dKamTNDSww38eHw7qPlbHQU4PosBVaCxSAnIuHMB6gxxf
	 UjuWQqPAbBUYM12I+I/Qc1N28OhxEwVGIWs1iejKL59lKtFumx1sH7U3zTnX5NeZI/
	 r/OiYjVtGDZDO9Ia95Xu3lgKkbf/3BoJn4ZLI0x6PooyRW+Eq/T2yEaLASF7DQmTJu
	 qWfzzri3BnvOKFQ19G+K0RuFi/CaKhb2uOSNl3tJjRj2C2jCj7Dm1AZY8l2edr6eva
	 qxcTH9YVFutJp9eLy/e2zEALGjYnbykFK+GjDs7nSNj3dnrOVkrobr+t9WQa+OaVXg
	 FUsbNGR8H4wcIb/52Xccfd7c=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFE2040E021A;
	Tue,  3 Nov 2026 21:09:54 +0000 (UTC)
Date: Tue, 3 Nov 2026 13:09:51 -0800
From: Borislav Petkov <bp@alien8.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: stable@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH stable] EDAC/mc: Really fix error path ordering in
 edac_mc_alloc()
Message-ID: <20261103210951.GAaupNn1kEIZMr4GVt@fat_crate.local>
References: <20261103170439.2f918d14@endymion>
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
In-Reply-To: <20261103170439.2f918d14@endymion>

On Tue, Nov 03, 2026 at 05:04:39PM +0100, Jean Delvare wrote:
> The backport of 51520e03e70d ("EDAC/mc: Fix error path ordering in
> edac_mc_alloc()") to stable kernel branches is incomplete due to a
> different memory allocation scheme. In v6.19 and earlier, the device
> initialization must be moved further up so that all jumps to the
> error label are covered.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: stable@kernel.org # v6.19-

looks about right:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

> I believe that CVE-2026-31689 is not properly fixed in kernels v6.19 and
> older as of today, and the patch below shall address that. Affected
> branches still under maintenance would be v6.18, v6.12, v6.6 and v6.1.
> v6.19 is equally affected but no longer maintained.

Have you audited all those other trees, whether backporting it there is
correct?

> I wrote to Borislav earlier about this but I'm unsure if my message
> reached him as I did not hear back.

Borislav is regularly overloaded with shit. :-\

Sorry that I couldn't get back to you.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
