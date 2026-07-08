Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491B43E487
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519591; cv=fail; b=AjuDxXeBnZCnTiO9QLlMAKRBh3whDLgIV2p7s/9KOZO9yUL2z+ppk+WEvrAncLITLsXBf1KsCf4UXTnfTZ9eUlY+GjyrxOXEif0V2R4vH+72yzAmWqMXndw1OgHBI5NbHURTExoKX89olTcRHM3O8uJ/vG0R5WDUYCf1mDy8IZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519591; c=relaxed/simple;
	bh=r6qkoDFD72aNqg7YZ/TcrCwk9wBfbwfACZvk0C3Ml6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHMvDyTvWhsduIMmAz3oN+kV8hQHpK+2+J9mmW67K0HZLFuuuxOsh63yjLALXnO/VUpMemGAPru5HPljHFg2hVtpuWpmsD2VhPsze5rjisIGk+HiGvHg7RWsNYjm79wLaM+DspbkJKtq2vq9DYNWU9NP2kQA8vAVe60WH+B67og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=lE8Z2gv7; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=R7F3XTsL; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="lE8Z2gv7";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="R7F3XTsL"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1whSur-00000009bPa-0qcI
 	for stable@vger.kernel.org;
 	Wed, 08 Jul 2026 10:06:21 -0400
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5aeb9e6a8feso558554e87.0
         for <stable@vger.kernel.org>; Wed, 08 Jul 2026 07:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783519580; cv=none;
         d=google.com; s=arc-20260327;
         b=UvHVIOurJg9vXhjGCE/RzM4kkzR2sBhoodI+22ugkCqZspxjItAePB34dY4vrk5MNE
          X248OAnn9m6Ghek/sWMB2PMj4Q/qyufKyymvnFfGzN5miD72uGRAiMj9XJSPmg4yYzbC
          bzrPUJnFVADh2RiuEOl5nJJ7Ag8DMwKkdXMA7Ct4WsHAvLu/ypMFbTXiAG02qZ+8OuQy
          TmCeICcGBKHx369fz/AE4O6XW9oMAlqffcleBfrW1xhQBgng/jAaoU3ZukLfZ8taPmDo
          /slHmWCJddgJLwy3ozdhhV4rW3S7mLTjA/tQ60To/Euu0cO9il3SIQwfSW1dzNvzkrbR
          uYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
         fh=36Y8giqmaOliUfICM7Lqm9pUm4hz8zsEJnXblybCYfs=;
         b=n+rSKMx1HJno+UulkJTe0SWdSAZOuubqod3hLh+iNl4UCTaMSTwWh9h2xGZdZ9ivWB
          wZOAmh895eA2zWWaiH27vI3P2s4v6nv5sXxpXKZqnjlgUnH64T/vgRrRCroTaUc9AcWZ
          MztMxsVxlZMKgBlC9kKf8ZgzDhkaCQGcniuj8eye+jO1uIR46KC0b7OAdznKH9VBs1/D
          LtJ8oOhhhSmMombbeuu8/djiOy+dCsgw+swyoKp/Iy9m21gFShGBOBEu4xn08yyXzQac
          +EUzQaLdwYe4tqvNoiiYPQruAhqp7O0fEI3ggEsLfVIkYEvaA8DbyFw6jb6593uhf6gk
          L55Q==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1783519580; x=1784124380; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
         b=lE8Z2gv7oj5Ovk3l/pFTmLrZRpu7sQE2mBQhJe7OcfbAg1B6TTeRF/zoF2s4ydpLxD
          SB8oCZAtyz1M8fdaHpfyG5vADe3FuhNqQCXfqK9Bmwzij63hcrnEADZJtg8xsjlz6Em/
          n8YnZSkFaj67oW1KJ9m8X7sptrgvwQB5igpf4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1783519582;
  bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=R7F3XTsLVilWOG5j51JgnNa4E1RW7g7V5i5n+KyWK1lC+JwddXhuqDtExr13RgPjY
  2djTLbL1jIhcrloBUo1SSKYFs9YyZrVjr9wWmXR+51u7CnOQpcUcFliA5vRZkhKfri
  kFmvPx3nKp30YQjYohLinCkG6uM54x6wfmTu+2+Q4gPddPeB/R+3iMfRd+2MSIhwN/
  Ja3Tu6WFm0ZB7Ii/4bS16cp0NopsOIGva81VaZS11GdjAiWYT02BJA39W8yYk661Fx
  cJovsgdpkQvGiWJyuFnLc5vdGdO+lT32pVMiCfCPZnQQQKU4h23TrafbSzeeyUUsBn
  otr1wHt6V6Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1783519580; x=1784124380;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=PXZNu0Za/OOMa318wr8xs0J+7OvkEgNoNQGLM6QdaVo=;
         b=ElgTZhwe21HR5ASFiz3MSmJ3ol8/8+CfBkyGOuy+8X0issyRfOY/22Sg/RbOhbc0Qr
          jc+u0oGvuwSFoNu58HdHD3aN0TTBx02v026AfIdvCzqxieX/8hq/vmWjvXym7QEa0CRf
          HMIqvW3bDYpjE30TTOUJIKaJwmURE4yIDH1j50M0uBC8kd7BF/EY1SOnKemwgGc2ZxBq
          2r1Faiq/EDCAaS88Um+V5+dau7aX/Le9cqELlRMtDeZPUKsuaM4HV7hhtkMhvb2SeA6N
          wSsqGdH/F2nfXNfRv3O4yzlKVGMKm2KO6XPZtXzC6TsKlPnQCejNWnILrzdnbIkNWLRh
          4nXg==
