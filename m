Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B941D4FE
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975446; cv=none; b=Rg+vva2OQGOQ5TtZJybFcwGD33XoqMT/EZq6Fuq/vdQFLkE9BarW8colwp02eAkks3JAZrktjL1WK9OVb1W75Pg4yDF8KjA6zT/llRhq9RbF5DC7MZ3Q+i+xr33npVM77TwNB0XtsubFXgDnJ9mXzm45EQanI6peK+pYxpRwxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975446; c=relaxed/simple;
	bh=4hQZ1hv95ZmLUZyAQdcAX7t2YJsMN4p/wo5AphmXl9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpVdMDFauknAsjzOSElMpAsMyXqwuyZMVGQQlWlWeGLkdjXKINYzA/pqqjPQqIbfgcMdjXbF8yOsWymGGoUhMyIn0prQmTV/vk3scTsh61J+m8pZviRML9Yv3Y17MbnkWBtSksxHiotVF6oCxeJOipJ76OGYOBx4XkDNJb9LTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEqUOkuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEqUOkuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB051F0089B;
	Fri,  2 Oct 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975444;
	bh=+8qbwfZzE051hnDQa8btdgCT77C390hUhWlyp8BUNks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEqUOkuj05zXILcVY+Kwt5Ja3BLrKBXuoUB7dzS9oR6lYjLC4yi/Qq1TZw+oNvblu
	 sl9vOt3pg4qsg1Zcky90452JNwgKRLgdZoynlmARZb8tUR0tuptzljSVKXe6X6pbwk
	 u5Znsj0mmcow6cUKJoGwm40mOzNSdKIDfTm0PT+JylHDb/oM8ZnQmJQadasOlKCtDl
	 hOtctsIHIYwDsr0h7A/wiE7GobomRnsv06ZXlar3Spmzh7IKLqvhvUlLuek49Ajf2m
	 yWC2lPCXOZwYyBCnCzgvbAoI/mb27aUMouJAMAiUrfaZ6F10na4xTGPjhCElgCIgsw
	 rSM4SKWlTf4mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH stable v6.12 backport 0/2] ASoC: SOF: ipc4/Intel: Library restore firmware functionality
Date: Fri,  2 Oct 2026 17:10:32 -0400
Message-ID: <2026-10-02-1-daily-reply-0006-re-sof-ipc4-library-restore-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
References: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please pick/apply the following patches from mainline to v6.12 stable:
> cec49fa47bcc ("ASoC: SOF: ipc4-priv: Add kernel doc for fw_context_save of sof_ipc4_fw_data")
> ace9b3daf2b4 ("ASoC: SOF: ipc4/Intel: Add support for library restore firmware functionality")

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
