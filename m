Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC947CC9C;
	Mon,  5 Oct 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208277; cv=none; b=P+aUC0JX65YeNYaObysxbKlfZTOXUUlr3gMmrOE2z56iEw9VHA9QUekkqdYqV718TZx3NyF1GYdiBN4N2ZRNw1JoAIE9nVYIgxFaEvIDx7US6h1YP5Rz5s67vGXLfV7Gy7DUTEOJdnPh9+Y5LV9dgBLkud3sSafieuLcPvqjo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208277; c=relaxed/simple;
	bh=9bBYlvk0ZFG9UjnNElXnMvb1jy0UjBCEJNuZ4Q7F0GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdGqUtLLAB739wS2U4VpTNb9Qncg8hhOhuP1iSZx0Fr8o4KLj5cZ3GMpmwSMihtx7H3igZXZ2NAMrFKxPHzs6lgjsgx+Y3Uj4iDaxiMsjtQO8MwqfGLACDUl0Ru/6UVraujkTgCbY0AF40Z5DzA6z5jPqvhgZwr28uih0Rt3VnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLmzyvT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLmzyvT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5D91F00893;
	Mon,  5 Oct 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208275;
	bh=h7gqiFEy/echHNwt2H7114df9BVhAjMYiVV4IWazL2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLmzyvT2ibOlunNeq7PBuW4aWXY+546ite5hhr6LshEEzllIfJEp7Hg2U6rB4QRDL
	 LAf3FGyzBj0TPRMX2zhisvaCdWALDTIo+w4rfTmCovMKpLaY4M3KTd13iq6O44wvsd
	 UzfK0iU5e8hjDjsrHcfa0xvaliLW8w3X5q5xpjpKh5hYItff3w1AEeV+AXPBjMV/h9
	 Y4aAl2NB2ajqtWH2VaIXb2OkpGpTo1voMex7cDzp3Vt1AZ7TyhjWgAH+XGYFxa9EvX
	 lX1WXg9IalMo/4Xd24m/faN3vccZx/IlD2uBvTzy7qGUHbM6yhSZndNiWvAvJL5x3o
	 6YQH6x4dLwfLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: Patch "nvme: do not reset controllers in NVME_CTRL_NEW state" has been added to the 6.6-stable tree
Date: Mon,  5 Oct 2026 09:50:23 -0400
Message-ID: <2026-10-05-1-daily-reply-0002-nvme-ctrl-new-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFL455mC4cyq1TZsB9PXCZQQCWRjxcDTZvFKdoARCMU1e-+UrQ@mail.gmail.com>
References: <CAFL455mC4cyq1TZsB9PXCZQQCWRjxcDTZvFKdoARCMU1e-+UrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please remove this patch from the stable trees.
>
> A regression has been reported and this patch must be reverted.

Dropped from all trees (7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10). It
stays out until upstream has a fix or a revert.

-- 
Thanks,
Sasha
