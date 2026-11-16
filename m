Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828676;
	b=ND6Fl82YM0pwF1Ymc264mc+ba6FcBJlM3cLqN5imgga6ZYUru0DfIIqjSC7XknDapSbo
	 nxwqqPQtKGAcqpgHuTgTEfMTAyNZy8VeIr6YMx9LjfsYGWRDYuz83TA6zXppcMkKdfstT
	 Qy/aXDM6X8AMGBYyPMR9IAqTtCeWad4/8/A9KldtCcOiAM45qnZ2CKWzKO71GtCodogVF
	 6mJE58CJfdw1u6F73BL0Vez7r02s9SWcAjZBOM9Sjmgk9Tb5QMmhTX4aBlvNRSkW02NIU
	 GEU712UcHFaQDH/joDeqmk27BaObewwY0ZAOAgRjOm3wrTyT3Ia6UMrPkkzz6D7qhhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
	b=dHf7s635TE2BZnrgCsozLGNolv9nk+kwDvKVJ6Rlqwm8VnMsaZaGlcW9mmwv/a7ttrK4
	 J866lWY8jhLbW/aWyXBnAHgYxu/3ukxLCsgilqk27SoIPMNXJOebf7/bFYYNWoN2Aygcy
	 90H/iIY/eRfCFwoYES2jpXswbsdUJKRY+glC87rJ80U5rNZdkK/mqezl8m0VTu3mrczhO
	 8dIQYL5O1x2fu4i/C4vGpvvIra/WZd2/8eAqM5y/1TptAENdkT6xUocaOOhNy8TjRawst
	 kcVX6XI1iSRdpZNFDcwzkL8iJJi9yprpq9sURyB1IOkafLjJEAUr26xUgwFPgFfRDCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxWZ3V2d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAE606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FEAE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxWZ3V2d
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3adfc004920so34836151fa.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794828674; cv=none;
        d=google.com; s=arc-20260327;
        b=PccRxK+84asLujv5q0hEtGu7vMaJ9MPxKIq5l04G0/4QNYqs2lczKy1iC90hVAPDt0
         szo7YYWCp80M1TPvt8n26Xo9DxFJOkeqfKdzYvO+VGwMTgrAdQi23e6iRa+N6DEV60cz
         Hqu+uIk4Rx+HDF1XKmh7CU+WkP70u5psS844oK9vyaSmOetBZihEsbJg787bAkZWdJmL
         rIAGgwMEML3nqw0rueoYxKY7Vvp67HEVd+vJCKDDXf0Ker8kiB26gFdg25N50uds5wUW
         aEcV3UADWHLcuHfKd/i2RvagVYyXswDF9Z4dRCbeSUiYmPRQIwyV838F6B/HZqFEeYTu
         AmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
        fh=+aAdKQRdJwxY9WvmRzYSp+k8mKgavJMhBZGpYXMQiNw=;
        b=O2ZjoBsxavUItZrljGi0y+wZV7XgE8JERWKWgIwKD5LyupTkGOVRz9Ull4byOgXnjn
         A+9d81qB0ysDrv7nVZMao6+VzZwwKWvGe8YXAMaAIjxrcUty2rIGD6AlMf2DFmn67x76
         N1HBGG0qfBAkNKRPsO2AAylH1MOxrFW4EV9CBmrom4t2T5E/4ttZ+H05uTiBybGPZ8h+
         By+fK/8g20d/M61stMtFMberXJNX+3CILQcJUsnxFUcI9Gotde7cogxKC1+1LAwloOXe
         D/7V8NCFVlxAhgHeoYOmLnT1D1lSHrLiHzoRF/SPpGJ0D+WfHe/gc8NC1MDjEyw2Qe/T
         6wsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794828674; x=1795433474; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
        b=kxWZ3V2dVLj+c2/8iSKefCrbXhzuXYCgt5E4YLq/IbkWEXpqNbQOR1/wAnWoWUhqXA
         QXEo807K+w4JcmYKtkfJqxmstIa4egAT1Sl4+XhRI1Rbsv3DKmQPvfrB7gbuDfW1uRmH
         n9Luy6QTnwLwntMmFdIBQKVSBC120MN2xvKRYW1Ib/gid02S7pSadDR5mk6mfYZJ1CE5
         qfpaFgr8QW/aEVwn62yYQHLYw5S/Qo6GSb68PdpnJ3gvg8H/wu5CB1dwjGHHMKtcx3Cx
         +PupmxkMqvBMbrWh0X2nETj4/m7GFVhZVT1iy055+ZP6FrtX93azsktz0agKKku4ajOW
         ZxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794828674; x=1795433474;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
        b=LVPhUqqb846MQ1ti9QpO8izJIS73R9A3A78V07ZoawP1lb4h6TQ01y4rpeaTv0wnEK
         h/LHVs+ROCSyZOYClj4q4pA+qczZa0pHEynY+0Hs/rrnpra3ARhoYRwUclp3ounfBNdw
         Fk4xSU6f4UYD3mEbrtWtow+gEdSuVOoqDrR1LjFjfk+STiqDGHl4ISQgSHKOeJMw+nVC
         TESfbLWkg6c0HcmegvDdYIaDrcmAkg1tWpFn0RAI0poNt6K4uLTXBKzPx6Us/reCA41S
         HwsIcFD2TyP/fSRDBDSNO7VBz0i4sGThYfQHpmNduUlLWmP1y8ka3fIhrJjTOgQjjnrL
         ilvg==
