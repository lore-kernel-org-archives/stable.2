Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259791A9FBD
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789259924; cv=none; b=EWbKmSi8SyCkqDFd8W1aqYxmMpalIDrEWS3rC8A9CKZ3IRe56svpzhYps6mSRe131Qwa+Evy19t5dIlFrDue+rkCcSBo7rOMT3x8zUGZaa4msZY0F+aGJQ4mxDUhbborNa3nTfn2DBNJ+VfjRRmez0GMef4Lec/Jw0+cE9exFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789259924; c=relaxed/simple;
	bh=lO5isEfk9RBIm4ksoMLx0wQO8jGwXEX0xdjWCusuNRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk8PbTLmChkdl1PRklswCHMYGLejKoWSSDe4pF7TfvhDyvqdyhVHi98/Hsle3Gaz6+xbIp+5wt3AnzVPwxsIhNSHKrfYU3qjs0/cty6CEzdn7lRg6x8QQeFli2XFv5/7Q2o8+zKITDj9PlYDumdFnMm+kf7ipq9FEF23MRatxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUhMCxcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUhMCxcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0681F000FF
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 00:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789259922;
	bh=DTAIZUEFWOGntp0PaM0rHkmAzw7S0ACVm6PwaL2Wbhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gUhMCxcjCqlQVfO/g0QuEv3+TrnSwAtheDWFLGM2oKHwUSl08WasJfWA2w6P/Vz5C
	 dqoeFIkmHCPWkET3Tj9pQkTF/lXjTsINZKMHZOwijOXRKeaD2MFB9avb/lXIkSynyv
	 KKApepi0S/i3aLa3F1/yw2yCnLNnVvl151O5lCUHaKhwzWfic8XyO5VADl3nr/91Hk
	 Dzw/Jmx4FroKpN+qz7TTRTV0pUTIpbsxBZn3LV3YlbvfMCay4NWVl8Nuzw66d1nZlo
	 yNueYI839aV93idM8gzYhN+CQGq1ZWTCLjcG90GwUNb/2RUF6kHi0VB7PCZx1fSABk
	 8uCdzieJlXERw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a9983162dcso2757549a12.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 17:38:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxy/mo/kBApZEWqVf810RLn0Weg/hsIj7LPk6yiXBLWkSpnXM77W7ptPsXbPF7cmtItu2BiAGA=@vger.kernel.org
X-Gm-Message-State: AFuF++kDD6RqutNRWHty1Cf4Ed4W8s8UizG/YkSMCF5KQqvLxZtdx7I/
	zAulN2ZmQKrpXTxL1/iqtUGHwtvMO2+EfYjcu0YaGdjnPRl4DlkvaX7C6OdxImEhpeDIz9cv6C0
	dp9pTluF0XYqC/bVlNIKQ6M3CmH7rXLI=
X-Received: by 2002:a05:6402:1f49:b0:6a7:ee56:615e with SMTP id
 4fb4d7f45d1cf-6a9b56b3298mr4645574a12.32.1789259921147; Sat, 12 Sep 2026
 17:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911151056.27965-1-suruurism@gmail.com> <178923374277.30348.14595304921780051144@gmail.com>
In-Reply-To: <178923374277.30348.14595304921780051144@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 13 Sep 2026 09:38:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-pAJmaBvYEo8YW75C288MA1F_7gLXALR=ygWqZSCzX8g@mail.gmail.com>
X-Gm-Features: AcwNN1WmiBKvXkv1QExPolMhCJzDUCWcwT9sA6bmz8WHamXl6qZqRsqzLjtkhcE
Message-ID: <CAKYAXd-pAJmaBvYEo8YW75C288MA1F_7gLXALR=ygWqZSCzX8g@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] ksmbd: defer oplock break until m_lock is released
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: sashal@kernel.org, gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 2:22=E2=80=AFAM Abdifatah Suruur <suruurism@gmail.c=
om> wrote:
>
> Hi Namjae,
>
> Sasha is holding this 6.18.y follow-up pending a maintainer review:
>
>   https://lore.kernel.org/stable/20260911151056.27965-1-suruurism@gmail.c=
om/
>
> The 6.18.y backport of the oplock UAF fix (c8279ae8df68, shipped in
> 6.18.51) calls oplock_break() directly while holding ci->m_lock, and
> the backported smb2_oplock_break_conn_get() takes down_read(ci->m_lock)
> internally -- a self-nested read lock that deadlocks as soon as a
> writer queues behind it.  The patch ports the oplock_break_add()/
> oplock_break_drain() machinery you have on newer branches so the three
> walks collect the breaks and drain them after releasing m_lock,
> matching the 7.2.y and 6.12.y shape of the fix.
>
> Could you give it a Reviewed-by/Ack when you get a chance?
BTW, Could we keep the original upstream subject and description?

  ksmbd: don't hold ci->m_lock while waiting for a lease break ack

This is a backport of 27a9bc968d4a, and we can add a brief description
explaining why this backport is needed for 6.18.y.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
