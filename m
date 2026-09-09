Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0E476697;
	Wed,  9 Sep 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986986; cv=none; b=O5fbNYi+XB0FAz6LNWUDF8Hhaa9fga/Tc+wGcRJGn6zjIhoh0IQT6MkIWFt2A6H4dBD6w/KhQa18/Bi9/eol2uzo6rJ3XdoOLINlDgk3TNwxoSc4pKjSBVQ25234jWKOIhsLcuPvs7kE/CEcy7cQLnic3Ebnr9M29Y1J/nGd1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986986; c=relaxed/simple;
	bh=po+xRNd7Qif7JrgwlJ64ORUxnv3PE97/J5WFJZeru9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t1qvZ3BaT2X3vN1V2dXsEayPX3dUnSMDccrjeTmh0QPAFOAB7f92mjJEtI348fdxFHBKf/2T4CVrHk15OKRj0N8cV0LYA/JWTnF9Mp4a/0sP73DkREjZGEkg5bqsftxeofKke2gs1LTxiYVKG12WXbo9HhywXGGctmEFe7hQ2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700181F0089C;
	Wed,  9 Sep 2026 20:49:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E8A72183379; Wed, 09 Sep 2026 22:49:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Robin Snyders <robin@snyders.xyz>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
Subject: Re: [PATCH 0/5] power: supply: qcom_smbx: fix watchdog and battery
 properties
Message-Id: <178898697194.883277.17587084710310947312.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Wed, 12 Aug 2026 01:29:57 +0200, Robin Snyders wrote:
> Fix five bugs in the existing Qualcomm SMB2 charger driver.
> 
> The watchdog bark handler omits the charger peripheral base and can write
> an unrelated SPMI register. Battery health handling compares the complete
> status register instead of testing its independent fault bits. The
> float-voltage calculation is one selector step too high, and its battery
> target is neither selected nor validated safely. Finally, the
> battery-overvoltage IRQ ignores read errors and only publishes assertion,
> leaving health and status stale after the falling-edge recovery interrupt.
> 
> [...]

Applied, thanks!

[1/5] power: supply: qcom_smbx: include base when petting watchdog
      commit: 2cbea120515bc23416cbf0d811a49dff50692a0c
[2/5] power: supply: qcom_smbx: test battery health status bits
      commit: a7749f679da9bd644e0450a58b7f38778a5e3c66
[3/5] power: supply: qcom_smbx: fix float voltage selector
      commit: f42b11ed65e8f2f54a403824193986ff28531a26
[4/5] power: supply: qcom_smbx: validate battery float voltage
      commit: 04370b7eab3fdfcb7e7d3bf32bc3e62e44769768
[5/5] power: supply: qcom_smbx: notify battery overvoltage recovery
      commit: 85ca07e187e1c93e2e5527140815f20bc5f8ac85

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

