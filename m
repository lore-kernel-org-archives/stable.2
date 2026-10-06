Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F641A6822;
	Tue,  6 Oct 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322562; cv=none; b=bn2mdj9mlrNU4nnTw/NFlwBboYBBlIPEJPvhQwFl21Q1dRz5Lx7E9wxwq1cdkyzdHyCB8NxGUoNK1hQm7NrUgu9lbLQlhhh86GJ4AedZ6wSGSBvdfR99LAxqM3W4T4XMBGJgl9E+2vfhSoUKpqLQ2ev87f/XbdJ6tlUuVE8l8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322562; c=relaxed/simple;
	bh=zDf5i7g56yUgldO+uKizR1LEMzjOYLiT1nezTBpSFYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWoBWSLO9+XArDM6JNTn4t4CidibReyV9if05yDXyurDNocLxaqGSFYPG5asJEWJlupbmWbkeQXTJpmp1Od/jTkJWsZQ2z/XWCY2zE2ySOCQRByelqlN/0LbgxJ+wIIH3r1k6NMJZCqfElWTcL8jiOPgz4zY6qeq5HcwNtGNrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWpMlmww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWpMlmww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC521F0089B;
	Tue,  6 Oct 2026 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322561;
	bh=V75Dwil5bjHLo9gcPp/ym87OIYXFwm6lkAQbyOmaYHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWpMlmww95agpOxjP7+B8t6pIoYm+juKiS8JEl/X2sH7AoVXmjO2wOnUTVxPEGzfc
	 qed+cSOM2ETTD35ODp1rXVpIVCdY13RuxBRy5GDylcAUfxuWwT022m+bQUbbJcliO/
	 GcmarzscEZ1HBf7xVEmgcfpcq2Rcd4iCKZ/eysZER/QqtCwFpSUCH2BX2ZXnAjJC8v
	 uMJ1oIcpyOrVCphE5fCZ5dmUp6gh1vorPHvt2GyBukyxHRWrxcd0Xm8KgIzjH3gZbg
	 4LGJZi8S+vHy98XQZEKe4DW5c8VvfzR7ruvjoiwq3rCveCVa4YiviGXZMySQpv+l8C
	 ZjIy+AXXM/MVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Gary Guo <gary@garyguo.net>,
	Markus Probst <markus.probst@posteo.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 6.18.y 5/5] rust: irq: pass RegistrationInner as cookie to request_irq
Date: Tue,  6 Oct 2026 17:35:33 -0400
Message-ID: <2026-10-06-1-daily-reply-0001-rust-irq-cookie-7.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-devres-6-18-backport-v1-5-06dcf0e592d5@google.com>
References: <20261005-devres-6-18-backport-v1-5-06dcf0e592d5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is not needed in mainline because commit 98c63ce4d760 ("rust: irq:
> make Registration compatible with lifetime-bound drivers") removed
> Devres from irq::Registration.

7.2 has the same uninitialized read. Devres::new() returns Result<Self>
there as well, since ba268514ea14 ("rust: devres: fix race condition due
to nesting") is already in v7.0, and the refactor you cite only arrives in
v7.3. This patch does not apply to 7.2 as is, because d1880d5f5899 ("rust:
irq: move 'static bounds to traits") moved the context lines.

Could you send a 7.2.y variant of this patch? We will queue the 6.18
series together with it.

-- 
Thanks,
Sasha
