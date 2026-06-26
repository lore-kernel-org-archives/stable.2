Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A03AB28C;
	Fri, 26 Jun 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496492; cv=none; b=nvAGGLTUqI8+CuVKGsjB24wSfGh+Lzjr1MAbctuZSseqwNbKjAh2n1QIwU78Vw8yVM/Q3TwiUwOVEBIJc2azwl7djwPwD9WKrtf/Xop2nI3E4AyBpU1gGXc9vBdKN4iDIuk/6yNWvsaURh5q3lt0Aew2rmHRlBT/f3+3Z9UREhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496492; c=relaxed/simple;
	bh=58pkwoKTTU88PAx27+BnWDynnsvY3vRMeVeH7waI0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGyJ+oyj42X4+qI0xYgmNxdQt2PGBeC/qzqj8t5n7cGJZRGCg1aVESH1Ugae0f8zboGvxRFt3JuzRkDm8LBcoi+iWlwkuqnYCd7RaQ2r+DYFpC7u6DccUaUeCq6hi+hi/irhDgPxNs9pt2r2g6AxpjRiEDbF8K+5rVIGDO6Wa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9gg+Utu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9gg+Utu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A491F00A3A;
	Fri, 26 Jun 2026 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496491;
	bh=uahxyPEIH6t27GLrs4p650lz88F6UyvLhIoK911HudA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T9gg+UtuT3oG/JEmrA1jiFe9qMgZbbLgcRN3FGrliuqLGcJaUhyP8GkAdJVArtIFP
	 YAUaJT5MgDMznMRACGJFuQL2N63nr4v30roZo3rHnKy881PTzG/5t2m5I0Db9GS9DC
	 Z93mAyE4X8RQ0EKVO+RiFPcsbrcqMC8DRcoSy6yvoiSUr18NkRta98GaoQiTw60tix
	 2SN9IlpkCkOqgnPzp/j9c/SAUQZM5kyQfVlCTjgszBBxzhxszggSdNyHwHixJJ/fts
	 4EsGcsdB/sQc+uoa3iyYx1vtRsuU6DTdsb5SPyE394gE6EX9FL4WxZexeokcjvJ0Ii
	 z1yzH6SzJju3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:22 -0400
Message-ID: <stable-reply-item006-role-612-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112405.1777340-1-pbonzini@redhat.com>
References: <20260626112405.1777340-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
