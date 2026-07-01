Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FC2DF13B
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885787; cv=pass; b=dWiEj+wDwD1Cd+5px5uoWqhqV9wxeSt0BF4FCi8MtxNjQmQS5X44BiA79vW4w601wSV5ZQ8kB4bkUAGmMUWux2pCgz6b8qVwBz/pHLNo6k9Gm1RgBAQrwyPvWRhvt1PdrFd7GWQ5+PRyV8Pfl7AcvHmktib99nDzAkCIu40wrVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885787; c=relaxed/simple;
	bh=ii2Ovvmk+FgMf8xa6WQFuQJH12MHZCzQMAvYq811Z84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVjeW2w0/Ywj8CChvZ3D0t+qHTNv4DFPzc7WNj5RVaTxiecuaTfGc7LSI5H//4tNqKyDBt3Bv75CmXHo0BBLnnB+011Y0+JbD4wtlTG2Y3ASYO3Jdm+GPCkl99f4alq3Wklr80TVkLDBt1h/GyE40fpg6kkZYxxhJ4ECVNF1i6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DBRTR9rg; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DBRTR9rg"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so97631fac.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 23:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782885784; cv=none;
        d=google.com; s=arc-20260327;
        b=OBVvkdUUBxTtWcBDsB/aEDHgzsK+03zUUzgKH7+TrHy6hqin596DdrXxZzKCh7IaC1
         ZPJEetG1anUr/oNIr6za1HY45oVP+e6AUyrazfmJ1/qDymf/i819C9v//aKvCaCZIzhN
         DNnBSiBuD8nBSdkeoiuJQ2JBgqB4FddHhqy4M4hJ/jgXTRwvV3npgEThUfmz3nzsilLV
         +0eW+PcRiVRUY9+zbhdM9EAyHV/O0xM0oqp83LoD77uF+vlAYRPvpgVDDm7YuI4gTcU4
         Qd+JJBlcxwVPe+sSSj+aSIyinESxgJBtbOwv8yI2zvoQsf5BY6G6bmuRp5ocvk4jawqK
         X27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=urWfKwGcxwK3Z47RUlR4AeZM5LsrQTLduiz910KNLFw=;
        fh=I26i+SiPgE5o7QJ5ibjodr36Gmc4Idgy1nk+4jmfA9M=;
        b=rfpTr2QELREsi+Ps+HOnXQkIZzw9/1ji7Zc8Y6m0lDEBdqTMGEExUtiyu+DD7iSEAN
         fTxaSXCIMh6PgPOgoDAZmDqIeYEckIsXDKZ3n/QcbdFFZfrhWwC18ngW+Hk4kC+H1Ixj
         fGviU8VA7SZnfrnQygenZ3MpAgxTmJqHgzROILWjFCIlFnJBT7Vfll0uvotjWHwd+dro
         KDQKuil+If5UjH3H6yhGHTtJboBgf13N1IxJ89c117McYUztZ+5E/py9S5M2s/N/9glx
         8AEyOoGvNnGaVLyOWxZEKDabG5v8A5pqMZ6bczGmVQ/H96LDIc84J5bQgMQ6TQev+u+8
         V4lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1782885784; x=1783490584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urWfKwGcxwK3Z47RUlR4AeZM5LsrQTLduiz910KNLFw=;
        b=DBRTR9rgFmrvq9xvLTomVNjAaNLUqN8b643deB7MtZS/ku5kEE5ZmNcR7VTqjcYzY0
         h23i1ss+LudJmoiskJPPSOys4uhlymAb6kdvPBZM6dipQ+ugx704GvpGlum5aC6d82rx
         85USYE87ihFtefSHEoC03frs5V9PxLkBNnEXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885784; x=1783490584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urWfKwGcxwK3Z47RUlR4AeZM5LsrQTLduiz910KNLFw=;
        b=WPnMga/L55F2N5YGIfOwSv2gAWIVJeW6QSVaZk7WCWaioiBmbuiDlr51ix/uJygUB3
         9mEHlYRIGSD1CngB7Z98R4veMbCFId/OrhXJFG/shKlyu8fFScFBdO+3kGBHHdylr+UB
         rBKnAe6N6l0WHoX2+DsGirxAQbKGp8HtlajWE6tEDOEVwSnz4EXdOdxNEt2eWIm16RYV
         H1/sRvLZ+dqC4r6oK9DA3XZKk1ujgJO4JB29VJUurDaHHyg8yEovjdhzt49ngLrCYYTD
         1SgvtIhF5yaQ9aoaBcMKejyUJB6IhjOsjAMIXwY/UbpCUzNJ0P7lqt605JwTS7mgXRWB
         Hn9w==
