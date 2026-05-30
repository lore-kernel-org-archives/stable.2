Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469541B4F1F
	for <stable@vger.kernel.org>; Sat, 30 May 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102811; cv=pass; b=D4ocNnRkMu16kv3LQshwq74DzGbuPHIa4d/vt4hUGIqfWOCpIwo4JVSlbsp8BEMy0QkvEYEhJgi6FT2UaNXMY6LyftN0rK4UzzBuo13BxuhdKSw/6t8c0yX4STuC80SvD9MNTRo/EXxMdMf8/ztf+rxo1kZV2Y8wQoxmRzhn3rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102811; c=relaxed/simple;
	bh=Xsapng4XUGHRM1lGFdQHa7kxf//aFyx+bzo2X+mRqmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsdqBYLPpiT6UWHsBI/10GDLHV8mxyZhkU9t0wsx9PO1gfVl6RMdQTfM2EZ76iaZ95bzB4+xr+uIe5Qthgt18nRhuoSpUO25UVmzmD3ZZ6ea2qHZMK0d2DrgB8thy08RlArdkhK0JJCHIczXKTId9XPjzkVwO65pcnTaG9BCiZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdIpuyKL; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdIpuyKL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf3781ca51so3554745ad.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 18:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780102808; cv=none;
        d=google.com; s=arc-20240605;
        b=aOd8i7PC5svLgqzBMSIPjFCMF/a93miL6J09p0AszeTtF7ksFQMCTLTm45nR/0oRo1
         gjvmkYufy2TAkmsd3ocymSEpexoRPSK5qW9oXYELf0UWk8aRzHex8NhlKQJAHiPZg/HL
         /4PKTwKoV9egXE1Brd3sIKV1MuGM5v/Mb9LieI3GjG88bXwgZEhJ+5WwnybaHFSKvzGS
         tVeyqemONvijRJ7y2BB7T2C3ut46n4dCXaIeYSkaeIQKTrvSqfThQaJmw9CD7O0sCniF
         0fJlJWCE+JybV4MNWd5AnMi8QJlyHMzXz+c4GHKPQviNPz24RJK/cmKXSAh92YJ28G6M
         1HXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iE1aJeMU3UqlHpiGOyDbSFLyOWGjGVM7dI7S8hJTB6c=;
        fh=FfRoVSWN3jZwjMhL0u92TyzefTy3PB/jthNoSF5uON4=;
        b=Zl4VTO6mfgofsMbheGeNZh6jRWb/fHgOdA8iIF5HHK5wGnQghghUXhfUmq7aym3LEm
         1VpnGAB4ED5JBwrBMyo9CnFEALLIGPfOwgaUCsWeFB5lIeG18lm1j3UME47u8jRXX2g5
         BsWfW2ZXaVW+Izd0qjbLY0bD5P4AlJP6qwXVPYHp6DzuKXNP+0866FGQ6Wq/H/YXLZLP
         7/N+/LL6Vc/gfCPj+CAI9SlgJjZmzquSBVA/qwCrj9wGRQyDYvHcjmT5GxQBPO07OeTz
         NVlMORm+sfwIzTfy9wfrmLrkC+KylMM/CegFqi5tNvSwCYmHgwmhIZP/Cx6C/ntHa2UT
         2e9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780102808; x=1780707608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE1aJeMU3UqlHpiGOyDbSFLyOWGjGVM7dI7S8hJTB6c=;
        b=gdIpuyKLbBYecXA7CfdjBbbng7Bz2c2nC2kGzxDcR8vR+nweOhixhxGezseTLFvx3V
         Lf8IzGiJlmhcK0kZE2Zk/J1kUGKFUksYhLuBTCDV7aygFPTtP8LFPk9yJmU+iR2/f+xU
         4JZ9jqq/djtMn0SUlF2HEOhfqL3bJxcR04yOUETyMSJQuDqSmRL+G9WlVjXlWZuS2U5N
         vqJb/6/YXBB3U6pctqdgZT6qCDcMN2LpIIcmm/+cbPsjH3I2E5dJ/zUhCmA3zKJZBBPU
         90wvo1B53NWIcl0WK6IrGkBqC4I3bzzZKOGsKn39Ubcdw0m60BC4Zt4dYQgDTRHAp+0l
         uFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780102808; x=1780707608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iE1aJeMU3UqlHpiGOyDbSFLyOWGjGVM7dI7S8hJTB6c=;
        b=Gl+oA9aYK9NQJYNYOx4vW0d6oQcRT7weY2M3W9piOY94rjSOG2lKH7bO2JiL9MAvbY
         ZOiJNsZ9tvNcJIJp3g5OG9YjHpIyVV0toJOVV48Dp13fgZGOm1PCGCtUszp4IwM9VhVz
         /Ma88kcDaMtyoB+tt5Eye77l6dRbubS1sDmpqj/O041Ve53vejqgg9YFX/jJfJbJx9F7
         8Gkpv0IYkg0IC7iv38WOtUNxEGhct+VO723xr3upoJRW5BdTz2ROccwk2w43uoBrd+ed
         W19cKdhzpTwpwNO61B5hF06GnHY/NfHI8slxozAWnmxEsnD1xlwY/Qm3hD4X+GezlVkM
         6vEA==
