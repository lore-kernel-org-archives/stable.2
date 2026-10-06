Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFF2F60CC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323063; cv=none; b=rQWUngjyDoTWMNtAXQMj6maQmt8Kq2SXQZoCPVr4Yi5YT5E4f2TQlkfMf6Ny0nFoHkdjjVUlP/VNv4XMU8dANaqFF6n42LzLp8Ll31hRECODeXHR3BOSOep1xOSXIpi4qOB5MxQ57WsQnA6TqYvN55NMv5omYvv5iMT+s/mxA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323063; c=relaxed/simple;
	bh=aUosEal3MZjZMLAJNgDR8ZADgwQLa9nKKm8X24NMJAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZB/fULFjsIM+hfcGDyoEc2vCp7nOpM5/5EgIA5VMJoayXyoMoWuIwrbsXRfcrzVla6bJcdAmFw7uBT8nQjI33MYEM0IkZGx6A7+jhKxCWf9xOma3WR6mUMGGDKyKRcuS7pO/uTNr9Bh1XyABDrRDJ6rNPvns+moGMH9RFvc7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJaWCSpA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJaWCSpA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso10115ad.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791323061; x=1791927861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G2/CnIgDJ02uU7V1vOgIKyg9HQ6J0Mb5GXmpvN71ZxM=;
        b=mJaWCSpAdHXzbJAkiOszFqHRp8w41thr5nISBt5H/H0tWot5Q0AbP+NRGrvdYKGUaJ
         yo/vFof/om15gZqIlnbcbcRS4adRoE1XbCBzky0d4DT2Bm8ST8j5JGhvWL7S7rhFNHBL
         4T4wmhCaEzGgG0GuqMppv0Vi6Vog2zWiBePho8d3l02uC7SIljrnTOGUuuaMH91fV1P1
         AdYFhEmuZ8ELiOVYVvvjW39vOnVxqFfO6Tzsl27MKd6hwXb7xHYSAaa2DLz5Yh2ReiMz
         NM0PEurSoh7L0tMkztdrivg2OTpr3D2CsLJhSNEiPgxkVNDzbYqSwg6yz+d1Lbx3wc8C
         iazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791323061; x=1791927861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2/CnIgDJ02uU7V1vOgIKyg9HQ6J0Mb5GXmpvN71ZxM=;
        b=fJEjBFk1nxgRnS63Fph17DNNOKkdx+1+I2cp/eoeDA+2ULmtl1/vX+nuWBSrYAp9Rr
         8+LkMV40cY0rjls0RANfKAeL9zEeU+VoWm1we9wckZ8acDcgVAL/3IgOTssQeq6oO2/m
         M0JtToxD0wKuayPBv2HPnQ413HO4XO4mrAyNlDiW0KFD0UIJI8ZtroCDWFEMR+qE6on6
         xeotC7TFmKyVjn8Rr5axLDYEHnU5P1ndUbTIpLqUlHl3mI7QzMtDi+OjPeNIpgIANSG1
         M5afXt9wzII5fdCdQdoW3g5FIhFN2USvt9ABC0VurEaOcu+Apa6cAIERPYIibWu6bVgQ
         4hXg==
X-Forwarded-Encrypted: i=1; AKwUvBymC4ItTnIyopZ5TuT55/Hq/HlgrFiCsJLRmrdLgcKL/UqeusUAxFDzah9BVI5USh3RZB+hDE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI30DXEdhiU/Ejs9Iu9Ns0Jxi/jVg1KCjFGm2lStTQbpjvn0c5g
	lM3Vhky3WfuvzJxKXAbBQ9Hin/09Yl+2ywLyZEOo6E6sMCzdCw6DgvUghjufRtDTtw==
