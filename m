Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047455;
	b=O3pWW65KqdIM5ZXP+pr1vb7rfQ92QPg/3yuY9w5BK4sdBHA/6NFmDXQlvIBLlqC/6WuJ
	 E4vuSWZMQlNlLAZotVS/RzPT2dXnBZx39jOJ3S4g6otklPnvK11Kf0UHg5oe1izs1tBcX
	 nMwEbJ+b/i/q1B8qHLSPMyhJXncxL/vuEitbiXzk4ktaTvOX6SCPFBjX8TrHlNIwLtc/Y
	 b3K0hreS1RIu1NnfbT2XC/IbLP2yMmNSSBOfseM5ppt9t74IpCeudUg9DUoABpamj4p54
	 u+c2QEA39w5J81VrFgPSJ3AhWsRMbbNt7tPbfurJE9wEsiFRG3Hfg7qAsUShj9Ft6SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047455;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/kBWIySqVK+PWmxdvx34TJ2UPR1qXh1MS37/nhOACws=;
	b=s7aa4AF/43kSOTudtYbksgJBp8mUlJ+i6IVTG5uLpEbWrMNzXf1D5Un6HZyqrNJ+PhGB
	 jp/AAujOMtmK7icnxCftLdvQr96BEd2V0XFfwuQiNxLsI4xMnIQGsxf6nJsF8aN4cTln2
	 lkaDv6z7igAwzpgWoNCd/MGGE8q0Rs9kn9IEDJLzbeUWV0KDGO8LhOT0XAIKQw1RpOT6d
	 jXeI+/WQ3PXpcPGESYooDiPpP+PUFBn0+S/jmlFPV/zKRG+OjM8ZvjjYFqD4VrcQxZTL6
	 oO3+zrF+yPfuyMxCEsbZ68EKHw9LnAuxWpGREwW4HqU0jjux4vf2v/J+7kaM/fHCT3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMlzYbub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C548606A31A;
	Mon, 26 Oct 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMlzYbub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAA71F01825;
	Mon, 26 Oct 2026 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793047455;
	bh=/kBWIySqVK+PWmxdvx34TJ2UPR1qXh1MS37/nhOACws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UMlzYbubU9+UHKB74PSevBibC29LZQLOORvzLEcWSxfcArzmmh3NgD/uVj44cM2WW
	 9VCLMVrSJh78gj6pVk5clxxljY9tiAWSdlsTPYU7Qki4EoOR3vsC6dus0vKWleF1cx
	 cagwvcosF+9v8uDCZPytC80sU3U0lxkNHfjbYurN3yGJs0VyKRBsMLTtT+kHncw/lv
	 mrqtPxLlbeknaIk5vtddCHOQaRj6WLSP2osBA2W/qMN76koNzWeBldiHg1DrbH+ggF
	 FLwqKJdoCx6oehOe9eOaJiYelTuLxIzLucY3Ue++aavZF2wOBYww3I1rnEki0ziQDH
	 jBzMsRlV2FoEQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 4281B1F286F3;
	Mon, 26 Oct 2026 20:44:00 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Val Packett <val@packett.cool>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Bhushan Shah <bhushan.shah@machinesoul.in>, 
 Luca Weiss <luca.weiss@fairphone.com>, Antoine Bernard <zalnir@proton.me>, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261016063536.598610-1-val@packett.cool>
References: <20261016063536.598610-1-val@packett.cool>
Subject: Re: [PATCH RESEND v2] ASoC: qcom: qdsp6: q6afe: fix clk vote
 response type mismatch
Message-Id: <179303940192.199157.18424504890882837346.b4-ty@b4>
Date: Mon, 26 Oct 2026 18:30:01 +0000
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
 h=from:subject:message-id; bh=+8moeMoR9LiSrGcSUzfh7gF90tvP7B2NY9IC3v4N87o=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLu755wZMNxw9+3xCYanV8QWp//8NC64wbTY0Qnxp3fu
 mi+8u7cWx2lLAxiXAyyYooscVncL+tLXq/hO7iwDWYOKxPIEAYuTgGYSKQ1I8Oxi/s/FLtJSZVd
 uWD/7RgHU++k282cM2Tv3r26Ilqk/HoqI8MDl8S8FdV/KysazorOXOabwLD6g7Gp6qno6uPPP1U
 5HWIBAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 03:29:17 -0300, Val Packett wrote:
> ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: qcom: qdsp6: q6afe: fix clk vote response type mismatch
      https://git.kernel.org/broonie/sound/c/f3c7bee984aa

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

