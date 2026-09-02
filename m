Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE64A5ED9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362288; cv=none; b=lmGQxGl3bRQlPlbdQlr22kEIr3KnaL35v41Zr5XaTL8mn0VNuQ/lMHq7xZOtg/Pl5+o1f0nelFgzU5y7S9jZxS3mg2Xl7mPi3GM1js3Qwo6HqOhRjW6Xmmu4HDnpRZrOnWZ9LCwozcAf0kvN6BYdDhVas06c/4XO3DgXm+hB/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362288; c=relaxed/simple;
	bh=21rcNKwNj+gfzwtDbWiARIBtlZyphQpDEMaJylFhpSI=;
	h=References:From:Date:Content-Type:To:Subject:Message-Id:
	 In-Reply-To:Cc:Mime-Version; b=CEvLGfP2zDJuyd4yzJz5HKsd5W5WcA4RJwGBnG8UWZOrdNXjwlOe+gvUox0sCwI1Vk2bwfKY3OX/AhyZOHVcnbNgQSPhAX4ISXkeIOvY8SAhax0K47SXJzWPdi9oArXRJ3JXGqFKkxOCi91CMmhp5B06q2uZWdrFGNlqOelvmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=E5RwZoyy; arc=none smtp.client-ip=209.127.231.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="E5RwZoyy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1788362278;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=NLbtg9v/wr1jTfkmRfnVDsymAoAkkWPBPijB9LWDQ1k=;
 b=E5RwZoyyfuCs+V+THDA1k0wJsQiHcyC7OGvP0bJRXX9pd8oU9xoL8r3uTcAMA++Yiz83qY
 cwPk1+aLo/D0lsT1Mxuh15KesPlW+5P3OBos7qD1GMTQp6eO+sMgpYB/e5bOy3d++Bo7Dc
 ZM9IcZ+qAI8FTXnVcFRZveJbTTcOPzQ6G//GFs+DVBH/DB9ju0dmbGNMShr2O2r2Q9vnbq
 Kh1XgHtyXQkWK2FsGkSVYSDKXCfgWP7X8TWxEpwe0IOqLwJop/qBEFwh/Q58igo5iWsb3I
 sI8WWVpSiv+mBO/RBywamQwio8oIG5R3Je1Vzk8uS2ZoL1UF/+/umOA2ajYqWw==
References: <20260709131904.596684-3-adhikari.resume@gmail.com> <20260721164027.637078-1-adhikari.resume@gmail.com> <20260721164027.637078-3-adhikari.resume@gmail.com> <anQdWeHd2EDZtkzp@studio.local>
From: "Coly Li" <colyli@fygo.io>
Date: Wed, 2 Sep 2026 23:17:44 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Coly Li <colyli@fygo.io>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
To: "Ramesh Adhikari" <adhikari.resume@gmail.com>
Subject: Re: [PATCH v7 2/2] badblocks: validate sector range and shift before rounding
Message-Id: <4B2B2780-254F-4702-8A78-2CD3F57C1D1F@fygo.io>
In-Reply-To: <anQdWeHd2EDZtkzp@studio.local>
Received: from smtpclient.apple ([120.245.64.136]) by smtp.larksuite.com with ESMTPS; Wed, 02 Sep 2026 15:17:57 +0000
Content-Transfer-Encoding: quoted-printable
Cc: <axboe@kernel.dk>, <gregkh@linuxfoundation.org>, 
	<linux-block@vger.kernel.org>, <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a983e26+2ac9d2+vger.kernel.org+colyli@fygo.io>

> 2026=E5=B9=B48=E6=9C=886=E6=97=A5 15:22=EF=BC=8CColy Li <colyli@fygo.io> =
=E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jul 21, 2026 at 10:10:24PM +0800, Ramesh Adhikari wrote:
>> _badblocks_set(), _badblocks_clear() and badblocks_check() round
>> the caller-supplied [s, s+sectors) range to the current bb->shift
>> block size before touching the bad block table. That rounding
>> was not defensive against a few cases:
>>=20
>> - s + sectors can overflow sector_t (u64), wrapping the range
>>  end before it is ever compared against s.
>>=20
>> - bb->shift is a plain 'int' field, populated in one case
>>  (drivers/md/md.c, from the on-disk superblock's bblog_shift)
>>  straight from an unvalidated byte with no upper bound. Shifting
>>  by an amount >=3D the width of the shifted type is undefined
>>  behaviour in C; "1 << bb->shift" was shifting an int literal,
>>  so this was already undefined for bb->shift >=3D 32, let alone
>>  the full 0-255 range bblog_shift allows.
>>=20
>> - round_up()/round_down() rounding a value near ULLONG_MAX can
>>  itself wrap back to a small value, so even with a valid shift
>>  the rounded end of the range could end up smaller than the
>>  rounded start, silently turning a small range into a huge one
>>  (in _badblocks_clear()/badblocks_check(), which round the end
>>  up) or losing the range entirely.
>>=20
>> Add an explicit s+sectors overflow check and cast the shift
>> operand to sector_t so the shift itself is never performed on a
>> 32-bit int, and detect post-rounding wrap by comparing the
>> rounded result back against the pre-rounding value.
>>=20
>> badblocks.c does not itself bound bb->shift: every caller except
>> drivers/md/md.c always leaves it at 0, so the one caller that
>> populates it from untrusted on-disk data is responsible for
>> bounding it before assigning it, per struct badblocks's shift
>> field documentation in include/linux/badblocks.h. That md.c-side
>> bound is being sent as a separate patch.
>>=20
>> badblocks_check() returns 0 rather than -EINVAL on the wrap case,
>> matching its existing "0: no known bad blocks in the range"
>> return convention instead of introducing a new error path callers
>> don't expect.
>>=20
>> Suggested-by: Coly Li <colyli@fygo.io>
>> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handlin=
g code")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
>=20
> The patch looks good to me, thanks.
>=20
> Reviewed-by: Coly Li <colyli@fygo.io>
>=20
> BTW, the shift overflow checking in md raid code is accepted by
> md maintainer, so you may submit these 2 patches with my Reviewed-by
> to Jens. That's enough.

Hi Ramesh,

If these patches are not merged yet, I will submit them with my other bcach=
e patches to Jens
later. It might take some time, but won=E2=80=99t be forgot.

Thanks.

Coly Li
