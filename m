Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B063D6CD7
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499692; cv=none; b=Zbu7ImMYK6jlTlF/KpthI0vb3hsTWUNmxAZchpUqpAIBupu/0wTlDjYx3zfboNcYG1kpbi4/zLuLKByI/usCLK6YR37PRnfTuZeiuWTE5ACLAqnyOqFfHu8lZysuG9H6sPC3YMhMRPZheUBqRwLHBAq0GXqzD/paTQNFBVadUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499692; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw6xP4NTASOpnXziGkfxvp3V1IOZ0gEHwbGSOmnl2nAAnjlCWUscX+CyDqOPNatFXXaPzONyGqhy3tgbTNfRlr38GwQf3HFRBluttbMKVivqUu/RgQBWzRq0hkKza5XUVwPwZhPvP0eQe1uePrYmMZLX0yQw6cEU5sdxj0FftpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUm0r42b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUm0r42b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF971F00898;
	Wed,  3 Jun 2026 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499691;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUm0r42bviOvyhdsV6j/C3+/qWYJhO+7akiWaVEP/IWnLVDDBIEazHfz3Z8P2nMkw
	 uD7TaeqtIXh6h1K/oGcISs0OWZqiSW+t7qXInNgdxeSlBy/4O+1vbh1onKXWUSO3fB
	 jMZEbCevjd4cjrPhgcFXVqwSYmWVtcVdGF3SPo0Y37QAhFYSomzhGQ/zdpLJagcJQe
	 EsytQbWMN+tj3BDdRZnJKPDu+sO2KjRMsU5eXnF2o2oVuFZDyLrAOrJPZ46bQnc4x7
	 kX29L8Tx92+nLd2YNy3oTM80Ap2lwNUBERGGqOF4Xi+NEoWDBKnEQjHjZ2VJrKeuf+
	 hAHX6saK8UVhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: avoid empty VLAN responses
Date: Wed,  3 Jun 2026 11:14:16 -0400
Message-ID: <20260603111500.item046@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180450.413317-1-sven@narfation.org>
References: <20260529180450.413317-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
