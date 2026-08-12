Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E13244667
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786496920; cv=none; b=BmAMnF93AgIp7QHH9R5kaNmqXJ6eVKdqmgWkjnQZTOaQFBmj1/XVRHb4cEoaWRB27584HDTVGC3RU86jmYHLkDrWIFAMgnr/vjDD9ip+diq4SFzrzkjWXVidBuY2scN3CzZZr5pfzX+PesYz645kIhzf7AJSzTzSJBzZfQJFPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786496920; c=relaxed/simple;
	bh=I6aJvhQDaPoz98wrJV1pnrAzrMqAYl22vSt5271RRdA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6F9p3PSIRBAqf84fJIzsrz8KkMaeyo9jk6zyxqnL0ZNu7Y7IwpTL2ZdEc0c/eDn/+QPfMuFGuvlfKawxaa64DI5Jd9ofaEgD2wAZhrWt8t0AxI5GVhGeuyipTB13pyQkjBTs4KNoszEA4hj6lCZWYnbYW2y/21z4StAZRO0TaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rfc2549.ca; spf=pass smtp.mailfrom=rfc2549.ca; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rfc2549.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rfc2549.ca
Date: Wed, 12 Aug 2026 01:08:28 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
From: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available") / CVE-2026-64561
Message-ID: <6T0kMG3on8gqQNlDZpl6PONhbz3R4vadrMJ2QzJu-UPYXvT1OfqbLyc0CNuW3_Cj7YojbCpo-dn9MU_Etj4npJkWbhZhPDbEvJsHUk3Zm6o=@rfc2549.ca>
In-Reply-To: <CABgObfbRQt1H5nEDzL5zCLPKdWDGX348+RcrZpmLSd9QqSJTbA@mail.gmail.com>
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca> <CABgObfbRQt1H5nEDzL5zCLPKdWDGX348+RcrZpmLSd9QqSJTbA@mail.gmail.com>
Feedback-ID: 126047231:user:proton
X-Pm-Message-ID: 85f8dc52bd32e5c7272a267abac6be27c54c5c1d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, August 11th, 2026 at 11:24 AM, Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> Sean already answered about the backport; I will add that upstream
> maintainers, as a general rule, do not have the bandwidth to check
> which commits are needed in older backports. The older the kernel, the
> more we need the help from the community. Especially with the
> increased amount of reports we've gotten over the last few months,
> *there's no guarantee that LTS kernels get fixes for all
> vulnerabilities*.

That makes sense and I hope I didn't come across as complaining.
On the contrary I am willing to help to the extent that I can.

I am familiar with the maintenance burden but I am not intimate with
the inner workings of the Kernel yet so I figured I would ask the people
who know.

> If your distro or fridge is running an old kernel
> and is left vulnerable, complain with them.

To be fair, Debian 12 ships with 6.1.y which is still supported and they
have 6.1.182 already.

My inquiry was about whether this particular fix should land in 6.1.y.
Otherwise, if this was still supported by Debian (or RHEL), then I might
expect the distro to manually patch or backport it as you mention.

I now see that the fix will land and I am glad to have contributed in
some small way :)

Thanks all,

- dms
