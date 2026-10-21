Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792589322;
	b=lfeGwHz+ASm3mDihXKMv/XgBTsZc/Gj6MlnY6f61GPUrjAFkPCH89SisJkxDWsvECAqn
	 lB+Uc9nlECJ9tWoGXBL41eexy7b+AIwGN4prYYLeNBqckTHnszvY59ldFRw8YkGXPLDdT
	 N49ddchoqEi8YTKs4RvGTeIgmJ0bRGrZK/WlK4+WK6NKBEpari4YtQZkCeK9fJ+kU0VCi
	 Jydj5WY/pU6zhUDI1XZYyDYKLFAFcuuZgHr0Cxl3Gfr6OPQQXbj3aW71yrn0rc9stZkU/
	 i1awDyV0n+fCLs+PutGw354m4x6AEylR4+JyG+7lvMsVdyOg05LnAdxr1TAnE8c/5VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aHoL/xV+lJSptWn1pnj9SxRHcMCta8KU7nBOlsKicA8=;
	b=GQs7K3/S9Cz+c85O/3nBFjzbqeg8w0h0yHwPmsDELqrnW+upC4THsI7ijNrXB8G0zF82
	 YvYpMjV+T0lETn5MjEuu0COcW0DcftUWD6mHrZ2VgW6oepWpJSgwNEX+TapvGxLoxh0KA
	 3f500JbhZ0aZ4mwOvDWPNNEvWAEkUwuKnoOj8xg7YtR0P3sx+AwgKw1dbalGam/ACTQo0
	 sR+jDolrdIFmJzzzZVZ3g9HfZDjTi0FbTPtT+uOK2Dm+3emd67Cop+7BUVq8PDu3GKa7p
	 ia5yt7QjbwWEKEz+BpxAqbVFKy9eZHkISdyZcc6R09SgoI2rrURybK8fS5wRZU9/tqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ihyLRDDv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45845606A321
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45845606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ihyLRDDv
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-535f598d126so254971cf.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792589321; cv=none;
        d=google.com; s=arc-20260327;
        b=Du2SJEjKcoRw/JLnVo34L0gBcfEEjIl4fjyV8SgGAFSZBA8LfvDKfOS5qmV74Mny2G
         bemZmnA15YEzcHDXfKLdJXIJs33ve7iSBjS/5L3/S4GMD7QtfcWKM/UnY2oE8XIkqNMY
         wX0YmCvz3XHurERDMzhWJasJisxyyYtKjVLaWM7wjjhz9qxgrCd40DsnFBQKHwDhV5Zp
         qoSUzv0lT9sNDon/Cg570p/cakj94uptbN9rRN8PDANVyJX3HF8TzZvJM1doXLWhH9UP
         Pk0bbcR5tDwrXrp9qmmqIDq83M3QxEBe5Bu0L4gfKbwvXCLNEyaU/TVfDzV1W88Xsw4U
         mLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=aHoL/xV+lJSptWn1pnj9SxRHcMCta8KU7nBOlsKicA8=;
        fh=9fLKQ4JQx+J++s/tmdgAOSFUWcpTcFYk12X5BwbOSU0=;
        b=YOZRWhQlXSzz71qwHSNtMiFYB4XN0yAR/QVB64z4b7n1TSvlJFG1jZ8X0E/vmKuQch
         sLNJdYwDp812NdmScimxfntq73TBe3vdMvqUrnZoApNIIL8FzMSp9Wi+sccgsXq3s2BR
         CpIdzyhJgE0uO8CnpG3bUWGhadeD4Gz4j/4zC6rsN0L4v1ihcqRtN19DgUoiXgobpTBf
         rqtMv2sex8CWYa5am/RElwNo59wUBqabHSPwtWBdk32MsA0OC3EjNqqmo2lqLqsRYuHj
         kJLEQ833A/tOos0lvV50HGivVfbBzOm0PdY8bmxdREoa++RhHq7fg0yRB9jmvJ4qylci
         Nnbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792589321; x=1793194121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHoL/xV+lJSptWn1pnj9SxRHcMCta8KU7nBOlsKicA8=;
        b=ihyLRDDvbYTaqBdY46anGqX/Vs0AIF82chcKzRQAE54w0CAOMr+AVgOSg6FalBjknK
         7hC8Pp2HJbJer88B7T/fwg45cNh1q+IJ4R+kIBFJeTZP7iBPa4GIt2nTldiQT4opU6J/
         AN8mU6nlMvKX8xaP0T1HE5WG9TR+aMq9HFRPNbYCCWSFpo1jKJ0adpoUMOKG9Ywb3IFi
         oCT7RaV6Ej3SwRyetkv3IdR0UjhGmczHNnRT9aNNFWWwpwJK59Y//+VSQZ5kk8d8eyVU
         mTezC3lqP+qG+2e/qUmLvgX3/xKM/6P6bB0yR8CA0/mJWvHGjFwCvOjNSfiJaWAZuAtY
         HGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589321; x=1793194121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHoL/xV+lJSptWn1pnj9SxRHcMCta8KU7nBOlsKicA8=;
        b=yZxUwcYmUIYw4tX0hPncwDkzOxHP45YdepMVHf8J/KQOIehFh1IZWRlJTwJ8yn+6vc
         tqQsWlzu3Y7ACPr8i3gRX1hNc1G4d1DW86oodYgXYFVLtzZZH2izYlmTW7llMOXvq4E4
         wrHvYVXpNS8xwI4w2wiuJG27ZHE+3+5HiCp2GmAKRR50mvIYoZkXuM62+zATZueT6YN8
         eB1PW4ZlMzB33neXgnzCktJFmfYPAvOAzWdE17tuvA+6yFHt/TwqMt9RK2lBzQ6g1ykc
         X8nvnN+7OwUkNJDXXP+i/9SOkq0hRNrggentbQGXd0l1/KFhX/ZrG4Xix4orKVbrrq9G
         75XQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvfMS0fJZjeidSbdos49A/Fg/PsTTv6w7qqhyKZv95YRBxLic03wMSaOgoOoLGH/RWDR7wlqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCGaeskm7qw5c9nU80rs4PPknjTwh4G+5Acf9JnMyIAT9Ce1ll
	HN2AiAeoTJTMIrA+3ZO2PDhGhr6lqYtOwo/1qE7txeFAcYvvlqDDZ/ULmQjO+3Mhhn3/sjzGybj
	pgsYeAmMq0DHUlfgviBB5xWpd4cFdXH0VR2dWLNyS
