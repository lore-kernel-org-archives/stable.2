Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43D2C0F81
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252284; cv=none; b=C17RlPZALSYGj1ne/i5WihBhq2hQ48Flr89X7Y8kRbPnVuygtYI51AGVYOVNpvaxJ4BG9Ytlj1Rx7eLnBLCX+gYsG5CHP9p6R1uobhTKKrzZbltp2ugRyFbt5t5L4f3akqDJEBKMtKoG7niX2eRDV4kRUx+GHTWgboEjWHUbrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252284; c=relaxed/simple;
	bh=/jUG5HS7EUmkZ2Z6RyRcvbWwsRTgQAKOmmSfgjUGF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmTNMSav8olaNeQe90ubrSCAIsUO9nXnI7n4oP/pryL9zKAyHem7DzUL5uXkWK/5L50hPpTsXdWM5qOvjMCp1Nt+RIhChhrSRVOS/hW8CPGNCeWqq5MWFHIAmXHcG2w6xe9TcQO2T6TpYFsEPR8B3OzKPPhxhKP70/awZPAZdNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsnsQNQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsnsQNQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F11F00A3D;
	Fri, 17 Jul 2026 01:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252283;
	bh=brpONBEpR5fWnfzumGTAURjVzuiVsPaqUAIGR2cBnbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lsnsQNQktu53sh3jFoGh9TeGG65QPq/oefvFa00F/5jcYJ6RFjWH+lq56n/6x3psA
	 dN+GRqevR+2pQQHqvk0ICSwrCPTAJVm3sGLNlPNpzKrMAvTSyFadombxDZFZkO3oHt
	 OlKyHberWcd3bfLojk9akoPWN3LN7N89fjmhpkLEKhNjkGoWXFmGv02pN4mMfpzVQ5
	 uXaD3vt7R2wZRezdEfVoVmAwfUyJrj8LWN4xxZNQSXnuRp/UiSS93CBYg35m7Dmv64
	 bNYm8gT4k1IlNzEyFB1+Djbfz30j/CmiPlaHlsPAkMaybNCMPjrmbIVkDdg8VXuh/K
	 RE+zUtnAhpeTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	sj@kernel.org,
	vbabka@kernel.org,
	chenyichong@uniontech.com
Subject: Re: [PATCH 6.1.y] tools/mm/slabinfo: fix total_objects attribute name
Date: Thu, 16 Jul 2026 21:37:40 -0400
Message-ID: <20260716232340.0016-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716075917.1165360-1-chenyichong@uniontech.com>
References: <20260716075917.1165360-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 16, 2026 at 03:59:17PM +0800, Yichong Chen wrote:
> SLUB exports the total_objects sysfs attribute, but slabinfo tries to read
> objects_total. As a result, the lookup fails and the field remains zero.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
