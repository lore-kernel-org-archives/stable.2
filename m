Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664902E401
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966331; cv=pass; b=GWWXqdEkargqo4zytzq6KkKwqDA3OjrjAX/72qq2XfXEh477S7EhBEs92f5keHaz682btY+/IQh7AmGKcvtT4Wnl3pOd4zATaB2bWrW2OXl54Sa+hlArJ8CTn37TdfZ5exzQ4rJY+DyZO4S+EWtfpE1YbQvpRyX2Qx2Pksv3GCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966331; c=relaxed/simple;
	bh=H3gv+ci9yfAjmDlc2a9UttTAk5lYXYxzxqzvJDY175Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGf7l8YxKDArE/ntOFBGskdntw/Bu3QdcO+Rqrud+KIb8JP/wYZsVqlBb2QUHkOASg8QKJUkVj/ZfF8ZrrnyuN2ZWAQSbCr3h1Qc/0jxWttNy7IT58TK/5SZAteBf9TbLsRdUyiiz22r063U1SV/jGpFwZOsLjBWtnKMAhH/s5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eK1gpWjP; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eK1gpWjP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2020421077so235653566b.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 18:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787966328; cv=none;
        d=google.com; s=arc-20260327;
        b=Ogb4TB7njNOLv3axgJix9kI7B/z2PzXkkZqo6YR5aVbNs0wFBCo1Qms42FJ1BefzPW
         7SzgiPuK4RQ7s/l6Xhm7MhjowT9hWj8zYhx26Sh5A8BYNK5rGczrsnuW37CxYc0Nj4Uw
         +9LVN3dP2aVC0mCCwGgyzl98vno9kVulH2Ripr0dqGrdggDir/hdoBtL2QVgFIl8VBwv
         yrS9rDcGvBhsDROs197cIJdr3HIHv9uW1EYSU00sKaHGgKrjGPzCfUkfpU6xUC6BcZsR
         3kcCkzjjDzPSENw82Zkt7Z2aU/f6nbZBpyCM+25nMjGa0ODjoS5yTFX/+Zco7o+BH4ui
         3B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3aE45yjI08m8/n9wR8Sbg0vb54KLTLrJEoFaJwFWHo8=;
        fh=WaQjjLU1Wzo3i8/f3PP7jgehtYHdOvui15Y4OExNKvk=;
        b=l5/xXa3YDpOWLGpUUF37ZF4LZdVqwJ3Y+3L2SnLa0nTMNDLo0SO9sRKddKse12gTb0
         QYElGvjVCnhe+HP2LH+1m0y4tR8ZlaiZwBnM18waqYTR20tpah9wxCHP+ZEITW756bqQ
         mShHYP8pLwt0Uj5YevfWIz8x6DZb7B1czMN7ni/Ns66leKEe5khTyu8GkRlHOEgWJQJa
         8ksSGnbAFi6By1Chx6J9JW58IkWkRRssANytMDSULfUXrz/R4byZ2zUlx1iPTzzfKq3e
         uML3QqLtXCpCzN9NCgV7Ogvi30NrsYahb6LefNX/nIZVAemBgvNE4uoiSt34nRHwyY3A
         Hrdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787966328; x=1788571128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3aE45yjI08m8/n9wR8Sbg0vb54KLTLrJEoFaJwFWHo8=;
        b=eK1gpWjPtDyRKjl7QFdAztvDbGYjYy7wp4egcGshXwuaq6icFvedO+0yGMI8Do3Dv/
         K9XcQFMIXg4kCQ+IXQtsS1f/alW4S1VDGCYHb7+t3iwCh4QIo0+C7mF9UUiujgN7wpZM
         n23Dtm7r8pVTU+dmrQLL1I7EyE9f8eEkXP5NiIuHASzKqqWoKfKdO5wUfOzQ5uxuSP0U
         DKi+hg2K1wh0jAdn31/A0jeu/KDULzOOCwDGkkF439dlazFFLkc+CC6DaBcSBxOi4sIT
         5vfvqo3qTZT5jOAhgINr7aLJw/43PBgH9T8FY6UPuhU0tC5PnRc88/r8rJCY5tktyNSE
         bN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787966328; x=1788571128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aE45yjI08m8/n9wR8Sbg0vb54KLTLrJEoFaJwFWHo8=;
        b=Igy1PInRnN6p7d9qIAH2yD8Bmli0fmtBcOGFnhmXLfGwUoUf426Z7CeMUqe9Z09mz4
         HvPro5iJ5Lw/oiLQ5VsLNspF2lRtcmpQinkD3zkX8EMG520FKNy5Lj4lSX76A94vz1GQ
         wcf7o4TG3v7wwT0qIP4XXjoLbl2BlAd+ufM3qVP7F61E96biJfFT0i3v/PPDh/+d5Ihh
         k59LkDxaX5v6syRc0eqzSqlZ+J6LwM/viOY81SH405c29XJdVVmyymaovEHfnGaFTHta
         A/pwqAr7npf1XrcCMErVr0ngct0SjjaH4Ez1zs/HUePD0pusKI8hc8IeL5aYoBnDYfFf
         53VQ==
