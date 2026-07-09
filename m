Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A1EEBA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561996; cv=pass; b=L5ZExg29AmWoNXMA6E/Ds215buA9+TfKyT//q6DqO9a74gVOeIH+B7CVilGoZNceHR+Mqn4NFzVeqkpnJtcU1QJ0oMDIr/PAzlR4P4ZVc0vov1R8xrDPkpWQjlNEJSsBQcHVUr2NFXAUrXzPVBbf7s75zFek2luSDRfpd8rRo50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561996; c=relaxed/simple;
	bh=PG4hFnmpqMvqWJbXz0n9H84WUl84ksuC5zjG4yT665c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXrYr7xpBgviMEbMmZ7mo325utR55wmTxILdb5XOW6fOoKKahSytZj9MCd7meT8KK+n1UsZlkxAtzpSTQ/QAjzSCqjQO1jEm49fzEIISiCLx85SrZo3UD7sVfjju6VJVF8hNmgmZQwhhEt3XbHDYvTCpIL2MvR/y/uIl/t2yWWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0/ICsQh; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0/ICsQh"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c96d7933910so103872a12.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 18:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783561994; cv=none;
        d=google.com; s=arc-20260327;
        b=be1Q5fZwi/LwxxiJnHg9un5B6rjcCxB0sqaIYlG0XNq8Cy3UizfW+02n9KrByAzLQw
         bZgog8k+SKmIiAQb4JmV635jfH3wbykeg0uipDO+FqziNRtpg+xxBE28xBxNG0sVHZ5p
         jh1dWZtM3amLyfzUGBq5v8JsL0jArSkoGlNZZbUujrjjwOVppgG58r9P2lA1QSw00F0J
         c8kXDEh4WApxdEDrPW45b7VpKyQz1gKFxJDu7LkiYAFVqi5cbEoGMPi1OH38pYOLaYkx
         LTt62fyIx5xRwpC7BFWd/FcnUb50Fm1Ymvjk4fhAfjrMIDhCXIRjsBW/W+PkAm/RF4fO
         zLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPLjwZvp4TlefGbzSxmbvq8s8H5xbEym4izUi26G7xg=;
        fh=jzD62sr308iAT5QHYYvoTmV+fT28zg5eCmYmUVtXvxg=;
        b=EFR+rvPXCvOR/OxworYcxb6aR3D2e9HWwby+ufgns0KZJDqwTejrMi61cFIuXFEObx
         cHE5i7W0q38QSao82MzH3rEkrajqalWVzBAjVp+fY92Y2q3kxIsImwBt4Tc3iFM6PfRx
         7YdeOBIudZFwEgBjwoyK3TfMrJOYNe44WjX2PJ6/BMsECj2fFFqOFsHrVL0wx4NUgJgW
         Nyui6H7QAGNIZvrKUc4IPnlUmN1tfD33PY/fzDFnUabJOLz860jU8UWK1toSP7P9RFBR
         n1lQ0gM5psivyfjKVT/vbWH6iaH2joYdZ1mapv1j/JaztVpcOVMr9Pqc8xF57jeeNBEd
         rcIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783561994; x=1784166794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dPLjwZvp4TlefGbzSxmbvq8s8H5xbEym4izUi26G7xg=;
        b=s0/ICsQhjDbYctnPE4SWgFk6+WMuOgQ3Dz+JObCCYdnUFJWXGBdAUuLRU16QqNiN1S
         XqImgBchEsQYjgarUCH7AOod+Zyz/X8SK4oHQ1ExkmWeuLbRJGbxZOLKU+xAsj9DZNeY
         lx5mC/L9BOcgcXzJNn+jIsiDrEAXsg3qv2cZPMjQtqh3FN6xeS3t8wirH8DZmyXyvIBH
         G7DCnYZ+cFX5BRwzU4JzUXZVLR8WZB9FBeHi2g9oVUX8aQedHmOPKX6NdL/oPcrq5Enx
         zw1z3TfGpktzhCd0Ea0V6qhdpXBJF7gTExSdBG27bUWcD8ZbNIV6q9A10QzE62LDInLX
         UCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783561994; x=1784166794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPLjwZvp4TlefGbzSxmbvq8s8H5xbEym4izUi26G7xg=;
        b=TfeLdNCByrCh7YROq5uGOe277pmQI0nnZUojtcgM+J9qFoh/ZVGEbVvdcsfFljYSp2
         fJhTaJpDg283O1BOPYKIL/P7wK7A44IMmcIaOcXz25nKkbWTIk29q+VeaZtT5VKz0ou0
         3DXo2SH6S9kKXId8o2vUd/hjUmbFnTjkcNKfaaQeBXLGso/BuLRkxUNCZ6JiKmU+GSTv
         UUemlSKDqZ5UXsfL1vz9MxsXBLlaDfadiX/A98J21t4UAMNCyIPdUq6Cd2rjCD/LCMXN
         swJvVqTIumX0gagaKZ/ueoFZ2Go8tgVoIYReXVktwhFPHFVcY5cLg0wry0AyhmXLansI
         nzZw==
