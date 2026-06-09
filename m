Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89F3EF664;
	Tue,  9 Jun 2026 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046312; cv=none; b=X0guE0awU0/3M2icRXx5VykhwlNRvqTXN/e+x4Z1G2mN62wQfB48AvRO3XeP6ddi+75nyC1IisT5EpqIlEPVdYoRzv3sEPsJ1HXGHvnGxifimOq90U6d6JVqTSsaChioeirEXXC/EMqwvVcVu0vcL87yOJjRuuF2bTFuPXvjmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046312; c=relaxed/simple;
	bh=WBSEWc9Ub9ajTgf+r05KEz8QdxvxLsBmicHP1AmhPEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LvJ9OEiAJfNrDrauI6OmvKKkH+GRId+sZ/+w8EyieTcqpDmwCo1tR/eCuw1zB2WOGwtf6i6QtUAcwudaRX5jZR86V3+S/pqUVjvmdnPUzaCBikHFEPxlejvW6n5mWQMtcM1RuGcMF7vQzSXqH4AN0iJblmxsdPObbaIZLVJd9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exrzL2BL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exrzL2BL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F731F00893;
	Tue,  9 Jun 2026 23:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046310;
	bh=0A6mqkysPmaX8VnA4nZH5iJqCKSPfw6NYqzHjo2z4l8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=exrzL2BLzNrEhXFOGd3+3fZKc8CTLay4372REMPSGK0XpwcJ6j824jbmCKChMuSp3
	 3q3K33Ey1D1+dP8mFBOzjA9W3aViAOYcxOpPPrfNUiKDuR9IlaSFnqkIaYNnxjyEBk
	 zwPS7vqz2v8I+5z+zSxKbqap8wFN/dq9k1kY2KVgHw4pA4jNqhhx8XeAgjrt3EyoGF
	 PKtsIGNaJnFJmiqQ3IrTOuwGf4wf73Bb1dEaQIv9fr7ySHLvybkayLBmk9PHooepDe
	 VjDe9j9d0OVa5hKGkAG1eHjmf5Rf2hKsh7wMhz5xC8IARORlvcMSg4HBSbTJpv20Ca
	 WqNPBNEm8yNPg==
From: Mark Brown <broonie@kernel.org>
To: Jonathan Marek <jonathan@marek.ca>, 
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260609-fix-spi-fragmentation-bit-logic-v2-1-e18efc255563@oss.qualcomm.com>
References: <20260609-fix-spi-fragmentation-bit-logic-v2-1-e18efc255563@oss.qualcomm.com>
Subject: Re: [PATCH v2] spi: qcom-geni: Fix cs_change handling on the last
 transfer
Message-Id: <178104125260.34323.1551253876744290838.b4-ty@b4>
Date: Tue, 09 Jun 2026 22:40:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WBSEWc9Ub9ajTgf+r05KEz8QdxvxLsBmicHP1AmhPEY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKJwjvMAfUU3inP2j43gKV+hOuWYknfX6TOIcU
 toXBbdspG+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiicIwAKCRAk1otyXVSH
 0IIaB/0ad8ndK3FL8LouctO4mx5Pb7fLl0cs5ONe2t8kwVCtwM34ap7J6OqZ/AwJ5+q7WobZR7y
 5bYPMfdTKAnI4qfIcUz7/PaBPY5nl6QpsSYW0oBt59W8Yp254ALkJqniizOL+3p0nY2uITaTObC
 lAcvGmpZ2eUfqIHXZL2H+dOO2/fglV8TQtObvs+pWEsA//36Cd82RDZUQEOG+taoEkUUQbfvh3O
 bW9m1cGTgGldnH/8+zZssi1DJvLLQjhjrayu3YBz7q13rrV6+kQLSBVGm+XmMDI4SatCFxgsfDX
 KgqPdl+PVFZBfqSprENVl4onfu51cLzz2P8sbAF8wPCV8BWZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 09 Jun 2026 14:13:09 +0530, Viken Dadhaniya wrote:
> spi: qcom-geni: Fix cs_change handling on the last transfer

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: qcom-geni: Fix cs_change handling on the last transfer
      https://git.kernel.org/broonie/spi/c/5ac5ec84734f

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

