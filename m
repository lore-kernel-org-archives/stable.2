Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C00414418
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470535; cv=none; b=BCFvfCGMB6wqw4n2wkB9UUv+tGRn4WS8CH6fCygqhvFhHweOdEomVy0tgS8UnU7RMB987/0dNU7S6IYuFRtDf3JzSs9+0frprSlVEO7X99tRKpd+OKatyBUknX3at9ib5KkTJTle7KKdVQsGFvYbM9QFA/IPHzZ+lKI0F5k9hK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470535; c=relaxed/simple;
	bh=H4Qgo3NrwT95Sj6qHP6uWdO/8v3KII+0oUnxyMfDvg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1BaLCaYuvjizMMkmKRFk9+1rxjBLPSGO99qJhPEYR3QbdYQVUl2UPopAQcua1wpNf5tSb+oLxG4t6YFnMR1Bf75kF1eUt1hS53XJMz4JqYk2bvWJqoS+IckK3N7P9NZdu5BQwf9oifj6W4ONd9Ru9mYkgeh5P5iZWsQ1gg3DRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDUl75hb; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDUl75hb"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-790ec94be85so1016665137.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470533; x=1790075333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cocdW15/2aZ+zXRgLCLnmTvep//WkmiPKE1VpqZbhIc=;
        b=IDUl75hbB87/S2eUxia57DH8pQHJL+eeG/fNp8uXFS87AZmnIAOwBHD9aEFl6/0uXC
         Y0me900EYkBIeVc3Miwq446Z+uW8AY7MVfrl+hSYBk50nt/FChnYYayfCPCVWn3t4NNg
         6OEpUlJWOnOTW+btHOwrmV3z3mxv5pLTQWzhtsVUKeWgrOZmT9ZwTQyF/ukNy3/c/OyE
         BGgVMUhMAJcAFKymDA43zGIs/6xw9SGmSPMX4d9Ifek4xcalS2TbSQX7QVfrTGQIOYGV
         lXIlbpje/CGyxqxQel2kowG+TXohTc7J8DGfxjpd662JQ8uLy2Q7PWQkyoT+DDzvjpgH
         F+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470533; x=1790075333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cocdW15/2aZ+zXRgLCLnmTvep//WkmiPKE1VpqZbhIc=;
        b=ohwbg8jxDfB9I/g80P9qEbAR0XzPTOjRLUmjgfBkWSgkX73n4zlxfVNUZHLFkwn0aC
         6g8xBol7cwWSl1zLNMdaCbu21MOCeEGHb4NFxZDzDihmFLXB0fhJ+1vpVk+fi+LfLZ+L
         882VgIkomLn571DNXCnEruMUVzyfyw+1UPLHREokACmfgUaIeBaQ/8+lQTIN6taGfCpT
         2dUcEx1kNtasU1MI07gxe0nAL2abkl6CyJHnTlvXhiZcyZX/DvSNRL+681JRHSbWvTgq
         tIYMbCnDfeHYUWXU17NOTbz6fHj5JvepdKxHHRu13sXQDn/dWHCOwyvBfznOZKOue/Tc
         zztQ==
X-Forwarded-Encrypted: i=1; AKwUvByxjW0OSy4G2FHcGOMw3zEoVwug5sC6e2tSKW8N+ctTsYjD9GDOysOWpF3eL0HVG2tMU9KQzBY=@vger.kernel.org
X-Gm-Message-State: AFuF++ny1Ri4wSpqpbS2A50gsFb6GK4WTgmDxPXxWux3lCKedayIpasx
	DotFx75apIyFCs0b11ElBxCM9TpvH63en8we4x3wHWsxCGqp4WeqQT3U
X-Gm-Gg: AYBFou3Q+b8DWCp+0qcts7SyT/KZi34ruEkd1fvxlqNR35x58/sw1L6TpVrKztuHvSD
	Tz3uyAC1OZh+bMG80UogWXxp68vVaWk0Ekt0rfJ9R7uK5kt3+xsGhXYCupz7HdG97puHN7agZNN
	nFvDJ/IHuAYn22uOu5zcCfCrXHX7y1M04i+ab0ewPJ3RAggjr+jKAJHEjSosbf9VLY2Z2xUU8fg
	jZiXhndtkmFiVW7zr6tm5lo2mdD7wGVNNNu14SBS7IUZ4wjxM5vyXZz/37lj5mw6m0HMYPQI4Td
	v2G6cJyC6eIjBb5qdc0LAu8dta3lQadhln6SsXCQ1AlatRoKCZbX4/LVx99Fbr6bjMpnnCjV2uj
	js3a9aIZfXM4rvdp+MGLJ/fB0+K4pCMQx+pFVVy/CYSN4Bv92Jql7Ra2EWWbjGQpT/E93qTqMcF
	NMaLY95473pPcOaJ+gEsrBC9JqvDSObGiwMTvyab2VXnIAb1JPh/4gF1c9d8Ao05Fi
