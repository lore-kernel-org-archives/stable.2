Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42B43E9C3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688260; cv=none; b=TiyV2ucpXRAk5ElPLP+AqmutnOVO0g0yQ0yt/QlVrjCCK4Nqh+lESNPHpa+1jJkDjdERlS37kz1IgWOJNk0Iejo3HbdYCbT8LIDOimJj0UhsiD7pKlxIMmfCXKeIN/2frW6xAPJyfWxtee+8Ch4uqYC8O2x1OXu0WVI80pKuct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688260; c=relaxed/simple;
	bh=T0ugMCc4iSM8yvS64Sm30Pt+Hr0lIaI/HRsSNwDfR3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neu6FUOlAvoIpHny/drAXgKclwEXMpEs8EwXt8epgWpVh4hBXw2DmOFNS0LguAMSEFqBmEi0yQ8NQOPukAQUjAttS6D25xNIVaZ8660QUKoJZkX5a+orxlpzT8fLk1lNZ8152drBa5cWlb/V9JT+HGYH1oW4UDC76UbLA1OQc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euKLAQ+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euKLAQ+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5574D1F0089B;
	Fri,  5 Jun 2026 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688257;
	bh=YXQHWInYSU9iZ+wVZTK0q83u3C+RhTg1T0mSRxoIGNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euKLAQ+LyckFwquVNRcyDYUQqgdJcDDthBRv5v751px5004ocPrMgiobz0/J+xit5
	 N93Axm7lyI3FjH2sq5W/Vn9NrFanDGV8uYkuGjPIa7+fgWyFbthn6JrW1YWgogycbL
	 MGO++z7/BNKv4w36UuoYbNjooyU9KlJg90hKNXqACto+OagDjoHpzduck93zRNbw94
	 wIiQHAerAn6Hf5OgkyHsoLb324XwyAhMnwMbJMh2b2yb9Jzw7CZhK4dMGTSVt0SPSG
	 HeGPM5PoC6beme4nwgbD7c5EJ5UsgLaoLVWvzPKxTHCVjwTzbefqrbstn/C59IYenQ
	 yC9PKADc8Dq1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: cypress_m8: fix memory corruption with small endpoint
Date: Fri,  5 Jun 2026 15:37:11 -0400
Message-ID: <20260605-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604083636.2650249-1-johan@kernel.org>
References: <2026060436-outcome-uptight-239a@gregkh> <20260604083636.2650249-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] USB: serial: cypress_m8: fix memory corruption with small endpoint

Queued for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y and 5.10.y, thanks.

-- 
Thanks,
Sasha
