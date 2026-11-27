Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775134;
	b=CYugLaeMjYFcj2HUfzOYS+r4oZi1e90Ifn5Ivzmkalz51sp4N9aJOPvlfp4bhiqAzqxP
	 TgA7/0ff1Ov/FsN+Ir75QJutY9MDwhUVpKW8nXd1crpBa+zGlIfUbJCSL+odmo//agUYj
	 hdHh3N6SjLDh5JNXvJ/0MA6D5v8H4cH3ArWZRLs5V47W+kIQRa4KLHCprFoM8RuG3ZKwe
	 7M0ui3VymWuPDGaxJPeYJQcnXSrZgVQ7qzNv45aUgGMOZB4ZS8aM9rangcrcT8J9dhQrQ
	 U0yBqMVelbmIffzg9XWzw3I01rINBh/C406wnjFYsT/M+gkKzcQWMEQSwkHDygiU9YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775134;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=cqrCtQ+crZqq5Hl0OWUmOQl8evhsbaMGP9KCXVs5fc8=;
	b=ZYGDcvJtSky2o4CkxOB+H7Ov17VJRv7h2yRdYM6J0POI2llbynFNxLqI1QWvg8mQcRXx
	 Z6Hd/2dymeoavZUchtAn3argRXD88jHu1C30Zdi0vSfi0ELAyY7a8z5kg4Lab+YfQ7g0T
	 pNxof9a6O9q/y6Vn473b5JoqAuGMrfcWtPMIp1YkwqPergCILio/XooEVNxZbKNhCSPaA
	 lUVsRiHzUWFGLq0qgozK1d+NeN5D1doNejOAGSxB6dIdYixdASJNbRyHc1Uo1KH6k/cOh
	 ZKZBYx5sm+SmLRiB9mEjxv+eKiZzUjrmUt0cudW7+6aJsR8I7Aysa1WIN8p7hWIVyWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqClurjm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF43606A31C;
	Fri, 27 Nov 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqClurjm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778471F00897;
	Fri, 27 Nov 2026 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775133;
	bh=cqrCtQ+crZqq5Hl0OWUmOQl8evhsbaMGP9KCXVs5fc8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gqClurjml9seBU1xNL1zqZ4uzDStIMLehmpB+cej0+4cKs82+vSC9/C8tY7OQp5Tj
	 NgpCAtm2ai8FJ+WQvovJBFlLLlcQg+lAZbyE+/9O+reVV7ENvKO9c3qivCaMB6sfw2
	 ddElOIehHuX8t2aUZjWpRXICBlq0g3dUKc0RdvJzQdHNo6ZFDR2ep4Gatb43Ilt+qi
	 f5d9JTWHN6my3TfO8Lsso3nEmgJKo7niHutFwhzpwqC/WWvRWSuUvjMl5JQPrw6nqv
	 5JPAxN4PPPRMZr2+bILO2+Rl+ktGmfqfkMI0DvgHKITomcCuPc5mn2aIdqiMlLXy/a
	 6EAluObFoESyw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Mohammad Harsij Sani <mohammadsaniac@gmail.com>, stable@vger.kernel.org, 
 linux-ide@vger.kernel.org
In-Reply-To: <20261126142406.2753290-2-cassel@kernel.org>
References: <20261126142406.2753290-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ADATA SU650 with
 firmware XD0R3C0F
Message-Id: <179577513220.3002126.6665251692747732688.b4-ty@kernel.org>
Date: Fri, 27 Nov 2026 11:25:32 +0100
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

On Thu, 26 Nov 2026 15:24:07 +0100, Niklas Cassel wrote:
> ADATA SU650 SSDs with firmware XD0R3C0F drop off the bus with NCQ command
> timeouts when LPM is enabled. Disable LPM for this firmware only, as the
> SU650 has shipped with several different controllers.
> 
> 

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-core: Disable LPM on ADATA SU650 with firmware XD0R3C0F
      https://git.kernel.org/libata/linux/c/eca06bf5

Kind regards,
Niklas

