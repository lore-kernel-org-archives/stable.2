Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49D26AF4;
	Fri, 14 Aug 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749922; cv=none; b=hXlOqVabL4bQ+yWh6aK4anW3BAcNlqlfSqYK/h3DY7yfe671Yu27kqKxiO27wfeyswQv7AzuHV6A/DgZcMbOfyvW5uzppskjPLlPAUqGSdp4v/rIMl3ZaMQICs4Rgxet2zFFy7q31NjSmYkANuMGCGtldLOS+DVUUmJrasri5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749922; c=relaxed/simple;
	bh=mqlG78gvNjAaMYhVSL9ycsVNFdBkJD2N6QgZxtXZGEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/f9l03tW9pypEP4tPckL6G4I5Ru2i/JH8TuiptYUBN5uSFt+5OSYsHScFWtjs9VXUSS2pAnp6v7mrP6qnBhrjAklfQ8X1xdjOrqdQ86mDdzp/0feoI8JmWEMen3WWKKivePTI/iwXWU3ZdWLhNLk+JaPAwrQgtCUrtX/g98Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R+quZCN/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R+quZCN/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9235340E014C;
	Fri, 14 Aug 2026 23:25:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XPZdJJjX0wzA; Fri, 14 Aug 2026 23:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786749906; bh=nxebB20xYfBX3tI/9cemYUdsdYltv9WZzkexbMBYcvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+quZCN/MaAkNkqoxWKbrKGhy1hxq/o83w/dMv0nbEFGxI0t2G0JjmsqPr9MEmuFT
	 FU3ONjkpMwMSxE6cFYxggFynjkOA0bIneV/Bwf0JyDPkhc+Vm+yJeV/nb5Ohmxbdq6
	 WMlMvjkQlcyzHyUUgPkgZR/I06BwsAC6k51+FdZCG4WU9qxAwCF+p5aFSL+rV9AutG
	 /eA5e5IYLUeEft4OXW1NZgmJwQxANXGF/Ef/rtIiCiPvuTur4FbqpEz72sl4BMuGA2
	 ej4hM5R/6IOI4Oy0f37o8572ncd0IClPzLBUIj3gm7AOpY0lJbcuDg7bjyI3c/EGJH
	 RYLAO+vaeinYMdNDgENz0+oopZPrMhizUpl2agu1ed8u6DvXEA/YHmFpVAKLd3pnct
	 fafsOvzfHtnN1UewVmKyTyPQygCldZ2c8PDazuDJuJOzkq/tUYn3DJw3izXdFp7GyU
	 IUP8/PS9yTf99qE4lEr6ugRHTw4rrRdGmt1Rfd7iiHvSHd5iWDsUK4f6RlvMD1A3vM
	 mIKNBMHRCfFyONo4QcFrZe13sxG/ziem6IvP0Y2o8DAvlKH4hIYwuu6kJI9jD5mRWl
	 YHbfHPdwcATSKWglQKhwPetb2EUyqvWCdgqo3v1TgTDlkPlQZpcuQ6tTdKKRENHqWF
	 hZmRi108lO6CV2yDMSbuGfwM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4957840E0031;
	Fri, 14 Aug 2026 23:24:50 +0000 (UTC)
Date: Fri, 14 Aug 2026 16:24:46 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jasjeet Rangi <jrangi@purestorage.com>
Cc: x86@kernel.org, tony.luck@intel.com, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-edac@vger.kernel.org, stable@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, yazen.ghannam@amd.com,
	msaggi@purestorage.com, rjethwani@purestorage.com,
	rhan@purestorage.com, dgiani@purestorage.com
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement
 during storm handling
Message-ID: <20260814232446.GDan-jvtKrj4Bh8Nsa@fat_crate.local>
References: <20260812221514.598842-1-jrangi@purestorage.com>
 <20260812221514.598842-2-jrangi@purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812221514.598842-2-jrangi@purestorage.com>

On Wed, Aug 12, 2026 at 04:15:13PM -0600, Jasjeet Rangi wrote:
> mce_amd_handle_storm() currently does the opposite of what storm
> handling needs: it enables threshold interrupts when a storm is detected
> and disables them when the storm subsides.
> 
> In addition, machine_check_poll() -> clear_bank() -> amd_clear_bank() ->
> amd_reset_thr_limit() will unconditionally enable threshold interrupts,
> which undoes storm mode behavior.

Except that the Intel side doesn't touch the CMCI_EN bit in
cmci_set_threshold(). And we should not diverge here. The thresholding
interrupt should not be a problem because with increased polling frequency
during a storm, we should not be really getting thresholding interrupts
because the polling code will pick up all MCEs that get logged, first.

And the second patch is not really making things better because, well, "on" is
"in_storm_mode". Basically the same thing. So I'm going to queue the below:

---
Author: Jasjeet Rangi <jrangi@purestorage.com>
Date:   Wed Aug 12 16:15:13 2026 -0600

    x86/MCE/AMD: Fix inverted interrupt enablement during storm handling
    
    mce_amd_handle_storm() currently does the opposite of what storm
    handling needs: it enables thresholding interrupts when a storm is
    detected and disables them when the storm subsides.
    
    Flip the "on" function argument before passing it to threshold_restart_bank()
    as it should have been done.
    
    To clarify: "on" to mce_handle_storm() means, the storm is on now when
    "on" is true, and off when "on" is false.
    
      [ bp: Simplify. ]
    
    Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold interrupt storms")
    Signed-off-by: Jasjeet Rangi <jrangi@purestorage.com>
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    Cc: stable@vger.kernel.org
    Link: https://patch.msgid.link/20260812221514.598842-2-jrangi@purestorage.com

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f916fb4c5d13..1cc20b855b7e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -865,7 +865,7 @@ static void amd_deferred_error_interrupt(void)
 
 void mce_amd_handle_storm(unsigned int bank, bool on)
 {
-	threshold_restart_bank(bank, on);
+	threshold_restart_bank(bank, !on);
 }
 
 static void amd_reset_thr_limit(unsigned int bank)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
