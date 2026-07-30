Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B842DA775;
	Thu, 30 Jul 2026 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445610; cv=none; b=uHSr6NLsRUulLoM5v2h5hI20mJYoKRc4qbxxN3eAUVUb7dMDMKUbsph/RppVxCB9Ui1SpL9s/nzYS15M+D56LGO1WQWlDZgKA4OuoJh2O1p8JQcSw413lzEyso/pzVAzTP4RI21AUzL1Fgwc5v/bZxESqZzAoJpKzA6lPkpPw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445610; c=relaxed/simple;
	bh=KxelYWF/F41KXmJ8u1h6ZFfcYubwn1l9Qs3L0Qe6qCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p6onY3e125F32qFYY0eeHCdcF1pRLfja6Eh89qdjXAYdOTuSfFCL6l9BYLoFEM/3JohqXyJJzaj1+IicRkJ3NA08hMr/VR5mnF0KizklAtM+goNgU3Hq1H7WDpFR2209HODMQxEm/3CTVQIPcFgn80NDw2ezfV1C2LZ2aKnbg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOQLwlTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOQLwlTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0CF1F000E9;
	Thu, 30 Jul 2026 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785445609;
	bh=OFST+NgxWTnRPSf6qIpveSKm4ok7+382sIeO8pMDckc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fOQLwlTfADB8niTHmxFz3Ah8nmUO6bt5InFevhctbx3kMRaLTNW/MPHgEa9MUp9m5
	 7DlbaqJdxP7Vmp4GnzJ/rsyFQi0d3DRMydDkyivUwOqgWvyi9Alvyh+QyT8+B4Dj+P
	 /SYqTWwnlCy9RUbBk00xBG5GoGZdCycd53ap3KWSyUXorIyLx3Q0H/+fuK5DQJzZ4l
	 +Pan2KudiaMRh7glQp3W2JF3jsX6O4XT7D+S3FYoV8vQsjuJrABqu8m51byvR6QPJl
	 nDpOKhXc+sonJAFkYdJAhw1B8g1XQRUch47FWCjiKo8qzTrAFC2x3GxlyId4wgDPcG
	 Gx4mRBIv4HAlA==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Florian Weimer
 <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <87o6fqhpcw.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13>
 <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13>
 <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
 <87o6fqhpcw.ffs@fw13>
Date: Thu, 30 Jul 2026 23:06:45 +0200
Message-ID: <87fr10faqi.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28 2026 at 21:43, Thomas Gleixner wrote:
> On Mon, Jul 27 2026 at 13:23, Keno Fischer wrote:
>
>> On Mon, Jul 27, 2026 at 9:12=E2=80=AFAM Thomas Gleixner <tglx@kernel.org=
> wrote:
>>> Reworked version below.
>>
>> Patch looks good and passes all my local tests! Thanks!
>
> Let me write a change log then ...

And while I did so, I came up with a trivial optimization for the most
common use case where @nr_wake =3D 1, which allows to skip the second list
walk completely.

I'll post that final patch in a few, so please have an eye on that
change.

Thanks,

        tglx
