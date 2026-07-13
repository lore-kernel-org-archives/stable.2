Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277742DFF3
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950448; cv=none; b=dzfGDp5Gg0DpX248CxoIMm0dbpVYj0olhrEkMoY+zvdwlC7xdzFXOgbgBZj8cUm+sIyspcLevdXZ2Fo/ZZ7bBL3rdzjT/7SABvii4o9z9Q8/rsVQhnfOpDkwBNU+ynGjWr0Cf6tYUe0GvzmTXiwERe/1GP3R7IQcvd5HZbgpzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950448; c=relaxed/simple;
	bh=m3r23/EnqIHFr/YwnaZyYrWiafwQEeXhBtxLRj2wHGE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KCieat3zNgXI4HiXgQKl38PsJQgq7e5ODxUkYGAlFuv3itUooXrp0EbcFlUiZfR2kVy2KpeL0WEO9EUxAXOfnzYboWXJhmH44b+X9G/aaQ+WQIko6SLG7KSyOLpjCcSrPqM+ivPisw3YVkcx4rQmEMPA4S1F5dkOczV5HOepwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQEqLPnA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQEqLPnA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so2066902a12.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783950446; x=1784555246; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DidKVYu0F2Emj2o37zWQ67YKMQ/cqUiWa4PnHuuYDj4=;
        b=rQEqLPnA66c/evB/gTE7Ul4j7w0KKqILWVzTCTAh0WrcEsGsflq3XUxdRGiaH2AW8w
         UqFDBuaXC6DuPYqIlssVNaiKIUbCD7QsnoRAIHyzGqtKHE6XmzIxX3piv7m0thOnY+k1
         oQRM/flgQvpcNcazZsug1B3MoGsBj0bcBoRLD9H24604KLfKjkcAWgh51+brGEmTDUAG
         pEeSN0iOnq3V4Ypnq5rw8lgCGW8d8CvobFrViDKpac976x/5ddS6sCzohkKfq74xI75s
         M8NV5Uk7+aFXe10+u7SfKwk2KUrKlS3BM9DBf+FKKtAbUObI4n5gkQ7MkIj9q0hYYIKY
         ZH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950446; x=1784555246;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DidKVYu0F2Emj2o37zWQ67YKMQ/cqUiWa4PnHuuYDj4=;
        b=MoMobu8DIvM5NgEFfLwNPlGuXC9StLrC8CvqISW5ZlLsrxwWMJLjs9PlJ8XXaA1xkr
         sQfGOHENfzNu9AOq+LK40zdbojNeCmKMi0RZVQdBlX+cB/j/pZpjOSt+hTkmyE8aVrZ3
         DrUbTriiZoaPdIAFWps3/IjI9NPOKZOj10v4IoIJ5+17tjVSlJ/hNajPlPpvKUHHHsBo
         NmQvvRDki/WEl9+kqKg0Ii7rrQeTjUH6ehE0i0u/UEae4iAPVX8koawBPyH2GyHCOvmw
         JWB4+tZj99IsJef66tV+fkYVRJfe/6YxS+sxzLDu70HLRAo4C/3wH9K+6XvE7myyVlQC
         oWmg==
X-Forwarded-Encrypted: i=1; AHgh+Rqsnkm6woa3Iyc04HZEFENYkg9PCUF2uoNholauLU2tCDm5RtYeYcnnACHoX8IjtrKpvm8f0nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpteAE0UK8v3zE6M4JWU0piWxDH0W/5sAE6/rjcSJ79hvg0wz
	jF3e+JqpqIsX6PmUfLB5yrgXgRISUBOHYmXQe2GL8CD/kODlBWAWcfhm
X-Gm-Gg: AfdE7cnNzenmPI/9IjLbIsiEmuAI40Nw54BYWxUSn4GGRQYPEVL8IbYPOiHoHnt90Fy
	o+iQr95hAA/uPr1f0LKJtmuhUkXWuCauGlzTjKB3fMBVDiw9TNol9ztdJN3HroQP0pr32T5TPZU
	6/EeVbRu6wAtDEdKFG9MTXgrXQuLAIHcTogYrXAEWlZi+TcUxhdAY7j4qdlVp8vRKtUDmnLK2EH
	WCcqodwV5f4CPXZIgIzTRcP7l1CdUvpNpUnk14kwPD1jruubbWDpzMN+Lk+negPSmYx/RicJu0O
	H673tKC+N5cgEJ6rTCz3tFG643DpYj4DtaEg6Lz/tNIkhrLSyAGePyQ4QGYb+fE5OmKI6376Ynq
	6FrS8Ndl50GfA4LxyZqdxWErW7TMgeDBjz1s6iKShywcFQ940wY5RhKXsv7eRFyLfSI9pE+3XIp
	1U47HwM9VuDmc=
X-Received: by 2002:a05:6a21:3383:b0:3bd:229c:dcab with SMTP id adf61e73a8af0-3c1108b490emr11781651637.17.1783950446099;
        Mon, 13 Jul 2026 06:47:26 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm71169157eec.10.2026.07.13.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:47:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Paul Mackerras <paulus@ozlabs.org>, MOKUNO Masakazu <mokuno@sm.sony.co.jp>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, stable@vger.kernel.org, Geoff Levand <geoffrey.levand@am.sony.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
In-Reply-To: <20260711130931.740719-3-thorsten.blum@linux.dev>
Date: Mon, 13 Jul 2026 18:08:56 +0530
Message-ID: <ik6jukrj.ritesh.list@gmail.com>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thorsten Blum <thorsten.blum@linux.dev> writes:

> If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> decrements iopage but keeps using the failed mapping's offset. As a
> result, it repeatedly tries to invalidate the failed IOPTE slot and
> leaves the already installed IOPTEs valid.
>
> Recompute offset and invalidate the installed IOPTEs instead.
>

Nice catch! I wonder how did you catch this?
Do you have ps3 console where you somehow ran into this ;)
Or was it a manual inspection?
I wonder whether PS3 consoles are still being used?

> Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")

Looks like this was from 2007.

However, the change looks good to me. So:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/platforms/ps3/mm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
> index 20fc5b68faee..315a32fd75b1 100644
> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> @@ -615,6 +615,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
>  
>  fail_map:
>  	for (iopage--; 0 <= iopage; iopage--) {
> +		offset = (1 << r->page_size) * iopage;
>  		lv1_put_iopte(0,
>  			      c->bus_addr + offset,
>  			      c->lpar_addr + offset,
