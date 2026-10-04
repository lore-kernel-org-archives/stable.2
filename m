Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E24A0F06;
	Mon,  5 Oct 2026 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209784; cv=none; b=TviQ4yvyJJ6ulquc24OMWuMBtAZv4FNyb52PwEJVLfyLT9bh67USMHlkq2U7sNN7eGYLoHQ/rg1+/Y5uJVWyykEQkccoTUxB9375ka+ck2EUyLISY7stA6JgCkjgMPsDaA5fXcnM1hLNx1zAeSHL3u/a6CpJ9x3l/MgvlDlqIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209784; c=relaxed/simple;
	bh=wK0A0cpLoG3IU3lnSYBzHWB3+DFPzCo2M39LNQgCXTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bb26zWECw6Qf6ccOsEBqaJys02BvdLsBPSFpjUW24Nn5rW7yqdWI344ROplYxOQYAq4eGLrNaYx0tWuHBLa9Y/4VW54kqWSQkXgoMbHKtsl0UW20gBYAoWL/OQPDkyiXJk4qKIBuTeBM7PTi+NGO+1/DS5nxEN+UtIvmX7mOxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML6WOWbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML6WOWbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9321F000FF;
	Mon,  5 Oct 2026 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209775;
	bh=Orxl5FHyGCiXhqHy4B1KJ3UbH0y2AdI/WwZXcl51m1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ML6WOWbMGz/g1SgyDpJFjO+/6V07sm4uGfIH7ZLyNBFEp/y1pYWcJdK7zu+6EL7uP
	 zTHvjPPm4OFJI7BeYgvEH25AROcetvieeqmIQvfem9lt0POKinHGISorSixixIuqwc
	 Tn49oPxoLGmPEysWDmtlle9w9aIcBTuOLFFSfeYv+dEqdR0nr5YkQkkzLs5tjgsWuO
	 J4OVubZMIY2D67nSrS+pYFvQ0AvWDGP6uwWRcpzxjlj45igTwPdXEmgExwLFTLZqjQ
	 D1FyYDj87OaHXN1tMcdA9BAE29J+/pJlliVMtMutwX2XHKP56474Acl7oQm5pLXOTa
	 EywluThTSU7tA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Fan Wu <fanwu01@zju.edu.cn>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vijendar.Mukunda@amd.com, 
 Syed.SabaKareem@amd.com, stable@vger.kernel.org, songl@zju.edu.cn
In-Reply-To: <20260929061349.3879-1-fanwu01@zju.edu.cn>
References: <20260929061349.3879-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH v2] ASoC: amd: ps: fix snd_acp63_remove() teardown
 ordering
Message-Id: <179114604475.150114.3693851033489195230.b4-ty@b4>
Date: Sun, 04 Oct 2026 22:34:04 +0200
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
 h=from:subject:message-id; bh=wK0A0cpLoG3IU3lnSYBzHWB3+DFPzCo2M39LNQgCXTI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw7EpUGK0ktjHpDtsCihtgiTi+wKpbeLBrSM93
 GOEOANBOZGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOxKQAKCRAk1otyXVSH
 0FI6B/wJBTNJz3VNjPypiTv/eID1us4GrijLEjeSI8KMKxVgGcKWpGpYE/hHQ1haQwR2wYW4dxR
 IwmADfUPefqCdlHJbHv2AQoHnea6FmDRt1gr0JYEa87GTlvb9dfOzy+MObTFokarR3o8NeaDupb
 M4tFEChmgX/B+uKyID/D0fBkjqrMWZr/xPiuMPXkQk+OXSDTM5uGWOd8t2XYXjnwUj7dQKYR/Us
 EYb97mQlyA+N/24HHyW09hZAC+3804bhJGaBzA0gy5M/vYYoqxE4QvjFNLd4RZhWRh/QR7ymPka
 hA30ztj9mBDlcOFbh//lISQ2WtTgeWGVSeQMJYNSrHaQnVaz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 29 Sep 2026 06:13:49 +0000, Fan Wu wrote:
> ASoC: amd: ps: fix snd_acp63_remove() teardown ordering

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
      https://git.kernel.org/broonie/sound/c/c53791d673ed

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

