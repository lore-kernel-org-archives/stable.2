Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82263CE083;
	Fri,  3 Jul 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079843; cv=none; b=pZJCKzOLsDqc9du6ePCSmFmTeW9wYI6a6T4gV1+ovqEmDUyEU5DpFiPKCjDJlfgCmnztISILxmjvsc5ki0AKr/923uXC7LIuBOl9dqlN2GQT0FzPYmGC8ILxzabMuD2xKQzBsPjljl8b09wrs5/TPlihL9JftyK9OaiiHHc1TK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079843; c=relaxed/simple;
	bh=F+W61zXwimrgpt1ggBsjN8++vVQ+3o9n7/WG+f9NJQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=brQsxYnUTPnrLkqLnY/ehTNcMuBfkDhgpHvu1g4vryvOb8vwMqHuHmrpkTNYT0+efChindv/xpA9g2z7Rb8t5Hb+nWrabD6CifUM9EXsCacMK4wUrXkhybYZYabfkcKeeW5Y1rvMcUSACggLPdQYMr8ySFGwkD3OI5mKMxvBzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSQ+5A0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSQ+5A0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DBD1F000E9;
	Fri,  3 Jul 2026 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079842;
	bh=OfZW02S7ngO+zI+imZuNcxJRB9BLEi7GDFBYgWvp/q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fSQ+5A0LIB3esWOraovQL9y5LFd3ybKFSFejXmmSNByUQVOcXPaJRzM9qKxXmyCN2
	 cx54OarEWrSjbP3Tx8MX1mG8bhHJfXJooB9G4CQMLx6EqeVVjvYjf5Y6Gp6fcrkc/v
	 qi1KBEEHkGG/789LnnvR1cm3TYAqJzB3Wm2mFzuHbFWDPJ+25jtr4JadgJ3mC3OV/J
	 CUaav6Nlsv4KiXOVAU1oNue4oDm8rmzapDsMd08BjWYKdv5FPs0BaonoxpRCkVpN6T
	 aNBnrUblyqm3KZHCi9iyyaHrn+u0FQZEr1hKiRzB+btxs0Je1zpx1XXZqE9Ab1JUDM
	 SGgRz59WkpWbg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 WenTao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org
In-Reply-To: <20260626160326.54457-1-vulab@iscas.ac.cn>
References: <20260626160326.54457-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: regulator: max8998_pmic_dt_parse_pdata:
 of_node_put on reg_np after ownership transferred to rdata
Message-Id: <178301457345.83990.6164984695166238490.b4-ty@b4>
Date: Thu, 02 Jul 2026 18:49:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=broonie@kernel.org;
 h=from:subject:message-id; bh=F+W61zXwimrgpt1ggBsjN8++vVQ+3o9n7/WG+f9NJQs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqR6Ogmo4VtfqBVtOemlXaDEddXE308Y3f9H40C
 uWdxq3WuO+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakejoAAKCRAk1otyXVSH
 0M92B/9LrWF5Pst7Fi2zF8a887LUDps7ZVPoNTw5XpvLS+jOANq7pAVw0NbdgvQVusraps+ZvM2
 DgYLs9TzxjvGzHRpoUl5K2MVXh/LdE8U2eUOJOk0EjAR1rDZEE57T1SuuHaCRWuC1DrHEpz0f9J
 ASLnM3sq7nziDa/ALFu3swGfLweff+MGHEoh5AxCX1Aq3nxaboGLUfH9wCqRTsm3qA58oa1EgW5
 ii2ehZHl4Ba7N17XFneeYM5QxYfrKsnvFx2T6bVnDSHz8+1pk3bJc+4Rcf8/7445zWqdmsAMaaa
 om5W3jqN9058R9j6xfxdhCjYs/agblODIup0ezO+mxtLrcgX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 27 Jun 2026 00:03:26 +0800, WenTao Liang wrote:
> fix: regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after ownership transferred to rdata

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.3

Thanks!

[1/1] fix: regulator: max8998_pmic_dt_parse_pdata: of_node_put on reg_np after ownership transferred to rdata
      https://git.kernel.org/broonie/regulator/c/7c8cc25d8d86

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

