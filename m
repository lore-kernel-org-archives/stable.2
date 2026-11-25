Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572026;
	b=zsGseigUWvJK7uPGu9oZnryX7FRPkbjHsJgQIKPNhcEobvb4B3vxk4ykS871vBxkS5qo
	 aFbdEIz7ugtt6CYtEzHPKnuFDjV3d8TD31B1QYlaLXkS/X2X281KH8NPs9FCY9TEESd7s
	 LzTH5mjMRIaw4pQL81aMOuU6rjRslKst7a+wJwwSiNwxIolGHsz/raqb+V5Qu+U5y7VAM
	 xMol1w9OdKKB3Uq4RaeusIfzEX8ZMeE4vgyGDDLdePqs/uXJIIExkltcXKIfs9F/zHfci
	 7nuj8av2X/ZW4/CmoF90Px8Onhu1oFwrGmo6pI/hWt8TT7vQ8liTt3JMFs1ufLi5z6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CmBnezBjBNUlOHWa9u0VCe+lFB+x5YUvV2kyPTDgM5E=;
	b=h+cr4W53VEC3wwYyAvDInKNsOukED9ViwZcsQqi3M3k5fvK/ah/6Lh5WOaUQBTee1Os5
	 nYS/Ge2NpZPmlg3qzbLcXReN76qnR3P35WslsD8HWm50WjhXn0ufZrWcX1JeBhn41B+ud
	 MskmGVWKClQCzjuceJzZA0oTvg0O+zj+rwcvQMdrOGFXIlYKpDTALIlCkHz8EY5BmD+Tl
	 V+4Ej3uLPTd1yxaIhcYsf3uhadDmBKe3THMO2VoDboi5Ayl8WnGr1lGrJS3tx4H5W72+5
	 wZ/lBSue34GqOtjxmPsOZOT53lKkQjXa/Be0x0YHwJXrmhywG9H3xpzAzGcz/fZN1aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="oB/VaUeb";
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1B606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC1B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=oB/VaUeb
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B9EE3F1AB
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795572023;
	bh=CmBnezBjBNUlOHWa9u0VCe+lFB+x5YUvV2kyPTDgM5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=oB/VaUebTi6lZYEjWYmDGtDnM4Eyy2/uLNNqK/ruAIpt/yCegfUhtlN8idpy3mgPo
	 MgwXUEgI/wSMnQ2oY0s4mh0f8op6M2nW+50kwki32lP7rtl0fADgzU/Q8DCPb+ui4P
	 NXq0f0vverZXbCRs0ruUFjcWqknbzTuyvCYN9nMaa1dmXebVBxyC1oCcjtMwuExUNb
	 KeQ8Pdj0e3FmN6lqjtAGXSzoDm8Lm1OKhFdapxfaDHz32m0CNtd3hkkBkdoXoXfbDB
	 R0VfBhuXv0IwUrqalXv0GR3qOH13/r533uBlLaEb0bjDfONyr5Y4N68LQnsQ5facAH
	 5sWqaQXlZhdFLhOtocwRSU6H2X9gpge+xhvy5s1v2vkAeWFylvl2LGvaAb3JpsXZM6
	 4GnqMMg+fsZ0HpCe0yD5/FGkjzNYdaXUH9oEtQPNCN7RZW4c532kaVsuD928OPovwK
	 mS4DOjhgnUcV23yCYZ39s4tE24afDqtnS2cr6IugjWXvXWaEHCH0/pUoO6XYW/Qeki
	 p0Qe6kgB/KMn2ENJKr25cgDXIV8bELaYUMoUHv75r0bxAHx+XeVjUJQWrqwsS3OXjY
	 Wm//iRKumsvhlY/UA7NXBb0aa/j2tngAA3AvxBekf5XpZuzLXhNGiwk7sU2Hi4oeWW
	 vIYGfXF1OZWRopnSzeWGxYJ4=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3fcce67c4so943979a91.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795572021; x=1796176821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmBnezBjBNUlOHWa9u0VCe+lFB+x5YUvV2kyPTDgM5E=;
        b=qd994eA1x7UI6mC4FFagcKMGpdFqtZ4sQxLixfBtQTVoZ0cNcWfWCypmUbhqGYbi6i
         yfhJVgyQCKFGni9F3l2P/7bbTMgl2et9tYeHXX/yovngY0d/6Q6WuiF8Wtoq4L/IG5l6
         Ay4NyhBv8/7H4fbUHJl/LO1RGm+euV/61lKn0pv9GubjRgpLagsuPkle/OasuZg9Nlt+
         OTmoiqgRt3pxSfH8j8qUnvvEOaz3GnIKkR9Hl6dAw+kGYdDh0lEhCdMFgBJ/CNIUwVEe
         +M5A8+bfxDkknwO4P9N9ilkVnr5bAXUgSwafBeS56yvlKnx7+8zYCnYcwkZnPtGjobGT
         Ii9Q==
