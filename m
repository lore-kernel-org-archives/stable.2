Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB823C3F59;
	Mon, 27 Jul 2026 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190796; cv=none; b=kuBhwqIxWtfNG2jcWDly8FM1dRA8LFd4JDKCfvl0mIdkSMvnI+4N4pNOrgU842nKwO9E5CCfWRTz+4fSEF1nCCYamWrYwguRh+hc+WCccDB1mtmY9StBo6dLkQiRggUSxuAdOyaXrrFEUfwhPoAXep1eB2Ga0ULBl8X4hiiouXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190796; c=relaxed/simple;
	bh=whnd00uoisjERkyzsR89ihxcMa/trZPw3KkplEodFBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNWFiM/HsHC7PqhxlYJNwjKV1UVRq5DcUYntbCLUBcLTLRMVebpdhNNFy3PUhJZzgRcDRB7U6m8LS9BrCWocfyY6rPQR4OgMsX+iC0/Q9h9FmWf2zAF3MAla/30JGz0DXPt7FCLNzG+NgeW24tVl2uvdhWOByYW+9c+reqev18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ59tAC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ59tAC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB121F00A3A;
	Mon, 27 Jul 2026 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190794;
	bh=4FpI8HSVS+wqj/qz0BJyVl7pdxsjBdmBf4KamLj1RyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQ59tAC3yLZPlSk94tMDVApPUSYORgywTdqXyEdNQY/uW/wHyqgudywKL7XI3xsZk
	 VPJgJinc3SvcDaLLI5HMOwgRbVnhCi2PTyxeS43595qOhsZ2XSI59L2tB31EkioPOy
	 Ic9UFE58d421YVOCDALIcXESIeTpeuZcWQ0KdR2iXPlqqiSEC55dpeWHVgdSNnhYxA
	 ocS7cPhxqHuHDDjRb3nnqdTvvr3ki4hCMrK5ZEMEWgbmP/5HCvSlUCHQQ0ED+v5pd7
	 TYwrSipPOskB23p9lWnsa926/Y6MrCA281cwDUfdfFba1lI6c3Tjw1v7DLQ5xktwoP
	 reylfCSSzg3xw==
From: Sasha Levin <sashal@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Sasha Levin <sashal@kernel.org>,
	johannes.berg@intel.com,
	Dan Carpenter <error27@gmail.com>,
	briannorris@chromium.org,
	s.kerkmann@pengutronix.de,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	George Valkov <gvalkov@gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware
Date: Mon, 27 Jul 2026 18:19:40 -0400
Message-ID: <20260727202413.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CADOrJmYyAXzx9wVdLMwtvaFBcKcEPWxCv8OAGkkDYZjZGzoOCw@mail.gmail.com>
References: <CADOrJmYyAXzx9wVdLMwtvaFBcKcEPWxCv8OAGkkDYZjZGzoOCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 03:15:37PM +0300, George Valkov wrote:
>Any update on the progress? Do I need to do or change anything?

Queued for 6.18 and 7.1, thanks - nothing more needed from you.

-- 
Thanks,
Sasha
