Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B63F20ED
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658583; cv=none; b=Kh4svRvnU8MXgXjXqWqLKJJsvx6zsJcoLiE5rh9JBAz10CvXRkzePf3FQ47vEn8BhXItn5hQCDSO8QybOFDqGlIav5T1H2u768BhsX5mkF3dWj3V2cIVf9629TJPNq08p+R23o42Z/780ewP6EWpro+eYdAvjib0cJkpMtc9els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658583; c=relaxed/simple;
	bh=luSmJJGIgTcP1IXeAIYkVPbGD4KUInd5gTlE7yLwo8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kid6aqGD04E4yW9tteUJNj++DQ9oaLURxNgUMJXmHHZSptoLNWrTMKoxMgeNfNy+QHikByd7uqQgNBgRnqzioMLDbD4rI8DNepH/NrSo2prJgI0xtFuOW9FklZ++3wLAIZgFaoGOgPEKLSlOQG4xNSWLBzh61WsqGIrw4JLNxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGXsARAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGXsARAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799511F000E9;
	Tue, 25 Aug 2026 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658581;
	bh=byFI9W3WR6avUteXf4BUgrYFrTNniX7Bt8eE+L/cx98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGXsARAtcukhTaGBzSCXCumJOSH9w7gkNJyIaFsgw+jv/sdjVLS+E510QGt2p56yg
	 oFYqRZ4ZcVm99SnWUfd1ZbmK9mSa7tTaVToeTwGGQE/eYx8jK0/Ks9F1WmLp6gQ4We
	 kN5npYox2UvBwsDtnIHum05H/JY0Fdru7gbyl/ppIKXKc8m+Y6JbYjU9FEMnUZw1Sn
	 WC2zHP1KrXZva4yppv01v8yhvL2azX0iIzvZeCa0CsSrmEmBfMZmAqGJF9BHE1a/r2
	 +URbXWNLfvTlzlzOiLyNhw51G87f7l0Rw0UQiFrxXO3LHPdi3mkf4jbM+QA8ATE5Mu
	 tffJvlwksYlaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kenta Akagi <k@mgml.me>
Subject: Re: [PATCH 5.15.y v2 0/8] backport for CVE-2026-64561
Date: Tue, 25 Aug 2026 07:49:25 -0400
Message-ID: <202608250003.e10141c037c23a12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823130751.2880-1-k@mgml.me>
References: <20260823130751.2880-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 23, 2026 at 10:07:43PM +0900, Kenta Akagi wrote:
> This is v2 of the backport to fix CVE-2026-64561, v1 is Sasha's series [1].
>
> Patches 2-7 in this series correspond to patches 1-6 in v1; Patches 1 and 8 are new in v2.

Queued the series for 5.15, thanks.

One addition on my side: I inserted 18c841e1f411 ("KVM: x86: Retry page
fault if MMU reload is pending and root has no sp") immediately after
patch 1/8. It is the Cc: stable follow-up to a955cad84cda and the two
need to ship together.

-- 
Thanks,
Sasha
