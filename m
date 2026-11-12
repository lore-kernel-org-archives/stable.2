Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501650;
	b=eyYFN2BnCsGZLm0xi0ln78aLrU0AP3qHw9For6MqlX+P2chIRnRLYiOkStxakgqOUFiD
	 vtwtVjZXDUK/nCgD/2wvyyhzd9GF3kYjWHDpuzoajlJKr1MMapyvTBZLX6Ne0ILNcVdsh
	 rJA6sfu2eVXAKKnP/SbwqYHXQDXQq6nhZdNfX0uB9xi4Yv+89oR0bFqXaSq6/AEKB2Fqk
	 J/ouQzvqzEj2IOnRfXiy+J3grVUfmTZTmly1Ddrf52my9yQq12VVgtX7a16faB5+GqRsw
	 LzsLOH2WWoVRR7NNaWdapqSbEMZF8j4futU9ApJHIfxYbQCMjihyNJrWQ7w4xMT3XQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h4XhdGstHHaoDKhn87VxtYdFBjOR/ijZJS15gJryUyk=;
	b=xFP2z60z92VCFnhw3sxHn3uRBpsDVu4HOvL+S+fwKtJMsNu/61d2WR2Cw1Z7spsPv5oi
	 lvykPyQTrY/VsNhxDeVP0cjzHkJjbnhVT6NIxgHVit3AAukxSrngFw9NTX5/RMV6RuXX9
	 YpuBZIJsa1vlPeE/woQIq5D0wzpmZvHMzvHCXU8SKM32sGWPiWAAHS0HgOg+xfd7kUa8v
	 HxP0Um+Q0lD8Vce2Sylb4wxGEW6tc5ZpcVUeTESHMl6hS2lQVjee/4lmtB9cL/5bMGNnA
	 II7OgjCQy5VW7hEiTXLcs9upOs2bqJqcNXHqklQpxClPLDX/p79NLy04SZKNn5Ir09A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z2HWyp/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C31606A890;
	Thu, 12 Nov 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2HWyp/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222B31F000C4;
	Thu, 12 Nov 2026 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501649;
	bh=h4XhdGstHHaoDKhn87VxtYdFBjOR/ijZJS15gJryUyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z2HWyp/tJDDjjTHcJR3EqrO+Co3DWeMLJ1+cp2ynX2OINbp8WyivGS6bUYCElRnHv
	 j82yu2W0I6XbhRl6k1jGMrybLRN3rtsxa9jpBTx+ED6Lo2I2lVItYT5jq4zrZSGZzs
	 JXUgU8bmDotIuPcRgcQnRfdkmCpC0cle2atzG2wdTeGxjiblOhweVWrNK8sHl3qORz
	 AptP+WXgJYapp1q4qpa21NtXJZGJFCXXQTz9CI+U/mh2RSFbpUGKjXJrisLA5A/IyL
	 WRrvvgmWPTatgjPr4LX8gIKpHS1COMkia2Rnrxs+diTDADTj0jXe4+8KHHufORL2wP
	 EtFhzktL6OIhg==
Date: Thu, 12 Nov 2026 17:40:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] crash_dump: recover from machine checks in
 copy_oldmem_page()
Message-ID: <20261112-singt-gewettert-rohkost-74009dcf3366@brauner>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
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
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>

On Thu, Nov 12, 2026 at 05:37:06PM +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel. That memory
> may have uncorrectable errors in it. Which is likely also what murdered
> the first kernel.
> 
> On x86 a machine check in the copy that /proc/vmcore does out of an old
> page panics the capture kernel. On book3s64 the read() comes up short
> and splice() panics. Breno has observed that on a fleet iiuc. The first
> kernel dies of a machine check and then there's no vmcore either.
> 
> I had the powerpc half of this as a fix in part 1 of the procfs series
> because Chris ran into it there. Breno pointed out that x86 has the same
> hole.
> 
> I think that likely makes this a kdump problem and not a procfs problem.
> So I moved this out together with the ioremap_cache() fix.

So I'm not super familiar with the machine check stuff. I know that
@Linus has some familiarity with this. So I guess a yay or nay would be
nice. Not sure if really a localized fix for the architectures that have
mc support makes more sense. A common helper seems less fragile to me.
