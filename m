Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456D4AFE0F;
	Wed, 14 Oct 2026 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017212; cv=none; b=qGMZs3VY8bvueEFZIbLYqIsH0Ppl11tIUcZo6tBe/nklCYUb1zSnW0VNL+iNYlG5FsTQyzZT2iyeoAkNt7WjbUwoe5KtdkqfUujY5txFtngDF0voo+BXenXrJf6r0vroAUdEktKnejdFWkt5J20ImZqSLakGW/Qva8AjNhlBYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017212; c=relaxed/simple;
	bh=Ym9rQhNbxcI/dm5Sd9OxkMAQDZAkFKqGyf0cwWTTnrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUIq6O5vlZVwwWvEAKaXwVdaSAxi1UAp1GWSDUVRodDEUcaRFrcLZ3KQbbNznny7T0MuuhnDbVjEAisy1HHAFkawtR3f9WWl8cNvrWRW6Q5kgNaVjjU0C0pSfcUIDmX5UAepxg7WjJIvU61+DMEAPRNm0n9XMUQJvHdjO+ANe4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXSGfpcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXSGfpcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD651F000C7;
	Wed, 14 Oct 2026 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792017211;
	bh=dBPAnOqfcHl4bVqNA6BtaYXXGHeXlX0sKaMRq56krc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXSGfpcsTswRWYIP+GgSA/BiGHib+8rdj3LbbWH87U8ARoC7JllbbKHIrLiKiMN0S
	 /D7LYdYGCr2X6aPRmg3wqZJE/XhM0+gO067FIamzclY5dlP2MFyMlu+r+gH2t4UZax
	 4PDijTWMvBrvi4IBPtgAkL2Roj3B8fwj5LJeIaeH8x4ImUaNG2/mDs4bV9GA0UrWyJ
	 puvQ5tXSYOq7qmgKtcWITNoTAja+daeKbUWLGXU3WFeLbAPo8bv+psw0RQ18JQf1kl
	 jZ6CYFykSzFIbsBUFYrEDQzqZiGN9sWqTafgpd4x5nE+xGcUKccEBLvc9BlW4MlCqj
	 Lke5DMw4QJYCQ==
From: Sasha Levin <sashal@kernel.org>
To: Birk Skyum <birk.skyum@pm.me>,
	Andi Shyti <andi.shyti@kernel.org>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Daniel J Blueman <daniel@quora.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL"
Date: Wed, 14 Oct 2026 18:33:23 -0400
Message-ID: <20261014213019.rc-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014130805.48840-1-birk.skyum@pm.me>
References: <20261014130805.48840-1-birk.skyum@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 01:08:08PM +0000, Birk Skyum wrote:
> This reverts commit cb97bf3d4f91453b881acaf8e9f0cc47bb40b604.

Thanks for the report and the bisection. I've dropped the backport of
cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL")
from the pending 6.6, 6.1, 5.15 and 5.10 queues.

7.2.y and 6.18.y will pick up the mainline revert or fix once it lands in
Linus's tree.

-- 
Thanks,
Sasha
