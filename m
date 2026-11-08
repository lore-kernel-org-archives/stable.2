Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172602;
	b=SJZnIkV0T3fwPat2V5DkDOzbdw7dE/zXPdcFGXMIqJ7trWnYUAdX6+VsKE4fsc41eUQc
	 xq7b0Hc4EKnc0sMFnnZrryGzkPbGcmsA0iag+4zrsn1H0l4RpOkbThAGBbZKxzdPfWPvq
	 Ii6x8DePBiaK9EBSxgUtX/PPBp57dRMZu9JMcrOTUXOhWs6IHgrHE4TKQXYLORFZ7p+Xj
	 cCm5GfwCIcYBcZgxQvG8bQUtqquQcMem5JzfDH6IYQPpnIoi/9C7xxIAZ/GdoDTF9RhaQ
	 5UjHpaUW6paQq6B1R99panyaQtMdL0JuCiDMsHAPCigH69iHcCaUEiEL+m9OlNP5c8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=YqppGydY2lVpcg6U6RxDeq0X7ii+knKFWwlrA7dV7j4=;
	b=IBp0a50xy8HeIFfEX6I4IYd1q2EY+6o7QLDTOnQqGvT0VaLIuZu2mIpCaYVJcn0yx3aA
	 TXnoEhezVJCcZKreZDcUmAVt4Vhkd/SrEPz4+11tRhBd+/jLjkFwTxn9FTz9trep3PA7/
	 jgBKxG2PvJKjZOaBnBGhpHGroLkEMSJmEIiNVnnUxE32R7lkw8zVf85hy1+hUAq4bmcp/
	 RhshBuaMr3irqb2zk1hC6cHk9EnUhkMCF1wra1L0tsFxXfX+HxToKiUNekoThCOcg7uHK
	 4O5Pmimf/ItOXUOc5mOgvCcOtuFOo10/vcZRkxUS24K4jh0WdoLPxoHDVtEtB0tjTtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8AWoA0O;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4070606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4070606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8AWoA0O
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dde81a6820so161232eaf.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172601; x=1794777401; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YqppGydY2lVpcg6U6RxDeq0X7ii+knKFWwlrA7dV7j4=;
        b=h8AWoA0OWxbqjyWSNiYXEzTizNbayTb0xZvvXcqCgkbk2w6HrwjoDDPGXFLH/fsHDO
         BDyEC1UwljkkYsQwQnpdWzQFEYIVN99b+HFiVsQrgGCKlGMGz9PcaP57xeV17t6Nz/S/
         gHkBA4kiJt3gn1lxJxuScSF382vlSUtXxg9JA1pmbjpkCc9oovDuzn1bws859QUX2aek
         w7pIy4d9VWt4Iaey/v74OrK9GqNo+Hz5qSlJ7kVutNNBYDHUjGLjz+Mc6L/qdDMDKG01
         AS8nZFrBadASG1JTaDpel7dwavlnGnsHdS3p7XxN3CGMpp71D9eDK9fDgFncwCT6XS2e
         CHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172601; x=1794777401;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YqppGydY2lVpcg6U6RxDeq0X7ii+knKFWwlrA7dV7j4=;
        b=AF1xf3rB9KG2cGJvEQUAD01zLpSN23eHqI9LZ1uGVOZMEOdLCcm4jCgZX0GbbMVkSv
         U7g+qW9hOy4IQSssbaqdwNR6IRAQjFDV0kF4uUXGkHTFtgqs4wCAkhXxgvXt++j7zn2n
         NGggHotdlFT+lfRmPp3l+5A9AkKzmM8xywJxNsVKns5AEO4LWPH1n32hoy4Xylt6Q9kf
         YVAPiAuSrxE+q+zicM0aE1fqw2UsdyFcJ5o83i5ruSaQif5uLFPHTn3kelrRi3p1k0qg
         cx0CyhkLt/rCmk9ho8lMLlEjaG1x6yOkmEpxQnz/XFPHadQdpaTLnLKczxIUpGC7fru9
         av0w==
