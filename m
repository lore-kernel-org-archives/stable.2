Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30F3C6600;
	Tue, 22 Sep 2026 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077926; cv=none; b=jCg1LGCAViiLHVplO2k5+m5ejwRrETQ6bZX1y0xz+w53E+3tqg3pIkppzBiTjFOb5Wbor8oPjWwSYp7WKneC7fFE9pwWL+gbDx2ryU7MoMeGCMuBminNSsBA6t9vagFpzzuTs0pcCkbBVqVixEqxmPwfIlFe0j5Atvx6TqWSLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077926; c=relaxed/simple;
	bh=D9ZnlxhLyS5+nP0zqh4D73xmn+7BRn5CzcEEG4vfSJ4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HiNC7i0uWi9AMC5ME9INDSpOb2zHQhv9fmSgiRhpXeBcgP5CywJ54637Pb5MebVBvOOBk0dft8Aa/VJZYjBFC2BpR3W/SMYPNIAVVb93kpVc/52HL1uZ11A/Cib1SD9yBNyWOm0RCdA/qz1XEDW6n0a9ezg8CZI46BIIqcq0/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipzqRLhR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipzqRLhR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790077924; x=1821613924;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D9ZnlxhLyS5+nP0zqh4D73xmn+7BRn5CzcEEG4vfSJ4=;
  b=ipzqRLhRHg+58pQSPIf5EsMTzqYEy0zhsJlyVbclUzngDRMkIa1zMJ/L
   7FJl4Tr9j+gcmwK3cOWDaLRDA3Q7lLKA5WpB3+zLpzoVe7ih+B5iWeQFZ
   68sOYqS8svMi5H8DiPLup5kEVj6wFtzk8tQiuAAWEeqPZo3IOAFtupC8w
   +5pYVJFq+p7yl2ADksGaOglgUIf2YyS22O45Fu6+8NH8CbGOkdVTfmNgR
   9YOK8+Ldm5EUeqoWet4GO45oTrVCcIZ8UhBCYxBBHo/ZI0j0Zv+b4+wyb
   x2nMLy7oP18aYhbiwwlXrFNjUr5ZskpU3BZUCUQPs418VCXGVOXM9mg5J
   A==;
X-CSE-ConnectionGUID: Gqqvh3MVSwqVHgk31LOL1A==
X-CSE-MsgGUID: ckty+CXgQrKzle8EbW1oJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89806327"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="89806327"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:52:03 -0700
X-CSE-ConnectionGUID: R4SQEZlLRnWYR+hGiUhMnA==
X-CSE-MsgGUID: yAZKAI+QQPOLPkwXu+xHeg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:52:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Sep 2026 14:51:57 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: jorge.lopez2@hp.com, Hans de Goede <hansg@kernel.org>, 
    linux@weissschuh.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and
 buffer desync in hp_get_string_from_buffer()
In-Reply-To: <CADqcGBnuzxwKiQ-r94gin0+8oWpvsWQ+tL=PRpK=tee7A2okdw@mail.gmail.com>
Message-ID: <328dceac-d5cd-269d-518d-6f7a7bbf52f0@linux.intel.com>
References: <20260824225610.18471-1-meatuni001@gmail.com> <20260824225610.18471-3-meatuni001@gmail.com> <a67d4e52-5e87-0e76-4c91-cb8ba2be31f9@linux.intel.com> <CADqcGBnGHd+rRn6b=eWVjhWDU-NQ4CFb-3B9cgwBeouN-sbw4Q@mail.gmail.com> <ab2078e1-4388-6311-0363-afdfc131ea60@linux.intel.com>
 <CADqcGBnuzxwKiQ-r94gin0+8oWpvsWQ+tL=PRpK=tee7A2okdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1313611999-1790077917=:1233"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1313611999-1790077917=:1233
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 Sep 2026, Muhammad Bilal wrote:

> That makes sense, thanks for the pointers. Here's what I found and a
> concrete proposal.
>=20
> string_escape_mem() (lib/string_helpers.c) does exactly what the
> manual loop is trying to do, safely: it takes a source byte buffer and
> length, writes escaped output into dst up to osz without ever writing
> past it, and returns the true escaped length so truncation is
> detectable by comparing the return value to osz. I checked
> escape_passthrough(), the fallback for anything not matched by a flag:
> it copies the byte through unchanged. ESCAPE_SPACE covers \n \r \t \v
> \f, ESCAPE_SPECIAL covers \\ \a \e and ".

I think what we don't want is to add other characters beyond \\ from this=
=20
ESCAPE_SPECIAL set, definitely not " I'd way. So one needs to perhaps add=
=20
another flag to have it do only backslash escapes _without_ changing the=20
meaning of ESCAPE_SPECIAL.

> All of those are ASCII
> values below 0x80, so none of them can collide with a UTF-8
> continuation or lead byte (those are always >=3D 0x80). So running
> string_escape_mem() over already-converted UTF-8 output is safe
> without needing to be UTF-8-aware itself.

Yes. I didn't realize this >=3D 0x80 property earlier.

