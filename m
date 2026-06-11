Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B3413244;
	Thu, 11 Jun 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191593; cv=none; b=pDYf0UdhH3z+kCbhqalrxODjXXDVALpYaDEiNptyz5RPtorKFfpmhrqWywkNfiLszx5W7e6Rrx4VuLkrOcflwXsPpHPK5/jxEd/rLXY6mKb2Y7mfhH88r0QangjKSaP7e1AGCzqK2RaJDsgpi564WzYgfc0slhFUSSEAGr6uzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191593; c=relaxed/simple;
	bh=KrfNtD7eh37mvZkNAIwh0UB4EgeUTjECxRLRH9Xmukc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkY8cD6mNMt9awC5yW/Ttg5BCJR0Vag9O2UdZqRPEL05sFbFI0QBqfv0y1qq3x/ygFmmDjzuvB5OJRHsAeH87T5Wy4bP2ErIzf59WD61HxqgmXk6uV+dT2OyTq1+IdUt5m7zLxDb0bj/7QictArqZxfx+XMqsEyYWaMiQfoipnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnpnIqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnpnIqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957AD1F0089B;
	Thu, 11 Jun 2026 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191592;
	bh=KrfNtD7eh37mvZkNAIwh0UB4EgeUTjECxRLRH9Xmukc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EAnpnIqJ1ZWcr9M7BX2rPQpw9qiR8RpcxbNayg+RFC6epD3T+nwkzYrSRj45fiNHx
	 N77jmY7cisF3eDzYOYFgSn2rpSvvaNyqkAp5LPU6fKc0F1IhUKCOZjDx7AYcG+/lAV
	 /uyg+KeSwGqOsFl1fddL2a+f7ofeJe+Wkr764pymoFppg96kETMQEghdoxhzHVOURD
	 Wp7f9YCK63PoItpGrwZ97amlmu3XpwtHsj0GXMnXT2ahu/Pw/tudp1l53bSEyWbZtn
	 w24qv5SIlcDKjDlIyaNtJRVdNatDQ+MKpYoWfWEVkewpP8WHLdBzKvM4jIBuZnsUDB
	 vUKieW2pXjFvw==
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
	Felipe Balbi <balbi@ti.com>,
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
Date: Thu, 11 Jun 2026 11:26:21 -0400
Message-ID: <20260611-stable-reply-0103@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610180841.3091635-1-cmllamas@google.com>
References: <20260610180841.3091635-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 10, 2026 at 06:08:36PM +0000, Carlos Llamas wrote:
> From: Kuen-Han Tsai <khtsai@google.com>
>
> [ Upstream commit ec35c1969650e7cb6c8a91020e568ed46e3551b0 ]
>
> The network device outlived its parent gadget device during
> disconnection, resulting in dangling sysfs links and null pointer
> dereference problems.

Both queued for 6.1 together as the series, thanks.

--
Thanks,
Sasha
