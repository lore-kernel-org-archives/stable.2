Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156021;
	b=Na77GqEqo8ZneiyFmWRszxBeoAETfKHRNDfsexMDADM8JkkBNc/21Q23KduJU1KgcGg5
	 AI9VcpZXPlo29ASPVhqP4gO5IivUlxc8mjc8wetF6KJp6b7a3s6bl883A9XCQr6TrhvuU
	 jba+JEMmkuCpG1tWzoPtymIQfQ56vj98t+as/HSl6aA4tbxpJfpPcv7fA7s9H2yiZR189
	 jH7K5Gijbx1WX+KMcMi3IAxoPY80bBJtJ32ELPZ1H+z1Co6W2n6n+KcvkXudE/CEFpgHY
	 eOvYeLnM7xJ5joaB8oVHs3W8ZdPJ5lSEXhyOvHZ15WCfw221RMKVe+WKkjHsqhqRHHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Qg44TA9M4xQVsgU9++esQTwRSc5BCFel6jJqsRyWYGw=;
	b=17NZBGRTE15qVEMnRJYqLhFdcVRQbe8bRRagtKqNuh4O4lehyPt9EUb9lst1IMqvuxgc
	 xQ4hvmm7aMIjSrxalstW8V8opE2ZhEoQmaPM0L/2Q3Jcbl5gurKbFE3pSeUSTeLWMB9iS
	 VSwfU2ekVFhMmoTRXYk2taKjBtQKvA7ZzDsrBSGqLRrKZX1pfynS0RjAt8wdB2H28JwO/
	 eJ6AfiCf9EOuy0L5CwESGN+vcTBeV+6MNHa4Ld43eg3RgT8z6xANPJoKj9llZaWlfoJGl
	 lZbKyh0wSsMfe8LS60mPyrNDTK7ToS2wHogY0CTxqknn2r8Ms8fZHZaW9GFm6O3JYoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oS1XWR2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B717606A31C;
	Sun,  8 Nov 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oS1XWR2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94D51F0089F;
	Sun,  8 Nov 2026 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156021;
	bh=Qg44TA9M4xQVsgU9++esQTwRSc5BCFel6jJqsRyWYGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oS1XWR2KgUtsY9nrSeFZRlEiBJjrNUdF4Dz66WNBglG1fdOpQKm+n9o7iJ+FFWawf
	 ewxXzC99klbSXc+mT01LhnKBDo1OWw9QS/HvQI7jjsptYY8tWZDhYXkmEe0/nwfsmW
	 CW1IYIRZ4HRZ2ongslj0N1Werk/gTWxMmnm8SDS04rvnUYT6/Wzxx8N9Pdia4fjNXr
	 vS4let5TnuBE/H1RG1DNT5wl8WYHPl2lx2wGrMEPV9fNhz+XVcHDYuz1kGVgZ6L6fp
	 1iKVCVd4LStTUBJQ1ToaBUtoOz3pzzFRpURgl9x/PHUlS37V+2JbdK5p0eNZzH92vT
	 nX6JHa01WSBEQ==
Date: Sun, 8 Nov 2026 16:40:17 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: netdev-bot+sinfo@kernel.org,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on
 byte-limit update
Message-ID: <20261108164017.GE18859@horms.kernel.org>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179348482309.3286.17799482231932078029@kernel.org>
 <20261108141812.GA18859@horms.kernel.org>
 <5a28b58c53e167ea8b6e0218fb63f54f@oss.cyber.gouv.fr>
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
In-Reply-To: <5a28b58c53e167ea8b6e0218fb63f54f@oss.cyber.gouv.fr>

On Sun, Nov 08, 2026 at 03:36:01PM +0100, Jérémy Jean wrote:
> On 2026-11-08 15:18, Simon Horman wrote:
> > On Sat, Oct 31, 2026 at 10:13:43PM +0000, netdev-bot+sinfo@kernel.org
> > wrote:
> > > Hi!
> > > 
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > > 
> > >  - How the issue was discovered, e.g. hit in production, hit during
> > >    development, syzbot report, manual code inspection, LLM or static
> > >    analysis tool scan.
> > > 
> > >  - Whether the issue was actually triggered, or is only theoretical
> > >    (e.g. found by code inspection). If it was triggered please include
> > >    the symptoms, like the stack trace or error messages.
> > > 
> > >  - What hardware the change was tested on. For driver fixes please
> > >    mention the device (and if relevant firmware version) used for
> > >    testing, or say that the change was not tested on real hardware.
> > > 
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then.
> > > 
> > > The evaluation is done by an LLM so it may be wrong, if you think
> > > that is the case please reply and explain.
> > 
> > Hi Jérémy,
> > 
> > I would appreciate it if you could take a moment to respond to
> > the questions posed by the bot above.
> 
> Hello Simon,
> 
> Sure, here are some answers:
> * The bug was found by LLM-assisted code review.
> * The bug was triggered by a software reproducer with a KASAN enabled
>   kernel under QEMU VM.
> * It has not been tested on real hardware.

Thanks, much appreciated.

Overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

