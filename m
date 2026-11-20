Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177011;
	b=D5w/yMstuRdbehco2et3xNYFdpIFHyCU3RZhEIo4lZiWo6ZHSBzBqgP0b1pj0uS13P4z
	 y6yvs9P1OBZp29wq8OJeGKPLp9awJtifbLoX3k2piRS9eSmuiNohnGtckd+M4nZ88qYWq
	 BnseMYPbFxjD7sePrmnT0RG5zPOKhxw0GgJdYx9O9Zv6JoxQKy8pgfoNSQJD8ym9++Bac
	 deYPnPAEyJDXK+222/rIRH+4HqplP7DKCjXYnbEgDTn5fB4XLer6jc8jE/sPeeVpFNBlw
	 re2nZ5ViQUpQZ/7+2abf397JP8wxNJqLH61+I7b2My2IoNN7KMSkYOEHgBCrdPY/cew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177011;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PSxLr1HHsETskvI6VvCsOfwe2CKjdeVgSnc6fyenuSA=;
	b=jNnHWUJMZCjsxqcb9uUroW3wEZtZe+lVhp1BU2BdiuL1zsjxdoBSVqbZOxugve37s3w6
	 fIS4qSFRC4uZA84YMwXm2+TnMvzNk2hVLhVTKF09hUJGOmh21+f/uOu3fttNOTTBImaQ/
	 OPPIjovJrS4hnybU1jkA+p7P2nPQ0SnVgLyR4PdOLB1frV5kIGUwBo0pnCPIHZ2SR6wu+
	 9cT9MJN0inUBkUSG88eZ9BtcUfRr+cDUdrZv8YTjZFXTd5zHahbJEqPAiSr53aC7PytfN
	 qNYvdvOG31egWz5TVApagFHJXnCLuxRGiAndPZrSreao/8/ZakfJl7jDMYoiv1ar01Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ew7t0BiM;
	arc=none smtp.remote-ip=91.218.175.93
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1688606A334
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1688606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ew7t0BiM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8XiXryHIULlaN/y2rMXAN7tXMcBUgoQa55KwIlOF3YQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795177008; v=1; x=1795781808;
 b=Ew7t0BiMr3e7CVmdSlurASVTZhKw1/jT/GA3R/abcw65m0Z+SuR+peAbPzIMnEzsqXjh7HZV
 Ozo/C2SWRz+SAS+NAZ8L+dZ27G5so1ghoVYUa1jPuYKd8sPaOQyFR9iLUfoFTchFMEdImD+sXiR
 eGbs+VozdluDtnHCmM4UrXPs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3526d582d4043ac;
	Fri, 20 Nov 2026 12:16:48 +0000
X-Mizu-Trace-ID: b3526d582d4043ac
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] arm64: pi: Add an ISB after mapping the FDT in the initial ID map
Date: Fri, 20 Nov 2026 12:16:36 +0000
Message-ID: <20261120121638.194154-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120121638.194154-1-fuad.tabba@linux.dev>
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
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

map_fdt() maps the FDT into the live initial ID map with only a DSB
before the caller reads it, so the read can fault on a translation made
speculatively before the mapping was written. This early in boot,
VBAR_EL1 doesn't yet point at the kernel's vectors, and the kernel fails
to boot.

Add an ISB after the DSB.

Fixes: 84b04d3e6bdbc ("arm64: kernel: Create initial ID map from C code")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kernel/pi/map_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index fb44cbdd2f292..f9338257adb7d 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -211,6 +211,7 @@ static void *__init map_fdt(phys_addr_t fdt)
 		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL,
 		  (pte_t *)init_idmap_pg_dir, false, 0);
 	dsb(ishst);
+	isb();
 
 	return (void *)fdt;
 }
-- 
2.47.3

