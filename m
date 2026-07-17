Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713F2931C6
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252269; cv=none; b=Kb5Ko5fZuSvCwup2ikmRsyNOrleZ2IfkShJnrv3bIBkO4XEO7sOgXk0BxrO5dTB4PDIhZSvwpuh9wWQAMYFSaOZnwT1bsx3qRyeJgHTAdlQNp9dOswRV+wJhg5EunKiNOrQoROQg+ccKzy16yrltoolfDmxULU2HigkSS9toVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252269; c=relaxed/simple;
	bh=YWr1fEEr7osMHM9cNOKGCxSv/BP6KcSoabBCGmQ+Xr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n13aQB3jYCxNaSuw2ymlsurmCpVxXBXFPGZT8b0nckSyUWPq8dEYa+yViuYcU3dDcS6anHXF3BcW/nriV45SccANoBLLaufMHW6PkkEFIbrSZyvQBbDqWGapj7/n1w8TDqJI4xFudZalTvoHB+GgsL8b9C52+gINmB7HO8/WVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPd9HxeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPd9HxeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9A51F000E9;
	Fri, 17 Jul 2026 01:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252267;
	bh=WgfjmeENtlavPS1Zuk5wOjnC1HjWapgUDVUzEMqlYMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bPd9HxeEawPKZsbr+E1Q3QIAcAqZd3Gl9vZG4z0wUX1vJZW3EoQQwawRqZsgFEaEQ
	 SPhTf1zFE9xQtLaQgu064E9dFuK2xdP0IJmQUk7UIKkX+bnn59PebnRTlWS7alzp/1
	 YpEI+wpanJH10DblU8rss0jZty0GaJEYuZzxiJOOeuqVsKvChItzoCv2rHLUbOo3nM
	 ihWizIc5op5EVnJTVf9ZKIoHlYG9vWSYr24W7CpsQ2estEtnowS3hRKx6YbVMJJu55
	 +ncHx2SMXB6UvCufvDIN75b+ux97a55hNouViH7UbFJJDExheHkhtcMBGhhw9QmhjU
	 Ar0Lei+4iEDuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	roger.pau@citrix.com,
	phil@raspberrypi.com,
	linux-nvme@lists.infradead.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH 6.18.y] nvme-pci: DMA unmap the correct regions in nvme_free_sgls
Date: Thu, 16 Jul 2026 21:37:28 -0400
Message-ID: <20260716232340.0001-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714201342.1347823-1-nb@tipi-net.de>
References: <20260714201342.1347823-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 10:13:42PM +0200, Nicolai Buchwitz wrote:
> The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
> parameters swapped.  This wasn't noticed by the compiler because both share
> the same type.  On a Xen PV hardware domain, and possibly any other
> architectures that takes that path, this leads to corruption of the NVMe
> contents.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
