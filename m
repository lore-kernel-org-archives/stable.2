Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795583216;
	b=gCFKNWfwBKmlbpxnCURtUfMKEaZfF/+vAtBAWlig+J91oHtKCqq0O5gwUX4rtBQ0+xy0
	 XAJ9LbKoaqTsp/HXrKlU2VSttVF1xo+4GhuiS9wv6J1aXmeSEL/vskUWZ+D5bvjZf1WPl
	 o9AzzM+REd7WIY/M+8Q8+MopZ4DmWavV5pfPAJLyRGoGccoChO+IRKaTlPeLp8/beAb/7
	 /RUvII+eCHCfKNynhLYTleTkmHdviErUl+nKE+Ki9cQBYb7+VXGHgGIF4YwYisq0MB+5q
	 ywdMrOcc45CjgRgrtSjWL8tOpqBACKFkOZEWNS+MYyQGL8NjPTOvLHKz0tgRT90gLcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=St9qGG3raKOdkDcDbquwSocgYR27/42BAaGi49zTWXE=;
	b=Barj231oS22rnJ7FhY3VKvFIwv0TIBgluJmrPmCqMmjfvJCzn198HM/iojwMy4UBAgDl
	 iOXMkxrzjaHTZetJmYHsIu9Q+HxLep/JYCpZzl9GF1RYoFxEnjWQC4Gtkjj7Ny9Z1snhl
	 5RlfSDHxZQD+9T6g5LxlXnCERzyKY976DaxzcU0dekF4fNXkDfen85pbJkwJAe5eBxCMQ
	 bUdOiIlSNh+5lXTSe79GDQFLnJq6IVLnmeIq+RKVadjTuI0EQ/LdWOfHY+6ZLq/+iMOGY
	 Tiqo1rLyQ08Ywwl3WIcYvDuwtOZpVqhQC6JqefsfHD4bQJXOFahk20L5vsHWWC7y2YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=WvCW1Bg4;
	arc=fail smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19D606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B19D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=WvCW1Bg4
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so6987564a12.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:06:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795583202; cv=none;
        d=google.com; s=arc-20260327;
        b=RFDrtCJcxazZ7qnk+rwwq0hFetxg3z9dNjklkfPiI3v6lXsuBEONh5GSkfKrBYOn2D
         4ihRC+FsmVYYqZu9dvA62xJgt5rkF1uD9MxbHOErpGG0wJpv3RjnUXV479wHsfgo+QbN
         o+wjnkqZeTdXGpHnYcljbHC5ESZy87M+zEGPPvb4wsg47JqFRYuzaoWl0tW6B4RC3N2e
         DxVMm9sWkppAfy89IF5FfEMhcc4zlThZ2d2u+6fAF88fr/+4P3dcOk6ObiZiJNu5rI3a
         rs+x4Gw/pFuaVPtRVCfatGmNAUoJzZeWo8pghucA3aV6xkmKtQGoky1TWRXHe9GJqC5l
         XRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=St9qGG3raKOdkDcDbquwSocgYR27/42BAaGi49zTWXE=;
        fh=Gj/iCEb7+PJaorRaKcwIVWeIQZJL/jUYmh8G/X4GMe8=;
        b=gyajFxoPeYMbyJKnacwfY05vaKoTa7lm1pCRJnkdQAILe/qKAx9t4p7tyKPQxmUxMk
         04rL7Bmo8eMgnOxFfrzzhc/UfjLTgyQPeGZFwWxtrNexK+k7qST1sYaCjOE3KQGhiJaH
         WVUf0qiEDOU4clIn/+faTT4DVnocKa1SvZCO5CDxnw3drp/uJvB4OjBbOK21QvYxEUmf
         k5jfGwV1K/aErI/clXM21L3mFdy/7ddrFwdnJR+W/7cq31Fs/x4I3KJV0ud/tDD2UnWL
         Ru28Hsf/JKKOENSV3/RhX/eTZhOuES01qXhKRIx56SRPVhpZWUifTpzPVjUrwl2L1uX5
         5kWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795583202; x=1796188002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=St9qGG3raKOdkDcDbquwSocgYR27/42BAaGi49zTWXE=;
        b=WvCW1Bg4ViJubZeAEI0wYclnYXwKcIfPWWaMc9ZYTHNFKwJAVdCHcNiTzHn6PetD/3
         myrf5RFaZ2plYTw8GPMbuKPDxhjAr/O539xfOwB3qv4OIeo/63IuHPGAvb6uMnWgI4DO
         0LoFQkv5PtCnVQ9jmUSzUtB/4qlHMRW3ijYiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795583202; x=1796188002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=St9qGG3raKOdkDcDbquwSocgYR27/42BAaGi49zTWXE=;
        b=zirXyoYTptzPfXAWL8Ak/PLE6+HqsKNGwwsxjFTs3mnOMAK5caqqKIl9zGz8G+9fD4
         9XNeC8m/9LR8njTfUpSQmxvVRNCXTixeyOoFbkrR4fSEtEsPBml0b3BH0hKnT7S5cWQq
         H10xGw9aQOTSBE7xTpVER6dW2dPeDe9cnlpAPLeDdh2X0H5eJ8V19j4/iyUu8fua2o/F
         le9bY6LQ3raAPnFbRqdLujo9bxbO0GEadlg47ZOpK8AaEPa+b+noAmKztoi3+KGurZmx
         HHVJXaH436HS640a1X2dM28ywGPH6i5aOvShcU6OnDFmVkQrsjSuoz7CkdXt/2yvwWLy
         Dn+Q==
