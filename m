Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7840DFDC;
	Thu, 11 Jun 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191595; cv=none; b=L6hX43x8I9T5UfEqAMBK7BRFHc7HY5SCqMjakRfTNAeiFXv5spKlyccRI0yVz+HZF3Y+tl+rRwhe6Pn05wv7JVXB/+rMSVOkCXhaPlV69cru+5ASOsbSLTrAnjA8G2Le73Mkxmb+MsTayT7jJXA16+TiMorrrQRFZmbmsdxZWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191595; c=relaxed/simple;
	bh=lb/Xh6CZ6v1JETMo9SWyYV+gk6hUM+mppnKrC0/EHrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re+1ERlc9IjHsoaKXybunFtPYutvLQfms39Kz4Vq69F8OjDjhKHFpNEfEOk0i4ZlZ5MSxyYuGfnDpKyN3VUBK/yFpXDc3tlNlQorJ3t8yIsPytohSDbDtSpdAZeHz41EutDlIcLi8aeg4IJztKx3zTq5URf4s9SntqIHp8E273I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAp+zw0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAp+zw0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847171F00893;
	Thu, 11 Jun 2026 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191594;
	bh=lb/Xh6CZ6v1JETMo9SWyYV+gk6hUM+mppnKrC0/EHrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAp+zw0CbJJIQ4NM0uBYexikifAx7aNFXk5dTK9zgeBSbTObWApjirUISQviKuIpf
	 Fj8X+LJR2tPTZBRGogK2M+pfizLJ2qwtdhY651v1XLHv9pSG5+AVYs5p4trKGqJPDR
	 BbfPOWiGYk8N3HsTTy2YcOjI3iiCXVh3niox1fdfDS3ZLq1P0txsV0ooMyxP318mTM
	 pqHTsquON/C1nKquL0n+u+t7jaqYNKCC2Wnzw/r0EKiLykR6NtQiqNdZjSWJSBsMc3
	 0MH96hQwiTbrn90FcksFkz7PK9qEah0ev4i2sksH4SB5QP6WTPvBBIGNEClaGIFdSo
	 dZBqg5EECasyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jianqiang kang <jianqkang@sina.cn>,
	Neill Kapron <nkapron@google.com>,
	kernel-team@android.com,
	Kuen-Han Tsai <khtsai@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>,
	raub camaioni <raubcameo@gmail.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
	Felipe Balbi <balbi@ti.com>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
Date: Thu, 11 Jun 2026 11:26:22 -0400
Message-ID: <20260611-stable-reply-0104@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610180928.3093023-1-cmllamas@google.com>
References: <20260610180928.3093023-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 10, 2026 at 06:09:23PM +0000, Carlos Llamas wrote:
> From: Kuen-Han Tsai <khtsai@google.com>
>
> [ Upstream commit ec35c1969650e7cb6c8a91020e568ed46e3551b0 ]
>
> The network device outlived its parent gadget device during
> disconnection, resulting in dangling sysfs links and null pointer
> dereference problems.

Both queued for 6.6 together as the series, thanks.

--
Thanks,
Sasha
