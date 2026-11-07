Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060997;
	b=4+WIqQ4JUB8yGVdOT5/VX3moI5xv3kzQuO4jRYxiLQLuKnl8MTrSEEGPEwyJFCfMPKyA
	 4MDREFc7uaMhKi9CB6dz0Eo9AO7FzZ3k0nXmwAsCJDk5eapCm5kE7IyZQNsrBFkZarSQG
	 L10P+zJ0hHNbULsuVoDeg/CJnVG4eogDqV5aYv3okuw29cEq9u/0wK6Ka/GSa5/GUlZ5U
	 8Y83xK2+DRIAH1RHsq29jCR8u1IlWn22HUfJ/VzBPxJ03YYF4AobZdBWfbBsqmt4quBMG
	 bqEDDKW6lU4k9dAPSi7/jOZOJctdOABIgRFvYigFWNVEiOUW0dpLCeywbuSsz2OJpLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0LuoVKAjLq+hb784u7RGab9yGpRw6YnS9FlKLABseiI=;
	b=lRAU146BLhqNC5XLdwNFRhbWUFjlxmLqWj5Ccyz832vkzMDLsXYO+/mJ76iF/sDI8b94
	 CY18ri/mkagvagx7D78eDjKW4RpMsGJqYVBmMjJdN1dqfw1LtVKi775Dk9dYYW9nY0ZcG
	 +8GamMxSG8+umQZrLxe5wxGk9E8fWH1CuHlny9dWulbyGjnCf4IJlphJcHbL2HnJuUHOa
	 ZUjouAy9zCZZZfVQlhZklvwx0Lkh7H+B2F+CtMybFoFy0dG7nZl0G52Uf1sYwL96L+Q6m
	 8BZbW11fyjYvX7enq+pxxMXQC63a6btm9751OMZH0CdnMVOLBu4/mO2sAKhjWsU42DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0blTck8O;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E58606D821
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E58606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0blTck8O
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4922523d1afso862283f8f.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060987; x=1794665787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0LuoVKAjLq+hb784u7RGab9yGpRw6YnS9FlKLABseiI=;
        b=0blTck8Ock6CNtoBg7HYduEHT2DXKfYoCFTZ9g6pYgC3whPHf+OT4jvw/nVDNYC/Lf
         BwblrXHS/EP9yq3iGIEI0AnbW4U+wlEz+PM3wRgGbBFaitwIWO0IRmNLAgD4j4It3n08
         dP47eaVR2PplTrlUZevvHirVRY68GXPffHDEgDuCNFKWoL77VY4fY28G1IWSfIUBRXdm
         QhKvgDWC4d0J3LGBkJUrFz+PYzIiHs4vIHTSfRUH98suD4QKuzXx5/zQ8J1/ZLqa9ahx
         ZZVK+nbDz3ce2sRSxGxQu/53C1xWV0vVyQNWA29UjnL9R1Cum53K0xwVbSNANqzwnXXX
         Vu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060987; x=1794665787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0LuoVKAjLq+hb784u7RGab9yGpRw6YnS9FlKLABseiI=;
        b=lYRmL0PymTr2LHqPdEcf2J0ec7TGLgGyRd5cLZWTQrQ6WPhjCUNB/ZNG3MZBkQqMPc
         29uUXXE9e7rILELxQwImLTIdKi+shbMAnwD/90D5LhZqH8B9UkG2d7tZRutOmwtbLbiI
         A0GWaB74pPO1KhcDCGwac46Sq3m3Rn1JkjsMSBYCQBIv19tY7b7N2V9XPtBB2NwE8FSi
         ZaEtCX1icGUm94Xw3yCZGZe3PV4j/JibkNBEzUqqD/q+BzlqDYy1A8JRbGF57lfMRqCR
         ydlHxsVJGuRm5KspRXAsZE1xOZXClGlV/nOSaXOI/4k3ikRrQ0n3ZetrRrvlXr6Om59X
         kWkw==
X-Gm-Message-State: APuU4Z8pwxJqOb9pgQzKGi5nOFFwUxC9xZ9PPqU8q1J2CHFZ5tel5CMS
	WmncGY2k7G4qHeiOmocdtq9jFdnR2H6FjglPBsl+kcu9/hfkzy+irGzePs5Q4Xmu+a0=
X-Gm-Gg: AYBFou3noj3IhYzcVePn9hTgKp3fxALA8gUkjDnjp19gtOFnkjIlHwEAeGoUV68TsJC
	SQHTZuiuf7WfBwc+fxONQ8sXpU0WuOvRC4YL5gcu2kkxVMzMNoRoKryhZI1AkY0XKuwdUan4fdL
	Xz6F/v4ZVd6lsb1SlKsdGCSqbt0hYAYCrR7GCg5Cf/Y10mKr/NDEwml5jtFisfAOi9EFGLj8OVO
	MMvgpro6YfKEH6OYvT+1hoCCnwMPpa2R56VNLYc6erdhaNVuXvvUYMam79XI70HGuv+X4CHVXb+
	JkBn4acH4BcE9bpq8a3URS9/7e5/94tHamKIknQB8goljA9yunPu6q6NMA47AH+IuZfP069L1fx
	dTpsYM6tb7ilZ0fpKELUZSun6bpZ3QVgtIZ8ZAxLG/kmyXpyI+dqbTFMd9n30pdQJeJPKOQBu5S
	RukENlv7lMOfWer93AQpWTx78wu9Tc1HbI6FXYjPuUOiWjBMBnlptqTLCLkjnFr7Xe/62CD3ENS
	FqGETxNANoPu5w2OWhrKOBdCMpZxzW7llTpG1HK58WdjAddLX1CRUXcY9+pIbBsOEEC3tZNaxEF
	K2rnqzHFqR8Qb0kJyYNRtzGZKMgg6ZE+MpCIXYkag0/sva3uGaKnCDKIuo9FQezmgzbaGiwadEc
	vQD4nZTt5hN6w3j7mK6c0+9KXpg==
X-Received: by 2002:a05:6000:15da:b0:487:40d:af29 with SMTP id ffacd0b85a97d-492778d1b34mr7644618f8f.36.1794060986980;
        Sat, 07 Nov 2026 06:16:26 -0800 (PST)
Received: from corered.localdomain (p200300eca7315efc6acddbf2c21e6b03.dip0.t-ipconnect.de. [2003:ec:a731:5efc:6acd:dbf2:c21e:6b03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d770248esm10138501f8f.42.2026.11.07.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:16:26 -0800 (PST)
From: Andreas Wild <andiwild@gmail.com>
To: stable@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Andreas Wild <andiwild@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.12.y] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Sat,  7 Nov 2026 15:16:18 +0100
Message-ID: <20261107141618.384584-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107051712-failed-6.12-ff8a969f7dc8@kernel.org>
References: <20261107051712-failed-6.12-ff8a969f7dc8@kernel.org>
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
    Boot-tested on v6.12.116 on the MSI PRO Z690-A WIFI DDR4 from the report (empty
    x1 slot at 0000:00:1c.0), cold boots: without this patch both messages appear
    and enumeration from 00:1c.0 to 00:1c.2 takes 2.001 s; with it neither message
    appears, the step takes 0.001 s, and the systemd "kernel" phase drops from
    3.097 s to 1.098 s.  The other 22 PCI devices enumerate as before.

 drivers/pci/quirks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ac9851e3d..a7e2026b1 100644
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

