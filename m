Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491793EDABA;
	Tue,  9 Jun 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046381; cv=none; b=aT5cL5vRNH0y6zwbV2XvZD0jpc15fYjj04WfAjcpLQ5Ybd6bvLJcWcdcSH3ReuvUERTQhsO3nczxEd+YqFEoXToQyHg++8euFcX2FK11OKHXyifLz/QWCtVHZSA5s+hg/VRAsSV08gHH19hLc7luJ+O3zT3nwrP78RnXBuIWkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046381; c=relaxed/simple;
	bh=4uZIHwZ1FummxHeb3vPJSqClgqSIXab7kKj02Zdv9iA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RS1oQrhRtGEHF+cRYBLCIsQ4/20r3kYlPVuN4q94/zscC20JnwRSdLUSrd/AJs/xQJZ2RipPCHoCqDmvJu3qLcGHL60oLOJcoj/03SEzZpzqgdpLLnRi7MGnukpF8EPfFfVQwoU+VlDK78oJ/EOX29Sr1PmqD+X+K8+xdjIOF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoogQM0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoogQM0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893E01F00893;
	Tue,  9 Jun 2026 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046380;
	bh=AtTkIPwhiUBqdh/egoEcrg9UpG8OOuSwuXDOFVx9VHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MoogQM0gxY2wwwz9o7v7ySh2THpZJiwwdzXXV5No3MFdJEpnIEgZ2NFr4yX+V5w3D
	 aZjmgKnHLnzqe+ptqjQ+HfmWZ5Y+D52cgYE4lg+k4vUTh+t5TfkSoKvrlaXI3AD4az
	 vReCPAq0brNwk00ppsFdeUutzbBLz5LWFtt98zIZhUiey3LxojWfgIh7vCTcBB84F2
	 463EAScA4wjm4oKtbzquumal4UGzF25bEMD/J0SmP4hTnAxL+s97bzm7ZXu/v6+Lb/
	 8MmhifTRH5hd/l/GcoKNceKxQvgYNjhCB9UqE2xwfPDnqZKLJLROJMCtsckC3LxQMz
	 l7Z1wWKgSqt3w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 liam.r.girdwood@intel.com, stable@vger.kernel.org
In-Reply-To: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
References: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC: SOF: ipc3/ipc4-control: harden kcontrol
 payload handling
Message-Id: <178102687840.34323.18334716238703776280.b4-ty@b4>
Date: Tue, 09 Jun 2026 18:41:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4uZIHwZ1FummxHeb3vPJSqClgqSIXab7kKj02Zdv9iA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKJxoPVtdGVWZxVP9/UUzdp4+ggn0T4s7w7jLT
 4x0nHI8FDWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiicaAAKCRAk1otyXVSH
 0MTtB/9fE9Q9UYOEbIQgvE20zuQnFqlSRpnCL+mCFzwcul3rZ43sSYgG7qIWdGPprifsHGYieZ0
 tBr8rIB4Yf3Xa8YfHD1nBUYuRi6hGIGoWDmVJfRNtFSDqGAWHu0Dzgyh6ki7IQfbM2OQ/1xaOFm
 /45hGLJqtIg/Fnzas0tPneHCIaw0g0OEC7Zkcey7qmv6bQfmRAdjpdZbKEPsynXxb/KxMHULlvs
 9iEEy7wTwSWwdYehvnlchXqmsPGNP+K4qlAIEZx4W8sp9vHbS+QSUpl3U4XDKZQBIfobY4rK8+U
 hOWb064N6hnkqwAsp93VM327GpK1JpZ5F1Ck97bkeVsDG6me
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 09 Jun 2026 11:34:52 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: ipc3/ipc4-control: harden kcontrol payload handling
> 
> Hi,
> 
> This series hardens SOF kcontrol data paths for both IPC3 and IPC4 by
> fixing size-handling bugs in put/get/update flows and tightening bounds
> checks around firmware/user-provided payload lengths.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/6] ASoC: SOF: ipc4-control: Fix TOCTOU in sof_ipc4_bytes_put
      https://git.kernel.org/broonie/sound/c/3ad673e7139c
[2/6] ASoC: SOF: ipc4-control: Validate notification payload size
      https://git.kernel.org/broonie/sound/c/5bdfeccb7fbf
[3/6] ASoC: SOF: ipc3-control: Use overflow checks in control_update size calc
      https://git.kernel.org/broonie/sound/c/8791977d7289
[4/6] ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control
      https://git.kernel.org/broonie/sound/c/390aa4c9339b
[5/6] ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
      https://git.kernel.org/broonie/sound/c/1f97760417b5
[6/6] ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get
      https://git.kernel.org/broonie/sound/c/fd46668d5389

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

