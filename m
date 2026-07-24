Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32F3B7B7A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879957; cv=pass; b=n1ojJ0dcS8X7eovdf/38UPPUckjyTH2r+k/8b07UmPmimGBxyPgA99tSuNe91jeBdl1Khjw0EFDKPMSdSYysqUMTKjeJ7JUbR7sq330bSWyuSp9DQlDDuS9UAW6DvrB7i5GU6HRr89DdHi/w8p51y/4k9rOIYVuv+A2tEySkh7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879957; c=relaxed/simple;
	bh=ILlD11q5P/icymMeNwcr6XkCRGdz3IA7THBE4JdvrCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBPmCxanrk1gStU4xr2qvQXOqrAoI4F1elYiQhhy9L1I1V19Z/h07lh4ANYXalZ1L25V69cjsSu90aiqJib1jf83lAiucGtjgdA0VZi8zegD1Bs96B0vPTvb/M+/JesluUQIRoIrZJ6dR935nVeluAghiOiPtSuvYN5XozRsVis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VuYjq2qi; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VuYjq2qi"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c52d920b8so22532866b.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 00:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784879954; cv=none;
        d=google.com; s=arc-20260327;
        b=oDpGSSz/lBgrGX+x1QQ4500Zllay09FDISAchuUzT82DHzbbmhH2lkZJfooJxHNyyN
         qiOtHnNg8NoXfbi1/ID/RYlYxt2DmuNUnHJC7JrTOobsAC4IHZb+zpN4K5pQc0vFfVhY
         m+RGu7hPObGG3twqI9WTg8ArJFZdFROXZCVOhM4rYpla9hYKmXbrrHuKSm2CPzgVBW88
         CaegUMwyruKYzR+m5ca8zFrntHKZKnQcNyHdZOpVbUhevu7z2Uc1/KdYaTjAbKWmwa0h
         RO9xa/aDjDXdVhcWwuL6rvxRDMBd4a029+EYWL+HTOWUqArpYvGfewxkmBT6+oEwK4wi
         d1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqV3fbHAN7NZPWrpuhuPLnTSOaBXRquD+39euEZsbvo=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=kX31rWfRseYSzjwE01vIRb2H3H3zKZU8QdooMN0lNEqJ1gYHQm2OsN/OtZWDXrnB+d
         02lFVwRKYXa+n6WAPBUznnTPpJaMhHKAmpnp8raY5Tt0BJhFptk2DP///MUGcUaMLzhh
         UVWvngjg+VDGrltxLIyD+SRqmZyQZabKttTgoNIayubwtHX5i5Ea0B9hQwBiOkQF6uCc
         9Sm4PxoPrWdfGKIVpUXcGx59ksNlPWlKZsl8dRz/kN22SN63mpdXwjqujnVPdkvf87aU
         7BdSWb2AyF4QqcNwGAKAtiJFjKu4F9nykPT4XziAsMsPmXsyzsk5cCiodD/oLRNicmAo
         Er7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784879954; x=1785484754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NqV3fbHAN7NZPWrpuhuPLnTSOaBXRquD+39euEZsbvo=;
        b=VuYjq2qifDT74ECTGr7NUJTvWvW4sv54T2us8dvAl/leQLXQz0Z52JJfgdDDitRh9R
         0B5+y+xovh3xjXXVeUFKJ+7UU5dQz2IWcpHW3sRpDvY5U6Wi1StUSGbpQ7nfx27dkPcO
         2wEMUaxb2HR3cVehtsMn3DCWujs7Fym6aHSvwyqTw60Df2f9gLmw+DU0yinDWndMej0+
         OzyVhnItcQaPbdJxdqbmjPVnqvzaNPFXxhAOPEElROfXQZZAw2JUd6MKhtbTBhnJkD0O
         iq+LzvTE8UcfsqgdnjjjAlPd0YACk6JytsYxkQ/jVsoLA/D48xPKFcr0lKWmY9sllvsL
         fxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784879954; x=1785484754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqV3fbHAN7NZPWrpuhuPLnTSOaBXRquD+39euEZsbvo=;
        b=ClbwZ/cipi30HlCOzfGYWoWZwjzCO5cW/JWxFon+csWW5c/G1yMFNi08M+6J77gW/H
         I8+1L+FY7ctwuQ01ppnw3kSxmn6jmSyXfnJX658YQ7Ao2XxFWgKKx8z84PiOfRXF5WUn
         8rT51k2kNy0kJtpkjbdFz3V1fk0hyGqg50vLqT4aoMSggqI+MuXR1CTJVVPSy4a3HdXm
         3r40m7VJpIt2SUasGIjP4eqhk3pMywsIGiHSA81GKCQX2wqeyvdltNSl+fc7igOCcdbN
         EFIC1CiDdSxrlgI7D6MmjZaUSPOtBxoX8P1rmtnV+xQU6FOUSPURjJkTahcfLQRRZimu
         k8uw==
