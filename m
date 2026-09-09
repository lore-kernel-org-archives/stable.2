Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D441BA62
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985605; cv=none; b=VuJBDfmoRq/ibgL2G4dDrBQvNYj1B3IMV7sXmgVC5YKmOjxLGdKpi3zxLUc2vyL226LeQcBYZoTVnf97D7n9v4DGVioTr2//WN8jO8rMjXLiJjVxglQu5kJLlbGcji8+CPYO1GrVhYwgTioJqd5QDVKEzXoSyHRf4nYJQes8OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985605; c=relaxed/simple;
	bh=f4mDdpYVK5i/VHpTZZ0zelfgyanjXAJ4DLh7QWS6B0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOUVX3hzH/gdMTY4xqpCFDCzs97gfQG5PGWTfqqb6m+hwYDwnxiPlEki/ofUHQChVr+0u6aWlvDe89msCLG13RA/34nxuUBD+5xRx7q99Eq3uctA0I9tcDVsF5kAiL8ZPuMVCzLVIBLVrR5KVnGJxKKKw3xLR1FXwkGK1UtYORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovmb28UC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovmb28UC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CA11F0089B;
	Wed,  9 Sep 2026 20:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985599;
	bh=ZuHvuOCHiApkM7PW4j+54Ep5xAC7w6GAOyGMcFfGdhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ovmb28UChEnVfbJa6rhnnrfwf8DNeJIBH+3VbaKje+XelvYzpFD7CygSbx+TTn7Pj
	 5xVFJ8E0knQUw5LGdJiairfo7wbXeEeDZ4YRvBhO539E601W/dYOE0xRlvfop14PT+
	 AJ86I9m5AjxLof/OJMU/xrM8I+SAtyWt9gPjbepQDP4yt0TZ+Teo3CcOq/XwbdqoGe
	 2goT5cM0fWeIIFm5VYNwaeojzC7fP2GxNwMhJT123xqniFsHEXDbVCwdMiyTLVSYzu
	 CoRMHUd0OJGA1g6mz5D1Gt9NXvm+tCXlstyboZaxkIeTTs9Ecaf5VBX/x2Ayvx5XrZ
	 q+Y0e2vGMvAtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kazuki Hanai <hnkz.64@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6.12.y] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Wed,  9 Sep 2026 16:26:02 -0400
Message-ID: <2026-09-09-daily-reply-0004-nvmet-auth-sq-teardown-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909124048.1793677-1-hnkz.64@gmail.com>
References: <20260909124048.1793677-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nvmet_auth_sq_free() cancels auth_expired_work with
> cancel_delayed_work(). If the work has already started, cancellation does
> not wait for the callback. Transport teardown can consequently free or
> reuse the queue containing struct nvmet_sq while
> nvmet_auth_expired_work() still accesses that SQ.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
