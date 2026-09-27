Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E85B206
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482969; cv=pass; b=CGXNa8AuWG4Zl2ZYKENxn/9buRMGv59VEL+yUbOGZwYPUHMyQEYhuShdkT6phruj/KtyXLNJcShnEXjCCFTmUpKX/9pISnj4qtuYRLRI1G4dsK0PEzmvfeoESsBzZESrJt7j5hVsCPoPGWouLYvBZ0SiFeTSh+QzSW8hlZF37nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482969; c=relaxed/simple;
	bh=KLSkK6Qg4UAryK/QypN2nQ63MLecaVYHzJbXbDtiYZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd6aIaZCdHpBmERLgn14lmuBim0WbjHXCuSzL63EAmaU12BT3zbujLxVn5G59ycBmN702HenbRRKnrpxEKWxNYlZ7zJH/lIYw9JlwtI4P51C+uG59bEGrx5xLS/xkdMYzBNLsKbjg5hVE0joXF5V3ivModvdtxx9aej3x0zAqyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=BaiBVVMR; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="BaiBVVMR"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a65a351692so9087051fa.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790482966; cv=none;
        d=google.com; s=arc-20260327;
        b=qoCqr4yVU8wSCbWRE5ieFaeb/NVvuQgvcEVQBFOFodM6NAu8PAfLrAy4klffGLsfMG
         rfdHYPTus+mK1ZMWSortDnJgFika/GwXuzD47/Lhql6KZPaUUlD1yg9gwqjEbJtsHueE
         CfjnjwuUZwo7w4FrRDitwbRIBnev+Vvi/Um0FiDO/h7Joxhsfa0Rgalxpbh0pAoA2wW5
         58xDUCU21XKdSZZp7wOYXZh+4UUh7Wrk6+wd8+HxdLuM6or3ORqbWqB2L0KZtHISeJEW
         0FcHJ91dk0kW1QeMKJ3CJrGJy1iSUG5xjW60PM7P783JSlE9XSz2Ow53rvWkIkkOlEu2
         E4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4hVd4e7MMTnrKqam9M+BnFhXIR0nvvUtPIpD0gRr9bg=;
        fh=YG9/+rFjZcb8cPi2aqx9uUfCjlr11X3ArrsaiLeXn+g=;
        b=Fh9J/v4UO9rTuQBC+sCeaLWUaga+ppXNpIMRcmYGFUPkFAR6Pt0G8VbxU7BJiCk/X0
         e/q7QFHbZuex8xkjBABk8DrtXVCrsvjJE5dulkkrBl+5Te8tgr+F7Z7bpmLX2Reij7l4
         eWl1G5t7Z6BEWEfFepO/w1c+htvR1CvRFDBRLr3jNJXsXvHiPxcFbWlI8r9UVni5ZqzM
         TUoXnQ/k7iP3HmPQUCt5zqh4mVHKixQ0HSfDaLYUIpvTG0gzZ5kaWvyG0F2WPdSwnhfz
         7Aj7Shey+n8PnXW1DRD+o/Zl0iSIQDefIuln/9dt8usiu9LUzOvphbudQQi2rVeWTnXr
         bRzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790482966; x=1791087766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4hVd4e7MMTnrKqam9M+BnFhXIR0nvvUtPIpD0gRr9bg=;
        b=BaiBVVMRU3n3QH0XSnvuQqc+2NaGSaZzWKIF2+GNz8QLZ7WLj/uNulbnOzyeK/VYat
         gPUcS6hnZhPE29I33DiswgMmUJ29JNfSsJX/YBsMJgjkWbYoN4UhQP4GWPu7ZFZzGLOL
         8Mo3UavDmR8iuf4tWpvGLAB+5LzLrdj1AyVobWe7B91BfZYbWaBqUvhrspkZ0ZW9f2Dc
         ND9Xo6UWG4LQZz1hle2+0r3dl7DQdd3cMx63hFH1FSiobltTgT7dn8zG9FDb/u3qWJpH
         cMsZUw28c3JmpkTjB0gp/2qmXdcVU+yUltIRcNBoO4v90UwJMdGJVCBPFV1BoSh0p/RB
         DcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482966; x=1791087766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hVd4e7MMTnrKqam9M+BnFhXIR0nvvUtPIpD0gRr9bg=;
        b=tK1XIumTYYr9lhSQZNl4OOlcvWUXN6IwCc15bgh0eFaSXBFcRq5uWDsKy/PHZA+xk3
         FlnhUY1Q+Epc3faX9BAO05YGMD9BOL3nxe9qj2/IIGcC6eFr3qfQf+cpQZHG8jo2zK08
         mbffaJvi6iAG7sVFSqgswzpsx1fsmXyKriH5jSMypoFPYSHN1xvd/lFACJGInCtqj3qU
         nmrxzghk2YdpFFTptmSCD7iLrlVlS0hF0/ink9oRZwHGbEM31RL7mBjhcMS8SLgkenWH
         pbUG4WiYWmborpDq8gDBlH93nHjyE1JQCA/TZQ+q8jbKRTd9O2zewDXDuZbFObimxXl0
         Tn9w==