X-Forwarded-Encrypted: i=1; AHgh+RoRaF9cxPtRIZJvKPwUgC3kKtziuD7x2PZ/gnbGwq3vdewuDtjchPF/lGMT/qYX+JXKC9C07JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTEieAfqVoD6ab8PraoranvZ/CiWtg58xqK9lVwNUYInDnHmE
 	s7FIbHGhsAiTuZ3BD70XIDRXK0noyew78moijc47KyjnCDVl6yY0lJetDz9fkoxUgyNgexSc3lo
 	Y6uTzOr+nxkCQF3b2U2FwI/jG7m4O50u/oMORwk+YgSeRuMeLn7D9PduBQmnh9fm12xCjlA/84T
 	rRvx2pfuonSyFPN8uX/PzoUcq5tTGS3Vo=
X-Gm-Gg: AfdE7clZtfrXC8MtfIR1VSsd/AcSqV9TGloLO4inYkZ/spvEH0u/4pDTWD6iIof7ejO
 	+Cu8fIqVX0kwbzGZT7cft0UCn3oP7Jgq5t4cNHVb04bzeYrDTj0nJGXW9RJxrZkGEHvfHTUM2FT
 	hBgn5JGpk12AM7ES5xO93FqvmoNmvJYktRHhsSTAttiGM+GnlC9hBWeQAszdzPseK1PwE=
X-Received: by 2002:a05:6512:340b:b0:5b0:11cc:2284 with SMTP id 2adb3069b0e04-5b011cc2571mr701634e87.21.1783519580571;
         Wed, 08 Jul 2026 07:06:20 -0700 (PDT)
X-Received: by 2002:a05:6512:340b:b0:5b0:11cc:2284 with SMTP id
  2adb3069b0e04-5b011cc2571mr701620e87.21.1783519580206; Wed, 08 Jul 2026
  07:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702165409.164568-1-pfalcato@suse.de> <akhYu66GmjyM8l6a@casper.infradead.org>
In-Reply-To: <akhYu66GmjyM8l6a@casper.infradead.org>
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Wed, 8 Jul 2026 10:05:43 -0400
X-Gm-Features: AVVi8CeMh2pp3lqKg47ZNV-_AiaErtleKM17gc2gMeTGtO_5NCmQTr7BfEwc8Wc
Message-ID: <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
 	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
 	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
 	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there, just checking on the next steps here.

@Pedro Falcato Are you currently working on this patch (mentioned
above, re: holding invalidate lock), or are we perhaps stalled on
something?

Thanks!

On Fri, Jul 3, 2026 at 8:50=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Jul 02, 2026 at 05:54:09PM +0100, Pedro Falcato wrote:
> > +++ b/mm/khugepaged.c
> > @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm=
_struct *mm, unsigned long addr,
> >               goto xa_unlocked;
> >       }
> >
> > -     if (!is_shmem) {
> > +xa_locked:
> > +     xas_unlock_irq(&xas);
> > +xa_unlocked:
>
> Hmm.  Before this patch, we increment nr_thps while holding the i_pages
> lock.  Now we aren't holding it, but we are holding the invalidate lock.
> Can you put something in the commit message that notes this change and
> argues that it's totally fine actually?
>
> You were good enough to not point out that my suggestion of calling
> write_and_wait in the existing !is_shmem condition would result in
> sleeping with a spinlock held.  Silly me ;-)
>
