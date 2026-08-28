Received: from server10.varnoff.net (mail.autoban.ru [195.62.71.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197E448BBE
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.62.71.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917170; cv=none; b=LljQF5NsOM5NnThrgzxMhQueuLyqDe/noZOXZI6LfpsyGHw1r2i4V3S4PMDx3LZAk1iPF2leZ9Hw18i9A71DPqm7ear1lgZgSf203ROMDlkmblRBTtCU4vZjTCtdPkwHWRWox+zQyv5x1K7KPR/wGN2KZCOYUwzmc7+vitzFfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917170; c=relaxed/simple;
	bh=6tolOqeWZjiZ6dzlOox9ujAHB3r5D59dAn1WSUP5fP8=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=OAOkA5GikhgUPtmhBId53ntRnTP3n1U7Cj0RRmPMnSjlTExkilz1xmQA8JS35bpZfUZDuWG3zG9oQUQKYWTWVQp3ivNuHpz8XVpGSy2CQBLmADKtNUW0G3kIR7TVELkUNl+SAyZju0Gx0FmVWd6Cd8pNrgEeuM6FceaGseTnQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=autoban.ru; spf=pass smtp.mailfrom=autoban.ru; dkim=pass (1024-bit key) header.d=autoban.ru header.i=@autoban.ru header.b=pV0sFRik; arc=none smtp.client-ip=195.62.71.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=autoban.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=autoban.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=autoban.ru header.i=@autoban.ru header.b="pV0sFRik"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=autoban.ru;
	 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:
	To:From:Reply-To:Message-ID:Sender:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D0hALOpRrF7b6/FMf/9vrmiuaKsct0RpbAyGawzuDRY=; b=pV0sFRikZuFD5dQJ/9Wvh5u78h
	p6Nx70yOBjDFKvUL6cK2ZIS7l8zLSqW/oDDE1XvTlnbT7S6gzSR4nNVCpo0rmI5eR1CGC2f1tKupA
	UEo5S+TOOtjfk4htDCuUmR/9vUvWQ00dRRfPxJSvkTgdHiMVKLgnyvIDKkYSSVN3NHUs=;
Received: from [185.184.171.186] (helo=suuhgya)
	by server10.varnoff.net with esmtpa (Exim 4.89)
	(envelope-from <test1@autoban.ru>)
	id 1wzuZS-00067H-Mj
	for stable@vger.kernel.org; Fri, 28 Aug 2026 15:16:31 +0400
Message-ID: <2e5445e115d1d47d5ef0298276b70d07333bd1c8@autoban.ru>
Reply-To: =?utf-8?B?0KXRg9C00L7QsWDRj9C6INCc0L7QstGH0LDQvSDQoNC+0YHRgtC40YE=?=
	=?utf-8?B?0LvQsNCy0L7QstC40Yc=?= <ssu@gov.ua>
From: =?utf-8?B?0KXRg9C00L7QsWDRj9C6INCc0L7QstGH0LDQvSDQoNC+0YHRgtC40YE=?=
	=?utf-8?B?0LvQsNCy0L7QstC40Yc=?= <test1@autoban.ru>
To: stable@vger.kernel.org
Subject: =?utf-8?B?0IbQvdGE0L7RgNC80LDRhtGW0Y8gKNCy0LjQvNCw0LPQsNGUINGA0LU=?=
	=?utf-8?B?0LDQs9GD0LLQsNC90L3RjykgLdCj0LvQuNGG0YzQutC40Lkg0JLQvtC7?=
	=?utf-8?B?0L7QtNC40YHQu9Cw0LIg0J7RgdGC0LDQv9C+0LLQuNGH?=
Date: Fri, 28 Aug 2026 14:16:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=AF =D0=A3=D1=81=D0=B8=D0=BA =D0=96=D0=B0=D0=B4=D0=B0=D0=BD =D0=96=D0=B4=
=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=87,=D0=9F=D0=BE=D0=BF=D0=B5=D1=80=D0=B5=
=D0=B4=D0=B6=D0=B0=D1=8E =D0=92=D0=B0=D1=81, =D1=89=D0=BE =D1=8F =D0=B7=D0=
=B0=D0=BC=D1=96=D0=BD=D1=83=D0=B2=D0=B0=D0=B2 =D0=BE=D1=84=D1=96=D1=81=D0=
=BD=D1=83 =D0=B1=D1=83=D0=B4=D1=96=D0=B2=D0=BB=D1=8E =D0=B7=D0=B0 =D0=B0=D0=
=B4=D1=80=D0=B5=D1=81=D0=BE=D1=8E =D0=BC. =D0=9C=D0=B8=D0=BA=D0=BE=D0=BB=D0=
=B0=D1=97=D0=B2, =D0=B2=D1=83=D0=BB. =D0=9C=D0=B0=D0=BB=D0=B0 =D0=9C=D0=BE=
=D1=80=D1=81=D1=8C=D0=BA=D0=B0, =D0=B1=D1=83=D0=B4. 108/5 =D0=BD=D0=B0 3=E2=
=80=935 =D0=BF=D0=BE=D0=B2=D0=B5=D1=80=D1=85=D0=B0=D1=85 =D1=83 =D1=81=D1=
=82=D0=B5=D0=BB=D1=8C=D0=BE=D0=B2=D1=96=D0=B9 =D1=87=D0=B0=D1=81=D1=82=D0=
=B8=D0=BD=D1=96 =D1=8F =D0=B2=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D0=
=B2 =D1=83 =D0=B2=D0=B0=D0=BA=D1=83=D1=83=D0=BC=D0=BD=D0=B8=D1=85 =D0=BF=D0=
=B0=D0=BA=D0=B5=D1=82=D0=B0=D1=85 7 =D0=B2=D0=B8=D0=B1=D1=83=D1=85=D0=BE=D0=
=B2=D0=B8=D1=85 =D0=BF=D1=80=D0=B8=D1=81=D1=82=D1=80=D0=BE=D1=97=D0=B2,
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


