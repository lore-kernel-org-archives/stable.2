Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104ED35E950
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080610; cv=pass; b=U8VjpXy8D9KBxGqOncsC4vCdDeLO6R5j4qnO7KHYzAFGOEuR7grjZR1M9k2O87potfkrdW195DIUzIBdpybkgwYICt1PHyMltGk+a+/EO/XMwF5oKelmE4uHE5f9ZDsXMxNIVL34llg7XgQVjcpWB2iHgO8oSdp1cSflDASI8sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080610; c=relaxed/simple;
	bh=jnUs4jwUuhP2XNi5yuvx6HOb3PmM28YCMYg+bxW2YwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9YMfO5YEgv08vdUqwzK1nY3rXSS5ZOtMQ+sMiKPrfvfZvn73rdBOnqihgpzU6qCqvLC/hxwEDeG608OUIgyy0Tc9twgtiI+anE3Mz/naRdogZe5fRXrEwLc+hztN/mHW5LKYAI9NwXT2qmy1NJ2jx6LSTea9zNewS1F50XPYKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYmEbS5S; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYmEbS5S"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1600d040e4so16123666b.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787080601; cv=none;
        d=google.com; s=arc-20260327;
        b=MUSSQP9d76yV+O62cSMKcIfll9jEckgF1NnQjMdwGBIZ08+McpQ+JKfrZLUvGjo8aC
         hHFEqqslRq+uZ+Fa2IX8kXXbZ4kdOy+bxNNteGk7mDqv1WitPBk1A4ZWeMjuLE8++vm4
         fzn9qXCG/UB3CKn0nwWpsfhijrVsnShOWnQ7CwrigUGOZ4Mz1S3CyzZdbRt+oQ5wc0jS
         JYGaROt0bKA51DlxzE8Gtnq2wIKVmgeNfGgoluA2PiITj6WWIsNKkocT0oAzEgfSkAHC
         jnICOIJCkmTLRe+Nz5d18IyWEbpwcofFPEZY10OXED+lGVSk1eLAwUU8dbIdr6/tMQBJ
         VQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6F63kr4+87sB4ghmMaGvMuNwmiTbtkXM8okV9uIZ1I=;
        fh=PvsqXg83mTCmBKfVsWJ/LbvS/qoKrBCHFaZ11wWWzDo=;
        b=rgtShhUdLUAdGzkOW31pyjCCQ9BRk+PIn7A7X2qP3Js7S+edZJ/75H1vps0EhwqGzu
         eJ1X9lhHwh5vaV7aIcyqV+HTUzB+4rPwcw3gXVOsdYlGYf2jTh0TmZwEh0wqPm0PhXl2
         ZaPkiE7P9VCBF57+YIZClsUS2ZILAnc7oCw++U+co4sZH2OKcDGLI3j6AdOIeRez/1on
         nBx6iqNhzb7peBIm3iXXx0r3gO4njMqGEWJjlwqr5rgjWfmBLUiTG4Ur41Kjq8dy4JK5
         HnCXtdaYf2rQgwb0pMBO84600+O7SDg+aAoz6WCmRxbHp3+fe4nEZiGfmxSsNLvoA42o
         NRaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080601; x=1787685401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K6F63kr4+87sB4ghmMaGvMuNwmiTbtkXM8okV9uIZ1I=;
        b=NYmEbS5SasrS3hLsCZCiiduPWqbojChcPw0c40+I2PLFN3nDPmrdQBhqAyFv5AUPB+
         T3jJZoSXApRgWdhFOJWJPDoVkznG9aFMnZeZQgmuosOywvA8BMU5fNmkAl36fIIKj5oW
         TPIxi3Q0OXbNQuuIUdBoBp7DgszafsnoxbIIJPdGTz/+4tC1CFz03WEPxAy9H/dokTO8
         33aj7kfRcscH8CK6miOs8sASbbJZL8lBMwtJPi/KD4Ko/95BRamyneJxC/3aG5ogf4rh
         OlGXi+AtQXHXfJXaxUcAwW0gn3Q5elMd4lKKE3pCv/j7jjSHiaxt4k5VMCyD9LFoq8CQ
         8+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080601; x=1787685401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6F63kr4+87sB4ghmMaGvMuNwmiTbtkXM8okV9uIZ1I=;
        b=nXTZsQ/eFiFjpZNAvgtuAnSlfTaGlGzAJqVq5K8s2SD8dliR/vLrxmgQiA5rqrHfSS
         RfLbD55k7mTHJHxxYSeqWNl8If/zeKja/wRqoaXWdNXTWlbHa4VfS2tJbCpUziqKGfvp
         X2ByEDJOPQWLEzLlNzEBtBvy+Aq7XoxRIJ/QGM72UdXBfULwlmVB3IUS8XnsEvbPk7nA
         YZnZzVM0qVdANII5bmL4TCCCDuD0KTuRsVKw5SQRb/4x57aKtNKLj/mPPdfKKBZFfIh9
         /7fIg8ofpXnCvL+jCBIj+i8GjStC4HQIHrlBnyJCRq2b9SfEwAAV/RCUgYZoKABDGY9W
         JauA==
