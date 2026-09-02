Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8335203C;
	Wed,  2 Sep 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358534; cv=none; b=tP1G7qda0TfwAPwwLqULL1XF8F3pqoZNvSgUVHqz5Or+FV91mWhQGrb6ck/1rlSmXq5YVPzYqbuwxq7G7oZ7hcNFCDnRgp/EDFg1yw3EU05ubOXjyb7U+ABVg7wkUCU0VmDUnwT7IPnL3AEFfaoK+rZGTz4xxOVR2QbDl5vU3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358534; c=relaxed/simple;
	bh=2KB2m+gDk/p4vhyDeC61/AYwoCwA5nATQLIcXaUUn1U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VeAk757v5Ub0gY3VpzI81AYtG2OBxj/MUlQbi1EJf/NGRo6t60BoIN5WzqKAgPFAkEXiu1UPjynzZrP82+2x2q3cTcKtODiOyDYtEjeBwt7C+ZUekE5FOwlGYtJUwrUZo79eIljUv3pToyQXi7UzWlqRBwCWUIGOiZK80m8ppME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF34A1F000E9;
	Wed,  2 Sep 2026 14:15:26 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: leoreis.costa@gmail.com, fra.schnyder@gmail.com, francesco@dolcini.it, 
 frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org
In-Reply-To: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
References: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Move clock enable after core reset
 assertion
Message-Id: <178835852653.83808.12038237867062064510.b4-ty@b4>
Date: Wed, 02 Sep 2026 16:15:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 13 Aug 2026 17:50:03 +0800, hongxing.zhu@oss.nxp.com wrote:
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> inadvertently moved clock enablement before core reset assertion, breaking
> PCI device initialization on i.MX6Q Apalis platforms with
> ASM1061/ASM1062 SATA controllers connected.
> 
> NOTE: It is not 100% clear if the issue is specific to the ASM1061/ASM1062
> device or on the specific power-up sequence (reset vs cold-power-on).
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Move clock enable after core reset assertion
      commit: 16929741a622eb345057e41c7b335d9b297890e1

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