X-Forwarded-Encrypted: i=1; AL+hErH6U0jM8LKYv2IcqbkrA/5vhX9QQT8BY+iE+ft07Saf02oemETrWVZ3rznEZ7EKH66EavdV8EQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+973Ry/TncJkcpdaF7T7ZemQzYk+t6JpBfpFWQe02mklhJenUJ
	t++MjBBC5BAneIU1i0X7/3t6Xc2rWhBGswdjXBOKPfJKQlQ3s2A+3B0HwsBjS/Sg8roD9A00rFe
	u8Svwnc6kOw5hSJozR/A60GV1h1D/Y/iWE+RoPbk8TRNyX1Dqpgi/UL4Dq3I5NkqxnGA6eFmR3Q
	Z3A1U75g==
X-Gm-Gg: AZFdTZd7VXSifmfFushPHRGPwleZQiw4yb6ndRN66/X028EaQvMYnPFcSWsBwTT/cjW
	LQg1xIuL7mfTXsSkeEL8MDwDtVJINurKpLfAfnm7KCFHL0T33vf9+6rGLurJ4KvMHA4ddxZcT/v
	idoT7lJSXGD+DCCr8rHssuS9jNk+7W6XEEXtAWIM2/gxsqO6kvg56uW7gG0yRQXpaN3oH2Pa4sd
	JPXLFdhJdunQaRxHwvmTdn9Bt+R2w2kqg3VEOHK1kEYnLASAqlg2LOI4gxV+MQ+L3xbTT722jK9
	8jAxaumDN0SEWeLpgte/QFKy3jDzoiPv77if009P2J5siznS6KInZkRVBGQac2xe6PBQipW1O2f
	TSi3At4Zx86eB+A/xFcLhInvNl67ua6dCRFwB0Q/o9gbC6XQK6tD+LgOsadoNvdf/iY4fdDXveC
	qpLzcF2VJpgn1FFutWb21GgzTtR7pwx2Nx6ktAY8C9Rp84HeuJkS6Er8+xBgp4rWWfkssssilCo
	mvQwWmpJkcC9TRYOMTI+vfGNmCjdUSt4dL7W6wpToug7/j9dy+rzXmONfs5O2lak8K56blUU1sV
	Lb3SX6knMusFA/6z
X-Received: by 2002:a17:90b:1dcd:b0:3b3:bcc2:490 with SMTP id 98e67ed59e1d1-3b41c7c77f8mr25857491a91.1.1795572021341;
        Tue, 24 Nov 2026 18:00:21 -0800 (PST)
X-Received: by 2002:a17:90b:1dcd:b0:3b3:bcc2:490 with SMTP id 98e67ed59e1d1-3b41c7c77f8mr25857411a91.1.1795572020632;
        Tue, 24 Nov 2026 18:00:20 -0800 (PST)
Received: from localhost.localdomain (2001-b011-2008-6747-70df-a308-14a0-6404.dynamic-ip6.hinet.net. [2001:b011:2008:6747:70df:a308:14a0:6404])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm24959832a91.8.2026.11.24.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:00:20 -0800 (PST)
From: ChunAn Wu <an.wu@canonical.com>
To: bhelgaas@google.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PCI/AER: Keep ANFE masked on PLDA PCIe-to-PCI bridge
Date: Wed, 25 Nov 2026 10:00:13 +0800
Message-Id: <20261125020013.639193-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
Errors"), pci_aer_init() unmasks Advisory Non-Fatal Errors (ANFE) on
devices with native AER.

On a Dell server, a BMC VGA sits behind a PLDA PCIe-to-PCI
bridge.  When enumeration reads an absent device on the bridge's secondary
bus, the bridge returns a UR completion and, with ANFE unmasked, also
signals the error.  Platform firmware reports it as a fatal error even
though the hardware severity is non-fatal.  The kernel then resets the
Root Port, the bridge loses its configuration, recovery fails and the VGA
becomes inaccessible, so the console goes black.  Kernels before v7.3 are
not affected.

Set no_aer_anfe for this bridge with an early fixup, as done for the Apple
T2 Secure Enclave in commit 7209846a169f ("PCI/AER: Keep ANFE masked on
Apple T2 Secure Enclave"), so that pci_aer_init() leaves ANFE masked.

Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
Cc: stable@vger.kernel.org
Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/pci/quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4a02fc80755d..511eb65f9872 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2610,6 +2610,15 @@ static void quirk_no_aer_anfe(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, 0x1802, quirk_no_aer_anfe);
 
+/*
+ * The PLDA PCIe-to-PCI bridge in front of some server BMC VGA devices
+ * reports an Advisory Non-Fatal Error when enumeration reads an absent
+ * device on its secondary bus.  Platform firmware escalates that to a fatal
+ * error, the Root Port is reset, and the devices behind the bridge become
+ * inaccessible.
+ */
+DECLARE_PCI_FIXUP_EARLY(0x1556, 0xbe00, quirk_no_aer_anfe);
+
 /*
  * Under some circumstances, AER is not linked with extended capabilities.
  * Force it to be linked by setting the corresponding control bit in the
-- 
2.34.1

