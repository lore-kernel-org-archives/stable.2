Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A2413249
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685067; cv=pass; b=SeDnHB/aWWIZNcJQ07Q0vylWd1qTCkKjd0Er7HUt1FQVNUHTy03wwraFwjfveBI5AzKpAXSIEWS9Vtd0UK8qfPANtKZ751o3mqa8XbNaMj9EHQQ9FYqA1fCSvYRyH8b9gTFHwmDUIJNCGvbqvilUElcqIG1KyKnQmaNVOr3kuf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685067; c=relaxed/simple;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCInZ5B3BZvV8j2/IZUqWnHy4aQNN+l9PDZteJ4zMQDLiD94iXfqezYF1zx63YoV8PPiTuvOZNhs7gp/T8KIK3paUeFnAr1z/jwsjs3vmJm9TAvVB1HNCRRYk3H+72O29xD4VzgWu3TMP4+B0YWi4oFMxY2GhNiPbzBYn0pOw1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCyZQILs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4K1185w; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCyZQILs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4K1185w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783685065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
	b=ZCyZQILsXTMqcz8z4boE6dk2LDtw6V0LGWHFhb1MUe6H+M1ANABrulHaZoNXDfMojbi8M1
	EPrkGlVYH7awXp6lJNn/bNHst47ZinTgr9Po81O5JBCuW8rZ78uAbIuGGTeVsxQSFor33Y
	vEKyZtTp8uqu2gub6FgYsz26Fo5Bf58=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101--8Uoz_t8MhiEQXVqvCOGyw-1; Fri, 10 Jul 2026 08:04:23 -0400
X-MC-Unique: -8Uoz_t8MhiEQXVqvCOGyw-1
X-Mimecast-MFC-AGG-ID: -8Uoz_t8MhiEQXVqvCOGyw_1783685063
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4893fc86bebso957303b6e.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 05:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783685063; cv=none;
        d=google.com; s=arc-20260327;
        b=dstz3o9M57jEhMiLLl6dNgWjfwtSpeTJfp1nnxy8iSpHJkmsBkHSY63nYweIBSEHZc
         TvlsCNBi1JfNQioWc0TevFP6SH0W5SKkrqWOFxRlqQ4GTTwcHjW0GyQE6HW4YRJjzp/m
         JuHKzkGLb3S9A3+JbbRkReN1Kk1zP9meJV0T82aAgklyPIH8wgF4c8CXOKV+BGGu5/Wu
         XtUksZ6s4qRBCEARQ1zIIVR5M6oD/BTwA3UtyOoePIaGbeMXnJb1YN17DrkpnpbAC+LL
         FLReb8Ri/99Ux0P6TB5trljbqjFWOmyDaLa1/vzcCu6gbVuW3u6WOSjXx2aH+Ccss5Pg
         ImlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
        fh=XtCpDRGs/YCGvV8L9JKc84fyjxBwsCPzddTj7H7nIrU=;
        b=PmAYsGMapgl2Mc27asJXfRJByrPvUEfhra4mMW9K/QR4zK1cDAPDLAiWsbxuf+UBeD
         umoZWyDVimqH89NthwKI/PnINo3rQrPgHPl5I48KdOoe0vZsWC/gj0pd40s4DVvzsraG
         Tnk99qlcsgqWGzJzP+vYo0cMQShPEILDizFk05l3PS7QxEzMmlppfXfwGRvbhabt+7Du
         yaM8XOCFt3VsNJn9UHULXgjRgrVhMmUK6u+LfKDC+z+kN9m2T2jvDxe0wUL264OwSlZc
         idtDktjinrjcCe8h0VGKjz8OtHPonOSaFOi7qW800o+ExqqM+EjvRA7Hb+yEXbwZuVI/
         fZpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783685063; x=1784289863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
        b=g4K1185wKQPGbtQaXuCtJME3ZTSzVSnMAsWX7pZ09qNbujrNdfFPMqfwZfsCaTAmJz
         Vo2pNXwXnyQkshULbZqrAsriULqXKx7Gjgg6+GZ4nSEGPk1IuSM09tqA4fF0LrIsO92/
         lFPAVzw/PyamZMuJyEs1QxLngSd795t8wB4CWf7QnvLX3tKseQhzZhHKtjldzKsdPW7A
         h4n4Ufsixhw+Z5AjuIj9cITudAta3MJl54w3QvWNO+SPx6bv0asCuj3cB0TLVsb4NUG2
         H1PoY31UkyPWBVo2eolbBIwbqGU0lOtQ9vFmfO4jiF4GJ0IqMoRDQXCJGla2/TNOQvCa
         gkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783685063; x=1784289863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
        b=RnFY7VbSMwLbLlGTTScJGGOFUrC3rPN7CLCbipbrLn3b5uVnp+RvivR3P3QMyQavZ6
         H3H85NdjA4xtNM5iYyapFngkQ4qmfLWmfKVSx/1U4hVrWITnF3B7GNTrh/VMa5d1I084
         LnhrIv0AFTkd8O9K4+99jQMpaBajg6j8zrfpM6L7cOCDRlSBSAZOopKlSyVguF35Q7WW
         9mJFA2d8+DjWAsTXHXr33El7WuuhcVX4OOOhmR7WwsVQqdE4I1za0lD3yRZypJh9Z8Uw
         DtNH99T6tfbekL+zN/in3qMIgEF7TFjN6B9ik0OAWX4Azpdk2EjFEkgHz8lVlSVyBDQx
         Fgdg==
