Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792504349;
	b=4eOsHvBunLxKPB0m880e6bqP25j2s46OVPQo6o/vC7UJh1mTmdP3Wq1uZ8OHYtjs6qFz
	 k/GNDDCtR3pzIt15wgDiLnTs6P6oSsk0c6laJVJo9UnqaNqWYDsqSi3yWw9Iqndn78/vT
	 90hznA6VuAP46x+jIq9QjKjipvu1KaJr3v4KTDcyQ3OqUsUxMZD+B3vVIzC+NKn3Pebrn
	 d4faMU6QbESDGfol1T74aHXF16Yd8fQ0JEAabWYj7O1aQaORKvt7BCZ2EdKVSc4geN/sA
	 53dkZUlt+xoANv45x6/TFbha+rgpQTEpoXFuJQFJhq5VRdH4iODTOs4cnoa7tkVlLCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
	b=0zbqDUbtsoVDfqo+bxI8oCCbF7ckor4bXp8nPxP9UXjSWarVnXowwNIfrWhN7pzgxGNs
	 hPIM/Es96gRy5cuZBEUFmqmIRMHARjxXubgqoO/WUBfm9UG1dUuSSIDJ2YC+6h34r167i
	 O+NLe0QAuXKXBZVIgC1HKL6aByclbuj7c0rq1iANO+vpEDGy0dEwwkRrsk4pqv+RQRTEg
	 8JcdDuHUzLrrH8iZ57jarMxCFNkvE1E0FghZ/Lqc0PKIRDXx5vjVg45vN1M0Jn4svSjdu
	 NQF3cxl2glhwUYnui4vLcgLbodUtYRMi4jRmTy0k8DdADZ7bRGdU6vu+PQKxhBpsmog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IV2bjblS;
	arc=fail smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29A606A326
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C29A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IV2bjblS
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070781f63so854846b3a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792504348; cv=none;
        d=google.com; s=arc-20260327;
        b=IjZS7obSl0Oqk7Yo7tO2Mm7wcHxT/pWw32r7aByHVB4u1kWYZoAvxn26+vDP6xUjj4
         U6OWklc0vaa1L5+HwOebm9y9kDPp6YQwcUdtt0+um5oPrXyL2W4EumdtWsP/CrvPAoBn
         86rOk+PlcWSIP/8A9AVub7n7fsPJxF5DdslsjdWhuLUqKnRF3PrY5xv9Qcwr+gSmpjNN
         1lazfr6Z1JSP2nISiwPjWvY/oTNLveP3lC2letu6hnVqShPg5qaywWIp+2YA9+kGujun
         raSJzGU6UejM3p1JVZtOEZjmKsoSvkwMFoqGs1b6EdLRRDvCCnnvv1AX+V0TXPqHXhjd
         xPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
        fh=cIsifzLs6qfI9fNaWtvky3ASOHgOYHtaYECz4wbwvdk=;
        b=nrVN5/T4kk8hKwEnII8sFUvQBpa23fKIu825HCVc7nhh4kmGdfrx0rBI9sFT5f4cYL
         UPxjdMZhyWvjzoW70W14iG0zVzHgMGV63nJUaM05ZfRhmHjOAfvpYta22R1qs+cBkQgT
         JVb9tvEvOVuEG8Zgq6LJ77T+Ya8eWXf2+0A6iKRt0BphxUxMuCwOpRPQZFL9jWX9wSdg
         XmrWT901ZDSARKz8nz3pFi/WGK/NDREl+J6GNo0oQxroF3flqfs7qZXKHwsm9hAKFOLM
         uoNan5eQbMR9GW5y/vOfEwriuVd80XglgCeiD5nvyKmNQQ0ORsqXGSffLKu7aZdZt1OP
         4fXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504348; x=1793109148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
        b=IV2bjblS35z+WtRmdC+d2NdVsRgCEc2iwHZCl7nN04NO7e2vjqFjw+Kx6HSekD8k2E
         /NPZRHZ2d9c1Lug7zCFOG0L68NjXSPPtKPzbZDrCoc8aYx91Wv0bQUQUtgRqVZulPYqu
         1syNEVnV219YTcsBqwsBTN8OTqFxpdGQxQXvZjeKMq+Ep4Z1SjPPQ2wtKwOxkoh5zuly
         P4+EdYiXsq+MlyOJePp6ZT18lccIxbzkqhPTQ/AorTqz9PdbsZePwazefSSyjIBhqVlp
         rbcM+9y4QEhyT9xZ5apQ6lMNz3ew0gGjIvKSy+Cg69b03SN4ZpNYRn/LcJvQzq+77ydf
         +7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504348; x=1793109148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/hbwlcYMnNfV2mBX84KMoYZ1kQ82mEtSuTGwp2XYJ0=;
        b=FXTfTqlQu6ANqOQoSXPywSUGpQ1DfY3AO6Qdqlq5X/VlSyenYdHoSoCVTm6xMvmaqx
         zo2xu1jqPnj4iF2acrHneY+zc2G34SGBIbVNLyb7L8RHwvY1Mh3AzhyRyPNfK08l6SBC
         xpoNMUR4yJXGc4IgaUGyMUlWfb6R63KFlbov1rrJV0sf460kwq8HWnYd/Ddm/7or0qx9
         3zmBr0vSl/P3RczqfrWsFNnxzFJZwlQnmDsz9kYlQsiQNk9a0Whk8NKgf866T0JZlAp1
         Swgan3r+b9eMuZszKJbhulspF5HmZrW5+UrF6bKQ0d4usUPDNgNV5Cg0oZx2Bhi4wOy1
         hh0A==