> Proposed shape: convert with utf16s_to_utf8s() into a scratch buffer,
> then string_escape_mem() that scratch buffer into dst.
>=20
> char utf8_buf[MAX_BUFF_SIZE];
> int utf8_len;
> int escaped_len;
>=20
> utf8_len =3D utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN,
> utf8_buf, sizeof(utf8_buf));
>=20
> escaped_len =3D string_escape_mem(utf8_buf, utf8_len, dst, dst_size - 1,
> ESCAPE_SPACE | ESCAPE_SPECIAL, NULL);
> dst[escaped_len] =3D 0;
>=20
> I want to flag the scratch buffer sizing specifically, since I got
> this wrong in my first pass at this reply and want to be upfront about
> it. src_size is attacker/firmware controlled (a u16 read straight from
> the WMI buffer), so orig_size can be up to ~32767 u16 units, worst
> case UTF-8 expansion of that is close to 100KB, nowhere near safe for
> a fixed-size stack buffer, and the kernel doesn't allow sizing a stack
> array off a runtime value. I checked all three call sites in this
> file: dst_size is 512 (MAX_BUFF_SIZE) at every one of them, no
> exceptions. So the above caps the conversion at MAX_BUFF_SIZE
> regardless of what orig_size claims, same capping discipline the
> current code already applies to conv_dst_size, just applied a step
> earlier, before the escape-inflated count. Open to a different
> constant or a kmalloc'd buffer instead if you'd rather not hardcode a
> dependency on MAX_BUFF_SIZE inside this function.
>=20
> Two more things I want your input on:
>=20
> 1. Quote handling changes. ESCAPE_SPECIAL turns " into \", the current
> code turns it into ' instead (no backslash). Switching to the library
> means losing that substitution, a visible output change I'd rather
> confirm than assume is fine.
>=20
> 2. \v and \f get escaped now, where they weren't before. Matches what
> you said about \v being an oversight,

It might be AI just parroting what I said about it being an oversight, I=20
don't know if it was an oversight or not but having these strings contain=
=20
\v in unescaped form doesn't seem very useful, same goes for \f which I=20
just didn't remember (I didn't check the code that deeply while writing=20
the previous email).

> just flagging that \f comes
> along with it from the same flag, there's no way to get one without
> the other from ESCAPE_SPACE.

I'm arguing ESCAPE_SPACE might work for us, because both \f and \v relate=
=20
to characters that might not have use in realistic characters this=20
interface is going to have, BUT I'm definitely not sure of that. But it=20
would seem worth a try.

=2E..And not using ESCAPE_SPECIAL but add ESCAPE_BACKSLASH along side with=
=20
ESCAPE_SPECIAL. It's easy to claim that \ always needs escapes when=20
there's any escaping going on so the justification for adding it=20
separately is there (both ESCAPE_SPACE and ESCAPE_NULL currently produce=20
broken output without backslashes getting escaped).

> On utf8clen(): found it, static inline and duplicated in both
> fs/unicode/mkutf8data.c and fs/unicode/utf8-norm.c, unusable from a
> driver as is. I don't think this fix needs it though,
> string_escape_mem() is already byte-transparent to UTF-8 as noted
> above. The only thing utf8clen() would buy is guaranteeing a dst_size
> truncation never lands mid-character. Given this is short BIOS
> attribute strings, I'd lean toward leaving that as a known, minor
> limitation for now rather than pulling in a separate cross-subsystem
> cleanup patch to fs/unicode just for it. Let me know if you'd rather I
> do that properly first.

Yes, since string_escape_mem() likely works, utf8clen() doesn't matter.

--=20
 i.

>=20
> Thanks,
> Muhammad
>=20
> On Mon, Sep 21, 2026 at 7:29=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Sat, 19 Sep 2026, Muhammad Bilal wrote:
> >
> > > Confirmed, you're right about the redundancy.
> > >
> > > utf16s_to_utf8s() takes src by value, so it can't advance the caller'=
s
> > > src pointer. The second loop then restarts from the same position and
> > > overwrites everything the conversion just wrote, using dst[i] =3D *sr=
c,
> > > a raw truncating cast with no UTF-8 encoding. So step 2 is currently
> > > dead work, and the function is ASCII-only in practice: any character
> > > above 0x7f gets truncated to garbage instead of being properly
> > > encoded.
> > >
> > > Two ways to fix that, and I'd like your preference before I send
> > > anything more for it:
> > >
> > > (a) Keep utf16s_to_utf8s() as the real conversion, and rewrite the
> > > second loop to do escaping as a pass over its UTF-8 output instead of
> > > re-deriving from UTF-16 src.
> >
> > Not exactly this, but somewhere there.
> >
> > You should not try to build the escaping nor utf-8 parsing/length
> > calculation within the driver but use generic code for that.
> >
> > To give some directions...
> >
> > There seems to be some escaping function in lib/string_helpers.c but si=
nce
> > we're dealing with an UTF-8 string here, there might not be a readily
> > available function for string inputs/outputs.
> >
> > escape_space() seems to also cover escaping \v, which wasn't among the
> > characters this driver escapes. You might need to check that particular
> > character in driver before calling the library's escape funtion though
> > I'm more thinking along the lines of not escaping it was an oversight f=
rom
> > the original submitter (given the questionable quality of this driver t=
o
> > begin with).
> >
> > utf8clen() seems to exists, but is currently in inconvinient place (and
> > already duplicated so it should be placed into some header anyway).
> >
> > > (b) Drop utf16s_to_utf8s() entirely if ASCII-only was always the
> > > intent, and keep only the manual loop, fixing its bounds instead..
> >
> > I think ASCII only was not the intent, but it just happens to work in
> > many cases which is why this has survived so far.
> >
> > --
> >  i.
> >
>=20
--8323328-1313611999-1790077917=:1233--