X-Gm-Message-State: AOJu0YxrjECwwfNU3NrEYCJh0CDOUTXmkEWo3tbOier121xwqpLBRKFn
	xJOaioeur4PPW5Y4IrrN5a8vTY6s4K4Dsv+Fo/yCzDF3gqc0WakKvbJ2jydvEEVpAwVfwceqqiF
	vyJ6VMW8WxLvODr0yxDtn8Zb+p23EHIrWIL5eQFrniQ==
X-Gm-Gg: AR+sD12yxiaCwDTXe4ztwk0ZE2BB1Xj/jfn72NAerZ53aY85GCtyQ8DmiEbiArx9pVC
	kzjDPzMcyBMNv+FiDZaXeRGaNoggdCebCry5xc6xGZX80L0R/iKN7uLtS5Efw9kjfc/TUcIkW/z
	jZ+Zw5QmuM4lBjHrXv/wpN5nXMw3Ou0iqJYZANjR5yWkb9QnZGAgeZnuuwBtYFHCWlvGH+xU5N8
	MWkDYM5I2cnx2lieZzRjWsa2SyA1aab2u5v8TKzb5Ac2HZ7J571eAH7c1yV
X-Received: by 2002:a17:907:8b85:b0:c1c:5c90:1bad with SMTP id
 a640c23a62f3a-c1c5c9029e3mr207519566b.14.1784879953664; Fri, 24 Jul 2026
 00:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722143258.264584003@linuxfoundation.org> <amHSEwZcutUhO5tL@u94a>
 <2026072304-dentist-repayment-4761@gregkh> <2026072416-chunk-curtain-332d@gregkh>
 <amMLUyAZFJJY73JI@u94a>
In-Reply-To: <amMLUyAZFJJY73JI@u94a>
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 24 Jul 2026 15:58:52 +0800
X-Gm-Features: AUfX_mxKhDR4Agh76fRXUCbOPz0JjCsCynyjqK0u9bSjgroBq7IqryokpL2Rbkk
Message-ID: <CAJFoxQOHyAdy65-Ew9G0GY-HDa3x7iC31J1sBzVYOGBuEy8RVg@mail.gmail.com>
Subject: Re: [PATCH 6.6 0000/1226] 6.6.145-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 2:52=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
> On Fri, Jul 24, 2026 at 08:18:39AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 23, 2026 at 12:17:23PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 23, 2026 at 04:37:07PM +0800, Shung-Hsi Yu wrote:
> > > > On Wed, Jul 22, 2026 at 04:33:42PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.6.145 rele=
ase.
> > > > > There are 1226 patches in this series, all will be posted as a re=
sponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Fri, 24 Jul 2026 14:31:21 +0000.
> > > > > Anything received after that time might be too late.
> > > >
> > > > BPF selftests compilation is currently broken. But with [1] applied=
 it
> > > > will build, with test_progs, test_progs-no_alu32, test_progs-cpuv4,
> > > > test_maps, test_verifier in BPF selftests all passes[2] on x86_64 a=
nd
> > > > aarch64.
> > > >
> > > > Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > >
> > > > 1: https://lore.kernel.org/stable/20260723071334.39630-1-shung-hsi.=
yu@suse.com/
> > > > 2: https://github.com/kernel-patches/linux-stable/actions/runs/2998=
7147891
> > >
> > > Ok, I'll go queue those up for 6.12.y and 6.6.y now, thanks!
> >
> > As I said on the thread for those patches, they only applied to 6.12.y,
> > so 6.6 will remain as-is for now :(
>
> Hmm, I would swear that `git cherry-pick $6-12-commit` in 6.6 worked
> when I tried. Maybe I got the wrong tree.

Seem like git figured out tools/testing/shared/linux/idr.h used to be calle=
d
tools/testing/radix-tree/linux/idr.h during cherry pick and handled the cha=
nge
itself. I didn't realize it does that.

Lesson learned, I'll test with 'git am' in the future.

> Will resend one specifically for 6.6.y, sorry for the hassle.

6.6-specfic patchset sent as

  https://lore.kernel.org/stable/20260724074835.47479-1-shung-hsi.yu@suse.c=
om/