X-Forwarded-Encrypted: i=1; AL+hErEYiKqibgHX5x9xygYDZdEvrsuNx6PFKJ+cL0lYnjGxaat63p0xm1PzY3UbHapdOKUp22AdEdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VOgqWG4ztKbRwyDTjBq9kH08Y5BdZ1+ph7sIdvgUR5Dt8a1AL
	5xVyygnLVvs7TS78R1+zeiY5aHHlJLTP2WK/V7Nn+Siy/G0t36WuHpm1g1S3cr+Xi0xE039/9Sr
	N0TiwLma8KBbE0SRjzre3/snnKPFn9Mb/H3XSrJIYDEC6q1iMZw02f81A0Ons
X-Gm-Gg: AZFdTZd7B2sgmxQ0HmSk916mujlPTneJZEliG0VjCMH/zD/SxPslalzI+15pubrTgcu
	/Ok+ku1nVzjc24t4X6KK4L9AacAb5j/I/FE49bP/pwKb2hbAm3dIA6GKLF3oy8TZ0cFM1oCrWm5
	TGNuKJlbRZTzG41Ra12qlUgDiFOkKRU5ocaowBwyDsdcS6HhzqdaiHqv8kX/WD0BKfE+GEEjP2E
	5kiBJtqPJrpoqP1dyp2mRNbHmTXps7vViqN+HQnsTPetjvurWfg5ut6l9lYbc0Oc27XX5q3yvnK
	5e1abk0oVaTGVvNEi7Gl0NqdXIeJ8+pUJaIc+FfaUHvJ7Pm5nm4UhD3eBkYPzl8ZzDWDGedgJe0
	2uuObDEDvPTr4+pP8h5NQpxn9KZBg+VVxO7hNJ1ydmj7EdvHlIH/p0iozZ8MvnATRyRmJ5Auohk
	no3MpIseE7XKYki6GAWro4MqbBiaSdZ8AJt7hK/fzCpg5Qo19KczABzmA=
X-Received: by 2002:a05:6402:504:b0:6b7:1cd4:87d6 with SMTP id
 4fb4d7f45d1cf-6ba37d17fc4mr8799911a12.13.1795583202056; Tue, 24 Nov 2026
 21:06:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125043847.885053-1-piyus@iiitd.ac.in> <179558178888.3294.13943698848591637747@kernel.org>
In-Reply-To: <179558178888.3294.13943698848591637747@kernel.org>
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Wed, 25 Nov 2026 10:36:30 +0530
X-Gm-Features: Aa3M54oDWglR0iAUavzHNeiehG4Hg13FhPc-XMGjpMFLClMWzn6h4NFTqVwgfFs
Message-ID: <CADq=QSx-7eYx93XbdGLTxHp4-O-=gO_6VyS6R4XgZzDXMG_ErA@mail.gmail.com>
Subject: Re: [PATCH wireless v2] wifi: mac80211: store the mesh IE blob's
 length without truncating it
To: netdev-bot+sinfo@kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kapil Vaswani <kapil@presceralabs.ai>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

The bot is right, and the information is in this posting - but under the --=
-
line, where git am drops it, so it is missing from the commit message itsel=
f.
Stating it here as asked, rather than reposting:

How it was found: by AI-driven fuzzing built on top of syzkaller.  A genera=
ted
program put a vendor element followed by an RSN element in
NL80211_MESH_SETUP_IE on a mesh interface, and KASAN reported a
slab-out-of-bounds write in ieee80211_mesh_build_beacon(), reproduced on
mainline 7.4-rc3 and on 7.3.1.

That run is what found the beacon-tail overflow fixed by the other patch of
this series, "wifi: mac80211: do not copy the mesh RSN IE twice into the
beacon".  The truncating "ifmsh->ie_len =3D setup->ie_len" that this patch =
is
about was found by reading the code around that crash, and by the review of
v1 of this patch, which showed that v1 made the overflow reachable rather t=
han
fixing it.  The two routes the commit message describes - a blob length tha=
t
is a multiple of 256, and a 257-byte element behind a truncated stored leng=
th
- come from reading the code and have not been run here.

If there is a v3 for other reasons, that paragraph will be in the commit
message.

On Wed, Nov 25, 2026 at 10:13=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
