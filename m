Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC92139C9
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696604; cv=none; b=KqDTm4wDee0POoqOs2XKuNCDiTB369SGs9B6JvpG0rfAmCb+EV70WUTDXysTkk3jjsY4tdBPknhUgv3li3sXG6zvpj6qskAW7hDbtT8ODCWUXJiFsa57y/fyMZdCvNj4kNo9c8U8qOFhG5ci28V7oao9dOr/dTmArhpY3vk2hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696604; c=relaxed/simple;
	bh=juRRSyYhBnrSn4n1u7S44/2D4HKkiqq9TslGeoCWimY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMwr9qMBmrMnDnXB/rW6zdI378YDQs8tensz4cgDRfr4EqW6LpxlbsYGP2eq0D8Z+uuzwETtMSLNYST2VP1lVoFySP1TwotWdkHolMOIF+Q48upBA9omGGd0HPchIwZ0iQri3BHMTBGil8ECOuXGfBu9qkdll1HnHlmSBrL9POc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA/KLYmN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA/KLYmN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so27361555e9.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 22:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784696601; x=1785301401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfEBwMTb0T8/mEZKR83LG9PnBynaSlP6/23toP1lQEs=;
        b=PA/KLYmNjQKRr4ticRVpZLrDZgcEr6QzJ7J14agOw0OcZxo3WfQA+WAHRI4f6xp2Dg
         trd9DrMK0ou+ZjztFKWYUlIQS0/G+KqxFRCZ/PWWgyGBb36mXCYdCctUr7v50CavhpFY
         TdQdHVzR+KNP7jeQ0uq2PQVAtUHtt1fEBi4EjJgnYoW28OC8mwpGbzgIH4ZIu7hy9Nq2
         WfqOlcF9O2nn+Rlv6sZfL3lEOsOErW8X5caLALgw2qzTZ3PqauZrCs7HlHk7GQVyZbQ8
         YkDLOpNP6cs5WWAkC6tYoU/DDkSvnPVZfa0IgNyJ10zv5gp19DbmwJiypFrIjeFAlKBa
         m/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784696601; x=1785301401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfEBwMTb0T8/mEZKR83LG9PnBynaSlP6/23toP1lQEs=;
        b=ahFPiBn6W4/ALX3dKDSsFTuYo1N/H5KG/N3p0QdvwPcuDZvFRYEpW0yjWP9gHDO93r
         dKyzfLgQolutx2YkoMIMKtmfSuGx4WmgrcZlAQ9FwCVTukSL86s0qTRVTXSXv14mIl6w
         AnNi/yNZIPlRW3vocPe0EYhqW/T92NkEbBQ9pOM6qIwHsfMtbUGpJPYGfBgeQuUOLFUH
         XqB6DjO6PZxVk/XzTQ8gIL2tzzW4eN8t+SmsyDK6HN1EHIWqNU+Mlfj+qNtVvXFxk8vq
         up+pBtDHM7YI/z6h4wZRNQXA4VialhEj6SztKyd+x39QqRzKyAj+41LoJGcc6ywF1EjA
         IegQ==
X-Gm-Message-State: AOJu0Yx3LDdy1vb7Gc3c0HTz40KXaUnu0kUEvmKgaNMKOnBs6D9GLdWP
	J9az3D/pwJJdsuuqh6FOcICRElpoTS41l8NVgW+HsibaY4jUAzl7gm9V
X-Gm-Gg: AR+sD10K4jfVrj2cJCm26EwIQges97mfJcJbrFTYCHVhB5515rTJ3fTyoexNISfDc1B
	nWuFbLOMd7sFakenG5vG+aMsaiMdPp2eF63OAlolvoGfPncICJ4HzBmBzuoURZiMjoNKOpI6WIb
	g6aafpK77Tx475U4cqot2qP9s7a8OovZ/d5Us6umAQdAlhCt+YrD3nV84n9tOryUtdnIqOzUBut
	V79X1QRnp2TfhwJu/mEz1c97ZR8u2I/WPxOsoTaAI95aT1eeSEtM0tnNov0svIML1Z9LH2SC/BV
	6F4ZdpZ7MsPerDrSMHxF2CKA/AHYbozxXwdFS9drGeDWcEEWEtfEunEw/etLOQf818D8/bOY3GZ
	mqwFhICXDH6StjR8vesnzlK+XQv0Scplqmvf14VltE12qJDYRl3aP1MLD/OxB7fQr
X-Received: by 2002:a05:600c:4515:b0:495:3af9:4cfe with SMTP id 5b1f17b1804b1-4954a40e322mr269127065e9.20.1784696600527;
        Tue, 21 Jul 2026 22:03:20 -0700 (PDT)
Received: from eldamar.lan ([213.55.223.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956d475e24sm6212035e9.0.2026.07.21.22.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:03:19 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id D1A90BE2EE7; Wed, 22 Jul 2026 07:03:16 +0200 (CEST)
Date: Wed, 22 Jul 2026 07:03:16 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Wongi Lee <qw3rtyp0@gmail.com>, Jungwoo Lee <jwlee2217@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: RFC: How to backport 920f893f735e ("posix-cpu-timers: Prevent
 UAF caused by non-leader exec() race") down to 5.15.y?
Message-ID: <amBPFET33odhDXb5@eldamar.lan>
References: <alVfR78eqdaRbOIy@eldamar.lan>
 <2026072148-saggy-broken-3ee6@gregkh>
 <20260721201114.0003-stable-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721201114.0003-stable-reply@kernel.org>

Hi Sasha,

On Tue, Jul 21, 2026 at 08:53:50PM -0400, Sasha Levin wrote:
> > > At least that would apply cleanly (though not yet even compile tested)
> > > to 7.1.y and 6.18.y but then already not anymore to 6.12.y, which will
> > > need more adjustments.
> >
> > These look sane, I've queued them up now, thanks!
> 
> Queued the pair for 6.18 as well, thanks.

Thanks Sasha and Greg. So this means now we can have a look how this
should be backported as well to things down the other stable series.

Regards,
Salvatore
