Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242193;
	b=2fMKDVjIOJIK1CEHhZnNUKzIn9UwvKiO01Ti3Y5FvfpWqhUlcRixPN9jQqx1PeInbySa
	 VQiylT9JwGrHHzKavwct3zLwfm8h+AIrm7QJUimiUJWUfA612ckGZUXJqIRXxHI9Ok1PX
	 4nH+iDPEpqOonqTlZCz7TyfIpUeJfzcEEV5JBubvjsud73LzYx53Lz6YsaAb0GzWsTv94
	 kzs7jRc42XafR80GyInVxGygpgCegm63/HrQhzBda0t2Ea4IXz1S/ZmsmRsTzOUyhtNke
	 exBbCvPjlsqmoqMbfBRJ3p01fGnJ8+Q0TsHodHXEbGVHVhjd0wHGSuHsK+0GCu2ZXUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242193;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JId6uBk9aYq0Mf2gdl20bnvfJVHQCFd7na+LV0uLZ5Q=;
	b=lg1kEYUkAkfOeEtMjO+v/bq1N7FZsRJ4uQ8PztlwKdjV8Qx5+nLld0egtnPl81RN8HPk
	 TvrK+vRjgpIRfD6oh4G7V7c1JScGFcqWF3Jly4egv2/eN3V7Rn/gBca3/uw3J5NhnPQNX
	 WMpj6JEIVkZU39bngWqzd3V2WuK1HdMc6d+E5bk96PJ+XMePR7kePbjRH9lav2ib2yvWt
	 /GUFypi+oGvBCdhZmX2rF7g6meGBBdhW/7DA9+1Oe/Zy2NFWxQS/NLkDBhP6BnRIJQ1NM
	 e8uNqDr+1miCf2aPrb6b5+V5EOkZ/qerwficldBM53yE4polvRfiEBvCHwz4hqrozYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqrcViW6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B4606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqrcViW6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D1D1F031E6
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793242192;
	bh=JId6uBk9aYq0Mf2gdl20bnvfJVHQCFd7na+LV0uLZ5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iqrcViW6QMFkXV++QBl6D0RJ1Own2kpWc8pYU+XpZ1iriTfqwbTSBiiXaXjMjGyrc
	 JPuBiXLOWHQMkup0wt4XXcQ8e8vF/0/HuU5GRcgzI9NQvWJkZfoPR9tlLPrwkBhTSz
	 ok0LaUqj4UmGoEIQEWddgYa+z7Y8psRq0jBTfnO/kyjVgZ2GFwgkI1uzqfjeFAx8f4
	 9Q0Gz1Gm+DNJZuxEq59zLiBjiNbchwa0vQuPD2FnyB3mU7x/IHsuvODE0Nb4fRuuDb
	 Tcz7+DRA7hmsxPutP8wcTVNlY/BM3SYJMDAwjuuOQAF9LbI9M0PLvu580OA/GyNF2l
	 NC+u43CoxE9IA==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6768403e9bbso1598567d50.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:49:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw7C3jFo3vmrd2iRwoIzwe7VBYmi8YMLbdjk9HK9SqV3kWE3nmP2PtQGaunElW5gkyYmpBIKw8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIHOgjNVhFpmTQXQdKLcAyNPd9Hi8ZzdZsixXr43KXD05mOdc6
	J23zHMdNhIVLEFFLF08qccJtT3cBaW+Shnh5+aEqLa+SL42BriS/+zXswpE6RYwxzfTBzh3AUY6
	W4srL5vqawVgjJ3ZEQ53f54JYkpqAApE=
X-Received: by 2002:a53:c712:0:b0:679:a959:2507 with SMTP id
 956f58d0204a3-67a7bd3b4b9mr3064245d50.45.1793242191766; Wed, 28 Oct 2026
 19:49:51 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028153441.184701-1-icb@fastmail.org> <CAKYAXd8PwT4aaFgUg82NYZUB=pFNasL2QN7TGGpJVaZjFXCuSg@mail.gmail.com>
 <20261029022039.224864-1-icb@fastmail.org>
In-Reply-To: <20261029022039.224864-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 29 Oct 2026 11:49:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-pRY-2aWy7vJwGSwVXL0=qadU_MA=K+GjtRkLcNBnOgQ@mail.gmail.com>
X-Gm-Features: AclHuK_d8MuzdKlzIG4ps_XWszTxNssGg7CnIdjq_8sWubyo__a0XLuRAHGpTaA
Message-ID: <CAKYAXd-pRY-2aWy7vJwGSwVXL0=qadU_MA=K+GjtRkLcNBnOgQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: enforce the DACL permission check on
 delete-on-close opens
To: Ian Bridges <icb@fastmail.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:20=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> On Thu, Oct 29, 2026 at 10:38 AM Namjae Jeon <linkinjeon@kernel.org> wrot=
e:
> > This patch causes smb2.acls.INHERITANCE failure in smbtorture test.
> > Can you check it ?
> >
> > failure: INHERITANCE [
> > (../../source4/torture/smb2/acls.c:1054) Incorrect status
> > NT_STATUS_OBJECT_NAME_COLLISION - should be NT_STATUS_OK
> > ]
>
> Thanks for running this. I can reproduce it with smbtorture 4.22, and it
> passes without this patch.
>
> The inheritance checks themselves aren't what fails. It's the rmdir at
> the end of the i =3D=3D 1 iteration, which the test doesn't check, so it
> shows up as a collision when the next iteration creates the same
> directory.
>
> In that iteration the parent directory's DACL is
>
>   ALLOW CREATOR OWNER  WRITE_DATA   (object inherit)
>   ALLOW Everyone       full access  (no inheritance)
>
> so the new subdirectory ends up with no ACE that grants DELETE. Windows
> and Samba still let you delete it, because the parent grants
> FILE_DELETE_CHILD. ksmbd doesn't have that rule, so even a plain DELETE
> open of that subdirectory fails today. Before this patch, the
> delete-on-close open that smb2_util_rmdir() uses skipped the DACL check
> and got through anyway. This patch sends that open through the DACL
> check, and the check denies it.
>
> So the test is right. What's missing is the FILE_DELETE_CHILD rule.
> Reverting this patch would just hide that again, and reopen the
> delete-on-close bypass.
>
> I have a fix that treats FILE_DELETE_CHILD on the parent as a second way
> to get DELETE, like Samba's parent_override_delete(). It only uses a
> parent's stored DACL, and never looks above the share root. With it,
> INHERITANCE passes, the rest of smb2.acls and smb2.delete-on-close-perms
> are unchanged, and the cases this patch blocks stay blocked.
>
> Would you like the fix as a separate patch on top of this one? Or, if
> you'd rather not keep this one in ksmbd-for-next for now, I can resend
> both as a two-patch series, fix first, so they reach stable together.
I will revert it in ksmbd-for-next. You can send v2 patch to the list and m=
e.
Thanks!
>
> Thanks,
> Ian
