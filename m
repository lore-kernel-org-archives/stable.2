Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794867004;
	b=T+jqPfuqG5DcYnQtpgvfOW+tJGD0T2Myy2dWSm8wbDzp2sXi5rj6wKCzcRYeZ7ptYRR4
	 SdraNsExba/QFUg4b0XXzApM248IwCF2cafDx9kpKUR59B1322yFw89L3LQgAVa0lVBBp
	 vR1TAOsCJwVxfVAedUEvUifqs4JNlWrNDG3SNc+Vt8bvxt3RXgIg4Vg0NU1sOIP+wpMvl
	 l0TU/mLB4RWN2Fj2riOa4nqn8aKwnm1TZisANJoBaDaI+0PQONyX/N2w4Soz60DetSVhf
	 sXHc5bCMOM9RjBREsRJFHY8FjOQP5TzGfIz0FteHi57RxCGuGF0zZWO1Nelp6PtviEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794867004;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8iYZBjVlYYxNkxBaWuErj357L087f22pPkodgyOQoVs=;
	b=GIFsWW/EO1iZTLKH5S0PphVdnL5+nJCBF4j2vmevkmJE9Lk3E+WcEqhgCKYEHxRvHTlp
	 RKXlAuBcNsQWeca6lhbMDPxBW3JLEsyXKMDsZysqcvDOoSQ4lcAIyMoKg7T9oiC4/5gUh
	 CscmCJvXUWr5w3wSFyCO0MJe9rZ21uu8OTkwpssSV6Ibi1kY8KmN4H+Co2PYKKEax49Oh
	 07RLVvIxxS+Cl2qP7j1xHG84uI/5jhAksHoF6NipypxtD1FXzmaCSGtv/k0/TY7qgWODe
	 SVk3SURCPnz/10shlDGSqHHanKPlXCSYZbCHZ53Fi9tMSSIDBK5XKot/yIkqadniycg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEFQsmDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B57606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEFQsmDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161FC1F000C6
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794867004;
	bh=8iYZBjVlYYxNkxBaWuErj357L087f22pPkodgyOQoVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mEFQsmDutZy1N/obcPtHewp3laoQcb5AY8Te27ZC+vLDcPv9oW2VST8KsXciFipcS
	 ZmnHf7+rPTgkEUl2RrA13AKeO324rCAdISNqi+NMtY5ViY1DiSa5/8TXWfAsxhNHSW
	 DYflbvIrElUcBpaABN3w09nlFF7H3+OQRF9ry0z1Wsz5f7OSJtaCtyowqsSHroVyk8
	 KokVgOrSiE0uNi4HyRvMIpjK8kbsFnSvBCYRTpdb4PZHA5O/z6tFuhl66gwJcneOTM
	 teKKXBFaqdnhQnQCZgokE9RtRSgSxWj2e8ZZuwFaPRiU2K8dfWcT9puQyOyWohWbWI
	 w7sCkZShDPQcg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4322d310e7so729051566b.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:10:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFN7dTOHbUiOV+fEdFrmrcGtX2Oa+ToQYqxM0FydMqA1WGBwBJ95ZYjcTDpgCFX0JgiCg3NuMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9k25VB4VOZgAJn+ahsCyg7U/k4qqxv3LeN5lIddXu3d8GwM47w
	iF3ZrxpZeWGMgR5T3jTNW6m6razW+nj4C+qb9tBumPJVtPwPqhWSNGeAS6vRrDBGFfyyIwJUYCZ
	Kzmf7UBKQ3pNuGkyt37cVcaW0XJMvdUo=
X-Received: by 2002:a17:907:3f9f:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c509631c9c0mr1078878666b.25.1794867002842; Mon, 16 Nov 2026
 14:10:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116161945.348983-1-0xbeac@gmail.com>
In-Reply-To: <20261116161945.348983-1-0xbeac@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Nov 2026 07:09:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_2A+LVONLQPG+SppZNc3MPg3V65fJ0Qcw3+TparHjUQg@mail.gmail.com>
X-Gm-Features: AclHuK_M0ohWgSQXOtSZh_EaDA0ukBzDr0Q-FBxFQDqMPeuApASjKf1eWiUERlE
Message-ID: <CAKYAXd_2A+LVONLQPG+SppZNc3MPg3V65fJ0Qcw3+TparHjUQg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: pin parent dentry in rename share check
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 1:19=E2=80=AFAM Yuansheng Yang <0xbeac@gmail.com> w=
rote:
>
> ksmbd_vfs_check_rename_share() passes old_path->dentry->d_parent to
> ksmbd_lookup_fd_inode() without taking a reference to the parent.
> Although the call in ksmbd_vfs_rename() runs with the parent directory
> locked, smb2_rename() also calls this helper before entering the VFS
> rename path, without that lock.
>
> A concurrent rename can move the child to another directory and drop
> the last reference to its old parent.  If that parent is then removed
> and freed, ksmbd_lookup_fd_inode() reads d_inode from a freed dentry.
> Holding a reference to the child does not keep its old parent alive
> across a rename.
>
> KASAN caught this on an x86_64 QEMU guest with a test-only 100 ms delay
> between sampling d_parent and calling ksmbd_lookup_fd_inode():
>
>   BUG: KASAN: slab-use-after-free in ksmbd_lookup_fd_inode+0x28c/0x2b0
>   Read of size 8 at addr ffff88810faa6f30 by task kworker/3:2/76
>   Workqueue: ksmbd-io handle_ksmbd_work
>   Call Trace:
>    ksmbd_lookup_fd_inode+0x28c/0x2b0
>    ksmbd_vfs_check_rename_share+0x8e/0x240
>    smb2_set_info+0x2b71/0x3bb0
>    handle_ksmbd_work+0xad4/0x2110
>
> The read is 48 bytes into a freed 192-byte dentry, at its d_inode
> member.  The stack reaches the unlocked smb2_rename() call, inlined
> into smb2_set_info(), rather than the check inside ksmbd_vfs_rename().
>
> Take a parent reference with dget_parent() and hold it until the
> lookup completes.  If the parent has no inode, skip the lookup and
> report no parent sharing conflict.  The returned ksmbd_file has its
> own reference, so the parent can be released before checking sharing.
>
> OpenAI Codex assisted with reviewing the archived fix and preparing
> the changelog and validation materials.
>
> Fixes: 7f8029591bed ("ksmbd: synchronize lease breaks before renaming fil=
es")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
Applied it to #ksmbd-for-next.
Thanks!
