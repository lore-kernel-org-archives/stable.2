Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169A277C81
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681812; cv=none; b=FK08TbIyl+3h6N5FqEp9CD2q1hVMqlI0ZpiOofoDAPSHB+5+qycn5BPpw4y2ESfKBtVXYZyOGkVSWzLvtWh+uKbbdCup2V/veeyhSxaBN9I84Ehjb3RubdtrYqroMvXXkWrlvgZoqv9+P90lh4v+U6dnDczTmd1PAnlLJFzzDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681812; c=relaxed/simple;
	bh=XrpzSJ/DTTagRfedMl1HXHs8F7QgjqSEkRayC0Oo8wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNTE3YHuFoEyh8CBYEi1RIBz7hsjVJEVQSAw/gjSuVwPsIayx/W+x8nyt6UOjWjLUApYn5Lz0Xg1END/JpsdUxZGkWrJoGgB/wXfiD+3kQn5GfGClgoxzlXmfbZkEvXRbdSTUe01KLNU2C3LbZotkYj2xZt4VkvfVQh4IiOTzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=OUYCctiy; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="OUYCctiy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6NWM+eldm9EciYsTQn972KMZgMpvJjJhXLQrDig7no0=; t=1791681811; x=1792545811; 
	b=OUYCctiypQ8eEg7mxxYo/fvzu+C0tnFbACHejFdIiSEE/hVbOEqB3uUK/PRg5MXI8kapzTKWTRu
	DG4c7izwJ4EYO/kZMqlpnH4V/vsblIu0yJhJ5U8gY7OQPFbyCUp6hT4UGxCFkEcIunrQiFrZcj4le
	7MrHj/Iyy7+dREWNjHpgZwtQxQwGGxaFeNSEc7tb4TUS68vNP3itfdO/tSSj+NZb6x4wKl5sZihDk
	SzOKRmwNvPVRsdJJ/uDD0fD2icDXRRWHRUf1E2BEioQ0wvVGa7Ami3M4d7Hs+ZpCthRRpM+IPL05M
	/pZ1q1pkaCdsZacKmsh+qpuFw/lHHRWOJJQQ==;
Received: from mail-dy1-f169.google.com ([74.125.82.169])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xFiHi-008AUh-5p
	for stable@vger.kernel.org;
	Sat, 10 Oct 2026 21:23:30 -0400
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so3174086eec.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 18:23:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByd0a2BY5Lgik39FGmUUrNNhkUoPZ9N7uvsadXRCVNBprp9LzoiBeQcgWPeI/fJaXKlhB4uVrs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+MQWCIrn0h2KnqvKHbjH73e7xnhEqONfwGKTqSnEPBumCSi3J
	TmObCvnEcJHt2rH3jXI0e40AdPA9idccAU8v1qFnkVSYW6N+jX6lBqE5hEHGX/rKgCbgpjDvHkf
	vgJ4EhBHjTETLyElpFV0mk5EwjhQt9a4=
X-Received: by 2002:a05:701b:2092:20b0:16d:c848:d36e with SMTP id
 a92af1059eb24-16dc848d4ecmr5183168c88.13.1791681809283; Sat, 10 Oct 2026
 18:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009051857.758182-1-nickolai@csail.mit.edu>
 <20261010162558.62abcd2ec967b009d0cb3bbb@linux-foundation.org>
 <CADGQE7G-PAiJ2W8uhFO_-e9GGtEPey=drfSqLfWdxXDys3mJNg@mail.gmail.com> <20261010181016.44f5e2883b6820bb32c04204@linux-foundation.org>
In-Reply-To: <20261010181016.44f5e2883b6820bb32c04204@linux-foundation.org>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Sat, 10 Oct 2026 21:23:17 -0400
X-Gmail-Original-Message-ID: <CADGQE7F5SsRjqCAWJbwsT9P8+Uq-d_movTmiCM1ko=dg52kmCQ@mail.gmail.com>
X-Gm-Features: AclHuK_JytmvPKHV2JJKLmw644JZVHLd9i3B6iNoev1zmZ91lFgee4W5dbKHjvk
Message-ID: <CADGQE7F5SsRjqCAWJbwsT9P8+Uq-d_movTmiCM1ko=dg52kmCQ@mail.gmail.com>
Subject: Re: [PATCH] lib/plist: fix plist_requeue() shortcut inserting the
 node at the list head
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	I Hsin Cheng <richard120310@gmail.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 9:10=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Sat, 10 Oct 2026 19:33:46 -0400 Nickolai Zeldovich <nickolai@csail.mit=
.edu> wrote:
> > On Sat, Oct 10, 2026 at 7:26=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > > I recently queued a fix for this problem from Alex:
> > >         https://lore.kernel.org/20260903222456.1881786-1-handyhandyma=
n.adam@gmail.com
> > >
> > > The two patches are rather different.  Please review Alex's change an=
d
> > > and let us know of any alterations/improvements which you see.
> >
> > This patch is equivalent; I don't see any reason to prefer my fix
>
> Thanks.  Can I add your Reviewed-by:?

Sure, sounds good to me.

> > (except for the test case that might be helpful in catching
> > regressions).
>
> I like test cases and I take patches ;)

Sent just now.

Thanks,

Nickolai.
