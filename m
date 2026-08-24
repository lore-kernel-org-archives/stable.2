Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3011364049
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583729; cv=pass; b=HSRVlGWkcMm/fgNwSPD0HTl3hzHDxznylBdcdmclLzjPAUpMRYpXUuzAlE77dkN9rlhmVv1VGIwjghCORLmTTZQS075U/5VfzPkUaxsktQYO8NKKHINCRg5nuC6O/wRUlT9UNmD3HFEgxxYR2DQXebR13rGV1lDKCunsOdops90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583729; c=relaxed/simple;
	bh=8htVseq9wQKiK0UE4dDd9JnlLWJaYWLtXE9iyBFW9As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzO5BKEZprJED4OmbB5IGGt8Z/egBPKl5CmD3gRfS1n0It7dIy8Ocposqo5AhhPFGvxiiRGTT55gvGCwadxbn2ibhONqsz+uh2zaJ8IYzd6c/az2xQU4EXwySG4xwyOvS1KxuHQfKya9LHmm+DaG8KQIH/+a28aVjRRxkvWFrxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqHDnuj1; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqHDnuj1"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c744a00edso2212719d50.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787583725; cv=none;
        d=google.com; s=arc-20260327;
        b=i7uCT5hplz/B/NqpefP082lsROzUuTUKfvac3puEP/AldDkFe2kjwUR1U2zSGB8TpE
         wStyWhMWmI2Jwqb1KuDfg2jpu08J0mkXwytfa8M+SCiOUk/lRhDFSuDkU8nN7vVnNvQP
         kl6ZqQeEhNuQ7iKKmIxEN6cgEl2MGcWsvG78zZ6VWqxn+/WZkoW1pwvMoppR++N9z1rW
         Oa5+IxI4ssMz3oo6old0jiSOzzRdGnNBQDWTjoW4Tkq3bbFs7/N9yq+b1OK/CFTnzewR
         LQqgzg/iTP7vxC3j/GEDlvRCvCjEPmjdMc0ICYYTYxLIJ73+JzveMxUKKxgn05fwVme/
         mZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0FEMUJZQVmX93REvnJ4GsWEzwIniTrdgUugr/eES0z8=;
        fh=l43FHkixZtK4wX3MJiCTPK53fYUXyiSGBonlDLKDY5U=;
        b=Pm7xp8b3CWbaPe9xf46b/kXu+5XZe6aVdNVHP1K1ragruBg+F2z7arSIUVJ2JPvZgv
         hRW4DIhoNpfYe5Y1lj5dlCPCMcnS5ZgGTFDyT+YFWrvgTQnXy2gBI+4nE33if4HoO5SM
         qXXB3UhkDlPBlHHmInkLS49SXkFOWmVmgnYRjF0twcFGcJqOGVtM1h38mdQV8vcQgdkk
         LM66rZXsoeICsTFvd3qkr0+GOdaSSWz7gx1jUD1kw80qhBryP90nFfq7HRgscdYfIUwT
         aUyPg1kvYaktMy+QV/2tZQRQbc8ka7pSmsl51X7/YIol8dJIk85A/gg2oEXqVHWoZcoK
         Ewyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583725; x=1788188525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0FEMUJZQVmX93REvnJ4GsWEzwIniTrdgUugr/eES0z8=;
        b=NqHDnuj1+lxh0iGUTQGJA9oo5OwqwV8EOiXupnKHSIx287Jyavh3kUuZeArCV5tXqi
         nP9vfhoeIqQr2lGwF1mMBDkIGS7tbIggAFCthuJMtAqiYIIXGVZfhtm5LIgpKNb5/udZ
         r4sd5PmCa5To+qIdLgSJb14tfEa6Jvp9bcxGBivYE3EBB8s7PeDMtPkzWmveRIGObbE8
         8x+mhjAxPLPQ9B5zoZLfi2cLis2bXpPk9wfMqI2gXgYUw5ha3mYCD9fxw+HUNVSaKWTd
         Uyw5aYtGUvRhZAtJa2yE7QA9Dhhb6k3kxb1gVexU0k7NfXvUVqEh6chzQSbK1tFSS/9U
         jHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583725; x=1788188525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0FEMUJZQVmX93REvnJ4GsWEzwIniTrdgUugr/eES0z8=;
        b=S5/1viguuAcr9W67KQXEGYPGnoCo9e08FMsZ9mCzhV8jAqbsj2KH33RH8PFltmiuwj
         QtkBLv23UVbGzQXzHMw24cVLOGg1BxIkQtSld5sFr8+bkQFnhVIloTLsGFLVRzqiAvH7
         VBxLmr6DUkRtqfi2PNepYfBjlZiWoN85NYeGdPE/zZcAqaI+MDlfanxXQtp9mbDL+c2C
         TaYVwvwjNFCmMe0yiPj9erCQ4kmdvrNnazPr9vcAUQMhG28fEql81307TMB22hq6nJZ8
         MRKJVBYYavL0nomvvUPdyfqQlP7df1zUZXoubn7QpMfT711vmurOmIYT+wO4PzjQMeva
         p9yw==
