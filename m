Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623303;
	b=qS2FihkQwr+HQ3rSVIF5sBWhX8WGVy6OjWGzWgtf9qE0yMWmdL2utZPZMldzHkmMOopv
	 gprw+9dSPHSXilPSa3RwC3ZMPnHQj/Bp1fvdz+1B6eSEuw1eL8p8K8pZ0vz0IoxaE1zE4
	 t8qiwbVTPzzHZpipPihRrNBKujRm4cbPXHosO7FpEDLTSWTGxwSr7ffNt+8Kic3Pmrj24
	 uDRtgSDUpZ7kD1lSAxzL5NhUPP3SlbBV/QrchecTa/6gOEnQyVs9SStsVnfele+nxGytV
	 H39cFHziCRgA4pT5BMRfEqV7q5uUGOEnk82ReMkyCNOHjw9tfGCjvdLirTN/Q3fLdog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623303;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=BIPXY/ZKLgSoQMb6rlsEAducJh08YC58iEGteAsnDi0=;
	b=IF2d44UWnMITqUQYCR8+ZFVPimrISt8Dv9cndOV7ZRNOfDK2an5ohSmetmMosOirFZxq
	 BONjaD2x4/bJGtGvDAgGNmrmijAtdAdBONXo4uYp7+WluhUhvW3tP86/7AKv5HlzcoyIj
	 pIQdx6FfxKsDwOiahDXy3tnKCOFM+KEv+cVZpymYsMA4g/fwemJFAQ72XjW1R+75Z4ZgK
	 BKrlZ/fMU+8cIvpMjzk8pbIa1XYu7kVRh1NWJBj1MwTtqHQfH3eXCPpe7h7ejdCtAUvlR
	 Z+XgEnLjwKDfwBp5cnVFLHEzRU4V8LPlvP7I1U+Sg8160xGgMLCAmoiEN8u6qZ4MfgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx9XPHeI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C960A2637;
	Mon,  2 Nov 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx9XPHeI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FB21F00A1D;
	Mon,  2 Nov 2026 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623302;
	bh=BIPXY/ZKLgSoQMb6rlsEAducJh08YC58iEGteAsnDi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Dx9XPHeImChmTs0j9yIksHNHH4FuFP66rUDtfzV3/BdZ3bd1vGwDgwR1bkmJkk5q7
	 iFQv3el6sBJSYbu22aSZGTi3C4808aJnSzbIcTPEXrinKKq0EPrhNGO+a2aTbBkk3Z
	 7dFVwury6FYLelOobe0R5L2KJTB3XWaQx64dP+rZwBA/XhxvkppbYZC7pISVxjtIae
	 tb8uATnQQ5keyEFGkaLScXOeX4jdOvNriBmU2lcXRPZVKFf/xG5umtRc0iMexlgj1W
	 8uBEYoDEcCY8wHxtEVItLAb6evDBnbvR9lS3bi+fG8Da4P78eNH+VeWcle5LA2TO0u
	 eTcsexA/YJRqg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D82B72310400;
	Mon, 02 Nov 2026 12:41:40 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Brian Austin <brian.austin@cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 James Schulman <james.schulman@cirrus.com>, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20261030142637.415971-1-a.kazinsky@ideco.ru>
References: <20261030142637.415971-1-a.kazinsky@ideco.ru>
Subject: Re: [PATCH] ASoC: cs35l36: Handle zero sysclk frequency
Message-Id: <179357778962.1716893.15338453614634056539.b4-ty@b4>
Date: Mon, 02 Nov 2026 00:03:09 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ujMpkKvHBlLbsC3dgXY6O5xqQcsHadrBWxFl4EhFpEw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetLKsd/Y1FSrcN8P16ff++RHJL2RKuLWPbAubkNh36
 /l3efvkjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzkzkWGP3yN5etn1Z7OMDFQ
 uRE+Sf7S+o+a+2dnrOdgZD6Y9mZrYyYjw/qKB7+vnzh3N26SjMwtvorLErOn771jbhDRMNV7/0S
 JVXwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 30 Oct 2026 18:26:36 +0400, Alex Kazinsky wrote:
> ASoC: cs35l36: Handle zero sysclk frequency

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: cs35l36: Handle zero sysclk frequency
      https://git.kernel.org/broonie/sound/c/415f0a7c723f

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

