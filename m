Received: from smtpout10.dnsserver.eu (smtpout10.dnsserver.eu [92.240.253.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCF40BCD2
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.240.253.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913017; cv=none; b=WFMHAXEV9wvESuhxDbBdZRsQ0L4f1uR2eTtDX//FALuaAaeXFrkvvpLFx/FMK/2tOCvJTYGbtujNcK0H+m+u+sHJ+JERJFpmKlEpHlDI9nNyby3LBS60A1EtH4/r7R8a+/bwuZeCdbZVihBZ+MtXsuSNA6hxeIjLqyYyaj13HVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913017; c=relaxed/simple;
	bh=Tp59Q8mzg3qLDyVLcAA4WbwtxRLewIevhfLntO0q5WY=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=mPRwy1e9sSPHp4N5CaatPUVJmEt2zFEa64zxOC2C7SoEhg+l7opbE0mRiy2GJvRNN70TS5cqsYBmzIqPA5kHUbOinBtjgILMhTruVUBxsUeKC7N/zTTkloqNIl5rmeRHS7DurBja8YeNy7ZvaJwdIxMwvD19JkMyy20VBkHndvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alishop.sk; spf=pass smtp.mailfrom=alishop.sk; arc=none smtp.client-ip=92.240.253.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alishop.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alishop.sk
Received: from [192.168.27.90] (helo=smtp.exohosting.com)
	by smtpout10.dnsserver.eu with esmtp (Exim 4.94 (FreeBSD))
	(envelope-from <info@alishop.sk>)
	id 1wzta0-0001LV-1A
	for stable@vger.kernel.org; Fri, 28 Aug 2026 12:13:00 +0200
x-exo-ray: 0BA3F100-A2C9-11F1-B82D-9F02D6586AD3
Received: from [185.184.171.186] (helo=bmdyrdx)
	by smtp.exohosting.com with esmtpa (Exim)
	(envelope-from <info@alishop.sk>)
	id 1wztWu-00000000DZE-1TLj
	for stable@vger.kernel.org;
	Fri, 28 Aug 2026 12:12:59 +0200
Message-ID: <244227b74387822b08a67fd420e1cbc1f5cf714b@alishop.sk>
Reply-To: =?utf-8?B?0JTQsNGG0LrQviDQntC70LXQutGB0LDQvdC00YAg0K7RgNGW0LnQvtCy0Lg=?=
	=?utf-8?B?0Yc=?= <kahc@vimk.com.ua>
From: =?utf-8?B?0JTQsNGG0LrQviDQntC70LXQutGB0LDQvdC00YAg0K7RgNGW0LnQvtCy0Lg=?=
	=?utf-8?B?0Yc=?= <info@alishop.sk>
To: stable@vger.kernel.org
Subject: =?utf-8?B?0J/RgNC+0YHQuNC80L4g0JLQsNGBINC30LLigJnRj9C30LDRgtC40YHRjw==?=
	=?utf-8?B?INC3INC90LDQvNC4INC90LXQs9Cw0LnQvdC+LCDQsdC+INGC0LXQu9C10YQ=?=
	=?utf-8?B?0L7QvdC90LjQuSDQt9Cy4oCZ0Y/Qt9C+0Log0LLRltC00YHRg9GC0L3Rlg==?=
	=?utf-8?B?0LkuICA=?=
Date: Fri, 28 Aug 2026 13:12:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-User: info@alishop.sk
X-Spam-Bar: +
X-SA-Exim-Connect-IP: 185.184.171.186
X-SA-Exim-Mail-From: info@alishop.sk

=D0=94=D0=BE=D0=B1=D1=80=D0=B8=D0=B9 =D0=B4=D0=B5=D0=BD=D1=8C,  =D0=BC=D0=
=B8 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D0=BC=D0=BE =D0=B4=D0=BE=D0=B4=D0=
=B7=D0=B2=D0=BE=D0=BD=D0=B8=D1=82=D0=B8=D1=81=D1=8F =D0=B4=D0=BE =D0=92=D0=
=B0=D1=81, =D1=82=D0=BE=D0=BC=D1=83 =D0=BF=D1=80=D0=BE=D1=88=D1=83 =D0=9D=
=D0=95=D0=92=D0=86=D0=94=D0=9A=D0=9B=D0=90=D0=94=D0=9D=D0=9E =D0=BF=D0=B5=
=D1=80=D0=B5=D0=B4=D0=B7=D0=B2=D0=BE=D0=BD=D0=B8=D1=82=D0=B8 =D0=BC=D0=B5=
=D0=BD=D1=96 =D0=B7=D0=B0 =D0=BD=D0=BE=D0=BC=D0=B5=D1=80=D0=BE=D0=BC (073=
) 641-73-44.

=D0=97 =D0=BF=D0=BE=D0=B2=D0=B0=D0=B3=D0=BE=D1=8E,
=D0=94=D0=B0=D1=86=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=
=D0=B4=D1=80 =D0=AE=D1=80=D1=96=D0=B9=D0=BE=D0=B2=D0=B8=D1=87
(067) 995-08-92
(073) 641-73-44



