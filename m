Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795078394;
	b=NODr91DPStQo5UsNfqOQRa004kuTSKsRXZDE38bqizCmw4SCJ3aPtLkhHcd9cVDXM0LI
	 R1cS5NiGzmwbMt0Qg76cj0/ZD0ZKPCKoJI07xtb1EDmBQ1SOa9F7ukxBBer9ITNxRlh/c
	 oAUGz2dyspmUeDFcDa0DakDx/acTbzMB0A6tZR9b2P5Y1C/P9/x8Co7VVWuvzvzrhxHrw
	 edz+YB4TVNOQyyC3/lI4uHm5B2K1GgFN6vv/VULcJHgyyttzoDAVLoUO5klLv1qZDKSmT
	 FsOHSJfZsdG64TTTcMzH5FcxXq84xibplvLKl61J0Xi6cPM8YfKaCMH5zUTPFykQi/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wfP9MO2UqFb8Vm4Vt7CpNERZfJaN3jidxxklx2/WXmo=;
	b=v/j1e2RYwdEFk1huYZ71j+thBB+r5XdwC0Ml5l3pQY4OnCB8vpU/wS7nKjINWpmBL/15
	 ibpENvNfj5cCug/RaO3IVtmmSN+baWee87caeVyepg0YD5S+EIK7xie/0IiFHfJwfBT5l
	 UOGkgfA6LGpxlQbaekzyNHjf5iCIKoCX9K2DFOiqHGfZcCTW7k8NGZtqzab/8WXiOf3fW
	 WQamh5TpLrs1ooF0ul78FC8LJ6kHuRSRyUG38kFlLICqekDHtaW1NT1lf9GNV8eLfTj8D
	 6DMyV8XhEA1+dpiqTPu7WCHXhRBcU7dJEGrro9TgUon+W45UYbJXV+S9fW9nCPMz6vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hvk12pVa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84788606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84788606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hvk12pVa
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49412eb1474so1199379f8f.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:53:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795078393; cv=none;
        d=google.com; s=arc-20260327;
        b=fiUC8b22K+6fr71ygPBy1L4NfHr0/xiQTsTk+5xHlXySJQsv8zNmnQA9BdGr/Gs6Ne
         g2/ZFfA2444PXD1Z1M+mHBx5EMGfW75XB/zEytX3JlyIkggtHP03FovYIUD0EJBboyTX
         TBSbY+ThccL+Of6HZeWPWF9RchlpfqK4yaZOVmMc0yHRmC0TZXsq5vPtXD+UYvrzEubs
         y+slsc4NfcGxIFreDshny8TMHHYAalSsgcFygaXvZ3ysxzdDAZgGhEFohCkEs4d0DrTg
         7I3jjU9WDDC3KoJ4NOE5tV7n5+War2i1M/8QygvXNcWIQjzUjoMMGavkAponOk8WV/QW
         eSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfP9MO2UqFb8Vm4Vt7CpNERZfJaN3jidxxklx2/WXmo=;
        fh=pf7aIAEj/A341aDjF+71js0kLl9AT2Cy8EsKsg87jkU=;
        b=l+JZrmQx6GykyALrpO0KKQONMYYslfasj7oGBA4B4OeLxO+2039DpTNeIzoyfmAp2+
         pYJMrc4mqViOHiwhkJ14ZgE44SxrCF87GjNipdCjdcyy6I+D4u5GvnksvYLu2bsZLR9U
         JIE2Rf6jKYczB5nUBbSELpDKrqvIZ+Jj8LB3gYCG/RrkD6Jeq7yhT25lpZPNaiPwUEs9
         F5yyUwQ8ybFHGbfzaO/qbwj96uKaFUUvf7b8n28ysYMb9+RtMcOZ+w286D78g/JFZ0AP
         poWItQNuqMe0tLpDuLcvqYlKh32dUysGSAfZUT1P55qciJeE+E3XEccAyg9b5vjtGCYb
         lPzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795078393; x=1795683193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfP9MO2UqFb8Vm4Vt7CpNERZfJaN3jidxxklx2/WXmo=;
        b=Hvk12pVaWSUpS5IGqzjYVweLfTNcFXLn2RSK5tV0Kg+Zi76R2QEvyA9d80HY5lz2Il
         o6C/CKbFqMUTpB9PNHQ7cp1scGSOLK8+z73Ratq+lymmh0+qc6ZPiEegSNCUBgcT+m4e
         ICR/C2gLaW5OrbH0CAXYZ3IA/E8j6mUgHmOHRnw4axF1fd5G0ILfJAybiza1CGntuiCu
         cOljNS+Do5KGJtl+KKtTRDSnDguA0+ekZ0/B3DhXSkn+J+GpUxsAN2B7ZoVcaxaLc25X
         Z3UdyPBNrDKGHGEmFBZ8bB8Q70O4zgZZkhiBDA0r/dtHLyNVMUNRpH08KSG2NikS2333
         qdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795078393; x=1795683193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfP9MO2UqFb8Vm4Vt7CpNERZfJaN3jidxxklx2/WXmo=;
        b=IyEQux6ImE/MOPpYaHWxe7Gy636LGx1r9P/Egrdo7KLCoRjm233ugQkNuMofGEPfpU
         ntKfVkVNJwpEGw4RpVKvq5qltItwSkH0fsKPw+PUnuJHTor4F5V67LyEYJLco/oWldAE
         voERE7FOAE9GRSxrDdCBtNMIosGcB1aLrk7B6O7yTLkHzy7YGQUJdZc3hI2dyax1tnni
         CPrsJqzzWGnf7gVf6S7mRMf1YiT9aF9PNnccJNA7fT88Zq8ihssOVjZawVJ/oU5+N8iU
         RQu97dy2biYpUmtacz/cjSD2rx6uqsghZWf24dsXtbqgFHr1L4dgmka4zVC4hIyRc8Wq
         0zOw==
