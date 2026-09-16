Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2201361966;
	Thu, 17 Sep 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640353; cv=none; b=bw3XolZFJM9n1GuOspYz8x9xsFf0aVwMf0RNUrhsbCMNmFh7W3VE/kyRGEIW7cU9GvjOUyjcnSPUpuoriQCNxT7uNwUqItgEZTsmSzqHXYWcKdbtKa4qEERV+7vupl7JWOJC9Uw5SHY23w/G74ZzILCsk3Dnm6DmpV0YWIRAtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640353; c=relaxed/simple;
	bh=sYOBPCQZCZz6ppPtm4bDuvKorzgrYBsny7NWNCPiBkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a3VkAKl4MAII7gWp2nRUJpSjnYMN2abt3/Pz+5/NHq40dGeN0VHs3ei9UnYcx+oZsn2J6Udl8PceYCJDPDv4OmNLMcoDqT6aUhX/79MUH9GtG4EzBWXRHpi0PiTkL3CK7GW50/r/C6Aiyw1Nh4DI+9Fnj6icKcHGb2qTizDe4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjTpgD3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjTpgD3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152A51F000FF;
	Thu, 17 Sep 2026 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789640352;
	bh=uDXtF86VK1gu27NEV85R0MtRyEx8CrnTliqhkEYUPmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OjTpgD3TK3YALyveSRIcZAuTFmzjC4x4yu0+yJKGV1QTvERP2/ksnYAQhcHB7xhI1
	 bM6pgBptqq+635wj35ZiQY2a+d/d9Jhrab884NXyPYVAQQwJ/BzB+RJgvwFr41fxtR
	 kAg5LNXdtcHodwUVKbFWcxoLOvVoeyi5JHbOynw4pr8kEl+c1jeVmUHSC1XKv2vFjg
	 1j0CbZCcZADxy5HnOnvtprq6gDqguuW5aSAFnojR/wDVtF5GQh/Fpv1UEmNU6j3SWF
	 vXUc+kSkOfBXLOcUMQTGMMw5VJAhtStindIACkMj16wjBioGcb4qtsKyrR22KlVCwO
	 nFeRPG9YXCGKQ==
From: Mark Brown <broonie@kernel.org>
To: Itai Handler <itai.handler@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, michal.simek@amd.com, stable@vger.kernel.org
In-Reply-To: <20260910174832.873352-1-itai.handler@gmail.com>
References: <20260910174832.873352-1-itai.handler@gmail.com>
Subject: Re: [PATCH v2] spi: spi-zynqmp-gqspi: stop the controller on
 shutdown
Message-Id: <178957983642.100121.2784046911009039548.b4-ty@b4>
Date: Wed, 16 Sep 2026 18:30:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sYOBPCQZCZz6ppPtm4bDuvKorzgrYBsny7NWNCPiBkw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq76c3YimaI4GlY4gTxTHdyj0qP0RsZYlS2kuA
 K2/+wEMG6qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqu+nAAKCRAk1otyXVSH
 0MtAB/9xDXzGPp+XGSGH3Re/gsQvAACubZO5NHSS8ey5YdEa1OW4Pj5RU7pN+fbOUW/Zqq+lQa1
 JwDAf27dyCeANWu6+QIkjQgCUHEThXGYHlC/724BN26tgLaY1oXv1dIM54F9A1fuCaDXEmhUNkG
 6gaNT6Xp0MmWWLGzySuav6+pthg6SSsjCAAiMa3gVlWP0+1V9DI6Ru/q9Gy1zmC9YwOPWmTfngf
 w9bZsbdxbGGxqYv5whRTHuIS8TNgb2jJC5sAjuIL/fLFlaPg6SjIzfQffpBw3/DOZxN1iMTAOn8
 tEoZFW+BMe2fwlsG9zj9vhI2hm/Gs93yMfvwDXraNascwWHh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 10 Sep 2026 20:48:32 +0300, Itai Handler wrote:
> spi: spi-zynqmp-gqspi: stop the controller on shutdown

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: spi-zynqmp-gqspi: stop the controller on shutdown
      https://git.kernel.org/broonie/spi/c/e922bad8b2d5

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