X-Forwarded-Encrypted: i=1; AHgh+RrT75Tl75xaAhri46ddT6N7zJe1fobG5+Y4pt1D1Z/2KWbBr0L2qqT1OsXRFho3d62Tr0z+ENs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMeAA1+vvTeT5evP9tvlBreDNw6kirCi0WqXmHmjBKpqGqDLU
	ge4rtny//geBPQcXUOqAjt3RvlxAEBXaCZw9zF7zHxbuYTK+Q5sIAYUbN0FR8j/FANIerYZgSAJ
	wEr9TcRkxctjs1wQEsdR5n594cUqHc1g=
X-Gm-Gg: AR+sD11YWWxjMrqx9hJzyrve0OdSEgn/iLaVEZ67AE/HaZZ6VoXyRtNAlyDOBn2fgx7
	U69LW1/4dMicD/EhnVywMhdoriEjocrDkN1eYnx+xtNLnaFVgmKkL+sjpKnaMlJsm/yelXWiJo1
	H9z9SdJ6cY4VKQMqsYajTPenWmS+EZndkVANy9iJXPp6a5TfXIuQaWxlUiJXtnxSpssVm/FKgji
	g4ETPIwHyxVJOYFeur4hlCFzZjq/8LChXoSGj3g9GREiPSatQDWND0sxVLwYq2mJcYnvng48Qol
	8c/lSWxqkmSBn8RYo7J/5BtVgIUlq3rcEu+ShGIxuWfm0PKRD0eostLcfqQ/EmPfzqO6AzRMXfl
	7kr0weeeAuzU6AWdYAcFvd/JMZCQQfspQLky1kg==
X-Received: by 2002:a17:907:d26:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c2229968e30mr40655666b.11.1787080600847; Tue, 18 Aug 2026
 12:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812111829.172273-1-meatuni001@gmail.com> <056903f7-802d-3db5-f0c8-b1c66d37b8c2@linux.intel.com>
In-Reply-To: <056903f7-802d-3db5-f0c8-b1c66d37b8c2@linux.intel.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 19 Aug 2026 00:16:29 +0500
X-Gm-Features: AcwNN1XEhyBjD7AyymcuQxdYUrgbM3et6h0a80EohmeOa4x5Usm8h0K4YUfdQq8
Message-ID: <CADqcGBnCt-Rkxa3ms7g-nbe2+Js9fyzSH52KQPNZBvoeTiaRcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] platform/x86: hp-bioscfg: fix multiple memory
 safety bugs and parsing errors
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
	Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thank you for applying patches 1-3 and 6-9 to review-ilpo-next, and thanks
for the heads-up regarding Guangshuo Li's earlier patch for the password
encodings bounds check.

I have submitted v3 for the remaining two patches (patches 4 and 5) here:
https://lore.kernel.org/r/20260818191120.38556-1-meatuni001@gmail.com

Once these remaining fixes settle, I will look into refactoring and
consolidating the duplicate ACPI element parsing logic across the
attribute files as you requested.

Thanks,
Muhammad

