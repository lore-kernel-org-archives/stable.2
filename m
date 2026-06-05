Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5F1FCF41;
	Fri,  5 Jun 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688262; cv=none; b=l8REW9LbYIQHLQ1LM5h32cUW+Ugl8Obg+2oD1ZN4jCnyQNO7SR5XLTR2gb/a7g3KtlNkj2LIMinVKdOEXvdsNfw5C26FhyRpWAi++bhN1M59C5RMHiw/6LPV1rE6/fkaSChKZe6ebiUhPUg+ShnKk73V3q4Ui1gVmxCPwYDT6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688262; c=relaxed/simple;
	bh=OFBzAyJ9wotpV9aYT/7987s36edPBn4agRYERsnu6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVl570xIDQaYVaP10UUgAj0mHZ2AsdbT8q9voW7arN5GeFuQgqerrBKuAOyIJjrFitfI0Cc9p3p7QXT79tlUZ81H2B6FZddyYf+hjIRBcehmWcoYEMcs1vJ3pBSiFTg8g/suGDD091Im8cHzHGOsfr4M5+Phm63DfeJBFJnZryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOvpdXx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOvpdXx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205F01F0089A;
	Fri,  5 Jun 2026 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688259;
	bh=BuE3DvXv5e4Mu8i/UKdg/3B+Dcqvk1E4K+aUYJGSP/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOvpdXx5SUWsjtJrMur/fYQ5kOgYveNhqQnvcczwu/4OMCDAcU9v9fvVPaqHiOvH9
	 ry6wUK8+KT4PVJsY3Y49vbj6C+EtQ175UUKwz0kWCzEdXMb3AcZ1qO5iKE0hIzR/D5
	 i/O1mRheco6pEO87ihKbWhAPlWJyij7tdbkStBrC/jhaBnB6lVGeZ+CvvXv0jl8fIr
	 FPBdMnqtydLxBigZrLU8mY9nLz5VE1a0OeKUPyIEW6PdRVhY4rAoM9uL55X4rGfRRf
	 ZQrfU7wyyqwMOaYzWHsxct93q8vghxWby63/4EoKtZwVpUB0esH9FwTuKvMmMNlcuT
	 69wxZuCqvhk2g==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [linux-5.15.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Fri,  5 Jun 2026 15:37:12 -0400
Message-ID: <20260605-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604092659.3953067-1-lee@kernel.org>
References: <20260604092659.3953067-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [linux-5.15.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc

Whole series queued for 5.15.y, thanks.

-- 
Thanks,
Sasha