X-Forwarded-Encrypted: i=1; AFNElJ9wpCB8T5KbcgRDA82TPhKCUUmMsO2MBE1I3DS4BnZHb9aGa04Q4kfBjl37TTOh2ZZlBjEePdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxguUKmplAllJQCVdbCUhMZRh5Mz2AWtBcO7VBouoyaNBh6Ezf7
	6nfgZta4HuVQU2kxa3qOlo7Kg1qmb2UO8u4u4yoxxHA3Rr8u21j1OvvwCUGFRQFz3x+QRnJ0tRv
	n9SH80M4qktAGufpuhLLEBwYFJLyQqXM=
X-Gm-Gg: Acq92OH6kKr/2ftJUXEOqfZE00hoOWFOxRGdUb6jJvdOi5VdEEXFZ8iWaurU7UWlorS
	WdN7vaxYfX5iHyWISA4Apj+uBIWM+ljkgwx6fQCtfffBFipDADPfamX5thdw18+2lENXq2N0qfd
	BJsXCBGZ61MqByGU9+Ma4/i97SozyMUseCjuVsHAjjUY2BQPTSc/jldddd9YrXXmgKANMWzTEum
	hAwjdROSG/oAqjujtgshOiQH/39ns/01smXGjfODc1YHCfIvuwQwGZ0+nT3uS91uWHvQA0CuMIt
	3MyGCGp8fy4EvgaoiRE66JdPNyht
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id
 d9443c01a7336-2bf36803dccmr26075455ad.24.1780102808384; Fri, 29 May 2026
 18:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527025828.5966-1-CFSworks@gmail.com> <20260527025828.5966-3-CFSworks@gmail.com>
 <937c1dbbb0300a8113d62ca1dbaffe1493bd10e5.camel@ibm.com>
