Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630795;
	b=jodMRgraQLGuIMLmccf8nz3ho04/UQ4YU2AIVDvrFMsF2mWhfV/GGct37LNeOe5buGM3
	 /7qF6hsYOxGTZ2pFW62RRay1T1+Z6+YziAgzKoqIIPqEL/5Lso0nKkajJ6T/i+MRYMiog
	 Ju7tSiOPC5DrvR6gmm4Ij08QOC7r+NRV+p23hK/BprA9jGp0oVi9IyEhX4ByM7BLMKXop
	 tvHr7CpWbY63LNmb8fssOLauY8uPWzoE5zy1PjgOMncFE7t/fgMHg1eQFYGcbEoRuwg2u
	 54nhaoL+Ibt5kKsCEj0JHbXJPyv2j89EBhTso4XpblF5s0ERCJkEje/EB2LTHsLCXXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rCtrAnJviulqez0+JTPRdagoIh7IeZsTjrVmURq9iV0=;
	b=BnhzKvszTYbUr5i6kCdKKekR2V6yAb6dBMhh7YdmJSNJBS7hIQpeeZWrtJf8n843tuJb
	 WeilY9+4UKGjm3ZCU9ChWq919u7+KLjP0VHhHU2kbvVzbPeVP0P0IvivQc4H6/La1BnHM
	 6EvUJgd/vYSKjVKq3bfk+nHpB9yPyMS0iFutIIjhZWrDJlj9qTZKO4ppQRPFhYIfCncf2
	 IweCGkxlRgvxeedWfzq0pdryfNADZ5Sr7DFUf/85Ci8zrk0S+C85WxvJUvxn23z7LnCMz
	 viwYYJe1LbLZcwt8suUOPqhl9S233cKIMLx45xZxr45OHD/kA1ZI2rYuFq6dsmyfe5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4HZd+4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B006088B30;
	Mon,  2 Nov 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4HZd+4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED81F00A2D;
	Mon,  2 Nov 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630795;
	bh=rCtrAnJviulqez0+JTPRdagoIh7IeZsTjrVmURq9iV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U4HZd+4W6Pf3UVe/MGTpV9jp2TFzuGLQQAhPFC68075Wo8dHMtqMo5Y4Fh8nxp5Qh
	 3EApXUcedvjXzWfbAhUPrGms3NRdpkfiHqxym5bMR87QRmB5iWx6OipKELl6UJN1XZ
	 r3u45gEBFq1RGa/V13bozPYdrkPTARCASrS+ph7S4w+dDE2cvq5cfY49TLM8QYL8nN
	 8xACTcgMaF9BWeG1IrJHLFJ9NqLTj8XZsXexq1SU3vXXAC/ZQ9rtBL/InawXTqBhHM
	 Y1eugorTDD4/gXU+p8bpwbgGZ3e5DwEXeNxMfIYb6k4zeN3ZEu4gJPKMgjKqaWA5zu
	 6C1AzMtEt4zdA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	stable@vger.kernel.org,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable 1/3] mm/damon/core: reset watermark wait state on each iteration
Date: Mon,  2 Nov 2026 06:46:24 -0800
Message-ID: <20261102144627.88843-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102144627.88843-1-sj@kernel.org>
References: <20261102144627.88843-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

Found while reviewing the DAMON source code that if an online commit
removes all schemes while kdamond is waiting for watermark activation,
the scheme loop becomes empty but min_wait_time keeps the previous
positive value.  kdamond then keeps sleeping instead of resuming
monitoring without schemes.

The way to wake up the kdamond again without DAMON is bit complicated.
Install a scheme having watermarks that can activate the kdamond again,
and remove the scheme again.  Doable but cumbersome and complicated.

Initialize min_wait_time and init_wait_time on each loop iteration so
the wait is calculated from the current schemes and an empty scheme
list resumes monitoring.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Assisted-by: LLM
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/179277129124.2.16132047926074873101.damon-empty-schemes@gmail.com
- Collect R-b: from SJ.
- Add how to work around the problem.
- Update Fixes: and add Cc: stable@.
- Rebase to latest mm-new.

 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 73b571b429cb3..7441cdea57dc5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3976,10 +3976,11 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 {
 	struct damos *s;
 	unsigned long wait_time;
-	unsigned long min_wait_time = 0;
-	bool init_wait_time = false;
 
 	while (!kdamond_need_stop(ctx)) {
+		unsigned long min_wait_time = 0;
+		bool init_wait_time = false;
+
 		damon_for_each_scheme(s, ctx) {
 			wait_time = damos_wmark_wait_us(s);
 			if (!init_wait_time || wait_time < min_wait_time) {
-- 
2.47.3
