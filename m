Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2942DA34
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527498; cv=none; b=Dbt0qQaMSwCMsTCO237VXwbhXJSAO8RUXT89nIfWE/15f8tJbid1/j4RjNNhp4AXpcljFC+nyfdVH1Ytu8a4NoSRm4A6nvKgdK9ThPM6kYu4JjiiBOtkxcrJKGAY/p5QcZz75bZgGt6XLI3/8UazOy01kJYMyPv1TVcYrFtFTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527498; c=relaxed/simple;
	bh=Z77oCevfIR3pbeHzvsilpG3udijYIYRdK3NhZwtFVXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At6eJom5S1DDO1I5bDMZd7pfyCnTwHmIXuS6n7zE8SRiFYJ+zseItEbR27J3lrSFvpbzpNcVVY1ufb+qr0zykxbZXyxMRtW2QVcIfGpixEuUBTAR4Pk9gPk4bcfZB+4yDgRPeFuqRY2K7+sCjUye09+MZbXfjaoeRzE/cqRkxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1FyK8ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1FyK8ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765921F00A3E;
	Wed,  8 Jul 2026 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527497;
	bh=w6IGAxOVKX4I1hYiIVaYJNqmTwuBpnsL0vfvPP0k9JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1FyK8ffIlqgV+O78YzwLse1C3CvQ9E081TPnCrU3HYNvLqUJLV1xv763v73KRp5A
	 cGA2dEqJldOh9/uEOdWVizqSou2fzPHEh8vycYsArol8LL+1fScKkcCJ5ilNZU0Twm
	 xxLi7+h19VAAIRBUc5IRCFfwBLORO4WbxyUtoVyczHF0NHG/j+vOsY7+7z3x6ojfgB
	 TYbPyXH2M815Lg9CWBJzbtTqrtlQvEp8Wle/GEwbZxDdmrQdHALKcbS49rVwrK7pkV
	 zKsykznZyXv7Ke/pNQSch/Ams39QCz00ZcRVNBmrm7fmmmLnOGG5mg1Z+fDIJhREUS
	 y96VLQsgILXZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	wsa+renesas <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH linux-5.10.y-stable] mmc: renesas_sdhi: Add quirk entry for RZ/G2H SoC
Date: Wed,  8 Jul 2026 12:18:04 -0400
Message-ID: <20260708120506.agent5-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707104417.105834-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260707104417.105834-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 07, 2026 at 11:44:17AM +0100, Lad Prabhakar wrote:
> As requested [0], here is a patch to add the missing quirk entry
> for RZ/G2H SoC.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
