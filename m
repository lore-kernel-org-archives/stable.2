Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6C5208D4;
	Fri, 18 Sep 2026 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765460; cv=none; b=qP4k+YxQyU5uieTWWlrm1Y919EyhMpSwFF91NPWh6XD49UrJraqGTHFCaFUH6IGdtk/TxhkzsEFgCHF6QBCDt+NM5Ir8yH5lFNna4HnbVGOfG7a/5cQ282gkWVU0IqwmAQXY5wuxgt2lFQeQrmw+5wBovuuRjnLYRuYGtaQ3hPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765460; c=relaxed/simple;
	bh=5Tv+5ydQQFqLdrVk2uk0tWxja3TkWw5K3nhdJJXTqAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JQaXzX+FN47ihwJQR/e/UG1y/1r5NiQI/DLJlSo7CfAajKf9DDvXYfM36kNswfvx9+KngbgqUlERojqOiw3d+aOPURcLuZIq639QyJ90dFLXCcFCZ1n/RJ9h/8HCbEnsFmgSPSjWPdJvEE4/iVvcCZBBE9rVk6fPWA0inIFv+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdpzKOU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdpzKOU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1611F000FF;
	Fri, 18 Sep 2026 21:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765459;
	bh=LjQcXT5f88Y3XpPJaq6rCkODbnt9OXptHxwwp7xXXFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OdpzKOU95SOEFC5t2XUg7LxHAaT8s3C9bLX3NhAodrtJ/8CB/yIE3cY+r1SrxIugk
	 B3vxBRvT2IvayW0i1oQZOAWprzZxjvUfGtEnwSlUrrf02MHWh+W9zLkhuEyf8gvEEh
	 hu50NM99Fi28PAeaXlXX8j69npO9MpP01Q47UrXm8fUcuwnwO28sEdqHMGalB7ctms
	 ilD+8kBVe9usn0EKCIuOQyknvjR8wZC/t0mYuQrLDyJODPR3sjuGATaop43VDCkxxB
	 Z4CaBIqSICCS/ElyQf5M4GPZ3yIPjMaHx1t8LmB93zcot3E6yyKS9rYtPuZmvsRisx
	 G8N3PhWwKs2TQ==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: cy_huang@richtek.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260916072541.1968033-1-vulab@iscas.ac.cn>
References: <20260916072541.1968033-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: rt6190: Fix runtime PM imbalance in
 rt6190_out_enable()
Message-Id: <178975401549.1812520.191422533106341496.b4-ty@b4>
Date: Fri, 18 Sep 2026 18:53:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5Tv+5ydQQFqLdrVk2uk0tWxja3TkWw5K3nhdJJXTqAY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqradOWEz/cJkO7Av7zlckcxwAfIDwK5SXI523T
 tiZlhdKKRqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2nTgAKCRAk1otyXVSH
 0NnyCACGscxv3MinUjXO4+lMYMaVAhNqmoWcEkDDTvEwKOq4yB0AL2O/qPko83Vij2gJhJdjTY7
 kSQReMqUTzDV7q3UtyTlJW4NCl/eLfhFnyROFsra0DWsBQyWVnmytGAjMieXGep6dzkQ8SMn47N
 s+qmNlvV/h29rq8fhzhBR8ugIOEKQWIeFabxW9glsLJvAFr2FCtwdBS5RFGfbM0VfjCgqwpzK2M
 +6bcTG2xSolXSgIWGsvGsygYFr/vZ02yXeyrzjIr/Rc0wdatNiwvKvenXM0tAly/mLT39E9dXGX
 2+nMAo8N3MtIkGoLan/oYjn+B5kWjkTuBCWAaeKTyXrbb5SO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 16 Sep 2026 07:25:41 +0000, Wentao Liang wrote:
> regulator: rt6190: Fix runtime PM imbalance in rt6190_out_enable()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.4

Thanks!

[1/1] regulator: rt6190: Fix runtime PM imbalance in rt6190_out_enable()
      https://git.kernel.org/broonie/regulator/c/e0d673e5a5c4

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

