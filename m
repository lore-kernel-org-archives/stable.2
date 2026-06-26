Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2D3AB498;
	Fri, 26 Jun 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496506; cv=none; b=pbSvYLXlyBc1fXyNX92Rhi0MmLVSGpRk3gzCA9hweuvZFCYRJZIEheQaObqzU+mgnnOYPn7uYFiWa4BaX5eYiGP5MWj1Uh7ZZ89UEZWVy8dJYNOndujRJUR/rtiIlWU/SPp9OlJeBnvA5SKFjzPOxCJ48IFPF4iaUQhCnrDRz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496506; c=relaxed/simple;
	bh=TQoJUYXUeIsuq0/ALyI9Oir3uS8NjJAQKVlQC9DitWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJcONv57cx/x2GFpdRnpkoVeKCvMRUyXiwg7WQHDlDKyRkiKJ/KovBaGDl4eOKyRZZppsnUI7DWbmSJqRwtLCMQ32vsB7293qfkAoyQbVYD5S/8xyCd1bSND8SKWE5plVF59QHJAR4VRTldTEETz7YjqhQkSUJahVzlfCzEhuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2eu+pJy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2eu+pJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E31F000E9;
	Fri, 26 Jun 2026 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496504;
	bh=RpvKaYpVIHjwWfmOuj59bDD5ZM1aE5wAPuR73gcT/eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2eu+pJyrJpZ/T42tjnT/OuEgDyr1L8Pzp1ptlnPXOF0NqHSlqCrW/jokTwkgYcYp
	 /SbIg88BGgXnHvT08YhuJtGf2O+7SZHMxXlbtbJgnihKZIiuLVt0kc8usmxvJQwCVx
	 Ng3lsk36Nf+7KkwYEuSNs/37L15HfxHAt914/cGnuMFlcgiMjs0mOIr0sWAZW488FW
	 2Bz+KBFBhLlcaMKXrG+EyeEizY5EQ05HZDaZqSfuF3YrNqhQDrMR4DCKkZoP9OOvfG
	 RazICmrltLKtsxLQ6R8uGPvAacrKxqDWGNMdi60CtmVq31y1yf8k+QCzldQQmMcy8f
	 qMHNjLyZ2dPvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yu Zhao <yuzhao@google.com>,
	syzbot+03fd9b3f71641f0ebf2d@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakov Novak <jakovnovak30@gmail.com>
Subject: Re: [PATCH 6.1.y] mm/mglru: skip special VMAs in lru_gen_look_around()
Date: Fri, 26 Jun 2026 13:54:31 -0400
Message-ID: <stable-reply-item016-mglru-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625212751.23612-1-jakovnovak30@gmail.com>
References: <20260625212751.23612-1-jakovnovak30@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] mm/mglru: skip special VMAs in lru_gen_look_around()

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