In-Reply-To: <937c1dbbb0300a8113d62ca1dbaffe1493bd10e5.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 29 May 2026 17:59:55 -0700
X-Gm-Features: AVHnY4KJ4IvzZHDaQ3pli8MLHryBbTX5TlcoaSBDM-uXok6d9w24L6k1pShHh_U
Message-ID: <CAH5Ym4gJYT1WNY-s_bVjaRYQqu3bgAN0SRBnj0A5vttGUb4Uyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ceph: properly decrypt filenames in vmalloc() buffers
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "mchangir@redhat.com" <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:50=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2026-05-26 at 19:58 -0700, Sam Edwards wrote:
> > The fscrypt subsystem uses the scatterlist crypto API, inheriting its
> > requirement that any buffers are in the linear mapping region. However,
> > the messenger client uses kvmalloc() to create buffers for messages,
> > which will occasionally place those buffers in the vmalloc() region whe=
n
> > physical memory fragmentation doesn't permit a large enough kmalloc().
> > The various callers of ceph_fname_to_usr() directly pass (slices of) ra=
w
> > messages from the MDS without considering that the messages may be in
> > vmalloc() buffers, resulting in oopses especially on non-x86 platforms
> > (see 'Closes:' for more details and a reproducer).
> >
> > Make ceph_fname_to_usr() explicitly tolerant of vmalloc()-allocated
> > fname->ctext, fname->name, and/or oname->name buffers, using `tname`
> > (which, when non-null, must be a linear address; when null, is briefly
> > allocated as necessary) as a bounce buffer to avoid passing any
> > inappropriate addresses to fscrypt_fname_disk_to_usr().
> >
> > Additionally change parse_reply_info_readdir() -- the only function to
> > supply its own `tname` -- to follow the new "tname must never come from
> > vmalloc()" rule by passing NULL when the message is not in the linear
> > region. Though this causes a per-dentry kmalloc()+kfree(), this overhea=
d
> > exists only when processing the minority of messages that spill into
> > vmalloc(). My (crude) testing puts this at only about 1 in 8,000 readdi=
r
> > messages. Still, if the overhead proves unreasonable in the future, it
> > is easy enough to mitigate: a future change could allocate a bounce
> > buffer in parse_reply_info_readdir() and use that as `tname` instead.
> >
> > Fixes: 457117f077c67 ("ceph: add helpers for converting names for userl=
and presentation")
> > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.ker=
nel.org_ceph-2Ddevel_CAH5Ym4ga7miUQE0K-2DcJA93Ya7w62P69MAN27R5cBiYnudoOHdA-=
40mail.gmail.com_T_&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8N=
Ju1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DbcX0FhBD6jzWXGOsw2LoJOl_TqgobmwNBmqNIhj2=
K0qBn2krB8IUrIhcUs8LmJWM&s=3D2uInY5Ys7xQ_57Ifo4uovP7_e8SN0Q_wnzBDX-uj0hE&e=
=3D
> > Cc: stable@vger.kernel.org # v6.6+
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/crypto.c     | 37 +++++++++++++++++++++++++++++--------
> >  fs/ceph/mds_client.c |  8 ++++++--
> >  2 files changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 7515cb251226..61d6830d16bc 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -298,6 +298,10 @@ int ceph_encode_encrypted_dname(struct inode *pare=
nt, char *buf, int elen)
> >   * Otherwise, base64 decode the string, and then ask fscrypt to format=
 it
> >   * for userland presentation.
> >   *
> > + * Though the fscrypt/crypto subsystems broadly expect all buffers to =
be in the
> > + * linear-mapped region, this function slightly relaxes those requirem=
ents:
> > + * fname->ctext, fname->name, and oname->name may be vmalloc(), but no=
t tname.
> > + *
> >   * Returns 0 on success or negative error code on error.
> >   */
> >  int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *t=
name,
> > @@ -305,11 +309,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, unsigned char *tname,
> >  {
> >       struct inode *dir =3D fname->dir;
> >       struct fscrypt_str _tname =3D FSTR_INIT(NULL, 0);
> > +     struct fscrypt_str _oname;
> >       struct fscrypt_str iname;
> >       char *name =3D fname->name;
> >       int name_len =3D fname->name_len;
> >       int ret;
> >
> > +     if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
> > +             return -EIO;
> > +
> >       /* Sanity check that the resulting name will fit in the buffer */
> >       if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
> >               return -EIO;
> > @@ -350,16 +358,18 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, unsigned char *tname,
> >               goto out_inode;
> >       }
> >
> > +     if (!tname && (fname->ctext_len =3D=3D 0 ||
> > +                    unlikely(is_vmalloc_addr(fname->ctext)) ||
> > +                    unlikely(is_vmalloc_addr(oname->name)))) {
> > +             ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
> > +             if (ret)
> > +                     goto out_inode;
> > +             tname =3D _tname.name;
> > +     }
> > +
> >       if (fname->ctext_len =3D=3D 0) {
> >               int declen;
> >
> > -             if (!tname) {
> > -                     ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tn=
ame);
> > -                     if (ret)
> > -                             goto out_inode;
> > -                     tname =3D _tname.name;
> > -             }
> > -
> >               declen =3D base64_decode(name, name_len, tname, false,
> >                                      BASE64_IMAP);
> >               if (declen <=3D 0) {
> > @@ -368,12 +378,21 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, unsigned char *tname,
> >               }
> >               iname.name =3D tname;
> >               iname.len =3D declen;
> > +     } else if (unlikely(is_vmalloc_addr(fname->ctext))) {
> > +             memcpy(tname, fname->ctext, fname->ctext_len);
> > +
> > +             iname.name =3D tname;
> > +             iname.len =3D fname->ctext_len;
> >       } else {
> >               iname.name =3D fname->ctext;
> >               iname.len =3D fname->ctext_len;
> >       }
> >
> > -     ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
> > +     _oname.name =3D unlikely(is_vmalloc_addr(oname->name)) ?
> > +             tname : oname->name;
> > +     _oname.len =3D oname->len;
> > +     ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, &_oname);
> > +     oname->len =3D _oname.len;
> >       if (!ret && (dir !=3D fname->dir)) {
> >               char tmp_buf[BASE64_CHARS(NAME_MAX)];
> >
> > @@ -381,6 +400,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
e, unsigned char *tname,
> >                                   oname->len, oname->name, dir->i_ino);
> >               memcpy(oname->name, tmp_buf, name_len);
> >               oname->len =3D name_len;
> > +     } else if (!ret && unlikely(is_vmalloc_addr(oname->name))) {
> > +             memcpy(oname->name, _oname.name, _oname.len);
> >       }
>
> When both dir !=3D fname->dir (longname snapshot) and is_vmalloc_addr(ona=
me->name)
> are true:
>
> (1) The if branch is taken =E2=80=94 NOT the else if.
> (2) _oname.name =3D tname holds the decrypted result (fscrypt wrote there=
).
> (3) oname->name is the stale vmalloc buffer =E2=80=94 the copy-back in th=
e else if was
> never executed.
> (4) The snprintf reads oname->name and formats a snapshot name from garba=
ge.
>
> Am I right?

