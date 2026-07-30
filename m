Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D7344036
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379248; cv=none; b=aP1I4x0RHds0TBeV68zkhQGGMul4GwzWe1xnvH/q5LSvMIf2hUsaCAa/vD4dluVrCsSpx0e4Jk6PF4AQKcQtbiY5GNc17BmfPGL0FVVoZxJyv1C2iEqDi99UPRjb1qP5FN19dy7XJf4qM57rMi+TSNM9k5maFULv7Bc+UAJgCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379248; c=relaxed/simple;
	bh=XK1Lc1yanP84gdNL4xQlEfPmkWyB3Je2araitiGCo0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vvs+A6x8GuBCTbSR/BjAeyI8wF7OJU+zLyWAx4UXL8c9f2X2A0H3j5JBna6XVfXDDHWtmyKZwVlHSZ6UE4j8gYLkoVG2oTepTxxPfqh1ijJBJv8Z9/iDG0jNMaYH8xtw45KihvCDEWThJOnjgRczRqHaPVnVzaWE7zlGLaSsJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG9kf6n4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG9kf6n4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA51F00A3D;
	Thu, 30 Jul 2026 02:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379247;
	bh=aQMjZ+DxuV+mwOwXhI0rEXzkzGFlIO2Vz/gz2q2tllc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gG9kf6n4KomUk8Ms3pjaoUUbLj5WgCY1x3q3BrDeYKHNrqQshZSlJ+Z/3A1LDJtP+
	 YwyLkW3NBy/eMQ/BuMI2X9Vz9ypn+BBv+awLNNVBhivZJgFO66PO7mT1Tbcna/HpFg
	 +V8daaqoec35PTwdbHpOlk0SSAeaUYkxBH9RnRuldeahHI7oo7hFhm4Z+fjU8f51QY
	 H1/cqrmSkVCtzFGVUoO2lX78V/wav0KGrgk551ZExm+nzxjG2RsHViXN1Mpj8jm8iK
	 saUc8TOnlRUJREQaKRGRrqOB3owvt18WbNaiS+l12p05MKCL2PPcHqZTXnB72NcqN7
	 AtTcDETX00R6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] openvswitch: fix GSO userspace truncation underflow
Date: Wed, 29 Jul 2026 22:40:13 -0400
Message-ID: <20260729223316.stable-0017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729205609.628158-1-i.maximets@ovn.org>
References: <20260729205609.628158-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] openvswitch: fix GSO userspace truncation underflow

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
