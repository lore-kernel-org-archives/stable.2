Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795155867;
	b=I507tze2tQ7cWwMtChgNbCgIJlKkeGLSblnRgUOUh69/7hKZvimqvIqsxAoFX7DKNery
	 9k57tQL4n5OQQxBluuZ3OCUyvG9zMSccdc+0Sy6COP6GMiC9uAE/sPENjNvq4YZ7pbNjc
	 kwtcTA71KVmgmdhID8geU8Eo+UQfsod6MkFYWJTFh7t1Frmx7PHChLPkrXndJLayjwJ9L
	 6MyQNvOh92+9/ToLlWbqGplu5/0At4mJI6aGsFteOnpUpgqrZTjaqOBEN8iXMRF1D7+IC
	 1diIlG5WtfKNklMP1BDXtXxpCgcdfE6f+fVvrDGAKmzDrI3wRBDQ704u9hrjORU9DbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MODmg70tTlMb+YURV78DlCedigvuC4NLCFhQopdQZE0=;
	b=x8erQNxZD9P85kNaBzyT8/wjhkI/3un55JTK4ddFzsw/PvZ/zwAjBsDxll84laxnq2Gu
	 6DBXd/3NX7HELXFQQHWBKBTgB9Z2TIIOfwh9uKhjNWgwrAfC9Mfz4+rsDstPtiphV0VeT
	 rOwyPdl9SEcUH2MkE0hr4QiO5jPJdlBmgDYys8EQOnv2JaEJfBl8kXfVdcxOQY4fiAv6i
	 K5dwFTHQ6ZA0Gbcs+bMI4pA9GR4WB4JrYy8Zwt8cfHAzD1PAwhmsl8coxlIVTvbaf8uXV
	 cV81Vj3di7rkR7lNYnY/9V/zY013V1yEKvvkzFAbyErObwEPX/VVqu33IFQYLJJL1RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=A3byl5vO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F20606A33F
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F20606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=A3byl5vO
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so677955a12.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795155862; cv=none;
        d=google.com; s=arc-20260327;
        b=YSTlvMuyp1rnzm1h7jUAwpuODC5e/WHO02WG6e1sopi3VOk1MxWJcUutR65fA1GHxo
         UEKRWAPaXbBfOruMW0vv1ZLOkJBTJY8EfovTXeXxF3lI3ZBqnpHcMi4YGhIUVnE/fpHG
         qTuUjhuv5tfJJi8H8lk6FG9KCwvVXniiBTTG0Pf1w8swFoakcSUsrgrK7vb8cD5PPgN6
         R0wHtIADVYUjzQpgBcQaHol0BwOfj/N2nEqqhwPBjUkiMMDk+Izdz+pMBxTH8A9dg/6B
         sa2FwYMfMPWx+bO0QzzuA9KGx9ipEqwLngsxDMKte7cYW0mzkdri6FzWN3ZB2X8dPb9Q
         73lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MODmg70tTlMb+YURV78DlCedigvuC4NLCFhQopdQZE0=;
        fh=zsd2cblcypFq5q0WIwMwe0BSM+mmRxlHhbgmKrsz4Mk=;
        b=e+f0xVpUvVIKxR0ygxOjiKv/t7HFruaG77pWPwd2w5jkARlLTil5RC9GOJSNH7Bb3W
         uoqZuFV9a70lTaDylkrDLxjbjEuhUWReD/khFy5rIWXKXh404D4+ydddRbMPZe+XaH+V
         87c2hubIz1nzxIvGiTXbZnMVOg9ffU/jYWZuyGqizNozFQjjkENIdgtOiQ8/RIUfe9+B
         vdVti3arEaTGUbA0T8sDcvzaEQWhzlS7sbMO5JfABCtwXEQezee0kOjThGRd8YT6mNaB
         kk4SX3nIwUv1DJSKTvhC/NVNvcpxcG4rqM8w0Z9n53vjTlT/GXQvJ9WV6KFnTDBc0szn
         OBlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795155862; x=1795760662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MODmg70tTlMb+YURV78DlCedigvuC4NLCFhQopdQZE0=;
        b=A3byl5vOQIyjDjSu0HuJyFyXXESWoCgkKPFgfEavXogA408KlsFBx+xOKF8ZHPGxfN
         84OKeyX7rWk2PO+vdgDeIkCoxPp8R++z1n2958eRSiDuYCckkXeF4Utzkv3ZpTIkwbFZ
         vLDtURA2njeoDHiRrH+RwOE+y8/dcNDcJ+txLhCEVdujhwGRQPU9NY7yiGLxANWCRFzU
         WW02yYaA4iE/WKxrxONq3Oqj9nSIThJvJtj98BuniNvggKsE2iWl7FuOwIzyWvnymeki
         nHBrqxzp0mdTHYEbOVibA8nArk+aK8a2C+tlePE97y1Nww3VeQ0HfOC4V2EH7bZqc7dU
         y6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795155862; x=1795760662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MODmg70tTlMb+YURV78DlCedigvuC4NLCFhQopdQZE0=;
        b=grj54RUqx4pcTsAeAmfsAVMOgVQZZ2lrokBMbWURDXJMSo604sFshcOShgEPW+Wqlu
         3DeRmr5CybYY3qdXqXumr89N6l0kbd5OXSaVkMeYvbdcprgEkfyZRpXi0wBhws77DFg7
         4fnQWM3wx9NqGaFrzDPe/BL/h9lPL3qqnXyGv8URZHAkTZ+Se8sQ08NoQIzehLEGkYvL
         kUZJJiPMbyHpal6KlZ1DwY+gAznxa82cEYN8EMOzwj7mPpp4OFyHxbdyVC+ow0dl/vcs
         NxfpW5GMogdjRdbdGrPppA4GWnOs0oOU5/vCs8GgU3BKZl1h/QgeiVbeKPRvwZQ3ASRT
         HffA==
