Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614011;
	b=IVMtYNrGBWjAcd17Xb7//PQsqqH8gXKS/suLcZibLZftQ7c9lNhTy9zHLudpg6/Ho/1T
	 ZqJpd7topnvWFgmepAsPALXBMLUCPjkzc+vDSc2NLHH74c9/I6Uw4OOXapbQGsw/IG06q
	 gJkH5uS+JPRS0/PqcShaO3SgyUDuvJP1KQfr5JMt+xSd/ekF94u1gPtJeod3cdsf7IpkK
	 ZNpJNkns3bMSKtWxmi2DQB00uq+L+wicgX+tz2PhBNHnZeBZCCXET+tJqrG5zE4PKRSWP
	 VQ0AuLkhbMjd1mTwq5oA/CdGH9o0XQRVdVOrAVtdHZZyanZOvRkbTCNI3mKF6OlK09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614011;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ofzMkWeqC39zfEblKpdCI+AgTlcnHO+vyCGyUjjgVpI=;
	b=37LxqthBdnu0mOPa48YXwfPz/X1fHbuFMI1HOzs3guopTL/VMyLo6CdjP7Ba8WlX1NcP
	 ZFzKITZvy+Rnjks1LwIFaFds43l8f4DQ8vqkbxyV9a2bTT6kzvA7H/O85PNVEioSIynQb
	 K6q9dmHK1BI8/is9N0cw3voiIF6jKTEeLuPCYfqgTB0/QWikjlHXOlP65/9eiA7valMJJ
	 /1wERPS8nOfQvPDtW61JxweLqmZtM0FDU05o4TOYtcTmixBrHiMwPZwRnp4Djob+n16u8
	 6niCusIB0WhtyF4S8m5DISIrA/H0T1FJSes6S4s0FJ1OTf7lhZxULWLo7h3qYvcYrdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=DYi87pQB;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC92606A336;
	Fri, 13 Nov 2026 23:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC92606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=DYi87pQB
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 066C740E0184;
	Fri, 13 Nov 2026 23:53:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YzEvr1eMUUKw; Fri, 13 Nov 2026 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794614005; bh=ofzMkWeqC39zfEblKpdCI+AgTlcnHO+vyCGyUjjgVpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYi87pQBTBLGdOlVAxfY/jDFJ8i7MBr9lRudWLSi85+miQTxO8Z9pHPst+PrRivQQ
	 audgX3QkI32n6LviWC2oD0zutowQJzrCdhG32/9Urn7OF4E0nEFYEelx9mfL93ndkc
	 9mQAisxyOCW8ymx+jnPZzdzC9Uf/whF9D5fYyBB/UQCK0nMzCfgWcQQY9KST5xqAbW
	 YnJYC3zFSdVf1Wdzm9BZlicmQDhixd2nK8bwpAPsRWoNAbfzyrZ00KvmMrJLY8lbWc
	 ZsKCiyuDy60ZH8iTp0z+rZgvJLTQ8+ppYHyGBcu30qMILI/m+5x6+Dni4h/pjVDe7N
	 bX3vbZn4WJRo5uDltmL23UTs6cfhc19WeqdEbo7SdddfGuUD3Z8MCMgWMzd1aCQ3eb
	 eI3oqN7tTT41Y5nSt27h/OIi9YHc+QAzZZL7BmOTMmsSa6uPK/AxZLHIGYxKn5wYhF
	 +zZvP4yeijzn4iRuMB/NRv94RJ6QBK0J+h6zQc90wtscqpxxF1iPSXqjlagn7o6ATf
	 FShyPyHYdL6Vr8igt0WT9KjwLmMgbb7sdi6e89bsBBFkgwdiAXmX/GgytGrB9GSQgq
	 ssBPhFPK0yHGebomUrWDoBk4DRo9kTJ6N4y+CrxTYN1TgbTXHarPXhD5yLuU8pL/jI
	 khArxatRbstVezAbLcrmFfsk=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20CF940E019C;
	Fri, 13 Nov 2026 23:53:11 +0000 (UTC)
Date: Fri, 13 Nov 2026 15:53:05 -0800
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Qiuxu Zhuo <qzhuo@nvidia.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] x86/mce: Rate-limit messages from corrected error
 floods
Message-ID: <20261113235305.GEavei4ZaT6cVVy_mm@fat_crate.local>
References: <20261113-mci_ratelimit-v3-0-ada38c5a6c88@debian.org>
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
In-Reply-To: <20261113-mci_ratelimit-v3-0-ada38c5a6c88@debian.org>

On Fri, Nov 13, 2026 at 04:49:13AM -0800, Breno Leitao wrote:
> A machine check bank that reports corrected errors at a high rate
> makes the MCE code print two messages without any bound: "Machine
> check events logged" for every error mce_log() queues, and "CMCI storm
> detected" / "CMCI storm subsided" every time the bank enters or leaves
> storm mode.
> 
> One host printed about 100 million "Machine check events logged" lines
> an hour. On another, the storm notices were 82% of everything it wrote
> to the kernel log.
> 
> Patch 1, from Rik, restores the two-per-minute limit that "Machine
> check events logged" had before it moved into mce_log(). It is a fix
> and is tagged for stable.
> 
> Patch 2 puts both storm notices behind one ratelimit, with the default
> interval and burst.

Yeah, maybe I wasn't too explicit in my question, sorry. I was asking more about
whether it would make sense to have a single:

static DEFINE_RATELIMIT_STATE(shut_up_too_load_mce_prints, DEFAULT_RATELIMIT_INTERVAL,
                             DEFAULT_RATELIMIT_BURST);

which all the mce printks can use?

I.e., a single ratelimit for all. Or even:

	mce_print_ratelimit(...)

which does that.

The mce code is full of homegrown shit like per-CPU vars left and right and
other hackery which got grown for some reason back then and I don't want to
add more if not absolutely necessary.

I hope that makes more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
