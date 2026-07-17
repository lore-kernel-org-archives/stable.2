Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E543FBEB3
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293030; cv=pass; b=eZLtz5WcrOAy5I101d6SjVjwyMRRbwzkU67DNtAPYHrPUuAa9db2zWtSI3AhGANTIrRdnQDU+H0qMaijMx2NCNoH9+Q/QO5rdFgwk/EEuCu9W9x+IkhnHwaZnLpeaTFWmvXH0hzXT344eDknZdNV3/F3YRQ3aKt/I9CPb7f7aIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293030; c=relaxed/simple;
	bh=VxRwuygTU9AoUQ0S4EdfU+bCUToEaxOHkB8It6+r9Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUDVEvMo+YJ7wUzVzQ51DOLf830eKT8LSUS3oDCdKN5fmvpRQ+fKTqNNqxzoH8C19GbT2bR1OFRgvjU6YjH9Wivoy9oJeXTomtb9QFEqkBe8cQz227zZ9RtEtnV155zSBA0RXZu2EcZzXDduldGYMyjBKb9BZ8c32uTPeqHD/6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwrbEhRn; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwrbEhRn"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15f020a223so1031822966b.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 05:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784293027; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2505doP27gN7mUcgZA5Rt9vY9FycirN9hJy+SHlk70PuuyHSMfSBPX3pwjO1SN0dw
         TDrEee81iWCznFGIhPq/Hk62iIvOkutcaWkrcoEzdOVoOp7WkwoYpIh5Iwzjc+FDQs25
         BM6eJLh3YqLodmDnabnKtW/f+RqrHsSIIQmIcx5/1acd5l87RFHZtK9zNYfCmtchV1Ed
         Gb9rN/doUZQJ+YiappcrWsXuyv+i+XWCHBiGnv9rjOzZrh8+NQ1SnTnk5kZjIklcCfEl
         sE3WiUNwtmvzGJKFu46sow+lFGlGkQwbP0I7HcXetkDMV23bnE6KoOLhRpkQBci4uhWJ
         wpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=svTgFu9s+lNvR0ImLSl7IFWMvijrBYhlNbArZkaFdUY=;
        fh=oHX9f9m1BYrP8IQtOLwpTDvv0Oc5TFl182Sm2fcC6M0=;
        b=FAmLHlVkeHfIgZkQy/O8la0oeUDcnqfAretplnuU5vhWStDXQn2Ta6Fd481UcHeGEP
         hPsJfWOAaBBVLTwV/gJYFYsLHK2sUes5RR/U2GkdqVt71CYkDUYl5U/uako0t3LVJASZ
         W6ds34FAbTsZF7GwhaNRGMoMz7Cbi+H8QKP1PvGxeCSQI22GXjo1IiamjoJIOVjMu9dm
         JMhDw2kqzxyRyYxjHol5EVv+pRqUVmgrptevxBy3VUCmz1UVXrf3hgmbx6UT5qvOFgTp
         JwBq6Ek0Jcf3tPrtyAbHBnDyA+qZDaVwoUFGtMtXHvQni29CJojkTgd06yZ87iCXE5Rn
         88wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293027; x=1784897827; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svTgFu9s+lNvR0ImLSl7IFWMvijrBYhlNbArZkaFdUY=;
        b=YwrbEhRnloSBfWJjDGm7AQciaPXUPhmG58sp+YhoATdBNnAWTSFxwScdfegXJ0Tujd
         vN6lY8+hoO6ev7jIHAlw4as18tqyp2XLFAvI1MZ3xU0GDQW3zzRwNxpEVQC1sv3RF7OX
         YKR8USlSVpZFGnGjn2aFQ2WIzt0QYvzBrNuJ9qpbCD1EpSfBATPGy5J6NCjEQqNukKbr
         NFvVDQdC3QCRSRC+uLGt8IarIAgnYlh3OIgzXv7cBiqMTabERb9RXOx86EvFrUTrc5p5
         GCCLyz1hk27yHizKechUXBcIQypfZcStUqiBvVei7vaznM/F5vGwAsxcGrXJ52fOIYBR
         V5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293027; x=1784897827;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=svTgFu9s+lNvR0ImLSl7IFWMvijrBYhlNbArZkaFdUY=;
        b=TbfzDaUL5nMyuYOrdheq2fp9bZ7rYH4VBFVrHbdKPxIpSmpe1rwii8Yd+zuVL48xwB
         w/a9MfGCaauIfhG7eiIRAGSB6jowRB5kGYw+amRR57u5HbVeaZC7voX0pTVlA3yTFdpo
         1tYyn0ZdBo92KCmoJAKGYkrhQhgbKmEr0wkw+IAOC21yp6A5Oy3wmRM00NY1wX2IEtPX
         PI643cVm2DVc5KWp7ytrVayzOwPe0DF2j7jrsLNUlPbG9RkQWzQaJ/wGHIQtEFUCtfa6
         gL0hhwVq3gbBF1tmjoqylGqxC7JYXksDbNhR/OlWCAElnpJ3mrbmJToypVaUxQxgmJD1
         54BA==
