Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8782E228D
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584433; cv=none; b=XHVXS/kvn0u2HPsZw2aaYy2L44KCcvve/Np71B/vAsin5R1w6/x9kIsunKt7n0t+nmzNJD9Xxe5X2gPQdzuVf8UEeQ+JGXAJ8CDprkeu2REBePGfbkxCei7IDdk9ZDmuSNGE3TaGAvB3ae30rz6ECFQMHMSMazPpT6Z0bp1SuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584433; c=relaxed/simple;
	bh=5W01sVx2RIds1DAOkxhzGj9ZtpdsFUHRR8oVnYx2nJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r50/vLEjki6mU0cGVEERhYPY5B2cpGdvci/OA6YDzbnFLPFmTwnJOj16k00OgVMAppLLZcSNHVuLiJDXrlv/GngDg5XEhggWFkRhCUWiQcKlAv2AU/LNMhvvF9K7uYfZmYPXJXnU2lnrTfp/yYI921227tHpu37CZbMWrTaVkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZonB7/A3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZonB7/A3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EABF1F0089A;
	Thu,  4 Jun 2026 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584431;
	bh=dYvl/3K29ZV0cu6YhcZ12nwDPuy1zRO0Zwwz9harlvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZonB7/A3SLrOt0qeRcodQVxDUOXFkE1F+VKgBsMGGKkmOVZ3Q4wHyQ7gOcFvA9Vtu
	 WRLLdwitv+LESPihxrcMU/i3WzNhbcpSj7KOpe5ejLr0VugFx1Fh2Hsw2iSOj033li
	 9I9/pbswfMS4K4WNY3KGsmxulntqL0D6jtuBsTsCsBDp2Rzn3v2aIEDybFaXJdFs0y
	 wBh6KMN0UogQvalNj4XiMWH1QWk7TDL1tgRuHIFvz1MnxVZ32j1LQlPKKhOf0rZrQ8
	 WDXRy95bM0wGQULdxsU2YiBjW4y9Lnq1jMhkAm6c+lAeDXXK7KId2Kl8295gEl46xA
	 w1NgTUYWS1+ZA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D6C0F4006A;
	Thu,  4 Jun 2026 10:47:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 10:47:10 -0400
X-ME-Sender: <xms:7o8hao2fGCESxndKLp1pTQqH-beNbK3i90uwd6hHHEMDk9HT6h8VvQ>
    <xme:7o8hagT0CKly1DVwkQuVh6ZdyseeL9LxuXRKVgqopnHV9cyqR1lsOiM14Rk0thfzQ
    biuhZX6Y7J9bApWk4lRGdVBG0Ru7mM94eJXLpuwpbaQkokPP5eHfQ>
X-ME-Received: <xmr:7o8halb2cmfpy3NCL2FBKxoJPWY2f7DCoYjjvC2T4w3v9hsqlv-ZWzq4XcVt6A>
X-ME-Proxy-Cause: dmFkZTEnbxOoIv6tM0dLsEuDtk1qDKvd9SBoRk315SFIs+8A8nvG6NPaTuTHtWxX09pQd2
    kmhZQJAFXIZRoG2uwqXsCvSQLHHFyqPBLRlgDZDOM1R+77uRHXsLwpqHqkuB/xQMEeL5H9
    Yh7j9EoCepX3S8oxsk0Q7b1XMMuXVtxHCUg4Aa5UHd0TkOkqN6exGRI2HWKvJ5gzF66+CH
    9fJySW0myPH7lfp6BMxlzjyNHqw9L6PwmZLSyt1okrlhfToPVERjX7lBHt/jPkXvBx/Qrl
    D5naZubOYqFywyiARe2ZjFKnu+RDowAinYmgXtLtTezD1qxkQqUbpHifL2f+9hFdA0KVYK
    x7+p/JfmYQvSDHpUkJjASvFUQWPpThlG7Ur/1PI0pPcV3mDP0pDnG5goD0sRUdzPNoNy7n
    w7AiDQ7em4blbZ1R89QSnh7iZmECUW9JnEN8dvyPZ2rBfvVAgrqkgwe15JgZKwwCuPqj97
    je7aMqqWbiOdaj8JjDMQ0WWE3ADmpFfepDVnUdKy/LJNW9uQMMoocVDn/NLeKZA2NLhnzg
    bO09zNzE7xShuvITJvPfK5bZulikellPjGWur93O3qQcIOD83PGZZTTXEwVsFpP6zFvf5M
    vKVDuQkqlQo28OGHAggYwYcFZhYlkKFtiI28HTT1Gx8GYqRMzBmo7ZyULn2g
X-ME-Proxy: <xmx:7o8hauAtVRZCzqk5Um7_CR6gKW6Jn4Nuh9NKIYW-jj7lxX9KDzepeQ>
    <xmx:7o8hasCtvfo69e6WWsEzQ3N6a0rEuNxRpHC0WKlMO59nZ04sNopGlg>
    <xmx:7o8haqEh75_egZluEv103oLXu_q6uD72Qqed4vnl3-gdjQRIUhm1lA>
    <xmx:7o8havmTbl154q3dNgzmpmWS1BRd8agLlTn2NgFoxNYmHwZbioSMdg>
    <xmx:7o8hanuq43p6dS_OxW__gE1VgF5JBkZGHDJYNSnzUeb7oc_ix5N51L_j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 10:47:09 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kai.huang@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	rick.p.edgecombe@intel.com,
	david.laight.linux@gmail.com,
	ak@linux.intel.com,
	djbw@kernel.org,
	tsyrulnikov.borys@gmail.com,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] x86/tdx: Fix off-by-one in port I/O handling
Date: Thu,  4 Jun 2026 15:46:59 +0100
Message-ID: <e5a75bb68a6a778c95cac2ef77acd55cfd24d389.1780584300.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780584300.git.kas@kernel.org>
References: <cover.1780584300.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=1 (INB), this produces
GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
bits). The mask is one bit too wide for all I/O sizes.

Fix the mask calculation.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 186915a17c50..65119362f9a2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -693,7 +693,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
 
 	/*
@@ -713,7 +713,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found
-- 
2.54.0

