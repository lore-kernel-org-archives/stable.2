Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689908;
	b=rfw1Y844iM2/aZtoA+lmP1Z804yL4n8Jc1YGYS6BnBAp1KegeDILtPbHlM2BX7964e8Z
	 RO9ek8OkxfCyixvCES7yvZpbN8BjvwNnLHWoomaOkRcwONZOhCCF8YYwAj7xON1Kj0c6f
	 1GTioIIjcHYn3rDqaZYnTVwryMSv/H3LPawAiEc2Wdfmaf0ntjOGEmb/vbMQq+qIdxCPn
	 ipBZ91HfCt4A3b9lOPkBpWC7BhI3rO2H/rxE87pxObsBriERjS4M0CCfwNgepbZ8de5SG
	 U+IK9oF6oix47wko3xhPnyKdF0VZH/awzOBTJqg84D4xbw4tRXipUTN0q3c9yrsNXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689908;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=p8sA69clyuMHBtVgMFHobbbcfk1WWAj1HgbHgwO8ICc=;
	b=1CBUZFLCBS4GII3jvX1JGrdS1tyuq+1mKqwKEnxC1M5qOevLIUYubbVJmNEotJCraAT+
	 Rbu/iQkn9om2JItRPqWJKeWsM2akffsBtyo1V08OvgbNs/x5UTiOTyiCcaPZ0RWl+fJvH
	 Y1wQtOGZlhddrLdPUsbhAav7VwhqPX1FDI28/KGEkh41XsWGFW308Xzl/gim57GT4K9EY
	 zGN5m5TQgvupTusWlgTh8yUQwil8ZFo19V0nN1ydm6DP/81Qx6/3Az0LuSN7m5kJboH1o
	 DGFYGN9BIsd9igqqolQsCCY8/6p/0hXjhzXTycv2mZ7NGzczZB80rXck8rnU51+ztAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=WBGE2QbX;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510E606A32D;
	Sat, 14 Nov 2026 20:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4510E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=WBGE2QbX
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0968440E0255;
	Sat, 14 Nov 2026 20:58:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gn7jUe7z44Gq; Sat, 14 Nov 2026 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794689902; bh=p8sA69clyuMHBtVgMFHobbbcfk1WWAj1HgbHgwO8ICc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBGE2QbXYH2H/WaGisAPvaSw1M8JF+a3j6UbFCsulz3fxgrN2KtlEvf3Jn2zSpF6u
	 flc5O3ivtf4aCYTd+/MlbZDu/7xREfugzQ9xEngsFEYaxwkvlWzWOgelklSpxwhmgu
	 NKoMOqoW48VT31nJXUF2SNw0ah03SFA47o0cx3YfuxF25BxH49cnxysHwv/FeS4RCf
	 VZaRv70jrozkd86UWe29KxQYWzlZ49fuHBjVlZSgYtxcnyjerl/lO4cYs4zyHJAkzs
	 lTo26A+m7NjrpTQJdu2pBNAenGRY707E7LMKRKZ/4/QqG5cr6GFGNdETrj3u6xhJ1z
	 WMyYGfH3DL2QNHODOjw54bMUCt5n3uuynN1gJy8MgyJMmfn72XTCZRnR5wSdhCOebm
	 6MebRUxBLnx2D9FeVhCtLVOD+hKEbC2Gkc6upsYURi+i4vNRNu36sYLkE95Fdi63KR
	 zBNevyVPXR2kVS4FMCAfZ/tnwyA6wu+woXlWG3tvoVgkHc9FPOOiHlhgioc5Okna8U
	 lBoI5X0fbDc81IFDHdr5l5w+RI13a/A3T5Gy0tY7muGSERaugUViav/w5vFhhnFh/4
	 Cn9Eqwv+vKmiyndo9pSvswwWuXoZDBnofupYXHk8/iZCxzQLRPHaToq9i0cLCq47pn
	 eC0lpXCDGwSOvaJu3M0N3lNY=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C57F40E021B;
	Sat, 14 Nov 2026 20:58:10 +0000 (UTC)
Date: Sat, 14 Nov 2026 12:58:06 -0800
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
Message-ID: <20261114205806.GCavjLXgsKNNwK0zLz@fat_crate.local>
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
 <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>
 <20261114204605.GA173332@ax162>
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
In-Reply-To: <20261114204605.GA173332@ax162>

On Sat, Nov 14, 2026 at 01:46:05PM -0700, Nathan Chancellor wrote:
> No other architectures provide an option to turn on '-march=native' like
> x86 does. It all lives within arch/x86, so I would just be adding a
> check to arch/x86/Makefile instead of arch/x86/Kconfig.cpu. Making the
> option unselectable seems like a better option. If other architectures
> did want to add this option, I agree generically abstacting this check
> would be reasonable.

Are you going to move it somewhere generic when other arches decide all of
a sudden they love the native thing?

(If it were me, I'd simply whack that native thing. It is such a waste of
energy).

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
