Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721147206F;
	Wed, 14 Oct 2026 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979970; cv=none; b=FFM2jLGYMZwbSrlbLjaNn+8PvAnqsH7mdS8sU2Ogwd5GBhmhYG+7kAwdp6EmJssj+vGTYSmIQ3fSbvVOzGPgb9OIK1kz7UE9JLlrEPTQAM4TuxXfRFvaiM7lF8I1RWZQTNb5gbLNqhBay0C5yTuKqyGkazmbiMvP95mV57Y03ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979970; c=relaxed/simple;
	bh=x7N6XBFp4Y0RlKxogsfKhRyxYH+FFxWI6+Qh928rbeI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=psYKYhZ/SQGwmk7lEHrkgAIYQ3253djWjNFpfMfNj7pHWzbSXEXevAr36taC29PEJ7vh939cgLcpBBa+g09kmL+gaptUUdWG7Lvenz/GHvPCML5OFbA9NtiSwFMrQiWnYhaiavIcL2vvViWf4LFgxd2u6TTHAD51HsrVB0cyQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZLIhcGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZLIhcGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1821F00893;
	Wed, 14 Oct 2026 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791979968;
	bh=u0/kXwLol77P1UIWOZaXZfvnRJWwEc/Fx9u5zNdyzPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BZLIhcGbGKV1fsesf/wSm71gyqX5envcYaPqmYBFHgAuldLfHIx+qHL3q4oc/ZYpT
	 UR+6xFVedLeFGlSYXe+hwMsCsMnorDk0TZ0jNCNcw0TqloNhZ8bLEKYy6xhmQn/q20
	 1x8TjHMulY4z2j1Gi679Q8i03H2kvVHpWKfQON012Aev9AdiuCbTeyu3Fe6D4szxxA
	 FlEFsLQcQM3eJ+Jw/N07l72bXJjJF7OVyHtQ5aGBxIMTuw5ak4Kr56H0+qpbjmoA6H
	 DmVnWgzb5Ug+0Om/EjBpJYRDgcycRY6Z3cXrrK7tvpzdLaGIeHqLT+7ARzSZ+nFaBU
	 VPhscif4noHVQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, Rudi Heitbaum <rudi@heitbaum.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <aqfqE4OLhnN4a1lW@b65e9c1eb12f>
References: <aqfqE4OLhnN4a1lW@b65e9c1eb12f>
Subject: Re: [PATCH v2] PCI: imx6: Avoid dereferencing a NULL clock name
Message-Id: <179197995736.38040.16523239820411551777.b4-ty@b4>
Date: Wed, 14 Oct 2026 17:42:37 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=320;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=57pibpZHJQ8PNUTQdmsvfInl1FuFWliYpgpnWYMvTOc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz3G7KyLfJwopwyubBI2cQyz05Pgfv7a6bBmIO
 GuKeAj9B2GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas9xuwAKCRBVnxHm/pHO
 9f0mB/4hu+0F+duNvinGllK+1Hhv37pnBDPebIMwv3Ligu+r3lGaVU8q1a95LUKPyr/xx5vywU+
 gmIl2GndmGc8dAkpT7O12EbYixW+40Gr+JsRSJzFw0+TCEvzx4ayCDyNwCkSeAfagp0+9BaMKAv
 ZVTWUV5eRNLRDQegH5uUdDFkkVKtccEP5IPPx2/qshCSf/Gcbb67t6gn74cSr/BYAv8PbEdWjjm
 gsGZay4vEcKxNJx3SUVu1J0SQVMqDSUpTHFz/UDzWczyCobEjumElMRTWYgJwS1iietF8hXEc+y
 uX8vzO/ccIIWqJS0GYu31dpFBqTypaSYJq7bpKiZuGrkxY6m
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Mon, 14 Sep 2026 12:35:31 +0000, Rudi Heitbaum wrote:
> PCI: imx6: Avoid dereferencing a NULL clock name

Applied, thanks!

[1/1] PCI: imx6: Avoid dereferencing a NULL clock name
      commit: e6fe37efcde8e7f81581129ef4e57ea158f38e40

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