X-Forwarded-Encrypted: i=1; AHgh+RqPINeQJ9OHrrHNTy5JUd8/nnLoujVEEyxyxSshUNUZP/C3Muup3uOnr2bsn3poQE/tk0D0EJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdVmS9zFNKf2gu2ERphO0zj/2mX4Ak0HFsTjztKkX2aM0AEn0R
	TKMBk5QZ0zhruuSZ6Lgk5f65fOz/LxumOS7FtDmUY3k6yEwlvj96OBFIkLSCovvetlmGaqAmdDl
	5X+crweOVRlQxe/y66bsb4eISDDrJBAc=
X-Gm-Gg: AfdE7ckKgTDLZMwyRTx3VCicRXZQkGGDvuo98KL2PadhU0ZXmewIrnaCQgXBMVw3+C+
	rAeTIt8KNWJoG9OoNJDUci7NZ8zJGieuqGijb4pRxl08nhFO1vdcdoBcIWAvgvCgFA7PbVY3iPn
	mXiEJUw7jrKwxbiTRW85KZvBTbLJuZAf2Kb9NkJQJyGx9PBiqL+rvTywMKfiaX/SeY4tShJrUfT
	sZ6sl/To3qbR/LFDv2oe4MiXYzEo4sJBd4zWwD5gZwWpKvKyX+MboLd2+PhXgqYs3F1UIaK+TNU
	X1IXgZKiF7htTk+vO2SFG5IxTyllb0vi7X8YdF25kJEyjwIq0Dis6KHi
X-Received: by 2002:a17:907:72cd:b0:c16:3187:997e with SMTP id
 a640c23a62f3a-c16b46ade61mr99195166b.7.1784293027129; Fri, 17 Jul 2026
 05:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212312.117781-1-meatuni001@gmail.com> <2026071744-unsteady-easter-16ab@gregkh>
In-Reply-To: <2026071744-unsteady-easter-16ab@gregkh>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Fri, 17 Jul 2026 17:56:54 +0500
X-Gm-Features: AUfX_myKzWSR5rEYoP3NZQmCokffDes95vQyXBZBa1acuorlTHcHVbko8mUajy8
Message-ID: <CADqcGB=nEfdZhZj_zkO3+nW3M17XYEM86mSQctG_3h-pjsz-3A@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: audio: bound topology parsing to the
 received buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Vaibhav Agarwal <vaibhav.sr@gmail.com>, 
	Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 17, 2026 at 05:13:00PM +0000, Greg Kroah-Hartman wrote:
> How was this found, and tested?

Found by manual code audit of the topology parsing path in
drivers/staging/greybus/audio_topology.c.

The pattern that caught my attention was in gb_audio_gb_get_topology():
it reads a u16 size from the module, allocates and fills a buffer of
that size, but then discards the size and never passes it to the parsing
functions. The parser then walks the buffer using lengths and counts
taken from inside the buffer itself (size_dais, size_controls,
size_widgets, num_controls, num_widgets, num_routes, names_length,
items) with no bounds checks against the actual allocation size, so
every one of those walks is an unchecked trust of wire data.

gb_generate_enum_strings() in particular has an unbounded
while (*data != '\0') scan with no end pointer, which is the most
straightforward out-of-bounds read.

Testing: I verified the patch builds cleanly with
make M=drivers/staging/greybus on x86_64 (allyesconfig with
CONFIG_STAGING=y and CONFIG_GREYBUS=m). I do not have Greybus hardware,
so runtime testing was limited to build verification and manual review
of the bounds logic.

I confirmed that:
  - All four block offsets (dai, control, widget, route) are validated
    as ordered and within the buffer in gbaudio_tplg_process_header().
  - Each per-element walk in _process_kcontrols(), _process_widgets(),
    and _process_routes() checks that the element fits before
    dereferencing.
  - gb_generate_enum_strings() now has an explicit end pointer and
    rejects items > names_length.
  - The gbaudio_control_size() helper centralises the variable-length
    control size calculation and validates it before use.

Thanks,
Muhammad Bilal
