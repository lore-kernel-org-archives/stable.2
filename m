Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6059221D;
	Tue,  8 Sep 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891634; cv=none; b=OrDtDyTgB3BbnShwtm3+GBBkCimEf+T02IZhFU0k2VxWkGInTI3w91wjQ+hwHhGsyfbbgLi2Xq6Pp6dlohCPN0NB+bmxk3CV28GuqQC6PwWWyz6PQ7atDhgVgyvJdVJt53bAr/It6I9a526KjgLlGyJ68u3UD2xyfLA10o+eIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891634; c=relaxed/simple;
	bh=aEmeb3BPj4vgzXWCAg8YcKiAHPbXVWt2vQExapyRePY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npv3NrrBp5N4A3TcT1gW8nKnjmBQnzzWamqtml36W6ZgtrnRlWlGW7xxaSKMlEyF/ZTQ7Vz7Lcjt6KES7xozNJ4TOqZ0yJggu/1t0ujT0D3PeMHC+70uGuu6KbFUMvSDUwItoKQIJWuaDPOC3M0ZDj6pwupIZgTJ3wQiZ/YL/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP3HBXBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP3HBXBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B35B1F00A3A;
	Tue,  8 Sep 2026 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891632;
	bh=mpzINRNRq1CBm2/HslyepZlk5MVgORYoamd+SFjS3ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TP3HBXBL+799ygFMkGXjA0a7gu7THkPZVcee7jnQRYuvBNYQgUSpJouE4ppvKRMbt
	 Usv5TCWPajZa9XzDeGFluNmuRl7z2ikzJHyKxDauLaTD68V+OB3dqiQKod5E1QN8Di
	 fC3S564bxug3dz7H5yR7DIRjohByzsUGOXki+03MIu2YP43ZHgshEr25tLUPjUpS4E
	 eKFSTfdOBtY0yvq2zpfdLGy755+DPe2qINIlnZeO6yrARq0V2zSzdRqzDkK3/tHzcR
	 PSOSVNQme3uS0AHtRPaGXw4tuDBOSgCeShGBDoPCn3xqiNcN1beg7WtAPk7JjIAJcu
	 XAPFZ9erBBu2A==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: microchip: beaglev-fire: remove double definition of gpio interrupts
Date: Tue,  8 Sep 2026 19:20:27 +0100
Message-ID: <178889161920.3146991.520958835856287447.b4-ty@microchip.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904172253.2274751-3-conor@kernel.org>
References: <20260904172253.2274751-3-conor@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ZjFyHx8kfO+HZ4s57D5vDO7q0jUtFSGy5PPMUBeWPak=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDFkLAl9XtWW/Trfe/PyqWVz/n8bJl+66FL1ly1+k1vtvp mPcGvGVHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIAhsjw4P9eyRvLL5QX/bs r0MM/9Lze4wfzsrOdLMquFFmfTtmwn6Gfwp7+hLEPk35vn3iQ700rjdxUv4q07m+5JjbMO5IrFD sYQQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 04 Sep 2026 18:22:55 +0100, Conor Dooley wrote:
> When the irq-mux and its interrupt-map were added to the mpfs
> devicetree, the gpio interrupts became fixed at the SoC level rather
> than dependant on the design - the interrupt-map is now what varies.
> The beaglev-fire should have had its dts copy of the interrupts removed
> but did not. As a result, the mcp3564 driver does not probe, because
> even though it doesn't use the interrupt at present, the SPI core still
> looks it up. This lookup fails because the second copy of the interrupts
> property doesn't resolve to something valid when passed via the
> interrupt-map. Remove the second/incorrect set of interrupts properties.
> 
> [...]

Applied to cache-for-next, thanks!

[1/1] riscv: dts: microchip: beaglev-fire: remove double definition of gpio interrupts
      (no commit info)

Thanks,
Conor.
