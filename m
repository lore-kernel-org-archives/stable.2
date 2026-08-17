Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535A442FBE
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984979; cv=pass; b=Ppq3uuvnUnBNekkbKC/aCa2egAAFMp4nFOrY7pDlcCYKV+YGf6qPI/5C6qOO5VJH4WJQbENe/8TjVuHAlpOQO/LkYyNO5lhz43gHw8PrU8Zc48zo3RiKMDD4A7nzYVuTH9G+zjF05hW0zCNkz+J9EskqzXVTkRDcM0Tb8sR3lUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984979; c=relaxed/simple;
	bh=EkJmkr4i0XfDcLVsu3GNYhW4t/PNRuWRBy9eVihU4eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdfcjz8NFWu7sYRjcnuvOaSnyFGuAfKZtOyWVAthyjXKztZBGqGTS2+duqJF8JRVIz+9UJXlR/adTQqJCngjkeXXqtY1Yo9wiOx8N5SHb3/7sDMeuDk64EM9ARIgnrbcCwIU7lZExo4iMxvp8PKywGw/WC05tmI1jEr0P92IuF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHPFdZW6; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHPFdZW6"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81f3b227a4aso52921297b3.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786984974; cv=none;
        d=google.com; s=arc-20260327;
        b=ghwZatuUxK80xZR5itEXaZDR3czfk6PUJCV/fRi6Ckh96zKGnYjGJjdfhcrPuECgUQ
         dPl1kTVij6xMo3D3B0W2/DKD5cwX6k6xoD6uuV40wP71nn+m+3BpJE3kBTDtgkq9E+ur
         kPBPvpdcW/xL1grk83WrFCQLQrrGUHapI1nj9HpzlA1sY+yPXuIdej5HM6/JGx4WElUK
         RW6sGMtwS8IFjsm0dteLn5g0cJ+YLvI+LcorkkeBrjKR2Bw68NjLzk3JVCH6Itn6XvKF
         83Dim+S4+YtciOPXR53U+s5U57yeZfHPOBDoucAtCtpRcw4YjT+EvLJfLtLd/uip8thW
         osqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/btAlrvPaD93Lrko/2BtnY6B4NRoou9llL+XSVCd+w=;
        fh=RKuApSpDlcZbU6pVtH7yriLdqbxf77qNGNtzzWZ4J44=;
        b=OI43pmpON5k4WDxKYGWgA56bc9S+AZCoj1D1Xr7OpedY9nBrJeXWPH4X7tIKvJGo4M
         aVgNisBNDqCN9Osmf8dJd24efuemeVOWV+xQrJZOGtjg/7PV08lOoNB4GVXFR89F3fte
         +EMMSrKRjrupf5wiGYamGD+1JDYGKp3qFGtkHO8lO+pwsNNmhhmMWpAY2vtDZuyZJWpA
         VxBi1qP2AffUXeHu1J1BxT6olxqG+M/w7QgHYr7ryov5pz8r/NzAsCMCBxR9Encavr8M
         hmGiSSNIlcygu+eLKHKV2Gc7BQFDDhRtH9WPNE2JD2svnX7GmIscMSoncPbCn9wNl6X4
         5/XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786984974; x=1787589774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/btAlrvPaD93Lrko/2BtnY6B4NRoou9llL+XSVCd+w=;
        b=LHPFdZW6lRnqTYHW60ekEN7LwPD/XOtMmKdf3xzuGRbaNPzO12wes4uvPKveW9nwdz
         KtkuJRoamK2z7su1NLWKAwOKRtHPssFN6c2sNqrrxxjf3+xRGKjh3+3Tp4Vjpl+Gz/f2
         DngfBxjRGIDakFTB8M9k79sZZO/8pqYNgPVzoNoWXyntXAS+ovVSreUJOoWgS6brJNDX
         CdBkgetLTfoBZvDwadKJHKGgcSOz4RseDsBelZEU4didA3nWI+id7Rv2jUkRRwxJl7ke
         Ufu2Lvyg8FUKwDFydD0wqV2vrWLUVxjVP15+ZypYrcdrjyaTTD+zmw8UWHTAgaNm8Rmy
         m2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984974; x=1787589774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/btAlrvPaD93Lrko/2BtnY6B4NRoou9llL+XSVCd+w=;
        b=OU7Pfy50ZoC68MeJH2JR3gKLKrK1xfZiMUAYx5TBZO4itwZJqEI7Y5ciGVMV1W7TbI
         2a/tp6CfcS+zmgTcWgnZNwOgL4rdZt7bZbieeLbW3mKxF+V+nnGe1iqhWLSA7Y7n6Vnx
         MIowWGf9uomBTb6wbp6wmg2Fv40zqMnVLcXN+kA5CXFRcPnf48pUnmv+EurRaRPhFb8z
         lwSNpcSVhsXAaYMo1wlFUdeDlpBd5k6C9+1zQo39E47r9XMUA1q2Bl9320aJVh4Y0KIa
         DBvmj+uj9OuAgzmJJegZp0AzSRtUSUCul8jre1heQmsyy/TC9urKT6MnLVN+f2x11prb
         umKg==
