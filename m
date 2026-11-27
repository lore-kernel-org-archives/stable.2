Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784994;
	b=x3WFzcZ3xKrTlA+6qYrLLHAqMePlPt2THN7uppAl6cX1mBiJHNb/Q5HFnRYw0GiOfUug
	 6LPlddxT+nnGnmIQguYP9gzlko64YjUZw9CV52ZbeJhCgiXhBq3fyqYgPTWhNbtH5gC2f
	 N73QCaUsOjK+sq84fiJKdn41/MKSOu+qsyGPnlcECENqpsAwMLT2kh2kfaUP1OIX0TdZ3
	 jAR5BPWaoMu6sLnOyaTftZaaNu2opgLDJEi4q0d/RIJnGjLSxVZj7mR8cbB4yFM0DZm2Q
	 lNgxuWGnd9lXVlO3b6/VcZbVL32JjeSEwvEN3i2gtWURO14EMkk4iD3SYhz3P6fEJQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784994;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0ZIzM/jXseF2ZQWdwlG46mJZav9UpUjy9ipp/LnhEBQ=;
	b=2lNBKYJ3DnRwBqQjugpYY4hVzg1W72x19mr6pfzUSSJj5euZCYwVLiV3+i3uihRQR6mS
	 EwKDvTsZo0o8LbVhR0lPpKEVPD4oRkVoolQtIN1jcNFqHiQ9A7gS1cMTwlScwRXdqcXUG
	 3r7S273iSSaC8jyjLjL/9vSnRWMJpTKCbzh1UbekHopQMaZ4Q8WycOPg6ooDTW2KZp0yc
	 aGUhoGlnqYnRTXoM07pJiKbnobI6rVc3Y+9GQx6/Vxd249T+SSmWvN2mS+zvZQJ9Mn7AG
	 WTfZBtQh62olTHfQpdoLsKFZ+LNAreGhHXC1UR6gpcssAMql+piAQ64D8h2gprNFfGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlOqZKSc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F64606A31C;
	Fri, 27 Nov 2026 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlOqZKSc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795784993;
	b=P11HH4882IOvX2GDwZOUxFJ38AUrBoupayx8J3jb1OwpZIhZUDWqYgBJPaCoSu5lnWH1
	 m3Vb8StcQYQxTQ6VO7s2+IQ0GtbnyvscuE9rW31ZW4vmGtAhIpfRrc/raOaTBVl6BaKpE
	 qQKbeonELeQH0qRtFAFHWy4gcZiIDzYHSXnsitZkz0QjDDDHlD6YYKwuRDqDOjSjtLCAH
	 Lcau31n4is5l8hpuLV8fzfHBTsuuW/mUWqhkusplbPkv+NjRQGqBwQjQp5aKtTygk08B5
	 8DeIBaOBG6Qcg3HXiTaMmOj5Dsfg/Iq46893bDaXpcaI45QJwc52xgG9NUqWqfVQSAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784993;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0ZIzM/jXseF2ZQWdwlG46mJZav9UpUjy9ipp/LnhEBQ=;
	b=MgTL/Dqzn9JQ/HGNaVmPdIENO/H7dVVzme19XzwTRCLIywcIH10zUOlNlQEMQWdAD8va
	 YkVR6P1HUzqdj4ZUvOiQU+WZl0jpdjJdwhRXiLeqUnEL5UkZXLC44N7xhbMjXFxJOcI0U
	 +PvSa7NYe9HL80vDOLd9C1XsnxbM48ucYxLLnO1HpkNrlLCaHSuy+xlIoGbVhj+yOVrQg
	 68/C0/jAeaZIHsFZcpOsp0dwL5/PFt9PMuROMkiCCSz7+zfmC9NCqFFrGO59zM3TIgruC
	 7KaWGapUVihTzEFYGKHLs+SeO68quBDKwvsPCerLSmyipJIjwEVPNyZ480896xg8EvQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1690C1F00899;
	Fri, 27 Nov 2026 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795784993;
	bh=0ZIzM/jXseF2ZQWdwlG46mJZav9UpUjy9ipp/LnhEBQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jlOqZKSccZHT7qV4m3qonLKKhrtlclPbYU/DbV5BBtfWlb14BJheE3hAHDAT/htoI
	 vqmr0XsgT/bfhhCkAVkE4rmDOmAwUaxhB1BJaGTScZEnfQGzxsV6ACoKHPezEqXja5
	 7uUHuzpoPkjI5XhoO/CsQDlNOFGq9w/gOf+V4bixDyJsB9loPgpfj3eMalxIobo/Fl
	 ycuzIxP0BwRfwdk8xZJTZiwy1ypiniIxQJLuqzuXRUmWxM7RaCp/3Pwyq6gRAYMn5n
	 folUYhbpsL+0SYjdKlhJ8UZqKZ3tTZS8TTBgVBfaaaaUYtINElv+vmy4zZePIe+iat
	 T39RBRNx1tPVQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9C2614B7CB;
	Fri, 27 Nov 2026 13:09:43 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 21:09:29 +0800
Subject: [PATCH] clk: loongson1: Fix PLL bitfield definitions
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
Message-Id: <20261127-clk-loongson1-fix-v1-1-fccdb30ae60d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5GzCxuH1FPFSNGpRWWhBB/LvF4
 wzMPBAlqETosgeCXBrVuwSUZzBt1q2COicGLrgi4hqnY8fDe7dG7wgXvbE1hkfisjG2gtSdQZL
 +n/3wvh+gs2ZKYwAAAA==
