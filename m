Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586548;
	b=tNcytGdlNFH2RnLyIaERks3iKSjHft/gZ+IH7OkQt/ZviXUOMcQ0xOWQUTfheDtpWptR
	 HR71UhAIUql4CjjNKs1UURaeXoIoyABLHQw3Ko1q0PzvVC2c0jZh49T2ivKnbO4fkvtFO
	 RrrXuKT92R8AuPxgQlgCHI8dajQLXCd3E9BEfVLlDlbJRsH5PMinQpc36MJgfKQRTv5tU
	 01FzC08GL9bEmij3rzdunEy6udhz3FsgPUAVezo1uHi+tTyYlLPn4BszoU+mKOkIU8GfL
	 K/31j+RfDjRh/yX1T0u2qASXTYpEUkdN4SP+A9VTiRuWQHgx6F0dQVTmPjHs8CdlI3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586548;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=iXnnv1l3XO8DMLc+JArutucUAlGgvxCJTsCN7SIQhyw=;
	b=QeuXqjsDhb7frnngzAlHOykBUNpKoDGRHOoDylDjefEozdA8NtGgKp/uSQjBzftGCHfA
	 hgMn/Tn5gT9Ou8cyuZqjTmWQ6t/PqD9r7MLRiTVmcjG2ripYtafyyl2+uMDKBwVae8fCK
	 GxGdXedyVkkCyz9zM0e9ybV4GM1If7nrCHIYgEXzlfS4Q2n52pNTchKg7O4IoSR0EFcsA
	 ChNSM6EOb8dPYYuKqFcW+nJWdSOz6ziMLHNdNVVfairWSzZIpx/qqfAeHsFSyCuzYJaFt
	 xeuYdZ4Pl/eLm/1PShPmpAoxOb/vKyePuxXwVHRmU4lE15JwVWOgOpRbnblqI8x1acg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5DKxWVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15595606A338;
	Fri, 13 Nov 2026 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5DKxWVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A341F000C4;
	Fri, 13 Nov 2026 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586547;
	bh=iXnnv1l3XO8DMLc+JArutucUAlGgvxCJTsCN7SIQhyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G5DKxWViTbpZl1F8SLzi6S352oc9hRveKJ2ivd9G5M2MgJ9zDygiB6JJ56G3w8EvF
	 4YNzpvp6btcFTRqyvwbBTXTQVtSMqo4JpuCtXJH0hYzBtIEClp3CWE//5hsXqad1fm
	 ioTOhssx95T50v0OgAsr7S9dTYDndu2tB493I2YAu/PLQjhS0e0aVhhfqx8zu5B41X
	 +SACO9pevn3k/BFCSUHZU+f1ExHlmHK8SrmDzLR6cNMpfDlO+6iWkNFb6sgvmAVfCN
	 osQg7Gn+bhrc7y+TkYZ+7GIlgyfTAqekgUPyASemIbQpRNdwqGBp6xAKZRro0ltIEQ
	 422zmErQ6PqMQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261110124742.275022-2-cassel@kernel.org>
References: <20261110124742.275022-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libahci: Do not use an EM slot for the PMP
 control port
Message-Id: <179458654662.1844066.9708510734581868040.b4-ty@kernel.org>
Date: Fri, 13 Nov 2026 17:15:46 +0100
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
X-Mailer: b4 0.14.3

On Tue, 10 Nov 2026 13:47:43 +0100, Niklas Cassel wrote:
> When a Port Multiplier is attached, sata_pmp_attach() sets the pmp
> number of the host link to SATA_PMP_CTRL_PORT (15), and every PMP
> register access then goes through ahci_qc_issue() -> ahci_sw_activity()
> on the host link. ahci_sw_activity() uses link->pmp as an index into
> pp->em_priv[], which only has EM_MAX_SLOTS (15) entries, so for the
> control port it ends up one past the end of the array.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libahci: Do not use an EM slot for the PMP control port
      https://git.kernel.org/libata/linux/c/4576da8e

Kind regards,
Niklas

