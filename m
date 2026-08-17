Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26229E11A;
	Mon, 17 Aug 2026 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991060; cv=none; b=b5VblA1nrRQDZjz3N0zN4POVpUwj+cu2TZjL+6jaivVlR7XNpby65RQz7gultQlpNK7yw2b+IOfIv1gg0Ev0xaKGrpPodgiev5qe7Bc5T5U4BOrHwGlsghxVXmXxFl+1MvnAcUIYmzGjwXLl1AxFmydWviwyD8PGfZdWt+JcjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991060; c=relaxed/simple;
	bh=vy5aeHD8d+Jx1qMGwwl5D/7Bi3rGEWzbwGp1Tk7bSPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRzOLwSarDjKQc/DD+iA3myrL0Hibx8XD3rJfCJYriCAA2WiAy6+WapgVwWoK+0iHpa5NnfSL8kej/LjttThORpZLmvKMLGgj06rvStO7iGLb7yVNzZf1YJzIaDt4RHxpgJD5hk7H/SJY8avHpUZjlayZdS2lePedT51G4+anew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j33J8SpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j33J8SpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC171F000E9;
	Mon, 17 Aug 2026 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786991057;
	bh=vy5aeHD8d+Jx1qMGwwl5D/7Bi3rGEWzbwGp1Tk7bSPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j33J8SpBIEotOP8DhEHOuKEtjOPRTXcET4HUd1Twrbxoy70DMh3OJGmKV0UiW9o+c
	 k7CokEMVkmuueB5Q0+qu5IK0i6uP5PvWwcDGHf50qkDYe1x9BltWLSZfdqdS4A8FfQ
	 FaE8QNl6MpnFogd+K8VaKN1pMU28jwtT42Eax3ht91iyEAq9yfNtcu076eUyKWlxyP
	 TFgopx0VgjUrNMJV4sCmFlXvkdnTGObyHxw6nRhW+O0fLTu1eVkvj+pc9ZTpq4S/Jm
	 TCzuzEJA79IBPBGpwb/EHkytvYnEcscqDeVIysh4wOQpz0WFPV0EOpJ4Tk654icHpQ
	 JBFFkHdQ8khhg==
Date: Mon, 17 Aug 2026 11:24:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org (moderated
 list:AIROHA ETHERNET DRIVER), linux-mediatek@lists.infradead.org (moderated
 list:AIROHA ETHERNET DRIVER), netdev@vger.kernel.org (open list:AIROHA
 ETHERNET DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v2] net: airoha: npu: load the firmware without the
 sysfs fallback
Message-ID: <20260817112414.0e82a395@kernel.org>
In-Reply-To: <20260811181717.19339-1-sochnev.v.74@gmail.com>
References: <20260811181717.19339-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 19:16:59 +0100 Vitaliy Sochnev wrote:
> airoha_npu_load_firmware() maps a missing firmware file to -EPROBE_DEFER
> so that the NPU can be brought up once the rootfs carrying /lib/firmware
> has been mounted. That mapping holds only as long as request_firmware()
> reports -ENOENT.

Okay, but AFAIU this is a hack. AFAIU PROBE_DEFER is not meant to
be used for FW loading. The driver module should live on the same
'partition' as the firmware. Either have them both available in initrd,
or have neither?
