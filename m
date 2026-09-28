Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8B3546F9
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583349; cv=none; b=WIpsE4eENzV2PD2v4ZMkULGkIV/upA8x5ComlzffeGuC3rL9PAb24WhmZTlr2WSxg5WBcm50Wu5/XMTfTkJuftVWKg+gk1PzMU/dR69KnI07N1jzA+AxppXJatuhLAD5SvSTmxSRmQkC5p6VsXu+9Vj7W736E8aJcg1dnKfblHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583349; c=relaxed/simple;
	bh=Zrxm2r3foFtOVsLu9cLVdf63YE5ECOwPdW8HWwhE0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhol8XgTkU/Tc0R9tPeiiSxZiYyfT+wzfSQIpdusyWdJfvk8iJRkHRKK2LUnWrkQwNo6wPzHYdrooF/E0uAINqQmohvefv+JftMoGaRRodXlPzXVLd39FN0c5RTCYDChh6Rko3TNHCLxC30WtgFPo07oG4XqUSjzxYSLfLmGebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b56eoMt8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b56eoMt8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6649A4E41091
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:15:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BEA4601BD;
	Mon, 28 Sep 2026 08:15:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25D9B102F1E57;
	Mon, 28 Sep 2026 10:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790583344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zrxm2r3foFtOVsLu9cLVdf63YE5ECOwPdW8HWwhE0ag=;
	b=b56eoMt8BHlltO7ts7XLN3dhAqtruZRAj7270AIB8iPLhTTB19NsY15WI1mITCejJOowA+
	whvx+yfpaHvSCthP49KCarOESwkKGyynojmHue/3T9nTeGOgRgwdUiwM6Y386n00J5khu5
	Djs+zGjg0Mqd3N0ZdzeHzyPEavXLUpKo7+1rVfBc4vAZXVLZ2wZxvjIvkuULC+s3AGovsT
	6/BZCgdGpieX3LY8dlrs3r8qSuHq4u/oGXv+soJeicrqoj2KuF+GR7lQv8CAwLZ9Qvd7zw
	7LYYIQqZhjKa+7U42djBzxvf8AG/aWSzM4dZqL107L+Oh+r2BrA2/KI5PS532Q==
From: Benjamin Robin <benjamin.robin@bootlin.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject:
 Re: [PATCH 6.18.y 0/2] netfilter: nf_tables: join hook list via
 splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 10:15:43 +0200
Message-ID: <y1YYJSp3Q5q9mRFyTmWbqg@bootlin.com>
In-Reply-To:
 <2026-09-25-daily-reply-0004-re-nf-tables-splice-list-rcu-bounce@kernel.org>
References:
 <20260925-cve-2026-52988-6-18-v1-0-680b24895415@bootlin.com>
 <2026-09-25-daily-reply-0004-re-nf-tables-splice-list-rcu-bounce@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Friday, September 25, 2026 at 8:47=E2=80=AFPM, Sasha Levin wrote:
> > I backported an additional patch, which adds list_splice_rcu(), which is
> > required.
> >
> > Signed-off-by: Benjamin Robin (Schneider Electric) <benjamin.robin@boot=
lin.com>
>=20
> The code looks fine on all six trees, but your Signed-off-by is missing
> from 1/2 in every series, and from 2/2 in the 6.18, 6.12 and 6.6 ones.
> The 6.6.y series also didn't go to stable@vger.kernel.org.
>=20
> Could you resend all six with your Signed-off-by on every patch, and with
> stable@ on the 6.6.y one?
=20
Hello, sorry about that. I was not sure about the rule if I did not modify
the commit in any way. I should have informed myself better.
I have sent a v2 for all kernel branches.

=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



