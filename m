Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771495;
	b=4gC4wPhO9Z1YNWgmfSVeun+MgWl+VpdWvNfgKSiO3rYJqAmC5Isblvsks0TFC/mzuK+2
	 0IBGWT9ubCV58LZ0JRt3UHfgxLi9UX9B9cbiQDuIJpw7D/W8XipHobiuY7n0LeIvnvt0X
	 hOMfrzQ6LtN6ME44K97pxFSuNhaQvqIdY9nsCsf+UJmoCC5hVAdK22VorO+QKYmROc3Ie
	 Cnw712pOvyjI3RFHXoJeDWV4ZPy4NOhDbVB5jvhBL4AX+kyEcfkLvyGo9DjNVkLH1zz6z
	 4rBaTp7lGbxzr7YeGDvObJcgZuaJuuPaKrZ7Hl4tYuEorcWbGTGxsaKC077me5veXcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771495;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=ffjaXrQgekHgaiAXYlHWxAd1hg/vdm54u7R2y3uB1e8=;
	b=mty0H+aKDcmbIhQSHdI3qZ+SKhBNRyVOvgOlO5LL37T70Jxe3xqW+s81Z8elEpm7hl8P
	 7Gy+qUaK9V7OzJ9nOwzsxfNfsjHbA1CeKXhcc5B2EbYhRklmT9ZYejKvEbOmrpgUo0JMv
	 AtoU908+Pg4qE8hfip+/So/At+ACmuG1yxu/hDTrYqtY69qoupZIACh6jqAhKV1CUftW/
	 f2W5eCEEe7G4irhIdKXyeDO1QF+EWl5NaWaRAhzhGLGhTYolFnlrUXz4F//KoNyeT9qCZ
	 2WlsiBSUkANdp3Iqzsw8UTbS4mwlfU+UIGZs7u3iX/OT/81b576SvxdFiAR3rU2vc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=GtuuVy1j;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CF606A321;
	Fri, 27 Nov 2026 09:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=GtuuVy1j
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5E1FC208A6;
	Fri, 27 Nov 2026 10:24:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UrWwbOnHPHgB; Fri, 27 Nov 2026 10:24:52 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D500120894;
	Fri, 27 Nov 2026 10:24:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D500120894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1795771492;
	bh=ffjaXrQgekHgaiAXYlHWxAd1hg/vdm54u7R2y3uB1e8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GtuuVy1jYqkTjFISKIRbvwGvu4BScdqaj10HE6PHMbaUe02lCFRgQzaoo2cZFlDdX
	 lypl3Y3ZJ6oybq1sp5bBH3/UkZv40suipixwn3ZPLWRzl0OMYz9fJx9W7qebpH8Q2D
	 V3eY+TP8StHFO645IWuEN8DY0WrvuUBWNaxrVvThK0hpZgICoE7YxYIjGCxRpBsIRt
	 J+mi0H4/603PexmVaTH+VSyGM24npjUtrYIPX4Du/4eu06mD1cN2o4jtTBj7NLhfWe
	 QfhWV0PaOosm8Yam9GrBMfSV72gA/tvYKVi5SO2Fqh+A58A7+ZF7qkcpNTRVTW+jNv
	 CF/VHq0iOz4tg==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 27 Nov
 2026 10:24:52 +0100
Received: (nullmailer pid 3468826 invoked by uid 1000);
	Fri, 27 Nov 2026 09:24:52 -0000
Date: Fri, 27 Nov 2026 10:24:51 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Andrii Tereshchenko <opensource@andrii.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>, <ipsec@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH ipsec] xfrm/compat: pass on the translated length of a
 socket policy
Message-ID: <awlMY_jXPtnF8D2W@gauss4>
References: <5249741d-fa84-4d54-bf77-45f48dbbb169@mid.andrii.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5249741d-fa84-4d54-bf77-45f48dbbb169@mid.andrii.net>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Nov 23, 2026 at 07:29:46PM -0800, Andrii Tereshchenko wrote:
> xfrm_user_policy() compiles a 32-bit task's translated socket policy
> with the untranslated length, 4 bytes short, so the policy loses its
> last template: an ESP-required socket policy then sends in clear
> text. Have the translator return the translated length.
> 
> Made with an AI coding assistant, reviewed by the submitter.
> 
> Fixes: 96392ee5a13b ("xfrm/compat: Translate 32-bit user_policy from sockptr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>

Applied, thanks a lot!
