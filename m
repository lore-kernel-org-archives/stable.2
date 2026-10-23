Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767625;
	b=1CZHZK4YPQqbl6HWHnjrC9O/mDaZca4x9s095qVIN89gNiOopwxEasSMo8AjOmGeHBuL
	 JIjHk9DlQbEivG56Pm2gCFhORFJNF1VvnWOU2jhJ0j3n+wHZRFRSoCffvmPFmcw6j4u+D
	 kgjvAJch5PHWN9/lPL7mte5KvoSuaNW900iPNhoVT/r1BmhHAH7NZulwBbjwpLI4rqRkT
	 h5lZI9O6REVe+IOxQF+uVFegtFidZhQp4KZe591GAopXQCXWA3ADjXTgvH/sRnXeFBSYP
	 HsOp8uwsyqpAxQ0xzqOOIVOeY6/08ydDF/mi6lHecqQFrT5na6yU+bM5Ilp84GPHwkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767625;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=GTu+v8DMOAbysoph/cbjE04nLy4WCnUvKq56fF3kka4=;
	b=GRvDjDPz+6AFXTwEc9mTltEIev5GiMjJCwyAR2jaiQbup+seNp43KrTzauBbDBvX42Kg
	 P9aE3skGK+Xasaoo0E4xNWVPur+qAiQbJ7iXiLg4scNgV9HJmmd72M7/JKeoXBO1L02J5
	 LHaHernw8Up6qI6stEXRDiGC2jNdyFPc0uiBCl4S6jj+Pp23Vc+hGXHvn4wSAIyMelgjQ
	 9LKfbeEhK45PBraPtIlQflCfw1VrGG/rFrAVMeR7YmVL8bV9S6u2nezAIHmt1qSCwSQZc
	 BIaBLywLnGfCqSDiCh+lmeTMKwtJ84WEbkrOS5pkA6x3VrcNQCRB6XU2NrWAasAq+0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TI9Xr+8o;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F6606A329;
	Fri, 23 Oct 2026 15:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TI9Xr+8o
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A963AA013B;
	Fri, 23 Oct 2026 15:00:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A14466000A;
	Fri, 23 Oct 2026 15:00:18 +0000 (UTC)
Date: Fri, 23 Oct 2026 11:00:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michal =?UTF-8?B?U3VjaMOhbmVr?=
 <msuchanek@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261023110017.72c9bf20@gandalf.local.home>
In-Reply-To: <atsYQtXHRH_cCQ5A@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
	<20261022181817.49717-1-amachhiw@linux.ibm.com>
	<atsYQtXHRH_cCQ5A@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A14466000A
X-Stat-Signature: tsgqnq55n4bydcajbc8ijqh5raais9q9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dr23hATlAmtnFLsRTaJj5AYAM/0nesZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=GTu+v8DMOAbysoph/cbjE04nLy4WCnUvKq56fF3kka4=; b=TI9Xr+8oVB6/+eVuQw+nTLqDmoNjjNuBMRtAMGsUhsE7X0UQlJMvu49btqrDm9TTIsj6gH+vW/oYEGjQIpQ9XYrYUvylOdS1PCiZ8lzx/KfRuG0Ccmcw4xO5zGBJpWLbkbBYvny9UNF1jhMFUwvB+c74cTvapHDCVly8gyaQsf8=
X-HE-Tag: 1792767618-41480
X-HE-Meta: U2FsdGVkX18eMYXpWfWbgSCecZIfpE2quM/PgZsA53xA0TIJn+8ZQ/5BZDMttsoN5sWy8uyv2gK0+37paM/0cZzQYcrbooTiMVkW4J/bog/mmOWcE75yU0KRtXc6eRTVe1QmX4AuA+Eq3/zDzCCrTQEaOMU24HmBuHDQ6yb8kPvuWcvSJC3ZTUv24CH4QfhAghPvRzh6GhzExdPK2e187Zc9EKsFV+8cFl0bWcqdOVBkhxtnSO+4SMymwGcoybpxPTu/WaGw8SOSXwIRtpE/quLsB+2OBLvDKfIycX0XhNaJhHU2+30azvxnzwYu5+4Mq4bga5stik7X6fhgzH91y2qmUPFC+69y6Emm5KNzXcJ6DXrqFUzE5jARsrBvoWwmLnWdSTzyU/M=

On Fri, 23 Oct 2026 09:18:10 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> >=20
> > Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before =
allocation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com> =20
>=20
> It is usually good practice to not use in-reply-to to link the series bet=
ween
> each other.

Correct, the best thing to do is add a link to v2 below:

>=20
> > ---
> > Changes since v2:

As in:

  Changes since v2: https://lore.kernel.org/all/20261016134247.70722-1-amac=
hhiw@linux.ibm.com/

As versions in threads of previous versions gets messing and confusing. And
in most cases, just dropped entirely.

> >  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefo=
rt;
> >    update threshold to i < (nr_pages << subbuf_order). (Michal Such=C3=
=A1nek)
> >=20

-- Steve
