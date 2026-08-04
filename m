Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC8466AF3
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851892; cv=none; b=FkOcMpTBN/0bsGOh03CJwMCvVlobfD4j69qAWzAL29cnM6Q2cSnYdHAZgBgpBtyw/z3Htd6J/k6YJSeW7429wZVyXsyWIdeP89uxbHOL2rjnIxKLl8cKYGDKSo0hbJIhfESus+WdC3MschvPmT1dYsot8muKp//Suq9upIZ2O+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851892; c=relaxed/simple;
	bh=txGfUfO22TGl/v7WcQ0mKQmlhCK0ZJom4iJVYi0p5go=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=i/sUds9xczBUTWS88VEavqnnWWsu9xDpTEv832mxzrNUVDBYDV/rgOyBKKpnahrGw8/YYFr3sLTkckZtHIXmpQd5L2D1oeP0z+U1/NdgHiNYbCKQpw5jdAUUIXUW29fnY2kbnpDkmbOm+A699itQ69t6JArqj2LuehJHLeQB8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=vHukB/HT; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="vHukB/HT"
X-KPN-MessageId: 5bbb6a80-900c-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5bbb6a80-900c-11f1-8f54-005056992ed3;
	Tue, 04 Aug 2026 15:56:57 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 5bba2d42-900c-11f1-ae90-0050569981f5;
	Tue, 04 Aug 2026 15:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=dBsWrMLZ9IzD0m3McaFDhOmIT6EBYDLLbBBMJYpe3Mw=;
	b=vHukB/HTeJw5AIc2orXHKliiewULrRD+H2BHkbgUGkMyICHs48Z1HYymYTA49kVAuzPxT67Dbb1K9
	 vr2FnEIo8OtKaCs6EiHHnCmoeRrsmtl+f/s8mJUWdqEWl4Wklmvz553sggQw0drXhgAWdloZNSOeky
	 zAaLl9dkxBnGMJz73yYKt6L6rbYVX5K3UQLQMWHg28T1JSo5cv8/w6Erh5p6MLv16fCosf+gvUGrgM
	 uCTI5cUqxdaBxNALkjxqpBESqWfE5DeVNzklgwnvkCyEhwJZerwkhKHbVhbJAPsqKcVfqjc3AmJpVt
	 FvoLgeFRy6Pq3oPSVZn4wGNWfBzQbFA==
X-KPN-MID: 33|bSkcPgtBDk1gKMWgyA3HaTgwp6j+zKz9P/adMdjVcl8l9WJ1SXLkUfRWBhItrmf
 T9Nv4XDLjbSYhTSbUAqdk2fX/VT7tkRiSp+eUOrKeWoI=
X-CMASSUN: 33|LAGBz+PPp1YI5gX1WJ7hDWL+U1+b6MeCFoghNwngiaSKSBfbBbaqbo3yaZ/Wah4
 E+avM+Ydyes0tBkWiZfWg5Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5bb4102f-900c-11f1-916a-005056995d6c;
	Tue, 04 Aug 2026 15:56:57 +0200 (CEST)
Date: Tue, 4 Aug 2026 15:56:57 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Daniel Palmer <daniel@0x0f.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, corbet@lwn.net,
	daniel@iogearbox.net, farid.m.zakaria@gmail.com, jack@suse.cz,
	jannh@google.com, kees@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, mail@johnericson.me, stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Message-ID: <1267570591.181935.1785851817769@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260804134225.3631912-1-daniel@0x0f.com>
References: <al_MqBrjDW1QjRau@daedalus>
 <20260804134225.3631912-1-daniel@0x0f.com>
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 04-08-2026 15:42 CEST schreef Daniel Palmer <daniel@0x0f.com>:
> 
>  
> Hi,
> 
> Sorry if I messed this up. First time replying via git.
> 
> >Afaict, currently read_code() may blow past what vm_mmap() allocated
> >there, which may result in memory corruption for a non MMU system.
> 
> I ran Fable on all of the "nommu files" and it found the issue this
> commit fixes and the above issue,
> I sent a patch (co-written with fable) and we proved this is an actual
> issue on nommu via a reproducer tested on a real system.
> 
> https://lore.kernel.org/all/20260710121443.1059549-1-daniel@thingy.jp/
> 
> Thanks,
> 
> Daniel

Charlie Mirabile made a good point to me about this, namely that on a no MMU
systems, if a malicious elf can run, you are basically screwed any way since
there isn't really any memory protection. I don't know how much worse it is here
that you can corrupt memory, given that this already assumes a malicious elf. But
I don't know if no MMU has any other protection that would make this patch useful.

Thanks,
Jori.
