Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F83DB62E;
	Tue,  6 Oct 2026 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274345; cv=none; b=LFZsH8shZUyJDZxdLElD9nXiRqxqzie1zT7aaw13LfXKeERIwVB5cwLuDKBipexjIkFhkVBh69t2X5dEMxF2ZmfBzBI9m4fAVcijFYGxIJAKeNjlG8OV3Ih4DX0CstyZq1385vW1/MInkSfjgIoaglz0tBBeYHGVKhh2KsAh9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274345; c=relaxed/simple;
	bh=hY8sMIu7jBNQSb3vULPOnW5VarKXgMfWF5SB394xPnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=odcSqJjAYiOvhqSWUBxE+5b/py9quX+lFT5hOnpgs6iKYOXdy/hTkaKXBb5ERtlIJq+T8dxosYhYSNDQmFx6r3v+xzieltFOb9CuG+d5K8tW3qBPdIo8pSf6hui+LBK9PWx0RyVwyWPjrZgoNN4T48rzSFxI3owSAobRmS5GW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoV4Qmm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoV4Qmm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11351F000FF;
	Tue,  6 Oct 2026 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274341;
	bh=ivnJBMc+jWbCgkX40sCX7eTCwtTHgQTlNzAcwrtbn2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GoV4Qmm7/IUoIouWeygSBRwmq5DHV4I9BKn9QKbxyVBGsiufa1AHZB46+RSn7OSZW
	 XWdn71wkoNNrLPllhVDOebpseih+VoGhWNlt8JckxqC5q2DUTlFFKIboK6EtpOf2in
	 G/P2h+LLwTwCMNERXB6rK+uF4bfrPtxjltyEUI5z54j0BL05T7zI5hXOqoFth4fdA5
	 rD1kij0O5/6YyL1Qdm1I5/wVhZMtin5lLoCsTCvxTpvP6Js4QlfLoGK2yz4oyuXCXo
	 +Q3z9T/2+7Y+iSGT0DLj/Y/ULkS7ZSOcjdNQwFj5FojSMeAN08Xcnm5Twu5JeshqYv
	 0hBUgdIHVucpw==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Derek Fang <derek.fang@realtek.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261003041045.650207-1-mhun512@gmail.com>
References: <20261003041045.650207-1-mhun512@gmail.com>
Subject: Re: [PATCH] ASoC: codecs: rt5682s: disable jack detection work on
 shutdown
Message-Id: <179120760007.150114.16478950058016400676.b4-ty@b4>
Date: Mon, 05 Oct 2026 15:40:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hY8sMIu7jBNQSb3vULPOnW5VarKXgMfWF5SB394xPnc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqxK1fpme4wThy2u6jmTiwjM5KYxlnXtq3X3WCs
 DepCH1sUy+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasStXwAKCRAk1otyXVSH
 0ITwB/9b6GUDCOCPXSHUYMVQ7qI0HbqpXj+DlpYqP9NSmevBLQjaf7Fxc3ffVWKOLy7LQ5xk2LG
 Q0zK/6G+TcjNt6zM3g08EnudGYVHkDi0ZwGbGZImJhgz1I3LxpK5a6h3maa9x52adFbz0cSkBJq
 Wu2YgHMcYmoGPgGVW38JrMv2XI1FQhO7PkzEAzbogh0A4TyMUMG9aH8knlUDWYc4nWyWGoxHYs5
 Lsku2s23495SsKN1CACxJBUrAQAS7kH+hmydMz9kKy0xNHiXZuIxDgD9V89EU/bYnNwkhT8yET/
 E9T1gWVz6Lfqz/hZwO1TqOBZzoB6sm5+UaclwZU8z+bP70Up
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 03 Oct 2026 00:10:45 -0400, Myeonghun Pak wrote:
> ASoC: codecs: rt5682s: disable jack detection work on shutdown

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: rt5682s: disable jack detection work on shutdown
      https://git.kernel.org/broonie/sound/c/ca552e3140e7

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