X-Forwarded-Encrypted: i=1; AFNElJ9zAMixLJ11MnmrHG7E0HZTIMZy1dAMDdT/jESB5mG8I8O9hUbVZdkIGGlx2lSkqNxKt0/NqGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxAqlhn3Ilz6Cn67TPtwBy9vpMn+sWWXnEYJgIu7k5hU7nE+Y
	0n+SAsmh39bS6LTPO/XxziNbIh2+Bri4g1N5yvkLL8p98TQH1VMg9wLFw/2X90EU9Vlw/dOthOJ
	o5+8UHbCGsdd3MuoOJ5VtBJDfMIiKPP8qPZDgEUnT8B+/lD8SvROF3jgi0OLrPamJHflcNK13as
	lbL1ZAOJT4Ocqh27cJYLZ5yP9YpmOwz8EX
X-Gm-Gg: AfdE7cnAeDc2IlJByVEG+UwpvjWXLCivZDDBTpd/sQc8ch4t6BInZVDmoC8wh2vjDY3
	vT8PSROFsmW+B00da8ovtyOtDcGGR+PtxUABq4RiqZ00sICxKdBbTW+RV8qJETy2XnUek4YzvE4
	L85LSAEKR3PBNIaILiUeRhJj3qBSnvlQS94HAN9OnYuggty4K9lZw6TXV+EBluom98keR+4IeER
	+AJC4Oe6FfKaflGDirVTa3V5nM=
X-Received: by 2002:a05:6808:4495:b0:495:d6b7:6004 with SMTP id 5614622812f47-4a2045e17aemr8153644b6e.26.1783685063072;
        Fri, 10 Jul 2026 05:04:23 -0700 (PDT)
X-Received: by 2002:a05:6808:4495:b0:495:d6b7:6004 with SMTP id
 5614622812f47-4a2045e17aemr8153631b6e.26.1783685062691; Fri, 10 Jul 2026
 05:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629144837.3244851-1-desnesn@redhat.com> <akRTVinqeeZnVARD@localhost.localdomain>
In-Reply-To: <akRTVinqeeZnVARD@localhost.localdomain>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 10 Jul 2026 09:04:11 -0300
X-Gm-Features: AUfX_mzVC853Yhxe5IzKb6IGxVPhPJKkZ0EBhVqEVYwZEn7zq3i4mNWDrdm-aj8
Message-ID: <CACaw+exCLSLRUNU38uorD9r+fk4AjD-Oe+RZNzFXzjwE2q9rsQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
To: Tao Liu <ltao@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, stable@vger.kernel.org, baolu.lu@linux.intel.com, 
	dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings Tao,

On Tue, Jun 30, 2026 at 8:38=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
> Thanks for attaching the kernel stack trace, which is similar to the one =
I have
> encountered recently. And I have applied & tested the patch, works good f=
or me.
>
> Tested-by: Tao Liu <ltao@redhat.com>

Thanks for testing it on another system and confirming the fix.

Best regards,

Desnes

