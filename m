Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8817A2F6;
	Thu, 18 Jun 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758468; cv=none; b=saFyoPZtutqEYoDJK4opKkZBzxJodx9evZ0Ia67Z+Mz6a9oGmc3YzB+/nlSyK36sFcaasWLzTZIGWsFSvE7w6s1OEsPgBua1VRm0hFLx0qWKgukFku6xiEuUld6rRAMnJLmYZ5oH8pcs91MB1+bHtgBRb+hJeGhjGelXLNPcREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758468; c=relaxed/simple;
	bh=XbsBg4/NU2BYteToLiNpLXmkDRCx96cS07G2DulvX3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxu9q4gOaJLOIlXIBVZ4OIheQle6NvTyHmVmq5qZAC41kwrkdP2c2iPlXh1a8y8WPzkIqwQQ+XjsmGfwVYSbspt7ElXVVafTBa/P1EKV4xEOUc5ghg0IslpjkHX/S39kSvSOUwvoJOHttObGjEX1pAtDRT/5U6AQ5VX+xWV9GV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K1sEMdqb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K1sEMdqb"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A13F240E01C9;
	Thu, 18 Jun 2026 04:54:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C-lO53s-ZwwY; Thu, 18 Jun 2026 04:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781758453; bh=AzjJMSaRuItbT1wFHbmHrKfkEbN7VtEXIhfW20rUmA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1sEMdqb9zTUKp3cIzAga+tFk9ZWh+XI+q2DW2ek2tkRmjXKAd9q+uOHzX85qKD3o
	 hzk6Fyox9hVN+oGU4S4kON49VPphq1J9unqb5smTxK3x3SSJ5kWsjF1E7fF+cjcGFM
	 6hSpvOoHRBlLOjTY+2hJASRAofoJSD/OlMAVgZdkJwpBa86Se2uw6SqKYKD8Gjw/oB
	 oT9QGfV+bvArM/kT+e4uoloH2ApHSJAfWfYvhhEqQxiacmkwcU8E/Mi8zIwSjsJ9Lt
	 TeG8o+pEY4KVsHgln16WfarBZ/qye224Y05Zp0NfaFVKKdzGvaRkX67qrW7tmGXnQR
	 ca/vibvQLjag2Xr+aGTKsUKnB0ExnKMpXvltR31GTkWiZ93OA/btII6q0BFPrEFMEr
	 e1STYRb0lNtcIHJIrxM6MLrURlQMRXXxrvcWSyiM9TfgZ1xfPXrxn8LnO1UZlOloIQ
	 N1njCQMnzHhh1G4EFI1E8eJO2QKXAdrqVcOaHxD11yP0pfSeXpQkiNJOO1X5LNj7ka
	 GGico1s7pr9398Wzh9gwjWH9TzmR7GLqEw9u/TpZCUGL6L11HVd0gdRbwKavRd5YVb
	 NU+vs2yz0zTSsPOrr0lL4Ja5Sx55yHs9ueEcmzbosi4Mn6l7QFyq2Nw91D23CqmqHg
	 svbMt042iXVCksUTm9sqxuzA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34E0F40E015A;
	Thu, 18 Jun 2026 04:54:03 +0000 (UTC)
Date: Wed, 17 Jun 2026 21:54:00 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617130417.36651-4-thorsten.blum@linux.dev>

On Wed, Jun 17, 2026 at 03:04:18PM +0200, Thorsten Blum wrote:
> cmdline_find_option() returns the full length of the argument value even
> if it is truncated. However, get_cmdline_acpi_rsdp() only checks whether
> acpi_rsdp= is present and does not reject truncated values that do not
> fit in the buffer.
> 
> Reject truncated values early to prevent boot_kstrtoul() from parsing a
> partial value and thus from silently using the wrong RSDP address.

And?

If it uses the wrong address, it'll crash'n'burn later. As it should be.

Or are we protecting people from shooting themselves in foot now too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
