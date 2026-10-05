Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F4477E2E;
	Mon,  5 Oct 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197017; cv=none; b=Ql9RqLA0LOx6UbefRvWnkB3ADF9Mc5pBMj+knwewH+/Z1K4oC3wZVJJhzWbeouiPBLiWLstIA5NBf4Zzc69jlf51f8ybhchNhi/0/LDqS35ylJq5bjLR1yGyFe5CjQK0QzwDLg0CWlm5wb/PWLjJC1RipHM7iLRdzHuCgqT+z1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197017; c=relaxed/simple;
	bh=1r9Zy4rUA0hJWHzu/wbDg/CORkn5tv3aD2QFTlY6W7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/x4K4qCIEXboTX4wHeBrSFbrmx9AwRl6aYvPm0Qunw9YyKu8Qb1SCPLG1IHCAfpwQEfdSy+2ERA6Ae8eVJv1jhdH0OvEnDUcvqhXAKZSG3jVG/bjpin11f2A9tDd+ffqd32A4Z8/KEh2AMkXO38E1/8oY7qkOgN7+fDjljCYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbDtHklA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbDtHklA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92031F00893;
	Mon,  5 Oct 2026 10:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197016;
	bh=UE1ia2+Nnud8lkNlwJM2jeNw6p+Ex5NbnOjwL06Qys0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbDtHklAq128TTT3jUfClAR3xWOifVFJPEnubk4AizHnxIh19nAdiBH00borMMGqb
	 MAByAPlZgwLeHr29YA1AU3O1TrkOcGP8mkFJ77PQAefyTWj54GNmaJ6dsHYSAVvuhF
	 O7/xIkhsHbhsIrTaLqeX/r9UCJs4OQdtwHfaQ6srnFxfRdv9zj4I7r+4qsD/y98567
	 dz6LKDD+C5PGOiwV7+J+fdUI5btnNGAIIjpsZQOSuXg2UoLwqLLEIlHUZYPe4wTd64
	 aolLoU0lhO0Cq6uPtbMKV+YBEjXPTlioPWrLJM1iCBBlPSdL5aJcjUBfY3VFs78swS
	 iQYCnEjoBAsDQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Myeonghun Pak <mhun512@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] soc: fsl: dpio: Fix IRQ cleanup during probe and removal
Date: Mon,  5 Oct 2026 12:43:20 +0200
Message-ID: <179119699110.180542.13258001668157935133.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002194802.375497-1-mhun512@gmail.com>
References: <20261002194802.375497-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; i=chleroy@kernel.org; h=from:subject:message-id; bh=JwNYDRoRQhU9WQin3CftpaZ6xeoE0xQIsjPgxSQIBJM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQdrveyvLVe91fb/K1b+vZIn2RcyCvKuOO23mmNkocn9 xxs6Fgq0lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAm8uoeI8OzmZGPhVU/fPia Urxe8uK9vqSF5slLv1fx/C26nXtn2fbHDP/UnrerP1ip5bfrmxavl+KEKbdXqs//mverxb504nO z8tdMAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 02 Oct 2026 15:48:00 -0400, Myeonghun Pak wrote:
> This series fixes two DPIO I/O object lifetime issues during probe
> failure and device removal.
> 
> Patch 1 releases the I/O object when IRQ registration fails and removes
> the unnecessary unregister call from the probe error path. Patch 2 frees
> the managed IRQ before returning its resource to the MC pool and before
> releasing the I/O object during removal.
> 
> [...]

Applied, thanks!

[1/2] soc: fsl: dpio: Fix cleanup on IRQ registration failure
      commit: 899559907f9d8bce0720f6d4336b2871e83957ae
[2/2] soc: fsl: dpio: Free the IRQ before releasing the I/O object
      commit: c4ddf1eb1d321e40d82fb89d34b61edb3f927198

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>
