Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415608;
	b=yQY1BJ2n0qBBVKpx4RHlehdGpoFZQ3tK5OvtVhexVZe3XJfmGr67v6DLO0nF3cVwJxtk
	 9J46hGduYRvCyUO8KkZeD9fa7kVhvjE/PtjzFGLjkD4yrEaRmq63OM3AhN8EVPPjUPwNV
	 tKGNbSoD7carNRX+62AF4uEljCQ9HQKu8zmaL19uyeMBWLo/I0+40+2A03hrwAX1/dBsf
	 5ohRa9gnPvXmd5DJ1RqnFuFfAQ9kJ+jRM4BfYVb1drI+jOxaUs0XZzjsr0f97L/n+rWKy
	 W0Y29G1AikkaOX0XzLhkv8qNiGYqw27KRSqJ5981wJDzxVlTvmwab8F89Sz6vS86mZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6mnZfOSkxDepY2i0f378cTykfqpzL6KhJuIK0Wt6zEk=;
	b=mIBUke/SgO7n6K5pEgrIRteBc28NVDrenRcdW+yKEtaAhhYKnah09PT+AlkwQp5fzbyA
	 U8Ifkxv0ER9GUhhWDlV6P0NQ9HXCBelnsdKJZrrn+2RrTyPVJGhQEUCPwL5Rj0KRY0RLR
	 KhDmB5Z1paa9MNJlTpyTSBmWWJxXQJDCopzk+yiyqHvmu8eTA4LKeLHFN9lYPG0AiHG8C
	 FAWR0XUFGn8vAtGegPurEqECbZ9Y1MkEtOZkG+b6z+kRKvGLqkL//Rn3odjzXhG2zc027
	 3OVsp/POtOKQYEJ9NDsBKO3313hwnl4eqeHaZ7aF8yBBHhfUiMGNz3pFlPMT/txtnJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HCml0ifA;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D4606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E52D4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HCml0ifA
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a315ed211so3787089eec.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415607; x=1796020407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mnZfOSkxDepY2i0f378cTykfqpzL6KhJuIK0Wt6zEk=;
        b=HCml0ifAVoC04DR1qnxQJbTTPprsXumYeYTXKrUoG4N8+iSNYLroWnc1AN+0Sj/F8+
         v1Wn1GBig8CYi28Z9Tpfy3xtKZzxIDr088Y0eZmF27zIIZ5PJGq8FnBO/01J2FIrl6kl
         HTusLSf7gNIy2WYltMMZxsoTabhVwbE7F68vhV+cYFfyhxWXfrA4A0ZiSr8r+sXao5CA
         oLi4SJXu2RCAa6mwmEXRBB8rrrEqbhafqRhyhuZG9MRzjE63BEVtpvyHQJwhuLacw9pN
         k5HHpbTDF3SiWhBq+BvHkLvHY8Rc2Vn6EQXUcHi9HHFS0gqsRGYmceXvf81w2TK1WOVs
         ZdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415607; x=1796020407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mnZfOSkxDepY2i0f378cTykfqpzL6KhJuIK0Wt6zEk=;
        b=InVPFju72lYn2VLCnHWVMXB9kb5Tfk6jEjHlOtV9LHSbTQSyziuqqRxwVath8Zo0C3
         S0K6ISjyO73cVeB+lCl+yBih/sOfbHHgKKLFt1gXw18iB4qM7yMrlpyZuJgORMh2bQ6J
         wlwN4caODN+0YZHx00qPU2nfxrz406jecyIb9F+pahQkOS5KqkWQHjMh8DbkNSX5Rkda
         U4uwBmPOFcgwuh2UE7pmsXGzs8yMhQDTbi56fNPIiRjLAX6VAaI9yrrsr2SlKkD0V1hp
         HeVVSxUpba8mehT/IKqF4fpFXrKdVg+IrBaeMb2tl+u1ZTBuP0hQoUEhaJp7UyHzgWuX
         cgIQ==
