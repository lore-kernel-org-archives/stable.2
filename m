Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA546F4A6;
	Fri, 14 Aug 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731554; cv=none; b=Na3xTxX83eX0CbzOzASWI6C5c0Q0YlAVFBPRxdF0FycKKbSRvN+pO+Fzs0xwfxbpVikelFQX56xv5c/MKNZEjPrWZv84SZYiUCH8m44fkwWOsqAo80zhu0XIV9F2i/uyc+1WpyW6N2kxNVhwdr8N/4qiuDo1OjQKrtF1Z9SIKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731554; c=relaxed/simple;
	bh=tuorxcy8kCz954ftTE+fEgeG5Ca9/zq8rpku7IwM4QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/EkK+1NVix8S0Piy7LfD4LusbHF0xULJo/30ALXgNvF/B8esbqooJcRj77aSuq6uPhs0ok6aqVfp5wnEqbGkud9CeUn7HUA++vYu1JyvJzKfkqIX7CL90ZQ5upRcVZCebUM1OBnWKnGnq9Kset+fPzyBrbWqlYIQuwqJ7WBZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EzTsblWt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EzTsblWt"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3D46840E02DD;
	Fri, 14 Aug 2026 18:19:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wx0J8yb45_V4; Fri, 14 Aug 2026 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786731540; bh=zRC/6xG+xsEbvjQwqJBHeOIlQXcIvjKZxYYoh28zpAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzTsblWt/qEOtEKlNJNHcEz3XjwlWi+4LViVGsS3WsWWqdyabQrlpNbifYvk/u5v9
	 /L/3E8/1nR+dDzFpwdHITMRGD7+yK27fooDMfcGbhcFkO1NjFhlBb+hh3JFtAER5jN
	 i7ibhYxDTR4lmLGD3UPFbREg+tdUDU1/ON/edxs04gdAYoewvURxbHujACOV9P6io5
	 S2a5JDBe/s7VQBVPcMKTQYP/UALVtREUCeGRYekl/Dqd8bAdR9nhkwKabe/TdO5nH0
	 iccUdWm65+QPkFWLcKuDg9vEJRhXhCOFvGaa3bZgZa2AAZ5N+SFV7oYIY0PAquJK43
	 yQvDFt7zQ3yh294SRsEUAYR1I7HQ5dPldwCydTnMDeqf4MQlzCihq/cKtkjl1DPSVn
	 KjrIvDo6BkP/o5WQk0h8cGCgajoOB1JSIjkNrtt898Jia6kOdY3yYpePMcKPuKWjHZ
	 MY0nghWbyeOWg+xwPj/m2UxwoQMW9qAGiaOctA9VCmVPhtl9pDta+F+whTRn5lLryN
	 xZAW/Y/dVUxXEGxO9tdjywBAOu6RAOwENQ+xutXELL1xWgMRNyUYcVwxw9M1JuNBep
	 BNnAMlvQamXHSsgM13/aj2wcvW+4yHQBzbUEBW/iklwsHZZURwuS1wbXcDROm9Ps/k
	 iZDOBtklOVftLapP9K5iIIr4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A41C840E014C;
	Fri, 14 Aug 2026 18:18:48 +0000 (UTC)
Date: Fri, 14 Aug 2026 11:18:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
Message-ID: <20260814181845.GDan9cBSB731Iq1pAO@fat_crate.local>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
 <20260810140747.GB57095@yaz-khff2.amd.com>
 <20260812192805.GBanzJRTgkrti3Bm7F@fat_crate.local>
 <a57bdf5f-c9a5-4417-9d8b-d84cd29238b4@amd.com>
 <20260813235800.GAan5aCCfimjHRUV1O@fat_crate.local>
 <95307ce5-e209-4df9-aba4-5fcb668533c0@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95307ce5-e209-4df9-aba4-5fcb668533c0@amd.com>

On Fri, Aug 14, 2026 at 09:37:45AM -0400, Jason Andryuk wrote:
> Re-ordering is fine.  With the divide by zero fix, then amd_smn_init()
> succeeds in my test with Xen.  So the other patch isn't needed in that case,
> but it looked like a worthwhile fix.

Yes, as I said, it becomes a cleanup. And when you add the comment explaining
how amd_roots is going to be used too, then we're good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
