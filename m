Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE430EF64
	for <stable@vger.kernel.org>; Sat, 30 May 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142505; cv=pass; b=AqRdcWoqImtwZqoqsBKClyDQwlirlCqoTErP9H6CSo1OgotzNAhRcHLzwtz+H0ctRuyhrP83TJwHnBnvG4ch0dqiYnVko3Jf26L5UKF5z2iG8TQztC4ZEiuWFhYkm5Tikdq7NhadgQ2lOpSQeyPW7b1tCI6V2RTQHqczXfJMorY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142505; c=relaxed/simple;
	bh=OCqszMk0ZgOWIK4Jm+n02VgcUtOHbxZDLR7gWYCvH4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCDkPnsfuvcxrmD/w4GLZS7/3tsxI2FpJV0A5avsBNzccdvX4mS3WHsAHX0Kt4HCJn0mRov5Nn4o+Per3Ww5kFT84Y2jW8tzZC3x+plvPKXBulUdC/XP9r73drdfI9PmqAaJg0KhDj+Al5O6219Dg0eLUW8CASjWk4n+bYUcdtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOLZXYel; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOLZXYel"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304d2c56402so175786eec.0
        for <stable@vger.kernel.org>; Sat, 30 May 2026 05:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780142503; cv=none;
        d=google.com; s=arc-20240605;
        b=OamfMtFt3ggzCx69AbtxbRq+zMGTLzacTC99cPv06lLWkDhycrl+crjy6Zn2UDkNzA
         oi8z9d6SUuhPrM7VvEwT3bSwWRJw7CYknQnJc/lPcMrVI8BSrUbMhur7apv44CEDtTDL
         LLXd8rCcmfn4VHqV0qQwtRKQltoAVuDrxEmIQO55/EkBtabG2UBfXNlZzdXSjidRG6fV
         FQ85aBkAVDZhofGRh8gtZsBCiDAl4l+agMv84XbqNFYO/DfnAvKnEUOxIGIEqHIURkM3
         1W5mn5aaO7yA35mbcEL+lAe10kXtZagocLKI5s4fyu3HOx5ZXD8XgUwPFkZS1QhimDLH
         c3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJn8/bdk1cE+ulHsADFHheOpLB5d3Qes9hugaPWOOuQ=;
        fh=Fyf2kCJxyrdn2fShax5vgsbpdrnRQXWjryBsOKd4dmU=;
        b=Jd+O0LF9ELxcmFA521BuGwD6ak1pgX3fahBb1Gmq2JCOT7hLA2u+EGYtI1anrBmfQa
         4TeinsKM4F7peM+MBRdzWn0StrtdyICnXJf3raCPDmg/ADMpTbTBs8wtEEC/HbHBp92s
         L1bJS8ccscomj8DgvVPjBotAbd0a1JB8gKEgMigDpnxkAH+w5KeJVdEcasNbrq1ukdq6
         I2PSvfMZImvl5Hbmwg1iDMPeDA2OX1yoI16vV7ZsOYigKid9R6QdseclmXrGrM+fDIKK
         P/fvnvVbbjWvMyeUKTtlyMiLxEpQ5bh7VzvBqujzk6nNdSzrVyzEHc0BE171Ocz/xSq/
         9FOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780142503; x=1780747303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJn8/bdk1cE+ulHsADFHheOpLB5d3Qes9hugaPWOOuQ=;
        b=HOLZXYelsos+2Pa7vM77drfVCTY6Gx/4PjajxYibJXhesJ5w8MP14JHfP/yL+1+pQq
         TN3QJH6z1lYzMCXcQlezILd8V0sL+X1q0rnYwZIH0pJOe79qfRrdxWHW4lVM+tRtrrBz
         0RW2mA6XWD/NcOM1OrcQUFv7oZosUTd4G2upj9BIoHeaRiL4ojCvPOHMbNUwxZFvstKf
         qhDLpsEfN1zhKu+o+HuS8Ru3vC7m16iHmqWDTjJdQoFah4BLORsf3MKR2dR21tKs/z0X
         Q9l6ymQZJJ9hdidx1o/Miuqv8uNHJIfgNlZK74Z672Z+tXUOB5Wz1w9zhJG7HnZ5XfXM
         aYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780142503; x=1780747303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJn8/bdk1cE+ulHsADFHheOpLB5d3Qes9hugaPWOOuQ=;
        b=TPqZPh4NtAPCXXX3vbgNsNZpbyaJ0mqfCztBej8ovcD/V/d/5FAPqvYxqo5N3N0A5/
         mFa8PvFElrQPlIOylPrPj9rt5JWq4kb2O3ClCOtEa94hH1LRubBG917b22pO4nVfZ+8q
         JcwN8q62r2280fRqCSGNmq1xfveQ0SsctsIZNLaSLKgosfuyXo4FbphC9sCskx9bOEdz
         48TyvpZ4uh5uy8uJ+JvLUqoYb9uRX4BBUWPImXg3Y7bdx97zhL0Eqw1sfLpRoBi6/fGs
         bop7Xg6w7nqm1pxXZ3J27V3dUIjCN4pquugyyB8K6fQ1ZvotK4EkiMWPqlUJL32vuD9A
         4P1g==
