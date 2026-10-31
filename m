Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478372;
	b=Ise3Tstwc25VwWuVwGVxFZBDVaI/3XmLaxHltcYdj5vCmKJzSXZ47Cq1YQnOsapLTB/f
	 SBx76oMLeNYCi2Ii2+yQFw1jew9sWYUozPpekth+eowlY1QgzBkXhsOLugx0t8L7Bb3W5
	 d7HF1d/UgAKJjAsv4Wbd/tGvW+oJeWe/fu+xTaYkdydwsXUPCeEW4IL1izwO/Wfp3d0Ki
	 uQToaQsANO/MEtlXj9EW7ZYOngRT+jM90k3oy3L6hrAZs8jt78Gi+VDEpc4ddFJHetuUp
	 V++iJVUk17+wNQx3o9vx2RbpWUDRXoWOzJ4jIuiyAJ+TusFuTbMe3neehm8aJhh+jYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478372;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=31OiWa7Bx6I+GremiKpxsthouh1jt/r3kqbeVlN0OHs=;
	b=SDy+j3KS1sZyPJ4T0o8lZeEvLtQ33lrPD+swdQ12q3xWKMEAE6Xs8LBUd00pk35zaIS8
	 Ef+cvNbHthhqhikLqW944Mf4swlCl3eh3dcaX6ADcACO7ddcJ5GcyG75Plumb2UFknpF/
	 L81/HIzQU5tck2h1Iq9VNrxkQ7NsW7WmDnXAXfKtPOadFh+f3EaTTDGlh0yn8zeuQoClL
	 kO/FEmKxXI08fCQ3su4h9fd50SGUk1BWZS4vKHTZodAnWnlz1Ce4KnELk+sQPXaYaEvoH
	 vrnPUS5KSOzH5CnH7LBqel32o3P/F14AEbZDcG96wVYF07hIdPZJeoI6S+eBaT2G1ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lo7IeOrk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2912606A31A;
	Sat, 31 Oct 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lo7IeOrk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6AB1F00A18;
	Sat, 31 Oct 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793478371;
	bh=31OiWa7Bx6I+GremiKpxsthouh1jt/r3kqbeVlN0OHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lo7IeOrk67ctqrGEFCDLMXypVEqIIsbbanGBvTw3tsxy4zUap5zf87NtFJYtMIGKd
	 RxfgmhQ4vRf2jK9dBpv3zeezgtDNbmPe2fd/N342PR1ugL2lvFgDOB5LBtMQ14+ZA/
	 z4ePe3R+kEmPnj3kp5mVISBjiG5w9cKB39OsWO1c=
Date: Sat, 31 Oct 2026 21:25:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Radek =?utf-8?Q?Marci=C5=88a?= <github.unusual340@8alias.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhkelley58@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y 2/2] mm/early_ioremap: Sign-extend PAGE_MASK when
 aligning the physical address
Message-ID: <2026103137-showplace-numerator-a05b@gregkh>
References: <179346145167.7.7861216093151225931.1735978772@8alias.com>
 <179346152914.8.7838190602983146541.1735981230@8alias.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <179346152914.8.7838190602983146541.1735981230@8alias.com>

On Sat, Oct 31, 2026 at 03:45:21PM +0000, Radek Marciňa wrote:
> Signed-off-by: Radek Marciňa <github.unusual340@8alias.com>

Sorry, but this isn't going to work for the obvious reason, so we can't
take these as-is.

greg k-h
