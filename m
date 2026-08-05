Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABA2FDC30
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892423; cv=none; b=W+ncFRmO874xLF58v0XEqAW8YRC5VuzN62UXTeyRqaIQKuY4RidhRmIhiEzjq4JuIpaUIDVgcH0M4CyvihkdcyQo9YoJILSEpnRjXb8iBg4u9DQVlM98QxXWvNzjSJDyq09kxh8PLYS/V4X5GFTp9bU9Qo2iglbCTNmvQhI53wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892423; c=relaxed/simple;
	bh=1aZx/Ivvc9FYqDwbppC5sblk1/+ZACf80M5W1GKi854=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuaPXh3vXt3BteT6oTWiNs3LLumU6Hv8P13PkIruRidYDYlPCFxzgwHavLCSIU3P71jQ68RUTgFu6BIeE6IDNjDTt+PVYUswgXLSWmqCHePvAdJp/6WFbfbuFIjtElzve6tdIuwemZt4GoQNzoqWll/hepNTXRob7ZaqBaGrc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTb1aQ1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTb1aQ1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDEE1F00A3A;
	Wed,  5 Aug 2026 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892420;
	bh=/CcpFdoCyfCllHn+AoJibFxBa/nPg75ICxkcxgS1yeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XTb1aQ1W/sCW5itN5WpRh7CHegbTU9GUHNPiYK6ACUyKvMHXuZXdwXURnVGWmOOOF
	 yJ73Bx9aMQfEwgx882JpUY6DOqSrKSw14bVBThphwAdhZy+Qin1F/ISrkcEOG/2OZ6
	 vfjrPegzIzER6Wrd+t+gaiVthaTfTpzsK6Oo9NDwcUfORSsgc4NcB/BIMhR7ypBcLp
	 x5OUiRcFNLKY/NO2w08tOzZMG2Y/c6yPV09KFaGYK0IOUqSQTPzVXNaCbcYVeRN8lh
	 dqFOzYU+l24hK910K19lRgxn3W8cWxwQ+6WEROrzoleLpMr+yinUa86WiR9MOfEn0p
	 zthX+GZI47wlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH 7.1.y 0/8] drivers/gpu/drm/xe: Don't whitelist OA registers unconditionally
Date: Tue,  4 Aug 2026 21:13:27 -0400
Message-ID: <20260805011003.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
References: <20260803230136.3270230-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 04:01:28PM -0700, Ashutosh Dixit wrote:
> Backport of the following series to Linux 7.1.y:
>
> https://lore.kernel.org/intel-xe/20260615224227.34880-1-ashutosh.dixit@intel.com/

Patches 2/8 through 8/8 tag "[ Upstream commit <sha> ]" with commits that
aren't in Linus' tree...

-- 
Thanks,
Sasha
