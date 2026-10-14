Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBF469847;
	Wed, 14 Oct 2026 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990407; cv=none; b=BZb5nkKNT18by1IOuIu0k0EwA27wKmRUSxVXvf16625WIzs4Y1wwzgDpl2zf0P1e3OG1h8ZV1n0Ohx1+jUhU8pcjaXkPxzAdbqmcs57PbeFvSPrtOG3Kh5W2xdal1l7QyLae25gc2w54DJr82oYiablHEYB7mZHyTavmaexQo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990407; c=relaxed/simple;
	bh=vjLU4atgWtNkD3lZO6dYduHPj1nvSQ1PSL1KdSzn9eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=WkLz7mc65ozPlXyBe2suRfK/1NMs/AIHtLeFkzjGf7JPolPELEnMYGgfjiYnfViguUS7P9gZDguuHdlWQ+QbGpsvYfDYCWvm/KGT+q7Do8ahph/x5WNXdGyDpNbfIAYHbi+IUkPjL13sjXL55CSUOG1n35oiClFnk+VIKrrzCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.16] ) by
 ajax-webmail-APP-10 (Coremail) ; Wed, 14 Oct 2026 23:06:36 +0800
 (GMT+08:00)
Date: Wed, 14 Oct 2026 23:06:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: "Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"Dave Jiang" <dave.jiang@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Ira Weiny" <iweiny@kernel.org>, "Li Ming" <ming.li@zohomail.com>, 
	"Richard Cheng" <icheng@nvidia.com>, linux-cxl@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/mbox: Treat unknown device return codes as
 errors
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5cd8a569.40305.1a13af3751b.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowACXnKt8ms9qjCcTAA--.57659W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwcADGrOyBb0pAADsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

QWNrZWQtYnk6IEdhb2JpbiBIdWFuZyA8aHVhbmdnYW9iaW4yM0BzZW1pLmFjLmNuPgoKCg==
