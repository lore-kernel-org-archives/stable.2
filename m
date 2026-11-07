Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061024;
	b=oRtCMU4wCIe1oHwcCl+RgYSDrutgSPmpohNBYLax1anhzI7TPiSwm2scQOTO/pvIMlgG
	 TEbht+7UK2S1etDLNoe+sUMo3btdlwIP/NrWjWbMbbzwNI9XLoF0X/wh6Bt96l5ocgbG2
	 ABx8TdkrNcAjAOoPw8XqMpVAEtCBK+1W7Hrd/yG0nBIPbUe6uyzen+2maRSeGcdI51gDJ
	 4Pql2dA3wBRhgPJxNu6ExmsYeL6Efd0c/ywQkuSnPnmLJfGQy6SdMQJKnNdTWiw0ntOr8
	 J86yTCyUYehIket655nK4d/De+fyAtDcgqND0+FBc88Ffbs2xc20hWX/OjTGQkZEXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k4iR2mxvWylquEU8KA26nu8fMGWnTyCNi3UU2qV/4iM=;
	b=dcqhBeh+siRIrMlgs4aLMTGfRCqIZm2s9/iaSV/6ocs1nKrf/VdT0/SQvRpzvlGHfRzu
	 66eKt8SrC/y4im6SOBOIJNTXTYV5FCKMvvGZnMOUj5XXSPQAwkwIcCAjfKNJX/CQUZFwU
	 kyPW24H2GKcmgcVL4sGNtiFsM5BtIwreiv5zw3hzKwOhOVVV3M1HPGllUNauTYyjrwuDh
	 LrBlm2g07hsuTH28Qr9H8519Jrv+Af9ff14ouLiyqJjsT5Y0DQSbbS7A8aEeCe9m9RL+Y
	 zZO/xLE+xwK3kROdqhU2OB3yg+FZECgaZi1f9obUPHXdev4uq5fI9UoQEPswqBB5uCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spJmWW1D;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2BF606EEAF
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B2BF606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spJmWW1D
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4918c2d727fso800550f8f.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061022; x=1794665822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4iR2mxvWylquEU8KA26nu8fMGWnTyCNi3UU2qV/4iM=;
        b=spJmWW1DG/s9aBUdyknjvArDN1C7HK3wilbX6HsamxUKI1TPKaGT+fvPA3YEBcU+J4
         FYYcjbkOxXtoIz0aVm4kNd2hty5aYd72+naHj5mbYCVrw1pFCOZmf46gp7xFdmTAsJQw
         xm3q4RZQe7xX3qdih2ORvsRMONrTCE0Q8GgFDRyLfl6wTuuiFOeIOJpyMdpSDCSiUgmG
         s3oKpCaBTda7U8LvAjJpzRLK1LNlWMDmxxX78xSZmQMrbjb87ZXM3y5Xgy/Ci20pjw91
         pN7WvI3uqPC7qcWqUf2VFypN9l8+JT9oVDb6H1HONlZ8vJzSoaCllwb/LA/QGVR+5/CD
         b5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061022; x=1794665822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k4iR2mxvWylquEU8KA26nu8fMGWnTyCNi3UU2qV/4iM=;
        b=XHLOv5k9/sRerkvrxvOsOHjXp0yEOzA4/SDkiMs43uSn3qejjnhMdGgStBbu2FwfI1
         EFT2vAxEOOe8YiTtAbQweW4kAh133mLvTxlDLRG6i6wvoYmuF5WwlHKeN4IFm2BWL7Sc
         8WTCEYdFH2Ry+XMrBUPrEn4XB+ou8d5kPd832fIoUligwn5xVlNdTQn1a2TyV8eUfsSw
         juAvkMVgHf6akkjTA+CiHSkKdo8zidYA1hCEJkJ+/Gpcf6K4j40SAosAYgrIcuYVl/6R
         zPEDqxM/hzQilSytBRXic+eP524nBdtMNBiiRoKD+GAfOAa83eSibbB4O4u4YdE1aCqA
         77kw==
X-Gm-Message-State: APuU4Z91u/qn3mKvHe6Dxl4QVG/6GoZXPAMTtsv04fXemdmHChhjGam7
	sjNoRFekgyvlyo0qD3U89odR+D9kgXduLXcU/UXHsQBCaEFXjPJHyitH8JVWzN3umXM=
