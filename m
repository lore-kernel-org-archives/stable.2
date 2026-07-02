Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA73CE0B8;
	Fri,  3 Jul 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079839; cv=none; b=smc4mq2VTFPq+r8wqS+FDXlqRg4uVnTprPMIzhg2Hnka8wzhhVgzK15suhlRXNVJ3iKH2ntHPAsgHk/XApj4Qm7q25M6VroGj4jAvV2xsrzv3audxm/8kj+L42n88luKYz3ePK+3dC9tmkpjxG4McdUDMiT1xtRtZF+GkZfrWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079839; c=relaxed/simple;
	bh=ovPM9xZDUdWaupBWQHoOBb40dBYxxOM7oXiMWWVZVww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2cWGTTD8q5KRYJFDpN4irJSaiSi74v5FPZb2lE0AaYI+laDPM2jurT7tJ7m/fnnzztHXHDZ4l9/IG8frucc9wRWbLRqChpZVkzLLPCq+LEzfTBfs7RNoT7Fm04CFwToBoiwzdTFolnDz1MFuVbjRFuGfdRrkCvX3ItmtqyqwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZd1as71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZd1as71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900A71F000E9;
	Fri,  3 Jul 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079838;
	bh=r+aPFwarUHkhrm1jZbamCEDXoqqXazDsHMO77Y6Hkqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HZd1as7135L9ie4torTNvRcIlxRlY7pUneeGYreenG2FnfncoKpAcfQAeaAx+6LDM
	 lbsepL4pfw1VHKVIDFHn98YoJHvSz8dRNPDvo5LU72wN56KT3+9Vrldp/1becRRLfC
	 Zgx0bYlrf91tZpAzQtcMcpt7xmWMdlnLlcZqqoz9D8cU0DjxFAN/Ea/nRzQ35/vVnf
	 aNFcXK0Rvv0CNx3CRBkb43O/gwDVLl5NC+cSHIP9wRExXRVkONX8TJKfaA2ibKnT1T
	 1BJV4aw9eq4PHV0X6uepkhks9fuYqyFPh/39ljFX4ZW9LT305EoEbbuBYxjLDAoaab
	 czldWgnZpqsQQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 WenTao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org
In-Reply-To: <20260626160150.54291-1-vulab@iscas.ac.cn>
References: <20260626160150.54291-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: regulator: as3722_get_regulator_dt_data: fix
 premature of_node_put leaving dangling of_node pointer
Message-Id: <178300935014.83990.3579120327882545763.b4-ty@b4>
Date: Thu, 02 Jul 2026 17:22:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ovPM9xZDUdWaupBWQHoOBb40dBYxxOM7oXiMWWVZVww=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqR6OcGOFaX2ASGZmlFq9sO7OsrWH20ngi4Dc0Q
 /Jer56A8pKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakejnAAKCRAk1otyXVSH
 0A++B/wMcGmxlpL3woIzmXlhwmG6i1EzlHzMEU8ab+o4rc7Ies2QFWZPYOjokOQTdFKe6dWULUu
 WlP38v7m2ls2xA1USyBN/7IuRHZF1+wiv8EEkK0sMeaz1B68V21a7XWJGx38/Rb4UbQw1WbXQoc
 yQYU6EnjURoV3vSa/3nI+o7HBm2wulhy10SpnkREIg9LzyIxXMqjOfPmLhYiA2KkZv5AJganh7U
 NcY9eNJ7xW3afNOIsg5lcY43F+CxTA8LCOgAuwSopYyGFbAjjgfMtOTCC2E5J7OKgTudG7isXgg
 UO0FFQR7Ezi/p9RILVDwUg0CtyqORQhdfNJwFJ0/2DW4MRYK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 27 Jun 2026 00:01:50 +0800, WenTao Liang wrote:
> fix: regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.3

Thanks!

[1/1] fix: regulator: as3722_get_regulator_dt_data: fix premature of_node_put leaving dangling of_node pointer
      https://git.kernel.org/broonie/regulator/c/f9324d670ae0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

