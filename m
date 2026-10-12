Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A649D5B7
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821922; cv=none; b=aXJusVPLGsfWe7ndv9YOG16Zweba/fG347MDm2FfOHwI42Lxgc01uYv6MKzI8Fl2x+yhwWIbuiSAEXb7ezMVLc9h7XLySkeNNvzj8WlzBWiNEjq16kIkRF7QBtbK0V2EJCul5xkKNBgFNg79bOdKyb+huGgUOcAatamAwo3gK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821922; c=relaxed/simple;
	bh=4YpWVz2t7P3nkCK75u6xOdBsc4nHUlNeMIe6NmdDkAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv58mEVocDYHQEBIZsRQkSA6/9ZozuL/jz3VJLcmv89q7TjF3O47qttdnrXq0MkTTI6mLGqCXTPBuZXr6Lr79P0HX1IPpoqcecD3abI8cX5/OLJj3M/hZEK19lkE1tKl71+CQo/DnDqpc6AcM9ONpo0QjIe82NOxB4yqQbgoA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LvvoZaG6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LvvoZaG6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93cbc3ab2fdso82550985a.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791821919; x=1792426719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ycCA/46fGP9bMzNSUFEULycpfUfNegmWCSDBNo9iDiA=;
        b=LvvoZaG6fsq8hB0FOotQh35EMoCepkvvzptzfAzU/s1zJC7dhg5PSKIPvRHtUNIUBP
         w9gvhZ87eGhXWdTMd4p/TK1h1+ue4Fr7gFP9EBJo7NiJyYTitoai0dUHr0lFLGA30I4P
         x0LV6t/aKncAdIxJf1RpJN2EUnV8Jc6gOa7sDXczYruPnhnW0AEZTntu47jpBq4qmz65
         XZ29Cj0zf+pzoYW7+Sqi+LWrGr7lNlQ6BbmCinaNxPHEK+0fy08RT5N9oE+GYxegAK2R
         c0TFCts30Tzfsr89JZpBW+/suz2o049I6GsqorKmvKbg1H4thRkP3HGJRwS3IdBsjHZn
         P06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791821919; x=1792426719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycCA/46fGP9bMzNSUFEULycpfUfNegmWCSDBNo9iDiA=;
        b=HgPW/4hL3WqAbpqfYybMEIEJAmQBzxQgIoDINmxQNsUYytQCSMpTYXD1GP7kV8tM9c
         eGBp+xGthROOi1ErpV+p7Pu5DDC4asWHT46yJgdmhzIHVCfqAefb8YzB3Ur9RojkMwah
         Jysoq01M5175CMj6giXvZVg1iXpOZ+FJR8jJnUVyiaTajwWDtc1GQyEcIAZB1pHq19Z8
         big6PIanMvHux579se7A7gYfZgzwow975nVLhkk7W+zeq4EEV/cQBc7r3pdw0JiQYlyN
         0vLZsP2N2HjLBOeYcgDVgzjhuWTg+Q5hGT4//+Lg3FLHhA7zKijKUTuQUmQKmBKNX4Oh
         b9ww==
X-Forwarded-Encrypted: i=1; AKwUvByGTAJ5VLxSAHFiyxtkvVi6bq8NjCbZBExo5s68jwEFk2ILPiM+Mi/pTzgbGnlFWih4HajHZMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+ZkS0o4Ilnxe/FDIH+c5VvTGhxlgGtTsuUc3Cf9GYGXqWVFiE
	pY+cuB+l8wZWnOe3oaMHdzpljYJCwaYgtEtUaoRDxk6olthMPw7mvTbaZERNBIMR/eCJqb3tw/p
	9irUL2Y8=
X-Gm-Gg: AYBFou0aSQqDJm4wzZVqJWRsttZM1Gkh8ZBD4H+nEBdisVati1ny5qPeWz4BChbJHxk
	+yOdcDsgR4I/eB24IBaVRRKuu4rcjAxkgJL5K9450K9z+ocXi+NQ1X3bPxo50h83XQjZ0jYwpNr
	3pj/5a/R60MSYQB+6EpFeXk58AzN9Fye0kl4CbBwP+anG7XMKSzNl/OLMTfHne9nyG6eqBBrGUq
	CGq0XldUIjTo1nLtC18rBuu93Kv/ViN8gugfGK9QT8PFIhocX9kv/CBqSDHoXEOsMMzI6nMZS0n
	tEsT5R4FFDRcmqT+xD2Jz9HBCfyirxICWR327Y6GJNK2iDMgWrcpQJhZ/KUjf+cc7rHgy6FNsMD
	ojo9ZAtttfNkylSIwbmW/zXav6O5oCvkxavP9jLjSH02tVv3oe86esuRYM7SowUA3fOZ1H7Jenj
	dS7e/Wl/79XaA52fiW/ySWaq0zMj2sUISROKhxhenuC5zhRj9+VyukmeWnOY2v9Iw0P5lrcuQbn
	Y1AEM6kWTI8PJJEOHEKZv2Mk38B2DjCWt2+qcGS/bGoKMFGeg1hXN8=
X-Received: by 2002:a05:620a:2981:b0:939:6df7:73f1 with SMTP id af79cd13be357-93ebd27484bmr1635268185a.51.1791821918598;
        Mon, 12 Oct 2026 09:18:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50295a7sm20807785a.23.2026.10.12.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:18:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 12:18:36 -0400
From: Gregory Price <gourry@gourry.net>
To: jianyungao89@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] dax: fix dax_core_init error return code
Message-ID: <as0IMU-uIENTAXSW@gourry-fedora-PF4VCD3F>
References: <20261012151857.22534-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012151857.22534-1-jianyungao89@gmail.com>

On Mon, Oct 12, 2026 at 11:18:57PM +0800, jianyungao89@gmail.com wrote:
> From: Jianyun Gao <jianyungao89@gmail.com>
> 
> dax_core_init() mistakenly returns 0 on error paths. Change the
> error return to use rc so the actual error code is propagated
> to the caller.
> 
> Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

