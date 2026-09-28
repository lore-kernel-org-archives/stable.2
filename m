Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BCD531
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558281; cv=pass; b=fyVWEcvaYXp3rNkZLNjnNdpOelsxsX8SOmYbpzSwOe1kHRpwFbfSIrvShgXgvJswngtGpZ+KcYmO/JchTpirhsZEdMc1wn8ONmugFTXp3KlQuttTqsqZDPkuwqspl/YnOafWUZzTfPneknu0eaOjXj7KHx1TH7VtZ+7XnJFvLYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558281; c=relaxed/simple;
	bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKtzUzZvxngfW/ym8E11HFMkPSJqdwIfNes+3+8zrjh7L/ODHtxxrqDzDlUnBEKuOzV804OZeMhMSLiXHN3/FIjD+VnRetgx8jk9zHqKz+nwD7wbSA1vfO82P27g9rO/oW3Gly3W83+apvZ0ynF83xQHXTLd9CYalvYtwCi5dEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGKI6jg3; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGKI6jg3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1279448a91.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 18:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790558276; cv=none;
        d=google.com; s=arc-20260327;
        b=XyGRydIypriTPcd4yUYVWcymT0Z8+FKCEuyu6XxUhyQsxdngrBCGPghe9oTSkj8UR9
         zuUNg7X7YAFa5fi5QDmnV/+17/WYVmlSX7foMM0fQ3uYmkzfBlrV7EpG/L4kbCCoXGDk
         At0zfhfB3w5eGLiwk8VynGkOb98/n/ZB87uAu0QxtwePjrMTO8Fa1Ga+IkTzGqBRo8P0
         s1WMWsdS/QibSlUQjjYO3eyNIDwE0bA2+nAY21WTf+B53+dmdu4sisp8ppsKSDs8oq8W
         Zvde4TjStQddXSzbbZzk5xYDSY36KGADgcDfITpYMfzJ4RrQyxe+qAeTc4I9FcpAlWTI
         P3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
        fh=x9PeCDNBRJ7S73doUfbwuUnQTpAm8Qsg6OWR0v2Tfrk=;
        b=oEl4EQITY9HquvUp3nKMePLeRM00eygKg2RjrnlZ783S5vAtyAdBRGw7/e92dFbfPT
         v0qSjjwuPovFq1qEcq0j1gtf5P+xzAT90v19MGkj0xfYsnkO2ROd6wczJzz6rNJYK/DF
         7JvNLzJs1Bd7R5fHDWPmB51fWihNJgCt6vvc0cBnkMAGlUS3Tkm7xs44Upd0FdXfJj6E
         meQL4SdIaSd4CqnlR31Xm+yPRozp1jneGUB9eUghJe8X92tHyHWZkQOGBxdsUBJL8aAZ
         h5rv9/udhgMS4weo5A8P5Wfxnp18Mpmjn6nn4NfZUstBBJGM0IvQ0WP122sT9aa65QG0
         j3Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558276; x=1791163076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
        b=JGKI6jg32qU7HvvlSYoxFjnAvByO+mb43g3GWBjUljo+LbdH8TCg/qZlan0cz0AYUK
         TuzS6cwINsUtf+EVB8QQC3JROVY2K6RkKqcMkH01GAdG3EbIsqR06ZVNaqnowGLGJs3c
         kdL4LJA51u3244uNESzs8J3djYiq1FDkkGNucwPkkuPD7l4Eyn+j+NcOVxmLa7nTjyKK
         xm+LjCTUpx/MNBG1ybaRFLKke8q+/58UPs2nqR8K+InKNrWfqOFrMtnL84nGGSyc9dvf
         stQ0QaXg4V1wk4NN3aFWpkta1JH+I/vH986ITm4d/f30QCd6iAKyHj6bo4afoaiuBV3u
         XHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558276; x=1791163076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
        b=LmvN6+BrfDuvaIXLGVFxV2RK9n0H/2THAD0O47JoPX1OiVn55mqazzYlQkfhv55mF2
         QZ+VQezSZVvTgbM9zbgQ9dcCI4lue0wgmwn+CUyS1myZ73HZizFYcol+Ld4Bc+xwdOD6
         A8XSrD5etGmT45zmi8NY50g4jRAWJOZ9WB8DEC8FbPghKGTKHYYBK6vWJqBG4x9Muutx
         xfCqVg0Z0KaZ95iHpli7E9La4+10Yf/wKEe29A2wVv9a+JYFZjI01clixgtgZMIEm97X
         SSaYeO/SoRCbvsbppFLv1nul878RidSBDYtf1rCJz2+3vFOwwWhEclxv6OHShI990SYB
         MTWg==