On Tue, Aug 18, 2026 at 5:08=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 12 Aug 2026, Muhammad Bilal wrote:
>
> > This series fixes several bugs in the hp-bioscfg driver:
> >
> > 1. Memory safety issues (patches 1-6):
> >    - Off-by-one NUL terminator write in hp_get_string_from_buffer()
> >    - Heap OOB read in sk_store()/kek_store() when passing original
> >      count instead of trimmed length to hp_wmi_perform_query()
> >    - Heap OOB read on empty password write in validate_password_input()
> >    - 16-byte heap overflow in hp_calculate_security_buffer() for empty
> >      authentication tokens
> >    - Off-by-one heap OOB write in audit_log_entries_show() when more
> >      than 256 log entries are reported
> >    - Missing bounds check in the PSWD_ENCODINGS parsing loop
> >
> > 2. Logic bugs (patches 7-8):
> >    - new_password_store() incorrectly passing is_current=3Dtrue, causin=
g
> >      writes to land in current_password instead
> >    - ORD_LIST_ELEMENTS case using a stale NULL str_value pointer
> >      instead of converting the current ACPI element directly
> >
> > 3. ACPI package element index tracking (patch 9):
> >    - Five attribute-type parsers (enum, int, string, order-list,
> >      passwd) all share the same defect: multi-element array cases
> >      consume "size" consecutive elements but the outer loop only
> >      advances by one, causing the next iteration to misread a
> >      leftover array entry as the next property and abort with -EIO
> >
> > Tested on HP EliteBook 840 G2 (BIOS M71 Ver. 01.31), kernel 7.2.0-rc5+,
> > with CONFIG_KASAN_GENERIC=3Dy and CONFIG_SLUB_DEBUG=3Dy.
> >
> > This series applies on top of:
> >   commit ea4d8f8ba283 ("platform/x86: hp-bioscfg: fix
> >   slab-out-of-bounds write in hp_convert_hexstr_to_str")
> >
> > Changes in v2:
> >   - Squash patches 9-13 from v1 into a single patch (now patch 9),
> >     as the fix is identical across all five attribute-type parsers.
> >     Requested by Ilpo J=C3=A4rvinen.
> >
> > v1: https://lore.kernel.org/all/20260803143037.93105-1-meatuni001@gmail=
.com/
> >
> > Muhammad Bilal (9):
> >   platform/x86: hp-bioscfg: fix off-by-one write in
> >     hp_get_string_from_buffer
> >   platform/x86: hp-bioscfg: fix heap OOB read in sk_store and kek_store
> >   platform/x86: hp-bioscfg: fix heap OOB read on empty password write
> >   platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth
> >     token
> >   platform/x86: hp-bioscfg: fix off-by-one heap OOB write in
> >     audit_log_entries_show
> >   platform/x86: hp-bioscfg: add missing bounds check in PSWD_ENCODINGS
> >     loop
> >   platform/x86: hp-bioscfg: fix new_password_store overwriting
> >     current_password
> >   platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
> >   platform/x86: hp-bioscfg: advance elem past consumed array elements
>
> Hi,
>
> Thanks for the update, I've applied patches 1-3 and 6-9 to the
> review-ilpo-next branch. For patch 4, the approach in Josh's patch seem
> better (IMO) and patch 5 seemed to be changing dead code (AFAICT).
>
> (And once again, I really hate the amount of unnecessary copy paste in
> this driver.)
>
> --
>  i.
>
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c        |  2 +-
> >  .../platform/x86/hp/hp-bioscfg/enum-attributes.c    |  4 ++++
> >  drivers/platform/x86/hp/hp-bioscfg/int-attributes.c |  2 ++
> >  .../x86/hp/hp-bioscfg/order-list-attributes.c       |  6 +++++-
> >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c        | 13 +++++++++++--
> >  .../platform/x86/hp/hp-bioscfg/spmobj-attributes.c  |  6 +++---
> >  .../platform/x86/hp/hp-bioscfg/string-attributes.c  |  2 ++
> >  .../x86/hp/hp-bioscfg/surestart-attributes.c        |  2 +-
> >  8 files changed, 29 insertions(+), 8 deletions(-)
> >
> >