X-Forwarded-Encrypted: i=1; AL+hErG2CVIc/6MH6hsim7zz3oWrT4oM+CO/4XjcScdO5r2f7EtRcsVyhd3gfkULslKW8l4a0puOq+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VqBMRmCLxUgSvvooYIs20sFEEcflGLdqfjtdXcAQXyXOcOGgP
	hdEW8AwmRJj9FgxdSWMfA9xXofX0b5rTOlBVLUF2cOrKaEEmfQ2/A9aqDvaRe7dHMzkIDHa2S5g
	lkd0iRH64oqo8QQlraPuAoHJaq1Q1WCdaTNm1F/CDaFa7RPO4yQS9riXT8rHD
X-Gm-Gg: AZFdTZfYhN00/lQRDQtyYd7kQZx2BiOu3HOZaPP+5w7sdg+YhbLip4Im0k15zg5s4o7
	q9+GFCXDq+Rx6UIasBYt+0LG5dQMIIoDKv91+npIPSuJg4W/5jpaLUCsbvh0/L1Ls80cGqRsKYF
	jWxxQPapQ/su/a33VDE9SDxvYO4h7qic6LwyJHiuLx7MNuu784KRImS7TULaIz3qwWGgca0ZKQ+
	wcSuwMenn0B3ZXje7ltdamTXNLeYt+HD2m0TgqCj57J2tc47kK4Nc4RGaJ3gRcoTdBvEuAKPgVO
	onvpjKgW28U+rd/kFHUfn3AlDLK9/kPu7iTmQaCx3654URdp82bhX1Kz2UgDM4nDShExyxHjPXY
	Ov698qN62wc8jxSWpCoJ1VYzACWYPT2REdlmcRja1dwg84+Ac
X-Received: by 2002:a17:907:97cc:b0:c40:3a99:3f96 with SMTP id
 a640c23a62f3a-c513a5ed338mr182484166b.10.1795155862252; Thu, 19 Nov 2026
 22:24:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-ceph-readdir-name-max-v1-1-ba7c434d4733@clyso.com> <CAK8psm4BqmEPnhU8piRoZ2ZkJ9NVNtw=dka4DuL18U9j+A1wPQ@mail.gmail.com>
In-Reply-To: <CAK8psm4BqmEPnhU8piRoZ2ZkJ9NVNtw=dka4DuL18U9j+A1wPQ@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 20 Nov 2026 07:24:08 +0100
X-Gm-Features: Aa3M54pZj5olb0efvd5-lf-1yhvcd5o2xGtXkcnxUHsxRXMp16OrQ3VGoJ2HGlc
Message-ID: <CAOJNxRKZK114w44Y06XPt-+aP8=KBpUEH33Qu41Z3b1v9PdE9Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: reject MDS dentry names longer than NAME_MAX
To: leograntquinn@gmail.com
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quinn,

Sounds good, I will go ahead and post it publicly then.

Thanks,
Xiubo

