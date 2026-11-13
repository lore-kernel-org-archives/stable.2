Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553143;
	b=koo/uhRC2gQusPvUV3EIpSaeKAxHN0xNRuqHLtDgjGJ1jhs/kxYULSYu0tbyaJ7+BdGG
	 JTbm9N+90+5NLhpSaL2JVtsqdyi+ZnEFRGxEPQg26QneEJRC7+Pa6A9879N7c6Pm01UnN
	 GoL5TH11zoMFI84FshVqSkHeyLG8g056AyhxNZ8vuY70RoK5QAEmdTWPBHuoUmcN10b1W
	 VLCQDT7TxH3dldD6GPGMaEjLg4CIvSl8ojOzvodAMlsrvZRL30l9ek/Yhgaicr3Xro5W/
	 8Idn35BhQrmKeK2nHDFvUDNwXV9ml2BPs7wVrCloAVNgsC3mgZP2UbLOT5X9Ldpj1SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553143;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=ozxLfapJWDQCfeGZqwmNNx/MIjqfWyk0rPIWNbFTJv8=;
	b=ew5wZO6F8Vj8ACnZheVjcypb51M7QZVYSq4oHzud2SWRDqEgTr9rotkfapapZy1Ihv0X
	 +OeA90oErZxhgQyB3+iWNNkeWqjmiZKOvmgZiVt8GUkaeMlNKEsGwc3vVn7eiGhHthmMr
	 Ap0wYcpYnsY4KlKthK9Znmd5KWcltBUpKOOs/cMfvyBA8w77RTowgJpsnsXZmP+L7Axvf
	 9T805X17UGDLhA7PTiRbtCVvwiyBM5YOKH6TeuZpDtr+ccdcMOGLcJODKsYZgXzuCKXy+
	 T0odD3/ulKGyKCxlf/SQEUixM5IQjPdECFUfjZWRWBbIjg4TMvv1ydCeC46iNGnc6tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyTJMdFX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3B606A31C;
	Fri, 13 Nov 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyTJMdFX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA49B1F000C4;
	Fri, 13 Nov 2026 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553142;
	bh=ozxLfapJWDQCfeGZqwmNNx/MIjqfWyk0rPIWNbFTJv8=;
	h=From:To:Cc:Subject:Date;
	b=DyTJMdFXBeFK5qaPreaxje3hizU8jMb6FEYbTcQKphiGueLwI9jtH1CTYxsmAvAm+
	 O+NHlWmVT9A6isBSNieuC7USvpXWAFGj67Fd7Bb6oP56vuRpkLAzy7E6rZ5s2lNZy/
	 xKtOG4wLODwuHnfluEiCZdsBUaBze+CqKmKiKSEXKcC/I2Sz2E3TF/5tJLDxS0QZzC
	 JRijyUPV9UZD/qTf9Z/MFW1g9rPBcQi2O4yNITHz0GVCLIlJIywjwsyR2hz6rupbcW
	 v6kJo6VHGGO6K+4w9E4b5h9wn3/JoNlaJ6+0uBebJzpO8TLnVasAEmMVUEDbxzrETV
	 uodSadJUJmQkg==
From: Kees Cook <kees@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mmc_test: Set "cnt" to the allocated size explicitly
Date: Thu, 12 Nov 2026 22:59:00 -0800
Message-ID: <20261113065859.i.967-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=kees@kernel.org; h=from:subject:message-id; bh=Shs3zF3wUU8JHN1trlidFo9nMMZXkE47Zl6or46ELb4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnfthp7FC0QlCyQ7/jw+5pI/iMndT93BsHtH9Kuz/FOa lxu7PS4o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJMTxn+B9u/fzTtSeDfCdPV /B3nbdJedWCq4JHzRkvzHkqw//a5L87wz/RL/SP265wH1GQ6S9RT5/scWl7zaO4p3mfTwz/8ku0 Q4QYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since commit c35fac6481a1d ("mmc: mmc_test: Fix __counted_by handling
after kzalloc_flex() conversion"), mmc_test_alloc_mem() bounds its fill
loop with mem->cnt, relying on kzalloc_flex() to have set it to
"max_segs". kzalloc_flex() only sets the __counted_by() counter when the
compiler supports __builtin_counted_by_ref(). Otherwise mem->cnt is still
zero after the first segment is stored.

Set mem->cnt after the allocation, as that commit's description intends.

Build tested ARCH=x86_64 defconfig with CONFIG_MMC_TEST=m and W=1, with
GCC 16.2.0.

Fixes: c35fac6481a1d ("mmc: mmc_test: Fix __counted_by handling after kzalloc_flex() conversion")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/mmc/core/mmc_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 4dc16649e61d..aa30df9d33d8 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -357,6 +357,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	mem = kzalloc_flex(*mem, arr, max_segs);
 	if (!mem)
 		return NULL;
+	mem->cnt = max_segs;
 
 	while (max_page_cnt) {
 		struct page *page;
-- 
2.55.0

