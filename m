Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831959;
	b=LG9RDhFpuYj5ZOEauwRQTmrsF+OItokb6SbKI1yUbCAiluSNLyj73qg6sXVZlln0vDX0
	 BftWscWfnBRaGnic5ucxAMeufcbg0RUdh6mKr1Ykyv5VLJg/ag8QRQnleGuFuMktmp9vI
	 EIFsEU4CP2Th3LXDYRHwJtJWylafUzMH6QaP5HHYQqnBA94pM7QFlcUwmPeDSvB+mKf+y
	 8isMwcnnbWhJh7ma3t5WRIpvY4VG37l9gaV4YNaANG8GdS2WD0VtnNKSPP6p+orO6qZgd
	 pnI7wy2gcrAGAoMEqwLWLzc1APx2RnvrLew/rIFRL2jaI46PL92yH7hJf0HIVumdO3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YALGcrzQ4O6vvZMnexM7qTw2QJN74h7pb23E9WOgRKM=;
	b=PUDnLg+5kriinbrVP95daCGlCVTp2+GObK8ml9OosYKt/kKRS73kjxSZTzam2dQECxyV
	 jZgu0KraHK9GCtOna3Vz/Jgowq5Sq4zw/ZtHHtRQ8TIzOL+pXJd7sng77Bki8GQYw+28H
	 hmiehV7yEOE0C4lP2p+xkrC9ZH68Fc+k6zcNv5QG56Ee3qPodGtrq2RlSjIVkeHgY0LUj
	 rCYiue4KU34BeRe8PW/gyAcRlOGM/mUXpNdwZkYNr/qCukEAJQ96O6Qxmv5LSCPTohnQk
	 q5DoN2U+J2eLHSFm7a70Ke8f9gHFhn6vO7efpTw632AoO1wFA5EoJKU7FtN065V+0nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hz+uMkTg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABB606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hz+uMkTg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD2C1F00919;
	Wed,  4 Nov 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793831959;
	bh=YALGcrzQ4O6vvZMnexM7qTw2QJN74h7pb23E9WOgRKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hz+uMkTgwv2n8q+9UUG2Os2WmBGfX5d+aqEzqKcTcxuJhOLQ70nvWphyrqmNOjDHK
	 0vQs8+yF7Z6HYYaW5Yqz1gC9rG8RUXS62pr2Y/Rem2xBNb6bTLKfzbkkGzGPonZDdT
	 eY/GtDb0gp1RUDmQQGJzF0vVBiEC8qdlsIohqoD4=
Date: Wed, 4 Nov 2026 16:19:06 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "S Shaiju (AMD)" <sshaiju.lkml@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
Message-ID: <2026110456-greeter-reconvene-ad9e@gregkh>
References: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
 <2026110405-exporter-surfacing-9624@gregkh>
 <A286426C-2D2B-4CC2-B113-7212B62CB03F@alien8.de>
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
In-Reply-To: <A286426C-2D2B-4CC2-B113-7212B62CB03F@alien8.de>

On Wed, Nov 04, 2026 at 09:08:29PM +0000, Borislav Petkov wrote:
> On November 4, 2026 5:58:23 PM UTC, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Tue, Nov 03, 2026 at 10:21:43AM -0800, S Shaiju (AMD) wrote:
> >> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> >> 
> >> commit ae1d2082d93bc04604dc08e9b7f9cdba5e0c28e6 upstream.
> >> 
> >> Zen6 has BTB protection which isolates the different contexts
> >> (user/kernel, guest/host) from one another. This makes the SafeRET
> >> mitigation there unnecessary leaving the user/user and guest/guest
> >> attack vectors open, whose protection is handled by the Spectre v2
> >> mitigation setting to do IBPB on a context switch.
> >> 
> >> Detect that setting and report it with a new mitigation string.
> >> 
> >> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >> Link: https://patch.msgid.link/20260822013231.1109255-1-bp@kernel.org
> >> Signed-off-by: S Shaiju (AMD) <sshaiju.lkml@gmail.com>
> >> ---
> >>  arch/x86/include/asm/cpufeatures.h |  1 +
> >>  arch/x86/kernel/cpu/bugs.c         | 18 ++++++++++++++++--
> >>  arch/x86/kernel/cpu/scattered.c    |  1 +
> >>  3 files changed, 18 insertions(+), 2 deletions(-)
> >
> >You forgot to mention this needs to go to 7.3.y too.
> >
> >Now queued up, thanks.
> >
> >greg k-h
> 
> Ah, thanks. You guys are opening and closing non-LTS branches waay to fast for me :-)

7.3 will be LTS :)
