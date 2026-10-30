Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357569;
	b=14EGUlwBX6zeeMz0M6YcJoQltn06VykjelMM5KMQ7cZUHIfPAp4lByT5ImNXG+HWpP+c
	 w89uMCsCINq7aZ0JOcgYDl5g5YwUMgiu3JFIrJ6XsTZNrUCpm77cdThsilKVPtWlYW8ca
	 gDG7ng6sTAxeynHt/h3i5g1Ms4ZIMOG7FOXXeD4E4X/NqzqEy4Tzs13/lQ55i8losWkF7
	 EbFtPdJm8400yOqY0m/oXczUDx0Gu5ocQ+h+csauE5mXRV6BKk14uuaBf0k7zrG0fC5vV
	 2dIVFNbLaJaNsVEseBqdyJW6+2vRvzNNg92FaHw+apz62+nP38TC7BOz5GXp761hVyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357569;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=19UWKhVy2zuhB24lqtjvX1ge71thkeEw7AhozvsBUs8=;
	b=nF8Mh65oBKWwBn3I0D6eHaBZL9b04hmMIp9aNUJifg64KbiUlG/GOZDsd7ZoHRLSin9r
	 VDdh4AnoAiljVOPTx7chppAvJsAyHbU0nmpcxEA/Ci865mGLM+kqKTa6Z6oCU1GWjNHHG
	 1/Bo71bgiSGyf6Qm31k98734yobxqfmyQvforVomtrNQtdecF/+6VpivIRRiPDskxHmBw
	 vHGyTOIfAOxFmfFfIxlOsXczxt+tpBOgtD+x79l4wPFVrDgiRRaNXqPUXd4+WPGV0ExjY
	 WQjWuTv+G0Bjh+iKIH3AkjFco6D5OZuMn7sSx82gxCe3sdiGZuFqnuwt8uQKSI54O0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=IePDJiDI;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CA606EDAA;
	Fri, 30 Oct 2026 10:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4CA606EDAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=IePDJiDI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=19UWKhVy2zuhB24lqtjvX1ge71thkeEw7AhozvsBUs8=; t=1793357568; x=1794567168; 
	b=IePDJiDIcCyLaRjFdCY0PhjQH7Uydk4e2pKPvH78Jxb89zrO/AefFe+fvC1CyrCKBVIxIfGtsF0
	Ygv+5iuNWmbyAixgYEfbC34c8PXPpSpSiMCfdRAvetj6nvU2JS8M5pFUEeybMi1A2MZoa6V/kpQnW
	mqxzECt2oMmLiFaVzK1sYtAryGU6Rr2qmRTpXaBQF1Bi0SllhrLKgayAHAKFJeCy5OBY3O0CBnL4d
	P+W67LK+V2Bz9Jpfead63ILnl6apInBcTeF8qGahxj27PE5NVK8Kp81vonE4yX+LUR3p2lNbSy8ub
	yRmpxkt397+ZL+LSiG4e2216xQmEhDA2dfzA==;
Date: Fri, 30 Oct 2026 11:52:41 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Kai Svahn <kai.svahn@nokia.com>, syed khasim
 <x0khasim@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz
 <sameo@linux.intel.com>, linux-omap@vger.kernel.org, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 13/27] mfd: twl-core: Clear twl_priv pointer on
 teardown and probe failure
Message-ID: <20261030115241.642c5971@kemnade.info>
In-Reply-To: <20261030104806.GC3774906@google.com>
References: <20261027093306.2812695-1-lee@kernel.org>
	<20261027093306.2812695-14-lee@kernel.org>
	<20261028165003.60d0c033@kemnade.info>
	<20261030104806.GC3774906@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 10:48:06 +0000
Lee Jones <lee@kernel.org> wrote:

> On Wed, 28 Oct 2026, Andreas Kemnade wrote:
> 
> > On Tue, 27 Oct 2026 09:30:42 +0000
> > Lee Jones <lee@kernel.org> wrote:
> >   
> > > twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
> > > and checks for a non-NULL twl_priv at entry to reject multiple device
> > > instances.  However, twl_remove() and the early error paths in
> > > twl_probe() never reset twl_priv to NULL, a failure when adding MFD
> > > child devices bypasses twl_remove() by jumping to free instead of fail,
> > > and twl_remove() tears down the IRQ domain and dummy I2C clients before
> > > child devices are unregistered.  After devres frees the underlying
> > > memory on probe failure or unbind, twl_priv remains a dangling pointer,
> > > causing subsequent exported API calls to dereference freed memory and
> > > blocking future probe attempts with -EBUSY.
> > > 
> > > Unregister DT-populated and MFD child devices at the start of
> > > twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
> > > reset twl_priv to NULL in twl_remove() and on probe error exit.
> > > 
> > > Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
> > > Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee@kernel.org>  
> > 
> > Hmm, couldn't we use devm_add_action_or_reset() for resetting the
> > twl_priv pointer? Feels more clean for me.  
> 
> Nice!  Thanks for the suggestion.
> 
> To keep this fix minimal for Stable backporting (and avoid resending a
> 27-patch series), I'll take this one as-is and send a follow-up patch
> converting twl_priv to use devm_add_action_or_reset().
> 

I think the whole patch can be simplified a lot then, 

devm_mfd_add_devices can stay.

Regards,
Andreas
