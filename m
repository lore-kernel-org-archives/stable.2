Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120648;
	b=rXkyPHqUHqRC96cim+GcMojmGHBY7rEPGrUk+2p1W8RF8ntf+V51A7AfNsSp9tubDFam
	 efcvwVtKp6H/WekD2JBnLP4Kv9Fx0i3q/NfhyDOuHIsp5Rjak/6++oBkKbKJKFYssgWKS
	 E8H9kOm0VLlJ9n2PJIIS44OOPuuFvFEece+XtCEoT1Qnv1u3y+3ZVPDQ/Eb1wQEHZJ04b
	 tp2ySQH5a+z0SLkr4wUSn2fRWr8mYt5jqXP4tkGICUjEITy0Kr4YXhF1kkzaKhAFc0w33
	 rIvHtpvneLoXXJa4CKfdh4IhJ6qUW+ZigbNuq+1s2/n7tojnbY/1PRTa2VzfkTNpm1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120648;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QwD1xrLGDGo1I/zT6EZsHW/ce6SqUcbnrjNu+DcjOYg=;
	b=aMuHCJAdW7PpR6aw5Mqjb/QvxRfr5xtk6F2b5Zq5k/ECib1SjyCN1Be9A3Uhcx8Z9aNz
	 iBI25/T9yEVeWb21npcs7iekL8Ljy5WxJwjnvQpRwybZtC8NJtjeW+GQOL/P6bMG72Kj9
	 XnhO9/9UdglsQfC57pFq7v/6mahXqVQ05jzw3YaqjmRdzUJTc4B43Cik4xCtrWUtvxtvI
	 ADo7Ofr7mtJBt4nEAcUosVCfS1nKhTejwvSfJvNTuTuh2Ks44QbFeKrimePB5DE9YHiwD
	 IJlji5NM4wc24tww1MzkngtIZMAZx05FT0qA8EZxPgMtwK7zz0uoj15dorhMEk1ZDbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEl999la;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885860A3822;
	Thu, 19 Nov 2026 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEl999la
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD051F000C0;
	Thu, 19 Nov 2026 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120648;
	bh=QwD1xrLGDGo1I/zT6EZsHW/ce6SqUcbnrjNu+DcjOYg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MEl999laiqL9Ek/kF0TQve1xCMvdh0ZCMqF/R0r/U6cpLDHayk8SqJriOE+Ftiocp
	 YsyHHehkSOFrAS9kPmJsO7qWioHfOZWwdSF6PFhoWmTMTGpPHfk4CjOO0iAsIxfMmz
	 N/vDp8WqUYEpDsVnj1MJFtPkng5wg7qLCa7+9OHGGvvAUc41JOhVhEUwbFOdoKb3Ei
	 JW7opAHadgRZvaVTUnqOmgQ1NZAQJ2NEtlxb/4wvDQNqS3QgvDlIW5jOtBwlYyq50P
	 9BtFkumv2UdlbdSaBKyWL0n3qBSqFBl5bNrPAgMIxA1cOCvIjkcPv2NgcEWt/TgArT
	 3ll0J5h8e+3Tg==
Date: Thu, 19 Nov 2026 21:37:25 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jason Gerecke <killertofu@gmail.com>
cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
    Jason Gerecke <jason.gerecke@wacom.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] HID: wacom: validate battery range before scaling
In-Reply-To: <CANRwn3Rt_zT5jwCvgbC1J-V1EUzLKKqDC+aDrgt=y1HkzpzYuQ@mail.gmail.com>
Message-ID: <54636o44-451s-r2q5-n749-6r127q995q66@xreary.bet>
References: <20261106213526.3393779-1-qwe.aldo@gmail.com> <20261107012636.1008932-1-qwe.aldo@gmail.com> <CANRwn3Rt_zT5jwCvgbC1J-V1EUzLKKqDC+aDrgt=y1HkzpzYuQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Nov 2026, Jason Gerecke wrote:

> On Fri, Nov 6, 2026 at 5:26=E2=80=AFPM Aldo Ariel Panzardo <qwe.aldo@gmai=
l.com> wrote:
> >
> > Battery events divide by the difference between the logical maximum
> > and minimum without validating the range.  A malformed HID descriptor
> > with equal limits can therefore trigger a divide-by-zero exception.
> >
> > Move percentage conversion to a helper that rejects non-positive
> > ranges and accounts for a nonzero logical minimum.  Clamp the result
> > to [0, 100] as an additional safeguard against out-of-range
> > percentages.
> >
> > Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measu=
rements to percentages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>=20
> LGTM
>=20
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to hid.git#for-7.4/upstream-fixes, thanks.

--=20
Jiri Kosina
SUSE Labs