X-Forwarded-Encrypted: i=1; AL+hErEBVohhjxUnNQXY72UW/uPg8/GKZKSHwXsNfcVoVQtXpu2Pw1oYOPhYtm8d1PtFlOrU2oe1iiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FUIibNZ92jCWSLSJI+iAPG2/ioxeQ706PnMHjYOeUKZo3T0BO
	H77SOVg57QDN4ZN9CK+NStuHpQaCRqyyZteCy+mtutep++NJMZM0mWqsKhmWu68JtxMTSwSH4iG
	r4B3BWwO4zTIRQXcgTWUUeAIfiWJrf/6/qe8lyO/H
X-Gm-Gg: AZFdTZe7kU5WfZePfG+X95bneU63GKbdR4EZoFp2fs+HHYX20+Uug5iSAI3WGmBEtga
	1zjJPsW0IVzomv3siCrZQXoqTApuJ5imUB4kPRD5vCd7WN3wHfsS6FNWVlFdQbHVIIQeeezd2id
	XyrLrRCGQcjkAjPzPilznTZ6vFxWuN8KcZUVnp0YQgvbd2knspTHEsBEH9SR2S/tlg3UYg/pcX2
	cDadG7fK8z20bMwFQCjPJlVDT9OJEDnHWY9BTApvYSlf9o9nAMRgsONPU9blQnoyxyj72MAg7Li
	s5Riy9Fr5tLv7O/psZgiRZnLzR2jsWOP4eESruWuLCVUr+jwpJSnUB2a/yxi6GPu2Ugw8t3y4Va
	dRZwFRQOczvZYGfKXI7kL3BHo7igjhP4EUBBDDAHLrDErqPi4EA9RcWWgVrl5ueAaX5ssxvYcie
	frzQ7plZQi1hOkvGvrJ4L7t4JEFYwGdnqQg+EDnQU16U1hPg==
X-Received: by 2002:a05:6000:200c:b0:490:411a:1eed with SMTP id
 ffacd0b85a97d-4a63d2cf93emr11007405f8f.39.1795078392254; Thu, 19 Nov 2026
 00:53:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com> <20261117-formatter-lifetime-v2-2-e216d86ffb57@gmail.com>
In-Reply-To: <20261117-formatter-lifetime-v2-2-e216d86ffb57@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Nov 2026 09:52:59 +0100
X-Gm-Features: Aa3M54qWXf-BecwMhD33FC_LoK5lSzu5f6uP1S-mq1j8HfpLtedDHeIgEaf3kUU
Message-ID: <CAH5fLgiye2b7qVDLRgi1rZaOKvVb=V2u-XbrQEH7PtB78+9V_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: str: add an example for Formatter::new
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Georgios Androutsopoulos <georgeandrout13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 6:57=E2=80=AFPM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> From: Peder Bergan <peder.bergan@gmail.com>
>
> Document the exclusive buffer borrow held by Formatter::new() and show
> formatting into a live buffer. Check the number of bytes written and the
> resulting buffer contents.
>
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
