Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DB3C0A09;
	Mon,  1 Jun 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325366; cv=none; b=OZXg835D6Ol6NdM+Zn0Cn4nsOdOf86YbNmX3ASe4l1FSG2RD8Piylph3CQuKbRAeV+KYMJM6eKi+NaLEtAy4a1C/2O8Ln3bOuyFKwz83KlhoUkmOXZBe6UGbbmqqLcLff4/nUOak7kb0s+qRHCvBmAifPqsl4J1mN4j18XX5VwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325366; c=relaxed/simple;
	bh=kZ5OxWO2kZ388paquAFYEV27oj5G65NxfBe2aFI264E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwdQDdFvIRS3VSPTr7ytJxWmfye+AQPe9dJSPj2sp5LApPD494QYGaV5hKl8YLObRnZmAyAjurkq7chfSbCLCfAIjLc11fXUdCazk+iATyeFMnWJNz29tjRdBaBQxrAL9gm/x93oVFaiiAPI/CP6ibrbpm+nkdeGYixuRUMbKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nSTXygy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nSTXygy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDD41F00893;
	Mon,  1 Jun 2026 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780325364;
	bh=vtAPGhX+7U6INxMjiC0kcWet3yUKk+FkIZBrebt17S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nSTXygy/SJrNByVtwvIejbN4XR3LmSSXZ4kq+HExuHJ1OhBJ/+/wzhuoKUardphy6
	 Nt81S2cw02XNox+GNQhajrGlx8/EkWONaSpmGENQ+sMIVErckct5nReaTG5y8P1+pH
	 49ZcEL82TzGvKf4I+LruqQzwf50VuljwAEMUDbMs=
Date: Mon, 1 Jun 2026 16:48:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: boz baba <bababoz943@gmail.com>
Cc: stable@vger.kernel.org, steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: esp4/esp6: missing skb_has_shared_frag() check in
 6.1.y (CVE-2026-43284 backport)
Message-ID: <2026060157-throbbing-antarctic-5e7a@gregkh>
References: <CAAB7JC+TiyF6-1uvzhOcJ9KeDUhNgLmXk8unHNogY156xSu61g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAB7JC+TiyF6-1uvzhOcJ9KeDUhNgLmXk8unHNogY156xSu61g@mail.gmail.com>

On Mon, Jun 01, 2026 at 02:31:48PM +0300, boz baba wrote:
> Hi stable team,
> 
> The fix for CVE-2026-43284 ("Dirty Frag", commit f4c50a4034e6) added a
> skb_has_shared_frag() check to the skip_cow path in esp_input() in both
> net/ipv4/esp4.c and net/ipv6/esp6.c. This fix was backported to 6.12.y
> but appears to be missing from the 6.1.y stable branch.
> 
> Affected: linux-6.1.133 (latest 6.1.y as of 2026-05-31)

No, 6.1.133 was released on Mon Apr 7 10:05:54 2025 +0200, there have
been many many releases since then.

> Fixed in: linux-6.12.91, mainline (f4c50a4034e6)
> 
> Vulnerable pattern in net/ipv4/esp4.c (line 912) and net/ipv6/esp6.c (line 960):
> 
>   if (!skb_cloned(skb)) {
>       if (!skb_is_nonlinear(skb)) {
>           nfrags = 1;
>           goto skip_cow;
>       } else if (!skb_has_frag_list(skb)) {   /* <-- missing &&
> !skb_has_shared_frag(skb) */
>           nfrags = skb_shinfo(skb)->nr_frags;
>           nfrags++;
>           goto skip_cow;
>       }
>   }
> 
> The missing check allows an skb with SKBFL_SHARED_FRAG set (e.g. from
> vmsplice()/sendfile()) to bypass skb_cow_data() and proceed to in-place
> aead decryption via:
> 
>   aead_request_set_crypt(req, sg, sg, elen + ivlen, iv);
>   crypto_aead_decrypt(req);
> 
> This is the same page-cache corruption primitive as CVE-2026-43284.
> 
> Please backport commit f4c50a4034e6 to linux-6.1.y.

It is already in the 6.1.171 release.

> Affected versions: linux-6.1.x (all versions, fix not present)
> Fixed versions: linux-6.12.91+, mainline
> 
> Verified by: source comparison of net/ipv4/esp4.c and net/ipv6/esp6.c
> between linux-6.1.133 and linux-6.12.91.

6.1.133 is very very old, please update your tree.

thanks,

greg k-h