X-Gm-Gg: AYBFou3PqqdjG8zcFUVJJQR3aZl4wa54p8547bTJFVwbAXKKiei1XH6t6Jd+EcGozVL
	Cz25cRIOk2MuxlV2mYnz7M9iigRPG1otqFpeEubgpcy3x9PUDG1LwdHc2PwSQa/DZRRaHse9stz
	p1UHuRL+lbYgE1He0SoKWxNLuh8KqkEdXddXtQkpTQV8Z6uWUEiuzupZU3X2q/ihQJ3TMe3DDz9
	Ix+somm9MQ3MHWAWgGlSSOyax+b7hJCP+dU5MGJ96HxwhUvTGNrdtCHMv3/ZS6VmnT2VxQZXRv8
	5mrilMiaqaDw4PRvKntL8ulkq8b75+PRCkJGlbEh0dYTA4s4pMNJ5uVyexzdd2fF655NkFgi6zT
	IhiZKeScp5VWj8GdoRBWW9TRZYIssa6z1Onl2h9FnKggJj+E2jUVjCHXEAAlj+awfi/pgbCb548
	8b/Az6gKi2o/ncbRcGFkHPQ3xKLi6V0bB6jVIAIYjJERyBLfTUxraZBzQPeJBRaYMX4ud+vnqiN
	AM4wYNlNcnR9LEuwg0uuQhcf3dtOzdvxRYeGzcoCEpZA1lG7D6agE9vhNxBJMoV5gLRBDkVTD19
	X7hIdp+lSl/l4X+Ivl9/ha00hyNBBwOq1Hwi3yoH0r70jq8=
X-Received: by 2002:a17:902:ebc5:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2e5ccf0268bmr6121035ad.17.1791323060723;
        Tue, 06 Oct 2026 14:44:20 -0700 (PDT)
Received: from google.com (99.95.125.34.bc.googleusercontent.com. [34.125.95.99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd09d215b96sm577100a12.0.2026.10.06.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 14:44:19 -0700 (PDT)
Date: Tue, 6 Oct 2026 21:44:12 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Ke Sun <sunke@kylinos.cn>, Dirk Behme <dirk.behme@de.bosch.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"open list:RUST" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: fmt: drop the "0x" prefix from {:p} to match %p
Message-ID: <asVrrG0P_QGf3u_M@google.com>
References: <20261006183857.396710-1-cmllamas@google.com>
 <DLY2A3MDYYTH.2IXSHIKU7SJEH@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLY2A3MDYYTH.2IXSHIKU7SJEH@garyguo.net>

On Tue, Oct 06, 2026 at 11:09:09PM +0200, Gary Guo wrote:
> On Tue Oct 6, 2026 at 8:38 PM CEST, Carlos Llamas wrote:
> > Commit 643a7c306b8c ("rust: fmt: route {:p} through HashedPtr to prevent
> > address leaks") made {:p} go through the kernel's %p so that pointers
> > are hashed by default. However, it formats them with %#0*p, where the
> > '#' flag prepends a '0x' prefix that the plain %p does not produce in C.
> > Thus the same pointer is printed differently from C and from Rust:
> >
> >     C     %p      00000000e8efa736
> >     Rust  {:p}  0x00000000e8efa736
> >
> > The prefix is a leftover from 'core::fmt::Pointer', which always adds
> > one. However, doing so deviates from the %p format documented in
> > Documentation/core-api/printk-formats.rst and makes it harder to
> > correlate the same pointer across C and Rust messages.
> >
> > Format the pointer with '%0*p' instead and adjust the default field
> > width accordingly, so that {:p} produces exactly the same output as
> > plain %p which is zero-padded to the width of a pointer and without any
> > prefix, both for hashed pointers and for real addresses under
> > 'no_hash_pointers'. Update the KUnit test expectations to match.
> >
> > Note this patch focuses only on fixing the '{:p}' prefix to match %p.
> > The '#' flag remains ignored as before, so the '{:#p}' equivalent to
> > %#p should be sent as a follow up patch.
> >
> > Fixes: 643a7c306b8c ("rust: fmt: route {:p} through HashedPtr to prevent address leaks")
> 
> Rust libcore's `:p` also adds the 0x, so I don't consider this a fix.
> This will be an intentional behaviour divergence from Rust format specifier, so
> this fact need to be mentioned explicitly.

I see. I was afraid this was going to be the case. Then, I don't know if
:p in the kernel should follow %p or std:fmt. It diverges either way.
For context, I ran into this issue because log parsing broke in binder
when I started using :p due to the unexpected prefix.

I suppose one can always open code a %p equivalent as needed too but
perhaps matching the %p behavior make more sense? I dunno, wdyt?

--
Carlos Llamas
