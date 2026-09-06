Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFC3B14B3
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667886; cv=pass; b=E3Q3WFDkud9/z78gUucniVLpqmZWP4iSG41/s6mk0zYd9DKcAAUnVmwnEPS4Mi+jnzHmtowICw2pKzeNgYwl70j3enNYmwtpD5pMZI2jz7zPgdf5aZkl6I3GwjthNWn3J/fXUkB6WGUH1bcBtP+zCzI9Eq6zRWRqHFwgpBlBPtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667886; c=relaxed/simple;
	bh=o8RRhMmOJZ4Q8Ws8xLNr8N1jORKBteyJlETpeYJ1kRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+DMiMD5jbT5KfEBFhEMOc6iJdgoS0K/v1R8Dnsk3JQl7Koo9bDOq0i/Ys0WCfAsYuraCLe5SwUV5EgWzXj+QSPSwghnQEbMBCe9W/Wyh3byNl22L2AqzKdVgF4EpYkDCYbEKX/sfd0GO8YD8HuGCmIAZrGOpFLwPkv13ZCaCRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=gsWl0xQl; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="gsWl0xQl"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a151eda82dso21926881fa.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 21:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788667882; cv=none;
        d=google.com; s=arc-20260327;
        b=OCtmPx0IqIIb25I+lfqsX0rGFR5b1c0EI5/HAN/X1F0cVLGmmb6SdQWDCl2o5WHxqi
         9Sv+Yc6nRWwiKAo2BOW3GDocWp+ytwuFg2zUmsNGY1KzUcxOl922Wk/o2CFHo7h80Czc
         mx5A1h7Opi73x4wvtwzsrWTwYui7OWyGpiEyNh+/iG7WDDJ95hifW5e0a3ID5JdiMh4e
         UnjaR2xykq2DSt1olSAo6jd5FRJHv/RxkhgZJfJR0VI2reGkswyXkijl2NKtc0ImX2wW
         xqTgBNX23IhcBjQJKbsUbuCA6k/ytr8HRZM04TLi8KX6ZfknuZTpgfN8+2VEcjtXfmCe
         zMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8ob/HIduIdO4mxeAjoBbDAMkNrzJkir8KFEywokfoU=;
        fh=FAzyhqswQHwNMjd+uE/xRZ1wziAtfrP5Gj+YIoCtO/s=;
        b=l7M070hNTb/UBgMt1JeL9AB9b3QxRZ/hWZXgxoMgV4GKABVvst3LVmtoJuXjOKbms1
         2zc6bjyv/UH9xybS5sHU3mbUcV72Gp7LzPYPGhPJiMRwdY1PAsttOtyls6kZfY+YqtC4
         mDSPPyVCyum99dPx59bmEybI+ve4XwxpkyPjRus+Azs/fSKFwWySWldR4O8EGCo+Mdpk
         TG+FZsJ5Dk95pF+xWtMmcbI7NJOS9c+PVJuhaEjWirzTz8YcbwOzOhZ7xD9te5nM+b2S
         nr3UlCdgRNI4h8NWTqKSwczrdpLN2YIKpTmltUPDh6ASYwwRccUujibkPwoEE6swKUag
         33dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788667882; x=1789272682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A8ob/HIduIdO4mxeAjoBbDAMkNrzJkir8KFEywokfoU=;
        b=gsWl0xQlYcx8XUNBl1rvfDlda8jv6dU2v/34V0RWMl0w8WWAUN99iynCISfQA1Wpa6
         eXuyk38fDHSd424wVQK1Ak4PlfEdkwmD5mCfD/B7Jbfbbs5RZG0DqCG5nmRR9+anc+wr
         C8e8+l1rf7mW4LAAI0rI/0oskDPGpZC0wjEBctRuich12FzON7mxCHVSEVPV4o26IrdC
         KEBCnB7CS3pPPmZudziSGxh9CUrXOHWHp5Pe+SqV4mrgmMm5//cmK8pyP6PMWPBb52eO
         SIr8vS0KTGh8rWiKzpumBYDXKC1ABbs2oKDXTAeO4pZfQqgz9BeTPDK0d5GBaggfpzUA
         iOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788667882; x=1789272682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8ob/HIduIdO4mxeAjoBbDAMkNrzJkir8KFEywokfoU=;
        b=MyearRLxxpSSD88VmyfJerDZ+CIsNy9M6Lwis63rRTqZPjQb+bkfkccM97nSgV4ipC
         WcNPLdXlGXOSUoNrUMCMgwiZ+NYxlfpMbG7naDqJSXG2LVraxqhPocPSRyWVQL7kfxUH
         1+pj4ThcnqXrwL2Ju9u5nL1vYyp4vyb5MFyVHD9fuwp6Yf7jW7dEP/WLggChBScVsrLA
         R3lvtrvy3kck0dGx8Kx2YqJcvCZPa0WZzksmZgGDIcrS+FW1pw3G91ihBoFqAM5ZNjWR
         N5srfDoS2/KF5c92GYSS9+EZ5kkGu01wTWZw0hI50KslDYkyi6/tDOHPHjyKylztAMdD
         TdOg==