X-Gm-Message-State: AOJu0YzjP/jZSXp5aLN5WWOJMWfs3+gspYhFaLHiN7rUWbdVWo9pkehX
	PdkS+lzUOBBuPbi5lntp6Um1zH6L7gCvxxJ/N3TboJtNq1uz61aGbZPYFSP/5f3iDC/IIJzu+2u
	UIuzqplRNEBWR2wj/rwCtvvOndwZfUwA=
X-Gm-Gg: AfdE7cltrneomcmZY/YsmN/OjVOx6TWCgc66hio80VNKfJg05wc7le52aBimzyiW/+q
	mIeruPiG5bikbhV5/xvCv2NP3ZNtSsqbecN/7H9ztX94eMQsI1Dr+QqUVpJcXhRXuzWJbIR+Nbk
	HKhStd9dl1+72S3HtSxHEePWxH9JOJHVPKF0DJmVAjdtMjN5Je5LQ7vzQm0v7Rq44KwT1mUZBf9
	QAL82yjbvI9umafU5/JyK4QIo6bAaD59SHcuk6Mi5JdTGlhuV5gZjyAGV6njKQtftlMPIGP
X-Received: by 2002:a17:90b:3502:b0:380:7688:fc06 with SMTP id
 98e67ed59e1d1-38a21af6569mr1485773a91.8.1783561994547; Wed, 08 Jul 2026
 18:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708150527.3212183-1-sidkumar1@gmail.com> <20260708194323.agent5-0004@kernel.org>
In-Reply-To: <20260708194323.agent5-0004@kernel.org>
From: Wu Frank <yifanwucs@gmail.com>
Date: Wed, 8 Jul 2026 18:53:03 -0700
X-Gm-Features: AVVi8CeEaa-5KAjlmQtSl9i5_8CTGyXAR2_zQzwPctghpHS7EC4glwzfeAqn6Po
Message-ID: <CAPw-QwdiQnbxiwrivx8HthquyQef4herojq15ozy2JgWa8sAAA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] rtmutex: Use waiter::task instead of current in remove_waiter()
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Keenan Dong <keenanat2000@gmail.com>, 
	Yuan Tan <yuantan098@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>, 
	Thomas Gleixner <tglx@kernel.org>, Sid Kumar <sidkumar1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 6:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> > Use waiter::task instead of current in all related operations in
> > remove_waiter() to cure those problems.
> >
> > [ tglx: Fixup rt_mutex_adjust_prio_chain(), add a comment and amend the
> >       changelog ]
> >
> > [ sidk: Replace scoped_guard() macro with raw spinlock operations for
> >       5.15]
>
> The backport itself looks correct, but I can't take it alone: upstream
> this commit has a Cc: stable follow-up fix, 40a25d59e85b3c
> ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued").
>
> Could you resend this as a two-patch series: this patch plus a 5.15.y
> adaptation of 40a25d59e85b3c? Also worth considering as a third patch is
> 74e144274af399 ("futex/requeue: Prevent NULL pointer dereference in
> remove_waiter() on self-deadlock").

For completeness, we also reviewed the related patches yesterday.

Our understanding is that the correct backport set is this patch plus
40a25d59e85b3c. This patch fixes the original issue, while
40a25d59e85b3c fixes the NULL-pointer dereference. We also noticed
that 40a25d59e85b3c appears to cover a separate
use-before-initialization case, although that case is not relevant to
this backport.

I do not think 74e144274af399 should be included. It was later
reverted by 39def6d250d3, and the revert changelog says that the issue
was already handled by 40a25d59e85b3c. It also notes that
74e144274af399 introduced new problems.

>
> --
> Thanks,
> Sasha
