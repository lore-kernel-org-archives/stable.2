Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793715191;
	b=NKxPsJyiyLaIKW1xHdblJQKQQOpruc2rXcz7Boveoz+3uKvYfLLCae+aAm80KjS6OPqp
	 yjvSBXwgS29pYdGeeBMwHiEWynkifQbU8rrGcF7HuMUCfndPoacW9kSt0t/EspiJRgdm7
	 T8iMtVv/BHtFgEooRL/UJMJH4+am6VbF/SVoy/DE/3QOzk2vq8AoXDknbyl/HCCH9Elcj
	 C5uiqYYt8RzhXbwGUBJwaXpLQQCFOYXCetY2QEv+bX2zdYmCKn2BCqZSTPo5rXE5SMhFg
	 Po2eMmLIMGOTPpwwZPTblDEpD7N0yY8JvwWsJJ73IQ+6QJ3dBJdk6A1YlzDQrKEny4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HL04h1yc9M4hwxY/BxNlJ65GkcTfjvC+va5ivgCWeBs=;
	b=tEHAJk/6c5hi1K/at4DLxZGKZv+U0wl5Koui6oWbbJTOMSLMXBNCXCagEcOchG8Bv/58
	 Tg0sUAlQ9DCSOEhIHrIvFlEMLsgOvoL7cyNryd4ZqFXNyQSYEkoH99fXJpeMNzyri4UaI
	 o6dZ4yVaNZsQEhwonfPwUfS+8sek/zVz33DHczKv9EaLI0wxYKHIO2qos5VWfG+NHLqJe
	 qXHyDtIYqyAsCcYNVLUKO+RWtCjgh9obQNrJUxYVPNFOpPW/UVXyQhiUuO4a+XBr8hcAW
	 Dt7dYnHe3aKyGtBh9WfjA04vmf4E1wnS7LNX18Me+OZ2fznapuk1wLS09SLvKnAPmYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APtZSFjT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.70
