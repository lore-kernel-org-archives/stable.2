Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9C13E02A;
	Sat, 22 Aug 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787433006; cv=none; b=oZcE/bPjhZhjodxTEkXZDYfxZgxoXAOhENmKv7Sq8egwh8pU7Rwsf5pj3vhDEXprWMKUorRfQv9hBG1K1wZN1le6PVGvJygqODH7Slei7CVgSW/bD3cbDNdSHHKK4pu8RGUZZPb7NoDsJApvXiYG3cPata2R6G5G7Y3U/1HiTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787433006; c=relaxed/simple;
	bh=a3hw2EN0ToEpsukzbkSaE1ljQxz1fX36hGbSCE4KXTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qsyclz3GUmQdBQgH/2tZUeMrf/Rzs2B1Y95tIhW/EM9oopmUtjs07UA9DI3NuyBpU2FNK6NqnzkXXeX0eJOhzNz5SLyKrKL0Zg+eyUgIDWOv/PT6ND6TwjcrYQKHyNnhirEG5Iu0gazh6HOBIv84dzZWHBEuJRiybiYmBj8OG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=cZd72qi9; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="cZd72qi9"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id CA34940203;
	Sat, 22 Aug 2026 21:09:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id D60A32002D;
	Sat, 22 Aug 2026 21:09:39 +0000 (UTC)
Date: Sat, 22 Aug 2026 17:09:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <include@grrlz.net>
Cc: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, bsegall@google.com,
 dietmar.eggemann@arm.com, kees@kernel.org, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] fork: initialize function graph state before
 copy_exec_state()
Message-ID: <20260822170928.1acba2cc@fedora>
In-Reply-To: <4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: bchptuiitregw8grxmyadnsig59ji9zy
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D60A32002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187Mxv5W4DFJ3fURMYUvMnrhDd8uqR80Rw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8tizi2Uz63VDjzZwu+pGZmliKPuwtoD7SrzZgbbbMac=; b=cZd72qi9ymxUl9V8XfieHWrIXrJ1PnIzyJy+BPyUoZrE9UlS1TULy/OrTaw0wO848HgkMqFDmS2QTWaSfHHIaxvi58GjfP566ANuzX1viHqvMYZh2GKd5g98sj66woLci9OVSoVcVP1aXikh2H3LscvPwIPNvQpx1J279Q2CNX8=
X-HE-Tag: 1787432979-424543
X-HE-Meta: U2FsdGVkX1/CrHML0TEz1SejKFmkDQnB4+yKcjQD66q8Jcu+lGWPWRCs5jyXT3aVqU8qktRFuQNQhr6DRgV/hroJHlTbByDPzksYd2yEIXrXn1wGg0AV8iDGQCD04ysBGEA0GaxkiSRvAdqOGoLfLVhYopv1sGOP+9U1Y3tKeC8cZsND7kDaEJny3ouPRaHP9b3Mv5J3czn2EUYy7qEhXOpWH45TNyhEphrDGaGdtMeC3MLLHe7OorJSN9Y7OS7kqw0zHcCjXoyU5LRWKphlXUx4STKkxO8RPpUOr56rBwhwC7lrSJgPCl6Pv8CHB6/fS6gbvhTxgZ1uJ6CKT4Abp/8pMJVjhqAhgTqm6ucrSWd3ASzCABe5VBKvQ5NQdCXTvo+3XJKR9laQVlc7BzA3Uw==

On Sat, 22 Aug 2026 20:58:15 +0100
Bradley Morgan <include@grrlz.net> wrote:

> >Fixes: 6b1c66c9cca9 ("exec_state: relocate dumpable information")
> >Cc: stable@vger.kernel.org
> >Assisted-by: Codex:gpt-5 =20
>=20
> Where's my R-B, nothing changed also, it's V3!!!!

No need to get so excited ;-)

Anyway, as there was no change, it should have included your
Reviewed-by tag, as it will not be automatically added from the
previous thread.

>=20
> >Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> >---
> >Resending v2  =20
>=20
> (no! V3!!)=20

Right, when resending, it is best to add "[RESEND]" to the subject:

   [RESEND][PATCH v2] fork: initialize function graph state before copy_exe=
c_state()

And below the '---' have:

- Resend to include linux-trace-kernel mailing list.
  Previous sent patch: https://lore.kernel.org/all/20260822195321.962383-2-=
Jeremy.Jean@oss.cyber.gouv.fr/

-- Steve