X-Gm-Gg: AYBFou22X+ihlM7ON4+PgcQD/WahmjlDvPYSP19zvIEap45pEUczQuTABxgw0RL7XuU
	05gYVaSxwHfhAX1+Umzma4bWi9V7VxIDdeg4CKkPlUGe0nZzk9Vf7LLF9QVp5k/XW1CCLmNT+EL
	74urg8hLnu3EoXRtzV+19uKTxWHUzD1NxR9dwu8m+TcjShm7AWNJ7wKRprrqQgtPgPj0GncvW1m
	/8y4w+jxT//7gOP/oRWqnPDPE81+w5+jRQnS9WLe1T2fG8Y488uxhMRV49rIS0JDUKGms+0CXol
	LdOWeVKtfuw7Ee7YZ125J4lzY1pYRqSXFSyXq6mCA6fqPf7Mcs05/4M1T/cKscb8IapmriATPWH
	4NbRq+ZYxudP0mUZdVsdwLQVPDwBNyCBDk264Ao7v1SwyLYSvAmhAkUeFK58fcwsJRg+cQvgw+O
	tvng7qw2ZzaGuAspVqhSzR2+0yn7O79Q40pN5YPCSqbEbCuLlf1NZ2aQy6sAmjLx4i1qpoFa2Kb
	65J7qaVlB350Quv84WSm0RkBkf3w1EO/99gXSC6/3o+yYQpbdU0nf4tys+4MwTsSfichQqmXVWk
	seODMfpm5yXX2Xh9CdF0r3DZKqOr3u3cUxz8Bpow+3wfeOozzgIa8+Idgr2Zc+PCAwr9NJzJ37U
	3LqgD2Ymwo5arNXN1Mscg8AgA6g==
X-Received: by 2002:a5d:5d08:0:b0:48d:fdd0:6ce8 with SMTP id ffacd0b85a97d-49272c2779dmr13644166f8f.3.1794061022422;
        Sat, 07 Nov 2026 06:17:02 -0800 (PST)
Received: from corered.localdomain (p200300eca7315efc6acddbf2c21e6b03.dip0.t-ipconnect.de. [2003:ec:a731:5efc:6acd:dbf2:c21e:6b03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723320csm9111983f8f.26.2026.11.07.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:17:02 -0800 (PST)
From: Andreas Wild <andiwild@gmail.com>
To: stable@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Andreas Wild <andiwild@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.6.y] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Sat,  7 Nov 2026 15:16:49 +0100
Message-ID: <20261107141649.384711-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107052930-failed-6.6-ff8a969f7dc8@kernel.org>
References: <20261107052930-failed-6.6-ff8a969f7dc8@kernel.org>
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

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
failed link retraining") the Target Speed quirk lifts a firmware-imposed
2.5GT/s restriction on any downstream port, without checking whether the
link is up.  Where nothing is plugged in, the retraining that follows can
never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
quirk makes two of them -- the initial one and the restore on the error
path -- adding a fixed 2 s to every boot.

On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
slot, running v7.2-rc5:

  0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
  1.541 pci 0000:00:1c.0: retraining failed
  2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400

Where the Link Speed has already been clamped at 2.5GT/s and no link has
been established there is nothing worth doing, which is what the kerneldoc
for the quirk already describes: the restriction is to be lifted where
firmware arranged it "and the port reports its link already being up".
Bail out early in that case, before either the ASM2824 workaround or the
removal of the restriction is considered.

Ports whose link is up are unaffected, and so is the ASM2824 workaround,
which is reached with the Target Link Speed not clamped.

With this applied the quirk returns without touching the port: both
messages are gone, enumeration proceeds from 0000:00:1c.0 to 0000:00:1c.2
in 1 ms rather than 2 s, and the systemd "kernel" boot phase goes from
3.011 s to 1.036 s.

Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
Reported-by: Andreas Wild <andiwild@gmail.com>
Closes: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221801
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Andreas Wild <andiwild@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Andreas Wild <andiwild@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260801201244.4421-1-andiwild@gmail.com
(cherry picked from commit ff8a969f7dc8e79ea6113abcfa983e070b2b585a)
[ Andreas: this tree predates pcie_lbms_seen() and pcie_set_target_speed()
  and still tests LBMS and DLLLA in one expression, so the hunk did not
  apply.  Split that test the same way as upstream and compare the
  LNKCTL2 Target Link Speed field against PCI_EXP_LNKCTL2_TLS_2_5GT
  directly, as the existing code further down already does. ]
Signed-off-by: Andreas Wild <andiwild@gmail.com>
---

Notes:
    Boot-tested on v6.6.162 on the MSI PRO Z690-A WIFI DDR4 from the report (empty
    x1 slot at 0000:00:1c.0), cold boots: without this patch both messages appear
    and enumeration from 00:1c.0 to 00:1c.2 takes 2.005 s; with it neither message
    appears, the step takes 0.001 s, and the systemd "kernel" phase drops from
    3.070 s to 1.085 s.  The other 22 PCI devices enumerate as before.

 drivers/pci/quirks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 027f26035..9bfa99e2b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -93,8 +93,12 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	oldlnkctl2 = lnkctl2;
-	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
-	    PCI_EXP_LNKSTA_LBMS) {
+	if (lnksta & PCI_EXP_LNKSTA_DLLLA) {
+		;
+	} else if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) ==
+		   PCI_EXP_LNKCTL2_TLS_2_5GT) {
+		return ret;
+	} else if (lnksta & PCI_EXP_LNKSTA_LBMS) {
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-- 
2.56.0

