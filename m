Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634638;
	b=fqPk78NOM8aXTNCBxvJRWijaV+0hpKkVJM7fDCAFcPVGlNo9ZwNG3A7uS8YOMp+TlI5M
	 PioEdlTPMWLACY5VPQxvKSwHj7tpBkgcFFIQgCveFQOjmpmaB8eRLnu1FWYFN5AuCTlIE
	 OZg+lZGOqaZLwKmAv050SsQmxCQS+WIw1NKb3QuGme0RKNR7WTmSeBUyrbfdMqmBIta2d
	 Pkt4xs045Tf2ABqcx6F3MFK+w6WKQJ/fv6IRoMwqm/P9m2R+hgM46zVxc5/0UVvjf7l/j
	 RTpZsDF+UBna19fl+fv55EiNxpXeppQjjr1jOt2SuB+sVDagnUKbYQ63PgNEGxyqk8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tO15jCGmhx7W4UuGA301GS32Ma7iGydlryUNr84SUK4=;
	b=Ki1q1QMhFj/Sz6W3GcFKQUIgU75r1xQ0ibjHGuHKu8MyfbGZ4D1JVQPn8heOTdGLEBZ3
	 s4XjobqE3k3NgWGtxGzFSse/0c2OuyVOm6nlsl8SlBPOJT2eB1bTiqOHjIe2wJTkD2FTH
	 ZxE8XeSjwmaPEzBIUbVpQtTPUXrF0dO+s6GYecqXKEgP0SfPxUNvvZQUHaJK3uRuvVzDi
	 qh0RuHIfeAhPXmQDf88PqLU0C/woCr6vfbR6PsScdsL0gExyISU6nQ/Z+lJj10iEd7ifR
	 qjHxYoDGLtSgcqdbZZ1rKqZIFd42bKNjXYmpqlOSm3i3zBRL5HG2rcIejZt6/YSILuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODcWWdTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15E606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODcWWdTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD6C1F000C1;
	Thu, 22 Oct 2026 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634637;
	bh=tO15jCGmhx7W4UuGA301GS32Ma7iGydlryUNr84SUK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ODcWWdTXhzfiQhWEoP+VVXa4NKKhz8nkgsc3YlwwNQHPDuNG2OZ/u7d8O01u3Y3JT
	 5bxLcOsEI1xAYuMVRtySFVBc5ScBtsVZetQxQeGcd6YT6O7O8bxxzJ7T+VMicQRpY+
	 MwWayucERT4L0bxtQdYI1Ols3ZdUFMWL/4+5twwiKb1PRmaf8z6tnM/mPNEH6FBEuE
	 y2s+kX85wE6/pV0PS51ay6qPxuOL5DkEOTspCtQmZ+SH2R42CmBzarW1pZnFrz/Rze
	 O2BD91+VCD4Dmx9X3w0uVacKlpe8ZihPzVfRXItNtKM1S1OWWh4MPaDF79jxKehbqP
	 F9kfg0MJB3wKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Hao Sun <sunhao.th@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
Date: Wed, 21 Oct 2026 22:03:26 -0400
Message-ID: <2026-10-21-1-daily-reply-0001-bpf-flow-keys-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019-cve-2024-26589-v1-1-e96c2b7dbe20@bootlin.com>
References: <20261019-cve-2024-26589-v1-1-e96c2b7dbe20@bootlin.com>
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

> For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
> for validation. However, variable offset ptr alu is not prohibited
> for this ptr kind. So the variable offset is not checked.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
