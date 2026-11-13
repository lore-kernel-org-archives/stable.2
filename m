Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574564;
	b=kFnj1RP3iGxoGY9VjUg924+uMlncHJJKF/88n1ve9VgLolo/M+TQQn5DPwEi3tkFaWNn
	 kd+sFFvsIFNFBs2+V0opRVSn/usAEDH27xMJbh759YdzW/b47e82tquShKzBoWxv3394h
	 o0I56WTzvAKfGcIPeY98VZObnljNdj4fkwLG37RgAS9D7MMVxxDgurryKUjm14rFl0jo8
	 U49tMW0GRaB1BDNg3xTBU1z3j+FpzcIi71v9GwKewUnSSuEiCjjKEU1QpKoGK+TfKeoKH
	 RnSazxhGMapEm+ndyPHRYxaPqyErTg0y8GznqZwJoYpqxpqjh4XPK+Q3gPsy9HLNQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574564;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4tSzNT5XSWSixiegslDJk3QLG0Zr8jciuO7mZR0zc5I=;
	b=k0tjRxWpL+Uocg8ZIoNWXgSpvv8+XjJoW4qKWJsS4nyqRDVCtck0mnC5yNl7mbOoimoL
	 QYCm+O1mmm1lwmLnO1Um3nbXkcFIaD+mH6Ac+yeS7GMT/z8kLRjQJ7PBP+9yvb+H06VeU
	 4ifVy5MlOucZPoJuQd6xjYBHqVTYmPTp1trrtqrV05KdQyTB9m3j6pBa5rMASqr3ky9OO
	 +zg8H8t6c4MHI1p781gvFPsJbChBMm51oIuYIdOZDL4dPmLLuVOAkRukcFpyDsYNXyF7W
	 qDqAxfX+XJhNqo2J+52Pk+GvdtWfIGwiT0eEArbF61bcAtGCVzCTEw1SOMtFa00kaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvj4yY1l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC85606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvj4yY1l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDCA1F000C4;
	Fri, 13 Nov 2026 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794574564;
	bh=4tSzNT5XSWSixiegslDJk3QLG0Zr8jciuO7mZR0zc5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lvj4yY1lMbAfCFEKpUy46MLT7MIRUMSw/9DvQi0lCqCyfEEWLXHLjrYGbcbvlyUgd
	 Ee42FemA5b21zkdvvm2EAcIpaf0CjIEWN/7EUqsJjyBITnPtmVDcsG4MPROXfIcQFH
	 YctRCRfK3yh8tnV6DyDCnIiemj6ANeOP5P89LsEZ75NDg646Bnpu6/VKcK8z8UH3Wj
	 UHidyE1JlCdHLM1Gxtue3BpiaLFJ5AEJKZF3ACXzZxQreCex3EyZXGaYou4/uM0qna
	 q9HmZIM31Sgl9Ew8S87KOh/SHp2hHnSzP38MwKYuY4xgcOd1he+AXwpFMLvfpsL3my
	 TU28frsWTH7IQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id BD18B198003A;
	Fri, 13 Nov 2026 07:55:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 07:56:02 -0500
X-ME-Sender: <xms:3wj3apbkmeonf4y5wE7ksEA3GtTBf57EWzkWE5neafKKC3LIBFU7qQ>
    <xme:3wj3at7H_CSaBiiK8MxPCWEXxuf8_32SjEpBm7p6t46otfyshxxW0DySGHZC2nRx6
    o3CnKqCMg3AcqUsOLjzzWxJ3gE-E_jODyZZW59-0WOiS1ywFfQoHSLq>
