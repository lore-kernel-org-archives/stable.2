Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815106;
	b=x7UH9MJ2WjeLkYbw06L7VvaP6fuFMfI6sU4qNZhL4Iw3Hp/Ca5bPib5EKlOe2UnDlJoo
	 s82bmZy1d7sskBj2xSUiYEy4euDFGkNq2APNUAp1IH0eY3oU8GUNg76mgekpD2/S23Axf
	 040//m+ijNZs46+yu/sBPd2BTGG1QLaqt1TsrotYDV1o/OElhrGN1ECwGsCmUuAscE2Wt
	 3FYQLWEI5CH4Zq8zys6bwnV/8QmqN0KOVOy1qdlyyHOqFkjZFPgb2kbXrjQJk9O0op9m/
	 6w5h62Qj8K2QtC8xBr275gpa0vNizx1MYYcxjK1ni44WYV7GZ0Dy5bTNLpc1Uhfoj1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WWueKsNQBmvjiGTYbWt5O2pIWil2G4IejvzkaIiFgek=;
	b=v79/cf76036xS8U67LiGvGocAiWphmH6+Mh3KGzjTdJSGPfy36ycYBfe9d1Y4KwU05zO
	 5JkW4mTfHit1rRImmzkj2AtyVqRjROeuC0JbItlSMYpvuLkfGrWW++qqyi+/L+LY9nVbP
	 +YQkjJl2u1u7RUu+EQyvk6RWOui8m0fJugFt2E/fHg2GLAkerc3pUBQQRU6JRC4ilNGTZ
	 KjFwJ/SectZpSI2pHk5xit4JabMSBS+fV8fp9ZsirLXPgJLlDKMAr6E4Ou4adaYP0gZRF
	 zCOx+ML2oHXMyWhRz8Dl58OIEFBHevIPxxNnRBMWrNtac2xX4jWFYX5d+aIPw47dWtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="T/UHQwxt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF844606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T/UHQwxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA461F000C1;
	Wed,  4 Nov 2026 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793815105;
	bh=WWueKsNQBmvjiGTYbWt5O2pIWil2G4IejvzkaIiFgek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T/UHQwxt3md8c84oiYI6ZDOG9jxSYnbCMsElnDwwXIK3xCAyd2xgjEd82RL3VoauB
	 AHzG+tdrxvEffFnkKFlf+Ts2L6wIFMU+bNwfjfIxbP6HvAfPYlrcr/xJ7E87Pdfs1J
	 W+VL7AZ2hbR525knK9cel7ENHoxn7JRzAnIGOxiw=
Date: Wed, 4 Nov 2026 12:58:23 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: "S Shaiju (AMD)" <sshaiju.lkml@gmail.com>
Cc: stable@vger.kernel.org, bp@alien8.de
Subject: Re: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
Message-ID: <2026110405-exporter-surfacing-9624@gregkh>
References: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
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
In-Reply-To: <20261103182143.27403-1-sshaiju.lkml@gmail.com>

On Tue, Nov 03, 2026 at 10:21:43AM -0800, S Shaiju (AMD) wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> commit ae1d2082d93bc04604dc08e9b7f9cdba5e0c28e6 upstream.
> 
> Zen6 has BTB protection which isolates the different contexts
> (user/kernel, guest/host) from one another. This makes the SafeRET
> mitigation there unnecessary leaving the user/user and guest/guest
> attack vectors open, whose protection is handled by the Spectre v2
> mitigation setting to do IBPB on a context switch.
> 
> Detect that setting and report it with a new mitigation string.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://patch.msgid.link/20260822013231.1109255-1-bp@kernel.org
> Signed-off-by: S Shaiju (AMD) <sshaiju.lkml@gmail.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/kernel/cpu/bugs.c         | 18 ++++++++++++++++--
>  arch/x86/kernel/cpu/scattered.c    |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)

You forgot to mention this needs to go to 7.3.y too.

Now queued up, thanks.

greg k-h