X-Forwarded-Encrypted: i=1; AHgh+RolBOGEKteWoz5tDwFG3M6nROENDkCf0EKM/O62Ej8GZ6nXnTP+I0anPbC8wrXoAxoP2MbKRUM=@vger.kernel.org
X-Gm-Message-State: AFuF++lNl7ld9JXJylHhxGGwE7E7HFyjrHqoTz+IrBa84QL0IF+yuEN9
	ANVU90YyckiInTAqqf0YDv/gY8gyJT1jxILx7IGPH3nUax4W7K/xdbd08QOMw6Au0dfAskBg0Ba
	LaXjn0LJBGWGXiz8pR687HDNY8ujYyg9V1EwtLvRSapoA
X-Gm-Gg: AR+sD13YEn7ENYBjU8kplM7DZza7KuFnJjnFWBvTKoeTUmdzWaqObHhh4IypwGIpnI5
	Qlo8VBg6DDJTnfXY7BM62A/UDoNHteppsH8DkRqFRDskE1zW6Fq+rbZN8VOZE5/GUt6ox/Krq59
	9aeIRtCCx9eDLRiC+YL9pA5Wd6Z4a3hXMVuLDrRuvOpnUffX5kLZy7s/suYD+8ZEjtd3nXRbmxP
	b+EwE59E9E6VLvtmGVqIY6O9XFxYohhAWtAZP1EGFvbJBSDSrDlEqPR/LAi6+9h9eiuqaidcWvI
	TEY6ZrIZn8SYMZ2VOxXZnuEIULFePC44qUpFRc3rq0UcBefWlrtzDQVeXhMgsnKBxoM4+fIe1MV
	WSNIKEADYa9Nvd5+MAdO1MT7zqiNV
X-Received: by 2002:a05:690e:4086:b0:66d:bc2:8067 with SMTP id
 956f58d0204a3-66d0bc28453mr1305222d50.42.1787583724407; Mon, 24 Aug 2026
 08:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
 <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com> <20260824144051.50010-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260824144051.50010-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 11:01:52 -0400
X-Gm-Features: AcwNN1Wa_Sx4KTo6DQHVJ-mtw5XFv-5Ba7tmLh-coqhcOdt0jH_gninJBULA00A
Message-ID: <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Mon, Aug 24, 2026 at 10:40=E2=80=AFAM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> Hi Luiz,
>
> You are right that sizeof(*vnd_codecs) and
> sizeof(vnd_codecs->num) are both one byte here.  The issue is the order
> in which the existing check performs the access: vnd_codecs->num must
> be evaluated as the count argument to flex_array_size() before the
> result can be compared with skb->len.
>
> For example, consider a V1 reply containing exactly these three bytes:
>
>         status =3D 0, std_codecs->num =3D 1, std_codecs->codec[0]
>
> It passes the initial sizeof(*rp) check.  After pulling the status byte,
> the standard codec length check also passes, and pulling that array
> leaves skb->len equal to zero.  The existing vendor length check then
> evaluates vnd_codecs->num with vnd_codecs pointing at the end of the
> skb data.
>
> The added check uses sizeof(), whose operand is not evaluated, to make
> sure the count byte is present before the following expression reads
> vnd_codecs->num.  The V2 parser has the same ordering issue.

So you are saying flex_array_size being performed before size_of would
matter? Afaike flex_array_size doesn't acuatually access the
vnd_codecs pointer, it just calculate the array size based on the it
size:

#define flex_array_size(p, member, count) \
__builtin_choose_expr(__is_constexpr(count), \
(count) * sizeof(*(p)->member) + __must_be_array((p)->member), \
size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))

Same thing as to sizeof(vnd_codecs->num) that would be evaluated to 1
at build time, so it doesn't generate an access to vnd_codecs at
runtime, maybe it would have been better to change it to
sizeof(*vnd_codecs) if that causes less confusion.

--=20
Luiz Augusto von Dentz
