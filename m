Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734689;
	b=asLJO0h/Py+BY+ohmJ1klMVc7idsWSVL1YtGgUzAs+LUGZV8B4NAOUPiKB2caCC7XeO+
	 uttoUNd+kSq/bmT/1cOiPInEMUM8n2h0pL3CVaBHG/CxZUUa8BxcBfLgtpWY6aya9Mrap
	 mJNuOZr9Bhdy8Ne1SyKJblbzuKbbMjXO0p7Ey/G5oeAFQDJtXJg9EBO0WT2vDPb8ED11J
	 /xPjieMC0mvYeTmGf8/Ct8bzjNcccO0A8cxaQ0Jo30TzU307kykS1NE6G7Cg0RYrrEV58
	 CCt4jtwm7N8g/JqriUZIhofsLQc7F7+OhmDTlp+BZIDIufupkag1lhIm6Qz8dnUSUcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ha3lGnJBwyk4YR7zSIS8QHZCwEJjqdMUCtp8VxcQYlg=;
	b=2RNGWIJPviXO80XlKLhhv339tIWReIzjGw7tFAYjxIZcBtWWd8lTb0LBcvn9+n0eQ/H8
	 PHlXvDuaXxig9JZolBoCNKF/miswfePiaI1Dg4uG4LQ2PJaGsuHjbtpG+I/XbWMiVv1g3
	 YaRD01tr+mFefWR/BETL+/K6GuakV7OfIOfqBzxDWcOnYQ1OJX8NIwM/8lMGXgJTW7x2C
	 TvuxIlZBJZNDP+oz8USK2EeOQdNkkA87x/yqD9QdcA6VfN0Fljvb1A4m/WZ8f8GDgGbnT
	 QAh6k1hxkodkTQi7vqcPjfyq0KCj0/4veTKTDOvihdUzerQJD89DFPc4N5/Nqu5VfiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Qc9ryKR0;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F69606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F69606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Qc9ryKR0
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso37426015e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793734686; x=1794339486; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ha3lGnJBwyk4YR7zSIS8QHZCwEJjqdMUCtp8VxcQYlg=;
        b=Qc9ryKR0MLQPExVVbk5Z+7VV9yjXBcNjJcjTBDe3G38pocoOV82H9z+NwxbazjH1aK
         E/6qBcrQiYCO92zbzb4A3jxte1kO2Y76s7HST3qICTyk1VTMVBeNMx5VvQpK66t/CCE+
         UQKnJaVxg1p9CgO4NrTqUSqpyMV9vVBe2liobRwchiMWD4mZpOH3D/L2UVWey1DMutaB
         8MLFfwEv+rLDXPodVfLmOs/EOzGv+9EGOUvnmBnfE49ks2lpRU4l49QdPz2KWLl5EjVv
         tqt0/vY/YM+R0YCCYDsdU/fEw9wmJfNgS9uA9Yt8acfXii/ixED9bdMr+VxZOmmwXMWf
         PGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734686; x=1794339486;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ha3lGnJBwyk4YR7zSIS8QHZCwEJjqdMUCtp8VxcQYlg=;
        b=gNMx4qTNk+1+ZtcAAU+X7nJ23CUCYX6VhuEG+B+hQuXF7s49KYEagu/+NhLRpS5Kaj
         C1LGCIGYt46bF+wAg0Bx+66A6LWKdMYmfic8/hCg1W6t2o1OZO0gkK5sB5QZXv8ZpBgM
         g8yn3aPA8cpGMa77LsjEDwz5rAkA+LWaV1BsxVKRWrwoQ/ff7bVU+g5XgZy1sDHdSbzW
         6Z+CevntMk5epvBZNcKclO/UxgVr5lLIs2BiBEU/FPnpUTp/6du13TJLvapKAIJe59dU
         DM1y8pcnW3+OHeVQ54LuJyf/Eer9QzfxTF5PVX6/1rdaBpnudC6GCQcUIzgeVIoGLRQ0
         F/cQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF4QQFqjOUl/R9wBkaVAuj5A/ZCFTK2zzqK03iYBFmNZ7keBx4wyjmISe3hY9KsJLElv4kL9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HMANiU5ITvWQrEiPXWUFDZeLLRNXOGoTAtqdBWA/7cpaBM9ZW
	wBP7TDXcgFg0NfvPyO64uXJYPOtCNTqWYzdq4+U4NzHePOE7ntw11HEocSZ2iv7f8Wk=