X-Forwarded-Encrypted: i=1; AKwUvBwQJO18S04CHZZrfPif8JVrqk+zvUbivZtjfxEUSBiPP4BVj2T76q90syOeWLioGjDS1AphW9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJy66XRam9gQcVi3DE6bG6kqT3rV7m/NiX6TpwOHR2yVM+Q1XM0
	1N9+JANhks7zcdjPQ1uvlgi2BZHIxBMhw4UGWUaiizXUhYKdKnGuuMYwh0fk4Vr7tYJMvuhJOkB
	+OYcMVthO/YC04E7bvFhHPN0HoFlRe7Y=
X-Gm-Gg: AYBFou3XCO+CmGnjZe0BCoW4SkJLczsXq78qN/+6mEyrDcy6hsWxvMoxd+OKof7fwO/
	ItdY937L0oX3SduWB5yfSaIfxMp6QUTdigAt0YhXiITkEMxoJNMShVr9yP0cMEChS6WyqQk+4OF
	K1PiPJPYIF8LcAWHCkUcENVcPYvHIOET1r+GvKpO0GJFBKVvjj2uGv13r9ue9gtehADr36u9Fcv
	QTIccDke1MKeIIP0VyvU0cwyP1FvJypW2mPk0ljGhLuINIZsZHr//ESRNrT/Yyo9XmTx5Fa6POD
	I7vvv23evPIRldVxynXSI35Qa1F7iuU96Zv9f/EeOr2eG+qhFW8OCImicLfVVMVmBLLEVNGSsO7
	9AP0rJVSyyMur
X-Received: by 2002:a17:90b:4b89:b0:3a0:cc3f:b93a with SMTP id
 98e67ed59e1d1-3a0cc3fcbf8mr4139825a91.0.1790558275492; Sun, 27 Sep 2026
 18:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807112818.958190-1-kimjw04271234@gmail.com>
 <CAH+3ta7b7MudRedhFG4xQH6-3ZK9gfkcEPy_aHsAHBwjyK81+w@mail.gmail.com> <apcj7xrcIhEw7lCl@google.com>
In-Reply-To: <apcj7xrcIhEw7lCl@google.com>
From: Jinu Kim <kimjw04271234@gmail.com>
Date: Mon, 28 Sep 2026 10:17:42 +0900
X-Gm-Features: AclHuK8uKM50viEvYvH7gJtUCOdNx9kwbsg5nfa3655kxX2O_gRVG_nRjZ7rjkE
Message-ID: <CAH+3ta7zvKzX=8nQeDSE3rz1i81=C5mSCRiXtQuoKkKcw=M58A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use active memslots for the per-vCPU MMIO cache
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean, Paolo,

Thank you again for confirming that this patch was on your list.

I know I already followed up earlier this month, but as a few weeks have
passed and I haven't seen any further updates, I thought I'd send a
gentle ping.

When you have a chance, could you please let me know if there is any
update, or if anything else is needed from my side?

Thanks,
Jinu

2026=EB=85=84 9=EC=9B=94 2=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 4:13, Se=
an Christopherson <seanjc@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Sep 01, 2026, Jinu Kim wrote:
> > Hi Sean, Paolo,
> >
> > A friendly ping on this patch.
> > I originally sent this on August 7, which was fairly late in the 7.2
> > release cycle, so I held off on pinging during the remainder of the
> > cycle and the 7.3 merge window.
> > Now that 7.3-rc1 is out, could you please take a look when you get a ch=
ance?
> > Please let me know if you'd prefer that I resend or rebase the patch.
>
> No RESEND is necessary, this is already on my list of things to grab (or =
to make
> sure Paolo grabs).
