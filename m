Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8142252E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927140; cv=none; b=ju2AxrgSx7O5W0UScFJz1ogCGRGTol2KpMcoVMxv/SDW5ftAs89VrMUpZUNAl7vVrSuZSdui5iMGcZiyhlVjSXSh7WqYeLe2+T602szgWvUA4+zrn/hOuuzKxzAFIrWZBuJMWjG/zW488b0xzu4LFZAIIX/SJp8P022P2YF5alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927140; c=relaxed/simple;
	bh=eP5zT19otmavZYh5jnGMqz0ktdAeVJgmyjcd+gz8ImY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJeG7t3uDnR6CCBVOhlapGQ/cXzFUDI8J1R9J+zEMrDAgxNrqtKxqVmEsH1GYOqDO534fESa9H6I5/VyKwXEofZwS8gQMf5kbe0+30b9IXXPBhqgVxf+BL5/ptK11MHWmneN/od4UD478S52+FDX9Cn5DPcRf77Bmhcvz3zVFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V0u4IeNp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0u4IeNp"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1007773b3a.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785927138; x=1786531938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=41H3P09sKw8wwkKnWV642RHA7jFSxWcxJqByp/NmDs0=;
        b=V0u4IeNpm0UBpYa8FDO0F7/a5R1KA1+Wpn44fLWP5imSktgLrFafUz1pXukG5ttxWk
         GHqaKugXaJ4P1Jl6HLJztnU/JpxaghXo59+7I5THv0zLn8Y7ZPTkT2yhpMmdoCxmM/0d
         8l5uUACRbbpoNAzbMoSEZcYrsjh8HTLLRLIxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785927138; x=1786531938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41H3P09sKw8wwkKnWV642RHA7jFSxWcxJqByp/NmDs0=;
        b=Am+ElmlUfZEJ4gakGeQg09PoE1fDM5l3l2Br2bNKTDajxRr4HPkxzBk381EN24F8Cw
         DPfGo07kOx23tk53q6Sff79qNUg0X+yyASrZ3QQqEIHmmTaNUyE+pQZpeo1e7HBcUrej
         w3Ik/w/nyMCg8w2b+2EUD8gnKYdkX6ZdX3WjQd3clcVyGFPTBy1qoxyCkxwCH4H5eXl3
         PbA+F9fpNomvEBdEG7axkIBJv0ApPVJ7rrjEkJ/emKUpRimMW5efv9DvZO+a5RaLVjBR
         qgd1pqkGESFEqn3Ek0H1vNL1pawGbRsyyVuBbwjo5LqQTpAfskQigGH4zY6mUia+T/Bi
         4kfA==
X-Forwarded-Encrypted: i=1; AHgh+RqHOOkLvAVIy11LBd1zjIfAUNis5Uqa5vUYXjQxYsYPwAAcMEwiii20T8QAYfd6HNG+1WPDdAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFr+ZEkhSPtYrD50E2HEx0yvSYvwNld/g6PMPluTjQ4Xy6+iy3
	HIANWFkQc56BX77OXTJheopzw8ACVicNQLSfvOBf/GUHDMPmIGwaU2UbC/TgX+eDoA==
X-Gm-Gg: AR+sD108ser6BNmAdXPQL2np2/Lblz2PQESbiZmD8iM/1RyJhOq0OVddXM3fS0T9Qbv
	c0mgd3F4vpPB5qe7dHD5mXh7RFIviH3xjC+1X48MCIEKVGtndhX6dCyFmYoh4ZvudzUVebYjfdh
	AaA48j7ODUT6bY81yTOb2pvAbqD5KIuwL2KCq6ZyM5hPQOd7nqJtH38rqn/Aa5BzmK/ozqHrA2E
	TZrHkF3yWcIJfEgvJawv/ZYWvZ8sXyqxrNCg9TUoMdbC7K4cMcA5F71rTH6LuRgwOixU+b8DSmU
	LG4hMXbTta2s5T2Iwq5FluUjVIpjgABWDGXfYMeJBqFKmIxAD6XS2StyidYMX0Lnll42tCtUz3A
	fXpLtsoid1Un+mmfpYZ7fGcJKUkTcfwLcx9PnRwR3X60pvgr5z0iP9515LSiyQJmuFX3ySM3Uot
	ltn8Esc/OvYn9gxT3ni3GV2i+xc/wihydTWWynI1MC72Nq8NO1bPYOmxM/x/pm6EPAlT83nOBqE
	gJ040honq7VgzJNj95jd+VowDiGK4tYfDNQUBU=
X-Received: by 2002:a05:6a21:4685:b0:3c4:3321:4fe8 with SMTP id adf61e73a8af0-3cb85dbd1ffmr7117853637.14.1785927137918;
        Wed, 05 Aug 2026 03:52:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708c0e7fsm1281577a12.21.2026.08.05.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:52:17 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:52:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: freeze device queue before device reset
Message-ID: <anMVoqIwmubZj3wY@google.com>
References: <20260805021854.1057715-1-senozhatsky@chromium.org>
 <anMQTJeiBZUHX2Y_@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anMQTJeiBZUHX2Y_@google.com>

On (26/08/05 19:29), Sergey Senozhatsky wrote:
> On (26/08/05 11:18), Sergey Senozhatsky wrote:
> > Device reset does not take into account in-flight async IO
> > requests so we can free meta table and reset device concurrently
> > with those requests being executed. The block layer guidelines
> > indicate that queue state should be protected by blk_mq_freeze_queue()
> > during teardown.  Freeze zram queue before device reset.
> > 
> > Fixes: cd67e10ac699 ("zram: promote zram from staging")
> > Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> lockdep doesn't seem to be happy...
> Let me look into it.

Actually I need to look at the report again.  I suspect that we
maybe don't even need any patches for that "async IO vs reset"
sashiko report.
