Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845910;
	b=Nm+Q7Yk9KkrVD5YDJZYmQILT1SKAI7un2IjZCTTS4HTPD5erSAtqzMylj8jqluVwpX2J
	 FO2pZcGev/D+VsDHLpp/G0nDIZvQsEd6wviaOIMKZtDKemjKBRBc5w4fj51pqYWuqP5RF
	 3wWLqBxP793vX8+7/T04hKB2irjVoKAn6dIWYVtiDJtnbKwXGhoKaj00NwMFf0Vd8aF3v
	 x+MXKwynI57K7Yve4fZNi14Y72R2bKQULW68o7gbQqqADLBWbc+jUG9nlJvgUWTlOCcLZ
	 n/+WZWakjqsomtNnlpWzffAozRt3XLTFSYm2Tp8vLpL5H4UDpXOW2r7BLSyRhpVIy4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845910;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=hWYRZxhzdGmu3yL2KKK7JeGOrICBHwZgYHCHIPw54NE=;
	b=Lq5u8mC+19vDr6r//aCy0BI3Wr8f7/5LgM/Jxzn34zSOqJPnLUKgKPIqzbgIcQ+5R873
	 ej8GJoMov8b68looJYhTWiEZix0s0vQS27A4a9Cn5Ebf3LFCkr9oBSNMtwxKbBjgJD+lp
	 02V4iXNINgNGme8ixWIMflKLHlJW22DzwzeJDt4hJYXIhlAXwPZCTdLdmDn7qaDWX16aP
	 hT1Mvzo7prnc5r9e+0TXcyEwOoun+w52AARieOgORvbzHK1ytsHr7c18a47jB9B70dreB
	 zCdyw/X2odu25K2xefEiJsB5bHh8ZW6doZhUIqjo0xuoagNuSC9MoG82vCaw3eaiYXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LUnH/Z48";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012E606A31C;
	Mon, 16 Nov 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUnH/Z48
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FAD1F000C4;
	Mon, 16 Nov 2026 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845910;
	bh=hWYRZxhzdGmu3yL2KKK7JeGOrICBHwZgYHCHIPw54NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUnH/Z48zWPLdQoLRf6pyF4mOCpt5tUjm11Q6Bib3u9mpsZfnB60yeR9iS1Ai20op
	 x+sSBYVcNTzuvLZI3cKc+voTIXguqaB/EL6PsOmj3cFCP04mugauAf25bqCo3L79lU
	 xh9EGNJ0jplV8FyuqD2+3fcvBrseeL5He42Z9YBGW163n+LWMCi9c99h6gHyxE/y3m
	 vTmRahFjuRsejRZM2uvJGhGFUV6ZmBZpkn+BxF4ciml1xP6MARs1Z9Th5r/GpBtw7Q
	 qcVohxxP6mGqQVCkFv5GcHDF7dTC1YjPrKZc95950oUjNqto+Sk2XmGWSbtzHeo6La
	 GUZqhfu1384Dg==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	shao.mingyin@zte.com.cn
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND 0/5] ata: fix platform driver probe, removal and locking issues
Date: Mon, 16 Nov 2026 17:18:09 +0100
Message-ID: <179484577325.2781504.2497197768299979233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
References: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=cassel@kernel.org; h=from:subject:message-id; bh=m6P+ovuoLnFZojBaYpMmxQknMVxdBrl66jX5PDeKg/k=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJ+6xyK3ZF1Ib69/YSTobfkm7Z9HO+z3tey1hz8a/7ox Ypy7qXbO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRf2cZGX4VOYrrxz9Z1qbX /u5yZtaSTcvW+p5vUORfW/N14u0+j6MM/8xOP3ozc/uMc5yf416w+Ty/Yn73m8zVV1EXwjrS3O/ OkWcHAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 02:03:05 +0800, shao.mingyin@zte.com.cn wrote:
> The ATA platform drivers in this series have independent defects in
> their probe, removal or locking paths.  They share the same shape:
> state established in probe is not checked, torn down or serialized
> consistently.
> 
> Patch 1 fixes recursive locking in the IXP4xx CF PIO callback, which
> can hang the first data transfer, including IDENTIFY during probe.  Patch 2
> returns the host activation error from the Buddha probe path instead of
> reporting a successful bind.  Patch 3 makes the QorIQ and Seattle
> drivers inherit ahci_platform_ops so that host teardown runs host_stop.
> Patch 4 stops only the Gemini SATA bridges that started successfully.
> Patch 5 serializes the controller-wide SGPIO update in the Seattle LED
> callback.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/5] ata: pata_ixp4xx_cf: avoid recursive locking in the PIO callback
      https://git.kernel.org/libata/linux/c/5149ef22
[2/5] ata: pata_buddha: propagate host activation errors
      https://git.kernel.org/libata/linux/c/5849257c
[3/5] ata: ahci: release QorIQ and Seattle platform resources on removal
      https://git.kernel.org/libata/linux/c/8d1ddc50
[4/5] ata: pata_ftide010: stop only successfully started Gemini bridges
      https://git.kernel.org/libata/linux/c/1c72150a
[5/5] ata: ahci_seattle: serialize SGPIO register updates
      https://git.kernel.org/libata/linux/c/e83e9d4d

Kind regards,
Niklas
