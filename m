Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A60492E35
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463644; cv=none; b=tKbND5RZxnENG9pcxqEBxcW6Hu8ktuLXRxOF/6ZP8tPmg8ndcZe4nFiUF4WmlAOV6GVnwu3Wl/gHj7FQ+n6NiMWYSo6nQa4KFWBa6Fw2TFlnuOUxWeHxPMXljYgIlwKhvAgFL+Z2GcwepYzEUJVyXjaKWZvyoyu03iO23Po4gZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463644; c=relaxed/simple;
	bh=LlMO6iQODPUl//akDACh6iLTLYAzcsIkYiJxJNtBM6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAZGxrc+yVQzTiblFTme5fbciHmquia5tpGPG8aSrF7FjuXKgL10HuakE3HDqADa85mAz372PS68GDFVMa3CNdbqHXf5hIcDb/tZ9WbFPw4fpgR2Uya1eNa0qBGTY+sMygVhvH/sI5Z3dL0Lf5eQOBz4Ro3ZEijSgZBWWYXtEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KhzO33ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KhzO33ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65941F000FF
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=KhzO33ny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791463638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxDOQiXRdTnPHTu6HRM1AHIJABx+3lat/A0hYbuPbLI=;
	b=KhzO33nybonBlNRJLBIBENyzXSq++HOjT7obPD9vEDGQThqzbzUGjpGRvYNkkXR5DVmM0f
	nys1Dfo6vMrUzBQJStS7drTEvh16xEXLR81plcmv3/uoHV2BKtwIkLFQnPtfprZm+sMfvQ
	lNZmLxKUdmFOCgX3Phoz8sGUavIgGPU=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 72db2ecf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Thu, 8 Oct 2026 12:47:18 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so8815267a12.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 05:47:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwyqONVTIiobVW2ixzLHlHYE5kECebi+P/d42YX0jhiEsU9x0xRUAqgJZHFurNO60m/nevFoP8=@vger.kernel.org
X-Gm-Message-State: AFuF++mHlosdzzgjHNvLAGi4hGNldRn+EOkqqh1Twj+akmOQlrifUizu
	K5+ZeJ2QIjhcto7HVTN7mMAfSkssN7tpZjlssjEkkF/z79yYZe3r2FzKPZTGbd/lqa4CwUwscq8
	mcRhOV6++Fk6OjHsQS7T/JV8hPLy5Ntw=
X-Received: by 2002:a17:907:6ea8:b0:c2a:704c:8c8e with SMTP id
 a640c23a62f3a-c317bd901cdmr531801466b.11.1791463636243; Thu, 08 Oct 2026
 05:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <179146356621.2527009.11001901701574636880@kernel.org>
In-Reply-To: <179146356621.2527009.11001901701574636880@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 8 Oct 2026 14:47:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9rypRmL0tA-20vJumRBckpbzEaBXdE+xhMqi5M5OKPFhg@mail.gmail.com>
X-Gm-Features: AclHuK96wsj5ZjuVQ3gcwk4j3i0Tl8rQf2A9V50RB91AIzVaSRqAPpdX4EdBA54
Message-ID: <CAHmME9rypRmL0tA-20vJumRBckpbzEaBXdE+xhMqi5M5OKPFhg@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: netdev-bot+sinfo@kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 2:46=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Yea, I really have no idea. That's for J=C3=A9r=C3=A9my to elucidate.

Jason