X-Forwarded-Encrypted: i=1; AKwUvBxt10Y5t11AaGsUC5V2G/mySo3pmWAXDwdbAhtllL25pZIrvLy3HTUb8pOxP+AlnywX4PXdyss=@vger.kernel.org
X-Gm-Message-State: AFuF++m5lW3Vs1d7gv+B9MfbVeeWukLaT5gIVDHgatK3Ibl9/p+hW3gu
	d/iZvHhANM9WjjVD1z1abjfs93df5OdqpNNT33QARldwXgxypgLXBGBWswUD/l959jBGm2vEDXw
	+hUH3ISG7uTGRIORVmAF4P3A9mMNb0eqFFCR4UmWA
X-Gm-Gg: AR+sD11lWAaVbVDG8IqTTI+pCcDNowLinx2MAPlhtpuw21fp4Uk2w32TfK5VZulkoq/
	VWEEmN+XOQB7VgstHyeAu+tbmPI02VYa/lciE6RnRfdC07jzH+WoYvw99/lmp6Eazvw4L6PQaHV
	gTFhEjwGXEWgOHdFD3Yb+SNy2qIC6lZXUrL00JpcnRHsh3cTOSADdWHSu/o/JurlUg09Lemrqo+
	bdZwv51QA7zvwsqWE8ueuknbj2D1cR77s74jVepxHqcfUzZaCZOmJvt6RrSDXMgpfaXVO/v0QX2
	vrOJ+NY9Za3Gw9bXwDSiaMOv2IK1An9aFM4mdHTuvxeJLbB745/D7WBwChBm9XXU+u0KdgL81og
	XRuFYOeCRc302XPYrmHYY9jIBauqq07sqmfQN/+Oe+bLPnswaAiaZt8gEF9YvCyyyT1GnBrNifc
	MYmPtWLxoWAM16LA==
X-Received: by 2002:a05:6938:a092:10b0:c25:5eeb:4c00 with SMTP id
 a640c23a62f3a-c255eeb5579mr473776566b.7.1787966328124; Fri, 28 Aug 2026
 18:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828222640.1638457-1-jthoughton@google.com>
 <20260828173302.29778f1bf802a1db932778ad@linux-foundation.org> <CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
In-Reply-To: <CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
From: James Houghton <jthoughton@google.com>
Date: Fri, 28 Aug 2026 18:18:11 -0700
X-Gm-Features: AcwNN1VQFp5gp0oCn-gKtkB6rZ9iIgxR8OPs2LiIa4f6Frg3IYBz6ouINZI-z8o
Message-ID: <CADrL8HV0nUDjr432S8AdTZ_HO8fACrFSCu8cS49vR4XJQa39zg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in
 uffd-minor-registered VMAs
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, liam@infradead.org, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, Yang Shi <shy828301@gmail.com>, 
	zokeefe@google.com, hughd@google.com, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:09=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> On Fri, Aug 28, 2026 at 5:33=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> > Wondering what Lance tested.  Was he able to reproduce the bug?
>
> I assume he just re-ran my repro, but yeah I'm not sure, heh. Lance,
> what did you test?

Ah, just to be clear, I linked a repro on v1. Here[1] is that repro.
Sorry, slipped my mind to also include it in the notes for this v2.

[1] https://gist.github.com/48ca/d399bf534158e80241fb4937ef1ff664
