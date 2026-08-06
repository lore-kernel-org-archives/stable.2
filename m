Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F446AF27
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016208; cv=none; b=uYSSPmvMA/v4t6py02pDu9PYmQAciuOszd0AZyCPclRTtMHpahDmsOTbG4KyyBiNy9n/9FnWZZ91rHjZqYfQbOU2Do8mShS8ALTCBWtxfkHFmCtFI6aQ5+5x+EaxSdxUix5dOdYRKxGBkQXf/9bDAvvugQr3koidWved1G0rvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016208; c=relaxed/simple;
	bh=pedzRgUZ7XYSNdXd4lbnen2aNlP7qoMFku8/iUjyoJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD6jwmfqT49Hz75EYm6SmK6FS/CWpRDRxP82K8J5XwuWXKBK4d1kbiiTIs1s62TB69RpSOsPG9/8He+pr3GuwOuJDvAKgi7twKXhoiyRBoO6wznXeuVE8QxIglmuhBWV0YjL464PX1+q8aRh3nEBeFjjHb40Ma3+VjCUQSs8uGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTtvlf40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTtvlf40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED521F00ACF;
	Thu,  6 Aug 2026 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016198;
	bh=v6UEuLU5LgZz8dAZm+xcNq0KiwT4V5WKi756BlckYmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTtvlf40uD60RuihPde7lr/w7/iXbT/Ev8v97UhUCnqJPr5Nr2JLO6Q8MCPDwYg1A
	 953XqDDqas/GhUhQjofg8qy2fOtIo8M3WTNk3eodZmZ/99xQsAoGwR18HYxCZ8Qxt7
	 ckL4e/fFJ8T0U3Ujc9nRB8JZKdS9NFmvGzKn6vj7HM/GWL0pchidZd+xE0bF1riA5I
	 0JNidorGo3mJt3wyzL3brH2p4lvcyORFiGldYDbUKdYVRkGq/3w+O5dSmDJ/MvHN8f
	 T96oIUAO7dajhOOjMFJBQbqsZMiSMSvqXSF+LBU6/bkylrPiEsr5mDF/HrdZejmUQ/
	 U0ycuZj58MYQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Thu,  6 Aug 2026 07:36:08 -0400
Message-ID: <20260806021809.0015-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805221920.2820141-1-i.maximets@ovn.org>
References: <20260805221920.2820141-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 12:19:18AM +0200, Ilya Maximets wrote:
> [OVS drop reasons are not available in 6.1, hence plain kfree_skb()]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
