Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00603D1709
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499696; cv=none; b=LaLEyAoGg5z5q9ylgCI2MfuRMJX2ak1PYF2tMTZvKFJkkzxy9iTGN803qfogLzfVFoh0zz3PSDAvL7zG2EuwI5o8nTmhcytnXLNstdB/dHCTBar+ujhKlBwUCZVW7JBvDaHzvE41oc9EBHvjq0Qki7zqTfH/EeJstRs9MeeU3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499696; c=relaxed/simple;
	bh=x2CyR83K8Ui/zDUZ89B7pi39PinAtPOk+fTNyDbzn4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb9HfsKZqMd3Q8iSRHBLcIYT53vQvnwRbTWV5NZR252JFYrR1wYx3RoIUfu1niUVkVK/E6H/BA4Y9D7W+n//mkW5+izwCzF/NuqjHYsURwHMpDw/k7HhunltK5gu0YxM9+RqhZ1h8HSKeSo4Idd5wvDXn4FsQvnUBew6WHabnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtTfK3j1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtTfK3j1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DEC1F00893;
	Wed,  3 Jun 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499695;
	bh=4Kj4voNkYXV/vTBaXRccNGRUErzTkLYlawm8sg0S9go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OtTfK3j1LcIUQN2h7gmJm3XnuqZwU4rArFWu2/n5cmI+BNCwQZOGZZEm+/qPiVRDD
	 N5N1WHDsaG1jwiotBvVQJ5Y0q0sD41N4vRgWCeQ4gNTGSKeSHnu1tYaC97LYKod44t
	 Fb460qBvWUca+FMOQRwruU7goq+TrO3tFPy3XkxH+WoKYlFirSR1FndbkPZduGsbpy
	 jpZ2PCFfMaqX9RncakiA2BzlO8nqhGwR/b20MWPrsZD9Y0RsB69YhpUl8JH6M5QG/v
	 jZxwOvdubHqTTvQv0mRaPE78RkCximD8DAq2DRpgsuxdeVIQvwYP7WejJDCZjxZOGw
	 ZA/ijeIUrATbg==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	sean@mess.org,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 6.18.y, 6.12.y, 6.6.y] media: rc: ttusbir: fix inverted error logic
Date: Wed,  3 Jun 2026 11:14:21 -0400
Message-ID: <20260603111500.item062@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f92f7417-9ba4-4a16-9f4c-77bcf212784a@siemens.com>
References: <f92f7417-9ba4-4a16-9f4c-77bcf212784a@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y and 6.12.y, thanks.

-- 
Thanks,
Sasha
