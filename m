Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AE2749DC;
	Thu,  4 Jun 2026 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579073; cv=none; b=rpGOSu6dKpGT3lHegbmT3KMHqcnNLRfzeBv6R4KWk3GvyZ+vTGLFdTlOYdajSSncZREZzMRa2dhd+36G4jEY0C8GU7qZFWmQwarGMAr/Hh3wPI8x90bIL7NzXnv2GaezOip+/Rfs7G1oCFDVhWTNt+G7mUwcZD0jXrSwN/3HBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579073; c=relaxed/simple;
	bh=OxNdjiclvt3XWr9lGJv8pywSMILXl1KuxQxrcQ/M3s4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rBG6ATyt9Cm6VnZNWISnwFiellPzfRrDbUHnlqDBfQ/EaJJG/adt4GbibJJN9laC5FEzNT83aL9xR+g61SeR+UM1Ei4Y/OVY7Wut8ZLHzrTkPo3WSPGcEwsF9f4aZ2HTKZWWjmlVM2NzdZfVXcNyio4TL45n0TjVMewGXhyt+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0WGt6dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0WGt6dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A41F00893;
	Thu,  4 Jun 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579071;
	bh=/5uXpRyUrLn5meNm86Lfod8o8MpRd+piC/cq/gzPePY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n0WGt6dt1Aqe35I11bb8enolwaDGwbGLDhIumRd3Lo0Z1MO2t/DbqRW5rOMh9nEbo
	 Hc6eUodQYJQ9ooe5XOpwKJJufujPBahJkw2grthcQ7KtHADU2pyPuXzyi7gNKmCk+O
	 CfFTDq+3n4rcfkDma77nRJpm/2fKj/9fmZcZegwaRw1vuJU3OGgZo6eVcvSVmx/x+8
	 7aytA9dEjUNr8EG9fn63hz+0tlK4vE0bRGREnB839IKOHGwh2WG/WKQ5RTn2GbqRoI
	 fX7jLNEE059aLHHEIHs0xWBnK/Zr4pa75eIjBTfy/oiGaUhQ9pH0B3ap7bpHfgK78i
	 vqAJHEDTgqnlA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 chancel.liu@oss.nxp.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
References: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Message-Id: <178056822812.53724.11372449372244956668.b4-ty@b4>
Date: Thu, 04 Jun 2026 11:17:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OxNdjiclvt3XWr9lGJv8pywSMILXl1KuxQxrcQ/M3s4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqIXr8KlHbpsbVkedXxSZs+2KCwbVlZw6puS5EM
 BwWP/BGFayJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiF6/AAKCRAk1otyXVSH
 0L9zB/4/n0blZE1Z6+elV9oWF+udM4vqfGkMnWJ6r7KgA0pJQPK/xU0RuvGhc1HYtvCCLOWA5MB
 AyyPQV9u21xbPrmhusis2cGWvbNNU82MbW0cTYzeKGKVUG1a7kc2/3uP676Jxf/F91WR4+W6LnA
 W//1xv7sGbhK8AUYGsi8ZKuDhnfxSBl0U/R/cyonOkX/16sUvPoiwMdX3SPa9tJStkeDuOQB1zh
 Q3SGed42moVgdD4NH5sRQbrtDB+7HqsQcz3NXnX9EMFEBNJQ8rXZWSl7d+F3++zVHMHGwg8HEn1
 1OaWzdR6UbDB5ukkqiDb4EpgKakSvtIWAlnYnZD6RLVxtgkP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 01 Jun 2026 17:33:27 +0900, chancel.liu@oss.nxp.com wrote:
> ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
      https://git.kernel.org/broonie/sound/c/4790af1cc2e8

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