X-Forwarded-Encrypted: i=1; AKwUvBzdWmC5j31hwMeznXM+EID+p94M8UDZL9/9YjatYSt3DzJ/+sBcE5NhBnkV1Wu+2eqRyPTWZjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9IS1/6HfI4xCgBjF96+lXYK0HKSv7YzH4ESnVyUT07OCC8XqY
	dZ+PnDigCTd68FEA9gjx4OUFHsqH9fCEPBgfAqsg+BL6m0zoFuwIUJzGc+5uvcyEfTr413k9R8c
	z8JaehdRkDjnd81+BKVPIp12t4ckZ3dA=
X-Gm-Gg: AYBFou0yzpWCQmqdpRo7Uk1laXU5OtXiX5OsSKUo97x0QdDs1T1LBRZundk5t4xhYBq
	2LBuDcZsma9BJXccPlTciT6H5FdBwEMOVh1P8bAa/grYc6+uNi0RS49TKSq5ssTvFJqqK3JYxoA
	M8DpQ3qVqMLfdyZWvgU56OVJ5yOGuEyF0CDEPg7fmwEyle4M2Ub40dycFgBChU6obAgErsrraco
	0ICp3aKLzfn8yffds03gczO1ZLPs5pU7jfJkbH57sfEBkOTNj/5Rb9ZEchjaEZafKQBWi9QWt98
	bAGm+5LicXsWx8om0QXtcN9YVCbUkbrJYmmNemN2bpWLtBSMfjR2gYxIZx8/EUx440+7cpP7rEF
	ujWJCYUOIMEj7LEM+Was2Bp0ZRbQ/FUPx6rT4KpWXto3/EKDvHpUM5H0W1m9APZ4UJFSQ9gx3sA
	74sFkjpe0caxHyayZ6AbJZ5NNBVStDX7LtfRD6aA==
X-Received: by 2002:a05:6a00:2343:b0:89e:9c7e:fd51 with SMTP id
 d2e1a72fcca58-8a04ba30b92mr8261328b3a.10.1792504348492; Tue, 20 Oct 2026
 06:52:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019135441.1420968-1-sashal@kernel.org> <20261019135441.1420968-252-sashal@kernel.org>
 <20261019172836.GA1885@quark>
In-Reply-To: <20261019172836.GA1885@quark>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 09:52:16 -0400
X-Gm-Features: AclHuK-B306P9cHCODywZCNc6I1CxZirkEbtUGcvZRPSRQ2med4P2bdTR4gz54A
Message-ID: <CADvbK_d3hcGcP21Fy_z9hkoSuQT0Bg7111Ejns_WxOYfCCGFHw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-5.10] sctp: auth: propagate HMAC calculation
 errors to callers
To: Eric Biggers <ebiggers@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, stable@vger.kernel.org, 
	Qing Luo <luoqing@kylinos.cn>, Paolo Abeni <pabeni@redhat.com>, marcelo.leitner@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 1:28=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Mon, Oct 19, 2026 at 09:49:03AM -0400, Sasha Levin wrote:
> > - Residual in this tree: `crypto_shash_setkey()` failure still `goto
> >   free` without an error (mainline HMAC helpers no longer have that
> >   path). That is preexisting and outside this commit.
>
> I don't think this backport can be considered complete without handling
> that case.
>

Agreed. We should return the error from crypto_shash_setkey() when
it fails in sctp_auth_calculate_hmac().

Thanks.
