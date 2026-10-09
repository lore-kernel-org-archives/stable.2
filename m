Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824473BF676;
	Fri,  9 Oct 2026 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565836; cv=none; b=ZgGqKUBZhttULhtOkipnAWXL4f0/RpuZDi8qdZJuQQXjrS6XktWkB6FzKncpSt6WQiEZa6cWOWR3p7wzRUFLSI9GYQM7rWrDKis+uqSWPpJFGWLmgeH14QPTiEtdSfZA8VXMsdexFEfztGPmFAH7tfVpaDwEB23PHsqZ38CK8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565836; c=relaxed/simple;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EojN3C7GxNYrqFWk6TUbUzc9qfd1k2dpvTdxWf9XmQOPERfQSDw5ZuN5fjAKDH+Qrfo3xVM5EB71OtzclSbA2nr/rP+nGOuKW5zEc+gZvu/d/97x+GJ3rG4/7cRyNRSpqHhnhkUE/kobOiJZBrgLNUupC02bDiYKDomXvC+zNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z634Y5Iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z634Y5Iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25231F000FF;
	Fri,  9 Oct 2026 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565835;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z634Y5IypidQbFnPdfvPWiyXUimIZt5btlC8kDBCbPcbKddDUvLPCFmkDmmSkzqPF
	 7ZqhSgd6J+zPUmKiIy0xFAUiviT5rw9W8j5hXZY9i1ephEurVBII7GhRb8cXSqvX1Z
	 JMaekl90TGTVHtH+FLrjs9QZHRrYPI0uLiYEDSwRVTAz+sZX41AXlmMmiI0S55ew5S
	 iDhPJJBEuzwW5JnXxyeACW1Yc1Jsj3eOpuS+gULPt6hNBByFYzDendJDvr/qAVmclJ
	 +m5j1kVglmlM7nKsiY2wNkeI8VtxkXcOhzv+KBprxmdIFkjV232r1bPLxmpoPcs2eJ
	 +2kFE86iQcaXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: Re: [PATCH 6.6.y 0/2] firmware: backport CVE-2026-93083, CVE-2026-93093
Date: Fri,  9 Oct 2026 13:09:47 -0400
Message-ID: <2026-10-09-1-daily-reply-0010-arm-scmi-channel-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191624.98532-1-artem@trailofbits.com>
References: <20261008191624.98532-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