X-Gm-Gg: AYBFou18Ugwtc3IW9fs0UQBXyjtsPBbTVX4jkuNd+VpPrJj4QHSuFMXuGEmoGbqwTep
	Lugd7TlSyTSbDiM/C+1TLlyTpgi8fHND+s5UXjrRiAT+hkdfDBbjorDMXGU+DuPgq9CuTLitnrr
	HaaliZrOcAvtFvTh78GU5Nn+4S9L4kQ6TElWOFPhbwiP20W6Ptzgi6klqRrgipVQZKt1nQhrxe4
	qZSzfogfTxuG7p3k9pRXGcZ0YqQghKQ3RjH7nwOWiwSy8NfIwdMdRJguV8E6jmyQvGRvVEzSpNO
	KMLJlQJfODWURnpj3HcdKEgz5XJNSQf6OVle9ZzI3xcX0DEsLByIpFn3TnjlOE/yWDzXI9PXRbH
	DIt1G0TsSdyx/gNj0y3aHYTo+VaTLVTEE8Qg99LGVklweb9MFA8cfOqJJYxaHC/cBraEsyxYOI1
	JbTqeF8p96kfX/cSY8DPERK4hrou06OLApZC3U4jo8RXHODftHhLQow2kvtt5VT2Z8ssU6bxduN
	TavgbFmyWdhN/NVwNUBzqx2E1A6k9ziUbtf98/dNif/stam8O2+julGMRBz5J0+3+7y/7D399SA
	WX0Wuxpy95T6JudzxtucAH/N5A==
X-Received: by 2002:a05:600d:82ea:b0:4a1:cfa7:e968 with SMTP id 5b1f17b1804b1-4ac17ff9be8mr351143745e9.21.1793734686327;
        Tue, 03 Nov 2026 11:38:06 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab010a66sm114159265e9.13.2026.11.03.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:38:05 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH 0/4] dmaengine: ti: cppi41: Fix suspend/resume issues
Date: Tue, 03 Nov 2026 20:37:27 +0100
Message-Id: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
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
X-B4-Tracking: v=1; b=H4sIAPc36moC/yXMSw6CMBAA0KuQWTNJPwjIVQiLUkYdIzBpgZAQ7
 k7V5du8AyIFpghNdkCgjSPPU4LOM/AvNz0JeUgGo0yplVW4VWhxmYU9utHa20dG9CJcaOx1rZw
 ZSnOvK0iBBHrw/svb7u+49m/yy3eE87wAcQ9sVX4AAAA=
X-Change-ID: 20261030-v7-3-topic-am335lpm-cppi41-b180a2d62987
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=msp@baylibre.com;
 h=from:subject:message-id; bh=SMzMjv+Lw+u1NgOCPW5V9Cq40PADdnkoFK7SsolANoM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxXFsx3/0ZZ3ZhoK2HEfSHzmxSP1u2nzzY9nLXy2MLTC
 SlW+U8mdJSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE/h1jZPh4Im/BCfUGZ7GE
 XZPmdVzmDP6552C+7m21Caqv5x85ODGRkaGH0XFV5cplp9SOMTE81yz+4Xi3rbKy3uSJfblqgMe
 FXCYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

there are some issues with cppi41 regarding suspend/resume. This series
fixes suspend/resume when the device is currently runtime suspended. It
also fixes an incomplete restore of QMGR_MEMCTRL during resume. To make
the restore on resume more reliable the last patch unifies the register
writes for init and resume.

I tested this series with am335x-evm

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI) (4):
      dmaengine: ti: cppi41: Use td_queue to restore DMA_TDFDQ
      dmaengine: ti: cppi41: Fix register access in suspend_late
      dmaengine: ti: cppi41: Restore QMGR_MEMCTRL in resume
      dmaengine: ti: cppi41: Share register setup with resume

 drivers/dma/ti/cppi41.c | 74 ++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 31 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261030-v7-3-topic-am335lpm-cppi41-b180a2d62987

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

