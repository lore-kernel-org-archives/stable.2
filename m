Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73A38F253
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436403; cv=none; b=fyK0CWIwzoTQMQ2NFs8KMYMId4f4BHNOzoSA0V0kKwTV2dtrjp4bK1UMNQ9guU1gfiWPsCft8PGgsuXfyzSeAA/P8cr9yniPhv8E+1GzyPvl9oCMCVYHRTV/SMYQq4rkG3wmRXy9r5gKAmARDeiUdtEZEVlUPw5V2DT1nPldhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436403; c=relaxed/simple;
	bh=eegAhnVrUCevIMwR4a8J4nvt5iV1r65jSQgaC+VQDZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaHC5WDrl7fp49oGLhCLixuO+cQX6Mhp6ASpc8cYndLXcD39suR8LrF+So65byG8NDvEjE1IkZIXJxqJ9BJG4BCtCbacD52HA70+lu9ZTuhIrb6K3AX+P5yI7XUDI/OSwqgBu8+uw3lAsd0bhIuL4y/1d1Aod7kpGtSQtUV5b6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIDy+PAN; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIDy+PAN"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so41743396d6.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436401; x=1790041201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzOO1UKhv3FRQXtJhYy1irle0OACEUNuvCoqDtGq3w4=;
        b=LIDy+PAN+gq12MmwDXOgaoHwaiechq6I4ljijJdC9+t2VAl4pOGUCj1AYFXLd8MD+e
         V0YkCCLEfH60fH+xDQcIc+9KeEF7zHniTj7AcXlufkJnFZ7fPCAvTRhHCpbzwbGOPg4O
         Hbqmpzuxb34KuMEM0XwPraDnJ9oD1j3tU+VwOuuqkPHprcnvFaKHbAIpQCWpvEEkv2xy
         RkFtdPqpum7uE/7RXeKR9/+cKQE9PP+ySzmTgLANZhtfACrZvXlYdzf5935/xXYvvbuv
         FjlpCr1rDk9pOKQoYdD7fUKnwxN8MiZV4nDYPwpyk4VmL1/mwnDOPI7kJ3PGNeM7TYIM
         mjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436401; x=1790041201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzOO1UKhv3FRQXtJhYy1irle0OACEUNuvCoqDtGq3w4=;
        b=QtEK22KMeoQrggpZRxeArEfW9Iw2wJsgFCz6t8SSiwcF0+jxwPqBoBTI5VvRh01TZ2
         OoNwP2Lk8vibGG7fdOaogQwOcpUizwf5sM/sqeY2WUTOgbv/XjBpwO6KR9RifLVd+oEe
         bwodUkrF5dKjh759YiDdP1dt/B3itnI3aCx5+M2d11k8FoEFk3VyCyhSP3wosky5Vyvf
         +SDnNWAt+Xe9RxNwsWIzYULoR5MHr2s+5sBgZwdoBzLE6YQJzBFD5VVItw5XkHPaluIM
         PhIicdUiGKbts+V2ij3InhbsAbwVvyOjcyVxGFMO9jEzlwvd819g4Fe7WfDXg3mXAPtp
         ROkg==
X-Forwarded-Encrypted: i=1; AKwUvByGZnnPPNdnfFKdF4od85q7gfOenSb9QM0l31MjkOZU9v7a2lnKjIjNBdnwLPXJZmicTn1yJrI=@vger.kernel.org
X-Gm-Message-State: AFuF++kmjZO56sPtRq+92C/LHyQV+lOWerVNo+hWJDxFYffEYOys67bP
	Qvd1k5VPVs4rMrsptXIUpubE0dpK7WKB89w6tIBmFCmPoE0Y1UdvPf0=
X-Gm-Gg: AYBFou3GC/pYNpgp1yIFoIHSmWHoHleTdBUhQ8nLVQ0EKY/t4xZeq1XFZPawdlM6qVv
	Zy3MgI9hbeKuDA/xE4F7Ug6f5VmLCsUTm2l2HR1MBinadK7njz/90nuqsM5TBwxGGZ1aidmDxZR
	7ApSd5Or7QggaKGzW8xVF4VJWfqd8prShc2lGoCYpOqDWmo753tQ9ohAVremcnRLEB8S7sKCVR1
	mkUaIJlOMJIZBO3fq3XCTL09OPjIJXbl0C8he64NwS9bbJX8elT8LfHr0zbP1PuAeFKQv74LM7a
	ybxNqbGlxtO4d+dD8dCF6TGZItoGuasQ94PJuP/tqGT7bLGzkq+HXlOA59agEFIF5Up3h1XwZ30
	UgfxSQ0YB4S92Ti8yBpHJS0tGmOPJfgcIGCWByFTuI7Hx9UDznO2oK3CJvIru+OOTaU2NZ/hWor
	vpvE4tavUtfYO2azQ2C6nzdEBjNvPm2DuUhyzFb4cu69joNBi1EWvhs+1DQ9q5h5lwp2d0RkAwm
	Xp2ua8DDsxNqkCAnhaUqQBpuqu9CmydL8o0p0OQL/uo+hyVAcPEKXz00lF5x/tAHhbtNihAKFgq
	eLNykEPUPpIeYKXk7ihCzdLqyqeA51NEudG2O/Z7pYTFjLam3CPiL456CNcPS2DEeXK47A==
X-Received: by 2002:a05:6214:e88:b0:912:1fca:531d with SMTP id 6a1803df08f44-9122e4cf515mr93110326d6.2.1789436396274;
        Mon, 14 Sep 2026 18:39:56 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4787eesm108637906d6.21.2026.09.14.18.39.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:39:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: arcnet: com20020-pci: balance PCI enable on cleanup
Date: Mon, 14 Sep 2026 21:39:46 -0400
Message-ID: <20260915013946.73963-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915013946.73963-1-mhun512@gmail.com>
References: <20260915013946.73963-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

com20020pci_probe() enables the PCI device, but neither its later failure
paths nor com20020pci_remove() release the enable reference. This
imbalance already exists in the initial Git import.

Use pcim_enable_device() so PCI is disabled after channel cleanup and
after managed LEDs and I/O regions have been released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Depends on patch 1/2 to tear down registered channels before managed
PCI cleanup disables the device on probe failure.

 drivers/net/arcnet/com20020-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -133,7 +133,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 	ret = 0;
 
-	if (pci_enable_device(pdev))
+	if (pcim_enable_device(pdev))
 		return -EIO;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct com20020_priv),
