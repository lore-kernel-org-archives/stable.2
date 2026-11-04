Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800732;
	b=fO42VFKKbBkfh5/nb/b0xQGdtKxISjGEaT8Kvxyib+RlaQfGvbiy+sD/8Y2y49YLXajG
	 UiGAOjW15TrApCIiHRJ5aJ2jnzZwTQETgssXv0+g+ahr2CIJJ67/hxmCKHcFLv7h5NTWH
	 QZrYXiK1uhJ+A+1QOwFt3hjdhsSnQ1CzW+RYHuhvbWa+wwsrlvMSslXgnUHGfq2/Pl9Tp
	 aOT3ElW+70Yifv+abfdXew2zVQSJNFDyXid4teENFmDGMJrtjT8eoPwlOGQ9QlCKFC9YE
	 GcjX8Tjv6Og9a/0C7kjJOxHfiwFBYRSOEFHgldJFFsy/jb0gTnJ1eGjoZA+v2RQB9OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZPv+9S+aiBa8tNGD5vEe2CYUtrZbYxxQ/p69PxMnGRo=;
	b=PeJwf4nVrQBSVUZOCnV3LoZdcnpScv5uOxyNQYvanFzXtb2zTp3y+QzGoS4sIBvNWZuG
	 ZCxg1jc9rZ31wHhqhF3aGpPlHvgTWKnbGrNa5yppYy0Czx32XfmPqAKyj7NZEa2XVBn6Y
	 wYy2n7E45ezKHSiRpzDKS5tPwVHsF939dNDFYqjQNBTt+BcEc0YLmC6GrGxmPRapYMnKP
	 tj1r0C1L6PPT9tzLFjLCc0ddBY0K7oJ3Wuk46deBK9V5CIJmSDQBZES+wiUNn8wZElPVp
	 ZNoVV31Lhr0rUYa2qJeMl+mIorxPzKTgzx8SpwABbD0V0XQIyoyF/4HtgzF+6g0GwYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5M2O1fx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22F606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D22F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F5M2O1fx
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac847f9d78so123039a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800731; cv=none;
        d=google.com; s=arc-20260327;
        b=E6WEFWdQLrC7fiQY7dI6pcVO5kO0C2c1lnK5J9zZQB9vNPcm9AomQQNIZHvn7wA5+k
         uBpE3ajYHc/EyLDIyPNMyDV81Zh5xhYCJRaQ7P0xKYY3U8C4piGlFjgrpslSxGuXkC4H
         syMfuo5cXIlkRFsU1BEoq7Vg9zUoBAYxt0GLJlMXb/ML2Kk0GbB++ewkgykwWBKR8xEs
         rHVeCghid6EW/XsykkhudmWPfUEewYSO1LyvccuXsX/F+PbhHwtMta8JNGdfp4k2pisp
         qVMldfNxPk9cmbRIhSBGpZEVGDE9+VDIzzihAgfdzj6i/iju1lZ4ug6t6NP7lUYqNYni
         UwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPv+9S+aiBa8tNGD5vEe2CYUtrZbYxxQ/p69PxMnGRo=;
        fh=SxrDnVzmQcUgJQG0fktrg6Aa2SIl3vD88Kf3pYNuNuk=;
        b=ooBtYvJij2ydGPHnbAFnRb4oC1leSI1NR+7za+bx5OyMNcsVgaleWrI5mWgE6WAMuB
         5nQwZMjYOcoXQaXGykERRADcdPwqFISPOrpJ86vKe00CVNWyaZCSajCK7ulhSuBqVRVu
         wtamzxtPQanm1McI1HmLnYjCe8WeXmk8hFKWEQ5nzGVzr1Nu0+qyf4Gxe9ADdN2a8Vbq
         neM7IwGvQ5LSC2RE0IO/EmxoiqSueJ+kOdFhqmxP1Yb5C5Xqnkz2buVhOXTUncRyDAag
         j84o3ma8b3gyPacdDFD2I/jxOGNwQlaPaGpMJPhOjef0rdeARzfbJomwb3kD5Xglihu6
         mtrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800731; x=1794405531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPv+9S+aiBa8tNGD5vEe2CYUtrZbYxxQ/p69PxMnGRo=;
        b=F5M2O1fxLCtLRQg9IAYf3X+Gd3ZYHD1ynEG9t4Ps835d+iHvTwQJA5bZv78futORon
         Qh3VdTCgcwRbrEmLiOjBODGmqnopXRMch23fI4nAO5V4fxOynIJhRAiRSvbN6m/qgraH
         frYZ7b6CWCckynp9t9eePQSlV8C+itEFYiiUDKItx9+KbkrBZBmEjihq20msNOYIqHce
         PrZRfOMWp8wbl5wozoawkGbUib2yb1hLD9DhpgnvkLWVr+I5PEOyNVXKW5EC3Ck9SRYc
         oDfJzWviTU+8x+IBCuPcjXowtqg3l/yt1WRLqau88VPnRZfsjN3nsT0dqOid76F1b/f3
         Yugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800731; x=1794405531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPv+9S+aiBa8tNGD5vEe2CYUtrZbYxxQ/p69PxMnGRo=;
        b=QF6524myhO4Oka+X5FGK5+HqO/16yjiyftThtVoMX+dnLY0B1guhZvajabznk3D8k3
         t1i7hsOWioNxVZXrihbwNri66ZqFdPu+bp95ZL817k6AX6hAQIupKkSw3X7eaxV4wI8j
         eVsiNy5hAaDrRXmnv8gv3gEegp97bCiA/zoztTCtCH/oN7yUOgiliSbECwAPt2D+wdYF
         LJQZR2BTNz942LWsCH2bZOHjOjomNgGu6QNNN1rPZE2T5keaZPbGPf6HR9uTWic/VyW4
         pOugBhTqgBqf+kAPdAMiKpfbi6/vL20eZsoydPfEJBcCnET8bAZ3DecTePJFQ3oHdRPU
         7STw==
