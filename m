Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C2329C48;
	Wed, 26 Aug 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732451; cv=none; b=fTyMYuvYahBui05hQ8uwQCX7tN2Q65SmqzdQIGpA2Bvwsb8H4cX08Kbi/pDTCHP2az6FCYtij/K8Aa8iVtda5qX8O2TkbSKpbRBt3/8R9Ba8w9KEYvnMx58w1j5yCg8IrIku34tcK7/hVN8U/USsOXPbf3S5NB72HJY5TxhvLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732451; c=relaxed/simple;
	bh=L2jTBik34L4IKN2v7U1iuFA+B2KK/86axUcteVoIGs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VylZtSwFDHKZPyytiSacaplbd58vsRVR7G35ooa0BPO+JVn99YwOi11OO5L4a8jizA3SM/cRPyrjZRIe7EJYDhPRuwh1yfQxfUugDpqsVr4Y77SKNmG1jeDotB52H7FxcfplfTptIZlfz6/qUA79fG+HJlRgytqJ9ci1C3NselE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RBOcPlY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RBOcPlY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF7A1F000E9;
	Wed, 26 Aug 2026 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787732450;
	bh=6rtIpVWOsH4xqmhu92q/l09e9sAzYoHSkvy5CikzJQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RBOcPlY2q8hy9XyizLTVpKS9GEJAKZR3ojVM+wDmpO7/MwIeKs0nXb1jYQK2dzb7h
	 xV0q/S9u8xwTF56BdzRDPOmxDvu2VnDYO452GTxY1BWApQs5wpRgS40Bkz2oJBFaRg
	 3IR20jJhiOcOtqCZZg+wAcuWl6x3forJ9E+SznjE=
Date: Wed, 26 Aug 2026 10:20:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>, Gerhard Engleder <eg@keba.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Message-ID: <2026082650-outgoing-cane-6c3f@gregkh>
References: <20260826073237.1377668-1-linuxoid@gmail.com>
 <2026082645-stench-backpack-6e07@gregkh>
 <178773158689.1384029.3121943722878545406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178773158689.1384029.3121943722878545406@gmail.com>

On Wed, Aug 26, 2026 at 10:06:26AM +0200, Ruslan Valiyev wrote:
> On Wed, Aug 26, 2026 at 09:53:34AM +0200, Greg Kroah-Hartman wrote:
> > It's an invalid syzbot reproducer, if root tells the kernel to unbind
> > from a device when it is being used, it gets to keep the pieces when
> > things break :(
> >
> > Let me go polish off my "taint the kernel if bind/unbind runs" patch to
> > keep this from happening...
> 
> Understood, thanks for looking at it so quickly. I'll drop the patch.

It's not an invalid change, just fix it up to be sane and we can take
it.

> > Did you forget an Assisted-by: tag?
> 
> Yes. The patch was AI-assisted and should have included
> 
>   Assisted-by: Claude:claude-opus-5
>   Assisted-by: Codex:gpt-5.6-sol
> 
> I worked from submitting-patches.rst for the tag order and did not read
> coding-assistants.rst. My mistake, and it will be on anything I send in future.

Your LLM should have read that file and added it automatically.  If not,
you're "holding it wrong" when using those tools as there's lots of text
in there that it should be reading.

thanks,

greg k-h
