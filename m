Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1353AF664
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752686; cv=none; b=dVdk5/yZHKB7PTMmwK25RCWXnC3Nraf3T5jZut/59pHxEL02DbcZ0r2sx7c8x4+6WtnJRGY4XCgtU28jZAKEe8sL+7JZwao65GXbwCT9ue0wBPXOOvH8uCCI3vp46CF0A9p8PGWvLk2gOwtPu1g8swfJHNxBu289Mwp3Hx3FEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752686; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giIN6HTkLWAMGeqTGiXqK0/RdJGBiL2NEqa28F+9XcTZwtisPn4sFi+2qDrHdmUEKpdBQtTEGNLBKepH1aASM2U0sFwJC2pS7JC+6p3VXrX4RyTZzvzL8IrzUyvScmx448xUAw/9o5ZfJ/zxGVITdvhzyaKldpNXjcaYPq9eeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXD1ul35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXD1ul35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4511F0089A;
	Sat,  6 Jun 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752685;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXD1ul35jm47zqAJcZG/XXXQZNsFXhsqmVp8O7NqixNI87xnsw/hBL4aItYPeadoE
	 j05iNENUTPxgr6pmbc2DzG6W3mQ00U4FW7W7KWwb9yAfdJufGfh2lPb3FsgFc5VUHf
	 DtpPnDh0dJH4Zuzs4GbAAx7FS0kxFcDSxTgntcMDXwTWgr7h3QyfmTZ+srpqRIyDlG
	 Dz7aeD+qlSAIpP/PAzETSsNg0To4zB5G/USfeJT8S45/edZS6+MNldziDHAP8ruGEo
	 3r+OAjlePg3NapfGOB3INayN6DY06i1cTQOkvLu7oWAkaMsbk00ByVTxfjefeOjm/y
	 vJSL5FvddyfRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] serial: zs: Convert to use a platform device
Date: Sat,  6 Jun 2026 09:31:13 -0400
Message-ID: <20260606-stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605030505.6430-1-macro@orcam.me.uk>
References: <20260605030505.6430-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