X-Forwarded-Encrypted: i=1; AHgh+Rrl9fN2HWxpoahazUxn8+WfiUu3oMU94XrQUmt+KLsRwxLRAgXPfs7Ol074eOD1wg21tv1wfjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6li1/rWYYknWPjaCXvHZQyUwfrp/nzw9upPxL5cA+jCTMKsv
	Cz4p3tR24vHPvZxwXcMzi/LUqTyOr6Ot1ELz37xNfCpUqQzI+5sx3eBAVQ9RkjLq5v124f4YlPy
	KbSJFtJW8xSV9wt9CUZPqTKy9T04anauTyE+0LSOwkQ==
X-Gm-Gg: AfdE7ckwtFT+vXnVdJoyxV6NF1M0Fy4G+b9zDRql8NxBYInJRqlNJcSK4qCTlVoj/cU
	stE900aUF7d7FnP+SG9Tc/kiRzOUiJ/sDZJeV0GjNugYOUjc4m+k2Wevue1QaikaTVZMXkH7PV8
	HieE4dZ3Bpq278Qg2leWH7u0N/FKgrLkg2o0ggY1Azg6teZum8p2x2UfIyQbilmPLHRpOx/Sb/3
	ZkWmc/6HozvsVnazvuyU3yAHB2Oz2HoHpItjBPKtp2Chx4qXxs3rBQp9t812Q9goANlNm++0/nn
	cEbJfrFu+1sPxEJJdQk/kCeeeKrryQPEb+ONIwSUx3I=
X-Received: by 2002:a05:6871:6615:b0:448:b0bc:e63c with SMTP id
 586e51a60fabf-44cab982d70mr70174fac.25.1782885784398; Tue, 30 Jun 2026
 23:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611212710.5134-1-kylebot@openai.com> <4a0ad1fbf065b3d0bc0e3f1f2efbc44249181d03.camel@dubeyko.com>
In-Reply-To: <4a0ad1fbf065b3d0bc0e3f1f2efbc44249181d03.camel@dubeyko.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Wed, 1 Jul 2026 00:02:52 -0600
X-Gm-Features: AVVi8CfHZxpUzMycGiwegRVobrM33QDlg0eLpjrN9fL3Cdc7Vxe02DKkOm5Phog
Message-ID: <CAC7i46-V_aK=ZVVvQ_45_Sv==swzD0P0-FeqWbsbO4zACiv_9w@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: terminate xattr names before listing them
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com, 
	stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dae7d806558671c9"

--000000000000dae7d806558671c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

I just checked the report. It seems the issue has been patched on
master (https://github.com/torvalds/linux/commit/413466f3f0f84e7356da16c611=
afd69d2a0872e4),
but the corresponding patch is not backported to stable branches yet.
And you are right, zeroing strbuf on every iteration can fix the issue.

I just confirmed the issue on 6.12.94 and the same vulnerable pattern
seems to exist in 6.18.y as well.
The corresponding crash splash is attached.

I suggest to backport the patch to stable branches because it has
security implications.

Best,
Kyle

