Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767781DF74F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198513; cv=pass; b=MVAp34ThzDUd4i8+kYkHVmHOR0GYVSZ6jzSGKQiUpyxEi6UERjqIZ6VJ8kIZAyG+QzqYMwNbjDATej6nbbzMH1Meq25S2WwvTt9BGwgYnpz0wmdQLu2VNtsNzkMZnx3X2FSfrONyJEc7TIvTnZx9Ko/GqQj8TKJoi2UWSEYGvfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198513; c=relaxed/simple;
	bh=YClnWxAZzLXxSW6y3LH3i9NbMLvH66kZ0/+Caj+H2aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZQ8oh+VhgR1qopPY2PAlnLcnso8sI0Rr+BRv92K5fkow1JxM7OTf//ozB85QZI//KkDVoKHwfyRU39CGlJPcUxt96JTbTpVVdI+SMbjdMExJbotKw1LzfMlSM7aEuufcX/yj9W3udSurazCvzl30QDRqEODdQOgUXd1LAPF9DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pg2AM2L1; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pg2AM2L1"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fc2261f2bso3733678a12.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785198511; cv=none;
        d=google.com; s=arc-20260327;
        b=ShIl4HU1qhnh8fIXkubsu1pPvTzphjVGE5J1WmsRf6nxDm4stf2Wi1kNCkx4B9sRnz
         YxuueQwL7ZckGxA3cd/kzni47ooXLoDM63La6A1WEu+21F4Pno/3EapdzEc0lAZXYjBx
         V8a9hVpI4W2TkuXj8Ip6LABhWdIWdFa4xGXWJkbwkh+ZpQrZgGBmDM7P964fnpWJiz6V
         hiNeoHBuc0nHfl9MvVyyczOfyvZ30ClBjfCdyx0iDcHUHjO70toGPiGwWZ8BMLn6DvZg
         xXJGSnnortEWWIxP8dHw6hh/XbpXYl5MOoL/db2teNoRPItTn6QRgCvICCLr3B2LQVAK
         nPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoAWrFtDL9wLXrUXpLS9z22viQcTgc6ahMrO+sMDQqc=;
        fh=qI8gzJBAfIrT3YB42nszSvSU/TyRQlNAHVVa1SJN25o=;
        b=MQnnGljbN9BMYsyUnPRx8+qHTmpX3E4DQuoxvRF+fhHOHhGtOMHCgf1tcu03UiBZgK
         9aMxhXAC18qZnBDMGhlp6Pbm9ZMRGozOT0Lz7R6A1GF4W6q7AF2cr0epUXaxVtXDpQRB
         8IC1i57ESFhGgKDGPhLhkPG2UF40OyFIsoCiO/43i/L+HyYtwUXvV5063YP2caT76MdN
         2NBC/bjGr8gcucSGOQpOwWGhLRgqfuy4GshXTHCK3XhJ7nKiyuzuAbw45xMjx6amaYL9
         VliNdMb6riYliP28xg0sDl/ahQ5ioEP3kGMXdREVr/nPDYv08Vx8D4OeWbwWpEChvUMO
         8saQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785198511; x=1785803311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoAWrFtDL9wLXrUXpLS9z22viQcTgc6ahMrO+sMDQqc=;
        b=Pg2AM2L1JbFMBTcYTWDmamF1g/gqwYKzVmaskYyvpYvI8XPjw0M22ipRS4VbvChhEy
         aNxP+c1c38iXt8AOpitFUC7/wzhpC1WlJG3B2OBZHdZ4sAwucOncG0VFmr16FGurdXBQ
         hHTE55JCS7Snj59xGroyvob7/HQe9x9+rKTqGI2iQNS8/jlZU+/XGseyGHr24zHJPE/u
         R5LsqPoJ9bcmjklXfsKVsD9lN3rIBLvG1Mk9T//dSW5uBsufnmDC6DvRmQsfB05qedFo
         hBTkhC4clp0EypBCW9dkydLGJBWHH4/2jpl9hsc2/C/lT1jmsnwapyDMFD9HJOckKZKI
         H4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198511; x=1785803311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoAWrFtDL9wLXrUXpLS9z22viQcTgc6ahMrO+sMDQqc=;
        b=MWyLbc0jl6k+8c5rHQRwVJu0tfh7qSLCn8UQ95XOzraAQ+vZZ9JYU1pkp5+Es61o1G
         4Pk/VnqP1nzgcunvVCy2b6a5I3l5zRCVa60rjZ0jxx7HRrqWTvOSqOn0F8sVf1JjWRZU
         +zq3mSZWuhdaUTNX+OgAU56l2J9mWwUrK607X7Cvz0gbVwxPM8OgLx9ida1VCjDYcGKe
         m5LWMIQg/4Bown8fYv9+4q73AkIhJjFiuzBmaSPf6MAPmGiZI4vLO4/86edtQ67wN2hh
         uNwcnCjHM/udOnl8Cn0tiupzYDWuOYBA/NmpJhgZI4YwfITg1E9iUA9qIDq8MJ+k4sbc
         hkjA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8LKnaq+wSwhrOWDvXilQ1ME7akQXjBJyBIQPUUF7Q2V0JgfZfuVSRAvscvrd5S42vSWyF5RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF04+FALP16E1ykeNCIiXfkdrZS5PVvYM3rGMK/2gpERCQnlSg
	uOYr8gLFQ+NdlgwqZUtBdbBt8ey/1iJ8uT2BowuwdKFcgbtjC7ajgMF0MNeAr0PJUSc8uO/ymYy
	KXcjjWTIwkgoSQuz/ht/3Pn9fSbLuiX3BnRk9wsox