X-Change-ID: 20261127-clk-loongson1-fix-9442b12384a6
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 stable@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795784978; l=4767;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=z6CT5ehMC3aRVWkMq6hQtWiXhaK42zNsoBh43sLGpGw=;
 b=mZWRGqP6O7oiRrrzYa3IaE5rfPbzUUIahiW54W2q1lOvthYiora6a+rACAgdSMMue/q1yYIv+
 ErZCqbLkIepC/F0F6uQ4fzr6NClge3xV1A4ibfqA2Mecn9Th/4FynP/
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
Content-Transfer-Encoding: 7bit

From: Keguang Zhang <keguang.zhang@gmail.com>

LS1X_CLK_PLL() expects the fractional field parameters before the
integer field parameters, but the LS1B and LS1C definitions are
written with the integer field first. In addition, ls1x_pll_rate_part()
builds the mask with GENMASK(shift + width, shift), treating width
as an inclusive upper bit rather than a field width.

As a result, the extracted fields do not match the register layout:

 - LS1B reads bits 5:0 as the fractional field and still selects
   bit 0 for the zero-width integer field, so bit 0 is counted
   twice. The PLL rate is over-reported when bit 0 is set.
 - LS1C extracts bits 24:16 and 16:8, i.e. two 9-bit fields
   overlapping at bit 16, instead of bits 23:16 and 15:8. The
   overlap and the extra bit 24 corrupt the PLL rate whenever
   those bits are set.

Describe the fields with explicit GENMASK() values and reorder the
LS1X_CLK_PLL() arguments to integer first and fractional second,
matching the original order of the LS1B and LS1C definitions and the
register layout.

Also make the field helper return 0 for an absent field instead of
relying on callers to skip it.

Fixes: fbdb1873656b ("clk: loongson1: Re-implement the clock driver")
Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/clk/clk-loongson1.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-loongson1.c b/drivers/clk/clk-loongson1.c
index 1674181a1107..5efb0bf6009f 100644
--- a/drivers/clk/clk-loongson1.c
+++ b/drivers/clk/clk-loongson1.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2012-2023 Keguang Zhang <keguang.zhang@gmail.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
 #include <linux/container_of.h>
@@ -25,10 +26,8 @@ static DEFINE_SPINLOCK(ls1x_clk_div_lock);
 struct ls1x_clk_pll_data {
 	u32 fixed;
 	u8 shift;
-	u8 int_shift;
-	u8 int_width;
-	u8 frac_shift;
-	u8 frac_width;
+	u32 int_field;
+	u32 frac_field;
 };
 
 struct ls1x_clk_div_data {
@@ -50,11 +49,9 @@ struct ls1x_clk {
 
 #define to_ls1x_clk(_hw) container_of(_hw, struct ls1x_clk, hw)
 
-static inline unsigned long ls1x_pll_rate_part(unsigned int val,
-					       unsigned int shift,
-					       unsigned int width)
+static inline u32 ls1x_pll_get_field(u32 val, u32 field)
 {
-	return (val & GENMASK(shift + width, shift)) >> shift;
+	return field ? (val & field) >> __ffs(field) : 0;
 }
 
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
@@ -66,9 +63,8 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 
 	val = readl(ls1x_clk->reg);
 	rate = d->fixed;
-	rate += ls1x_pll_rate_part(val, d->int_shift, d->int_width);
-	if (d->frac_width)
-		rate += ls1x_pll_rate_part(val, d->frac_shift, d->frac_width);
+	rate += ls1x_pll_get_field(val, d->int_field);
+	rate += ls1x_pll_get_field(val, d->frac_field);
 	rate *= parent_rate;
 	rate >>= d->shift;
 
@@ -149,17 +145,14 @@ static const struct clk_ops ls1x_clk_divider_ops = {
 	.set_rate = ls1x_divider_set_rate,
 };
 
-#define LS1X_CLK_PLL(_name, _offset, _fixed, _shift,			\
-		     f_shift, f_width, i_shift, i_width)		\
+#define LS1X_CLK_PLL(_name, _offset, _fixed, _shift, _i_field, _f_field) \
 struct ls1x_clk _name = {						\
 	.offset = (_offset),						\
 	.data = &(const struct ls1x_clk_pll_data) {			\
 		.fixed = (_fixed),					\
 		.shift = (_shift),					\
-		.int_shift = (i_shift),					\
-		.int_width = (i_width),					\
-		.frac_shift = (f_shift),				\
-		.frac_width = (f_width),				\
+		.int_field = (_i_field),				\
+		.frac_field = (_f_field),				\
 	},								\
 	.hw.init = &(const struct clk_init_data) {			\
 		.name = #_name,						\
@@ -195,7 +188,7 @@ struct ls1x_clk _name = {						\
 	},								\
 }
 
-static LS1X_CLK_PLL(ls1b_clk_pll, CLK_PLL_FREQ, 12, 1, 0, 5, 0, 0);
+static LS1X_CLK_PLL(ls1b_clk_pll, CLK_PLL_FREQ, 12, 1, GENMASK(5, 0), 0);
 static LS1X_CLK_DIV(ls1b_clk_cpu, &ls1b_clk_pll.hw, CLK_PLL_DIV,
 		    20, 4, NULL, 8, 0,
 		    CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST);
@@ -225,7 +218,7 @@ static const struct clk_div_table ls1c_ahb_div_table[] = {
 	[4] = { /* sentinel */ }
 };
 
-static LS1X_CLK_PLL(ls1c_clk_pll, CLK_PLL_FREQ, 0, 2, 8, 8, 16, 8);
+static LS1X_CLK_PLL(ls1c_clk_pll, CLK_PLL_FREQ, 0, 2, GENMASK(15, 8), GENMASK(23, 16));
 static LS1X_CLK_DIV(ls1c_clk_cpu, &ls1c_clk_pll.hw, CLK_PLL_DIV,
 		    8, 7, NULL, 0, 1,
 		    CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST);

---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261127-clk-loongson1-fix-9442b12384a6

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>