Hi Slava,

Indeed you are. Well spotted, I should have examined that snprintf a
little more closely.

> This part of logic needs to be reworked carefully. This if - else constru=
ction
> becomes really complicated to understand.

ACK - I was originally just going to amend the patch with that fixed:

                char tmp_buf[BASE64_CHARS(NAME_MAX)];

                name_len =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu=
",
-                                   oname->len, oname->name, dir->i_ino);
+                                   _oname.len, _oname.name, dir->i_ino);
                memcpy(oname->name, tmp_buf, name_len);
                oname->len =3D name_len;

...but, looking at the if/else-if block more carefully, I realized we
only care about ensuring `!ret`, so I'll simplify the control flow for
v2.

Thank you for the feedback,
Sam

> Thanks,
> Slava.
>
> >
> >  out:
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index aa6730b48e97..8fcf185e3a82 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -538,9 +538,13 @@ static int parse_reply_info_readdir(void **p, void=
 *end,
> >                        * to do the base64_decode in-place. It's
> >                        * safe because the decoded string should
> >                        * always be shorter, which is 3/4 of origin
> > -                      * string.
> > +                      * string. If this message was allocated with
> > +                      * vmalloc() (happens, but rarely), leave it
> > +                      * NULL and let ceph_fname_to_usr() allocate
> > +                      * suitable temporary working space instead.
> >                        */
> > -                     tname =3D _name;
> > +                     if (likely(!is_vmalloc_addr(_name)))
> > +                             tname =3D _name;
> >
> >                       /*
> >                        * Set oname to _name too, and this will be
