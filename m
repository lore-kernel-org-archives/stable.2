Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8B2EC0A2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941248; cv=none; b=Vq7Q3IeqpQBbu0Hu5dYmLqftOVM8pMC9M68MWeLlWKK9L/k40o07LiEaKBDEHPeJxQ7EM73BSOT0IkAjvTmGKFBtZy75yXYy/JbX1damTD6vxpboanU0K0RRXcfYZVe9TymZhNBP8UE+Ae0ZVV92lmii4Uc2wL3JCrMSjDahx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941248; c=relaxed/simple;
	bh=PTSXJAF19JTQNPSUrNQ3K36CneDeqCKxKeodivVRdvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIBHdGeoiOOfjMB3jPx6PGGUsMSv4zT+7Hufd2n7yPGdWWUIfbgGXYrJ5MfYJYke9IR8wY4+i3eGfQT+HPwVC0SF7gsURUSYV87axAsYmqklZe95+zXAOojddTEQ9T5+eeJuOaZo24xtx6DGJzGIFxzZt9k9ZwuYnICjDETqDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuIDty+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuIDty+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25421F000FF;
	Wed, 14 Oct 2026 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941247;
	bh=uQ2yEiOBkRe7NQMdD6ffhVnWJhLWl+cDkpRU7kN3Qak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fuIDty+LVvrs38rC9WwcjtFNd6YGaoV3lJOWynZsjNnul2viDVTPl1nHsUrs/Uq3Z
	 J+253k1H09DknaJw09AYNEjeYi17Ad5tZVdjHEfsM8pd62kHIlzisJMFwpSsTzS8AG
	 FWwOBXmspeAhMqO/bcCd0wHBv+WAVTL7ahE/6irKqSCivzMWxTkcBbspPPDQ6SYo+b
	 MY1N8rnT3G/2DD96mBj4b5qjU0SV3HDylRYGiXiETfC0O25nyrKNTEGjoGEPLb1AP2
	 zt+DI2gCi2bQH2QwkZSGJOkJB62F8TeTJOrAbCQJ+8/bE5iF/J2hWeUB3IAKeCWngY
	 Pw0kTKrvUTINw==
From: Sasha Levin <sashal@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Norbert Szetei <norbert@doyensec.com>,
	Dave Chinner <dchinner@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.18.y] xfs: fix exchange-range-to-eof file size exchange
Date: Tue, 13 Oct 2026 21:26:57 -0400
Message-ID: <2026-10-13-1-daily-reply-0006-xfs-exchange-range-reflink-flags-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012165444.GZ1615495@frogsfrogsfrogs>
References: <20261012165444.GZ1615495@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You might want to pick up "xfs: stop exchanging reflink flags when
> exchanging mappings" for 6.18 as well.

Queued both for 6.18, thanks.

-- 
Thanks,
Sasha
