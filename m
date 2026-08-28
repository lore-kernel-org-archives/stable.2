Received: from h1008.onnet.my (svr2.mailcentre.com.my [103.17.211.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707F43A7E7
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.17.211.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920553; cv=none; b=A7xeWR2g/M9ST4nF6bjsOuvbaheKkUokDUPbBDpzXjLVNAby+pMwBr84iRuY1Dcz2pQcKu2L96fk6ly+zWnnZKPoWCXvLjBEZRFdV0xv8NVONlsEp++hNRAGNnb75jdjeDOQehOurRZafSNxgdhzeDC3KJ8/20pPS1+c3qA131k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920553; c=relaxed/simple;
	bh=O0xsDZ1Gk90qqmPhKGsCswkNddv7z02AZ1lr+clqk7o=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=UewFzOteGfWc/EMbZ+BNTfztzF0HzJePB6yvRPA8RP50d5OS2PeYfEw6uk1546XfpmLPbyAGhYj/AqMNDr1e5ZjqrFcdFekl2hafLKfrnWA35I5n/46Fo1Zaqft3apUJtynkCjd2PBix74x+ffCm4mshhWxm6yAiRGTJXzpQgao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svr2.mailcentre.com.my; spf=pass smtp.mailfrom=svr2.mailcentre.com.my; dkim=fail (2048-bit key) header.d=svr2.mailcentre.com.my header.i=@svr2.mailcentre.com.my header.b=FTyVCpyr reason="signature verification failed"; arc=none smtp.client-ip=103.17.211.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svr2.mailcentre.com.my
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svr2.mailcentre.com.my
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=svr2.mailcentre.com.my header.i=@svr2.mailcentre.com.my header.b="FTyVCpyr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=svr2.mailcentre.com.my; s=x; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Date:Subject:To:From:Reply-To:Message-ID:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0P/a0bWrggEYODb55tKIPsN457Pdh9dkVBJKkZtsDts=; b=FTyVCpyrgV8ZUmBEwGKBYUDm2s
	p61CPU3WHTbMDh+qNC/GRP5+0NSvMNrO5MjDvmWw6xhwJFiKKtdgrgi4gDMp019VNnDqGwKUVECJ4
	zcWYmv3X23jn3j1tZ6ubSFnz6dmcqXE2DG2ST9uBjfnv6fF4BqbLePVLePq4BeoYbsinFh2MEXGW3
	6Yb55QrnE4CKXjiHMYTa26Ua5LiRrmyayRNDAIOmue8SiSokzMmpQH0+BJb5E4ca9VlRQbFe8UO/q
	7NoK1/70GSG+y+ThEBrNnFm3l4UvXJRzifl8lQ0KoMfVtWmmJCItNFWkPESsMurA1PO06PHeTTJbY
	U6Bp/GaA==;
Received: from [185.184.171.186] (helo=zxld)
	by h1008.onnet.my with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <rivercity@svr2.mailcentre.com.my>)
	id 1wzuYf-0000rV-8a
	for stable@vger.kernel.org;
	Fri, 28 Aug 2026 19:15:41 +0800
Message-ID: <069cd104f0343198bb15cc6793521812263bd9f9@svr2.mailcentre.com.my>
Reply-To: =?utf-8?B?0IfQttCw0Log0KPQu9C40YfQsNC9INCW0LTQsNC90L7QstC40Yc=?= <ssu@gov.ua>
From: =?utf-8?B?0IfQttCw0Log0KPQu9C40YfQsNC9INCW0LTQsNC90L7QstC40Yc=?= <rivercity@svr2.mailcentre.com.my>
To: stable@vger.kernel.org
Subject: =?utf-8?B?0IbQvdGE0L7RgNC80LDRhtGW0Y8gKNCy0LjQvNCw0LPQsNGUINGA0LXQsNCz?=
	=?utf-8?B?0YPQstCw0L3QvdGPKSAt0KbQuNCx0LXQvdC60L4g0ITRgNC10LzRltC5INCh?=
	=?utf-8?B?0LLRltGC0LDQvdC+0LLQuNGH?=
Date: Fri, 28 Aug 2026 14:15:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: rivercity@svr2.mailcentre.com.my

=D0=AF =D0=A8=D0=BF=D0=B0=D1=80=D0=B0 =D0=90=D0=B2=D0=BA=D1=81=D0=B5=D0=BD=
=D1=82=D1=96=D0=B9 =D0=9A=D0=BE=D1=81=D1=82=D1=8F=D0=BD=D1=82=D0=B8=D0=BD=
=D0=BE=D0=B2=D0=B8=D1=87,=D0=9F=D0=BE=D0=BF=D0=B5=D1=80=D0=B5=D0=B4=D0=B6=
=D0=B0=D1=8E =D0=92=D0=B0=D1=81, =D1=89=D0=BE =D1=8F =D0=B7=D0=B0=D0=BC=D1=
=96=D0=BD=D1=83=D0=B2=D0=B0=D0=B2 =D0=BE=D1=84=D1=96=D1=81=D0=BD=D1=83 =D0=
=B1=D1=83=D0=B4=D1=96=D0=B2=D0=BB=D1=8E =D0=B7=D0=B0 =D0=B0=D0=B4=D1=80=D0=
=B5=D1=81=D0=BE=D1=8E =D0=BC. =D0=9C=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D1=97=D0=
=B2, =D0=B2=D1=83=D0=BB. =D0=9C=D0=B0=D0=BB=D0=B0 =D0=9C=D0=BE=D1=80=D1=81=
=D1=8C=D0=BA=D0=B0, =D0=B1=D1=83=D0=B4. 108/5 =D0=BD=D0=B0 3=E2=80=935 =D0=
=BF=D0=BE=D0=B2=D0=B5=D1=80=D1=85=D0=B0=D1=85 =D1=83 =D1=81=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BE=D0=B2=D1=96=D0=B9 =D1=87=D0=B0=D1=81=D1=82=D0=B8=D0=BD=D1=
=96 =D1=8F =D0=B2=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D0=B2 =D1=83 =
=D0=B2=D0=B0=D0=BA=D1=83=D1=83=D0=BC=D0=BD=D0=B8=D1=85 =D0=BF=D0=B0=D0=BA=
=D0=B5=D1=82=D0=B0=D1=85 7 =D0=B2=D0=B8=D0=B1=D1=83=D1=85=D0=BE=D0=B2=D0=B8=
=D1=85 =D0=BF=D1=80=D0=B8=D1=81=D1=82=D1=80=D0=BE=D1=97=D0=B2,
 =D1=8F=D0=BA=D1=96 =D1=81=D0=BF=D1=80=D0=B0=D1=86=D1=8E=D1=8E=D1=82=D1=8C=
 =D0=B7 14:30 =D0=B4=D0=BE 17:00 =D0=B7=D0=B0 =D1=86=D1=96=D1=94=D1=8E =D0=
=B0=D0=B4=D1=80=D0=B5=D1=81=D0=BE=D1=8E; 3 =D0=B2=D0=B8=D0=B1=D1=83=D1=85=
=D0=BE=D0=B2=D1=96 =D0=BF=D1=80=D0=B8=D1=81=D1=82=D1=80=D0=BE=D1=97 =D1=8F=
 =D1=80=D0=BE=D0=B7=D0=BC=D1=96=D1=81=D1=82=D0=B8=D0=B2 =D0=BD=D0=B0 5 =D0=
=BF=D0=BE=D0=B2=D0=B5=D1=80=D1=81=D1=96 =D0=BE=D1=84=D1=96=D1=81=D0=BD=D0=
=BE=D1=97 =D0=B1=D1=83=D0=B4=D1=96=D0=B2=D0=BB=D1=96 =D0=BC=D1=96=D0=B6 =D0=
=BE=D1=84=D1=96=D1=81=D0=B0=D0=BC=D0=B8 521=E2=80=93527, =D1=80=D0=B5=D1=88=
=D1=82=D1=83 =D0=B2=D0=B8=D0=B1=D1=83=D1=85=D0=BE=D0=B2=D0=B8=D1=85 =D0=BF=
=D1=80=D0=B8=D1=81=D1=82=D1=80=D0=BE=D1=97=D0=B2 =D1=8F =D1=81=D1=85=D0=BE=
=D0=B2=D0=B0=D0=B2 =D1=83 =D1=80=D1=96=D0=B7=D0=BD=D0=B8=D1=85 =D0=BC=D1=96=
=D1=81=D1=86=D1=8F=D1=85 =D1=86=D1=96=D1=94=D1=97 =D0=B1=D1=83=D0=B4=D1=96=
=D0=B2=D0=BB=D1=96! =D0=AF =D0=B2=D1=81=D1=96=D1=85 =D0=BF=D1=96=D0=B4=D1=
=96=D1=80=D0=B2=D1=83,
 =D1=96 =D0=BB=D1=8E=D0=B4=D0=B8 =D0=B7=D0=B0=D0=B3=D0=B8=D0=BD=D1=83=D1=82=
=D1=8C; =D0=BF=D1=80=D0=BE=D1=88=D1=83 =D0=B2=D1=81=D1=96=D1=85 =D0=BC=D0=
=B8=D1=80=D0=BD=D0=B8=D1=85 =D0=BC=D0=B5=D1=88=D0=BA=D0=B0=D0=BD=D1=86=D1=
=96=D0=B2 =D0=BF=D0=BE=D0=BA=D0=B8=D0=BD=D1=83=D1=82=D0=B8 =D0=B1=D1=83=D0=
=B4=D1=96=D0=B2=D0=BB=D1=96. =D0=AF =D1=96=D0=BD=D0=B2=D0=B0=D0=BB=D1=96=D0=
=B4, =D0=BC=D0=B5=D0=BD=D1=96 =D0=B2=D1=82=D1=80=D0=B0=D1=87=D0=B0=D1=82=D0=
=B8 =D0=BD=D1=96=D1=87=D0=BE=D0=B3=D0=BE, =D0=B2=D0=B8 =D0=B2=D1=81=D1=96=
 =D0=B7=D0=B0=D0=B3=D0=B8=D0=BD=D0=B5=D1=82=D0=B5! =D0=9F=D0=B5=D1=80=D1=88=
=D0=B8=D0=B9 =D0=B2=D0=B8=D0=B1=D1=83=D1=85 =D0=B2=D1=96=D0=B4=D0=B1=D1=83=
=D0=B4=D0=B5=D1=82=D1=8C=D1=81=D1=8F 28 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=
=8F 2026 =D1=80=D0=BE=D0=BA=D1=83 =D0=BE 14:30,
  =D0=B0 =D0=BE 16:30 =D1=8F =D0=B7=D0=B0=D0=B2=D0=B4=D0=B0=D0=BC =D1=83=D0=
=B4=D0=B0=D1=80=D1=83 =D0=B1=D0=BE=D0=B9=D0=BE=D0=B2=D0=B8=D0=BC =D0=B4=D1=
=80=D0=BE=D0=BD=D0=BE=D0=BC =D0=BF=D1=80=D1=8F=D0=BC=D0=BE =D0=BF=D0=BE 5=
-=D0=BC=D1=83 =D0=BF=D0=BE=D0=B2=D0=B5=D1=80=D1=85=D1=83 =D0=B1=D1=83=D0=B4=
=D1=96=D0=B2=D0=BB=D1=96! =D0=AF =D0=BA=D0=BE=D0=BD=D1=82=D1=83=D0=B6=D0=B5=
=D0=BD=D0=B8=D0=B9, =D0=BC=D0=B5=D0=BD=D1=96 =D0=B2=D1=82=D1=80=D0=B0=D1=87=
=D0=B0=D1=82=D0=B8 =D0=BD=D1=96=D1=87=D0=BE=D0=B3=D0=BE. =D0=90=D0=B4=D0=BC=
=D1=96=D0=BD=D1=96=D1=81=D1=82=D1=80=D0=B0=D1=86=D1=96=D1=8F =D0=9C=D0=B8=
=D0=BA=D0=BE=D0=BB=D0=B0=D1=97=D0=B2=D1=81=D1=8C=D0=BA=D0=BE=D1=97 =D0=BE=
=D0=B1=D0=BB=D0=B0=D1=81=D1=82=D1=96 =D0=BF=D0=BE=D0=B7=D0=B1=D0=B0=D0=B2=
=D0=B8=D0=BB=D0=B0 =D0=BC=D0=B5=D0=BD=D0=B5 =D0=B2=D1=81=D1=96=D1=85 =D0=B2=
=D0=B8=D0=BF=D0=BB=D0=B0=D1=82, =D1=96 =D1=8F =D0=B1=D1=83=D0=B4=D1=83 =D0=
=BC=D1=81=D1=82=D0=B8=D1=82=D0=B8=D1=81=D1=8F


