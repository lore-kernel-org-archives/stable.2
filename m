Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826A3D667D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499689; cv=none; b=EQnvvpW2e7cab46p9awXfsbt78BD8ILB59HJWY6IyRhawFtGrNDXcfBX91otlJuYdlx+pgXvZx3Trre8taovBWEBWh4vLFmIeiZsaDj35fiA4Kf4w9yBEz2GyRtmhvqC3l4dA9TxmHy7Hj+kZUJME4g7yKLdBeR8if5AWolc6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499689; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2DhvV9q3FJXoeA92kWxZqpUbZm385Uoch5WfWYj38eBEL3n0GiWJkAsOelKpVd5iB5h/B+W0UnknGzIgZWF3sZrAEBdOM7eD+AR4ySPNMlNQ8akybWPd18DJVhplvaVnSnqB/eBLMd+c7z1RVPZ7eryd027nBoTAHK0n/ji8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnsUMgsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnsUMgsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99CA1F00899;
	Wed,  3 Jun 2026 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499688;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnsUMgsA71fvaWmBQGXzauZIM7JvSNX4UIf4zH1caC92YLafkpvHyuUGXXHj1I3bM
	 +oKQDbnyn3BLO40J9Z4nH8tB5bZ5FZlC4UGWaT8t41igMsXrOQnm4NeB2g0jcvr7qh
	 WGuqHAg0pBctk/ZGQ/ENrDdRdK+7E9HlSuCwr4xEvIMm1Gr4z/2sISKkWNi4eHSOc9
	 7bMD4H3cMP+z/jZoAQV8eaJGJRubC6Z0j5LNtUIeugBbXB8Mu1TQpEQ5+lr042/kbt
	 9pO3RyAwF19vEAlPzGZ26YvJ6oGGgQRJQUX1PTRaCMIhYfz0G/3YH0DkiDfHIasKi2
	 qLlYwtnJ8Mfsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tvlv: abort OGM send on tvlv append failure
Date: Wed,  3 Jun 2026 11:14:12 -0400
Message-ID: <20260603111500.item038@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528194602.258724-1-sven@narfation.org>
References: <20260528194602.258724-1-sven@narfation.org>
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
