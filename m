Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE430DECC;
	Fri,  3 Jul 2026 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051638; cv=none; b=N9S4Eusq5YgODhu11kq4MMN0rKbHxFARylfZ92ie/cl0DaauLwqxTQ1nMXTrbIsTb2GiOjqGNbNgKwdw77iDC7v6PUbB+xs5mtpm1shIoMU3n8bVKkVvCHTg714bb+h1XAQOQ9R2Ib0KEADCycacW/mP+le2wVxK2X+HRYwHWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051638; c=relaxed/simple;
	bh=Kxik0PGP15X1QTMvuQHMbi9WbmUSQt+JurQoH3ADVS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs5ot9d/pFqtkApA2vwyIRC+q/9KaBz1kywVI4xgk6z6WrPjUnYjuKIGSxb+m5Nli2kwVf44XABL1nbVDWylX25hRWoJv2EUHVqh4zfvoZF4uKdqlDBOegwNY1J5thnfumHTUywsS7qRw+AlkCAO922NFBGoeKBf7ez/rP+oJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN8S6rnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN8S6rnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953CF1F00A3F;
	Fri,  3 Jul 2026 04:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051630;
	bh=V/IDuOkOULpxERfKYNtIRcT8Y6B+PBtsCGeyRszDJiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NN8S6rnHQfskr2AlUKu//359uBhPBK/70zx27rEM2JidQPnd5G4Nq1SOgiF1bOUcZ
	 F9RJobWoJzgFj/wHAhPOYgWINrkWmSSq2RBMPL28LXx9fb0M3bRP+snQHcUlnAO//s
	 E3vkSs3UYyDfGm70XyBtMRa7n2FvmP6DvzIoaK9nW8QOexe7KcLBS2SrNwMqdtTVzT
	 /M+hUxr9ElP+OxbLLg9jIQ9FwI18/FS5a1yV7ZKGZWO12ZYgQiQTjJYjKAbyEv5iDi
	 hU5nYJSWLeoh4Q2RnMt8wZtoBmoOINJ0Qg1uP1Y/kI/GcOf/h1G5XuRqYl5TX6gihT
	 MqKb//Ui78YTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:58 -0400
Message-ID: <stable-reply-nvmet-tcp-515y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123757.99897-1-lulie@linux.alibaba.com>
References: <20260702123757.99897-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 08:37:57PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 5.15.y, thanks!

-- 
Thanks,
Sasha
