Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABA39021A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902415; cv=none; b=MKQyK3qriz4BYg3msGQG7VeEY4Vf7NS7kdE4tnIzsnGySql0jCa7LLx7ShrpK8XK4Cqovnuo1EZsLmN3/vCEKQY9cIt5ATr8pIhmLXCN8pPoO9CFZBCf25cjGz3auoQM7Fn8Le1wMbVFGMdAYtxNppRhiPx9HxFQY3zWm1R2dqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902415; c=relaxed/simple;
	bh=8tljfG2MYEam8t8AtYWWq514QumbdCKZEA9GJU7iOJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7W8OS8rsLQIEjgDl2Ix8+znhF0Vk03EZjIjaogxHJsFmH8XiSzB+GK/HBBaYnIhUDDeNxKsp9HcemT7GRxmtqN4H/HzzmuWZtEbd7M4zUNIVODdxKR2AJgeDdRWgXTg3NVoCKlwvprjH3GOMg7AUARseKbUuS2NvXzZKwKu5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWAfQ9gf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWAfQ9gf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FDD1F00ACA
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902414;
	bh=8tljfG2MYEam8t8AtYWWq514QumbdCKZEA9GJU7iOJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PWAfQ9gfRc2tIqooSGsK+54jXObfq0TUgWaeCNe6oo2MTu5F4UT301EaBVa+LgIRB
	 Yef6HdM70fr5hwqh7cK5YgPHXxVgoUv+yala1AP7S24GLfikZm+Eqxs69Vw88E9fQN
	 a8ZZcM2PQfA2me6daLGBVQ4yeF++2E0D8gCyunDtlNag1XgXSpdM/nAJntVxDyZNDl
	 rmNZG4XJrcVsWW4oD5dC5q1KHiAvyentz5B19PTcd4AUadfmJD3HqqmzFY4GeNqG1y
	 v0xMiJW10bptq33PXzPFUUz/2Xqaml/9bmdEuZsMdfUjo75tE+yZHdWcCeHdrg2Fio
	 QRIWM6T0H8PIA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39957d210f4so4841881fa.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 03:40:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqo9fFtQL+n8ZWS6WwD3jfckvwsctGptHxtJt6yOATw3TJ+REwI8oVC8xPi+rsRmF8cxGL2mno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwttZhT9LjVb+O7PfbwZIqPyt+HzifNs/Z+sshLVaFjddWTD/g4
	rP4l97bVrygUsQ3SzRUHx0ZB4PB6aprTCRTvcOKvL2Gznr1Im8vEeaw05F17YGwsxQxkuAn1P7Y
	l2OPC1QyEmrDBYAAAYotFZ3n3oWP/TVU=
X-Received: by 2002:ac2:51c7:0:b0:5ae:c62b:fc45 with SMTP id
 2adb3069b0e04-5aec678e657mr216415e87.9.1782902412908; Wed, 01 Jul 2026
 03:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>
In-Reply-To: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 12:40:00 +0200
X-Gmail-Original-Message-ID: <CAD++jL=G1-2A-h7oXxq3eUhKLLpNQq8D3Sgh9nYK_0Q107wf7w@mail.gmail.com>
X-Gm-Features: AVVi8CfLaDi0Can4D2LJnFOq4Oq48vw-nrn8jVWNhab5RVBKiDNrfMZHd8GfN5E
Message-ID: <CAD++jL=G1-2A-h7oXxq3eUhKLLpNQq8D3Sgh9nYK_0Q107wf7w@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: ARM: breakpoint: CFI breakpoints only on demand
To: Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, slipher <slipher@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:11=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:

> This removes the stub hw_breakpoint_cfi_handler() from ARM, making
> it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
> CFI is actively used in the kernel.

Was meaning to send a non-RFC of this band-aid patch, but missed to
strip off "RFC", mea culpa.

Yours,
Linus Walleij
