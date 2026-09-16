Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2832C031E;
	Wed, 16 Sep 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566815; cv=none; b=n7YbH6v2sbaMbY/xHa25I/YQ9ghG8J68R2zIy1Wgd9JFmYaj5l07wfbrkC7D28Jpk/Ot7cI7dpN2YK1vINK5TuSn8YddRCywYn2nkdt0aKVp3kWPc31S8MpaL44RtdNBveQsPiE4IRPlFG/YX5FYmNQtHMFRhjyGCEGXJcyWBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566815; c=relaxed/simple;
	bh=F+ogjzRTqJoY+avP/BaOf0jCQ1Yn93zIUwe02EPjbLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dEVoBR1sCvo0T3DzNFbcWUTlh8P7w0T/342VjcTSp0Gl4JTk05td1Nh5/mHDrFcP/CsfMEBtz2K7nPqo1nANvwdVBd4SBZHJzmIcm9VEEE9LlIezRHz/bBLk+oH6THjitadhwKeX1oIzKKwhlYnv4bx1hoi2yiuK+7Elutmj3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQa0H7jr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQa0H7jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1631F000FF;
	Wed, 16 Sep 2026 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566808;
	bh=BU994nwZLXtuwX2RaHmsyMsirnCZZHZd31xqMqLqqxg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WQa0H7jrD2G7hDGNEc0T0Cr2SFSbH+jEpsaqM0tfu6KPKWWh6S113FEUIlKse1mrt
	 HIT1/pDZTd5136Hgm8GvUYQQeMTXuRyipRiAsthCN4clRaDXrB3d8qWQVPKEwGSyEx
	 He4jVSRDucLts354PD90DIa2jJq4H5PoqZZ9GhzHdHTi5NMeTPi4YPIRH64cPgQ1yb
	 WKIYdm5r5ptUY7Mawt069TWfzQ8AKYYHnfUKlTxidWv61qe/FDnLDTlW2yZmTho3bI
	 Y8OgcX2w0s6H/dQL7eS8Z2Pvan3xFPmW8g0Bwj+cXI8ulyTYpggpNCsWe2JBp7TKjv
	 sWDQJe+TtQQtw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260903-wcd-dma-v3-0-d3920c6563c4@ixit.cz>
References: <20260903-wcd-dma-v3-0-d3920c6563c4@ixit.cz>
Subject: Re: [PATCH v3 0/2] wcd934x fixes
Message-Id: <178956680650.1616494.14944497781429146767.b4-ty@b4>
Date: Wed, 16 Sep 2026 14:53:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 03 Sep 2026 17:21:41 +0200, David Heidelberg wrote:
> $subj

Applied, thanks!

[1/2] mfd: wcd934x: Fix NULL pointer dereference on IRQ probe deferral
      commit: 1389a4a5877403e57573d6bc01c5b7790a4472ce
[2/2] mfd: wcd934x: Set DMA mask on parent to silence "DMA mask not set"
      (no commit info)

--
Lee Jones [李琼斯]