X-Forwarded-Encrypted: i=1; AKwUvBwIsTkCG7Anc44b47VfXY9kO7EUeBgpjNUUQV3SwHki6GUmdjMJThmBIBHsQoEk8EtwkYUG7Ks=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lGIoTx8Rdz4mJ8nL/Vj7lHrFzVNLF/jIuj14ma3S2tkoBBcEM
	w6x5aJCGDI7caCBO07QP06lW8SBglNshDkV6K0eL+LD+9aH6ka1e6Wdvs+GTIKSaRITyQR+dDUX
	Qzb/M3c5oav7wTkuilHjNAI/N+dVAuTxylR6sbSc=
X-Gm-Gg: AYBFou15n033E+CijsHyE8d0HVdmNzxx+2S6PUX4j6KbBKSutZIR2ocienwDLsStRp/
	VYzYnZ9defOmN35Ff0wNtpzslM0tOAsk3wU1PV4OnAaGCir9MY/g5Q4b5YPX8J35iaVl8euvWrM
	dwN/IXXM4iylRtEydkdstriFwrdNFMjcEdu5tNTfd1g8DnXufte9Z+ZbgIHtyvhIxLKXq80OUOQ
	mAFSvZaET/mW6lteNiScSVvAWKdHuZfaMUjXWC/N74HfQpOEAqVsQ3+mkDDErWdNsMalxYb6ycs
	b2n+aT7bd6Hl7c3FtuN5hdUBIMG3H74cCh6cTxsOYQ/zi0SaxYzDC5TWaXrjLZlf94cTJ71vLHx
	V+ezKHk3xL8cl5wOwozKQvN8X9GClignzYsOFsQ==
X-Received: by 2002:a17:90b:3ec6:b0:3ac:a11a:7c88 with SMTP id
 98e67ed59e1d1-3ae89767d8dmr22622796a91.3.1793800731298; Wed, 04 Nov 2026
 05:58:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103174911.1600930-1-lui2012qwq@gmail.com>
 <20261104134838.326041-1-lui2012qwq@gmail.com> <5e63dcea-a397-41a4-a647-a356ab67f1a9@sirena.org.uk>
In-Reply-To: <5e63dcea-a397-41a4-a647-a356ab67f1a9@sirena.org.uk>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Wed, 4 Nov 2026 21:58:35 +0800
X-Gm-Features: AclHuK-leITjBZg3uaZFBEpELoETMeb-idv7bSBrHEFeVGW5tQYfscJGnYnWZLU
Message-ID: <CAE=Q7=5Dx7DYoVO=VcO9gs8euBY3c2hfJ2yze1HQuymJj=ZH9Q@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: disable disable_work for good in regulator_unregister()
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:53=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Understood, sorry about that - I'll repost v2 as a fresh thread with a
link to v1.
