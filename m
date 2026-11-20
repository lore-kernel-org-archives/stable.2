Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207175;
	b=ytPxpqZpmLOacS3UVebgisQhABgdAeZb+8QIyg29KDn2y0qyBAs2ldx9IEwQ5Yt2P2eB
	 cMQF5h3ZWFuFZ/3V2u9CV9M+hINFNttb8kKKgyPtT16xDAK4V+q/0h89TfTcXLVQz4w9g
	 LZhu5oa9HowsIUJZAjlO33MoS4XIB5BJmwcTToTyARWapqhgzAnvpBN1fwacS3tCMnRWa
	 HnEIcVw5oiYueQFpccP/ctF9KyNVdbt51zuP+imDJqgAd3NY/Nkhq4u60eykkrd/6wlo3
	 +vOTAF3+KXGnC9I5PfoFDo/jTto+tmh9ivDUQnRP/yV+bZppxj/KJqtPGncT2RqvVrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7SAmgLBumidMVZ21gQt95dH8y9qt8cTICDydyeCffOc=;
	b=09HcEwckqHV79XLyNB7KMe3E8sfgu0bF5Rj/vQ7io/s4+oklvE7840fTK9V6v0xUk+IB
	 UL9F/XHE0+fAd3sgnSr89lsknmzrGKjjTNkGaZAU4p7wu1xMWnIv15q8sxgaDkrjS5wdu
	 PB62Co8eOZsZREzMHmONYrQDC+1KKwU04af1NPOX65HYWLIAXLLG05Fy+bpalxYRQEzXh
	 V2tMpvXSB2MuLF0w7DKvClPnvNwpVYg6vgG2AA4YsMTIlAJP0mZE6wTWaMupyjZPTdQlO
	 tU8YwjuKI+hBZiUgW+dqH/LObpRh7vcMBjTWAM4PDoMHFJVRujQptKqFjVmrDuULmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0IUqWW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A702606A33F;
	Fri, 20 Nov 2026 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0IUqWW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BE41F000CA;
	Fri, 20 Nov 2026 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207174;
	bh=7SAmgLBumidMVZ21gQt95dH8y9qt8cTICDydyeCffOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0IUqWW9CDjg4Viw1Dra+iDy2erN8zw/Z2iRBbrRPhEejsOxylq86rLMVT73HZUjF
	 /IsO3TLOOdxuPx4E0b26REp7uMO2MqioiKRhylCxbDz2tLxgm/SysHEkFkFvnv+HIV
	 IGtYu25GbMqBz3HuhZRV8qSHQ0oEu2+jjwWoqBsyVfxHcbewQ0iZCTWw6gRCODbS+y
	 uuChLaOhF6YyBGWxSQ+Al6CutiMrW5J4sWeCmD+kpaZwbDj7lDKKRvhPWMe0e9M0DI
	 gSVhH7AaCEUuxRM4BPDhJe7sSCJnMQcRFEyXqYFE4++5otPHIQWGEvdTONBIG9XGYL
	 OldUgip5xWDug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH 6.12.y] writeback: use a per-sb counter to drain inode wb switches at umount
Date: Fri, 20 Nov 2026 15:38:56 -0500
Message-ID: <2026-11-20-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119185336.1149309-1-ehagberg@janestreet.com>
References: <20261119185336.1149309-1-ehagberg@janestreet.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Replace the global synchronize_rcu()/flush_workqueue() pair with a
> per-sb counter, s_isw_nr_in_flight, plus three small helpers:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
