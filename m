Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03534C141;
	Mon, 31 Aug 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788140376; cv=none; b=HQtzfJoYmizLFyRLLTkDxR+1n5kflcjcgL5fflXNxYj9Ah5WTM1lirM7ikEK8UNkyx+S8FuuuXiI3LAfge8GP1ZL46X3p0XApCQvRCv6wZjGOigRoSSVmxoyszDMz9YSyXquzlSWxL4/XSvq7lffw4F34SCnTa8UYJ+UBjRw/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788140376; c=relaxed/simple;
	bh=2p3lWF1Qf+EdHVZ5rrVPf3bgukvNQ/S3YW3+JuaxMMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4VjPLEdEpavQ5oSFP23qNAqAJvmZvJjtlL3F4kFkgVtZPd9mafVl2U18LWeb+xQgv48L8XnIjliOZANBEGSbR9z0fpnmGkwAWHaoo4ECzitkNbqr3iwja/vgaopLn56U/V6O7M35AMslwdPG2VCYd81XpYzNowo7k2A3T7pxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVWDBGDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVWDBGDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608941F00A3E;
	Mon, 31 Aug 2026 01:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788140375;
	bh=xaXlGRsNvPMHvYeN92hG7Q+hVmHvfa3015wWgUvq4BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVWDBGDmsSS/igNUrEpvBDiFjwA6NzVBFqJOhc48X9Y0NJ387cGw2zHlgOy6Hhwj6
	 52k2SOC9puOv44xL1ja5/UK3ZaCWfi8+9dZdiXowcGpmaI1aNuKw/52gAay7+k+dnu
	 vPFLj6P6GB4X/tjhuo+vfMETLzGvWjPm4HLLNn5vPy4EEu/KrSmhOJsUCQ5mDCB2cw
	 jWRQqCN2cCj95OIuJnVNVn5anAKUvKJsngnCkl+kxPHYf3d7QAwvSR6MwvVdfZQdAP
	 0xxpdL43jusL5KpCgb13Kef2FW/Tg1omRi159VYqKaxO6Z4awffQ77S8Fzx1jTBQvZ
	 waRgsGdxjIWwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com,
	syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 6.1.y v2] block: make bio_check_eod work for zero sized devices
Date: Sun, 30 Aug 2026 21:39:17 -0400
Message-ID: <20260830195600.0012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829171918.134829-1-miguelgarciaroman8@gmail.com>
References: <20260829171918.134829-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since the dawn of time bio_check_eod has a check for a non-zero size of
> the device.  This doesn't really make any sense as we never want to send
> I/O to a device that's been set to zero size, or never moved out of that.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
