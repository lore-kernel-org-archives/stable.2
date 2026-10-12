Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788B3B0587
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830932; cv=none; b=E4VDSpOvpnfF9JLDUCeQgzirySLgpcvgwwzkNqObtSzBHeNHn8yc+uimfI8jzQeDmv/Tujk0QHtt/9m/4NLgZ6ocelx/PzcxEqXmYQfEgw6XYdPkGrcEhxdpsDTuM+IkqYDPj8oTxEzW3SzANfzTYAiEIOTV7Y+y19/jBMWnO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830932; c=relaxed/simple;
	bh=lHqcE6L/05Y5Gh1t1RuDhITcXofphAcppq5EmdQFuLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAx9iTQSa36fKCpzx+YcXyPufIwptxVYR4qgXZu9Bnkp3cJzEt3q2EY8LFPZWuRBcr0kW8ilP2+JpO+nsWnqvnHiXI5Gy/YfDXlkOCg4arz7DIQ4D3RLsZLrzO9PEVfj3KlV+IZbDKSkVlZofUH7zW5nGCykldZ0dE5us2aUsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvuY6mhq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvuY6mhq"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e3846d1caso369447266b.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830929; x=1792435729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=EvuY6mhqmnypJ0n2Q2Fp++Ax9En4JybsvGIqnkiTt8bUda9JnoUgoEunpGUnUWIyQm
         7uhsxchtkzG2euYZly+A0xSeDs31XF6WBW2z8TaXC8IyS6bqcbvYdYoqQkLjnG2llp0M
         NmHazujB73v6dFUUFMZB8ebT1p9uQPe3D1oQ2efn0dE8cnHytpKz8IMhH6XjfBg+yUjT
         c99Ccu+hHpeMoK/LXmR/4NTIcrToEjNqnFa5e33Jhd9EyEN+/2VX+3gmwCD73XWF99bW
         VLEc6dv8UBfziVMiLqjed/UM3sSD38GghhQxxQM3vdd7gZB2o/FECwgM/vVbIEf5FQEB
         af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830929; x=1792435729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=LrUWy3ulLZZ601yUEXIvkz+CnNWfEHjgIqTHKdg3Rsg+3BFbesjW5PgxKDVBKesWa3
         OaRFicXnsKz+U9MpVD46u+Kvx9mI6/U6qjCYPf3juIfXAUmgjTEvS/UTrxbOJYT3Kz2R
         BRr9DmjXupnYF9rdNWLLRGeZq3I3i4F3KJj1JvJUhsF7E1H3nbCmbjtysuX3OxsiCf6P
         T9ukiTvUXBLSytGB0sBPti9RPx2h7S3IWAf8apoCJ4EjQ/3Etdc/DzcXQs2HRUHYhNHZ
         FZenRUxPZuYnYODgLQu27DHJd3UPlJihBuJBEbsFe7gF+cnXRzHRXEK+rysfovjss28O
         Wpgg==
X-Forwarded-Encrypted: i=1; AKwUvBwqVBtuuVZxMlTVnYNQR4BBoctonPqT6WRlN4GmSgobYXtihzx0l4sCSqGeOM9IZDDcJ+rn2Bg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeDYDN7P5TUyuI+yJH20L+jxUgIjZKIFKI7ONHU78Nti4sXyn1
	TNQ6DEdZmHaLAiT4jnPMgFnPpNbfPNQRUk0uymwHGAP8dLIH5SYVyQHM
X-Gm-Gg: AYBFou0s1FhiRuZNgX8/x0q9Sh2CxeR0EgYgigHq9xM3yvrgavtIQsHlsw3QvE006Yw
	E4KX94WyCxostaUbjaydBJG5cnnTZu8XvFY+J/Cktv+QJMOqh7JRbRCUXQm8sU07ILjKscmQ9ED
	owdV1HiK8l8QEKtD+fXRS5rT1/uFYmOG0LVRZXxf3Qr+ebuKFTt2l6LOhlH16JN4XuoYwsb/gjO
	oeHoQ9ZeCcj3U71eo1g3qIN0hLdIsPqRHz1hrVyUD9HEJu5ma+4IzNhg0Q3SsVUfzL3YL0d2ykS
	YIOU0FtJewLhi+Umlv0QXN+RVaIsMxAyfTkiOUROUKeHCilLspCcdkKqlZbA3b5/dTwGFsN+0k8
	ht4DB8Hx/Jqn2gLxL1X2doutK8hljeZkUnSqB07LcMFyPisVirotDyZZJF/JU5AcaiYAMcs4stP
	3y7BNkHah2OkCSyk4bNCh7+5lYjI2loXviOQ3B4X81Kmngm0a8xYQWckGNOqLTxRCjxroOmyuCL
	bNl4bb4ZhrCVh7G2al0qk2iXx0ic4Tp0woalbr1cBV8u7ElmYbF
X-Received: by 2002:a17:907:3e0d:b0:c2e:80b0:deb3 with SMTP id a640c23a62f3a-c31a9a10e74mr1102093566b.7.1791830928881;
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
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
Subject: [PATCH v3 3/8] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Mon, 12 Oct 2026 20:48:04 +0200
Message-ID: <20261012184826.986050-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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
 
