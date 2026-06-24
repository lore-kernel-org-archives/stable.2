Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9B3DD50E;
	Wed, 24 Jun 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321366; cv=none; b=Qe3KP6hL/5IhdUzOtxozRwF4y1WK/LUBAWpRKvpL6L540RxFkC78JES68Lx6l+grWAQ//BH4s40hbcdmWWEp4EWvzyIVoncvAoN6z61RASGJSghysz5dpf/7A2EfCDbiDlxDyB2OKRLyDj+nNfqi9d5FZC072iDpmY+pUS/I6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321366; c=relaxed/simple;
	bh=iPNcIeLf/61yvKOkQo1dLhgUZkJvexzibt0odvRRsYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1s9mmd1O8ZOF3Nn8HdXHCeWyJh3846NMnRBnvkZNoKX3kKDtCtrscNkjYjXOvMl8Idx+SR5Vv5EXDEek2G8p3E8BCCCnMyH3Q9YH4akAIMK14Z63ilmuJp1n1pRqV2Rnhr2mE6S5GlJNS3eN74Rs5/61FvcN2qvKNYk2Cy8N0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vtw6jtyQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vtw6jtyQ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 28D1340E0031;
	Wed, 24 Jun 2026 17:16:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JcqgbK_5Wjrj; Wed, 24 Jun 2026 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782321352; bh=CTk+ROcPgrIf3u1NqBedkrjU88PTb7VXwIsNvLzCv+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vtw6jtyQEXc7XI+hJeBcCwAYxc9PAvM+dj97XeI7T1wEOrDg55zwlxgCax+uX9E0Y
	 fKBbU6jUQ8JrwQ4oNrDvcRheo0iJOedO+rpmtqz2DSHdsZgpw1BxeHpo5ydsfiZ2AO
	 nBg9RRCxV+6g7UBvfttss/2surdRdqfQa+mOhSD9PkqTCPOcipUAjKX6631zHWSV4R
	 3k34BiDCEeQugFw4Mtfyz7nGh2Y+YwyzlYSsTjj07gry0wfzkPCpHA17DU7SadH6Om
	 8OeJAaQAmawni9t57dRG4UXS28s+ZilnXWq4Op2ECElQ5r4dp2SOXCmiz7prx8aeSc
	 faSOz1zCW0cbsy6X+kHve3PGmmiyzBu3cOlvAjVp+MNgOzrwFMhwjSONNbm15M+G77
	 coamxf/MztM3XhOaNqXeLO5yLnY22xVj57lVN6qEmytWOpH+SSyFAWqEkPbsbG6/2+
	 y3DhABVo8+84wpyjs/Y1G1FIe6Pdg5oGVAXr0tGKM5SMmRaNjQnqrPySy2eaTohv1Z
	 Pg/qo+ul50Pbb0fhfSxEeOeqPENxtR+RqjbD3EfNHjkTHU7HCw3vn3nOsjPgadRtds
	 fI9EqYU4M0BzB/5178ROtKEELN4mEtCnM/c6QYK/OsxWdnWAJhXrTLTIVH99ZZAb5A
	 1S6m4nfQaOQT0XA9Aj/11Q1A=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D8A740E00BF;
	Wed, 24 Jun 2026 17:15:39 +0000 (UTC)
Date: Wed, 24 Jun 2026 10:15:36 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Message-ID: <20260624171536.GDajwQuLD9pkLRLpLE@fat_crate.local>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
 <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>
 <20260624155910.GCajv-zguf0GiBxt2F@fat_crate.local>
 <0500111d-91bf-4105-8de3-af44a113157a@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0500111d-91bf-4105-8de3-af44a113157a@amd.com>

On Wed, Jun 24, 2026 at 12:41:48PM -0400, Jason Andryuk wrote:
> I think this is the issue:
> 
>     The "root" device search was introduced to support SMN access for Zen
>     systems. This device represents a PCIe root complex. It is not the
>     same as the "CPU/node" devices found at slots 0x18-0x1F.

What is that? AI output?

> We don't want dom0 to access the "CPU/node" devices.  It's the "root" device
> SMN access I am trying to retain.

I know what you're trying to do - you want to use SMN accesses on dom0. And
I'm trying to figure out a stable detection method on Xen which is future
proof.

> Many amd_smn_read/write calls have hardcoded node 0, like for amd-pmc.

Maybe.

Whatever it is, it needs to be a long-term solution and properly vetted by Xen
folks so that we don't do crazy hacks for Xen's sake everytime.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
