Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBA3DB626
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963791; cv=pass; b=Xh8B5JJhTi6m/O2B0AzxD+MyH30smt6G9Y52OSd/HHJCFfaHhs4ctYiIdTXN5vEkC4OIQxdkLmQ6cASpwiWD3fKBp9rffCdvETQnumz3GvDgoAfO38y1gCzMFqxWGCzXgdcK04rJtTPwveX2ljT1/gCv7AFqqTeSYjkxrzYmiz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963791; c=relaxed/simple;
	bh=vNuBttYXzn7l6JFZ+O3w0e33DT2r7ic+b7PA+10I7z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXSxgaXo+rEP66CWOVl7wNDD7ecOT+oqq0vI/Yd7p53uRdtd8JbkGL2UyeBSICQIDCbOMIyqa+GyggOMkFzkjndcK9NBzJvzSJsRQMXPX/Bvv3bqEdfvENKAAVTIz6KXUuShR2+KlTPvuBfng3CTFJd2D8fUHzy1B5kgPJ8GMO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjoGSTg; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjoGSTg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cedda2ce6fso20292335ad.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 03:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786963787; cv=none;
        d=google.com; s=arc-20260327;
        b=O3gPcaxOlMiY05wXD4o90Uyc18n/YiJEWPPrKbbmiFk+52VJJpEWEtlzXfJBdeFi4A
         HnREp0ZbalTPIwyQiKIsl2TzMC4o8kHmwgtQGci3XiaEE9DYuTCJvQiaa1r9d5STQDhS
         RLYzizb3GM7CaMJgbgQrvDc5YG9MDlDpsFjN0dhDYlYBxXN7aBR5gf2OHF8i6qXUG2XR
         +X3olzkpE9TAubpHrNzz23UeyJF4nsxB7eYQqSvYm+76qZ0qAkW/X/xO+ZCMTJfQgi6G
         h0hPSutMh9Z80mwNtUoByCDAtBPQHjV1kFvRX1Ldl0c0WyplNADcFvVZdB+6XKtuuwts
         zlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=10MVIIGEzvWvDaj1ETw/cKkyqZ37uW3f6xvqzSoqCb0=;
        fh=ViOEhS0THpDYhONfKAOBpCh+AGDlDlqVs5/bkPsqaU4=;
        b=E9BOqs8MoVbviLA9LFJtqdmgzaqCgJ8wIowShMVPQ2VhBKa1DcD5rvwcOjMO3t4lMt
         hpYyI1aLqXFdN7ltsOCRENsPUisFeJFWgsM+1/IOvawIsaYgWAe/cZdqGN7Y4W2FGjlg
         zG3PlcravhzZ4gKsPzB08TRnxsVbZR+khoFcyivVUYYWb2HnLNH8mZvMrghG32aC6UdJ
         JhrEwmI+PzuBDhi/I+SPwobZHkmlzzJXkcfWFHpMyOWIuSPBbNiaUfsalhTctbAcwzSs
         2Uh9S+sceoW2101ffG4HqmtC7sr6zSvnYIi5tX/lqALzb9z8TxmpnjIYixp3V/ZSq5a9
         tK7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963787; x=1787568587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=10MVIIGEzvWvDaj1ETw/cKkyqZ37uW3f6xvqzSoqCb0=;
        b=SUjoGSTg7m9VZFLpg6xuNCoezgGMUqcd3LtcwfMG2zHEyzPU2cjROeFipUBj/QoziG
         USq/f1mi4fS8MfCKhaYar1HyJs7wkNDU6X2Wqp90c+blxDoYU4nT1nOowPQYnx7m+kyi
         0UJC9LOYkf/Ez3HgN/bcVmr/q5AqHiMcceVEQdfcC8lWQizr1SzIETyDevrolM/Q9w0Y
         ASQa8G7wS95Zu9IUAcCIQ1q3eDVKn4EbCRJ0OqjAv2k4UdkhyxTl5aCFaLO6GYmvCfn+
         2slh2NQrRrOwGIu1MgPidI/luwC4BSXnvWX4Kepb9cHynPVzkfh9R3+tW8iNcOMJnOaY
         umbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963787; x=1787568587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10MVIIGEzvWvDaj1ETw/cKkyqZ37uW3f6xvqzSoqCb0=;
        b=o+ExMRtVveyMTNRvbGXRoMN2/4UaVWd+D2Fgk5VcMttLmFBEp5vPRmy604YktWC/0I
         eOmbPUcAPmgwxSrSshXy86d4T7lkeMFMfqbzNAuwaX4erFSQEbJWj0gcHDh3wfQP7fI+
         DlAOWkyCOGzpbv9KPmsXPOnTHDKdrXJO/NTF4bTzSM4YX4LtkURtl/AUXxNfWWWrr1eu
         iEgGjWDnjd+fQr0YnQn2QMzb4YJGZaVRCtOHt0v7xHiDCtASgKyp77UfvH+jut2GI0Z7
         tAXMCbGHGwrII79gbCB9dWgnpdopAx30teyJiqcRVAryzV7mnC3SweteG75RospXcIIi
         eblg==
