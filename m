Received: from mta0.migadu.com (out-140.mta0.migadu.com [91.218.175.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E9326924
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819606; cv=none; b=i/SPBdSb+BTTSPXaKYkMGp8mreNBEVspXKkkL95bx+RfqCM4VyJGHdfiyRkmd+2PveBiW1hmym6woY6zO3vlRZ05CAXWq7I8Jw9rLivJfzZciDi7CQyLaa2hZKOaFlHZCkNJE/gKWojDQjsOS1JpWiS7imXbAKonmjADXUTcTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819606; c=relaxed/simple;
	bh=zPGOdscwfUn5mgzb0Gu30YtAw5dbLao3e/+fpf4jvD8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ctrt6kFOdXnM9aHW8EbTW46vd/8uaKHsDVIi1O3qCbo57du4oUGrS5TALGQrT4osnUKtZzImB4M5vQqitdumCMO389UR4EWhwPABkr9wUy43UjwMp71EyVGnB8GFwYrjReSeZmc2HieI05YJUcBWtC53bfGbSYJzY9a5tnb43n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iqcjYwO2; arc=none smtp.client-ip=91.218.175.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iqcjYwO2"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zPGOdscwfUn5mgzb0Gu30YtAw5dbLao3e/+fpf4jvD8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819602; v=1; x=1792424402;
 b=iqcjYwO2LqFj4OZJ+hoO9/P5tFqoC6njYvBztokFZcdncyIoi0uVOp+CeeHxfgXFJB+LYLYO
 c3z3K46re8hN9scIxBUF0/kLIgYO9BmCG6DVWH8t2TTUG0cBv+egOaW3mb9tjHG8u3zHR+EycYh
 CmrYPlInjHPH0yTcks+dDrGQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8cfabf6460186618;
	Mon, 12 Oct 2026 15:40:02 +0000
X-Mizu-Trace-ID: 8cfabf6460186618
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 15:40:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <341ceaef821fe23a887a90701d9fda6516066edf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 5.10] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE
 loop
To: "=?utf-8?B?0JzQuNGF0LDQuNC7INCU0LzQuNGC0YDQuNGH0LXQvdC60L4=?="
 <mdmitrichenko@astralinux.ru>
Cc: stable@vger.kernel.org, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Sasha Levin" <sashal@kernel.org>, "Fabio
 Aiuto" <fabioaiuto83@gmail.com>, "Alexandru Hossu"
 <hossu.alexandru@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
 "Navaneeth K" <knavaneeth786@gmail.com>, "Michael Straube"
 <straube.linux@gmail.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Dan Carpenter" <error27@gmail.com>,
 "Andrei Khomenkov" <khomenkov@mailbox.org>, "Dalvin-Ehinoma Noah
 Aiguobas" <fliegbert2@gmail.com>, "Michael Huang"
 <tehsiu.huang@gmail.com>, "Jinke Wu" <coolbeaner@126.com>, "Nikolay
 Kulikov" <nikolayof23@gmail.com>, "William Hansen-Baird"
 <william.hansen.baird@gmail.com>, "Serhat Kumral"
 <serhatkumral1@gmail.com>, "Nazar Kletskii" <nazar.kletskii@gmail.com>,
 "Jennifer Guo" <guojy.bj@gmail.com>, "Hans de Goede" <hansg@kernel.org>,
 lvc-project@linuxtesting.org, "stable" <stable@kernel.org>
In-Reply-To: <fa2a1e43-8b9f-2c0c-609c-ca17bd20b7c0@astralinux.ru>
References: <20261012140642.1076-1-mdmitrichenko@astralinux.ru>
 <7e9af4f7528da1307cf62e53cf6b00fa9c4f674f@linux.dev>
 <fa2a1e43-8b9f-2c0c-609c-ca17bd20b7c0@astralinux.ru>

October 12, 2026 at 5:33 PM, "=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB =D0=94=
=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D1=87=D0=B5=D0=BD=D0=BA=D0=BE" <mdmitriche=
nko@astralinux.ru> wrote:


>=20
>=20On Mon, 12 Oct 2026 at 17:19 MSK, Luka Gejak <luka.gejak@linux.dev> w=
rote:
>=20
>=20>=20
>=20> It seems to me that this was sent by accident by running git format=
-patch -1
> >=20
>=20>  You probably forgot to commit so git made last commit into a patch=
 file.
> >=20
>=20>  Either way staging rtl8723bs is getting removed in linux 7.4 so an=
y
> >  further commits for rtl8723bs are discouraged.
> >=20
>=20Hi Luka,
>=20
>=20Thanks for taking a look. This was intentional: it is a backport of
> your reviewed fix f9654207e922 for the 5.10.y stable tree (hence the
> [PATCH 5.10] prefix). The upstream commit is tagged Cc: stable and is
> already in 5.15.y and newer, but 5.10.y is still missing it
> (CVE-2026-64444).=20
>=20
> As far as I understand, the removal in 7.4 affects mainline only; the
> driver is still part of 5.10.y, so the fix is still relevant there.
>=20
>=20Best regards,
> Mikhail
>

Understandable, I wasn't aware it isn't backported as it seems to me
it was merged quite some time ago.

Best regards,
Luka Gejak
