Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C13769F8
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331102; cv=none; b=la6nXVbj3MVrl3LwUOSXzsf8D+0/gXxdgKMqA3UovAOYRPkBjmd5BdUSa1/Ga+FDTQiw+PBf2kqciwjkpC0d6oL+bgIFPNYLBIHjvkD03Pz/eOttlvyxpcebc4GRx8S9g7Joktsa5lfq+t8ZJO2NCpMiS2uhkLgqnUCNRdQlW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331102; c=relaxed/simple;
	bh=rwFrErnnGNVnQ5Wg2M6KyzZvMet1z5SLZzeppmDk66Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clsCvPU35uPI+GOtViNr8FATubVRPrLez0PIZ97w/JMtWz7q6cZDhxOg+UOV8vg/QJx4/Wdz7zNllgXCJKBPnkt128SlLFoCxw2WeQLxyNf9MmiRIpPKiqmVTPGFkpod+XXFCOIMnB6Awms/VD+XMF9I2Ht/Y1UfHueUSyDJsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvFMr3mX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvFMr3mX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAAF1F01561;
	Fri, 21 Aug 2026 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331093;
	bh=9Ki5dD6huXJKMCoWQJEy+MAj3g2KSl+ujtO8OmPRkKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvFMr3mXW6UsWgvRX2fCILgrkbzWHUuEJqfrKY0+GUwPvRNTjESQ+XmP+2nF/PV0+
	 Ml47FBOELy7h/iWEhP+Qlh9ibuKOm9+f5VeDtFYhkXB87Gs4RAK430QAsmk44LLeRF
	 5ksEZRLEZ7J/W2rjWUcUoPo1+jOj6hBkYI3U7truYDRftR3W4+98YU4nwT0X1hHPr2
	 5QcJ46C8OOeH/PQDuceObrOBxJf5t0YaNF4sWWC/cpMu+UJPZTk82dAzhGd+WJ1nxS
	 P0tR9HPUuhnZxk0hItXx+au0jJfrSv9K22SJh7KAm2tehGBlRQNz44tB/xeSS0FCPi
	 7j4To1S4uH0jw==
From: Sasha Levin <sashal@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.12.y 1/2] selftests: tls: add rekey tests
Date: Fri, 21 Aug 2026 12:51:30 -0400
Message-ID: <20260821152000.rc-tls-rekey@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aoXJfMDP52O9vZVY@krikkit>
References: <2026081717-verbalize-stylist-2627@gregkh> <20260819113944.3620902-1-sashal@kernel.org> <aoXJfMDP52O9vZVY@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 19, 2026 at 05:19:24PM +0200, Sabrina Dubroca wrote:
> All of those rekey tests are going to fail if you don't take the rekey
> implementation as well (which I hope isn't getting backported to any
> stable kernels). You probably don't want that.

You're right, and thanks for catching it.

To be unambiguous about what this actually affected: the 6.12.y series
you're replying to here was never queued, so there was nothing to drop
on 6.12. The same selftest had, however, already been queued for 6.6
from a separate 6.6.y posting, and that is what I've now dropped. Three
patches came out of the 6.6 queue:

  - selftests: tls: add rekey tests (555f0edb9ff0)
  - selftests: tls: add test with a partially invalid iov (dc54b813df63)
  - tls: rx: restore msg_iter before TLS 1.3 optimistic retry (1c8629651cb5)

On 6.6 it's worse than the tests failing - the selftest doesn't even
build. tls_crypto_info_init() only grew its key_generation argument in
b2e584aa3c71, which isn't in 6.6, so the ~20 four-argument call sites
the rekey patch adds fail to compile, and __test_passed() (69fe8ec4f673,
v6.9) is missing from 6.6's kselftest_harness.h. And of course the rekey
implementation itself (0471b1093e3a, 47069594e67e, 510128b30f2d) isn't
there, so tls_main.c still returns -EBUSY on the second setsockopt()
that every rekey test expects to succeed.

-- 
Thanks,
Sasha