X-Forwarded-Encrypted: i=1; AKwUvBwSuue1WaEBOyId5C45ZE6nvoSuBrI/zMiBoiuPWeouca0wz6LtH7ScTrlcfufRvngSCMt7SPk=@vger.kernel.org
X-Gm-Message-State: AFuF++mjht0tJmAqlpVTJuX2vVDtwTJ9cHKAk6LIA6lD9GC6rriJ+a6c
	qM5xt/RdXjLKhvKVwE9JY8Ti1H6RuB1TyOoH8guEOcLvtfF/TgvbupI6az//SYOTjwdecHL8mS7
	f1gcOB2GK7bQt2pe5t9B+cxsUtzYW9mDEAdNPuPPMbmk=
X-Gm-Gg: AYBFou2UzRryQJsvSvOOm33tbrYEb3PEODdlVu86K2iIhuQ3a0quz1BozeXOSO3q8QP
	hG2GwFpM9Sqz2b/CWKKi8CdLyicu2KfaF67RG98Kpi8G9s6YqY4gE0WI6m1ujBeYC62/SiZ4v++
	M9DpLvQyPZHTh4Ord8MrAx85OV/2wATJw0OGcMnQVjxJ+BpoKy8rIO6n7IAjWN0Bq1wtxcTWSRx
	AW58Pzq5eeOj2AQecfee+wV5SQYBiahSE41IIEO5as6lFD6G7vjf2L/0WdM3QQ+sPaP5B6ceOzF
	mRWUlPH8wEfxZVTW4d03frrXFfZ17s600HxFmChXu0GPfEtW+pBlZA+xjALL85oGyUFtlXhn0fc
	=
X-Received: by 2002:a2e:ae18:0:20b0:3a1:8510:cbab with SMTP id
 38308e7fff4ca-3a371f4a7e8mr21960751fa.12.1788667882373; Sat, 05 Sep 2026
 21:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org> <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
 <20260905122929.5bd1bd45@kernel.org>
In-Reply-To: <20260905122929.5bd1bd45@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 6 Sep 2026 12:11:09 +0800
X-Gm-Features: AcwNN1X4pr4fNZzhfVF2lKYxFSJa-AapKUR7vl8QhdvgCFTfBdfx9ZvtSLVLJBo
Message-ID: <CAANe3eRLauCoiYjxBWGqF0Wz7FxMkNxJcTUaqiD6ZygxcUfUcA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, xemul@parallels.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 5 Sep 2026 23:49:05 +0800 zihan xi wrote:
> > > When an active netlink dump for UDP sockets finishes, inet_diag_dump_=
done()
> > > invokes udp_diag_dump_done(). This function drops its module referenc=
e using
> > > module_put(THIS_MODULE) as its final step.
> > >
> > > If this was the last reference, a concurrent rmmod udp_diag operation=
 can
> > > proceed and unmap the module's text segment before the thread executi=
ng
> > > udp_diag_dump_done() executes its return instruction to return to ine=
t_diag.
> > >
> > > Could this result in a kernel panic due to the CPU attempting to exec=
ute
> > > unmapped memory?
> >
> > Yes.  If that module_put() drops the last reference, rmmod can unmap
> > udp_diag while dump_done() is still returning to inet_diag.
> >
> > I will keep the extra module_get() in udp_diag_dump(), and move the
> > matching module_put() into inet_diag_dump_done() so it runs after the
> > callback has returned.
> >
> > v2 incoming.
>
> FTR your patch also looks atrociously ugly.
> If you send v2 please make it better.

I'll rework it.  v2 will follow tcp_diag's batching and drop the
socket cursor, dump_done callback, and extra module reference.

Thanks,
Zihan
