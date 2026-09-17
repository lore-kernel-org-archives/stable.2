Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9193B0584;
	Fri, 18 Sep 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723915; cv=none; b=VGq7tqwcpZxFBtg2DEPaDocWW/FnyHn2OfSDjjTKR/YXRhKRPPhN4ghjJGGirtAcuZXSbGT1KIM0BJlsloemwBh0CHO6Vwaxl8G1RZpIbQeggGZfgt0YGRbVCpVTrOCEyf1EFhSd5JyOGNiK2+w6qncJ+gd9w6JMXhzdchm87AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723915; c=relaxed/simple;
	bh=cIxthHi+6oc7V8RywyJ6TtfoXmYZ+Ji6gkukqNhNp/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G5b0vO33OIWHtGZzIpafkkODhDNjZWW2CfZ68XcSMEOsqP7XD2itHJOVr/1PM24AX0PnlMmAr23SsRy170p8JLxUJL531b3suBkCZqNcGckuqHkX4iB3aU8+YBdJ1iMpFTIFwi0DJNv/FxApqyvPAat/EV6bb6O0x+at1pCVSKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr43/o5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr43/o5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3491F000FF;
	Fri, 18 Sep 2026 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723914;
	bh=M1twlS3IsDwZiHdAJxhPHJGcD3GPwnSZQuW85tFYhrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Wr43/o5jtuT01AVSZcCWxPrY+InDcORuM/MHU7wYcIToc4z3wugsFZoYf7jyrDare
	 OiI3aQVoPbWdIPshOdtv6ofrrK4aTIuhnumHDsQ36COEsXKWUKQuuDtj2PlfVXERl8
	 UKObTWylPLel2OuHHjIr3h8s7YLrgxwvXCpdcK+WH900QyuwETgTE0fNaehOiUglof
	 aLvR8mUH90swwHVgONMA8iuEkg/rn+LH8Jf92EfGJKOYvm+sk09sa1EmB+3D9xWwzo
	 LTaWhb6vhtdYqmpdIRUmqbqoJxeMp313jg4cslV8uhdujMW4gdL2Z/dRosiNjzUG54
	 20hOeABc1uDyw==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 mirq-linux@rere.qmqm.pl, stable@vger.kernel.org
In-Reply-To: <20260917142810.2156816-1-vulab@iscas.ac.cn>
References: <20260917142810.2156816-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: core: Fix rdev reference leak in
 regulator_resolve_supply()
Message-Id: <178967672751.285745.5497160013224648977.b4-ty@b4>
Date: Thu, 17 Sep 2026 21:25:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cIxthHi+6oc7V8RywyJ6TtfoXmYZ+Ji6gkukqNhNp/k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQUGQt49Jqo/xQ52ESfrWtVzTUkbEwa+RB1QM
 Wx0mo+j6UqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0FBgAKCRAk1otyXVSH
 0Ea5B/463SZTBwxx00aWV4nFtkge41eBirT/qpXx6Uc8PBWdKRuviJxsaMIShCRb04j57jwLL0G
 E6Ie858MzGBAaCi2OLds6zny1Kv4gG8si/59ZI3u134iQ5SsY2QOZOJ8fef/xqvnz6K2rUCSpSG
 tlgEN+wHaky1MqY7AVMj5uQ5t9Mhm1h0R1sReudarA9ncBW//1bI/6CtDxBhzDKih6ARlQdlCW2
 LpNZf4HdPbyh3xSQtlcmzxYOaXCZ7gS4ItIEZru2lwVpKQjxHO5L05TGJ/Z38H2jSMfiXWET0AL
 sZie8CZqZcSgL3z3bMEnS5IKwmqHIBM8BzvckrFFW5KGsKc/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:28:10 +0000, Wentao Liang wrote:
> regulator: core: Fix rdev reference leak in regulator_resolve_supply()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.4

Thanks!

[1/1] regulator: core: Fix rdev reference leak in regulator_resolve_supply()
      https://git.kernel.org/broonie/regulator/c/195bbe5e1c29

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