X-Received: by 2002:a05:6102:dc6:b0:779:5049:87b2 with SMTP id ada2fe7eead31-79b517aca36mr6935170137.0.1789470532635;
        Tue, 15 Sep 2026 04:08:52 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927ed7d0absm12878673137.9.2026.09.15.04.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:08:52 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] usb: gadget: ncm: validate the NDP chain before parsing
Date: Tue, 15 Sep 2026 08:08:33 -0300
Message-ID: <20260915110833.2721086-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915041111.2429236-1-qwe.aldo@gmail.com>
References: <20260915041111.2429236-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (d)wNextNdpIndex fields form a linked chain supplied entirely by
the USB host.  ncm_unwrap_ntb() follows this chain in a do-while loop
without cycle detection, so a malicious host can force the gadget to
repeatedly parse the same NDP and allocate datagram skbs until a
GFP_ATOMIC allocation fails.  This causes avoidable memory pressure
and allows a malicious host to deny service to the gadget receive path.

Example: a 64-byte NTB16 from the host with a single NDP whose
wNextNdpIndex points back to its own offset:

  Offset  0: NTH16  dwSignature     = "NCMH"
                     wHeaderLength   = 12
                     wBlockLength    = 64
                     wNdpIndex       = 12        <- first NDP at byte 12

  Offset 12: NDP16  dwSignature     = "NCM0"
                     wLength         = 16
                     wNextNdpIndex   = 12        <- points to itself

  Offset 20: DPE16[0]  wDatagramIndex  = 32
                        wDatagramLength = 14

  Offset 24: DPE16[1]  wDatagramIndex  = 0       <- terminator
                        wDatagramLength = 0

  Offset 32: 14-byte Ethernet frame (payload)

The existing do-while loop reads this NDP, processes the datagram
entry, reads wNextNdpIndex (12), and jumps back to the same NDP
indefinitely.

Fix this by prewalking the NDP chain using only bounded header reads
before parsing any NDP.  NDP offsets must be four-byte aligned, so
following more than block_len / 4 valid offsets proves that the chain
contains a cycle.  This terminates cyclic chains without imposing an
arbitrary limit on valid NTBs or allocating skbs before the chain is
known to terminate.  The prewalk is safe for both NDP16 and NDP32.

Fixes: 370af734dfaf ("usb: gadget: NCM: RX function support multiple NDPs")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v2:
  - Added NTB packet walkthrough with DPE entries showing the cyclic
    chain, as requested by Krishna Kurapati.
  - Softened impact description: allocation eventually fails and err:
    purges the skbs, so the loop is not infinite but causes avoidable
    memory pressure and receive-path DoS.
  - Use "(d)wNextNdpIndex" to cover both NCM16 and NCM32.

 drivers/usb/gadget/function/f_ncm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 64eabda2f5..085aea142f 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1175,6 +1175,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	unsigned	dg_len, dg_len2;
 	unsigned	ndp_len;
 	unsigned	block_len;
+	unsigned int	ndp_count, next_ndp_index;
 	struct sk_buff	*skb2;
 	int		ret = -EINVAL;
 	unsigned	ntb_max = le32_to_cpu(ntb_parameters.dwNtbOutMaxSize);
@@ -1224,6 +1225,30 @@ static int ncm_unwrap_ntb(struct gether *port,
 	}

 	ndp_index = get_ncm(&tmp, opts->ndp_index);
+	next_ndp_index = ndp_index;
+	ndp_count = 0;
+
+	/* Validate the NDP chain before allocating datagram skbs. */
+	while (next_ndp_index) {
+		if (next_ndp_index % 4 ||
+		    next_ndp_index < opts->nth_size ||
+		    next_ndp_index > block_len - opts->ndp_size) {
+			INFO(port->func.config->cdev, "Bad index: %#X\n",
+			     next_ndp_index);
+			goto err;
+		}
+
+		/* More aligned offsets than fit in the NTB imply a cycle. */
+		if (++ndp_count > block_len / 4) {
+			INFO(port->func.config->cdev, "NDP chain cycle\n");
+			goto err;
+		}
+
+		tmp = (__le16 *)(ntb_ptr + next_ndp_index);
+		tmp += 3; /* skip the signature and length */
+		tmp += opts->reserved1;
+		next_ndp_index = get_ncm(&tmp, opts->next_ndp_index);
+	}

 	/* Run through all the NDP's in the NTB */
 	do {
--
2.43.0
