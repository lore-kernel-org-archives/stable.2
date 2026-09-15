Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C572874FB;
	Tue, 15 Sep 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433573; cv=none; b=Co89KHVo0ruSY4d9fhAw2DnOqp92GXY2IX4fhchS3Ek329cDYjDCNVhu38WXltc+iVxq1CHY8oYzgYoyJUONoTLjXlpN5qz+gtwbFMS4zIgC2v697Si62XHbDsUcUM+0TUZUlwFkDU2YhDUrMiB3CmqZkfucb75TDbOC1zCioDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433573; c=relaxed/simple;
	bh=FIrIogaDSap4zaV+vJPwNPh7LCUAsFlXFOwPZz3dG5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwFPAYg7zJxO8PPapjp0+V1D+mKRhiVeypjwSIio4YWKWf0WJouMp72z5Z786PSNFlv/AbgY0cGh7pF2+urBzARTSIZHJuYlTQtrQSjN97/9i2LfSsvmfBINWqpj+afKR0LNRdvHR6XOFWft72nKP+e+TfAPShwThE0hn0j5cD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irw5Icpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irw5Icpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92B91F000FF;
	Tue, 15 Sep 2026 00:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789433571;
	bh=OVMWAR6x9fDMUjH1lB9+DV4vSGMK5AQu+CQ6AxaYNAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Irw5IcpdeCbRRsaMzctOGKc22Ww0JrpTSfSNkm6UT1LolN+S5bF2C4G4/iAdTz3rL
	 xt/2oyshNR9D92KowI1Tv18DYUidYsRWmydZ5vargdW0duhk4p4VqSPjFiH20XdzZQ
	 pQNMjzzxnclEXjATQTr9DY97AOcM9TUbCuxSPMSU4tKXw7Ly6+LQmR5pQ1vJWDAsuX
	 /bSnmEFr/mlQq5wjDlqa90QvrttZGvQ50Mvqrf8kMwaffGf0DxuOVlxdjOyNnKlNKD
	 QGOtnvAW3Rxpaco+vwJYeSy5+7fv0mzoDv8qV4EmLp78dBHmuXrHXQqdjYGwL9QT1s
	 fE+CiMepGtU0g==
From: Yixun Lan <dlan@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>,
	Haylen Chu <heylenay@4d2.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	stable@vger.kernel.org,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] clk: spacemit: k3: add CPU PLL rate tables
Date: Tue, 15 Sep 2026 00:52:44 +0000
Message-ID: <178943352203.3672070.9474321252308932428.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907-k3-pll5-pll8-1800mhz-v5-1-5cc96d716b0a@linux.spacemit.com>
References: <20260907-k3-pll5-pll8-1800mhz-v5-1-5cc96d716b0a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Sep 2026 09:54:36 +0800, Troy Mitchell wrote:
> The K3 CPU PLL rate tables currently describe only one rate per PLL,
> although the hardware supports a wider range.
> 
> PLL3 and PLL4 support rates from 1.05 to 2.4 GHz, while PLL5 and PLL8
> support rates from 1.05 to 2 GHz. Populate the tables with every
> supported rate in 50 MHz steps.
> 
> [...]

Applied, thanks!

[1/1] clk: spacemit: k3: add CPU PLL rate tables
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=d558af8ee0bb1b2e88e696be84adb93cf2b7be6f

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
