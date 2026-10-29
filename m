Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299435;
	b=Hf1pFb5B6hrFl2HcIwmeUHTQPbxhGE6WwtzE8O9opN0NqSpimBrB/pM4gf74i72iSkKo
	 BcOT/yEgesNPavIM//++1WE2XvpTrmzb6iprclzAIO/TNW/QF67cuvKQrHvNDs0Z9ouUz
	 N3HSgQf0bqQ3NgDFfVxOJB7KiLrGJCiV5EoDWz6UCchZvrHA4d3d0cDOtMMT5tojYak8e
	 vWt4V4NurCn/HG4hGy7q5gGv7tMicGddlay/yIaGFJK+msaqtFQ8fHroZXznvhXNDjbrx
	 WAjZ0HhkPi6ljjrCpTmVe9X+GSMGVdWVD/+Jfvl2CRlZEM7Dm+04JB3HTNT4iWLH55A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CtpDxwIoT1nrTi1nrGQzeAHOqSMBl/MAyoIlA+VWnP0=;
	b=ZT7F4HQ0IYOPkdfPRy2eozQZvadgHED2rPpOX3PMdGOJ2AcZysbIG9aq83hBc7xVunbA
	 0SE+534uBiH6a1Nr0JKeCTssQaWmAAyhtgb4/um15Jdte3G71Q0pmdTpyNI4RRxsegcc+
	 U0ypDTDU+FktvkL6+qRDSwvQdzRhd3EkytG6AgksKLDEqQ9BuwE62pHORi8uWINlG6NoP
	 L+wa53qYjdYOZthiC8mey2k7N0tiTG3FcEVGyPUJkjkNDTKkJl7Owh0Pui8jpYluAN6xF
	 URJRy3OWnrg+nuzUzj0ybhaxvR/wMm1O8KcoWJp3vrFWRBpX2R/hheFeITYkMSJAYVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KipDBXKq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3608606A331;
	Thu, 29 Oct 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KipDBXKq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C7C1F031F2;
	Thu, 29 Oct 2026 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299434;
	bh=CtpDxwIoT1nrTi1nrGQzeAHOqSMBl/MAyoIlA+VWnP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KipDBXKqL3PiEjjs0hHts6XbTkKe1GoyzxvHUP4bLeZ/wXx/lL8mFdW7MCCk5ynuk
	 pRhsIAnmUu3ABfkvvj1HAiRbpimojIH6qU86CZQSNrHpPU4Xajlh2pyo2Tes7qxrOu
	 EEKwDpyUb+PCrPqZZ49uG3l8ATnqhZMpuDDtk9ibaaqy28dvICetwAI3STBGLw95gg
	 sF1IFVBYEOXAj41Nffq9ck9wDbMEYg095wJeXK6zuhxxVP/5g+V12sQhwHGBPDDDMk
	 QhqC/rythRBSvt9wfjXr3u4YdLAQ8JxwGQ6amFiuN/70TSpo3QDhMePBCy4zJ4EVcp
	 wO+MUEySOCGUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.1.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Thu, 29 Oct 2026 14:43:24 -0400
Message-ID: <2026-10-29-1-daily-reply-0017-damon-pid-leaks-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141723.161776-1-sj@kernel.org>
References: <20261028141723.161776-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> DAMON sysfs interface can leak pids due to wrong error handlings.  The
> issue in the mainline has been fixed with code refactoring.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
