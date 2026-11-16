Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877225;
	b=p04jns9mSTBXajwrHQmiwbQsAF66HdaBkCfOtIWgV1NUWjHjwWsnzeQHq8y03YxAKN3R
	 LrxD1F1NMfiZgA9a1H1VHLgXB/UC+MnAzD1iU2KnKz9YasG4nj9/ioVlfo3oW0EfnEfGI
	 EADB68QKg0pIQaFXA3PNVqUO/XfqaaQtb9ZRvqxBRi/5YWxXygxbr/H75Bk7spa6xmDba
	 DauJQNIzKOrg7s+PWLS+zEh7MpZt9d7AqshBRG5K69LClLfbToMfuynJ+mtHiMnQa5FYU
	 gbk3ok3ry8DUQFH0C1NIsie3p64tcc4/omx2twVbQQ44Lg7DXvl/apY36JvqtVgZwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877225;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bgSIbrhhX1M1S/mhIphweUgHFMz7lfbrdfHFK5Cb/eE=;
	b=h5EGLG1Xq13FHWMGZ/qcwVYb7R6+avXNOCRTP03LcImglScT9oVuR0pMiSh7IZj84UCx
	 xkXPb5A6nmFHDxtGxdINLLSnTQ1FokWDO/tyG2aJxRQxTiOPeIE6Hp1z/OrDZGRv7UeFX
	 PopLHPfHKXsEcA2j2K0ZSFM55vhD2+zqvv04GgfZaCcNdCKpHLOTp9LElTClBXg3FvxDN
	 KYcY3syrNjkiC82oQdLx/1xM0rzn1hfzylB4/mbWTzrt5pZnG6VdRgrifJZmnuGvJHHVC
	 0UxdJYkrxg7D+/AHc1rZj7m9rRX+NKOs+YkSkMQNhuMUd5/A3tNQEo9MaHLx76vj8GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSXHPF7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419B606A31C;
	Tue, 17 Nov 2026 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSXHPF7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3221F000C4;
	Tue, 17 Nov 2026 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877224;
	bh=bgSIbrhhX1M1S/mhIphweUgHFMz7lfbrdfHFK5Cb/eE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PSXHPF7spIVqe2ztBNDDhOyYVVdgDBOHFwE50CSUKJP/2nwXXWyJklRJOhCdEj6HQ
	 iPZooWFYCdvtK3lEDbYKgpvpWu++UIHhC0Kcxb04kS4rlzrgKlAEF7JY3kCW/+r+xX
	 NLgumWSFFMKlBgBlqxlizlycsYAwGc1yKgUj6Lg8wFoHOpZFfoXVDqnZwKSfufBV30
	 9E6AzsxjvDLpoh4+IcM116kHk5mja0+V8XEX1J5UvlxFt/BPJs52DpeZ6J74Z8BcIp
	 SXjMgGE0dvaod3eD4zSUV59LAygTs8n0PcY9MPMxipOfIJ3lyx9O6ptBdUDy7MLMer
	 30FpotCBC8xYA==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Leilk Liu <leilk.liu@mediatek.com>, Rui Cao <i@udp0.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20261107-mt65xx-qos-fix-v1-1-9d9c16a584e4@udp0.com>
References: <20261107-mt65xx-qos-fix-v1-1-9d9c16a584e4@udp0.com>
Subject: Re: [PATCH] spi: mt65xx: Remove the CPU latency QoS request when
 probe fails
Message-Id: <179486355915.2504946.5816262629767344458.b4-ty@b4>
Date: Mon, 16 Nov 2026 21:12:39 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ueKoG72WP0KE1M/J03C8AU5NedkldPwySMm1P4vDO9M=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+L1fdF3Ncc+Ole4JbK9bpNv+1eNVoOnsNn4TyBMfoF
 0cc70293lHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJqO9l+Gcn8Ozcvwsfj8+4
 8+XP9W2bZM+XZL1mSpV8qsLfK13NfWsXI8NTO9MfSvs05/O2dExeELatWiat17E/5IbBku/V2cc
 SlFkB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Nov 2026 18:13:43 +0800, Rui Cao wrote:
> spi: mt65xx: Remove the CPU latency QoS request when probe fails

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: mt65xx: Remove the CPU latency QoS request when probe fails
      https://git.kernel.org/broonie/spi/c/d4cb2717eb13

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

