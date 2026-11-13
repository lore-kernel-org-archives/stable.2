Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537226;
	b=4a22jcaA4vp99NHfSp6fDz60QMpbK25Dv8JaXPwbrsK9GUq6Vp0qH71zL0UT4/LEUZPR
	 NAqHO8gzv/q0I3lOf6PHuJ48dlcCLndmE+75SEruDm0JAgZEhqvpms9N/pwaja4WzSZoE
	 vYiobLixe3U4uKBwuML08/5P86tBt4mgZscg9/gQrHRybnxVOVLd2tnaWQ05Jffh0jfzW
	 UV1PUPZpv5/24hYoRItArIgRsWxcMbMbsb+L+7v3trlcvMzgY30JQfiUhY+yyIarlHtYT
	 VjWJSK88PyxhCyGnLMikqa2sqg8ak18LFHgUFNQSC7Tc0XstoC8leQvUr3/3aJ8MXfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537226;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4ujIVcj2O2E/TFr1vfVaxjopdtKT/hMjme4cS1f3Vdc=;
	b=JEWJmjKu9pJ3ViyfdsQgzpNxcV8J2diroK6ga2QE/h/br5u143bgCTrx1Tfw/L5U5t58
	 evD2dy4gcyrtBxFerdko3wevJY84eRROEMtGfw6lb1KA02P6xzevFE+OrwAyt1U8vbS7O
	 mZr5muaWAUBgu86FpwcgMPqPB8fC9Wqrip6NREU3ZF2CoOc7h05urcbYUX1ARhQi8jfdd
	 zh0XQkVsUUj7wBTPioJm9lF4cA15qbmpd3ENhQGhR7zcO0DKap3DjJpq33pCrc6k22+za
	 2OBDw9ZRGLExJcndHk9NC3w54RuXgiO14p1kCpo3JcwmliNs34bZLccbFERUPnj8Pzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mptp4V2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F37606A888
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mptp4V2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C071B1F000C8;
	Fri, 13 Nov 2026 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537226;
	bh=4ujIVcj2O2E/TFr1vfVaxjopdtKT/hMjme4cS1f3Vdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mptp4V2yhHAFPlYRJCZ76EvQCiMeQRaU2Vf1yPnN1caN/Xm060hbGdO22FIHcOVXV
	 OBw9OzufXx7oxigWUAexQHy4YZHjj+3zmjJA0ub+bezNHHNAR3DEmZO4v1aAWIsZsB
	 tnAwBxPW2Wf/9EEH7qTO6Xx79Le9DgALolMMMMDU7dHZXklMDANw6BByCcWxAQEU5d
	 y1szegLcpxwhEcUtZSlpWlJMDZxoYuYv6hl05Ndii4XXzbhIss2Brx3PMRHBWMrHQk
	 3R6wSRiSIUAgGIB8kG+YXShZOWNOAh3RPHxfvX3eHETFdADlpkuVhT5QmHhlVGNUuK
	 KBl7ReBuUcGoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Fab Stz <fabstz-it@yahoo.fr>,
	Marek Czernohous <mczernohous@gmail.com>
Subject: Re: [PATCH 6.12.y] drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
Date: Thu, 12 Nov 2026 21:33:25 -0500
Message-ID: <daily-reply-2026-11-12-5188480653@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179447220251.849346.14034519032960424850@gmail.com>
References: <179447220251.849346.14034519032960424850@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-12, Marek Czernohous wrote:
> [PATCH 6.12.y] drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
> NVAC (MCP79/MCP7A) uses g94_pci_func, whose .msi_rearm is
> nv40_pci_msi_rearm(): a re-arm write through the MMIO mirror of PCI
> config space.  On this IGP that path is unreliable; when a re-arm is

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.


-- 
Thanks,
Sasha
