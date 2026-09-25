Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614894AF9F3
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347023; cv=none; b=ArpRso5dV3/ewi2H4bHjlZcJk1J8vN9QMS6jlkWkIMuhSYqmbMbVOyXqdyhropxMS9ef3SaOKybiaRplYBNfV6mybRG9hS72XALRACP8p/vfJX4CFfdJd2eei+2FpkWpduIbnQIDs47hOkQgx0RvxoW1ftp7+yWg3YLQ5WhnVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347023; c=relaxed/simple;
	bh=yVYbgpctf+cIcCi/3azkcmMVYQ2W+T1GNvOQCWr2MoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmQgg5SS/SYHtheT6C+zZxARL5nPx0C5pOly30NPgfPRspTNXJ37ZHzUeRQsNrn2gEDuHZ1H/EtnNMtqlMpt5mCI4kbSfuHj4zI05pe4jxb/FH2k3FxBbvi0KQODKGrnIYHyvi3B8YCC0FerUPEMzD/bRjYNrOooStkcZ4FdWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WlK5r/wP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WlK5r/wP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0BFC4E41072;
	Fri, 25 Sep 2026 14:36:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CDB96073B;
	Fri, 25 Sep 2026 14:36:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90638102F1E10;
	Fri, 25 Sep 2026 16:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346988; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cho8VxMpsdgUEHhTUgNDONJA8kzPaWVfHk2YSHY12P0=;
	b=WlK5r/wPvrmwFvwC+CgaqGYU/TCjkUDUSgcnMPCQx1tj7vT77hpeMAQXZFwglnXeAsugLK
	O7h33FjAZ16k0+ZOR6QFUu+FdmrZqjwFR0nA4++9W8WnxR4QLuLJakJrJkAD9X/G37KQBw
	KmoNwfVOphnMaTIgyv+jCSLQ+I+swwR4ASz7q2xtPM0uRbIxnKrYy8oF62CbBJQk+hV1IV
	bG0jzd4XeQIHHO0/qIOZHf004LxbrlesrTMKbXaZyHgAsNQQFaBYBy5IXmoOv0ShEKTwdd
	eSziNnw1Q7lSdxm7TTs/naVFSw3Nl3slFPdaeBe3VJed59vOOIjpIWUHYwaPaQ==
From: Benjamin Robin <benjamin.robin@bootlin.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
 "miguel.gasquez@bootlin.com" <miguel.gasquez@bootlin.com>
Subject:
 Re: [PATCH 6.18.y 1/2] rculist: add list_splice_rcu() for private lists
Date: Fri, 25 Sep 2026 16:36:27 +0200
Message-ID: <8TOvOdgDRsCPoDckusflIA@bootlin.com>
In-Reply-To: <JyCWa7ltR_KwJYUaBPJh-g@bootlin.com>
References:
 <20260925-cve-2026-52988-6-18-v1-0-680b24895415@bootlin.com>
 <2026092540-jokester-certify-1339@gregkh>
 <JyCWa7ltR_KwJYUaBPJh-g@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Friday, September 25, 2026 at 4:28=E2=80=AFPM, Benjamin Robin wrote:
> On Friday, September 25, 2026 at 4:23=E2=80=AFPM, Greg KH wrote:
> > On Fri, Sep 25, 2026 at 09:52:23AM +0200, Benjamin Robin (Schneider Ele=
ctric) wrote:
> > > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > >=20
> > > [ Upstream commit f902877b635551513729bdf9a8d1422c4aab7741 ]
> > >=20
> > > This patch adds a helper function, list_splice_rcu(), to safely splice
> > > a private (non-RCU-protected) list into an RCU-protected list.
> > >=20
> > > The function ensures that only the pointer visible to RCU readers
> > > (prev->next) is updated using rcu_assign_pointer(), while the rest of
> > > the list manipulations are performed with regular assignments, as the
> > > source list is private and not visible to concurrent RCU readers.
> > >=20
> > > This is useful for moving elements from a private list into a global
> > > RCU-protected list, ensuring safe publication for RCU readers.
> > > Subsystems with some sort of batching mechanism from userspace can
> > > benefit from this new function.
> > >=20
> > > The function __list_splice_rcu() has been added for clarity and to
> > > follow the same pattern as in the existing list_splice*() interfaces,
> > > where there is a check to ensure that the list to splice is not
> > > empty. Note that __list_splice_rcu() has no documentation for this
> > > reason.
> > >=20
> > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > ---
> > >  include/linux/rculist.h | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> >=20
> > You did not sign off on this commit :(
>=20
> Hello Greg,
>=20
> Sorry about that, I was not sure about the rule if I did not modify
> the commit in any way.
> I will send a v2 for all branches ASAP (but I may only send the v2
> on Monday).

I have an additional question, I was wondering if it is necessary
to add in CC: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
netdev@vger.kernel.org, ...
These emails were auto suggested, so I kept them. But since I am
sending to stable, maybe I don't need to "spam" everybody.

Again sorry about that, and thank in advance.

=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



