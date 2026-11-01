Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793500859;
	b=4+vGPiR+a65pS0R/7VpKK0DV9Fe7/+UlhfHJdVOPqrlvDi/Z9DFTqaCSt5jcYk5wOwE8
	 RHVlpyfEXTIG0+BCL9wYKpB5CKxavhyXD8lpFfV3xpch+6KREaMpPNMyTFAmeGca7R302
	 SNbBKO7vV4FjDwzHXWaBrhx6qMRzYw01XtaVVOR+irwo4dtI5gpfWOpRdJvw/9OyocwNR
	 W7yBFDB54u/TOuiWuUBWb50eQyEzuxoCxNzf712tUuxUfNvCrFB8UwxqPpaucgaNMrYZG
	 OZhtC5sE08la5fREN+FtjAFtL/L/TrTKwz3YCku3SMXJYMkrDLBSwD1HFK4in95iLgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500859;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vtgNBTDMW/DtrGtv/8hkAbq35pBY5cFFg+9Km6ShdQ4=;
	b=xyIQP2bVYkNU3LW1Xb9dtwkkfB0I0suQsBAmIHoMQyiu8NIbAxXF3UiHnOlyHVBO7nGY
	 ccT+djIady4lGn1mLxuWaoTsHy2g6u+zPT9G60byBn8OcDsCEqKau93B4DLxsVCmCXipS
	 U++cXtEx0IZuhPLajNm1FPce46rgn8qYHP8x78WrcJnRdk/f7KFSiFNzVriKBXEbAjAzv
	 ghywlGd/ovc/oHgMd5SszyKDx3lGO01n4LbA3VJS7pbzWC2yDJ602Etgnri0dZ1Mbor4f
	 l6P0/swiAW9zhCiseKPPjB3OD9EDVK3iQkEK8UAWxXh98GFPmWqSD7pBK1BsX12pHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=w8ubrdgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD81606A324;
	Sun,  1 Nov 2026 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=w8ubrdgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C41F0093A;
	Sun,  1 Nov 2026 02:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793500858;
	bh=vtgNBTDMW/DtrGtv/8hkAbq35pBY5cFFg+9Km6ShdQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=w8ubrdgQ1H/88s1oR8DPOKefcURK6dl+7lDkz06LB+py/vNtwV5SmJt623XeYDEPG
	 MmQJmYnC4dazZopFbfUqdgOKXd1qQ5jzZTsIGyf5XJsbvppfZbm0CCL6SFvmZzHExJ
	 h2qnSkEyYWst05ejBOP+EHuEFy/ccuXV1qGDpCnI=
Date: Sat, 31 Oct 2026 19:40:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Andy
 Lutomirski <luto@amacapital.net>, Chris Mason <mason@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/gup: check folio->mapping under folio lock in
 memfd_pin_folios()
Message-Id: <20261031194058.d3bd25ed950e5340ab595f07@linux-foundation.org>
In-Reply-To: <20261031203540.2282507-1-skhawaja@google.com>
References: <20261031203540.2282507-1-skhawaja@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 20:35:40 +0000 Samiullah Khawaja <skhawaja@google.com> wrote:

> memfd_pin_folios() pins folios from the page cache without taking the
> folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
> its refcount check while memfd_pin_folios() still pins the old folio,
> and the caller ends up with a folio that is no longer part of the memfd.
> 
> Lock the folio and recheck folio->mapping before pinning it, like other
> page cache users do. If the folio was removed, retry the folio lookup
> from the index that was removed.

Can we please include a clear description of the userspace-visible
runtime effects of the bug?

> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Closes: https://lore.kernel.org/all/CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com/

Includes the words

> The issue is live update doesn't preserve those background punched
> folios and now we have created an UAF attack on the kernel across
> kexec if you don't do something about it.

Is that the extent of it, or are there other effects?