X-Forwarded-Encrypted: i=1; AHgh+RqVM8FwX9LeqY4GRCpeWut7kQPmCg73DjK4pRfeLhxZa5DSWD12LrQDAinow58fWsNpm5AijoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJaK5adOdV3aOYaWQxwJGW7Kn+OII8EVBUlmVL50Gx0im2Wmk
	b5YQAziDDzbtnlDwngYq9rIg0pHFoVy7PafdCk+zl1zjdUPSwPeoy1rWVeWiejkmOMHNDAiGFlO
	6FVfI1Dfc5ruW8S5CzyeeYQL3joY+mXo=
X-Gm-Gg: AR+sD13rKwjwoQ2YlxKzjdfjbIxwebvqJxMzkW1fgGa/9ztBc9N9MQv12UtuXggtVyL
	J61r4LvUkW00T7L1psbjC7oFuecjE3RPujIZLSba4PA3GG85LlRRsxPMs27FMM0g9pXJNG2bQGZ
	TEeU+uEMmRhNxFmAQ64F3H1lsDNxtrL7yOsvVS/PCSmVfLu1cCiHhJxlf2aReFLt8mOHEBRmr/f
	F1Xfyhm2k6aL1pf3HeLHnEXBEfKL9DB/0Y2cG16+g735OuH8vOcvUaHX8V/iPFVUwc7s09/iyPV
	9M/GyAiJZ/20IoCvIwNFzJeSmPt0ctp+4csj7Fv4/B2x3Vqc+Cj6CFzkBhb/wLIxwb4F0tjCS8K
	v8Q==
X-Received: by 2002:a05:6a20:da0d:b0:3bf:6011:53b with SMTP id
 adf61e73a8af0-3cc71e359e4mr28612349637.38.1786963786854; Mon, 17 Aug 2026
 03:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com> <aoLbbZ--FrkVN3SU@stanley.mountain>
In-Reply-To: <aoLbbZ--FrkVN3SU@stanley.mountain>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Mon, 17 Aug 2026 05:49:33 -0500
X-Gm-Features: AcwNN1WaN4sltzO3zSzfLw4CjufC35rEjXBIf8t5Lk-s1QFWw5Yg9F4K0utpl-c
Message-ID: <CAHYQsXR1RS+kzFUQQ24YFyxxUJE39Yk=YfuFgAsvph1hKqqd9g@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
To: Dan Carpenter <error27@gmail.com>
Cc: moonafterrain@outlook.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
	Teddy Wang <teddy.wang@siliconmotion.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 4:59=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wrote:
> > From: Junrui Luo <moonafterrain@outlook.com>
> >
> > sm750_calc_pll_value() writes pll->M, N, OD and POD only when its searc=
h
> > loop finds a divider combination with 0 < M < 256, and returns 0 when
> > there is none. ddk750_set_mode_timing() discards that return value and
> > calls program_mode_registers() regardless, so sm750_format_pll_reg()
> > reads the four members uninitialized and pokes them into PANEL_PLL_CTRL
> > or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a mode
> > set can ask for a clock the loop cannot represent.
> >
> > Consume the return value and reject the mode; hw_sm750_crtc_set_mode()
> > already propagates a non-zero return. Initialize the structure as well:
> > sm750_calc_pll_value() returns early for SM750LE without writing the
> > members, and returns non-zero on that path.
> >
> > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > ---
>
> Greg is not taking AI patches unless they can be tested.
> https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/
>
> I kind of hate AI commit messages...  They are so verbose, confident
> and reasonable sounding.  But they don't answer any of the real
> questions I want to know.  How did Yuhao Jiang find this bug?  What

We're working on an LLM-assisted system for vulnerability discovery,
and this bug was found by the system and checked by me.

We proactively wrote this patch to push for a faster fix. This patch was
also assisted by AI but we manually reviewed it before submitting.

> did the symptoms look like to a user?  Are there ways we could
> improve our QC process to prevent this sort of bug in the future?
>
> Probably the answer is that the bug was detected with AI and we
> have no idea what the symptoms look like.  Everyone sane automatically
> initializes variables to zero so probably there are no symptoms.
>
> So the problem is that the user inputs invalid var->pixclock, and
> it leads to an uninitialized variable usage.  This patch addresses
> it by initializing he variable to zero and checking if
> sm750_calc_pll_value() returns an error code.  Either approach on
> its own would would fix the problem, hopefully right?  So it's a belt
> and suspenders approach.  But isn't the real solution to reject
> invalid pixclocks in lynxfb_ops_check_var()?

Yes.

>
> We're not going to apply this patch because it hasn't been tested.
> Probably we should invent a new tag so we can create a TODO list
> of rejected AI patches.

Since the bug is valid, and we lack the hardware to test it, leaving it
on the KTODO list is fine.

>
> KTODO: investigate unintialized variables in sm750fb found by AI
>
> regards,
> dan carpenter
>


--
Yuhao Jiang
