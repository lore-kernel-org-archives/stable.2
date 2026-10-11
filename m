Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3D45FFC1
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748677; cv=none; b=T5lsdMqkMUhMM8cpUxvn+EKj8FzGeGfn4EI8xjg0c8Wjt+Q60u/6bGsC0T7iX+4VLWMsVKGY6fTzVTe/30wIhmnrO4GrOlaNb4qyi3BkthwEWtcrQFUlbW3C6srnyAi7YbMIQ/aqcy5YZcIArkwavF0U0TpH2MvOd/ncXqQ223o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748677; c=relaxed/simple;
	bh=9F9PqYLol8RYefMryvIE9X8WcFhHN+25KlDi07fHopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzDJ70xHIENGW/JUgM3n4CDnaPtAIFog1MrHkm1BZkoB5L2qwIsNA/Trb0uCLOhNSoiheyluFCL4/ec2oLAwX4VplQoH5vMaYKHn7NxgNmngz0QHKwE5YgpNxOnUkaoWyAdRtjxQNJuHqNpzVFodlC7odnGSVt1tpXZ4PSYqe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu6MxJgG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu6MxJgG"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso218585466b.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748672; x=1792353472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=gu6MxJgGhJ5fAuNey0baEcOvMpS/TXv1PMlzICuUjfuRcIWwg7oXnNfZbT2TBx+8oH
         zghvz02xttXd3lmZDw/J2j2tb2Tnx09itP7Hx8INrhakLgmg+MhFOXExPokaZo4pBaK/
         gvN+PlzsAbR/5z0JjcZRUb5rFA+UyZI4RbNUfVBHSm/oGlGtSFcJeJIHKjJXamzbj/Xn
         q9FLJMUiYdkWphP+YOUeamzsHFX7Cfd6dWZ2Jm66Ki51kGI5vWpdz/8rom54bV/j70CY
         r1Y674ahs10SCFMtmngXAhDdwDwwPga6G6N/x/8yduQA5bTv+XwAm3zPUPGpYJ2W1FLi
         ChCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748672; x=1792353472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=DbanDV+D1v/HPaO05zoFw2MuQKAsur8lx5tUfUlmB/FLWSanf6jOT66KnazVyDTUgL
         39cTC9u2MyESVI5mJyrIhtuTTkktl1WEUBTIiA3Koo+ZbnorKp30prLdgbSWxonnJgrY
         gA80fCnZETJWVVuHsKo8dIsv6JiT5wxR2/PU/E64gtKNPFYkUFUcP2JKhKpU0QYVHcCB
         nOEGvRuvWuZmcRue4jdMpx9B5Y38V0oJ/GSvKOgat1zmAOF65bnR/86JGF4d0+fk6d/j
         5p/FbyEYm55am1f/UoBmfWXolhIFZijjZUWultcbd1pwm8OfUy4ZS2aUAESasGR5EzT5
         HfRA==
X-Forwarded-Encrypted: i=1; AKwUvByxOdHvP6zyI+t6vcg2hYgs3niGcmc5KtIIrlJDVe9Pt27tvVJ6qUOMkp2BAxY9LqyXI+k86rM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPIC9qrIudrmkuP6apzM4M+AsNFAq3C9pBE9QJd+4rmxuW0k7T
	MeaFTRElLH8yg0bLEA3yOLImfOla2HsvRMHqEzxzG1Iso6NJ4r2Ctgmz
X-Gm-Gg: AYBFou1J84GZ1LX+3pWs42nj4vMPn8Adf2gkxtN6Bcd783L/49y5SwiSgSKHkiiTVSd
	lu2m2VFF3jMla2GX0Ff1fO3WcRjlkyJvPNb3P7uvLyxs01w76CsUj/1UECSiwVhBezEoL6eubQ3
	cZ3zHjdehUuZFR5WHsS7C4sk6iUy1QxLsD+yZDF7QnWzmpLSRM8LTHkazP+3pa5YjjITkXMcLml
	1mgo732SpqIrTzmLMcjJqeiy9IZxTGteqNEZluN6RpqZYoL8/s2IbHwaIz7/QWFGSeBr5aOdSo/
	eEh1W3nRXXsnS0UpGrFfn0XPY1TjPkU+AAIQMO820lB9MvgM8IH7aWY59v1EPKItQqphf+ZQpMQ
	kRaHftfSTPhp8CfY3yNtXmEDbUgHchfMy87PliZMqy+DSxwoQDw94a1U/o+2zBQu2iEDX3nqk3/
	Bv+3KYI1zeljQ4jIHtY+WHZKnIcaCcVTQdaH9v1MlivwW5hqlwGtayaSsFelZ69hQ6vo4IB2RqF
	rxZ4qxCSDDwtuGGPbiVbbrBTOmVm/nht9b17BpS
X-Received: by 2002:a17:907:7fab:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c31a9f6b728mr805802966b.33.1791748671740;
        Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/6] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Sun, 11 Oct 2026 21:55:55 +0200
Message-ID: <20261011195729.981243-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0

