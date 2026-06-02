Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE53F0ABC;
	Wed,  3 Jun 2026 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470289; cv=none; b=P4DIAO2fCxpRWQgyYXxAaLV5R5dhVaHkXZgS0hBZ4TsMuN1PIiAp2bnUvzbDQXpD6TgIzM/fBSvp9cnKpBRwVpdtbi2rV9kw0jb2PKJWxWSC8Hz5K3rsrvsyYyz8f0a+TLPab7lQy3Wz9hmATKy+skSBQHu7C/1nK8NFrOInBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470289; c=relaxed/simple;
	bh=JXDHK1AFoV/Cp0lzh3E7j29/nW3z5+WpwgzOwTPLyKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bNsp13l5cVgxuygeK1fod1xk7cI+qkEWVq6KEFNFmKCJMenpiAHgRbsP2KirfjTjKxwKyTUpxm4O8xveZ+yqn84i5y+BvC6/nGdvtqqbf/8ptsIUZmEj3mYQ/PbgQm9WuSovaXUcFyo0NDmYyMsX4i/epUE9SNE8O+4/6teTB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os1CMoqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os1CMoqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA911F00893;
	Wed,  3 Jun 2026 07:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470288;
	bh=HuZ3SHNNN1Vp5xAZShrxNbWTVQQOQNa2kom6jaAnmeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Os1CMoqFAVp25r+y0UsHwP/rILviNs6D1TqqUk97aqhLXOnJNQ52iRpgp1WXoQUt+
	 o92XjnqgDhq6+rtAtC9O5qxK8itHZNX4IR5U6/Tv0tKMvBz7fw9OTGMnZ59y1cI1za
	 RZWenFbgKuNSpR7EgbL3oWJrSGoTFhLA0ro8mcv7lQrVvivXI6oPr7BB8/h46qW6TP
	 IjLobi7wngBMmKoOvFKmtc+EVR1SivAJEp1gvFoON7d43ahF0ciKs+xGC1yzSabCBV
	 Kzfn5CUEndwuswPHT5kkRV63+Fed7+t5/lXR8628fidzr1/DzEDmJx5xtsajmW+aEM
	 TUizz1IrC43ng==
From: Mark Brown <broonie@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Wentao Liang <vulab@iscas.ac.cn>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260527104850.872415-1-vulab@iscas.ac.cn>
References: <20260527104850.872415-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] regulator: scmi: fix of_node refcount leak in
 scmi_regulator_probe()
Message-Id: <178041278238.93058.12658086457449189653.b4-ty@b4>
Date: Tue, 02 Jun 2026 16:06:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JXDHK1AFoV/Cp0lzh3E7j29/nW3z5+WpwgzOwTPLyKs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqH9INn4KqB7mJVRdOy2hkfe089055/c2uSL1s0
 UdLkYiA/O6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah/SDQAKCRAk1otyXVSH
 0A47B/9qQm3n3K/t3R1jGMr56sD02MC/VGb2KtA4cjUvQCwJcv7Kf7N2SdNcS1lsCqkvOe+XlhH
 a5L311HyBKqp4uspIQ1IyoZC6t2xWG/+LBynoecUPD0vwQju7WC5cggjAG/Ur4pvh/h4Z4oQijZ
 GkmTN0hNFh90wriHcTR6QwSzdC2C3hm+MP+iPe29IgzAriasZJOXyHac9l0HVTEd1pTXHQpkQ3/
 dbV6SKbeycfNSGL5VFOCOgmjihihq8eQ6ldECGGmZglxQvhg4woaMi/EjbOYPQApIZUOmGTau7V
 OULNeCtuKB2YSqfUzOWH010b5oKhTEesKMIxrC0fDOYBoLPY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 27 May 2026 10:48:50 +0000, Wentao Liang wrote:
> regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.2

Thanks!

[1/1] regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()
      https://git.kernel.org/broonie/regulator/c/fa11039d6cdf

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

