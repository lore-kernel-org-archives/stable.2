Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501649;
	b=WWx+w9iTUGTzIvP1TtDI0o7Ezh6NYADv+/TkFCUUg5Zrvk0pgz1dDLsL6OZRcaSR6lF4
	 QHrXkNc/K3HX9vEBgA/S21d6j8RrEaOVKfEw4BOavr6GqN5X/KXxWxUSu+NYi8k7rIpAS
	 8Ir/ttDA3ioYKYa2m0NlrpG3ZeJQ8Y4FAGzbRZp7lKUMhPYXpOy1cPlQPqzPNwx4f0TyP
	 wlkksMeMP6a45B/vY26CBMcwfBmDpBNVE5ZhA2bBQW29P7GCo854DKOkG2Qh3uwi/IS8V
	 CAp4NhqMz3rmYxSVjP+mtsU6c5+r7cPKV+QRjlrxrvywDnm2PBoWfkfl/fkpIycRCRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501649;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yczeao/IfIHXdQRDuzsDbtiZys1GnnvPZGbVKXnNSdw=;
	b=RF4ePqPdrYFi0zOpKMRZ1n3EkLiq3blHWrVSDNpV6njDC3qyyEXLvLPpDOsNQ3BI34Xj
	 8cYtlR1MfSvfgCf3N6scFMoGQ8U/BDRkEdgFPoNr+RiB/htUXKUIJGDhm1RU8rLxF//Y9
	 wLi29FpIMrqmiHnf3Qi8PD2xiHRcE67EKT/83WLXze5fR08xS25Yd4piHUa0370Ekpkkx
	 wwZuASc2wusomXE0hu04bVKJnsRzETM9cnAq8xdegR+KNwHUKpCeY9IqMWJvNF1M7EuPF
	 Pv18ER9me93/q8FPw1xLl8caRK0QS8+YlhtJxuW6tL891Z4FraqHLBSfs+4lDrYnuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lzCe/9+8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CA606A331;
	Tue, 20 Oct 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzCe/9+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A281F000CE;
	Tue, 20 Oct 2026 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501648;
	bh=yczeao/IfIHXdQRDuzsDbtiZys1GnnvPZGbVKXnNSdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lzCe/9+84DSLwPFWQmsvRNJqOqlvoSsVjLE6nSv4WCcw8Je9ijpBv61c3HpjHVdF8
	 FxqdVSsvl9BAcyZAca2J7ZfAGwaIRySoPcQAP1zP7iFyKTYwx/xi3TIjsILD51SeeU
	 v1eZQY48A12bekOcIvzDehRohwtV3xaNJmJNCKmhPDDgS7ZX17lyOYjpHyJfeWIAMl
	 Wyn3E/ugXIq0LEkX0Zd+6RhWFodEEGcHpISCTgsov93fxA+x8fgT1GaHhY//CDN3Ir
	 5qmqCS7iDGSrNhohuS8UpHKgl7+X5aZAsrgQs5fCbIjy20V+Xcszi7dkhDecesBUbi
	 HSvBQ/MlefZkA==
Date: Tue, 20 Oct 2026 13:07:25 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/6] watchdog: w83627hf_wdt: Fix watchdog identity
 truncation
Message-ID: <atdnjaujw_BUiVUR@google.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-1-b6f6b60a9566@bootlin.com>
 <atY1mMlBN1L93rbi@google.com>
 <DM9I42KN8Y2M.1076TL8NU62GR@bootlin.com>
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
In-Reply-To: <DM9I42KN8Y2M.1076TL8NU62GR@bootlin.com>

On Tue, Oct 20, 2026 at 09:52:54AM +0200, Paul Louvel wrote:
> On Mon Oct 19, 2026 at 5:22 PM CEST, Tzung-Bi Shih wrote:
> > On Tue, Oct 13, 2026 at 03:58:45PM +0200, Paul Louvel wrote:
> >> The identity field in struct watchdog_info is only 32 bytes in size, but
> >> the identity could be at most 33 bytes in this driver, resulting in
> >> truncation.
> >> Remove the "Watchdog" suffix, as this is implied that the device is a
> >> watchdog if a user request his identity.
> >> 
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: 3d6757a640f8 ("watchdog: w83627hf_wdt: Report the probed chip name via WDIOC_GETSUPPORT")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202610080027.3OsJDwfo-lkp@intel.com/
> >
> > The patch doesn't really fix anything.  The longest string in `chip_name`
> > with the " Watchdog" suffix is still under 32 bytes.
> 
> Indeed, max is 21.
> No idea why it got reported in the first place also.

It should be from 21 + sizeof(id->name) = 21 + PLATFORM_NAME_SIZE > 32.

   482		snprintf(data->info.identity, sizeof(data->info.identity),
 > 483			 "%s Watchdog", id->name);