X-Forwarded-Encrypted: i=1; AKwUvByltQodx0Row7IOWyMfXyWRyvcJfTD3LLPYpe82Y3+jOrZ2FovBYYd9dJN2EjW6y9uUAkzgTAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyDrlGy5WhNu2N0GBuVUNvio2bH3cJmFMZ5kG367FQ2aRs99jm
	GDKnE3QntuyQnMpOdUyqqPAqiEIWs3Zn1FCi9nz6Q+CIANtz39PfeIcSiG28P5gsD5/isaeExZ5
	lT7bf/7THXzel3oKueKvmgEgQnrecd0dLBDYFjdCUKQQ=
X-Gm-Gg: AYBFou0qZ/AWuPjLrvdfMBKw+T34TCXAPNt0OTv3U5n4gZ5zYozmPxgCbmhj99MYJQH
	Kp/eXG/4XsNqmi3WWbL7yVL6nRAiKT6iwyTp4n05E1pseP54OU8Sm/enb5G/A2HoQa1e40tunpv
	cR3GtkBsEKRgwRu9BiOt5UNJUIDMce6WDG4VPnSAyqdy2RwXL/ZXZDXPGT86/e3sBzQ8s6hyeyZ
	2Xoz2+a6x2aGWqTXlDS0O4B+QGVuue9firbqf609Vp+F8hHc6v8OPkJmKzEo/G9DBG+8IWiuqBH
	xpX3ZxMUmn2mF1Y+TPWDgVDPjMk7bdXTBbaKrfxEv8wY7yDS1s02VZm+RuXiKeigo/2jn5s8fS5
	2+/I0hIakzw==
X-Received: by 2002:a2e:bea2:0:b0:3a4:9e40:d7fb with SMTP id
 38308e7fff4ca-3a63c0cc6b9mr23491471fa.7.1790482966403; Sat, 26 Sep 2026
 21:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926132208.23360-1-zihanx@nebusec.ai> <CAKYAXd_T=r4doyNdeykejj4SsJHiK7Fv8aujt-fXACFybUr9xg@mail.gmail.com>
In-Reply-To: <CAKYAXd_T=r4doyNdeykejj4SsJHiK7Fv8aujt-fXACFybUr9xg@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 27 Sep 2026 12:22:34 +0800
X-Gm-Features: AclHuK-uSdiQSGbLHm-IaWFaZ_ga-DC4dbueRI0jyMRqGje92KnB5CWXDHu3OE4
Message-ID: <CAANe3eREUFdD8QaviwXTTmpGSF5cu_FJ3C9iHKsE1gpFMmjqeA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: avoid NULL resp_iov dereference
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	tom@talpey.com, bharathsm@microsoft.com, dhowells@redhat.com, 
	stfrench@microsoft.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
	Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 10:23=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
>
> > @@ -1111,7 +1111,7 @@ compound_send_recv(const unsigned int xid, struct=
 cifs_ses *ses,
> >         /*
> >          * Compounding is never used during session establish.
> >          */
> > -       if (num_processed =3D=3D num_rqst) {
> > +       if (num_processed =3D=3D num_rqst && resp_iov) {
> Could you please explain how this code path can be reached? Earlier in
> the function, if ses->ses_status =3D=3D SES_NEW or optype contains
> CIFS_NEG_OP or CIFS_SESS_OP, the code checks !resp_iov and returns
> -EINVAL.

Hi Namjae,

Thanks for checking.

You are right. I could not find a reachable path to the
resp_iov[0] dereference with resp_iov =3D=3D NULL.

Before waiting for responses, the session-establishment branch
returns -EINVAL when resp_iov is NULL. For ordinary requests that
may use a NULL resp_iov, optype is fixed and does not contain
CIFS_NEG_OP or CIFS_SESS_OP. In addition, SES_NEW is only the
initial session state and is not re-entered during this operation.

Therefore, the condition surrounding the resp_iov[0] dereference
cannot become true with resp_iov =3D=3D NULL. The smatch warning does not
account for this control-flow and state invariant.

The added guard is redundant, so I will withdraw this follow-up
patch.

Thanks,
Zihan