X-Forwarded-Encrypted: i=1; AFNElJ9P2Tos768CrG7uGo/WAwVrXeVaI1vyXaNdBD+Fp86ljKQQk4090g04p/LvAXLZzd0QySLG4Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweuw9yJy5x4F9K0ESixgiGGwPEMxVzVY53XFC3iuhjt5S90cqw
	qFLy1/wAiAA3ONZYRy9O2KDB1tiA5/2g/NYVdebqDSzj4rDRcBPuqyUoCGM5KA9uT7Fb80/sTMD
	nIcRn6y6BGpwpxKhS9tRmwz/PLbrENeM=
X-Gm-Gg: Acq92OHBT3HwffxqdgTk8MGHxSyrRp9wyvJZYH/Xirv74+1Zh3cNvSLeEAOScz41HSH
	4e8SiIkKQ76wj/nZ0+6TVXEsHoAiDoNW27bhpC9jnlMpcC2uSnYBdnTHX4gMGvsT87fB6+pY/YD
	lKZgcM9VAKbJ93Ks8XHkR0rP/dyp7Q0y0nOa2jKQlcA4oro9T0h7fKvefNHeRVFsZVZc+AZG7/s
	tPAZbyVkWFUYjyHvkf0Ol8JE6NwyG8Q3JjwAYQjRp6MCQ29PHqS2zqMUQSzsUHHisQqNAa0QMlM
	GzYh7M8Uxdp8Rzj0DEvV4NeuUSfhAHghbZSdWguk12SCwYvriSNHAPxa59Rs3ybhGWXzXqLbcjy
	7MuesZ4XlAWoIIVp+It6noHY9ObNCRkgALw==
X-Received: by 2002:a05:7300:d508:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-304fa30cb81mr774505eec.0.1780142503142; Sat, 30 May 2026
 05:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530114925.260754-1-ojeda@kernel.org>
In-Reply-To: <20260530114925.260754-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 May 2026 14:01:28 +0200
X-Gm-Features: AVHnY4LGlmoBZX2w5sGabCmClFAFhHgoPKWwrt4LBnvwnqXauOwx3a9EVVcoroU
Message-ID: <CANiq72=1zmEs_Sc8PpMNETmHEXNUERwCaWddxjuTH-TuSLzX2w@mail.gmail.com>
Subject: Re: [PATCH] rust: x86: support Rust >= 1.98.0 target spec
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Ralf Jung <post@ralfj.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 1:49=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
>      } else if cfg.has("X86_64") {

And the same change for 32-bit UML as Sashiko points out, of course --
tested that one now too.

Cheers,
Miguel
