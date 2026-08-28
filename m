Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0331327D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881595; cv=none; b=Dc8wsDSyZ3W4HkAzE+swzkyZEiEGxEyCF79DO2FYGHHB6JNglzt6juVCjufWNPOTBW4WSeZ/czuzjjK9lIrY8mM5VuH/9kfM5HxS6M0y1WuDCcV+poXtDfQ/BM5qND+wu2JnjnXPOGdPx8b5lpcCi6D9VugKpnQCeT5MBaCKinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881595; c=relaxed/simple;
	bh=O97G57hEFn0xoQi9hsmvA/Ey/8waEmgBmwKG+5LMQ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq7G+NaSdTFfIl3kmOWlok7lJ/ESKMbYuYNvdccY4iCWvzDrvWTTTx97ch+Ep/0DemkW0pWy7H+si2+WT4VsA8EKbQy4b2Nd8SFCaHzLIMi0sYVVYwygyDP0pPQi348Gs9iiS/KF/eXD3SbTPRAgUpt+jICvHycYnWt5EJ7I9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Neu1JVNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Neu1JVNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628011F00A3D;
	Fri, 28 Aug 2026 01:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881590;
	bh=GQvuv67P0WWE+DDUF+4I2f49RUal445O3ta+AvSR6+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Neu1JVNBBfkkH6sGcXfvuj0cXKlMEvnl1V9rwvyv3VbtNsN1vV1sWVxnS0y8fAnE4
	 4bu2SJk4rrm/q4TTIn70zje0UlLljz9WubzEmOBk2+zkl8PbcTlfm9/6OGXCrqkhBU
	 jqZ5tMAdBT9sB2u96WTHyz1YWR2LR7VUSeG3lDYeLUplzXiO1Iwlh+dgJ84yh7Z2PL
	 07Sx0pbr/QDKS4TG66gwkZ8dJIF47zorHMk5rNBFjPK89CmBwOMPrAr+lElX/AJXFe
	 rD0TSdCAxYqxijhd3aYnZuQVDZbAAKXUiTeZHj/o6INxW8W0653FDAMh1goen4m3SL
	 p4T5d1obZLtSw==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
Subject: Re: backport/fix for CVE-2026-43198 missing 6.12.x ?
Date: Thu, 27 Aug 2026 21:46:16 -0400
Message-ID: <20260827-stable-daily-0002-cve-2026-43198@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <01e4f29ebe9590b2c5a91697b0fa4e23861bba77.camel@nokia.com>
References: <01e4f29ebe9590b2c5a91697b0fa4e23861bba77.camel@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Looking in latest 6.12.x kernel I cannot find any evidence of a fix for CVE-2026-43198.
> Is it missing or is 6.12.x unaffected ?

It is missing, not inapplicable. 6.18.y has it; 6.12.y and everything
older do not.

Each of 6.12/6.6/6.1/5.15/5.10 needs a hand-adapted version. Patches
appreciated...

-- 
Thanks,
Sasha
