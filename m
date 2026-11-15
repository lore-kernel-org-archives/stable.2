Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786072;
	b=q287xZJT/F7BNZK52sczI4az1KfpdvMJ2rDsJLWuTSFwNVuCdrQ/c9f8uSsGUFS1tNJW
	 DlpwotnIpUIe7hiYwpV7ahyEcBoKCb5OoVjCQGy6HPKhRN2BXd3s6M/prl23Fux/2A3Ki
	 7eJFMhHcl/hIHsJbezCptmDMbBTBpgXqetqqRe2QUVflMW0k4wMpUrp76SoUsRPSmktIB
	 sw9/KAflOCoFEohrr90Xz8/GHoAynFKAZGXipAEvb2CF0kJc5xn4HtiVIy3NY+N+G5akB
	 fWvBigsWpaxMjGco53LNgZBqcW966tqkxq5BnhRMykZWCmgG+VJY3SSlyi4xzsOEFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KOp7dJxqcUzkx3Cv9PpbeCc6JI/LA/dmPcUuUfRQJgk=;
	b=2Quil3Cjapa9sKKR/uMxNJxuUzHif8bWkq78d0Xvx84qvlqX/hGlgGpBUi8J6siVJHG6
	 8h22ElckpUpB9YIlfnxtMmmvna9v1X2l0hEmfGIQFIShOL7lgWZcar87ZUtp6J38pGcv+
	 Y/C346h4618Obj3YLoYKdEYirDQralT6e12SbWFQQvWq0AOybdZ1KVY0WbVJracNAh+7/
	 ojFteL67AvEQHpAUlElN8gIX8nhnpGx7myBMwyg4GwWvWI21fgEY/Oh9/2e2EKCmKFqFe
	 0tawrVqdnhN2sb5iYro4UPdtLVm4fm9Ap9HE9YyGqVRCRhgamuh32zyp+INCXiSfwkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPrQZ+nL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB2606A31F;
	Sun, 15 Nov 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPrQZ+nL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44F71F000C5;
	Sun, 15 Nov 2026 23:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786072;
	bh=KOp7dJxqcUzkx3Cv9PpbeCc6JI/LA/dmPcUuUfRQJgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPrQZ+nLgfXpoMSmD2+8LGAzZHDHeKASJiGswlRWto0T8hdlJ3oZiwjUZnmje58S+
	 ohEJRViKqgavc2+rFwW35s00WTTBlSOSEt3hDxiMPqvh0HUEmpXZY1i6W6fYX6TbMe
	 wuED8RolKXWF9eCOS+HzJC7IlKSd1EHPOscXTp1+QEJs+cwK2tMy6spq1Qg5nZCvEm
	 M25ICAV+sX/LngjEWMI2CkYjMkfRTnlCq0QhDYLhE35hqY92jXD1W6p0W1S0Yz8im3
	 Ac9pjdUab8Vj5iuebSb8WmaGRjpbjocxaQHgzMXagjFPNh+6ER0WZ+f6vCHj5XwSk3
	 b2KlORh7PUQPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: Re: [STABLE 6.6] Bluetooth MediaTek controller reset fixes
Date: Sun, 15 Nov 2026 18:41:03 -0500
Message-ID: <2026-11-15-1-daily-reply-0002-bt-mediatek-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114173550.5736-1-lucid_duck@justthetip.ca>
References: <20261114173550.5736-1-lucid_duck@justthetip.ca>
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

> Please queue these two for 6.6.y, in this order:
>
>   a7208610761a ("Bluetooth: btmtk: Remove resetting mt7921 before
>                  downloading the fw")
>   33634e2ab7c6 ("Bluetooth: btmtk: Remove the resetting step before
>                  downloading the fw")

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
