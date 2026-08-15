Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB21CAA78
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761210; cv=none; b=D5hfNORPa0Qrw9Eph/kzbC+2tRnI92J8DtlvlZlTVxCsMlGaBgOrOmPSMSWhcZTwXQMjEdi5g8S2sfIey9aY6RJO7xcyA+3McCWsjnhPtPzmf0heI14MR48kUhh5Rs0GZoJP1ANDg96be4wyx3fubzWzXNYdJC67Kqg42T/NVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761210; c=relaxed/simple;
	bh=VfoVVN6z+fCFumsorq6U8dSGLwBRj4qPYbwzWwmMC10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDU0Nkixmlme8ZT4Yprdc2JU5FI/RFDmT2SCPt6LMclg7PtNfGzpMPXkA0RVqUK5mhWnHHrEeRlUQ9DxX800Y1EUr7xTcviAgLYvMYQn69H+abxuSk1I80SIOCtiT/PEW5EvpK/mAcl5dZhl+oA/OpQvpHULNMmMWpa25hmkIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoYovbUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoYovbUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5604D1F00A3F;
	Sat, 15 Aug 2026 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761209;
	bh=YMMPxOhAyAGNDkyBdgBF2myCzRg/1fhg2+EJAWnvspk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SoYovbUiSSua2dSq8mNQRDJ8mcvyzwPH3CHM2faYkpxoB43xOHBnwqf+1BF4snysl
	 C9HJ3SXOZc/Fe8cdYT1bd5PFzGRXqQpa0V0kMd4nRUnkjJGrjLMZQ2yhSTRWdiT25Q
	 aMQR7gjj2fGqYOWW0nBK3ybgHfdy3PE53s/310IhKuXBC0xQW0wrqxFHetNO5EF2wb
	 eHVaUaLv2jwzziHnCYbwOVEbXpsKNgXv4DFDLTUoQP71hYQwAb9t2Ihh68PuvSntWb
	 GYJlpjMHzGvnRZRXiU/GYjQV3uL5qurBTFEl1odVfEVGclR+/Vrrlc1iszh7VKd4e3
	 fQWphqGFAqnuw==
From: Sasha Levin <sashal@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 6.12.y 2/3] i2c: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri, 14 Aug 2026 22:33:03 -0400
Message-ID: <20260814193000.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <anxJTS3MkvCEckhz@kekkonen.localdomain>
References: <anxJTS3MkvCEckhz@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please don't.
>
> The patch adding pm_runtime_mark_last_busy() call to
> pm_request_autosuspend() was merged in 6.17 so before this version the
> explicit pm_runtime_mark_last_busy() calls are not redundant.

You're right, thanks for catching it. Nothing from that series was queued
anywhere, so there is nothing to drop.

-- 
Thanks,
Sasha
