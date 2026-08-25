Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E392F617C;
	Tue, 25 Aug 2026 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621817; cv=none; b=aEgdVIfy9inp4naMOvyj7qAtNS47IV3d3dhTIoB44UeLa6J+teRX/r+vdTO/YFlCDW840/dXbINGM3Hp51MC6L91ts56l9GzYWnDQb0xROoWpxDHP/B6+yYznFkDG4T0IR3XdLveiYlkBFNRcBTv1Qm0He8RiZV5CY0uJPn5HtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621817; c=relaxed/simple;
	bh=ehycwOTMY9ZC3berHiiIu4MNS2/KrfVKO/tl7ivzsh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIDWBTYiwWXZ/FcFOztf8pOSDJR1ufjYE6aC+zjJqRtN6g7TlBa5IuJqogk3q4Ok9rcgY3pMzT8n/9VOgJBxPGiOjmC1p8ritXUakG7yqqFM3xmD588BRvK1cWDVgZFcSlPd099BJoeLTPUtSZIH8OQVZ2BylMbkPhtuJA9RoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=fO26jlWn; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="fO26jlWn"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id ECB42402D1;
	Tue, 25 Aug 2026 01:36:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 03E9E2002B;
	Tue, 25 Aug 2026 01:36:49 +0000 (UTC)
Date: Mon, 24 Aug 2026 21:36:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] eventfs: Initialize ei->children and ei->list in
 init_ei()
Message-ID: <20260824213648.170f69f0@fedora>
In-Reply-To: <CADhLXY70RXpWsSNToYGsFniSht__2nd8xma4bkFPeR1kyWcL5A@mail.gmail.com>
References: <20260824144653.54044-1-kartikey406@gmail.com>
	<20260824110345.22c1cfa1@fedora>
	<CADhLXY70RXpWsSNToYGsFniSht__2nd8xma4bkFPeR1kyWcL5A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 03E9E2002B
X-Stat-Signature: ebwrn6ke76gi14hct5s5fx56j5btxqpb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PaWPrmnCvwGQBJSWiDa/tsReUClQROLw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ehycwOTMY9ZC3berHiiIu4MNS2/KrfVKO/tl7ivzsh0=; b=fO26jlWnGjVULGDWjPNkLgJ62fe7Z5w1+otVoXArES85kJ1mNXV6AYAdspAesYnWUnjFG92o9NhU0fizfDTYRY/2HRcVzwkCS8fWvqKMtZYG8mug4AzIX6OHwafllJxw4lsTqgO6Tlc/mRdn/3DFawaWU0+m3d4eOMeMFp300PI=
X-HE-Tag: 1787621809-264223
X-HE-Meta: U2FsdGVkX18fpRjGrQjwyC7kSKN8BxX9LslprbQv9fPKewgJCkKYk2nnfKJn/Ie1NlbZnCxReP0UeHN1K/dlXxVnEy1FP6e7UMn6q+ZWo81X+BJ86mQptrjFaZ94m35GZXXQ/zogZUFMzDmZIxXSUCkXXWqr9lGk70FLKGoVbQRoq8csT7HHnUQebupSSrf5DBe08rLmZX2ebfqDvZyUyzKhgUl7LFlEu8lBfGW3HrxjTOugG00xJSbIwmqOOdc5e0pGvi8jYBDAuRtvjM95q+DBna0yxh2M63f7rQPUJxqFa2f8dWbOo1qzEDEiMLeNzLW+NC4opB2yWWEBsN88qh/zJAvBJ0/Ltpwyf3k2tSo4hSE6dBIs6sgyjONzoHwXDTj+AqXVYLRuPc+wxgZ19g==

On Tue, 25 Aug 2026 06:53:55 +0530
Deepanshu Kartikey <kartikey406@gmail.com> wrote:

> On Mon, Aug 24, 2026 at 8:33=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Mon, 24 Aug 2026 20:16:53 +0530
> > Deepanshu Kartikey <kartikey406@gmail.com> wrote:
> >
> > Yeah, I saw the syzbot report and came up immediately with this fix as
> > well. But the change log is way too verbose for such a simple fix. Did
> > you use AI for this patch? If so, you must divulge that information,
> > usually with a tag.
> > =20
>=20
> Yes , I have used AI to create a commit log . I will add the tag in v2
> and the commit
> log you have suggested.
>=20

No need. I pulled your patch and just rewrote the change log. It's now
in my queue.

Thanks,

-- Steve