X-Forwarded-Encrypted: i=1; AHgh+Roq2Qdz9nTkSWax1a/RsuGrdQd5nLQ4Fp0vz3yu5CQb/tx7LhFYXXEqBWu/D/1BD5aQUggE2Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOYdcv+VYSTI7k9wu6rcRLa/4MyLWp7UibtOr1QC5Nxw2KVat
	V5d3OYsfom9xvJVmFNZmcOtjHKtlAhsZAh2i1qUIdW8hQNg7I5mx7SEcP89ro6MpkVhhwQWyzwG
	G1DTOOES8VS2KCmnEynxOk5E1nEB2spU=
X-Gm-Gg: AR+sD129Lhbvqo1OJnfjy1UYgEtMOH30EXbEayaxBOeqy7CF0jKTlUNFqLIcOdoANJx
	vhFvqVF4fMWDkZ5vWxN1oFEJl2BPnL0Tshxgk85VlLJC349ei1/RU8uH4e++ir7+jfztoFTwaOK
	9n8oERHFKuZM83VoqIWvn1HnFjcrB0JDD5Scn8IR3fWzbWlNeKiC4AIyFP/wsPbCreokD+Z/tGI
	wdBjdUjl335aHH5BEJtRQGPTxpMsd6SCVTjTQvvxNeKHRw7FL1Sk9CkEkoAvCNUuRyOFB8OFymm
	YVfyAYU8aOwtam0WdinbMZFEGQY8LJQOGP4YQ28/swocacFu3zhC915+oDMJogkxclu2Jefa7bV
	jlTJ4asVgwjGXjqtGF/1MGJd3+UjV
X-Received: by 2002:a05:690c:ec2:b0:81e:893c:2c23 with SMTP id
 00721157ae682-8370dfb375amr114957297b3.11.1786984973996; Mon, 17 Aug 2026
 09:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817150240.520181-1-valentin.kindschi@fiveco.ch>
 <20260817150240.520181-3-valentin.kindschi@fiveco.ch> <CABBYNZJ55q+jpSRrp7PS31hR6xbDEPNExQCADKGWFKtKKweMjQ@mail.gmail.com>
 <700f0c2d3c5d4ac8bea4774375703bba@fiveco.ch>
In-Reply-To: <700f0c2d3c5d4ac8bea4774375703bba@fiveco.ch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 12:42:42 -0400
X-Gm-Features: AcwNN1U0lbZ9sKvFCoDq7ZEQvI75MALh1DTXrlbrIEUc-kGiNRabIMye2jFeZVw
Message-ID: <CABBYNZKLcM2L9VTNhyr=O+TMHK-CoyspCQA+yU_hP2ER-SOS+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_event: keep HCI_LE_ADV set if the
 host cancelled
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Aug 17, 2026 at 12:31=E2=80=AFPM Valentin Kindschi
<valentin.kindschi@fiveco.ch> wrote:
>
> Oh, you're right. The test is too narrow - a connection timeout on the ce=
ntral path should not clear it either.
>
> The clear exists because advertising stops when a peripheral connection i=
s created, so the role seems more relevant than the status - but ev->role i=
s not dependable on a failed event, and the conn lookup that would give a t=
rustworthy role happens after this point.
>
> We could move the clear below the lookup and gate it on conn->role, or si=
mply !status ?

Try with !status, we need to confirm that doesn't break any CI test
either. That said, it does look like it would clear it also for
extended advertising where there could be multiple instances
advertising, so I'm not sure if it's correct to assume that if one
instance connects all others shall also be considered connected.

