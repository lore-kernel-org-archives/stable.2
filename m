Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350235;
	b=5Y3knueWSQJUVo3zd6IkBkX1Ec3uzk9PlPDfX02piWn0TASpoR52yp/sM7FNwEYAEZOi
	 hdS+sZpgRp7T5AFxpmGWRTqTFwunFPppGhnBsO22EA0bzPFlmiatucrl2Labn7obOuvLC
	 zMXM64kPlBWYO/NHy7QGfDXL9KCI0b33GYJvMrC1f404r1d/5J/RQSS/T91LW6LTEE+5N
	 +K0lBRlIoKxVn2lHh3TNLGHzux6FKjWJ24oabMUgArFU3c4CYStjLeRux+6CTfKiLia4Z
	 hY4A8F6OTFkU5PGZId33JyWXOxyK0daxSp0frSdKgYDmFBwb+/InddoMuP08Ty+V+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350235;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=UjsJrZ1pJJ5hdlIjL7oELqGtdNx6GVq1xde+Cdl2rherhfShOxrCLgFTvLqgiTLBHwt0
	 gnw4+MOmvZ0ledO8ifmYLR3qJJwyMC+Bl0uIj37QaQRoK5nkTe00fKfSW1crpN4TT1deu
	 EEZ4OvAAmERr9zkG431yCdDpmSC3ghbs3sY1gFoaNMB+w5Nob4qjMqZQgYFopvoovuaso
	 1GziKNUh8OhdGjwNt5NxoDXdaw0Ci2mkUIXbhmX6ZQC+wcgRYqMuXXFO8FLwnh41/jQ9C
	 VSW4AEx7FH7+XbDfQFPJ186AZYg/W6+HhCHYznj9uRskX4MjXY8PKW5DoJRVoZ12RBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1FUiVmo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B6606A320;
	Tue, 10 Nov 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1FUiVmo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9818A1F008A3;
	Tue, 10 Nov 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350234;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1FUiVmoNEBbz4wmMe6/PuBnKWz0AAIBZH/ToqJSBHRAj73ZA9ka+hNWMJL/9QE2n
	 /n7soxVfhbGFK0oySAYEnc+UyR3MImS4XBwHRfDPQSYbzGdzrrrEEjX+L95NDhGJlx
	 yuBMEOEnSR/8z9caYRn+NYAvfIMcUPx7wLeKW0LkVd2mDdpMiINMqVhHvWSJMrnv3U
	 SAg3xUtilqvJ6d5bqRlCuVpy4ocI/7nNkUxxWfZc0G8dTmJi9N4VFbPWlynVlM6IbZ
	 bjjPWpg61Ok1dMdZy8XTy0hYTbh4r4vQvrRxkQg+aOKkN/8/K/vTVrkB7x30ZT7a/J
	 /GSkQ/DJkic2g==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net/sched: sch_qfq: revalidate aggregate after peek
Date: Tue, 10 Nov 2026 22:37:14 +0000
Message-ID: <179435023413.488859.11967227218496669505@kernel.org>
In-Reply-To: <20261110222946.2147440-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261110222946.2147440-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
