Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1385431A28;
	Mon,  3 Aug 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790342; cv=none; b=RctSPUFQrzJ1kDXx4wAeC1p597qAjQqxqVHHKuPnLu8MMB7UeCndH+cMMVri0KIZNR1t/GJ5EnLf4kcOKQWiPofSYW7G5vmO1pXxgQnj0HEG+EGYpTRaTLWfJnhCeLJhLMrzLZMG1EdXcvLocdmOMd29JZ3PzWbrCjWviwvS1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790342; c=relaxed/simple;
	bh=EjSj8LHYY6/NLa8uYwGlS3tg7W/tnIcE8eHhTYcMyuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3UZT4BdWRNS3k3XBkDLJVZ31KVHaj2C7bcrKnTKD9qDVzWjboxnZIakoEylzZ94S4t+qRG3xa4sy0nkscdXdMrewOnzhzMGuOuXmhVD0JIYGyqeYZcxyGUGDcpa3oopXeSTORVEeM2TBwb/z0vVo2HA1NQu/tgySAEYV/1Kfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjkV7NNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjkV7NNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C41F000E9;
	Mon,  3 Aug 2026 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790341;
	bh=aMMK2jLCdY/b4YFQkTWS5S1uCCTLXTrZTqW6ilix4Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jjkV7NNRSjP6ubYbrNfRE3PPVTsTI1zwKd+Wyy+npoezsM+lrKnmBa8VIlUs74zZx
	 5M0IVDmAWGn0MI6S3vTpJjKxDOKCAlNQ8l6VyxSqvkGqi6kLf61PAmaYuiN0Rp3bo4
	 TYmRmcN+Ka1cV0+Q106QqU+eovmYw8c5MhHP9YVh+GcYfdMeg2W03AtTsdmEsgSajM
	 dCYONKnwcYsXaB138b8WvoqXIBsOwdAmOCZl8ow0vX0PkHgVTWJPL2wPOYmiqOZrOm
	 xvaxfORAo0sUB5Q3ouSChKG7RSlUBn2N6CweokwjL6mO7sMsBEO2h8rGz5YZmpB3xI
	 3pegA8Q0xM68Q==
From: Danilo Krummrich <dakr@kernel.org>
To: Younes Akhouayri <git@younes.io>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Timur Tabi <ttabi@nvidia.com>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] rust: dma: return zero for Coherent reads past EOF
Date: Mon,  3 Aug 2026 22:52:15 +0200
Message-ID: <20260803205215.3626518-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io>
References: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 18:34:38 +0200, Younes Akhouayri wrote:
> [PATCH v2] rust: dma: return zero for Coherent reads past EOF

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: dma: return zero for Coherent reads past EOF
      commit: 5391b147d9fd

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
