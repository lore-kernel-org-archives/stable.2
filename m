Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542DA36606B;
	Fri,  4 Sep 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519117; cv=none; b=olJAZihA22RT9fN4ae90RYBHzjslLG65i7lzC/68/OEnSUN/xx6+1/2vD3rYCEQFRIDD/1UXsSbeoMc+vJ0OwbhPQldBHrDV9jDIcaNzB/tvhpF49HNkmkAcxwY5EUBfSysv0MAaC8/fLLxw/fRQEzfsgjM233woO7YoDlxcgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519117; c=relaxed/simple;
	bh=rF1iIKdnD1arpqoiak4GAiMJte83ZTCC7sRmA66w/tY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLoeSnwSBcIS3njTlyC/zReblMDEG9N66FIz6hh527CCUAk4YGd/Caqe8ug+Ax0Vf4Erno8/1wVnTVsJpFsI9GMnR63tP7+AGyJLrMesOdylaNNnzszSuHiCJ3KEp9j6aKWAGZK7RE6elyu/hIZ4CmeY6v9M+rYgiK3XxhezpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y/LpR9Cr; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y/LpR9Cr"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbtZH59vkz8tyG;
	Fri, 04 Sep 2026 12:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788519111; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF1iIKdnD1arpqoiak4GAiMJte83ZTCC7sRmA66w/tY=;
	b=Y/LpR9CrtAx7PqoKF75627q5BCiO97S/1Sh06ZLgNceEPJPM6KSvbffv9rKSbExDDP118D
	YttwY9FqCjI1jPJZbiBsOyA1vrcyc9BCEZ1oVPG3Q4V3QJvMhTgokFnzphbWNp+eS8nnqM
	oRXVVAJv0h60cwDz6C7OyOM1sHR6ru5wJJJxst7WeU7OTQADxNpEQjGG7UD5kwdJeegW50
	otGZvwTODFuT52Kq/SHYm4N+fZI5CqA9kZgZrb//wpaXy444i2P5fx/nuHtjEl9qTgszIG
	muMwtBuk1LK1wS1u7GsOfmt9BNa/rgvKE0vraEvXCYWnUQHOJS0jKymL4qAa1w==
Message-ID: <3958ef460d25cd7bc2a72729c8bfd8ade4dc0b79.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, "Jonghyuk Kim(MalHyuk)"
	 <malhyuk97@gmail.com>
Cc: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net, 
	matthew.brost@intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, mdaenzer@redhat.com,
 alessio.belle@imgtec.com, 	luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Date: Fri, 04 Sep 2026 12:51:47 +0200
In-Reply-To: <DL6FYL70FVCX.10MCZIPFSVJ5G@kernel.org>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <DL6FYL70FVCX.10MCZIPFSVJ5G@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: i5bernthh4t84ra48qtbsp7gwf9h4u8t
X-MBO-RS-ID: 60fe534f6ce160e7ad4

On Fri, 2026-09-04 at 11:57 +0200, Danilo Krummrich wrote:
> On Fri Sep 4, 2026 at 10:06 AM CEST, Jonghyuk Kim(MalHyuk) wrote:
> > Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document t=
he rules")
> > Cc: stable@vger.kernel.org=C2=A0# we don't know since when
>=20
> How is that?

That is referring to the fact that it only is a reachable bug if the
respective driver exposes a mechanism that runs into
get_timeline_name().

>=20
> More in general, putting "we don't know since when" for the stable folks =
is
> rough. If neither the author of the patch nor the maintainers of the subs=
ystem
> can figure it out, how are the stable folks supposed to?

That's on me, it was a joking phrase by me that Jonghyuk or his LLM
picked up 1:1.

Anyways. So would you suggest backporting a fix as far as possible to
the amd origin commit? That might not be backportable that far, so
stable would still have to figure it out.


P.
