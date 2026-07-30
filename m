Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F237A841;
	Thu, 30 Jul 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379253; cv=none; b=tsdlqnwZdrjhIdvO9XoijMShdJoof88fe5ZaR9Egpkcce5TyuN+he1Q9Kdk8U/Wgt2VN7OBP1VcfW4fJaGaApnsqbIONYyJrKgXZN4cook3vZsV0OMVOKPSrMljM1gc4xRxv1J9QEtn/8SpljXbPih4E0kPprX8i70rOugRIqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379253; c=relaxed/simple;
	bh=C5thqaiBS/KwONQrlwRQGD4joY04ICTAEaBFaPHVEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxrJHaHwexqpwAPcJRzShDT+mnbiYOK75d1s7XTGOclYNthKmARDRgBQPBXhUaFQGfXDg8p6Uy1q12N1FS/zIZiUPyo5gApvIUjHKq45V4zjrCQo6/wh2Nr8SvqKneMyPQk1XpXLaVfewBDflL7uTJJMVbjzXErDnrFg53sLAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI2I3HVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI2I3HVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4B1F00A3F;
	Thu, 30 Jul 2026 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379252;
	bh=g7mUNg4HjxPDgi6PVH7O1BrjSAaSG3evJFOjazEGxXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI2I3HVaSCXenvDCXYSh20qUsfpUtX1FV03mHY+b+7c/YI/rFrZti0rjkM+16Hk5T
	 YOvZSljPaPCbzRQhqebv9vJZB8JXFOt73oqhW/iNtaVyhc+OE1rZJ6nJTzCv6gpctz
	 ftN1RiAUdDNGcuq3VlgaM50lp9OZDfkxd/0cfxZ0p6Wdnse4cc3i7vsjsFGhbdam69
	 0jTNeazExOT1IelFvKv6mbojm6NK9+rPrh94uFenwofG0KVkIxWk2C5CC43k9AkEa1
	 Ghjcbmye6Mw0Z7DBKFmHg8bXX+bCKvipeRlBMf/iWRzZ3eArYjUVznbXDKcooValYa
	 7gTRcfPGGxJmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org,
	syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Jay Wang <wanjay@amazon.com>
Subject: Re: [PATCH 6.6.y] exfat: validate cluster allocation bits of the allocation bitmap
Date: Wed, 29 Jul 2026 22:40:18 -0400
Message-ID: <20260729223316.stable-0024@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728204938.14116-1-wanjay@amazon.com>
References: <20260728204938.14116-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] exfat: validate cluster allocation bits of the allocation bitmap

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