X-Forwarded-Encrypted: i=1; AL+hErFnfM8wbZDeD5aUzYT4zbpUWDIHh8Ycr9M5YOLCaLNdtaGXd12BOdTsCrPBWb+4PLXOcP/JvRM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/27gLHF6eBEGB8uvkcdT+NjLzeBKwpIgqHcDjs0Fi2lFXlTB1
	rqjNYoMwtkCjPktWZjM3zP7MXvjW0SfSUmlbm7JcR9znF+r24k3+rg1V
X-Gm-Gg: AZFdTZe/qEfLea9KFeDPEhYPGI5FPWhHF16ZLpjuyuM4nZTR6n8R+PLouq3eLBeT5FF
	r2PHEljr/k3n2mrtl1CKhaANYwxFvCTxZBMp9Tsc0xp7qCaZDyd/KDmtfO3kZ3546Cct+R48ivm
	L/INJMQa2mOhm9RKpU7g7dYYnhddLKYPRNGmPG9X6GCZ/I6UQEv/gL+Lt+Tvc3ojfBXpiJB4akb
	tM6zo9j0ogpKtrAINluSsvqvGGQ3BYct0Mp1MUzYYcIpz4kBw+yc29b8xkZm1UxkRxLraok3vR4
	VfGeBWzlircsSM3eJZCz5C+rGKoXTr9ynJ5npU0+7f6W6p3GZgcLCYiBUfIJH9sxrwTLamRtD7y
	Bh41qlrbFHp5IaQMSIIhUgNzrP1gWi0f2TQzooZ0SqgHEiPsMgB3dvgZChjANHzVOA6ulR/c6G7
	aSyRvRvP9gGcM+lh9D1USIH0YrW/IyoJ1bi/aOU7MLyoGnyP+YL0TN4BprUED/zbRa2+hk6VG13
	0voQ5e772rZAbHYQIpVBNCYekAwePa692kxzeRaK6JP8drNQ6avBg5IBslqTiciIEih+nLyrswu
	qiumNrnaHS1Aptyuw1lg+BvRUK7ITqsU8TwVbE+S9ME2k4P6vuPBQ7ilLzKzkMFMVkU+8qQ/9Yi
	G6i4eKR0+aviNyHtKpTWieRqmNSroLN4dKSF3BU+qMpxnsUE29jZ5y4/SQRfsBaE5HU+RTPIQ5U
	cKC4/2DnH3kJkxEsYDSrqUQmUWcs3UL1Uw0aKeV7C8y0Y7SCX3YoJB4nrB9oIIz896
X-Received: by 2002:a05:693c:68dc:b0:384:244b:12ed with SMTP id 5a478bee46e88-384b11ec95amr13052915eec.3.1795415606797;
        Sun, 22 Nov 2026 22:33:26 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-47-129-70-252.ap-southeast-1.compute.amazonaws.com. [47.129.70.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm35452817eec.24.2026.11.22.22.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:33:26 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	"Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] nfc: preserve NCI data status error codes
Date: Mon, 23 Nov 2026 14:33:10 +0800
Message-ID: <20261123063310.1267-3-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261123063310.1267-1-luob87709@gmail.com>
References: <20261123063310.1267-1-luob87709@gmail.com>
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

nci_to_errno() returns negative errno values for nonzero data-status
bytes. Passing that value to nci_add_rx_data_frag() through a __u8
parameter truncates the errno and changes it to an unrelated positive
value before the completion callback receives it.

Keep the error parameter as int so the original errno reaches the
completion path unchanged.

Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")

Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
v3:
- Split the signed NCI status errno correction into a separate patch.

 net/nfc/nci/data.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 3bbebb950..4a2326a33 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -213,13 +213,11 @@ EXPORT_SYMBOL(nci_send_data);
 
 static void nci_add_rx_data_frag(struct nci_dev *ndev,
 				 struct sk_buff *skb,
-				 __u8 pbf, __u8 conn_id, __u8 status)
+				 __u8 pbf, __u8 conn_id, int err)
 {
 	int reassembly_len;
-	int err = 0;
 
-	if (status) {
-		err = status;
+	if (err) {
 		kfree_skb(ndev->rx_data_reassembly);
 		ndev->rx_data_reassembly = NULL;
 		goto exit;
