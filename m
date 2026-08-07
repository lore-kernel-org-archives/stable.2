Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097F282F3A;
	Fri,  7 Aug 2026 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143203; cv=none; b=OYMUPBZ54xqkRLP6zli7i5WZFHUBIKaC2MzTLWo8Em0ZOfutHEiDFIXXhu50gCUcEsG9Azj+julMigJfarcCFMVNdtRO45HiNO5HPCY+bbhq2s8X8mFbXvQbV/MMNJmqzwz/q+CJr0ROBtVdugNbn0nnhHw0aneAbkYRRBxqc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143203; c=relaxed/simple;
	bh=TgnFiOgYHcZHOf9TdbtGtK+PYfcwH7tmRAPJA9Tw/6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRrQ22jifLBOzjOfQEMoUfiqskk5AxhtFZe/GKVMikCWHZ4SxuzwfDntq4LjbNQxxc0B8DolMqSEr9wzH6QlNn9p1x+wr3KS4LQ4XBZTGCvWxKKs1i9VxFSmnsCitwSS7SfJjQlq0QMpCAJT7iLrYAS49C4olPY8/ZDBmE0mTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hIsY8nF9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hIsY8nF9"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B8AAB40E019E;
	Fri,  7 Aug 2026 22:53:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v-aCRvLEUesg; Fri,  7 Aug 2026 22:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786143180; bh=Qr8nSDsQdPdjpZCT7E2xBH6BYx3h24usuz6hApN8yD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIsY8nF9CcS2DHulD9hh2AxxxscOe/ItW9tZcRsuBXcHJXX6KzkU2HeCS81tbGDIo
	 GqNRvxy4TvXpTiPtpCpA3BKO+LQgaSiarntU3ysCXwCD2GpDXYz3nCLlJBCkecK3FM
	 A5/5+gCgT1GzAzmx8CBHlA+dx/jOUgZPReMc2S/+etET498MKgJQAWND074OiWb5tp
	 sCpDx7M+neSe+MvGB7pODV5ymXbRCC69UnldBEso/BIJESdht8WBsDp23QideKJYRd
	 hsYC/lRL2jVZiUzL9BlpWJrOZb1gFvb20ZGkbs6GJPO9h0YWGM75dfpP/nZ67C+9W4
	 /WDq45ugvJu4zZXXz7jTgAoaPJewYSNq4uYjWmDjqPQPjyMk7/e6ma0hsXppDQ9JPU
	 wK2HUXagC1MQfPrZgYbee4oxQGyHWPIRD5A8tTE43To+7gxjoytJNigBHTXlxm4yTv
	 BJzVxShV92hk7lBouz1olWFtbWyE7HOjH8tgTXyl2DEern3Uakgfs3WWiyjRZfMXEd
	 vN9E9lYLhmUg2VvgY1seCjS8rPVnPDRe+dLN1g3berIzD6vkvTwNd095lQNwHiLnhm
	 N/zOX1SqUfWx6zvcukNw8SPmjiSKo8VL+iPrvU0ehbXfl3u50YHPEXreHjAiot5kLq
	 Sb2YR9ASa5C2XVKMQPHKdBHM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C71A40E0171;
	Fri,  7 Aug 2026 22:52:45 +0000 (UTC)
Date: Fri, 7 Aug 2026 15:52:41 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jasjeet Rangi <jrangi@purestorage.com>
Cc: x86@kernel.org, tony.luck@intel.com, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-edac@vger.kernel.org, stable@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, yazen.ghannam@amd.com,
	avadhut.naik@amd.com, msaggi@purestorage.com,
	rjethwani@purestorage.com, rhan@purestorage.com
Subject: Re: [PATCH] x86/mce/amd: Fix inverted interrupt enablement during
 storm handling
Message-ID: <20260807225241.GAanZhufwGMzonqHUZ@fat_crate.local>
References: <20260807222721.2795123-1-jrangi@purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807222721.2795123-1-jrangi@purestorage.com>

On Fri, Aug 07, 2026 at 04:26:59PM -0600, Jasjeet Rangi wrote:
> mce_amd_handle_storm() currently does the opposite of what storm
> handling needs: it enables threshold interrupts when a storm is detected
> and disables them when the storm subsides.

the subside path:

printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), mce->bank);
mce_handle_storm(mce->bank, false);
|->mce_amd_handle_storm(bank, on)
|-> threshold_restart_bank(bank, on);
|-> tr.b->interrupt_enable = false;

while that commit Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold
interrupt storms") says:

    Rather, disable the interrupt on the corresponding CPU and bank.
    Re-enable back the interrupts if enough consecutive polls of the bank show no
    corrected errors (30, as programmed by Intel).

Yap, I see it.

I'm not sure about your approach to change the bool meaning - "on" is fine at
a first glance and this fix should be minimal so that it is more easily
backportable to stable - but yap, looks like we're doing it wrong.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
