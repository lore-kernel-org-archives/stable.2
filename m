Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4A2F7F02
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199576; cv=none; b=mkRcZAAzChQy9fUw3SA5zAeaImoea/vr7krHj20WSEbjKj39P+vKmqQ5ta9/Q4t39J21RcPD+TRelWhIOPM35fznpftMo36mHWgb/MW2SCVXz3EeIIkkY6PDajB9ADo99e2Tesp8OYJbjzTyzvbXQlZl0n3QI6Bds1lH6fLJ9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199576; c=relaxed/simple;
	bh=chNLk/vpq6mTsaRqyN8E1S8CdHGEVKCRMZdmvTvThs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpRi/N6qEkaUYeHZziF3OL0V5PKofHpjOjEoQyE/YNCFSVy9CaX9X0+m+26axVSPcF5uFZslgz3DAQXSICIW2EcZcWG5wekFfsIvpA4fVnNXhnt+yroNxN7eKl+AhEwGkuG+F5dp4Wu8A6SsDst5DcwobuO3X0VELgBkGkCLaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3fx7K5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3fx7K5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600961F000E9;
	Thu, 20 Aug 2026 04:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199575;
	bh=GsaW06bJ9bk0OzONH+z9oclCoUuCjmS4HA7lOrFaJhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3fx7K5T8WLAdemTd7uG2rx5PpzTQT7kFmRtUejhpISYYa6auW7PoV8JWGytqlvJj
	 ct8XHIdgIpn2ukRcqmXXYJIHD4JGKDfUZiXVPcwVqPWxNuRd954b1ffGq6PfqWiC+g
	 xpHddtvNlhoGpVcHa8p3egWQtudAKb/Iksx6fx4NS4lqs6bMQXvCiIMeOXATlu1syp
	 yzFo2awLKAs6OQ63I4mqYh09p+Z2ZPJb6PnU4z/KOWbIus23lbJr0zYUeror6/Rp87
	 4Itd90KA0FASSZRxE0L3H62e7Qg/nAmeAvyyfZCICzRvG62gW2ILKorZvQnNyXslYQ
	 9gm9/mYaZVqzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH 6.6.y] net: mana: Fix EQ leak in mana_remove on NULL port
Date: Thu, 20 Aug 2026 00:19:25 -0400
Message-ID: <20260820040907.4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818232531.102559-1-hamzamahfooz@linux.microsoft.com>
References: <20260818232531.102559-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 07:25:31PM -0400, Hamza Mahfooz wrote:
> [ Upstream commit 65267c9c4f28199985505977bc2c628c82fc50ef ]

Queued for 6.12 and 6.6, thanks - 6.12 is missing it too and your conflict
resolution applies there unchanged, so it gets the same patch.

-- 
Thanks,
Sasha
