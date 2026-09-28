Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62001E260C;
	Mon, 28 Sep 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613900; cv=none; b=eZ4Ga32lvZDIRbXtUqDs9t3YL2qqdqXGF2JneJFEQqeYX4gcYU2qnVdA91o4tvh4DMP3MyPqiRGHFDuUzVfERSYTGv8jeEqZqKdIAYZqE0X6oUg1e1hvjb6lCvNyBNZtfQOo+mbezdrDFkttD44G9eayyWcYus7+zE6YyubRsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613900; c=relaxed/simple;
	bh=v8iuk/d6hY4fm9sab6tZFLMo8YMgI5+6z4JDgU9D7Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2bbZu76POJBNHDCE+FSIRxfa1J8xX8R210UGTFkKBdeCBqti7qzaLwOEMgbxPnBsVYtZw2JIfwa/FH7gxypHNCXRj6km52KrPk62D6pLa9jErrY5zuMx2TAF8ffhISGu791UAvRnNmvLwsKkTFUUEdyphbHpo6e6hFVrrB7Esw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=JaW8HApV; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="JaW8HApV"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNo080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:50 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=lRFP5ukTvB5ywCx1qtpi0Y4ncEtE/ZOaMkomeF4W5n8=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613890; v=1;
        b=JaW8HApV8TyKz48SVnCnAVBnIYZ+rq4EKwJrzppjaxNqb6uGXbmzkChxTQfXO/mI
         8K5pKncE3jDgD+WS3igYlAQ2cPKzq8iAXTKwngkxq47CfWP7o6qk4GnqyHtaBuOc
         Rv9O6hT8JDelgIQqp6tC9Aw9Kd2WzYfv3hlj838DOd21tCFVCStENIkN6IWnaR+6
         gz48SFxy9wqz5VYCtu6Pl5lz0KWi8DNM6YiyXpHpT4cfkRaZZkoRJ5+loA4EfoqG
         Du4U/IuD0u16dp4/VaBtpMW8BluXGbHKsj0HYAz+TcxAfpJW82syfmsuY+2df7Tl
         RqoLZwqwHthIyQmDlLTFEw==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 03/11] KVM: MMU: update comment on the number of page role combinations
Date: Tue, 29 Sep 2026 01:44:19 +0900
Message-ID: <20260928164427.4699-4-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

commit dc1ce45575b3401102568dd60ba8894849d1d64b upstream.

Fix the number of bits in the role, and simplify the explanation of
why several bits or combinations of bits are redundant.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/include/asm/kvm_host.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 710c9c87cdf2..2c378064a1db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -292,19 +292,25 @@ struct kvm_kernel_irq_routing_entry;
  * the number of unique SPs that can theoretically be created is 2^n, where n
  * is the number of bits that are used to compute the role.
  *
- * But, even though there are 18 bits in the mask below, not all combinations
- * of modes and flags are possible.  The maximum number of possible upper-level
- * shadow pages for a single gfn is in the neighborhood of 2^13.
+ * But, even though there are 19 bits in the mask below, not all combinations
+ * of modes and flags are possible:
  *
- *   - invalid shadow pages are not accounted.
- *   - level is effectively limited to four combinations, not 16 as the number
- *     bits would imply, as 4k SPs are not tracked (allowed to go unsync).
- *   - level is effectively unused for non-PAE paging because there is exactly
- *     one upper level (see 4k SP exception above).
- *   - quadrant is used only for non-PAE paging and is exclusive with
- *     gpte_is_8_bytes.
- *   - execonly and ad_disabled are used only for nested EPT, which makes it
- *     exclusive with quadrant.
+ *   - invalid shadow pages are not accounted, so the bits are effectively 18
+ *
+ *   - quadrant will only be used if gpte_is_8_bytes=0 (non-PAE paging);
+ *     execonly and ad_disabled are only used for nested EPT which has
+ *     gpte_is_8_bytes=1.  Therefore, 2 bits are always unused.
+ *
+ *   - the 4 bits of level are effectively limited to the values 2/3/4/5,
+ *     as 4k SPs are not tracked (allowed to go unsync).  In addition non-PAE
+ *     paging has exactly one upper level, making level completely redundant
+ *     when gpte_is_8_bytes=0.
+ *
+ *   - on top of this, smep_andnot_wp and smap_andnot_wp are only set if
+ *     cr0_wp=0, therefore these three bits only give rise to 5 possibilities.
+ *
+ * Therefore, the maximum number of possible upper-level shadow pages for a
+ * single gfn is a bit less than 2^13.
  */
 union kvm_mmu_page_role {
 	u32 word;
-- 
2.53.0