X-Gm-Gg: AR+sD119KhnxMkBzOcgzhTcY+3hcZn2ZdC9Td53N9bpadf7lhXUVs5tddWFt9K/fZ/F
	onVhBWK+UglJbwEcLDqNbukg6aMIKeCA70561fomy2c/K5zkMbdqcGTqZ3fRlmK0ztkv9T0Vbgo
	KUY+v62JLXbn4CsoggKK9xScALtmEFi7DSsAIh/mkv8zNjXc7QLC4UdmDe1K7M6FhStVF1fYdDw
	SVgIMiUUc9Oc1+I3s6sBMObNQhFv3CzAA0Qn0kCliP8NFBeb1ZyYoCloF+9LA==
X-Received: by 2002:a05:6402:2684:b0:69f:e3cd:5ae0 with SMTP id
 4fb4d7f45d1cf-6a034a1c2e8mr59739a12.18.1785198510685; Mon, 27 Jul 2026
 17:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174521.589520-1-tristan@talencesecurity.com>
In-Reply-To: <20260715174521.589520-1-tristan@talencesecurity.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 20:28:17 -0400
X-Gm-Features: AUfX_mwWZHYR3F51fSZZlvPN9mmlMg7Kfjq2d-ETIPzjCOnQRzggRcMBgn-pmhQ
Message-ID: <CAHC9VhR+4nBiAqdNDPequ9o9MW84EeA3t279Pfr8fCHhUz=nQg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use socket SID for SCTP bind/connect permission
 checks in softirq
To: Tristan Madani <tristmd@gmail.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 1:45=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> __selinux_socket_bind() and selinux_socket_connect_helper() call
> sock_has_perm() which uses current_sid() as the AVC subject.  When
> selinux_sctp_bind_connect() is invoked from the ASCONF softirq path
> (sctp_process_asconf), current is whichever process was interrupted,
> so the permission check uses an unrelated subject SID.
>
> Thread an explicit caller SID through __selinux_socket_bind() and
> selinux_socket_connect_helper().  The process-context wrappers
> (selinux_socket_bind, selinux_socket_connect) pass current_sid(), and
> selinux_sctp_bind_connect() passes the socket own SID (sksec->sid),
> consistent with other softirq-context hooks such as
> selinux_socket_sock_rcv_skb() and selinux_sctp_assoc_request().
>
> Factor out __sock_has_perm() with an explicit subject SID parameter
> so that sock_has_perm() remains unchanged for all other callers.
>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  security/selinux/hooks.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Based on an off-list discussion with Tristan, I believe we will see a
revised v2 of this patchset.

--=20
paul-moore.com