X-ME-Received: <xmr:3wj3aoCjT6qOBmsBWaEBbadIi4IKYX-_viGElTeJ1FBxXk8-jPLWXELZq88>
X-ME-Proxy-Cause: dmFkZTEALCY8BjEB9962J19+FFzaFn7/mDszJU/f0IQoJYE08F9eNi9AROuRlq7pU2+FXD
    zoNVXqKBs3ph2NtrQiIbObaLyrIngOHx7B+sdK6iQ+jfItZBvkvsFLopEHbvs6okBQgb5T
    T3FhlyqhoGdVKxR9UvwevmGemWC2pw9RXWPJmT/hEImGxMrfJhZLPtavP/c6QdWQg/A6b8
    X5O11D6kkCylwxWMIUDUmx1JRIy29fX8Rzvm50e/adyzuWb9S0hJRhcuwm+lPAtw8FuGn4
    rju8p9vVIWIvL96aJgoJcn0XKhXQzZ1uUAuAH7wCb597h85mktgUj4cIXuqKo5YXHCqSYw
    ObzBzC+xeGRFdSq8OK9Iw179SQq7JXdMgizRPjcfc7bMNY4T6epVxNLGOJxv3xUQSLR/64
    Zxw6vhBrfWdMRycJp9of5fwiEuNbYcgfNCpCp0cn3gxt62aAog+aWCJXFmQAiNZCZkWG9B
    lWC/3udG+aiOLf/DbuEx2ykJWJHQaSgwcHKmqXrBVIxChV1yPNGmyFR+DbWWQVtVmpRQwj
    NtZPNHIr8/CvIjr/tdwg11qigVVQJPIqaWNhPn6ysx/4QZa61YdCJv4sA2APKR+gfMKL8v
    obEc1lTb9YEpWYZIrpyfGF/TB6GjA8e8r0Isgz4pTIYFCflmX0V2H1dmabRA
X-ME-Proxy: <xmx:3wj3ak6FPmng3aMbspqR6Igf0D2sIbQk1-6WorKrbKKADDHG0AAPMQ>
    <xmx:3wj3anJXJB8Zybw1x9dD0vuFCyrMwqOETaiw83FKYEJZqKOlm8gtEA>
    <xmx:3wj3aoxiwa_YTR87D7tSQQJSTL7TiZczR50Ez5E-b68EkZsa0J6kjA>
    <xmx:3wj3anFPKaQGh8qkS1LHsQZRjpVPAb0cT7GRfwH9jf9WeNj9M__Iug>
    <xmx:3wj3aoklSg9r9EGOP_SJS-KycWDomPYN6vpd9TXmeUML4jPK2OXNFZsy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 07:55:58 -0500 (EST)
Date: Fri, 13 Nov 2026 12:55:57 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, Pankaj.gupta.linux@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/unaccepted_memory: Do not accept ranges that are
 no longer E820 RAM
Message-ID: <avcIhKCXFo8Pn01U@thinkstation>
References: <20261113105554.199912-1-pankaj.gupta@amd.com>
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
In-Reply-To: <20261113105554.199912-1-pankaj.gupta@amd.com>

On Fri, Nov 13, 2026 at 04:55:54AM -0600, Pankaj Gupta wrote:
> Accept only whole pages of E820 RAM, and clear the bitmap bits only for the
> units in which memory was accepted.

A bit in the bitmap covers the whole unit. If the hole doesn't start and
end on a unit boundary, the unit at its edge is only partly accepted, but
its bit gets cleared. The rest of the unit stays unaccepted and nothing
records it.

This kernel never touches the hole, but the next one can. memmap= and mem=
only edit e820_table. kexec_file_load() hands the next kernel
e820_table_kexec, which is copied before the command line is parsed and
still has the hole as RAM. The next kernel finds RAM with a clear bit and
uses it. memmap=1M$0x1fff00000, then kexec into a kernel without it.

On TDX this is new. tdx_accept_memory() works on physical addresses, so
today the hole is accepted together with the rest of the unit and the
bitmap stays correct. Only SNP needs the direct mapping.

A unit cannot be half accepted. Given that, should we go with what Ard
suggested and refuse memmap= holes in unaccepted memory instead?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
