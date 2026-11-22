Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353813;
	b=rUkc2oUO//N7d5AenSmGc1ADc9jtMohnhdwPKx41P6VJFmOqtPxkjc/aOQr8FQGWgIHI
	 t7tLWDOqZt6AZEweso8mdRoZcShxa3PnoNHtlJjxbfK/FdJYS51uurma/FhNHf9dhdmJd
	 YQgrwbwcndigLj/R39A8553PlS6M0K3e/Be44w70LkZH8tnYx9kiLPzFC3oJ/pF63deWd
	 3i2TjbOzibbi4vhIaFmpJrXyewQKr5c5n4vOh8QANm22JLSLVimadnLdUYzeeoGc6LjUh
	 YHhtDbX1RbEWzovru1fpTsN9ODvMYilSu7XmQdh250pKSq71FwwITizWKBCL26LOjsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tw3cb2+kYjvBEJxGE8m+S5W8haGQ3n6c+8DpmSA4lig=;
	b=YunkOWNuTg3wi9ROZd0eDtBCfiT7EHun3ob+LoxgWZyWcAee2ZNXieDkWHdQC/SIPZtb
	 9ueOcrNo3d3pOFVZZvVStM9pJqeTGrIIyMIZOhgZ/cYpyptfqqDz123F1Qibj4nJoywgS
	 ivzphhKJDol9oFjRhwwEmvye55FcmUFlOMEWI+PgHsqqZrYiQIlODjMZZiOXjq3J2h74v
	 e7JHAxmPSnx0SQ2eOESpCVLVuyYzBChx4frJZmhlql1OoK26A+MHzyWR0nE732ExY/vfi
	 ETfsQ/F+RMd7E326lpWVWA+MkfziOziEeDauhgU2xkteQRnHgr4zk/mMDIkvGdiyJHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dVueh2F/";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6D606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF6D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVueh2F/
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1565629f8f.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795353811; x=1795958611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tw3cb2+kYjvBEJxGE8m+S5W8haGQ3n6c+8DpmSA4lig=;
        b=dVueh2F/N+Getk0I+AECAKNKoV/oXd77I1gtZ+8fnw6dtU5L1J948svQ/PTK6+LJSN
         iTea3DEaBRhR5onNQ1VQnRYIR7Lyo3PSaED4iq9WVH48kAJpQpNUG5xxep2Jw9lsZG/E
         0TmPUGcAabpEArLGCIah71z3OEhwJKJw6nngwWqpsQe7zugDSUguvLvHuAzx5b+i1GhB
         V0t9aQdwu7UxNL6h3bAYQLAs7aqgSRbqbJK1l/o5idArCDNY7Lr40NHiBl7+Cvaom/6N
         EdJyIbBZdb9x40Q/PscdynUih0CC75f2Axa4rp72wcylieEwXou5eys3ITk9K/okp92F
         0DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795353811; x=1795958611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tw3cb2+kYjvBEJxGE8m+S5W8haGQ3n6c+8DpmSA4lig=;
        b=PIL1SCZ53lhiQuL2Br8eOHFax2Ths3pIi/e2vlwiFVuhQBPqoySlZu8ybQ3xl2lC2s
         PO+r+6FocZkbtnYp6BddIB0dRynN9PXNGXuNE2cPt0XSth0HuGyvmo4Pnz54zAIr9c12
         ln9SqRjIcFSeImLmOZyU1E1FVHWlwTwpjrlKdhHpZUKXh4bTM2DS/73Fr0weygkX6qAP
         dCx+xZmNSXqARpUfkhIHDV8+Yp2ZaOaFtyISI6IDvFzGGEH1R41F9E22UuW263egaifI
         RA7hPEdK6ngYws7+aa0MSnV1kQXpzFe5Fy+AaqowcSUYXKg9Ia0ghEF+whIA7Ju2Cmun
         6fMA==
X-Gm-Message-State: APuU4Z/oqkcvG+aOqdE61rVUkUT/0h3nWr5Sn+qhemLr/Vmi5NzRVCfQ
	HVyYLSPVHVxmb5Qej3FxCLhOmyWHqhq/R3NgDPhiZCHoUNda3Rw0AenPUdjhhFwo
X-Gm-Gg: AZFdTZfo79V9OV6Ytqyybze2YgfgiKn2KPmIrNo2h24MOHq+S6hqF+2UCyxBarKdUZS
	leDMvYF0tcxXI8mL8kUxUN/XofJ6ytO8XMicffoN2LjGaz4K4L6UXXKtwB5emTi0b5l1d1DA2aH
	ihY4DCL/izyxMVexVw2qGwyEIr7ZswoRxTE/aCOVg4bD/leKSGsfpz8rKiPMP+gyKdWIGGDdaDV
	eLGK2oeoFMGAct7DNKR5z265z4kvat+s6kwf0NPgtb91pjM0XpOIWi0yEv1VuQzt9mwQUQEcsxz
	zRd4dzYQVybrbuMpX+ILQDfdky6h/EBo1NnBDVo9g3PJOLBYmy/+94aMG425RRDV06FfeoJVeP5
	BWtv56KpkzOGeuaTey659TBj1oDm+EdYXbrS/VSQ0q4KtuKmg07lWdWwdiQKhN4KufTCmLzshoh
	9MZZUW6+JtQaCa9cl4BxU713Kfi+5YjDobtQA10G43Qc7sqxmjM54lzCy1kGtsQIpQ1XBjXErqM
	Q6ra4z7ELuVZuWHUv0A1cwcUc8VFxzmdCoKxL4qB28d1e1vlN48smskz5glrDYT2fOXqnuMfyVh
	Efh9IUCZQWrDQfH8P0L17sNXTOsi6hw/pbdR6wKtjtQCLMCWOO8my7kL8Ek4p39ePv2Lr8ZKF8F
	zOdIEjugVNII0m4mjh5hN820eF5y0I7gv0tsRS9zopz89hm8c4KxFkzISEMfuShrLU5qGuNeTRd
	/BCS4V80ezrD2/8ELoAggIGWxw1A6F+zkoNn0C8fk8cbX0qcPm9qeuLw==
X-Received: by 2002:a05:6000:2997:10b0:4a8:12d3:c0b2 with SMTP id ffacd0b85a97d-4abb47b2244mr12544395f8f.23.1795353810746;
        Sun, 22 Nov 2026 05:23:30 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-20fd-ec9f-e3f8-60d4.ipv6.o2.cz. [2a00:1028:8388:a84e:20fd:ec9f:e3f8:60d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm17106499f8f.29.2026.11.22.05.23.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:23:30 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Nick Venenga <nick@venenga.com>,
	linux-wireless@vger.kernel.org
Subject: rtw89 USB: crash fix and RTL8922AU IDs for 7.3.y
Date: Sun, 22 Nov 2026 14:23:29 +0100
Message-ID: <20261122132329.52933-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Hi,

please consider these upstream commits for 7.3.y:

b1827227176821af9bba0cb643728d23328f3660 wifi: rtw89: usb: Avoid crash with dynamically added device ID
de2cb461456143a69845c24ce38ac14a61d6e166 wifi: rtw89: 8922au: Add support for TP-Link TBE400U
475539db19530b7e134f58555e1afcae21d419f3 wifi: rtw89: 8922au: add ASUS BE93

The first one fixes a NULL pointer dereference when a device ID is added
through new_id, the other two only add device IDs. They apply cleanly to
7.3.5 and build without warnings. I did not reproduce the crash myself.

I will send a backport of the first one for 6.18.y, where the RTL8922AU
driver does not exist.

Thanks,
Josef
