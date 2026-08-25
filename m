Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907B16DEB1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663275; cv=pass; b=XgtS8na+bp4qUq3isDFwaZdTUEbbE1CQ4+BQFjjx0PQ5YfxI22crPMW9d4ZenAkIkmK1ll4+/D5tpI7q0777tUO0PEgO0p/t9he3aLt9KIjmokPLHndFZgB1g3D7DS/H5yuomdVxMJLNqpbvRLq4JJilis0LCuASoe24mP2Sr2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663275; c=relaxed/simple;
	bh=RDvHNp28LTZIQGdraJaveU886I61YrsXyHDj06mHDPI=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=IbFHkIx/6CyukG/1AtR8GkS/emDdqMA3ZQYjWG1IrrHlYr1l/Lnbqgk41+jPkzLHKHEaZpqi8Wt5MUYUk1z4g9m4rypV5gkOn+HLdNRzIUWoHGcBQthy9Bwi2eoaoKLM9toq6QuEHsQpJHEhnSbQ+AuP94ex5uhtSnB7Sn92Ok8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kunalganglani.com; spf=pass smtp.mailfrom=kunalganglani.com; dkim=pass (1024-bit key) header.d=kunalganglani.com header.i=kunal@kunalganglani.com header.b=JhbYeVaz; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kunalganglani.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunalganglani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunalganglani.com header.i=kunal@kunalganglani.com header.b="JhbYeVaz"
ARC-Seal: i=1; a=rsa-sha256; t=1787663272; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S9O5kDqXIApLPfJp1i9ZnPaMXmd6IL3MeJXQkkrDFsqqYFOJ1p7//CHVm1M5BsdSFl+RXZfvz4v9Vuk9h7pKvp3/K8Ga7d+DcP6+x/n6LNR9fcaxB+8U+kdZU53qn1GmqAElb+LhoyQGWq/Y3KmMbYNuM9MRSwUx75/6L/hABMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787663272; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=RDvHNp28LTZIQGdraJaveU886I61YrsXyHDj06mHDPI=; 
	b=i0b3fNikbCrDPCypVdegnnt2OyvIqmMwad1rseBihQHrWhTtNukRNSfEZDYX2dFb4X0mDDurpt7vpPA6XiI7mzvWTvze5lfi4iNl3INawp/oOhE7skrecs5s9dX/G2jB9JI/0oiSopt0Rp+VRMTigIqKnihTLzVtiBZOSQqaDGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=kunalganglani.com;
	spf=pass  smtp.mailfrom=kunal@kunalganglani.com;
	dmarc=pass header.from=<kunal@kunalganglani.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787663272;
	s=zmail; d=kunalganglani.com; i=kunal@kunalganglani.com;
	h=Date:Date:From:From:To:To:Message-ID:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=RDvHNp28LTZIQGdraJaveU886I61YrsXyHDj06mHDPI=;
	b=JhbYeVazWu0Nl8kuKzmwdG23hcUjbo7VkTsPokEYNO294qsG+Zn6RfqmQVZoq7yN
	JI8LwMw5I3BEdWgVbpu1CqqyhL/6WCyaH/qfTL3wdIGuUwsouYHbqDhXuLscEOmV5Cm
	fkwVGMgyIH98SrYKawNcTpItBGTtQPbdVHt/6KGU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1787663272462459.73378307247515; Tue, 25 Aug 2026 06:07:52 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1787663270294905.4137689935714; Tue, 25 Aug 2026 06:07:50 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:07:50 -0400
From: kunal@kunalganglani.com
To: <stable@vger.kernel.org>
Message-ID: <1a03908c196.5ab2847e676394.552133240622154855@kunalganglani.com>
Subject: Re: Guest post pitch for kernel.org: 3 ideas from a hands-on AI
 engineer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi =E2=80=94 following up once on my guest-post pitch from last week (3 art=
icle ideas for kernel.org). If the timing's wrong or it's not a fit, no wor=
ries at all =E2=80=94 this is my only follow-up.

=E2=80=94 Kunal
kunalganglani.com