X-Forwarded-Encrypted: i=1; AL+hErFIoXr212+5NMnkZpzy3x5SF3GyXoKufnjKvZjqHrEoP09y4rnn2qzxZ+Go6iVmglsF5xYpUl4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PY/3O9dak8yWD934DSK81FSW0w6dgbGQRHk+Zib1Uk8TZq7v9
	1YVz2yRisYDX4xEbOLedzL1Ve8OOPgyY+3kNqvFqzVUuFhTUPpgokNiUBeTqc4PdHKypqzqzuzn
	A0SJMURH41xYElr9muhnlqhahjzoD0jk=
X-Gm-Gg: AYBFou1Jj2WZYzUbf41hHyz9e+yD8fUUxzRbcXGs3PqDMuA/kLsvoQ6LMZ+Tj0Scuup
	8yYlwXe3UJ3o2fbPfJ8je/qu+/kWGOSYSUg3I7lyC9USpyucBYBp9zpw+eP3Fr4bums2FAAvrmj
	HUwGnNGFfP5zUawhA4HWSwIxM5gJH5uHabUXnY5BXps8+9UWgLZw5JQXSzI43gehkaQVSGmWJ0N
	vF+SFztMXU4FlFffT7+oADyzXSsjeMYCN9RPT8jxvOtIEelhGzRbI0DSuXYhYmnzJfbePPPiN2u
	CejBwBdyh0dPPKJ3duyggPyI9KuH3KHWnOCUbR0hKT+bO+gQ7Vvb6OzMr5GIBD9LR67uDTFyqom
	L6r5WOaBW/pmKYC0fbvsrc1Zn0p3qycAEkAY3XA==
X-Received: by 2002:a05:651c:a344:b0:3ac:ff0a:9d86 with SMTP id
 38308e7fff4ca-3ae2b4bad81mr32453821fa.15.1794828674271; Mon, 16 Nov 2026
 03:31:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
 <20261115210952.2140036-2-graypanda.inzag@gmail.com> <CAOQ4uxhZS1w24GXWphu-PNPbGxVJUDwOfqHdRZcb05+_HVv=aA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhZS1w24GXWphu-PNPbGxVJUDwOfqHdRZcb05+_HVv=aA@mail.gmail.com>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Mon, 16 Nov 2026 20:31:00 +0900
X-Gm-Features: Aa3M54qrozvfFSvQ0gfAb_mSn86pOQYMr6gnIKh6TI_Xntwk7Flfv7qM72l-pE8
Message-ID: <CAO7ntTRdY+5G1wiETFu0SVa3vFX+0RyMO6R5XpoosF0zhuoQYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: reject embedded NULs in readdir entry names
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 7:25 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Nov 15, 2026 at 10:10 PM Junyoung Jang
> <graypanda.inzag@gmail.com> wrote:
> >
> > parse_dirfile() and parse_dirplusfile() reject '/' in dirent->name, but
> > do not check for embedded NUL bytes.
> >
> > Unlike plain getdents() buffers covered by verify_dirent_name() in
> > fs/readdir.c, FUSE READDIRPLUS passes dirent->namelen directly to
> > QSTR_INIT() in fuse_direntplus_link() and instantiates or aliases live
> > dentries via d_splice_alias(). A dirent name containing an embedded NUL
> > produces a dentry whose d_name.len extends past the NUL terminator,
> > which allows callers such as inotify to copy uninitialized kernel slab
> > memory past the NUL byte to userspace.
> >
> > Reject dirent names containing NUL alongside '/' in the FUSE readdir
> > parsers.
>
> My concern is that there are innocent buggy servers that pass NUL
> maybe even because of length including the terminating NUL.
>
> It would be more considerate to make this check in fuse_direntplus_link()
> rather than to fail the readdir.
>
> See precedent in:
> 78d04af4995a1 NFS: nfs_prime_dcache must validate the filename
>
> Also, verify_dirent_name() never checks for embedded NUL, so all the
> other filesystems can get away with this without failing readdir.
>
> Thanks,
> Amir.

Hi Amir,

That makes sense, breaking getdents() for FUSE servers that include a
trailing NUL in namelen is definitely a real risk.

In v2, I will drop the parser checks and instead have
fuse_direntplus_link() return 0 early when memchr(name.name, '\0',
name.len) is non-NULL, skipping dcache instantiation without failing
readdir (matching the nfs_prime_dcache() precedent).

Thanks,
Junyoung
