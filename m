Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696241;
	b=17VxNR+n8GVTpUKROSeG78KL2zZUTJ5tgt0A4EGhar2ZTgeWnCHZqyGmBr+4XjQh8K1b
	 4qg/wouG1e4L1sHFRAmmTMAgSaymyc4rnw5woux9b3a9TEzrguSBhCE5qIbFlA5mqcYob
	 BymQOkm9i+XWUl5F9LtsCFlrfKgVC59WrMLeO9E1ZsJpWLfQWBs7gb7d0AOil1Q+6fY45
	 1fyzem2bP4Qic8wSkTkKIk9n1ibtnxT5xfUKkBCUMJiZEVonYqFIAN6z8oo6P8ceQXR1L
	 bB4RRCeIfwZUWqMAHK0VH9oqIpaUbKPA0aclWHPwvUGvS5M6//DEEy59+A24f7PRMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
	b=BgsC8BCwnHe8wUqgpDHYaXYds7taTjT8dsD+xsLPQ+4A59rTkmTbugJdKFeq/DqvrpYM
	 rd5zv1AXB71S86LFiKzt/v5Bys6wCZBq3zNikbBDa1D0NZfFWc2tgBOUEDo+Zs+kREYg3
	 BXvkNZqUunzPcSGRaZ240Yi2uDB41eBiNqlZEw+GQ09j8RdqbCkMlmIlT6W0gqYqIUxEC
	 ClRzc7EzzbGOOk3rQLu0zPysgU0NyiKGpwcdVo8u5Kp/84skZ86ijH8U/u7ty5grQSipC
	 13LBleWxhmQ9k2P3rnVsiJq5O46IJHK9chBCVoBhz9USXFRi77cHQ67z2d5TH+OOwrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C3/VARB9";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE79606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE79606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3/VARB9
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2761c69fbso6576515c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793696240; x=1794301040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
        b=C3/VARB9Ki3INhlpjHk6uw34w0eGjBtr09D2pcJRau33CqrUBKiWngGSjA+cADcyCU
         /g8gav+ogPg2gM2vm97bmSe4uN77DKvTC0++azS/JtNfZb+vtpWfj0h/t+IdQpZPISzr
         NneQuIO31ZBa+SLp4ZgJvw0C5xtqOPLQ54p4Ou72UBGbwCrYQvp3R/4tOL2rJ2zv8nbM
         IZKHxPw06svFbE8O/kXyNZ6LykNqU2tTGXtCSfmLFgis2lO2lczOoFf4/44wMV1Feq+M
         1fdaeGPTHxI+HWPS1QPadsE4If1L+Ij+cF0apDlUreUjUZuST4N33nOf2F/d6D2/4udQ
         69fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696240; x=1794301040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
        b=OQRx+Zf2BMZaITJk/8hJRME1LPQZWZ2PHPOhxeVE8vCLruP2nKUhQvbCZJ1a+arlaw
         9m2crkdOc4fOEhehW2a6feYmHPmo1R37KLoTcMWU1c6x2iOPCSBRABb8Al3kHIiCca1c
         POZL+Il8NRkACo6fteW7vOQDvmzawqHy3UeJ6w0w835WCXVmUTPfNtOm+5G3Rm87asvN
         sJrDiZ3E7nfqb2MQ6jFTvGHvStLVka9swnGPpKrjts1+7IIr5/AVV76Nwd1gIr0b5Cbh
         gssEZAOXRZEwibCU0zDoYYbV4Ty1yijb/fuMxHi7b5T0PauBageKqB3r8djF4G4CaYdm
         2IBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrImWkIk5u7Low7JfHY3ji9vaXi5ZP7oigdC8MNqL69uIgJXEDWhX96EOCaVikQ0ZABKMjUi4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lXpUTArNRG5ljLv0mS01zFkoow/CLT4ENATZCBWRXWirQn3U/
	sga8faO/1F5RcdJrcSk8fsF9J0kADpsGlg2MhDWkt5QEqmFAo0V31fh9
X-Gm-Gg: AYBFou1PNfN2vdkEJMaZDBLgfs6BDPhWJIrp/88eIfU2hMyvhD1AIXgY5j+ryoXAHqO
	pEDJ9BftIIwbc36lNmK5BqxTx7dU4EAPO5JPn+mT9R9m1bIN31mVWqfWj3ag4ILJv5fHflWmroJ
	G0aJ06xWw/IxcLYzZbYWuJ1V5UADzp8MzarQSCfcfztdon0Xg/q9lYZVzjY/RLADXCUMOfiK6pw
	h6fAi+8WRqeY3JRGTmEfrEWj/srFMJ1HjbzJA5wjVVSxVrEbrdNfD6hnCDDDz/TGbQjd7Zorrw1
	/F8qdlViB7gZoJo2eK1UOfuOG6qryz6AHJMofSOT9VCmQ5LaWfxQuh2IJjYY6hnqT6PvcuE/xum
	xIBt1pqZNlw5sb+7EKkvSSgH2vRuLI/tJDkWqh0zsE2Y5mts9Y7b7N1E3DlZAzKYlL/bX7d7aSy
	B2CFF8ewglpSem96t8pdQcfiuIS8hEkb6DJ29CoBz6xP6tkmPisxa66GL9xFGY4dDEgjddtYXHP
	31Kls2Pp3ZKjL288x8Zl58E+PpmHN6EPQMppBt01ShUGt6d3z2AvIxhgea/jzwHmsDBhni3udc8
	+J2SU8bWBf4mYDZIAR3o
X-Received: by 2002:a05:7022:1113:b0:1ac:9da7:e86e with SMTP id a92af1059eb24-1ac9dc67128mr17230382c88.30.1793696240266;
        Tue, 03 Nov 2026 00:57:20 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm39704029c88.23.2026.11.03.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:57:19 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: wait for SRCU readers before splicing the namespace list
Date: Tue,  3 Nov 2026 03:57:13 -0500
Message-ID: <20261103085713.3479756-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103081418.GB4301@lst.de>
References: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com> <20261103081418.GB4301@lst.de>
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

On Tue, Nov 03, 2026 at 09:14:18AM +0100, Christoph Hellwig wrote:
> This feels like a design issue with list_splice_init_rcu or rather
> using list_splice_init_rcu with SRCU.  Do we need to encapsulate
> and verify this logic in a list_splice_init_srcu so that other
> potential users won't get it wrong again?

Makes sense. nvme is the only caller that pairs it with SRCU today; the
others (btrfs, apparmor, ima, smack) protect their lists with plain RCU.

I'll add list_splice_init_srcu(), which takes the srcu_struct to wait
on, as a separate patch next to list_splice_init_rcu(), and switch nvme
to it in v2.

Thanks,
Qiliang
