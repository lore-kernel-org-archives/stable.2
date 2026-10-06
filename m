Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C73D5222;
	Tue,  6 Oct 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326638; cv=none; b=Rhbs3wyeUmG2D2rKAYU+3LqhbIKZEngVBIo9+us3aTf5EbSrIBqaIn7KwUyxkTnmYgOJczXHbCAF4vkA1ftbHnwR4stQ9H8u+0mrcqiX8WMVNYhKoIOMJ7fuVCqkWgbalUjHRbUHJknc49sh1VrFSxjl9UBuKE0JL/OFbHrP4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326638; c=relaxed/simple;
	bh=Y30guEqmaN+fyB3nA1/y+pDwXoE5/pwd9+5Cn/oZzc4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VIWU6KxetbGCIrcYjPog5NVUMVSdx7TESsH8TJJjkovDRO/nJz4m2vXlVjCld2joeaja9miTToehMUkA4n4Mpzpxa/F5nLfgqJ0Z/Yz1zvNcTolKGJLtqkB7RR5Hbu/u2wP80xK3tLnWqw9EwKHFNUM1MQeGJYGOSF22cn5hoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ewhoLgus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ewhoLgus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63071F0089B;
	Tue,  6 Oct 2026 22:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791326578;
	bh=wH+kbQqqO44OPjLVUfEN8KMp7MAEqKGkdifBjveO3x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ewhoLgusei2RSq/WyL3pAvxlBnuhcfwp2wHIaw9X3IEiQCDcJYqi5ljSlWME50Qn+
	 1eMiXug0wlGvhPRpk3mz0GnOIszpjIM4kezpgeu1n0J/bFlhYJGjVGWHovl6rgPd5M
	 r3l+aoc+h1lgyOsg3/j9lEuPUq8htzIIJwD4u05I=
Date: Tue, 6 Oct 2026 15:42:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, David Howells
 <dhowells@redhat.com>
Subject: Re: [PATCH] assoc_array: Preserve full words when splitting
 shortcuts
Message-Id: <20261006154257.61196a7ca6f64b9a0156d17e@linux-foundation.org>
In-Reply-To: <asV3UaPsA2xSz8Cc@com-75606>
References: <20261006220638.32195-1-kylebot@openai.com>
	<20261006152508.ba7f3c7a6661daed4767a18a@linux-foundation.org>
	<asV3UaPsA2xSz8Cc@com-75606>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 15:33:53 -0700 Kyle Zeng <kylebot@openai.com> wrote:

> On Tue, Oct 06, 2026 at 03:25:08PM -0700, Andrew Morton wrote:
> > On Tue,  6 Oct 2026 15:06:38 -0700 Kyle Zeng <kylebot@openai.com> wrote:
> > 
> > > assoc_array_insert_mid_shortcut() copies enough index-key words for the
> > > new pre-shortcut, then masks off the unused bits in its last word.  If
> > > diff is word-aligned, the shift is zero and the mask clears that entire
> > > word, even though all of it belongs to the required prefix.  The new
> > > shortcut no longer matches the objects behind it, so lookups can fail
> > > for both the existing objects and the new one.
> > > 
> > > For example, inserting a user key with a different description length
> > > into a keyring containing enough full-hash collisions can split a
> > > shortcut at bit 64 and erase its hash word.  The resulting search
> > > failure can also expose the pointer-dependent keyring hash as a KASLR
> > > oracle.
> > > 
> > > Only trim the last word when diff ends inside it.  This mirrors
> > > commit bb2ba2d75a2d ("assoc_array: Fix shortcut creation"), which fixed
> > > the terminal-node case, and leaves non-word-aligned splits unchanged.
> > 
> > Thanks.
> > 
> > When fixing a bug please clearly describe the userspace-visible runtime
> > effects of that bug.  Including how-to-hit-it, reproducer, user reports, etc.
> 
> Hi Andrew,
> 
> Thanks for the response.
> As mentioned in the commit message, a search failure can expose the
> pointer-dependent keyring hash as a KASLR oracle. As a result, a local
> unprivileged user can use this to leak kernel pointer and bypass KASLR.

I googled it.

: In computer security and exploit development, a KASLR oracle is any
: mechanism or vulnerability that allows an attacker to reliably
: determine whether a specific virtual memory address contains valid
: kernel code or data.  
: 
: The term "oracle" comes from cryptography and computer science, meaning
: a black box that answers a specific question in this case, "Is there
: kernel memory loaded at this guessed address?" By querying this oracle
: repeatedly for different memory ranges, an attacker can pinpoint the
: exact base address of the kernel, completely neutralizing Kernel
: Address Space Layout Randomization (KASLR)

oh.  Hadn't heard that one before.

Anyway, please add those cc's and resend, thanks.

