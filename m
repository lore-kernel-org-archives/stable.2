Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC9255F28
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259177; cv=none; b=PXpICNPfx7/zYtbv9vRStBFjwQgDIp7NEdqMZ97B6oEsRDsuTejXRQ/nyuMwRj/+Z3MkqHymCPLTDswW+R4SpvmJQaRnn1tgkCL9IeNTkUMhI4jAH3Y4LpvFNZud0lnEZzHLao2rPX3JYpjzyKVyRZLDkkikhmju6BVsN2Kx6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259177; c=relaxed/simple;
	bh=WQmFHAI99v1cMif0KgogEHAyCvt3FSObu0aHSWXuIow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyQ48dbS9Lll9lCix184qIURw0hbqINu9HyBIHSvzHKFm2UZ5PbAUX38Z/b9dwMn6dBmyDpS/die4W4XaILG8mNl+gCV7VWhTfAYPFhIt1MGsW48e+dSlEHqx13J+aO34apgUdEHNihvZwmIteeDnnMFbOwVfH4FbRzG64qfEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awRS47nN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awRS47nN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4741F0089D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791259176;
	bh=WQmFHAI99v1cMif0KgogEHAyCvt3FSObu0aHSWXuIow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=awRS47nN1lY8enGymoI0K4Xcwjgkemcqt4/O/POHcD5UpaM5Gl8goE9z/m2ey8IfX
	 Kv+zJGv8x9DSsjZvpZ+UeTj+TB/HuTJLLly64cmm5+px5PO8HP3j4h98MS3Tk8YNkm
	 e9d7BPl4CbMaIIkF82fShWerqp/mNsDbZ07+svAMbbWzRQgQCzOd7juGxRN484kqhC
	 2WqbS3XF3Wf/PnD7WPhToAEf9NC5/K2bg6OoKHGbbKKnlkzJYSIKNvzO9mdXsSKsKk
	 CoJQX7F8y8vKfR2ECP2xmGB9369sS7ijirgaRQM+YttfvjJri4vQLUs9/0QfiRff4J
	 7o5x/UCWq9CeA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7fccba9c675so349354a34.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 20:59:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxrX1zm3UVefIICdYXGm198+sqZD6e8BJa0a/i8topcyk1o1EKj/fgTIX5Yj2hWK/yoeRk43xw=@vger.kernel.org
X-Gm-Message-State: AFuF++nep7SrLMzdAFJQX37QEj34c8mx7DZL7M93Kotg8ZCJrw7ceP0A
	RrfJn2HiQ55G9ZSxvF8QPSJukAkeo80d2elrHVxi0GH5lWce9Tl/CCC0VtPGNu1dY6rHYxwUBAP
	scFAU9OZ8O4ncxk8ofHV3zAUpircNX/Q=
X-Received: by 2002:a05:6820:1908:b0:6d3:abd1:9b92 with SMTP id
 006d021491bc7-6e4a7d4ee70mr1048558eaf.56.1791259175300; Mon, 05 Oct 2026
 20:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005023812.130639-1-edumazet@kernel.org> <179123498942.434549.13440734253618262332@kernel.org>
 <CAL4WiiqwLH51iXsqmuUKTeP4Mo5Tv-qZ_D_MzaGK6C81nxQ6SA@mail.gmail.com>
In-Reply-To: <CAL4WiiqwLH51iXsqmuUKTeP4Mo5Tv-qZ_D_MzaGK6C81nxQ6SA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 6 Oct 2026 05:59:23 +0200
X-Gmail-Original-Message-ID: <CAL4WiipgggQfFhc2DMTaBF+j0N0A8wg6TDb3gsEfdDAnPLaV_w@mail.gmail.com>
X-Gm-Features: AclHuK-b2Ms5MyWpBUCSQaVi5Vka2572xYI4b5qcUJXxeDvEvRQbYAASAqOr3Jc
Message-ID: <CAL4WiipgggQfFhc2DMTaBF+j0N0A8wg6TDb3gsEfdDAnPLaV_w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small packets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 6 oct. 2026 =C3=A0 05:56, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :

>
> Looks legit, I am cooking a V2, thanks.

pw-bot: cr
