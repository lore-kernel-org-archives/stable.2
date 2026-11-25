Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697335;
	b=t0iOSOnaluId2udFTxVUqi/JJamtGiZWZeVafymbhARhfiTDckzZAPJ4WgdPBiDt5A+7
	 WfNg1Vwdhj1a1DfkfOov4RTVSUpIp4wNYqsqHtU/sJHrLnHjN7IeG/xIOnEIHH+NzriPi
	 Yjvmp7qkP03g0TAJ2xJJDWLuDy4JdSu//6cyp/HqU3QYdcoAvBtOCThJ8YhF10neEDQKs
	 0kYEsSDiN61jW+G+IAyBOytVFdjLF2BS5mhDLfiy2Mr8kNhk7V32YMcKB52D87uPfHK/K
	 51ZHdDTD7IbeVreLDu4kjIn/GNGr+ZFFOvWRjuXJNek7ZL4bF6tHbib+Xv9eDDE2KeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697335;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=c65ZXA+WD4acqy3H/mw/ujfvEs+dg5xu8/jhbbs8vd4=;
	b=uSSrvQI4X74TDLPBTISrXDfHIEDmULFSE+7z9idmp7pW8U+0P2u5O+Lrkmp/IYqbOjz+
	 c2fceYzBx5rof2PDXlL8JNjCXa7E1ji9Ig/6tDdu2ruHcjcO58QYnZEGnJ//+46E3qoXF
	 LpZJjwwVacOkO9+0fNO+MOaOV0bJepBLVO5j6A68WpCP/vQLtPTHQJOM6c+1CkqVWZC0x
	 PJsiJ9FJI428yGNtBqG3oXIAe5pwLA5GAORgHVb82w0JEpQIu5TVm9TBMWIz9l30HIcWd
	 pYSb07Wnh4Va25hsp1lKpuWMKRCJJF2C2NKgiGqTgRbW1OkDgp8pNaMjr/QCh6dz7sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UpQJ/fMF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86126606A327;
	Thu, 26 Nov 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpQJ/fMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB21F000D4;
	Thu, 26 Nov 2026 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697334;
	bh=c65ZXA+WD4acqy3H/mw/ujfvEs+dg5xu8/jhbbs8vd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UpQJ/fMFpNSyFO98filCx2eRXrpJ2NZHss3Le2oXfPzKH3qUn7x/nnWTdyBjDdZB3
	 g76AG53lfp3GYAq5jcq/vj3IthkOmMjK2gHNFaslLF+VjUHwHa76usYYVeqFhXbh+F
	 7d+i+omrkAhioGn2GxLeiNUwEoiRKkQjvRwJZc0wvrs6PyAKxOHdigMQjOSfLhD6YH
	 8mIVZdZMh5Zy0swfznhAjt5SgLow9lX9RJQ3cPg2JQ5xRbvHJ29A8AKK6iADRcU+EE
	 2BM9s4leRMUGTk/NRoWShfh0a6o5OqAQJWuWcGVnf+hiduBUu7uI7B7N9qlufrwuYl
	 eaE8zsHKoh/vw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Chen Yuxi <chenyuxi19@huawei.com>
Cc: peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com, 
 pierre-louis.bossart@linux.dev, Vijendar.Mukunda@amd.com, 
 ranjani.sridharan@linux.intel.com, perex@perex.cz, tiwai@suse.com, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yeweihua4@huawei.com
In-Reply-To: <20261119082506.2485543-1-chenyuxi19@huawei.com>
References: <20261119082506.2485543-1-chenyuxi19@huawei.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: Fix NULL deref in hw_params and
 hw_free
Message-Id: <179562983890.358726.2657120156068501057.b4-ty@b4>
Date: Wed, 25 Nov 2026 18:03:58 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sYArD0D0S+9HGrIYuzuumthglu+sEmIuB4K6TbgArpQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5tDZNOBs6f4edhUX/GqtzE1O/2tztuGFTdrc0w7XI5
 POX49OOd5SyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAilTMZ/nDluLA88PlWbf0x
 pvt8bMFdwY47D/K+hG1Tqo25PjG6/gkjw9aKrt/6+yPM3m7RMK3NjpogvXXTPDner6F3tSQ69iw
 z4AMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Nov 2026 08:25:06 +0000, Chen Yuxi wrote:
> ASoC: SOF: Intel: hda: Fix NULL deref in hw_params and hw_free

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: SOF: Intel: hda: Fix NULL deref in hw_params and hw_free
      https://git.kernel.org/broonie/sound/c/4c30a6661e53

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

