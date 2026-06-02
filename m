Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B53396591
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424518; cv=none; b=ei9tT1VD+nIQ+BIque2AYqI4q+qJTlhFJFFGBh5V7fwLL0dkO0Cz7jjAvntxEhKcg15cPrxyLlWS4pvXwV65g8FZADklIYqorsgD+OiochuPvvLCIpenDMI7T7diEo9xkU+tVKSgAg69exB8KuCVEwHbJPSu051gkOUP93yQfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424518; c=relaxed/simple;
	bh=baXEPQjezCDzpC0P/8AFVrtXwhk1wdGOYlrPF1rAmr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7XB02T3so5S+jtB9gpO3IaFKspWFz1nFEBwPBRTEmTEcZDuc2uQo8Fv1dD1RnmQZWqrh64i4xlki1SHieJclWzwo3wDPTmtGm5UISbpahGYOh7e/4HAFuVMxvaJ+ZA621ej8AVNlY9CU/a8PXd7ue3p/CPFSlQYuDtkUccq/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3oKUrVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3oKUrVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08281F00898;
	Tue,  2 Jun 2026 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424516;
	bh=baXEPQjezCDzpC0P/8AFVrtXwhk1wdGOYlrPF1rAmr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3oKUrVAAuSS37Mk8slUfKKGgiN3hhIoDiNoH39+0TSqeAalo6cZPtIb2Awdn7her
	 rwoqgGkJi0NBE+dihhyLQ+gFaldar1mcaULbOaY4L91qyiLhnJ26By9EUcdscTQJqQ
	 hbYuarqNTP3+HTBnIKg5EfzezJom3cKhQmljSb9N954b9oFmN8ywUJ+NqT35qz4fX+
	 C6c6oYuLrQyKmVTQmjQHbm6jbUeXs6m0po0+6lrgnUpu4GAzyVzbNG8Fo2GI2m0wSl
	 1tT4eWt1Zz9fdcZQAJ08fVA4QSoT7mC0OtpruYJaY3PlWcJALdNbzU0IKPpslN89jT
	 rKliXc4VsG6MA==
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.12-stable v2 00/15] Backport: arm64: debug: remove hook registration, split exception entry
Date: Tue,  2 Jun 2026 14:21:32 -0400
Message-ID: <20260602180900.arm64-debug-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601102554.233076-1-bigeasy@linutronix.de>
References: <20260601102554.233076-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 01, 2026 at 12:25:39PM +0200, Sebastian Andrzej Siewior wrote:
> [PATCH v6.12-stable v2 00/15] Backport: arm64: debug: remove hook registration, split exception entry

Thanks, all 15 patches now applied to 6.12.y.

--
Thanks,
Sasha