X-Forwarded-Encrypted: i=1; AL+hErE0gAfvmmyaHnpZGAqsjyeFjK80KnHK41f7Y7x0ZcEuNHWE6eNTLrDkdp0yDSJKnj3t3Dc2MTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xODflC8nxp6CQRwWIwUQmTHRX2vP5yYgFu1nQZ/xX/mMuLqdZ
	TK2p1QU3KCWLV1bv5qEkzVls640T0tmBX+IANqzTBoe8EZ+vH34MVAwZ
X-Gm-Gg: AYBFou0LQTVOorh1CXb88znVrSNWI25eoCpjWZsEPXiqliml40R0Ag+aQ7BBLkWZsDR
	83a6v89n3iEavAZNhcZ5l/uyo4jaUjtYwdZKcNR+Z+pQdFbMdKX34PRKTyF92iuYDSi5XVAkXPr
	mqeozgyZWJKZA80RyJaEDk9TfXJ0cTusSN9CndnoI4KKaoFkGo0WJpzuR4p3tkDWikRsUWmKY8f
	RjGOlDVeDr2GdKaT534lMG2SlDawWWinWbPAfdYbQe3fZVZImvIjMIuqGRU1Nu//+0rEv1mmCAJ
	vsELKn9rcJJ7h5nVzv1p1HnRfd+6T7Q51gFgPhTkf6KKBv0sLWWhlgoH03f4GbSylcl4/MPOsnY
	tTQ/oBgHAhZ9hNSZ93B76O99guIDwGAz0+aCYeZeNbt6itZA2+VgIjYrgbIPt197XTUaXhlqqD7
	23VDb9ywAaY9waEQINJYE20Ojxg6yB80WEZDjR7cfLkPHMI4p2Z53/CvsrHUW/26O7BKNuA9R+h
	DC0ON9n6yprBnxM8An/+aAs4b2oGvvM+phIW56XGb+yd0JD+30i6dx4zixta7sc8F/CclzqvGAr
	WJjdRvUgAc5D3nfYhCUcv/To5sY4cHqRQmYqENc44oh0t8T1tiLyONNk4PSGKQ1F0zaKFho/QLU
	WJrlBLGRS2lbtBa/UPIf+EPhWArcKYaPTkd87D890f0nYKDBBRCaEaTwG5+LE48YcTnvzprrKLT
	vgX4RUaxWNvqBo5z+r4KOphfiWniqxlS85jPclwWkZsjK+mrZiqYM=
X-Received: by 2002:a05:6820:1381:b0:70a:df8e:8f64 with SMTP id 006d021491bc7-7170f259c8bmr1073868eaf.22.1794172600816;
        Sun, 08 Nov 2026 13:16:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1896378eaf.12.2026.11.08.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:16:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/3] mtd: rawnand: qcom: unwind failed child initialization
Date: Sun, 08 Nov 2026 14:16:34 -0700
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN3Q6CMAyG4VshPbaBzSCJt2I82E+RGtmwm4SEc
 O9uevh+aZ7ukEiYElybHYRWThxDCXVqwE0mPAjZlwbd6YtS3YDpY2fO+HZxxmCCRzfxy+Mi0RK
 SSJSEq8KxJz10Z6MG00PBFqGRt9+j2/3fRXqSy1WvF9YkQismuKlOc/Zt9dtAW4bj+AKcTNgMq
 gAAAA==
X-Change-ID: 20261107-submit-qcom-nand-child-probe-errors-v1-f5e2703a17a5
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

Keep the shared BAM transaction usable when resizing it fails, validate
the boot-partition layout before publishing a chip, and propagate child
probe failures after unregistering any previously published chips.

The layout and allocation fixes make cleanup safe before the final patch
adds the missing controller-wide probe unwind.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
James Hilliard (3):
      mtd: rawnand: qcom: parse boot partitions before registering MTD
      mtd: rawnand: qcom: retain the BAM transaction if replacement fails
      mtd: rawnand: qcom: unwind registered chips on child probe failure

 drivers/mtd/nand/raw/qcom_nandc.c | 56 ++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 24 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-qcom-nand-child-probe-errors-v1-f5e2703a17a5

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

