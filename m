Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7A3B42C4;
	Sat,  6 Jun 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752693; cv=none; b=K7dAIqPrbtYW1leaibC94afVxnLK2lKxEEl9HnPEutscP+SGbnkcB+gFRsE951JwPzh8pnn5XJik3Gbvemcarw7S3yn09V17M4blY9WIgEpCZR8HDfgTs6PA+ITt1GquDc9Ckrm6rImI1S0u169qK8Z9BL2x0FgHI5dw8EjVxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752693; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMiVy8RMAH4yGTte0yqBtbDmTHqg1/kZFRlrmL4jkyuw/3UtlmRJTQW+BnDsONaAAf/QntSRLu8fL1pY6EvAYHy2IBzgYg4FNMQdg6Oh0r2jyokxWeOc+kCD6fqPEb5bKP3siOa8t6BrUJgqSV/ovWg/DMBJfUAw9aVr/IR6qKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTb6TjhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTb6TjhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF481F00898;
	Sat,  6 Jun 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752691;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iTb6TjhYhNX3iVBnTo8NfKWNj58ai9SMmFXPmNjl7Z50pMJ++zumPBAEE7Fgtk74m
	 GQnEYSyH6Nt8aZ2kWRgP1oqBy85SQxCphK392IfJh0sHsCuC3a0wQ7FOKjfC9/oM8q
	 o97Q3bCEnAqI8LxEAqaVH/RZxL58mtZL3fK71yWo+OniQ1MiVAer1kWuJzODkuzSWu
	 dU/XzlH2JL1ZRaR8yjgfOYDxvlHTMnMD67aTaZaYxeYOOqqfEUlJD5tKZOqyM5uzHQ
	 xNAxkF4Wba9I6KJ+WS1Zn7nIqUyH42n4bl8n196niwafb3RPFEFg0e9L9be3R3BuoZ
	 47HptsMs2J/Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	Dmitrii Chervov <fary.ru@gmail.com>
Subject: Re: [PATCH 6.12] iommu: Skip PASID validation for devices without PASID capability
Date: Sat,  6 Jun 2026 09:31:18 -0400
Message-ID: <20260606-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604134753.57739-1-fary.ru@gmail.com>
References: <20260604134753.57739-1-fary.ru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
