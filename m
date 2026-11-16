Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833339;
	b=2G6IbLjH2xjySLTU9CBz26DXgvAt1+kQdk5cpx4+8NYzpejUB/JhqJqeH8kg1wNCbZnY
	 PGmAiFmwcfsAv83Zx5sQzh0v2JK4AIPkio7E7EOuVxbpg2J3busWldO9zT/vGbEKE6Fpo
	 XQEVqJXGbhnlOhR3mY0+flWjIbGLDsXWPb7+8CGpeI2XUEJCUoyyNfcln4Hw31PzOc4cd
	 IavDQH5ZWPB2vQ3MeeK2IEP4eRbDmeVS0b/lEPz2MgRDZPW1HAbr35cEYVGaHduOvEM5r
	 SiKVpfuod23cmbGAdVuz6EpajLALHNIVN+q9Pr7Lf8H2yKR/TN/RT7QC5Lif7YhPbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4F6U5hwvw8gwNmHBNKQhCDls4ausjqIT8kXPov+zDoA=;
	b=VySQd2GWQgrGzaXutR+HLerluX/RsxXBQ2D2TzbnZ+umHg8Xq8F7A7bpp6lviD419sJ9
	 wwdGXNoVV4uO8Fg2dpA2C6BvY6lUIhj6XhdP75+l3clemfmWH5ehjNlpGXY1N2vmMeEen
	 cS9BH2vwy0uFj+tHUC4zPXPDa2v1QE/tYL9H+c4CpwGU279WePPiFI1nNjz2yPX1eQZgp
	 lh6VRj3Jued1oleBMdwknHlw+tHPjObz1CyzfTJ6qOGgRbhkaQc3ugoQ3+dT2MGITkti3
	 sSJFQiQlw8OwPc1IqcxybcwA9HxlIQQ6GSi4B3G4FCcalcG3QKgY9uzWEw/vTdg/9Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSdNGUDn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBE606A323;
	Mon, 16 Nov 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSdNGUDn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A251F000C4;
	Mon, 16 Nov 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833339;
	bh=4F6U5hwvw8gwNmHBNKQhCDls4ausjqIT8kXPov+zDoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSdNGUDnUPPi4pJnAYBKNnCGTaI+y4qb3uN/K5lIkcESpOPrpKPgqoRvuRlqXEFp/
	 D22TIAOQoLnM4fj+lgCWae9ef+MQKYOaeqrQgq0dhWWtnjfAThJNwLHjtsfOcC5RbD
	 Np0pFfdb5cSXXXZAUynvQxQrYr1pxZBp6UXANT9o7ZTogMmpoIoohw9lcwxG03mhpX
	 Oy2/oEtzbGj0awkxpXQl7L8affCM3OatgSUKikQvjQ8lVdfzBbeLPTvGwJaiSqc/fS
	 78SKOIgyWd1tcz2HtBmGbx4T2VjGTdAtXLoFfYLGAeU5FNyhXMeNcrhwM2xy6db58r
	 GhZKMPeccyxAg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 03/10] ARM: pxa: support arbitrary PAGE_OFFSET
Date: Mon, 16 Nov 2026 13:48:25 +0100
Message-ID: <20261116124832.662455-4-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The pxa3xx_cpu_pm_suspend() implementation hardcodes the default
PAGE_OFFSET value for CONFIG_VMSPLIT_3G. This has always been broken
for other configurations but becomes much worse now that the default
is changing.

Fix this to use the correct compile-time constant instead.

Reported-by: sashiko-bot@kernel.org
Fixes: c4d1fb627ff3 ("[ARM] pxa: add preliminary suspend/resume code for pxa3xx")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-212719@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/pxa3xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 06c578ea658e..253770075a8b 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -103,7 +103,7 @@ static void pxa3xx_cpu_standby(unsigned int pwrmode)
  */
 static void pxa3xx_cpu_pm_suspend(void)
 {
-	volatile unsigned long *p = (volatile void *)0xc0000000;
+	volatile unsigned long *p = (volatile void *)PAGE_OFFSET;
 	unsigned long saved_data = *p;
 #ifndef CONFIG_IWMMXT
 	u64 acc0;
-- 
2.53.0