On Fri, 20 Nov 2026 at 08:22, <leograntquinn@gmail.com> wrote:
>
> Hi Xiubo,
>
> Thanks for the patch and for the Reported-by. It covers the four sites
> as discussed =E2=80=94 the two reply parsers and the two copy sites =E2=
=80=94 and the
> approach of rejecting overlong names at parse time so =3Dn builds fail
> the same way =3Dy builds already do looks right to me.
>
> From my side there is no need for coordinated disclosure; I am fine
> with you posting it to ceph-devel and linux-kernel as planned.
>
> Best regards,
> Quinn Grant
>
> On Fri, 20 Nov 2026 07:40:16 +0200, Xiubo Li via B4 Relay
> <devnull+xiubo.li.clyso.com@kernel.org> wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > The MDS reply parsers bound a dentry name only by the remaining
> > payload, never by NAME_MAX.  With CONFIG_FS_ENCRYPTION=3Dy that is
> > caught later, because ceph_fname_to_usr() refuses any name longer
> > than NAME_MAX, encrypted directory or not.  With
> > CONFIG_FS_ENCRYPTION=3Dn, ceph_fname_to_usr() is a stub that passes the
> > name through, so a buggy or malicious MDS can hand the client an
> > overlong name, and two fixed size buffers then overflow:
> >
> >  - ceph_readdir() keeps the last entry of a chunk in
> >    dfi->last_name, and the next READDIR request copies it into a
> >    NAME_MAX + 1 byte r_path2 buffer without a length check.
> >
> >  - a dentry created from such a name (readdir prepopulate, or the
> >    LOOKUPNAME trace) is later sent back in a lease message whose
> >    front is sized for NAME_MAX bytes of name.
> >
> > Reject a dentry name longer than NAME_MAX in both
> > parse_reply_info_readdir() and parse_reply_info_trace(), so an =3Dn
> > build fails the reply with -EIO the same way an =3Dy build already
> > does.  Also check the length at the two copy sites, so a long name
> > that gets there by any other way is refused instead of written past
> > the buffer.
> >
> > Fixes: 8f2a98ef3c1a ("ceph: ensure d_name/d_parent stability in ceph_md=
sc_lease_send_msg()")
> > Fixes: af9ffa6df7e3 ("ceph: add support to readdir for encrypted names"=
)
> > Cc: stable@vger.kernel.org
> > Reported-by: Quinn Grant <leograntquinn@gmail.com>
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> > This is sent privately first, as a follow-up to Quinn's report to
> > security@kernel.org.  Please let me know if you see a need for
> > coordinated disclosure.  Otherwise I plan to post it to ceph-devel and
> > linux-kernel (with Cc: stable) in a few days.
> >
> > On CONFIG_FS_ENCRYPTION=3Dn builds a buggy or malicious MDS can send a
> > dentry name longer than NAME_MAX.  It then overflows the NAME_MAX + 1
> > byte readdir continuation buffer and the lease message front.  This
> > patch rejects such names when the MDS reply is parsed, and also checks
> > the length at both copy sites.
> >
> > Tested on a KASAN kernel with CONFIG_FS_ENCRYPTION=3Dn:
> >  - without the patch: FORTIFY reports a 512-byte memcpy into a 256-byte
> >    buffer in ceph_readdir(); KASAN reports a 512-byte write in
> >    ceph_mdsc_lease_send_msg(); a 256-byte name already makes
> >    ceph_encode_filepath() read out of bounds
> >  - with the patch: readdir returns -EIO and no dentry is created; a
> >    255-byte name works as before (listing, readdir continuation,
> >    lookup, lease renewal); readdir of a 3000-entry directory with
> >    several chunk sizes and fsstress show no regression
> > ---
> >  fs/ceph/dir.c        |  5 +++++
> >  fs/ceph/mds_client.c | 12 ++++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index c7e91f53e4b6..eae177dd5bcf 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -460,6 +460,11 @@ static int ceph_readdir(struct file *file, struct =
dir_context *ctx)
> >               if (dfi->last_name) {
> >                       int len =3D strlen(dfi->last_name);
> >
> > +                     if (WARN_ON_ONCE(len > NAME_MAX)) {
> > +                             ceph_mdsc_put_request(req);
> > +                             ceph_blog_exit(&__ji);
> > +                             return -EIO;
> > +                     }
> >                       req->r_path2 =3D kzalloc(NAME_MAX + 1, GFP_KERNEL=
);
> >                       if (!req->r_path2) {
> >                               ceph_mdsc_put_request(req);
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 15df9d22008d..3c1ba94fc621 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -450,6 +450,8 @@ static int parse_reply_info_trace(void **p, void *e=
nd,
> >                       goto out_bad;
> >
> >               ceph_decode_32_safe(p, end, info->dname_len, bad);
> > +             if (info->dname_len > NAME_MAX)
> > +                     goto bad;
> >               ceph_decode_need(p, end, info->dname_len, bad);
> >               info->dname =3D *p;
> >               *p +=3D info->dname_len;
> > @@ -526,6 +528,11 @@ static int parse_reply_info_readdir(void **p, void=
 *end,
> >
> >               /* dentry */
> >               ceph_decode_32_safe(p, end, _name_len, bad);
> > +             if (_name_len > NAME_MAX) {
> > +                     pr_err_client(cl, "dir entry name too long (%u)\n=
",
> > +                                   _name_len);
> > +                     goto bad;
> > +             }
> >               ceph_decode_need(p, end, _name_len, bad);
> >               _name =3D *p;
> >               *p +=3D _name_len;
> > @@ -6332,6 +6339,11 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_se=
ssion *session,
> >       lease->seq =3D cpu_to_le32(seq);
> >
> >       spin_lock(&dentry->d_lock);
> > +     if (WARN_ON_ONCE(dentry->d_name.len > NAME_MAX)) {
> > +             spin_unlock(&dentry->d_lock);
> > +             ceph_msg_put(msg);
> > +             return;
> > +     }
> >       dir =3D d_inode(dentry->d_parent);
> >       lease->ino =3D cpu_to_le64(ceph_ino(dir));
> >       lease->first =3D lease->last =3D cpu_to_le64(ceph_snap(dir));
> >
> > ---
> > base-commit: 6a9830a8f414d3830c584782568d0233be969d09
> > change-id: 20261120-ceph-readdir-name-max-369df189af6e
> >
> > Best regards,
> > --
> > Xiubo Li <xiubo.li@clyso.com>
> >
> >