Received: from mail-lr2-f6.google.com (mail-lr2-f6.google.com [74.125.230.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1350606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1350606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APtZSFjT
Received: by mail-lr2-f6.google.com with SMTP id 38308e7fff4ca-3ab1b11ca0bso26459771fa.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793715189; cv=none;
        d=google.com; s=arc-20260327;
        b=nszig1Gg8UuIMUDEFfzlVSYiqwtqIhQGkiQBd0J8Bueqn1NJ8/XQhOMWdw/mQWSk75
         tigb80IzcYomOnuNDnRJHE0fSoXUAWnS9ecTeE3E348ZOzUTefadN6F3cdZ3MoWKeDN/
         zN8yEd/5rd40O2uWB2NXWR6zyO7g+EDWjPYCq6/m0AewcPBQBzbavKEItSFksPpeStY7
         uvrMRvlwYz5O09ai6GQzkMTOEUJJhhQwRUVZZ+kzsjSnOvOjN+oPbKlAOJ/5pYYJoloI
         BGfsXTNZvT9w5bUNhaWsxr5gg6TQn/2RQoTbrVuNPL2HX5pD+afsMhaRIwA3BxPT4rUe
         tGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HL04h1yc9M4hwxY/BxNlJ65GkcTfjvC+va5ivgCWeBs=;
        fh=bxiNLwGv+Qo2/UczIAtm7/Fz8srWU+cwfyU5ixariKI=;
        b=ItG3li3ao1DMn+UjU2PpNILbmdYbWdm5C94RqUHUK2+UpNbEHRPlw1N8wrx5MNO+en
         fJuhWMbYh4XYvxysfkHKuG4KJE4rA3dQWglAyNp4AR5RfGEa8Q8PnlwQjbf+yW47doN/
         UrklxdpRqvc3vrHGsH/z6794kta5ZMpxe4cOBuURwZY3sEa4YL9ySjTN+RUqxn/a8NyU
         qhMthuRd1CcgaWA8uqGEr/+Os5b/AQlX9BQLviquXhqqOur3aRapgi3ZIkftelaEGr5U
         DEsjc2pAlWAWGI/rP7OP+uA0EQfHkhf1AWFaaMVvpx/QbD74EBci8t/QmgnPKN8lr0Qg
         zurg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793715189; x=1794319989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HL04h1yc9M4hwxY/BxNlJ65GkcTfjvC+va5ivgCWeBs=;
        b=APtZSFjTMWO8qjF7GxxiWwzto/kwZF7nZ7TuzyxegZ3QQg47qjf7Q9FEsZ/gsaIbZS
         CvVufX3TCvXgBGLnjkWvSfbo9FIhWjdpSmA0z+Tn1/LcjXcVhyu/s1fj7xEcyb7xxCjf
         ZZ4MsVpybYhKKOjPTf/Wn/RJPmwBBuJOEqq8JR07cUEwnJKfYYbl7qiKVOxrRDOLXCUn
         QDsfnO1A9Nt4oBz7gr322PjtesSZ7D/GkMuq5GqWlDS6O7ZEbQ/jawnq7zgZ8sxtmbnh
         MJfcsSKqWsR1bBzqZvo3vWNrIMWFO222i/3C8XRE1Rit9rybjTP6Th61UvW4DNUHvq+Q
         ntwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715189; x=1794319989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HL04h1yc9M4hwxY/BxNlJ65GkcTfjvC+va5ivgCWeBs=;
        b=YvzG8X2tjEM5h7iLLFaIEbQiJwitDDG8OgYBduK4zIMVyBivoXnGt/cPpYZmvwwe00
         XRC5HSSKLO3C7lFIH3oItO59D/BFkg2sd7hqclQ8YtF31gEpfzCQo7W9Hw1nT93C3P5J
         n/cnouyABQ6tZbCGfwB2Nn41q7wyU9L7xpS6/1iraOKYt2Ed/9BA6mBIpQ6IGR1RCYSR
         XerRE8e6rRkM5EYSxQf5eupY/DDHlN+qeFxfuZY3VXyTy4CL3qhkAVlaPfOcu6d9I7IC
         p9WUQcHx+Rg7iWb/NYaHUy1xJCnPPyloOhv9HJ2L7azubiFAp1Bff6bNMJoUDC9xgnZd
         H6zg==
X-Forwarded-Encrypted: i=1; AKwUvBwQIv21UoPwq+u8RohLBCntRVMBjYiMtrYWdoB7k8kOjrWhjx1UDXKt2UVT176RXtZq26qfjkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DvEKNgk+5IUDqYR1VRbXtaBfYYqLxUsfTC5brDZvaZ7AKRIev
	KV4C+tRynqzO5R5D6Nj77JF90TciJJyb5QCKViD+BknLAnrWNkidMeV7wi0SxGcU4RKTySbh7mc
	Opzp7aARQDqKVaO4I23Mg4+LB3+HobNsrjkoivmrBXydD9mY=
X-Gm-Gg: AYBFou1gHYBuah5/x1K9KqhC8P7JBUIKuF0awmJ6vi7xMrCev7j7h9IuezuUXe7SXNh
	yoBE7FzneSCxvU18tkzy9p/PUgfGsOqDN58zbXMWXMn5y9WfdVt3/F6KvEaA6UYLxBSVuNmkkW2
	TUNeX1RsFQVNBVt0o+v6UXJ1iWDkJzaiRTASkGG+YuSRV/F545Wx74Cm4lfshsRzF0utunuQs5J
	intuYr1k4r91lhAyuCc0yVOTfBmaCV2BYRWRBVbask+6PoeS20O156cFTfFvGpbreFu230XuyLq
	ciTOaUvK8ZNcaAfOo/Q/Bg+5e3dyT880hJGbD2vE7bThvlXNKYCdcKEuXaZysfX0bd5DWiQTS9w
	L8zO0H5Qe/09KfRvJUIR9WVjftdkaTWjUGOAHcdYW49iBmmGsMcMyRhlOOgOdTzDexY7KuX8km1
	4vZOUw82sEPC8nY37hlg==
X-Received: by 2002:ac2:4c52:0:b0:5bf:ce41:7a8f with SMTP id
 2adb3069b0e04-5bfd957d192mr4098858e87.53.1793715188505; Tue, 03 Nov 2026
 06:13:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102150146.19777-1-jianyungao89@gmail.com> <717984c9-a0c2-43d8-a801-d36c18c7040d@web.de>
In-Reply-To: <717984c9-a0c2-43d8-a801-d36c18c7040d@web.de>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Tue, 3 Nov 2026 22:12:41 +0800
X-Gm-Features: AclHuK-MfLQMs5fQ5T8G-7KqHA8RnCDfPbXHT1W5k5aa0ReYsJ56PCXds9stJu4
Message-ID: <CAHP3+4BfTma1tQLbGLzy3aAzx05eR0QKOfmL0V-X5vEeOWtAEg@mail.gmail.com>
Subject: Re: [PATCH] xfs: fix temporary cursor leak in btree shift corruption paths
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"Bill O'Donnell" <billodo@sgi.com>, "Darrick J. Wong" <djwong@kernel.org>, David Chinner <david@fromorbit.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Lachlan McIlroy <lachlan@sgi.com>, 
	Viktor Malik <vmalik@redhat.com>, Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,
Thanks for the review and the suggestion. I agree that centralizing
the error handling paths in these functions would improve readability.
However, to keep this patch focused strictly on the cursor leak fix
(as per the 'one patch, one thing' principle), I would prefer to
submit the code clean-up as a separate follow-up patch if that's
acceptable. I will review the affected functions and see if there are
any obvious style issues worth addressing.
Best regards,
Jianyun

On Tue, Nov 3, 2026 at 6:43=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> =E2=80=A6
> > held by the duplicated cursor.  Jump to error1 instead, which calls
> > xfs_btree_del_cursor(tcur, XFS_BTREE_ERROR) to properly release all
> > resources.
>
> Can further source code clean-up become helpful for affected function imp=
lementations?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv7.4-rc1#n526
>
> Regards,
> Markus
