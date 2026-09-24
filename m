Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E349412BEF
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270020; cv=none; b=iTC+BvrQEyR5Rc+KKAyXQvMjOq24bFwYpUj9yjOlhVLNp0tuvim/+wdEJVwMXp0xuul3xniLFiC0XZzNL8TobEiF27ngiKg/DS6/3/6Yrjsc1Po8ZYVzJLuOHfEA5aQZ4tS7+eLFyhXIJ/SIuYi6l2Cy5ghsMGSILyT1Z77oFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270020; c=relaxed/simple;
	bh=zN2rA+uDNErOim/pO5wodMDlp+2ekudogtsv+w58fkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ6z741h+SydgDJQqfA6ljWb0PvpMzriYq4OOZfrVPS1IoPQXIVXk9WMlonmDVrY/geH+EaQQM39JXerotod3cnoQnDZNe7ASiSgm1/WXTo2DQ7e7vd1yfWP104CiCrEjnWJm2kPzQbH2qZjDT75vO6f+dj6uXNbiwFQfU1PzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCgPqaOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCgPqaOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757DE1F00893;
	Thu, 24 Sep 2026 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270018;
	bh=rwTcumBNBm1LlMn57BiYjcZv4TFGBDo6vCs4nV38ZEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCgPqaOFvevv+t7a9mKU2wwwaaaeAYzgzyjhV84uLn36gngmmdN5kPuirTXbfxdxG
	 YVzLNeK5nsRU3vAYr8AM39ZtGuTUtZWim5FJxkOHDKX06d5sIQVclnRzhh30F1cxxJ
	 Di2Q29VdT7Tz2jPvnnMlky7RZVi2Vdgp21+PS3bljDRNxnkp8Y6D6VWsBAHdOarf2n
	 4hNZ2ktEL2fHWgTWJnrLbKXKLkJofNU25dm+nSWLdkK8zNj51+5qzXFoxkY8+vtiSx
	 MBTUIMx+RY1hsBy44Z3vtI1DgTZoLk6UA1pnaQEWZ+ijQ909iXYE0RF8nNY59RnImG
	 2YfAIPXxSMz4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.1.y] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
Date: Thu, 24 Sep 2026 13:13:24 -0400
Message-ID: <2026-09-24-daily-reply-0005-re-t7xx-netif-index-6-1-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923022159.16308-1-zhugl3@xiaopeng.com>
References: <2026092215-sincere-shack-66e6@gregkh> <20260923022159.16308-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fixes: 05d19bf500f8 ("net: wwan: t7xx: Add WWAN network interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

This is missing the last two trailers of the upstream commit:

  Link: https://patch.msgid.link/20260911021734.1396599-3-zhugl3@xiaopeng.com
  Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Could you resend with the full upstream trailer block?

-- 
Thanks,
Sasha
