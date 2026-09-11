Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AF36196B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125682; cv=none; b=Ie+GdX/UCoGST/f6DchYR/vUZLixzg9YaGIJLCfJEBqB4UfKchHU8OMvJrRL8lmjSBKEQFxNxPH0d/A9v9a/TJ7ZwPbElrO2GycudGWEHnZ9s4v8LWpQGsIH/IREted/IZEJpbQ+edNcIKUlXqXPJTVZg98baWm58oQGVEs89TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125682; c=relaxed/simple;
	bh=ttuxXD/eDtgOOY7Tc6yXi3vem4wzUZD1tB3AQgWjOs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhR/qx9mH+lLECNEWMufqcrUkvxpRNKVMVoGAh/O8cHjuwYoJlZKvPFCQS/nqyL3fACuVl25Nmwc+ncWsMMzh5gmGphZPn2Fo1E+2ptxerktEPTcWD0+ZVVYNiRz8FzsJWVFA3mtcQSdz5nk2SsqMcmsPKxK8a3DabUq3WzYlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vly8Fg2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vly8Fg2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C81F0089D;
	Fri, 11 Sep 2026 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125673;
	bh=s0dOmUnXGKL5707Xfq3rsUDhIUlV+GmnziJFNr6H+I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vly8Fg2Kwt2NBE+N6Ek1DmoTfHWbVVIQOoszY09mZfQAvYdsh1WsXkv0Mj21ctGRS
	 Pbcyw51h306GAfqKhjfWa2Lcl3PAPw00/Ol/g/ZeL8DW2yKv1eJJv3r7y8PgVDABYJ
	 K2N5axWVrvlNYkJYjDGTcf4zhpCTDUTdFbao/xI70AIOWZQG8SM0QaIF7w/JKPcVt8
	 zwRCZcMppl63n32n6dEDaOwf4RDoatG8KCrjz+8oZ2zki811jFv/IWdOlNS/FKaa56
	 aKB9VDNWeoevnwxJb16XixEkM9BTxZL9xarApdyFNTTxVtfhbrzPUixCCPavCKlgQ0
	 wiXNPyVvTaQtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.6.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:30 -0400
Message-ID: <daily-reply-0011-re-batman-adv-dat-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190012.1009452-1-sven@narfation.org>
References: <20260909190012.1009452-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
