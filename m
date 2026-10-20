Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461190;
	b=E3XzNNxEUCAoDrZvkRHRna+fYe1BHLhYa+VfrcxQRZSO2QtOCPCwZwFEQMNFtDKsnBD3
	 x5/zM/w0rjIgN2djmsh6W0+lnlHEK0qqP6mEKY86skQJzHiqHcqpgS3wGmf3Uq8Ogq0lP
	 Wq7EHJfj0C0sF3mecp10X2HL09bSfetdZoPuh8ZKNBN8T3QR20BhPT52u2KkV9vR2idUk
	 Xs/AWSeQJGiycIo8eEje8O6RXcEvIOjWPUETyPVyYlebttvah8OuWr0Y+sAXonRAPLFOm
	 bWL7rHwppV2zsD43ryYxYaHmi+UmceenQ0j9iteLMlIYb5O2yB9GIGbGmu70bg5ABDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Yn7QqCwXM8MPvwetBEr3NullDr5Aw8no0EzlhyW/Hc=;
	b=kcBbvKnBf07oPQrM7TCy6E9k1EYkOTstIz+MiKjxZsyZ8IB/DsCBj7Lq+j8041Au2Ol2
	 bqWcxV3Lo4jpDEGV4V9WAsQA/hOukeBqyMKj7Fx9LdZU+PEmQSq7mphVcaEiEZsbmAND5
	 QemTgNEGCgddGEZ78zUnn2qnqmBfJjMtGpdeUk/WY6LS9sSjICgfJ0Xj1KFUZI8FshUqe
	 LPbKnJR5Dvb0xqCenIuUy0kLsIGNgveIrHLe10T5NMT9iqc6G9KCjt/7dmfyCw1UjU1m3
	 5vHXqjXOiaCvKsk8WaKyKLJC9yu1qxBdKEUJ5C0tYntMBjocL4YCy4etina51Mj6EwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CF606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso920746b3a.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792461178; x=1793065978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Yn7QqCwXM8MPvwetBEr3NullDr5Aw8no0EzlhyW/Hc=;
        b=vumXSNSbI09RrtlcyVULpvJxp0EcPVGVRu33CuFCqb5NorLBDg2EPhJOoHYzUwuz+f
         LxFgMsXL4GijHKtAhN/BqDlE9Qi3p9hYGCIOnGKa88rE5jwPUubOQuBXKPgdeQvryF6z
         cTDvY0P/QacS26B23naXpIrswv4zBJYwfkVlFWmLaxxCSXRy1tdPB68EMsLumnwe4A+g
         G5/PQ9b/87L91T4g2NUgqRe1o38gpLZk5NtO0oQnzCrT9cPThXF1ofoiQPSgJwbByVEU
         RN9xqUVimW85F1iDXLYkovAABIPAD9/xGN42NYO9suCDT3daOKBldwleo0F3DxjtA2L9
         ggjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792461178; x=1793065978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Yn7QqCwXM8MPvwetBEr3NullDr5Aw8no0EzlhyW/Hc=;
        b=a4e8xND6LNNULuxiL+9U28zInE+pWDNzpvk+YNAAVnysGGQ4m+NsU+/hUhREdTdnIN
         HNkLRWuBQM7O2dz5EJjUMxi+c9ADr6xC+kdJsxWQ75kPWQw0CRYFpFKqokkFTD77jjrM
         ieTZTCPU/qtPmHRysEokPf4DH/p14Q+p8+1HXtd21hEjydToeWDbUW5JysnyYoGV6o0x
         xRhMP3+7rPAiNuKdAhvLSZLwOOvjv3ifGuCAyrFdUILIZ15oNhUzOZDuA6X/R9hmHrit
         OFqQY+ig3VuxiR87rpUCAYeiSqhsBx1wCZBbi9wUgBiKe19fSUa3OS7muQMP0ztoGU8H
         4cFw==
X-Forwarded-Encrypted: i=1; AKwUvBwC+ULwnUfZM7WZRwWyOQFb3pniEgYtU/Z69t1PZvXCmHyiEYJH1wEWAGOXi6Gm82T18CmXDGc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJITtguiDqrQJeUtHzXP9cfy834vB1od1bxu4ZEXxpaixushnNl
	9gyykq2141j7bCbSQYKkIBmWQPAw3Uup3GdeUBITQAVWeSyOB0E6sVEXHeCzypALrQ4=
X-Gm-Gg: AYBFou0uPprs1I00/cJnChvB1006D8jq3MzUgVsSH4XIqyOnwDGzZOhszg6VlCqi9l2
	pRoqvGciEOivSE5Xc1guucZTnQz2p5IEeWnPMm4H8783XCGzTuP4yWTL7//3iMHE3PO6D9YAVlk
	kd+SsdJFYie4xMojiP+/C5btzyC6r+xZY5GJhUNhQx1vsCejimdiA66hnnwGyFqxGu0tjxXZyaV
	IiW1phGn0vb0/2WyBUTg6YInK5NF2KNwQtqm6lM92dzNHbyvwjvG56kjCRgoDUCK0PsL7TID/s9
	gzSlCC0j0CvGG16V44cQ3fgCFoA6P6hO0Rv3Rxn8mcEc1f0KuxxRgR/wqeI5G5zDRTDQci7jRnl
	r2G4llITpKq9FuUEyiXeolJo7cbuonNseJrG5HlkmIuN9lDNzzGemSbc9ciXI+dMFPEEDpvDF0W
	Md+qUqzWR17DSWytaqkTdqOjuTGgjMY/xRheM6leEGbBtoeAIU8RXVPWV++eEooUcnuRFxm3xJx
	O0eMA==
X-Received: by 2002:a05:6a21:3947:b0:3e2:1418:aae2 with SMTP id adf61e73a8af0-3e22640bb6cmr7707121637.68.1792461178034;
        Mon, 19 Oct 2026 18:52:58 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a15c57sm4551644a12.25.2026.10.19.18.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:52:57 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Fan Gong <gongfan1@huawei.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Xin Guo <guoxin09@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Date: Tue, 20 Oct 2026 10:52:45 +0900
Message-ID: <20261020015245.1117139-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020011209.13736-1-gongfan1@huawei.com>
References: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr> <20261018170531.bILLh5Zw@linutronix.de> <20261019001037.3496843-1-yhlee@isslab.korea.ac.kr> <20261019221306.d6dfPY_y@linutronix.de> <20261020011209.13736-1-gongfan1@huawei.com>
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

Hi Fan,

Thank you, that is very helpful, and no, it is not urgent. I found this
by code inspection rather than in the field, so with the current driver
unable to reach it and a complete solution already on the way from your
side, there is nothing that needs chasing.

Please go ahead with your own approach for the larger packet sizes; I am
glad to drop this patch in favour of it. I appreciate you and Sebastian
taking the time to look into it.

Regards,
Yehyeong
