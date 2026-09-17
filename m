Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780425B090;
	Fri, 18 Sep 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723911; cv=none; b=FRzDLS5O919vgQMfnxQJotRBJmpnzS7FUPgIHAysTdruys8g3drB/Q2Hnl4arZPn+khpXCmm8w22Pb2RSQxSeyWM9OLjIAGSySXt+7K9VFqHYy1rs5CuMRutsJIfRWg0MC7w9GyCyT5zOnMMmAu5SZwsgj1IJbymr9RNpFMlKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723911; c=relaxed/simple;
	bh=PIFZ7+2BrddEIwhUiMwHBAQz8mIGh5IsBxHAndWEBDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YaRHvr2aQ8QXQzAMImHXreQsOEZ82PRrxcn8ZKTBhU9SZ0zYX716b6jU2eSgcf+NpbGhMPqrooMM3joe7EN9T1oJbKMGmsTD306NX2d53Lm2RwTVO+cb8hVZfXVd/7k0NijVksblCivRWSZdp2kcP13ZJ9MYLOj85ZAA/ToUxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOUWT7xN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOUWT7xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2691F000FF;
	Fri, 18 Sep 2026 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723910;
	bh=kgEdmmO3+FEkPk8QUS5qayHDPrjZUEa4ovao0BEowLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JOUWT7xNRGITV0nwyyEbwObErvER/uggawLu0A10/bdO6Qaz/232R5QU1gyc1TtGW
	 PuBMkwGJCQTPAl7T3eGIWo3spG7l9jfjdBZAYI/869SqX3GnE4ZKUcsSZy1pmeV5IG
	 vursiyryJSpJDqg9pqFFQQr9JHN9lIIheXgmvi6hHxG4K/JfjCUYcVQ9uwu0XpOBp1
	 VMizaYv/FXZH59DfdnypuARUzXi1FwOl9dOfvfLoNnrnFq7nhEGokwlzt1J28V1zkR
	 pa/rJfAjwfnMEO4BCkj7jKyyD4AYkAQcltJlDNLTA29LfDbym12MUqQi2jtmH2JNN4
	 X1/vi/WWTOwMw==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: digetx@gmail.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260917142535.2156720-1-vulab@iscas.ac.cn>
References: <20260917142535.2156720-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: core: Fix c_rdev reference leak in
 regulator_resolve_coupling()
Message-Id: <178967518636.285745.1939777277384704372.b4-ty@b4>
Date: Thu, 17 Sep 2026 20:59:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PIFZ7+2BrddEIwhUiMwHBAQz8mIGh5IsBxHAndWEBDo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQUCcvt6RQOBhlKZw+Rcaz51TuSspHrXfj6At
 qiu0nfL3YqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0FAgAKCRAk1otyXVSH
 0L66B/oCOCvsx/ybU6ZBFvKAqf+1Xr6R0m6kWnUJwdJvs+dmPbgQwyqHqUcSkSr1N1sADyLZQoe
 toACTWxcX9CduEZlu70txMPO3d/u1V0iF/pEcHrYxKTkGy36DNnJMQgz4aIqzMYRN8l+aurrdS7
 o5Q2Cn7KEDsUW/2HSs0U4oj+hHbVUa6uOyFUTkS640M4edFG6MovCnD6ZWp/qOCGcDhQHjatK0a
 wLZ2Y/eG2bW9DD3y90A2dmgxIApfWdMBKvh6G/sToUVYr6+suhUReLUMjgy8N4p7I+Q08rpoToP
 pY0/s/wmp3poh9KcOUQWBvuzMcc7DcEonQuvooPFyE7oR0mr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:25:35 +0000, Wentao Liang wrote:
> regulator: core: Fix c_rdev reference leak in regulator_resolve_coupling()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.4

Thanks!

[1/1] regulator: core: Fix c_rdev reference leak in regulator_resolve_coupling()
      https://git.kernel.org/broonie/regulator/c/c41b69e9f76f

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

