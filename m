Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC57248867
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785006261; cv=pass; b=O8Aq4836rwrXGn2NxCrfdCRk0ttErlRdwPSNaas8F/qDIaVrUXgSNB9+9OVO8dNy12hPYOs0dHRCk7rxhaHYD+d6WLA3PUWN9tjUISZbkzb50uVcJkQ1pgTu5ctJ5albUdS53n7Vxxj0hZ1e826f+f4+RFkt0/M6+BMEOeScRbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785006261; c=relaxed/simple;
	bh=kQBfS/G022cLYikj0pGJYMUVbdaAMq2E/Ff6UFaU438=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=a16TyZmFP144FB5RtW2+Jl4+dOF9aVUko6jTZbDsKBO2uwURulV4V44gfAIN2ARWce06VZRlrxD6LQaN1UVxRbIi7sMJxWXaanXMn8zI8X/thlTv6Dc2LQekid30kFW/2wUGLV4aSZRv/RlryodqZBd3W/PeovbNar27lgioF2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=LWVYdwst; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="LWVYdwst"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e682b30ecso57601b3a.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 12:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785006260; cv=none;
        d=google.com; s=arc-20260327;
        b=MJ3aAQdUooBy70uP1Bi4aiMd3Sz0be3/kZazS1oW0hKV3X/EOQSOY8KClNPqVs+1a+
         X/88scHFNIl6UI+u4WAGnWxVxYZ+ErIZyBPrYU3DoJPSfuURGniCl2wBnqrDUuNvu0wE
         yJv8st0Wkl+ZWXPd6wUR41Td+HcFw7V352jLQYN8mvr27cpjlSSD57K9KuCjI6molIi1
         4EDkEaY6bnyYjUqAKYHg7ontx/HmQK/LkH3YJr0FSh2KSok/aBwynrh0YceQug02nEtR
         ye25uTcC+0e4JRBA8kB7aGN/Rmd45s+WpCxkI7wnQNBEj1EvjpAD8BDNHI2qzj/VArAd
         mbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=kQBfS/G022cLYikj0pGJYMUVbdaAMq2E/Ff6UFaU438=;
        fh=tlrrLvyjq42A0vDmGX4NTEOEF3GDY0pQc8OnnQBOEUQ=;
        b=aS0d3E0CBKDPjiFyu8BEXQcNryNDPx2cDsk3bC9uvYptTbSix/T6gNSqqU9HD8RP7d
         rDi7Xj3bcN6EsDQbx/5TJUds3keG/+1N+vxbH8TdlnTF0JSuCz0an3CAA6ZkYunuLa/+
         9uIgMgQbLyIo54LiyuM1z3LtUXXWJoD2PsNyaJfLkkeBbeA5yV+X9RvNnQE1aDTAAL2d
         8hYL52s7Uv2FqlpRLeVpsFB0iZCJKvWKzm8JffbcSSGNyXdJBJCj6l69pwwa2sBGFnGn
         7SxRlzQBJsl1mIP5NwyN+cTxQAwtwW/AQIlcUGC59WDKJvwi6/A8wA9Wt0O3qtOn0OrV
         SHkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785006260; x=1785611060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQBfS/G022cLYikj0pGJYMUVbdaAMq2E/Ff6UFaU438=;
        b=LWVYdwstdN9sF3V67EYhFijG82noFiMXDS+S+HKBVchke+ii3rs8fCniFjFwFar3bk
         bkh0u6X3A2EAtpCJmM9KxFKnyApDRl+yTXHaeeevmpvNMxo3svuCZhpCkkBMIA2Vwaqu
         JFZ5N0OABuiPYFOiuTi3OEJPvlmoZDoGTh7IndbAtheoV2I0aw5SpNki+yQml/jybtFf
         dRsoHLwBSX58w82sm6fwMzF69XDhCcirKtE8gyMcczwfIbngiqUdKoBIshSg5O9clBU/
         oPXENZ7CMyT4eLhj693jPuGlE5m2g/SEaAcxkMZeXw+g8zLdQSMlf6yEsW0h42y6ylr6
         +lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785006260; x=1785611060;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:references:in-reply-to:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kQBfS/G022cLYikj0pGJYMUVbdaAMq2E/Ff6UFaU438=;
        b=PpjNje8tLWfMQ5uY7tmKFy9vgy0j9rpb3VSUvypxYjGQrVg1O/rOhKsDdGsMmJ2eyE
         EJ8ITazLZRsfZ5lMTyuUv1RK4eKXK5ksHzWdckMLlO5ojKEFe5IJE+mFXGDnt75+z2gN
         YcXYfqSB1vyWohDZy4GA4f3go+ueWGHBzZOGYzXFxb9VG1EBiBcrVUhZ80x+tieuxp3y
         9t2INlFn3NAI1xMUtlpc6semImDvZZPHrIeoSzHEr3zrwuHsdHHB661vC77Q52EkLG4D
         DYvVIi6Lngnpj0Y9Yuk+B4sPGvsE5OK8NWlDhxEn9cqgaytXaQHgbedhlWUpUlKNp1Ys
         HxSw==