> Valentin Kindschi
>
> -----Message d'origine-----
> De : Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Envoy=C3=A9 : lundi, 17 ao=C3=BBt 2026 18:12
> =C3=80 : Valentin Kindschi <valentin.kindschi@fiveco.ch>
> Cc : linux-bluetooth@vger.kernel.org; marcel@holtmann.org; johan.hedberg@=
gmail.com; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Objet : Re: [PATCH v3 2/2] Bluetooth: hci_event: keep HCI_LE_ADV set if t=
he host cancelled
>
> Hi Valentin,
>
> On Mon, Aug 17, 2026 at 11:03=E2=80=AFAM Valentin Kindschi <valentin.kind=
schi@fiveco.ch> wrote:
> >
> > le_conn_complete_evt() clears HCI_LE_ADV before looking at the event
> > status, on the premise stated in its comment that all controllers stop
> > advertising when a connection is created.
> >
> > That premise fails for Unknown Connection Identifier (0x02), which is
> > what an HCI_LE_Connection_Complete carries after the host issued LE
> > Create Connection Cancel: no connection was created and the controller
> > never stopped advertising. Clearing the flag there makes the host
> > believe advertising is off while the controller has it on.
> >
> > Other non-zero statuses must keep clearing it. Advertising Timeout
> > (0x3c) in particular means the controller gave up advertising on its
> > own, so the flag has to go; leaving it set would make the "already
> > advertising" shortcut in hci_schedule_adv_instance_sync() skip the HCI
> > commands and silently stop advertising altogether.
> >
> > With legacy advertising the disagreement is self-sustaining. On the
> > next software rotation tick hci_enable_advertising_sync() runs:
> >
> >   - hci_disable_advertising_sync() returns early without sending
> >     anything, because HCI_LE_ADV is clear;
> >   - LE Set Advertising Parameters is then sent while the controller is
> >     still advertising, and is correctly rejected with Command Disallowe=
d
> >     (0x0c);
> >   - the function returns before LE Set Advertising Enable, so nothing
> >     re-sets HCI_LE_ADV.
> >
> > hci_schedule_adv_instance_sync() re-arms adv_instance_expire every
> > HCI_DEFAULT_ADV_DURATION (2 s) and its "already advertising" shortcut
> > tests HCI_LE_ADV, which can no longer become true, so the command is
> > retried every 2 s indefinitely:
> >
> >   Bluetooth: hci0: Opcode 0x2006 failed: -16
> >
> > Captured on a BCM43455 (no LE Extended Advertising) after a central
> > connection attempt timed out and was cancelled:
> >
> >   LE Set Advertising Parameters (0x2006)   Success
> >   LE Set Advertising Enable     (0x200a)   Success        HCI_LE_ADV se=
t
> >   LE Create Connection Cancel   (0x200e)   Success
> >   LE Connection Complete                   Unknown Conn Id  <- flag cle=
ared
> >   LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.033 =
s]
> >   LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.016 =
s]
> >   ...
> >
> > Keep the flag only for the host-cancelled case.
> >
> > Fixes: fbd96c151cdc ("Bluetooth: Fix clearing HCI_LE_ADV for LE
> > connections")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5 btmon
> > Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
> > ---
> > Changes in v2:
> > - Rebased onto bluetooth-next; no functional change.
> >   v1's hci_event.c context lacked the hci_store_wake_reason() call
> >   present in mainline, so the hunk did not apply.
> >
> >  net/bluetooth/hci_event.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -5720,10 +5720,12 @@ static void le_conn_complete_evt(struct hci_dev=
 *hdev, u8 status,
> >         hci_dev_lock(hdev);
> >         hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
> >
> > -       /* All controllers implicitly stop advertising in the event of =
a
> > -        * connection, so ensure that the state bit is cleared.
> > +       /* Advertising stops when a connection is created, and when the
> > +        * controller gives up advertising on its own. It keeps adverti=
sing
> > +        * when the host cancelled an outgoing connection.
> >          */
> > -       hci_dev_clear_flag(hdev, HCI_LE_ADV);
> > +       if (status !=3D HCI_ERROR_UNKNOWN_CONN_ID)
> > +               hci_dev_clear_flag(hdev, HCI_LE_ADV);
>
> Hmm, I wonder if this is not valid for all status !=3D 0 though, for exam=
ple if the connection timeout we probably shouldn't clear it either.
>
> >         /* Check for existing connection:
> >          *
> > --
> > 2.34.1
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
