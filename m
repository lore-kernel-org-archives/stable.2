Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276212EEE88;
	Wed, 12 Aug 2026 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563107; cv=none; b=fE9vnUudQn9YX6dEtT9W4GMI5rIpTc28xTOOO8IhVIICq+X+ABfJqQQr3KpDiVi8KJVLJ/b1WlQuuWKsjqFWF8PsXEPinl7SEqDzfN4L4x9ffASVo3nM+49/uzxcep9mD2U3hmSShWjxuUStyjlmGNRFwY3YnkBXM9oq6n7yzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563107; c=relaxed/simple;
	bh=eSi+aiYmDz+UjspgNSk8VDQ06flT2Y9JhfEVHqOvzbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZG/wvwW9b0yBppIt3o7E+fzlE20Hox4k+7hXXnSYIVzJ5E/t3gq15V3y1oR6/Z7NxNTXy5IAx9V1bvYVuCxtLkn4dfYoQKLTF1ogMJ1qClxqnCYNDmq6HkjqDLHIyrw2nzPu8KwFLuSw6kJT8x3SaTCqRqo7SCgcSI7eDnhHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BfQ1HqR9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BfQ1HqR9"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05B1540E01CE;
	Wed, 12 Aug 2026 19:31:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FQbdv5FFofjY; Wed, 12 Aug 2026 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786563093; bh=OEpYRLVLmhaCChhPxdTGB3cs+bNyrg4djk7tuinMr4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfQ1HqR9dQZ0YbiLiXJf04VfA8VMZ0bR4Y7L3cnkQNKooOjy0Xz1Muj5FR62x+U13
	 EH77FwKvUacOIvVEeI1YOV6/nYRZeBYQroJWcGRRVTDPliwaHDyqhKytDXsYEYi99S
	 +MjcVeN41ut9wk4tBlBNlQbfS8l0TVaS4Wo1CaH7Y6V0eCdy4d9h1G91qU+Vh0q/tZ
	 ot5kZQ/7fq5Nb1yOWyoIzEet8AMcoF3EEvGzN8Kk2O82fxu69WScsVo66AgS1fUHte
	 9LlqgoU48Q2MRJW6Cf9f/pYMaqx2sl3kX+jOJiDuaqMPZbXfhQ97d5r93366GI7Nr+
	 bT47wWjytgCO1tgjbl6NZr9s0t3txL+LYqpn70Xfz8HW/Ayo7aSFumBqenpMCZWjEd
	 7q70euW8aIepSdV+VYyEYtuHNUGyKOrbYa6VPESvLBlbH+IfyxhJlXiqGs3dBT5Bwd
	 kt1qNyve8yhAZwmlB41UT2a1tufaX8BkLKwBygn5fytqlt4Vt9zs4hSi5ke/QVQiMJ
	 s+wSxDG/0exdCTTe202KaCc9KeuqemS2zAeOLydVGUagm2RoUF6Hyd25kQBoSBEhvZ
	 9DQSEX0ByUBmLIJeNuCLf51jtI0l36RBdHJxhZVdvqxfbiHFVqGuCXgtVKr7xmORNc
	 TC6dHlA+pRDQp8XlIS1r0FYU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73A6040E019C;
	Wed, 12 Aug 2026 19:31:21 +0000 (UTC)
Date: Wed, 12 Aug 2026 12:31:17 -0700
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260812193117.GBanzKBaDLIdI_1Cfa@fat_crate.local>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-3-jason.andryuk@amd.com>
 <20260810144706.GC57095@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810144706.GC57095@yaz-khff2.amd.com>

On Mon, Aug 10, 2026 at 10:47:06AM -0400, Yazen Ghannam wrote:
> I don't think this is necessarily a Firmware bug.

What else can it be if we're running on baremetal?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
