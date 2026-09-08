Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA7257844
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828849; cv=none; b=nQctnyiAEpCBRvnITvJNIaKb9YnCvv4sL4SPYaQGCW87C3kUSA8hOq/TJQe1kfs4qrdwpT392CEzxvdv0VSwUnTeD4lsJ/X56WQICWmepZHoelthKhuxwG3wkzGBU1F7abPdAzG2W3Cra9B21JdB/j61otgdvJELgGqzIIZdnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828849; c=relaxed/simple;
	bh=10Z9qDQvZd1hwBzqX2qRKElNjgu7PAq5CjR7KIo/5e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqi0xMZxauSrnR6OQrsJ3U5khy+XN4IKyEkErWG9pSdwcCjGg/jkqk/SdCCSoFOIZNVVY86jOQF+5kn8X8hNI+3zNStrvaNokKVPOxH+/UOjTo132tuqPvwFUEH7OJ9DtmR7KmkI5gP6ee62Oxi2DxUp/Xp8Ws1l5xct1SHZWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn5MA4VX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn5MA4VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0C11F00A3D;
	Tue,  8 Sep 2026 00:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828847;
	bh=iqA6aKbFfQjRdOHLLEq2u5yUmf5DtfodLB49uuF3nJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cn5MA4VXLWK4IhMnzgAwBeLNADkthtry0MEIBfMjQcEXOCmvbn08aLWbDdUzRefcs
	 THIcNR3j2XLoDFg99PWhc3CPoBQ9qHbEzn6o8NJLUWmm6/l7Ooy7g6pYABN33G+FMV
	 HMC7OEDEoMStyCYu7Si7emMXmdcPQhEC5ish3QpZK0NElCuuEnY5VsAvFge/ZZii86
	 No9xZuuoVxCWnyYUrPpqGQO+1MkwBVPXbU09q/K9GL1DpQyJuGgMlihZ3qvHAKwdre
	 Ftcef8UFEb3CmAf5G0/zlQW728RQyLGZokHt+vKEMX9eehrTQiqCnzeacDRRI7shfw
	 6j9wM6WNxcVNg==
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
Date: Mon,  7 Sep 2026 20:53:43 -0400
Message-ID: <2026-09-07-daily-reply-0004-alsa-seq-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87qzj4rhbo.wl-tiwai@suse.de>
References: <87qzj4rhbo.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the ack. Queued for 5.15.

-- 
Thanks,
Sasha
