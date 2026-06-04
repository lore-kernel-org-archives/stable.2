Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66329199D8
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531560; cv=none; b=ekbb9tWa2kY/2EYPI6gpDBBTLFtkhWHIovPVm0xlyZ80O0qphRlUdll17CjCZSSISBtkrdIU3FWLHkqulDiI9fs3w8jztCmdfqMOKpSm8kjfcUhB44CxFLI+NER4paoqfxKkVIx9zMpGdrVW45kVF9g/zw4quYuEKQLth4ZHQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531560; c=relaxed/simple;
	bh=MNgNmIcvyyOUJvD4Y21N43+835RVttedKsDQrM/FLz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGRZzaZjDLXHRIAnd9HAD5v7xZFYTYcVQdC9xsrHdv1Hr3wXh4HU73jmiEFEWM80QwXqQmZNShvGm8p7BLcYyMQ+UZIeLSyF8vlC2vHyNrvBXOlALol70iebMBjyjpWNrMMZE+dalh9N8mmJSGnKTZKWsGHxr0YLqGFh3h0OQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3trhrGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3trhrGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956C31F00899;
	Thu,  4 Jun 2026 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531559;
	bh=RzgQbkT8A3NYki9D9wiFbfYv5h/9eo1H4c3CU0Nuq5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3trhrGFXQGbp8uqkYw1nwYNLRvkxoHYy455DXk+09sHDS7p0awVvC3QXd9jLBg9N
	 S6NrOXlIUAvpe7m4GMMGFD7exyf+IUwuP93q7BHiBZssYTcPgo+FK0pfsjFimINAx/
	 nEMu+em5Vd0NoX1JaKYBIyxF5FsqXbyWYWzL1esRJUYFMP8053mAetd7Lim6fhsAGW
	 XsOQYMBVH8zVnC1xQC8yUpqdFZpe8V9n4EbB5whey2l6G+4DyH06yTE2a0mobbqwJQ
	 ki2aSrgjI6bamDPScnoCt1WVQBEp9x6k0ITm5UpADQD+xHqJH7NPoj35k/MOlMFANf
	 4xKncd0lnH1/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Wed,  3 Jun 2026 20:05:44 -0400
Message-ID: <20260603210831.item009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602020601.609941-1-sashal@kernel.org>
References: <20260602020601.609941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with
> pmbus_lock

Queued for 6.6.y and 6.1.y, thanks.

-- 
Thanks,
Sasha
