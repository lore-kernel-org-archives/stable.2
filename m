Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647C40BCCA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541169; cv=none; b=clMp/yNCG7zHQ+VV69XUcuAkFUrqDIrWvkY7zmDQ9vG+XYu4Sf0ENHSkKXMOO4/PfxsMwNAbLm4iPasS71jbdxLX/CwxLvsByvQ9ym7EUtE6fbs9O03LswQGRRPXQ5cTUnUisfiFyBWGRYWyjJ0SvfzKSmNbJ6HRp/PWoyz6pEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541169; c=relaxed/simple;
	bh=w+yettWEbO4HQd+AjKTwc0Fx05RcuCUOYg/X93t4kXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Tbk//wtNJFWTOJ8TTRtccAshNKAHWK4uzmV46RGOkaKbzUs4fb4QRuBJGqstYcXagP8krN65qiLqqReVrKmSfvNVmtDXDzjRIK3gE+IDU1/UyBHunf/DHa6x1lADq/Ekamf9W2F2iLUYuF+anicO0jIPChsoPwqChPOvrPpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRlQUlho; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr3yHJw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRlQUlho";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr3yHJw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781541167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bem14i6XFVMIN3uqnQMz5GECQrxxG7BjUnzzU6nRLFQ=;
	b=eRlQUlhokSyjsW4CyFNCRcYuzbVlc1eHEFTn3B3OdwW4ap/k0agUCHxenNa6ScARkHZesT
	z3Ti6cvUgscxEYjLRpdrQftlvqCofFLVTlgTqC7QCPKOjtzOnYeN3CNcXdXaJ78QqgIvMY
	f777fzDVXCNqX9ecnP+yxI0lJf8Ayjs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-GKC55TsOM6-FEVGVJ64YKw-1; Mon, 15 Jun 2026 12:32:45 -0400
X-MC-Unique: GKC55TsOM6-FEVGVJ64YKw-1
X-Mimecast-MFC-AGG-ID: GKC55TsOM6-FEVGVJ64YKw_1781541165
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cceb5a9686so101583766d6.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781541165; x=1782145965; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bem14i6XFVMIN3uqnQMz5GECQrxxG7BjUnzzU6nRLFQ=;
        b=Lr3yHJw2/XQG35P/BCQKt6nbkNUr/9hEXbiguf1GZz2iBUYNEmay1ZdhfEpitrHvsT
         2RB+PU46xhViApqjo6u5moFQL+VTeP817kYDLeWqkD07wydzCkzvVlznj3egMmcnkPYs
         IExhm+bvjhreaWZgAd0yD0XRJDeJ+QSsc6bKS/nilbQVmoKCCV15f0ZQlJBzWtz8xw+c
         B/ci8ZGOVjpRskfApoBQaZcCZgqm4Wk4G9ZyDKYMYWzJXY1t3VZFAhoDuyFZYRjMs5+V
         1WU8tK2JkNn9A7sCLjkjWU5q+fWzPn4YXvifqPbt5pPjNhOBJvBMXvFEfKDdX0Rw+VzT
         OVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541165; x=1782145965;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bem14i6XFVMIN3uqnQMz5GECQrxxG7BjUnzzU6nRLFQ=;
        b=HoJzUTjS0wXiYTTUvzQihUzcZamWihEdwMm9jgy0dXckTIv1GNkGpsYRBZA5wbAf7r
         tM3MS8FisL9oB8rX83XTPfXf5HOLKEOY/TU9P/zwLzH0Gk1Nbfhl21gXyXZV0y/GhxuQ
         EsHIgTaXM2Kjt/VZjSKOCEVgOlO5vqCvlIjDizeBXLTG6sAmyeSN/1IHkktPabjSKeHj
         8i682TwYmi4/CB1dkkKe+WbYgF5N93HwbFOMWAG9KvXfdKkeuNwKRyYM2D3roa2Jd9AE
         bSYtC+bIbfcaw8weQhfNKnk9C3bOJZRlQyU7x/DLtlcYgvNkcyCkx9Kcb06v/aEsQ4hJ
         Axkw==
X-Forwarded-Encrypted: i=1; AFNElJ9p4MAGC9XDDCMnn/TPzvMssgwiDHi2RXAGnuHV3CSLziHUiC0xwHTFB5msYSnry89UBtt/SY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmxuiraN+ZM8Ouv7NX5Y8852Veq/862DBYZVl0LLiLMIPpMbP
	IGRouellhKvxYXejlS+/cQExIHkm65G1kni5AsC08ne5oWWzAribkF0MejYeF7X3ZzK9b7OmvIb
	H8BWjP8HKbh5JquoMGuLlb3vh7wUyQ7uW09IM/QIB7q4I/P1qLX4FqmG/jw==
X-Gm-Gg: Acq92OHrRs0nWK6U4JVsu48ehSGwpMDhYteyyHI+J78uUO/7Wju/+llzMtAGgvAEnew
	8WW7JcEMQkN5eLXXojgg1aLxyZHTl7GY/WGEOQ/txui5a0V/V50CONrU36+EtXQoSgAU+sFaD5c
	DHXwUiSM+aMo+2Yu9pq6kLGfu30pdMDNk998zKc0LhCkpRT02PC0m8Rr0p1sNisYVSplBYGDO7A
	IHOv9qSMdYRC6O8J8DdvPhX/U+wsxwRQoVtweIkojaC4E0DFxiExkiF5sia7LT7uRA7s0Ru7h59
	BGHGClTlMGWs1L86MpDvhptx/qhTvGrlvPWSpwXqBCZNCCp9eJGIisXsWJaa86nu4Ep/zgBEkEG
	6KWe/o7jq8wxzgd5FoAHI0deKbdUHU9N5g0hu0f2rzbvlKEhTy+p/4LlB
X-Received: by 2002:a05:6214:4ec3:b0:8cc:ebbb:8bda with SMTP id 6a1803df08f44-8d44ffc4615mr188041846d6.39.1781541165103;
        Mon, 15 Jun 2026 09:32:45 -0700 (PDT)
X-Received: by 2002:a05:6214:4ec3:b0:8cc:ebbb:8bda with SMTP id 6a1803df08f44-8d44ffc4615mr188041396d6.39.1781541164605;
        Mon, 15 Jun 2026 09:32:44 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f47408besm2913396d6.28.2026.06.15.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:32:44 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:32:39 -0400
From: Brian Masney <bmasney@redhat.com>
To: Pavel =?iso-8859-1?Q?L=F6bl?= <pavel@loebl.cz>
Cc: Stephen Boyd <sboyd@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-clk@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: clocking-wizard: fix integer overflow in rate
 calculation
Message-ID: <ajApJ5RDcffKtZOH@redhat.com>
References: <20260605130340.3549582-1-pavel@loebl.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605130340.3549582-1-pavel@loebl.cz>
User-Agent: Mutt/2.3.1 (2026-03-20)

On Fri, Jun 05, 2026 at 03:03:40PM +0200, Pavel Löbl wrote:
> When using driver on Zynq-7000 (32-bit) determine_rate calculation
> overflows. For instance requesting 32MHz with 100MHz parent clock
> results in 100000000*(4*1000+0) 32-bit multiplication.
> 
> Replace the expression with mult_frac which is already used in
> clk_wzrd_recalc_ratef.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7681f64e6404 ("clk: clocking-wizard: calculate dividers fractional parts")
> Signed-off-by: Pale Löbl <pavel@loebl.cz>

Reviewed-by: Brian Masney <bmasney@redhat.com>

