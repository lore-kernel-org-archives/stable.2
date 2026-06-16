Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88B3B2FC7
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578674; cv=none; b=ByOEiv6AsuOSZAoMClClygZriu5je/0eHK7R9zjdF0EuwKLzhjdIfiFhwqoJ9wyO40zNBynsDFMdoYj+LgTUBEbMXqEQexaaZYX3XAAAnxF50TuVp40fYII0+376O3y8oWbJdCkfPRSKh2LlpU8LRvsYHJmOsxnW5paArRuI4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578674; c=relaxed/simple;
	bh=lGLzOotU1pVPdRIi1pC1ZVQ/q5WOtTwhd3zSbT9aGwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFwxa/ynKrmY1TYCF9K0tSUf1tfOgMp5dZlRwePGaZjsukfDF0ed4bDON/VC41d9HWaVAmlVNbqjbKs/ZSQhMj8gYudUdmgVFtJguyMa0TlmNOGUWBarM46j/LyKkGgRDjenMJYCZv/AakyPl1v2LLb//BsfEgQk/rF/FNtMdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvxcguX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvxcguX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFBC1F00A3D;
	Tue, 16 Jun 2026 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578673;
	bh=lGLzOotU1pVPdRIi1pC1ZVQ/q5WOtTwhd3zSbT9aGwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvxcguX9eXWdyNi3fudYkih/2cnDqkT2TeYbQhQx+pgJW6n/Sz2XkKoULtW2hUAoM
	 RJKbErt5XTc4iY3Vx9WTEdMiYHtl20xDjL3oT2QQpOOy+8WbincDU1plut8w7RZH8b
	 ELpQAIGquYupCK6uZjx4ULwLLSxPAPHcTh5/2LCRFGLFRtnkZVesXB3t42Ol1zwNPZ
	 izpSSYZZU0zftTUvQh/D9Cj4VXQOZq0k4Eul33I5R8la6oRtem8Fru0USB1aTwZo/E
	 s7QE4Ekyq4T7TtvqL23W+a5XKHR9qp7lVZ5ZID+gm5I2LeH7j3rwaIzSn47VAm2usH
	 LjL35G7swbjGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: avoid false positive lockdep assertion
Date: Mon, 15 Jun 2026 22:57:44 -0400
Message-ID: <20260616130030.1000002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615164354.285032-1-ljs@kernel.org>
References: <20260615164354.285032-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 15, 2026 at 05:43:54PM +0100, Lorenzo Stoakes wrote:
> [PATCH 6.6.y] mm/hugetlb: avoid false positive lockdep assertion

Queued for 6.6.y, thanks.

--
Thanks,
Sasha