X-Gm-Gg: AYBFou36zJSKOvbXB9P3C/n6OoxZ/zXMCoM9CXehiG6GpoUjXpkRHXnSFURG8zCnCvE
	ktKxmQjcudVTBrk++LnzoqzDPlMWGnBptFwjiyxbZzruhNqInBWIMLYb1WjnPQRKwQXw5pTxKHH
	k/sHe0G9d6j7CEn5p6oUtAqnOp2Ub2YQMPmcP1uKnwd6IR72CjJzwueYlk6WXbccopXmj9nkHFP
	rCE/dEbMwLP+wvUk2V5A84TaDctRd5ZlSYO6h8R/yTZpmgo2e3wA0RJ66HrTsyGNpOVZb0En0me
	Ko34FlRph59ASc2zu5w95660kNnG6dzLEHrZmyqjxlUzZpTUYjMlGXArFcMJYx07Eo0pvqC+RBh
	jnRbvXryFlBZJ56Kebx5/jQQ7mppqJlwJwysB2amCI8eevLJwjzwxTfNhNIatHaOi
X-Received: by 2002:ac8:5dd0:0:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-5368b32a9c3mr35503331cf.10.1792589320454; Wed, 21 Oct 2026
 06:28:40 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:28:39 -0500
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:28:20 -0500
In-Reply-To: <db4d4e246ad6b4769f736db0d3d1678adf9d59cb.camel@mediatek.com>
References: <20261021035450.3488805-1-stanleyjhu@google.com>
	 <20261021040615.3566831-1-stanleyjhu@google.com>	 <20261021040615.3566831-3-stanleyjhu@google.com>
 <db4d4e246ad6b4769f736db0d3d1678adf9d59cb.camel@mediatek.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Stanley Jhu <stanleyjhu@google.com>
Date: Wed, 21 Oct 2026 08:28:39 -0500
X-Gm-Features: AclHuK_9yuJHTKtFtEEYtr3PTMFrReT2NVeEAvxb4V7BtW5ZNHdjV0Vtrr4xmu8
Message-ID: <CAE14pdcR7NPqK3W6Pfy+FkRrXSXB9wFuweOhLyFtSye_Bg4vWw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] scsi: ufs: core: Fix double release in ufshcd_abort()
To: Peter Wang <peter.wang@mediatek.com>
Cc: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 21:12 +0800, Peter Wang wrote:
> If ufshcd_clear_outstanding_reqs(hba, BIT(tag)) returns 0,
> should we also set err =3D SUCCESS? Since the tag is already done
> =E2=80=94 either by the ISR or by ufshcd_abort =E2=80=94 shouldn't both c=
ases
> be treated the same?

A return value of 0 here means the completion path, rather than
this abort path, has claimed the tag and may still be running
ufshcd_release_scsi_cmd() after it dropped outstanding_lock.
SUCCESS tells the SCSI error handler it can retry or finish the
command right away, so a retry could map the same command again
while the completion path is still unmapping it.

Returning FAILED here also matches the check at the top of
ufshcd_abort(), which already returns FAILED when the tag is no
longer set in hba->outstanding_reqs.

Thanks,
Stanley
