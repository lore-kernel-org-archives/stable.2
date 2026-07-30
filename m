Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827336EAB8;
	Thu, 30 Jul 2026 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379233; cv=none; b=ueI81rkcMd1PReDmuXaJDve395BX2tWoRpTAUYkExRBvHkQLaoW36fpmpp8SxxT+nHsBeG3LXGXX8R23m7hND8GB+et55ENPEi0NmAPZR+NZeA/3UnqdpIlnaQb6j+nt2S83Pahf5+BpvlULUuHSNmOB4YzZ86TwGQKIq3RkWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379233; c=relaxed/simple;
	bh=0XSmTIKOS3qbwjwz1USYg+ZIQ/GKZgCbx9DOvLLWrO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLQD63G+TP6zgRnaYUNsXQle/sfoVnhRGin0ePbDj03PUkftizRo9AwwfsycgEleXgBeAXvYXZGzqKAZEA+K6n+iVKpSERCcNaO1SXZD+ytLsZE8LXGbxFQ4slZFGaT6wdyBP3lwiKYrScNnLc26uvSF4wMKearHwzWJDUvKWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3BKT9pX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3BKT9pX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33FC1F000E9;
	Thu, 30 Jul 2026 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379232;
	bh=l2tpOYZ6orCxJ6zmScpv0PHA7e1WBAy5OLINtq8eY30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3BKT9pXrsbDWC4ykyBG2rlDmHEtboPjGyAbTI1aM83qT28beoJ2CTGFLPWjcB+rH
	 bN4V1rbMjkMkXJwiu2VigZZBrTLRLzvmJJ8xHt46N5Pw5upgy8sbnHWUdK70+hgEYl
	 WjQ9IKGg7zSIrRwBMOLcqXEtRXd2i+0Pg8BcenrjP/oCxSOAF+taDAhJOWsYScHwNr
	 MYOWshruL4YE1yjsNCCYlWTOCojE8U+2Xx4tJTN/80jOYC6P5eemjz91jRywukUeEv
	 pNgHfd3IQRrwLLl8ygjqTBToYKoNnZx5zjxwgmBwMbqPGTt4a3kXacYj2adp8p1b/X
	 LK1FSBJmah8NA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Haoran <haoranwangsec@gmail.com>,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Rinitha S <sx.rinitha@intel.com>,
	Jay Wang <wanjay@amazon.com>
Subject: Re: [PATCH 6.6.y] i40e: remove read access to debugfs files
Date: Wed, 29 Jul 2026 22:39:59 -0400
Message-ID: <20260729223316.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728210715.10700-1-wanjay@amazon.com>
References: <20260728210715.10700-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] i40e: remove read access to debugfs files

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