X-Gm-Message-State: AOJu0Yzcv7hU7FFiQQk5COWmrfMmJsUxYtLrsXMsqHutbrd24UDAp1ey
	3hu5IojZprgDUavTVm8njeUH69LRmjLfx01llZyAyCOsu4AvgHqyKCJF/23QfzRKj/MDW/tlgjc
	TkvhgBpPstory2wg13f0ZSDOAxqTW1X/2DPqQp94BdHE5eg16Q20vOg==
X-Gm-Gg: AR+sD1151B95a3ity8Pg95o9KAsEvuilN0N3pARPaJgRFJ9q4ZYdq/I3cwt2XnEt0VB
	FDAN3wXXPsvQMzTnSpu5MccC3yGWGaD56mfpGbkcdr7etV6gSQpq4ufQ7BDIvriOFWFJw2ASb27
	to/U0RWKZun/g4AXHBoxgqcH1FIPdn+pzedCELsRDCr5A3ZebFJdL5uu0IrGeujjQDRmvDbb/3r
	BtFqgD5OMvN88OXCVl79i1ytmEOmRqpb2DMf9KhtX0HfdHCeBWgJh2ZeTkJ6Gl0bIGkZ1fars0k
	4MPnKEMicDZ9+JGQKc3qDJx8T+6SsZOg0Vy8ugEW55vjvXw=
X-Received: by 2002:a05:6a00:c8f:b0:848:2ef5:50dc with SMTP id
 d2e1a72fcca58-84e595a7ecbmr2131833b3a.36.1785006259674; Sat, 25 Jul 2026
 12:04:19 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 25 Jul 2026 14:04:19 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 25 Jul 2026 13:37:44 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2026072039-spouse-automatic-c20e@gregkh>
References: <2026072039-spouse-automatic-c20e@gregkh>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sat, 25 Jul 2026 14:04:19 -0500
X-Gm-Features: AUfX_my2CP_RJF6PWesjxJDIYpL9X8znDBoj0dXqiWcpwfAXRKag4910kSrvNRI
Message-ID: <CAPdMp1oUHnn6T=OMxektvzEdxBm-jfDzACCwJVS-ywukyzBbhw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] accel/amdxdna: reject user command
 submission without a" failed to apply to 6.18-stable tree
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, lizhi.hou@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I checked both AMD XDNA failures on linux-6.18.y; neither needs a
replacement backport:

- 261c1fe3327ad24508f54552c6366e3e4db82c15 depends on the later
debug-buffer/drv_cmd refactor. Resolving its conflict would change
6.18=E2=80=99s existing command-less aie2_sync_bo path.
- 38953513d7313992676d4136cd425cdb70c6278e fixes AIE4 VF support,
which is absent from 6.18; the supported devices there all have a
cmd_submit op.

Please drop both from the 6.18 queue; no replacement backports are needed.

Thanks,
Doruk