On Mon, Jun 29, 2026 at 5:18=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Thu, 2026-06-11 at 14:27 -0700, Kyle Zeng wrote:
> > hfsplus_uni2asc_xattr_str() returns the converted byte count but does
> > not
> > append a trailing NUL. hfsplus_listxattr() then passes the reusable
> > conversion buffer to string helpers such as can_list(), name_len(),
> > and
> > copy_name().
> >
> > If a shorter converted xattr name follows a longer one, stale bytes
> > after
> > the new byte count can make strscpy() fail with -E2BIG. The caller
> > adds
> > copy_name()'s return value to the running output offset, so a
> > negative
> > return can move the next write before the listxattr buffer.
> >
> > Explicitly terminate the converted name at the returned byte count
> > before
> > treating it as a C string.
> >
> > Fixes: 127e5f5ae51ef ("hfsplus: rework functionality of getting,
> > setting and deleting of extended attributes")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> >  fs/hfsplus/xattr.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index 452a1f9becb2..35fcbc397b62 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -870,6 +870,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry,
> > char *buffer, size_t size)
> >                       res =3D -EIO;
> >                       goto end_listxattr;
> >               }
> > +             strbuf[xattr_name_len] =3D '\0';
>
> The strbuf is allocated by kzalloc() [1] and it is zeroed on every
> iteration [2]. Are you really sure that this code is necessary? Can you
> reproduce any issue without your patch?
>
> Thanks,
> Slava.
>
> >
> >               if (!buffer || !size) {
> >                       if (can_list(strbuf))
>
> [1]
> https://elixir.bootlin.com/linux/v7.1/source/fs/hfsplus/xattr.c#L833
> [2]
> https://elixir.bootlin.com/linux/v7.1/source/fs/hfsplus/xattr.c#L891

--000000000000dae7d806558671c9
Content-Type: text/plain; charset="US-ASCII"; name="splash.txt"
Content-Disposition: attachment; filename="splash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr1o22kc0>
X-Attachment-Id: f_mr1o22kc0

WyAgMTE0LjgyODY2Nl0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ClsgIDExNC44Mjk1ODhdIEJVRzogS0FTQU46IHNsYWIt
b3V0LW9mLWJvdW5kcyBpbiBzdHJpbmcrMHgyZjcvMHgzMzAKWyAgMTE0LjgyOTU4OF0gV3JpdGUg
b2Ygc2l6ZSAxIGF0IGFkZHIgZmZmZjg4ODEwMTI3M2NhOCBieSB0YXNrIGV4cC81NDEKWyAgMTE0
LjgyOTU4OF0gClsgIDExNC44Mjk1ODhdIENQVTogMCBVSUQ6IDAgUElEOiA1NDEgQ29tbTogZXhw
IE5vdCB0YWludGVkIDYuMTIuOTQgIzEKWyAgMTE0LjgyOTU4OF0gSGFyZHdhcmUgbmFtZTogUUVN
VSBVYnVudHUgMjQuMDQgUEMgdjIgKGk0NDBGWCArIFBJSVgsIGFyY2hfY2FwcyBmaXgsIDE5OTYp
LCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNApbICAxMTQuODI5NTg4XSBD
YWxsIFRyYWNlOgpbICAxMTQuODI5NTg4XSAgPFRBU0s+ClsgIDExNC44Mjk1ODhdICBkdW1wX3N0
YWNrX2x2bCsweDY0LzB4ODAKWyAgMTE0LjgyOTU4OF0gIHByaW50X3JlcG9ydCsweGNlLzB4NjYw
ClsgIDExNC44Mjk1ODhdICA/IF9fcGZ4X19yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgxMC8weDEw
ClsgIDExNC44Mjk1ODhdICA/IF9fcGZ4X3VuaTJjaGFyKzB4MTAvMHgxMApbICAxMTQuODI5NTg4
XSAgPyBzdHJpbmcrMHgyZjcvMHgzMzAKWyAgMTE0LjgyOTU4OF0gIGthc2FuX3JlcG9ydCsweGM2
LzB4MTAwClsgIDExNC44Mjk1ODhdICA/IHN0cmluZysweDJmNy8weDMzMApbICAxMTQuODI5NTg4
XSAgc3RyaW5nKzB4MmY3LzB4MzMwClsgIDExNC44Mjk1ODhdICA/IF9fcGZ4X3N0cmluZysweDEw
LzB4MTAKWyAgMTE0LjgyOTU4OF0gID8gX194NjRfc3lzX2ZsaXN0eGF0dHIrMHgxMmIvMHgxYzAK
WyAgMTE0LjgyOTU4OF0gIHZzbnByaW50ZisweDVlYy8weDE2ODAKWyAgMTE0LjgyOTU4OF0gID8g
X19wZnhfdnNucHJpbnRmKzB4MTAvMHgxMApbICAxMTQuODI5NTg4XSAgPyBoZnNwbHVzX2Jub2Rl
X3JlYWRfdTE2KzB4NzEvMHhhMApbICAxMTQuODI5NTg4XSAgPyBfX2FzYW5fbWVtY3B5KzB4M2Mv
MHg2MApbICAxMTQuODI5NTg4XSAgc2NucHJpbnRmKzB4YjUvMHgxMTAKWyAgMTE0LjgyOTU4OF0g
ID8gX19wZnhfc2NucHJpbnRmKzB4MTAvMHgxMApbICAxMTQuODI5NTg4XSAgPyB1bmkyY2hhcisw
eDE5LzB4NzAKWyAgMTE0LjgyOTU4OF0gID8gaGZzcGx1c191bmkyYXNjKzB4MjlmLzB4OWUwClsg
IDExNC44Mjk1ODhdICA/IF9fcGZ4X3VuaTJjaGFyKzB4MTAvMHgxMApbICAxMTQuODI5NTg4XSAg
Y29weV9uYW1lKzB4NjIvMHg3MApbICAxMTQuODI5NTg4XSAgaGZzcGx1c19saXN0eGF0dHIrMHg0
YTgvMHhiYjAKWyAgMTE0LjgyOTU4OF0gID8gX19wZnhfaGZzcGx1c19saXN0eGF0dHIrMHgxMC8w
eDEwClsgIDExNC44Mjk1ODhdICA/IF9fa2FzYW5fa21hbGxvYysweDhmLzB4YTAKWyAgMTE0Ljgy
OTU4OF0gID8gX19rbWFsbG9jX25vZGVfbm9wcm9mKzB4MTlhLzB4NDYwClsgIDExNC44Mjk1ODhd
ICA/IGxpc3R4YXR0cisweDQyLzB4ZjAKWyAgMTE0LjgyOTU4OF0gID8gX194NjRfc3lzX2ZsaXN0
eGF0dHIrMHgxMmIvMHgxYzAKWyAgMTE0LjgyOTU4OF0gID8gZG9fc3lzY2FsbF82NCsweDU4LzB4
MTIwClsgIDExNC44Mjk1ODhdICA/IGthc2FuX3NhdmVfdHJhY2srMHgxNC8weDMwClsgIDExNC44
Mjk1ODhdICA/IF9fa21hbGxvY19ub2RlX25vcHJvZisweDE5YS8weDQ2MApbICAxMTQuODI5NTg4
XSAgPyBsaXN0eGF0dHIrMHg0Mi8weGYwClsgIDExNC44Mjk1ODhdICA/IHNlY3VyaXR5X2lub2Rl
X2xpc3R4YXR0cisweGQwLzB4MTQwClsgIDExNC44Mjk1ODhdICBsaXN0eGF0dHIrMHg1Yy8weGYw
ClsgIDExNC44Mjk1ODhdICBfX3g2NF9zeXNfZmxpc3R4YXR0cisweDEyYi8weDFjMApbICAxMTQu
ODI5NTg4XSAgPyBhcmNoX2V4aXRfdG9fdXNlcl9tb2RlX3ByZXBhcmUuaXNyYS4wKzB4YmQvMHhl
MApbICAxMTQuODI5NTg4XSAgZG9fc3lzY2FsbF82NCsweDU4LzB4MTIwClsgIDExNC44Mjk1ODhd
ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlClsgIDExNC44Mjk1ODhd
IFJJUDogMDAzMzoweDQyZGQ0YgpbICAxMTQuODI5NTg4XSBDb2RlOiBjNyBjMCBiOCBmZiBmZiBm
ZiA2NCBjNyAwMCAwYyAwMCAwMCAwMCBiOCBmZiBmZiBmZiBmZiBjMyA2NiAyZSAwZiAxZiA4NCAw
MCAwMCAwMCAwMCAwMCA2NiA5MCBmMyAwZiAxZSBmYSBiOCBjNCAwMCAwMCAwMCAwZiAwNSA8NDg+
IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGI4IGZmIGZmIGZmIGY3IGQ4IDY0IDg5
IDAxIDQ4ClsgIDExNC44Mjk1ODhdIFJTUDogMDAyYjowMDAwN2ZmZTYwMGM5ZmE4IEVGTEFHUzog
MDAwMDAyMDcgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwYzQKWyAgMTE0LjgyOTU4OF0gUkFYOiBm
ZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDA0MmRk
NGIKWyAgMTE0LjgyOTU4OF0gUkRYOiAwMDAwMDAwMDAwMDAwMDIwIFJTSTogMDAwMDdmZmU2MDBj
OWZjMCBSREk6IDAwMDAwMDAwMDAwMDAwMDUKWyAgMTE0LjgyOTU4OF0gUkJQOiAwMDAwN2ZmZTYw
MGM5ZmYwIFIwODogMDAwMDdmZmU2MDBjYTcwOCBSMDk6IDAwMDAwMDAwMDAwMDAwMTAKWyAgMTE0
LjgyOTU4OF0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDIwNyBSMTI6
IDAwMDA3ZmZlNjAwZDMwNTgKWyAgMTE0LjgyOTU4OF0gUjEzOiAwMDAwN2ZmZTYwMGQzMDY4IFIx
NDogMDAwMDAwMDAwMDRkNDgwOCBSMTU6IDAwMDAwMDAwMDAwMDAwMDEKWyAgMTE0LjgyOTU4OF0g
IDwvVEFTSz4KWyAgMTE0LjgyOTU4OF0gClsgIDExNC44Mjk1ODhdIEFsbG9jYXRlZCBieSB0YXNr
IDE6ClsgIDExNC44Mjk1ODhdICBrYXNhbl9zYXZlX3N0YWNrKzB4MzMvMHg2MApbICAxMTQuODI5
NTg4XSAga2FzYW5fc2F2ZV90cmFjaysweDE0LzB4MzAKWyAgMTE0LjgyOTU4OF0gIF9fa2FzYW5f
a21hbGxvYysweDhmLzB4YTAKWyAgMTE0LjgyOTU4OF0gIGFjcGlfYmluZF9vbmUrMHgxNTQvMHg2
ZjAKWyAgMTE0LjgyOTU4OF0gIGFjcGlfZGV2aWNlX25vdGlmeSsweDE3LzB4MjYwClsgIDExNC44
Mjk1ODhdICBkZXZpY2VfYWRkKzB4MjJhLzB4MTQ5MApbICAxMTQuODI5NTg4XSAgY29udGFpbmVy
X2RldmljZV9hdHRhY2grMHgxNzAvMHgyNTAKWyAgMTE0LjgyOTU4OF0gIGFjcGlfYnVzX2F0dGFj
aCsweDRmOS8weGE1MApbICAxMTQuODI5NTg4XSAgZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKzB4Zjkv
MHgxNzAKWyAgMTE0LjgyOTU4OF0gIGFjcGlfZGV2X2Zvcl9lYWNoX2NoaWxkKzB4N2IvMHhiMApb
ICAxMTQuODI5NTg4XSAgYWNwaV9idXNfYXR0YWNoKzB4NzMzLzB4YTUwClsgIDExNC44Mjk1ODhd
ICBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHhmOS8weDE3MApbICAxMTQuODI5NTg4XSAgYWNwaV9k
ZXZfZm9yX2VhY2hfY2hpbGQrMHg3Yi8weGIwClsgIDExNC44Mjk1ODhdICBhY3BpX2J1c19hdHRh
Y2grMHg3MzMvMHhhNTAKWyAgMTE0LjgyOTU4OF0gIGRldmljZV9mb3JfZWFjaF9jaGlsZCsweGY5
LzB4MTcwClsgIDExNC44Mjk1ODhdICBhY3BpX2Rldl9mb3JfZWFjaF9jaGlsZCsweDdiLzB4YjAK
WyAgMTE0LjgyOTU4OF0gIGFjcGlfYnVzX2F0dGFjaCsweDczMy8weGE1MApbICAxMTQuODI5NTg4
XSAgYWNwaV9idXNfc2NhbisweGMxLzB4NDQwClsgIDExNC44Mjk1ODhdICBhY3BpX3NjYW5faW5p
dCsweDFlNi8weDY0MApbICAxMTQuODI5NTg4XSAgYWNwaV9pbml0KzB4Mzg1LzB4OGYwClsgIDEx
NC44Mjk1ODhdICBkb19vbmVfaW5pdGNhbGwrMHhiMS8weDM3MApbICAxMTQuODI5NTg4XSAga2Vy
bmVsX2luaXRfZnJlZWFibGUrMHg0OTQvMHg3YTAKWyAgMTE0LjgyOTU4OF0gIGtlcm5lbF9pbml0
KzB4MWYvMHgxZTAKWyAgMTE0LjgyOTU4OF0gIHJldF9mcm9tX2ZvcmsrMHgzNC8weDcwClsgIDEx
NC44Mjk1ODhdICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAKWyAgMTE0LjgyOTU4OF0gClsg
IDExNC44Mjk1ODhdIFNlY29uZCB0byBsYXN0IHBvdGVudGlhbGx5IHJlbGF0ZWQgd29yayBjcmVh
dGlvbjoKWyAgMTE0LjgyOTU4OF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0t
ClsgIDExNC44Mjk1ODhdIHBvb2wgaW5kZXggLTEgb3V0IG9mIGJvdW5kcyAoMjM3KSBmb3Igc3Rh
Y2sgaWQgNzUwMDAwMDAKWyAgMTE0LjgyOTU4OF0gV0FSTklORzogQ1BVOiAwIFBJRDogNTQxIGF0
IGxpYi9zdGFja2RlcG90LmM6NDUxIGRlcG90X2ZldGNoX3N0YWNrKzB4NWEvMHg4MApbICAxMTQu
ODI5NTg4XSBNb2R1bGVzIGxpbmtlZCBpbjoKWyAgMTE0LjgyOTU4OF0gQ1BVOiAwIFVJRDogMCBQ
SUQ6IDU0MSBDb21tOiBleHAgTm90IHRhaW50ZWQgNi4xMi45NCAjMQpbICAxMTQuODI5NTg4XSBI
YXJkd2FyZSBuYW1lOiBRRU1VIFVidW50dSAyNC4wNCBQQyB2MiAoaTQ0MEZYICsgUElJWCwgYXJj
aF9jYXBzIGZpeCwgMTk5NiksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8yMDE0
ClsgIDExNC44Mjk1ODhdIFJJUDogMDAxMDpkZXBvdF9mZXRjaF9zdGFjaysweDVhLzB4ODAKWyAg
MTE0LjgyOTU4OF0gQ29kZTogMDQgZWQgODAgNDkgMTIgOGEgNDggODUgYzAgNzQgMjUgNDggMDEg
ZDggOGIgNTAgMWMgODUgZDIgNzQgMjEgNWIgNWQgYzMgY2MgY2MgY2MgY2MgODkgZjkgNDggYzcg
YzcgNTAgNTAgNTcgODcgZTggYzYgNjUgZTIgZmQgPDBmPiAwYiAzMSBjMCBlYiBlNSAwZiAwYiAz
MSBjMCBlYiBkZiAwZiAwYiAzMSBjMCBlYiBkOSA0OCA4OSBlZSA0OApbICAxMTQuODI5NTg4XSBS
U1A6IDAwMTg6ZmZmZmM5MDAwMTQzZjdiMCBFRkxBR1M6IDAwMDAwMDgyClsgIDExNC44Mjk1ODhd
IFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDI4MDAgUkNYOiAwMDAwMDAw
MDAwMDAwMDI3ClsgIDExNC44Mjk1ODhdIFJEWDogMDAwMDAwMDAwMDAwMDAyNyBSU0k6IDAwMDAw
MDAwMDAwMDAwMDQgUkRJOiBmZmZmODg4MTFhYTMxYTA4ClsgIDExNC44Mjk1ODhdIFJCUDogZmZm
Zjg4ODEwMTI3M2NhOCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmZWQxMDIzNTQ2MzQx
ClsgIDExNC44Mjk1ODhdIFIxMDogZmZmZjg4ODExYWEzMWEwYiBSMTE6IDAwMDAwMDAwMDAwMDAw
MDEgUjEyOiBmZmZmZWEwMDA0MDQ5Y2MwClsgIDExNC44Mjk1ODhdIFIxMzogZmZmZjg4ODEwNGU3
YTAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDEgUjE1OiAwMDAwMDAwMDAwMDAwMDZmClsgIDExNC44
Mjk1ODhdIEZTOiAgMDAwMDAwMDAzMTIxZjNjMCgwMDAwKSBHUzpmZmZmODg4MTFhYTAwMDAwKDAw
MDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgMTE0LjgyOTU4OF0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICAxMTQuODI5NTg4XSBDUjI6IDAw
MDAwMDAwMDA0ZGMwZDAgQ1IzOiAwMDAwMDAwMTExMWNhMDAwIENSNDogMDAwMDAwMDAwMDAwMDZm
MApbICAxMTQuODI5NTg4XSBDYWxsIFRyYWNlOgpbICAxMTQuODI5NTg4XSAgPFRBU0s+ClsgIDEx
NC44Mjk1ODhdICBzdGFja19kZXBvdF9wcmludCsweDFiLzB4NTAKWyAgMTE0LjgyOTU4OF0gIGth
c2FuX3ByaW50X2F1eF9zdGFja3MrMHgzYS8weDcwClsgIDExNC44Mjk1ODhdICBwcmludF9yZXBv
cnQrMHgxMTcvMHg2NjAKWyAgMTE0LjgyOTU4OF0gID8gX19wZnhfX3Jhd19zcGluX2xvY2tfaXJx
c2F2ZSsweDEwLzB4MTAKWyAgMTE0LjgyOTU4OF0gID8gX19wZnhfdW5pMmNoYXIrMHgxMC8weDEw
ClsgIDExNC44Mjk1ODhdICA/IHN0cmluZysweDJmNy8weDMzMApbICAxMTQuODI5NTg4XSAga2Fz
YW5fcmVwb3J0KzB4YzYvMHgxMDAKWyAgMTE0LjgyOTU4OF0gID8gc3RyaW5nKzB4MmY3LzB4MzMw
ClsgIDExNC44Mjk1ODhdICBzdHJpbmcrMHgyZjcvMHgzMzAKWyAgMTE0LjgyOTU4OF0gID8gX19w
Znhfc3RyaW5nKzB4MTAvMHgxMApbICAxMTQuODI5NTg4XSAgPyBfX3g2NF9zeXNfZmxpc3R4YXR0
cisweDEyYi8weDFjMApbICAxMTQuODI5NTg4XSAgdnNucHJpbnRmKzB4NWVjLzB4MTY4MApbICAx
MTQuODI5NTg4XSAgPyBfX3BmeF92c25wcmludGYrMHgxMC8weDEwClsgIDExNC44Mjk1ODhdICA/
IGhmc3BsdXNfYm5vZGVfcmVhZF91MTYrMHg3MS8weGEwClsgIDExNC44Mjk1ODhdICA/IF9fYXNh
bl9tZW1jcHkrMHgzYy8weDYwClsgIDExNC44Mjk1ODhdICBzY25wcmludGYrMHhiNS8weDExMApb
ICAxMTQuODI5NTg4XSAgPyBfX3BmeF9zY25wcmludGYrMHgxMC8weDEwClsgIDExNC44Mjk1ODhd
ICA/IHVuaTJjaGFyKzB4MTkvMHg3MApbICAxMTQuODI5NTg4XSAgPyBoZnNwbHVzX3VuaTJhc2Mr
MHgyOWYvMHg5ZTAKWyAgMTE0LjgyOTU4OF0gID8gX19wZnhfdW5pMmNoYXIrMHgxMC8weDEwClsg
IDExNC44Mjk1ODhdICBjb3B5X25hbWUrMHg2Mi8weDcwClsgIDExNC44Mjk1ODhdICBoZnNwbHVz
X2xpc3R4YXR0cisweDRhOC8weGJiMApbICAxMTQuODI5NTg4XSAgPyBfX3BmeF9oZnNwbHVzX2xp
c3R4YXR0cisweDEwLzB4MTAKWyAgMTE0LjgyOTU4OF0gID8gX19rYXNhbl9rbWFsbG9jKzB4OGYv
MHhhMApbICAxMTQuODI5NTg4XSAgPyBfX2ttYWxsb2Nfbm9kZV9ub3Byb2YrMHgxOWEvMHg0NjAK
WyAgMTE0LjgyOTU4OF0gID8gbGlzdHhhdHRyKzB4NDIvMHhmMApbICAxMTQuODI5NTg4XSAgPyBf
X3g2NF9zeXNfZmxpc3R4YXR0cisweDEyYi8weDFjMApbICAxMTQuODI5NTg4XSAgPyBkb19zeXNj
YWxsXzY0KzB4NTgvMHgxMjAKWyAgMTE0LjgyOTU4OF0gID8ga2FzYW5fc2F2ZV90cmFjaysweDE0
LzB4MzAKWyAgMTE0LjgyOTU4OF0gID8gX19rbWFsbG9jX25vZGVfbm9wcm9mKzB4MTlhLzB4NDYw
ClsgIDExNC44Mjk1ODhdICA/IGxpc3R4YXR0cisweDQyLzB4ZjAKWyAgMTE0LjgyOTU4OF0gID8g
c2VjdXJpdHlfaW5vZGVfbGlzdHhhdHRyKzB4ZDAvMHgxNDAKWyAgMTE0LjgyOTU4OF0gIGxpc3R4
YXR0cisweDVjLzB4ZjAKWyAgMTE0LjgyOTU4OF0gIF9feDY0X3N5c19mbGlzdHhhdHRyKzB4MTJi
LzB4MWMwClsgIDExNC44Mjk1ODhdICA/IGFyY2hfZXhpdF90b191c2VyX21vZGVfcHJlcGFyZS5p
c3JhLjArMHhiZC8weGUwClsgIDExNC44Mjk1ODhdICBkb19zeXNjYWxsXzY0KzB4NTgvMHgxMjAK
WyAgMTE0LjgyOTU4OF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UK
WyAgMTE0LjgyOTU4OF0gUklQOiAwMDMzOjB4NDJkZDRiClsgIDExNC44Mjk1ODhdIENvZGU6IGM3
IGMwIGI4IGZmIGZmIGZmIDY0IGM3IDAwIDBjIDAwIDAwIDAwIGI4IGZmIGZmIGZmIGZmIGMzIDY2
IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDY2IDkwIGYzIDBmIDFlIGZhIGI4IGM0IDAwIDAw
IDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcgYzEgYjggZmYgZmYg
ZmYgZjcgZDggNjQgODkgMDEgNDgKWyAgMTE0LjgyOTU4OF0gUlNQOiAwMDJiOjAwMDA3ZmZlNjAw
YzlmYTggRUZMQUdTOiAwMDAwMDIwNyBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBjNApbICAxMTQu
ODI5NTg4XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDog
MDAwMDAwMDAwMDQyZGQ0YgpbICAxMTQuODI5NTg4XSBSRFg6IDAwMDAwMDAwMDAwMDAwMjAgUlNJ
OiAwMDAwN2ZmZTYwMGM5ZmMwIFJESTogMDAwMDAwMDAwMDAwMDAwNQpbICAxMTQuODI5NTg4XSBS
QlA6IDAwMDA3ZmZlNjAwYzlmZjAgUjA4OiAwMDAwN2ZmZTYwMGNhNzA4IFIwOTogMDAwMDAwMDAw
MDAwMDAxMApbICAxMTQuODI5NTg4XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAw
MDAwMDAwMjA3IFIxMjogMDAwMDdmZmU2MDBkMzA1OApbICAxMTQuODI5NTg4XSBSMTM6IDAwMDA3
ZmZlNjAwZDMwNjggUjE0OiAwMDAwMDAwMDAwNGQ0ODA4IFIxNTogMDAwMDAwMDAwMDAwMDAwMQpb
ICAxMTQuODI5NTg4XSAgPC9UQVNLPgpbICAxMTQuODI5NTg4XSAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0KWyAgMTE0LjgyOTU4OF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBd
LS0tLS0tLS0tLS0tClsgIDExNC44Mjk1ODhdIGNvcnJ1cHQgaGFuZGxlIG9yIHVzZSBhZnRlciBz
dGFja19kZXBvdF9wdXQoKQpbICAxMTQuODI5NTg4XSBXQVJOSU5HOiBDUFU6IDAgUElEOiA1NDEg
YXQgbGliL3N0YWNrZGVwb3QuYzo3MTkgc3RhY2tfZGVwb3RfcHJpbnQrMHgzZS8weDUwClsgIDEx
NC44Mjk1ODhdIE1vZHVsZXMgbGlua2VkIGluOgpbICAxMTQuODI5NTg4XSBDUFU6IDAgVUlEOiAw
IFBJRDogNTQxIENvbW06IGV4cCBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgIDYuMTIuOTQg
IzEKWyAgMTE0LjgyOTU4OF0gVGFpbnRlZDogW1ddPVdBUk4KWyAgMTE0LjgyOTU4OF0gSGFyZHdh
cmUgbmFtZTogUUVNVSBVYnVudHUgMjQuMDQgUEMgdjIgKGk0NDBGWCArIFBJSVgsIGFyY2hfY2Fw
cyBmaXgsIDE5OTYpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNApbICAx
MTQuODI5NTg4XSBSSVA6IDAwMTA6c3RhY2tfZGVwb3RfcHJpbnQrMHgzZS8weDUwClsgIDExNC44
Mjk1ODhdIENvZGU6IGNjIGNjIGU4IDc1IGZjIGZmIGZmIDQ4IDg1IGMwIDc0IDEyIDhiIDcwIDE0
IDQ4IDhkIDc4IDIwIDg1IGY2IDc0IDFhIDMxIGQyIGU5IDVlIDI2IDA2IGZlIDQ4IGM3IGM3IDg4
IDUwIDU3IDg3IGU4IDcyIDYyIGUyIGZkIDwwZj4gMGIgYzMgY2MgY2MgY2MgY2MgYzMgY2MgY2Mg
Y2MgY2MgNjYgMGYgMWYgNDQgMDAgMDAgOTAgOTAgOTAgOTAKWyAgMTE0LjgyOTU4OF0gUlNQOiAw
MDE4OmZmZmZjOTAwMDE0M2Y3YzggRUZMQUdTOiAwMDAwMDA4MgpbICAxMTQuODI5NTg4XSBSQVg6
IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmODg4MTAxMjczY2EwIFJDWDogMDAwMDAwMDAwMDAw
MDAyNwpbICAxMTQuODI5NTg4XSBSRFg6IDAwMDAwMDAwMDAwMDAwMjcgUlNJOiAwMDAwMDAwMDAw
MDAwMDA0IFJESTogZmZmZjg4ODExYWEzMWEwOApbICAxMTQuODI5NTg4XSBSQlA6IGZmZmY4ODgx
MDEyNzNjYTggUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogZmZmZmVkMTAyMzU0NjM0MQpbICAx
MTQuODI5NTg4XSBSMTA6IGZmZmY4ODgxMWFhMzFhMGIgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIx
MjogZmZmZmVhMDAwNDA0OWNjMApbICAxMTQuODI5NTg4XSBSMTM6IGZmZmY4ODgxMDRlN2EwMDAg
UjE0OiAwMDAwMDAwMDAwMDAwMDAxIFIxNTogMDAwMDAwMDAwMDAwMDA2ZgpbICAxMTQuODI5NTg4
XSBGUzogIDAwMDAwMDAwMzEyMWYzYzAoMDAwMCkgR1M6ZmZmZjg4ODExYWEwMDAwMCgwMDAwKSBr
bmxHUzowMDAwMDAwMDAwMDAwMDAwClsgIDExNC44Mjk1ODhdIENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKWyAgMTE0LjgyOTU4OF0gQ1IyOiAwMDAwMDAw
MDAwNGRjMGQwIENSMzogMDAwMDAwMDExMTFjYTAwMCBDUjQ6IDAwMDAwMDAwMDAwMDA2ZjAKWyAg
MTE0LjgyOTU4OF0gQ2FsbCBUcmFjZToKWyAgMTE0LjgyOTU4OF0gIDxUQVNLPgpbICAxMTQuODI5
NTg4XSAga2FzYW5fcHJpbnRfYXV4X3N0YWNrcysweDNhLzB4NzAKWyAgMTE0LjgyOTU4OF0gIHBy
aW50X3JlcG9ydCsweDExNy8weDY2MApbICAxMTQuODI5NTg4XSAgPyBfX3BmeF9fcmF3X3NwaW5f
bG9ja19pcnFzYXZlKzB4MTAvMHgxMApbICAxMTQuODI5NTg4XSAgPyBfX3BmeF91bmkyY2hhcisw
eDEwLzB4MTAKWyAgMTE0LjgyOTU4OF0gID8gc3RyaW5nKzB4MmY3LzB4MzMwCgoK
--000000000000dae7d806558671c9--
